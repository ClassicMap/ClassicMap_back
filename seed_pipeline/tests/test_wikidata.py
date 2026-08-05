from datetime import UTC, datetime
from pathlib import Path

import httpx

from classicmap_seed.artifacts import JsonlArtifactStore
from classicmap_seed.http import JsonHttpClient, NoopRateLimiter, RetryPolicy
from classicmap_seed.models import (
    ArtifactStage,
    EntityKind,
    SourceMetadata,
    SourceName,
    SourceRecord,
    WikidataScope,
)
from classicmap_seed.sources.collector import collect_paginated
from classicmap_seed.sources.pagination import SourcePage, read_checkpoint
from classicmap_seed.sources.wikidata import WikidataConnector


def _binding(entity_id: str) -> dict[str, object]:
    return {"entity": {"value": f"http://www.wikidata.org/entity/{entity_id}"}}


def _statement(value: object) -> dict[str, object]:
    return {"mainsnak": {"snaktype": "value", "datavalue": {"value": value}}}


def _entity(entity_id: str) -> dict[str, object]:
    linked = {
        "Q36834": ("composer", "작곡가"),
        "Q5994": ("piano", "피아노"),
        "Q183": ("Germany", "독일"),
    }
    if entity_id in linked:
        en, ko = linked[entity_id]
        claims = {"P297": [_statement("DE")]} if entity_id == "Q183" else {}
        return {
            "id": entity_id,
            "labels": {"en": {"value": en}, "ko": {"value": ko}},
            "aliases": {},
            "claims": claims,
        }
    return {
        "id": entity_id,
        "labels": {
            "en": {"value": f"English {entity_id}"},
            "ko": {"value": f"한국어 {entity_id}"},
        },
        "aliases": {"en": [{"value": f"Alias {entity_id}"}]},
        "claims": {
            "P106": [_statement({"id": "Q36834"})],
            "P1303": [_statement({"id": "Q5994"})],
            "P27": [_statement({"id": "Q183"})],
            "P18": [_statement(f"{entity_id}.jpg")],
            "P434": [_statement(f"mbid-{entity_id}")],
            "P227": [_statement(f"gnd-{entity_id}")],
            "P214": [_statement(f"viaf-{entity_id}")],
            "P213": [_statement(f"isni-{entity_id}")],
            "P5504": [_statement(f"people/{entity_id.removeprefix('Q')}")],
        },
    }


def _connector(handler: httpx.MockTransport) -> tuple[WikidataConnector, httpx.Client]:
    underlying = httpx.Client(transport=handler)
    client = JsonHttpClient(
        user_agent="ClassicMapSeed/test",
        rate_limiter=NoopRateLimiter(),
        retry_policy=RetryPolicy(max_attempts=1),
        client=underlying,
    )
    return WikidataConnector(client), underlying


def test_wikidata_scope_page_uses_stable_cursor_and_collects_authority_facts() -> None:
    queries: list[str] = []

    def handler(request: httpx.Request) -> httpx.Response:
        if request.url.host == "query.wikidata.org":
            query = request.url.params["query"]
            queries.append(query)
            bindings = (
                [_binding("Q10"), _binding("Q11")] if "FILTER" not in query else [_binding("Q12")]
            )
            return httpx.Response(200, json={"results": {"bindings": bindings}}, request=request)
        ids = request.url.params["ids"].split("|")
        return httpx.Response(
            200,
            json={"entities": {entity_id: _entity(entity_id) for entity_id in ids}},
            request=request,
        )

    connector, underlying = _connector(httpx.MockTransport(handler))
    first = connector.fetch_page(scope=WikidataScope.COMPOSERS, page_size=2, cursor=None)
    second = connector.fetch_page(
        scope=WikidataScope.COMPOSERS,
        page_size=2,
        cursor=first.next_cursor,
    )

    assert first.next_cursor == "http://www.wikidata.org/entity/Q11"
    assert second.complete is True
    assert 'FILTER(STR(?entity) > "http://www.wikidata.org/entity/Q11")' in queries[1]
    record = first.records[0]
    assert record.payload["localized_names"] == [
        {"locale": "en", "name_kind": "canonical", "name": "English Q10"},
        {"locale": "en", "name_kind": "alias", "name": "Alias Q10"},
        {"locale": "ko", "name_kind": "canonical", "name": "한국어 Q10"},
    ]
    assert record.payload["role_codes"] == ["Q36834"]
    assert record.payload["instrument_codes"] == ["Q5994"]
    assert record.payload["country_codes"] == ["DE"]
    assert record.payload["country_code_links"] == [
        {"country_code": "DE", "country_entity_id": "Q183"}
    ]
    assert record.payload["external_identifiers"] == {
        "musicbrainz_artist": ["mbid-Q10"],
        "gnd": ["gnd-Q10"],
        "viaf": ["viaf-Q10"],
        "isni": ["isni-Q10"],
        "rism": ["people/10"],
    }
    underlying.close()


