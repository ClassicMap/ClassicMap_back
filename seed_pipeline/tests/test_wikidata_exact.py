from datetime import UTC, datetime
from pathlib import Path

import httpx
import pytest

from classicmap_seed.artifacts import JsonlArtifactStore, read_artifact
from classicmap_seed.export import build_canonical_load_bundle
from classicmap_seed.http import JsonHttpClient, NoopRateLimiter, RetryPolicy
from classicmap_seed.models import (
    ArtifactStage,
    CanonicalLoadRecord,
    LoadTable,
    NormalizedEntityCandidate,
    ResolutionDecision,
    SourceRecord,
    WikidataScope,
)
from classicmap_seed.normalize import normalize_records
from classicmap_seed.resolve import resolve_candidates
from classicmap_seed.sources.collector import collect_paginated
from classicmap_seed.sources.wikidata import WikidataConnector
from classicmap_seed.sources.wikidata_exact import fetch_exact_request_page
from classicmap_seed.sources.wikidata_exact_input import (
    WikidataEntityRequest,
    extract_comparison_candidate_requests,
    read_wikidata_entity_requests,
)


def _statement(value: object) -> dict[str, object]:
    return {"mainsnak": {"snaktype": "value", "datavalue": {"value": value}}}


def _entity(entity_id: str) -> dict[str, object]:
    linked = {
        "Q36834": ("composer", "작곡가"),
        "Q486748": ("pianist", "피아니스트"),
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
    role_id = "Q36834" if entity_id == "Q10" else "Q486748"
    return {
        "id": entity_id,
        "labels": {
            "en": {"value": f"English {entity_id}"},
            "ko": {"value": f"한국어 {entity_id}"},
        },
        "aliases": {"en": [{"value": f"Alias {entity_id}"}]},
        "claims": {
            "P106": [_statement({"id": role_id})],
            "P1303": [_statement({"id": "Q5994"})],
            "P27": [_statement({"id": "Q183"})],
            "P434": [_statement(f"00000000-0000-4000-8000-{int(entity_id[1:]):012d}")],
            "P569": [_statement({"time": "+1980-01-01T00:00:00Z"})],
        },
    }


def _connector(
    requested_batches: list[tuple[str, ...]],
    *,
    valid_scope_pairs: set[tuple[str, str]] | None = None,
) -> tuple[WikidataConnector, httpx.Client]:
    accepted = (
        {("Q10", "composers"), ("Q20", "performers")}
        if valid_scope_pairs is None
        else valid_scope_pairs
    )

    def handler(request: httpx.Request) -> httpx.Response:
        if request.url.path == "/sparql":
            query = request.url.params["query"]
            bindings = [
                {
                    "entity": {
                        "type": "uri",
                        "value": f"http://www.wikidata.org/entity/{qid}",
                    },
                    "scope": {"type": "literal", "value": scope},
                }
                for qid, scope in sorted(accepted)
                if f"wd:{qid}" in query and f'BIND("{scope}" AS ?scope)' in query
            ]
            return httpx.Response(
                200,
                json={"results": {"bindings": bindings}},
                request=request,
            )
        assert request.url.path == "/w/api.php"
        ids = tuple(request.url.params["ids"].split("|"))
        requested_batches.append(ids)
        return httpx.Response(
            200,
            json={"entities": {entity_id: _entity(entity_id) for entity_id in ids}},
            request=request,
        )

    underlying = httpx.Client(transport=httpx.MockTransport(handler))
    client = JsonHttpClient(
        user_agent="ClassicMapSeed/test",
        rate_limiter=NoopRateLimiter(),
        retry_policy=RetryPolicy(max_attempts=1),
        client=underlying,
    )
    return WikidataConnector(client), underlying


def _pilot_dir() -> Path:
    return Path(__file__).parents[1] / "curation" / "pilot-2026-08-05"


def test_committed_manifest_is_exact_deterministic_pilot_dependency() -> None:
    pilot_dir = _pilot_dir()
    extracted = extract_comparison_candidate_requests(pilot_dir / "candidates.jsonl")
    committed = read_wikidata_entity_requests(pilot_dir / "wikidata-entities.jsonl")

    assert committed == extracted
    assert len(committed) == 17
    assert len({request.qid for request in committed}) == 17
    assert sum(request.scope is WikidataScope.COMPOSERS for request in committed) == 4
    assert sum(request.scope is WikidataScope.PERFORMERS for request in committed) == 13
    composer_only = read_wikidata_entity_requests(pilot_dir / "wikidata-composers.jsonl")
    assert composer_only == tuple(
        request for request in extracted if request.scope is WikidataScope.COMPOSERS
    )


@pytest.mark.parametrize(
    "contents, message",
    [
        ('{"qid":"Q10","scope":"performers","name":"forbidden"}\n', "extra_forbidden"),
        ('{"qid":"Q0","scope":"performers"}\n', "정규 Wikidata QID"),
        (
            '{"qid":"Q10","scope":"performers"}\n{"qid":"Q10","scope":"performers"}\n',
            "중복 QID",
        ),
        ('{"qid":"Q10","scope":"unknown"}\n', "Input should be"),
    ],
)
def test_exact_input_rejects_unknown_name_bad_qid_duplicate_and_scope(
    tmp_path: Path,
    contents: str,
    message: str,
) -> None:
    path = tmp_path / "invalid.jsonl"
    path.write_text(contents, encoding="utf-8")
    with pytest.raises(ValueError, match=message):
        read_wikidata_entity_requests(path)


def test_exact_connector_uses_main_batch_and_linked_enrichment() -> None:
    batches: list[tuple[str, ...]] = []
    connector, underlying = _connector(batches)
    requests = (
        WikidataEntityRequest(qid="Q10", scope=WikidataScope.COMPOSERS),
        WikidataEntityRequest(qid="Q20", scope=WikidataScope.PERFORMERS),
    )

    page = fetch_exact_request_page(connector, requests, page_size=50, cursor=None)

    assert page.complete is True
    assert page.next_cursor is None
    assert [record.source_record_id for record in page.records] == ["Q10", "Q20"]
    assert page.records[0].payload["scope"] == "composers"
    assert page.records[1].payload["scope"] == "performers"
    assert page.records[1].payload["instrument_labels"] == [
        {"code": "Q5994", "locale": "en", "name": "piano"},
        {"code": "Q5994", "locale": "ko", "name": "피아노"},
    ]
    assert page.records[0].payload["scope_validation"] == {
        "validated": True,
        "method": "wdqs-values",
        "source_uri": "https://query.wikidata.org/sparql",
        "scope": "composers",
        "predicate_path": "P106/P279*",
        "target_qid": "Q36834",
    }
    assert batches[0] == ("Q10", "Q20")
    assert set(batches[1]) == {"Q183", "Q36834", "Q486748", "Q5994"}
    underlying.close()


def test_exact_connector_rejects_scope_not_proven_by_wdqs() -> None:
    batches: list[tuple[str, ...]] = []
    connector, underlying = _connector(batches, valid_scope_pairs=set())

    with pytest.raises(ValueError, match="scope predicate"):
        connector.fetch_exact((WikidataEntityRequest(qid="Q10", scope=WikidataScope.COMPOSERS),))

    assert batches == []
    underlying.close()


def test_exact_raw_resume_and_standard_pipeline_are_idempotent(tmp_path: Path) -> None:
    batches: list[tuple[str, ...]] = []
    connector, underlying = _connector(batches)
    requests = (
        WikidataEntityRequest(qid="Q10", scope=WikidataScope.COMPOSERS),
        WikidataEntityRequest(qid="Q20", scope=WikidataScope.PERFORMERS),
    )
    run_id = "exact-fixture"
    retrieved_at = datetime(2026, 8, 5, tzinfo=UTC)
    store = JsonlArtifactStore(tmp_path, tool_version="test")
    checkpoint_path = tmp_path / run_id / "checkpoints" / "wikidata-entities-fixture.json"

    first = collect_paginated(
        run_id=run_id,
        scope="exact:fixture",
        metadata=connector.entity_metadata,
        fetch_page=lambda size, cursor: fetch_exact_request_page(
            connector,
            requests,
            page_size=size,
            cursor=cursor,
        ),
        artifact_store=store,
        artifacts_root=tmp_path,
        checkpoint_path=checkpoint_path,
        retrieved_at=retrieved_at,
        limit=2,
        page_size=50,
        max_pages=None,
        dry_run=False,
        resume=True,
    )
    raw_result = store.write(
        run_id=run_id,
        stage=ArtifactStage.RAW,
        metadata=connector.entity_metadata,
        records=first.records,
        retrieved_at=retrieved_at,
        dry_run=False,
        resume=True,
    )
    batch_count_after_first = len(batches)
    resumed = collect_paginated(
        run_id=run_id,
        scope="exact:fixture",
        metadata=connector.entity_metadata,
        fetch_page=lambda size, cursor: fetch_exact_request_page(
            connector,
            requests,
            page_size=size,
            cursor=cursor,
        ),
        artifact_store=store,
        artifacts_root=tmp_path,
        checkpoint_path=checkpoint_path,
        retrieved_at=retrieved_at,
        limit=2,
        page_size=50,
        max_pages=None,
        dry_run=False,
        resume=True,
    )
    second_raw = store.write(
        run_id=run_id,
        stage=ArtifactStage.RAW,
        metadata=connector.entity_metadata,
        records=resumed.records,
        retrieved_at=retrieved_at,
        dry_run=True,
        resume=True,
    )
    assert resumed.request_count == 0
    assert resumed.artifact_mutation_count == 0
    assert len(batches) == batch_count_after_first
    assert second_raw.mutation_count == 0

    normalized = normalize_records(list(first.records))
    normalized_result = store.write(
        run_id=run_id,
        stage=ArtifactStage.NORMALIZED,
        metadata=connector.entity_metadata,
        records=normalized,
        retrieved_at=retrieved_at,
        dry_run=False,
        resume=True,
        parent_sha256=raw_result.manifest.sha256,
    )
    decisions = resolve_candidates(normalized)
    resolved_result = store.write(
        run_id=run_id,
        stage=ArtifactStage.RESOLVED,
        metadata=connector.entity_metadata,
        records=decisions,
        retrieved_at=retrieved_at,
        dry_run=False,
        resume=True,
        parent_sha256=normalized_result.manifest.sha256,
    )
    canonical = build_canonical_load_bundle(
        run_id=run_id,
        source_manifest=raw_result.manifest,
        raw_records=list(first.records),
        candidates=normalized,
        decisions=decisions,
    )
    canonical_result = store.write(
        run_id=run_id,
        stage=ArtifactStage.CANONICAL,
        metadata=connector.entity_metadata,
        records=canonical,
        retrieved_at=retrieved_at,
        dry_run=False,
        resume=True,
        parent_sha256=resolved_result.manifest.sha256,
    )
    second_canonical = store.write(
        run_id=run_id,
        stage=ArtifactStage.CANONICAL,
        metadata=connector.entity_metadata,
        records=canonical,
        retrieved_at=retrieved_at,
        dry_run=True,
        resume=True,
        parent_sha256=resolved_result.manifest.sha256,
    )

    assert len(normalized) == len(decisions) == 2
    assert any(record.table is LoadTable.AUTHORITY_ENTITIES for record in canonical)
    assert any(
        record.table is LoadTable.EXTERNAL_IDENTIFIERS
        and record.values.get("namespace") == "wikidata"
        for record in canonical
    )
    assert second_canonical.mutation_count == 0
    assert second_canonical.manifest.sha256 == canonical_result.manifest.sha256
    _, normalized_roundtrip = read_artifact(
        normalized_result.manifest_path,
        NormalizedEntityCandidate,
    )
    _, resolved_roundtrip = read_artifact(
        resolved_result.manifest_path,
        ResolutionDecision,
    )
    _, canonical_roundtrip = read_artifact(
        canonical_result.manifest_path,
        CanonicalLoadRecord,
    )
    assert normalized_roundtrip == normalized
    assert resolved_roundtrip == decisions
    assert canonical_roundtrip == canonical
    _, raw_roundtrip = read_artifact(raw_result.manifest_path, SourceRecord)
    assert raw_roundtrip == list(first.records)
    underlying.close()