def test_wikidata_each_scope_uses_official_class_and_entity_kind() -> None:
    expected = {
        WikidataScope.COMPOSERS: ("wd:Q36834", EntityKind.PERSON),
        WikidataScope.PERFORMERS: ("wd:Q639669", EntityKind.PERSON),
        WikidataScope.ENSEMBLES: ("wd:Q2088357", EntityKind.ENSEMBLE),
    }
    for scope, (class_qid, entity_kind) in expected.items():
        seen_query = ""

        def handler(request: httpx.Request) -> httpx.Response:
            nonlocal seen_query
            if request.url.host == "query.wikidata.org":
                query = request.url.params["query"]
                seen_query = query
                bindings = [_binding("Q20")]
                return httpx.Response(
                    200,
                    json={"results": {"bindings": bindings}},
                    request=request,
                )
            ids = request.url.params["ids"].split("|")
            return httpx.Response(
                200,
                json={"entities": {entity_id: _entity(entity_id) for entity_id in ids}},
                request=request,
            )

        connector, underlying = _connector(httpx.MockTransport(handler))
        page = connector.fetch_page(scope=scope, page_size=2, cursor=None)
        assert class_qid in seen_query
        assert page.records[0].entity_kind is entity_kind
        underlying.close()


def test_paginated_collection_resumes_from_immutable_page_checkpoint(tmp_path: Path) -> None:
    metadata = SourceMetadata(
        source=SourceName.WIKIDATA,
        source_uri="https://query.wikidata.org/sparql",
        license="CC0-1.0",
        license_uri="https://www.wikidata.org/wiki/Wikidata:Licensing",
    )
    store = JsonlArtifactStore(tmp_path, tool_version="test")
    checkpoint_path = tmp_path / "run-1/checkpoints/wikidata-composers.json"

    def first_fetch(page_size: int, cursor: str | None) -> SourcePage:
        assert page_size == 2
        assert cursor is None
        return SourcePage(
            records=(_source_record("Q1"), _source_record("Q2")),
            next_cursor="http://www.wikidata.org/entity/Q2",
            complete=False,
        )

    first = collect_paginated(
        run_id="run-1",
        scope="composers",
        metadata=metadata,
        fetch_page=first_fetch,
        artifact_store=store,
        artifacts_root=tmp_path,
        checkpoint_path=checkpoint_path,
        retrieved_at=datetime(2026, 8, 5, tzinfo=UTC),
        limit=3,
        page_size=2,
        max_pages=1,
        dry_run=False,
        resume=True,
    )
    assert [record.source_record_id for record in first.records] == ["Q1", "Q2"]
    assert first.artifact_mutation_count == 2
    assert read_checkpoint(checkpoint_path).total_records == 2
    one_page_aggregate = store.write(
        run_id="run-1",
        stage=ArtifactStage.RAW,
        metadata=metadata,
        records=first.records,
        retrieved_at=datetime(2026, 8, 5, tzinfo=UTC),
        dry_run=False,
        resume=True,
    )
    assert one_page_aggregate.mutation_count == 0
    assert max(one_page_aggregate.mutation_count, first.artifact_mutation_count) == 2

    def resumed_fetch(page_size: int, cursor: str | None) -> SourcePage:
        assert page_size == 1
        assert cursor == "http://www.wikidata.org/entity/Q2"
        return SourcePage(records=(_source_record("Q3"),), next_cursor=None, complete=True)

    resumed = collect_paginated(
        run_id="run-1",
        scope="composers",
        metadata=metadata,
        fetch_page=resumed_fetch,
        artifact_store=store,
        artifacts_root=tmp_path,
        checkpoint_path=checkpoint_path,
        retrieved_at=datetime(2026, 8, 5, tzinfo=UTC),
        limit=3,
        page_size=2,
        max_pages=None,
        dry_run=False,
        resume=True,
    )
    assert resumed.resumed_record_count == 2
    assert resumed.request_count == 1
    assert resumed.artifact_mutation_count == 1
    assert [record.source_record_id for record in resumed.records] == ["Q1", "Q2", "Q3"]
    assert read_checkpoint(checkpoint_path).complete is True
    completed_aggregate = store.write(
        run_id="run-1",
        stage=ArtifactStage.RAW,
        metadata=metadata,
        records=resumed.records,
        retrieved_at=datetime(2026, 8, 5, tzinfo=UTC),
        dry_run=False,
        resume=True,
    )
    assert completed_aggregate.mutation_count == 3

    complete_resume = collect_paginated(
        run_id="run-1",
        scope="composers",
        metadata=metadata,
        fetch_page=lambda _size, _cursor: (_ for _ in ()).throw(
            AssertionError("complete checkpoint는 API를 다시 호출하면 안 됩니다.")
        ),
        artifact_store=store,
        artifacts_root=tmp_path,
        checkpoint_path=checkpoint_path,
        retrieved_at=datetime(2026, 8, 5, tzinfo=UTC),
        limit=3,
        page_size=2,
        max_pages=None,
        dry_run=False,
        resume=True,
    )
    assert complete_resume.request_count == 0
    assert complete_resume.artifact_mutation_count == 0
    second_aggregate = store.write(
        run_id="run-1",
        stage=ArtifactStage.RAW,
        metadata=metadata,
        records=complete_resume.records,
        retrieved_at=datetime(2026, 8, 6, tzinfo=UTC),
        dry_run=False,
        resume=True,
    )
    assert max(second_aggregate.mutation_count, complete_resume.artifact_mutation_count) == 0


def _source_record(entity_id: str) -> SourceRecord:
    return SourceRecord(
        source=SourceName.WIKIDATA,
        source_record_id=entity_id,
        entity_kind=EntityKind.PERSON,
        payload={"id": entity_id, "name": entity_id},
    )
