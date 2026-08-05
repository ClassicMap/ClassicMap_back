from datetime import UTC, datetime
from pathlib import Path

import httpx

from classicmap_seed.artifacts import JsonlArtifactStore, read_artifact
from classicmap_seed.export import build_canonical_load_bundle
from classicmap_seed.http import JsonHttpClient, NoopRateLimiter, RetryPolicy
from classicmap_seed.load import canonical_seed_run_id
from classicmap_seed.models import (
    ArtifactStage,
    CanonicalLoadRecord,
    ForeignKeyResolution,
    LoadForeignKey,
    LoadTable,
    SourceMetadata,
    SourceName,
)
from classicmap_seed.normalize import normalize_records
from classicmap_seed.resolve import resolve_candidates
from classicmap_seed.sources.wikidata import WikidataConnector
from classicmap_seed.sources.work_composer_dependencies import (
    WorkComposerDependencyConnector,
    WorkComposerDependencyReview,
    collect_work_composer_dependencies,
    read_work_composer_dependency_plan,
)

_MISSING_MBID = "1f9df192-a621-4f54-8850-2c5373b7eac9"
_EXISTING_MBID = "5f9df192-a621-4f54-8850-2c5373b7eac9"
_NOT_FOUND_MBID = "2f9df192-a621-4f54-8850-2c5373b7eac9"
_AMBIGUOUS_MBID = "3f9df192-a621-4f54-8850-2c5373b7eac9"
_MULTI_CLAIM_MBID = "4f9df192-a621-4f54-8850-2c5373b7eac9"


def test_missing_work_composer_closure_reaches_legacy_projection_and_resume_zero(
    tmp_path: Path,
) -> None:
    work_manifest, composer_manifest = _canonical_input_manifests(tmp_path)
    plan = read_work_composer_dependency_plan(work_manifest, [composer_manifest])

    assert plan.required_composer_keys == (
        f"musicbrainz_artist:{_MISSING_MBID}",
        f"musicbrainz_artist:{_EXISTING_MBID}",
    )
    assert plan.existing_composer_keys == (f"musicbrainz_artist:{_EXISTING_MBID}",)
    assert plan.missing_composer_mbids == (_MISSING_MBID,)

    wdqs_requests = 0

    def handler(request: httpx.Request) -> httpx.Response:
        nonlocal wdqs_requests
        if request.url.host == "query.wikidata.org":
            wdqs_requests += 1
            query = request.url.params["query"]
            assert f'VALUES ?mbid {{ "{_MISSING_MBID}" }}' in query
            assert "?entity wdt:P434 ?mbid ." in query
            assert "rdfs:label" not in query
            assert "P106" not in query
            return httpx.Response(
                200,
                json={
                    "results": {
                        "bindings": [_binding(_MISSING_MBID, "Q255")],
                    }
                },
                request=request,
            )
        ids = request.url.params["ids"].split("|")
        return httpx.Response(
            200,
            json={"entities": {entity_id: _entity(entity_id) for entity_id in ids}},
            request=request,
        )

    connector, underlying = _connector(httpx.MockTransport(handler))
    store = JsonlArtifactStore(tmp_path / "dependency-artifacts", tool_version="test")
    checkpoint_path = (
        tmp_path
        / "dependency-artifacts"
        / "dependency-run"
        / "checkpoints"
        / "work-composer-dependencies.json"
    )
    retrieved_at = datetime(2026, 8, 5, tzinfo=UTC)
    first = collect_work_composer_dependencies(
        run_id="dependency-run",
        plan=plan,
        connector=connector,
        artifact_store=store,
        artifacts_root=tmp_path / "dependency-artifacts",
        checkpoint_path=checkpoint_path,
        retrieved_at=retrieved_at,
        limit=10,
        batch_size=10,
        dry_run=False,
        resume=True,
    )
    assert first.request_count == 1
    assert first.resumed_composer_count == 0
    assert first.reviews == ()
    assert [record.source_record_id for record in first.records] == ["Q255"]

    raw_result = store.write(
        run_id="dependency-run",
        stage=ArtifactStage.RAW,
        metadata=connector.metadata,
        records=first.records,
        retrieved_at=retrieved_at,
        dry_run=False,
        resume=True,
    )
    candidates = normalize_records(list(first.records))
    decisions = resolve_candidates(candidates)
    canonical = build_canonical_load_bundle(
        run_id="dependency-run",
        source_manifest=raw_result.manifest,
        raw_records=list(first.records),
        candidates=candidates,
        decisions=decisions,
    )
    assert any(
        record.table is LoadTable.COMPOSERS
        and record.natural_key == f"musicbrainz_artist:{_MISSING_MBID}"
        for record in canonical
    )
    assert not any(
        record.table is LoadTable.REVIEW_QUEUE
        and record.values.get("target_type") == "legacy_composer"
        for record in canonical
    )

    resumed = collect_work_composer_dependencies(
        run_id="dependency-run",
        plan=plan,
        connector=connector,
        artifact_store=store,
        artifacts_root=tmp_path / "dependency-artifacts",
        checkpoint_path=checkpoint_path,
        retrieved_at=retrieved_at,
        limit=10,
        batch_size=10,
        dry_run=False,
        resume=True,
    )
    second_raw = store.write(
        run_id="dependency-run",
        stage=ArtifactStage.RAW,
        metadata=connector.metadata,
        records=resumed.records,
        retrieved_at=datetime(2026, 8, 6, tzinfo=UTC),
        dry_run=False,
        resume=True,
    )
    assert resumed.resumed_composer_count == 1
    assert resumed.request_count == 0
    assert resumed.artifact_mutation_count == 0
    assert second_raw.mutation_count == 0
    assert wdqs_requests == 1
    underlying.close()


def test_zero_multiple_qid_and_multi_mbid_claims_are_review_artifacts(tmp_path: Path) -> None:
    def handler(request: httpx.Request) -> httpx.Response:
        if request.url.host == "query.wikidata.org":
            return httpx.Response(
                200,
                json={
                    "results": {
                        "bindings": [
                            _binding(_AMBIGUOUS_MBID, "Q300"),
                            _binding(_AMBIGUOUS_MBID, "Q301"),
                            _binding(_MULTI_CLAIM_MBID, "Q400"),
                        ]
                    }
                },
                request=request,
            )
        ids = request.url.params["ids"].split("|")
        return httpx.Response(
            200,
            json={
                "entities": {
                    entity_id: _entity(
                        entity_id,
                        mbids=((_MULTI_CLAIM_MBID, _MISSING_MBID) if entity_id == "Q400" else None),
                    )
                    for entity_id in ids
                }
            },
            request=request,
        )

    connector, underlying = _connector(httpx.MockTransport(handler))
    results = connector.fetch_batch([_NOT_FOUND_MBID, _AMBIGUOUS_MBID, _MULTI_CLAIM_MBID])
    reviews = [result.review for result in results]
    assert [review.reason_code for review in reviews if review is not None] == [
        "WORK_COMPOSER_MBID_WIKIDATA_NOT_FOUND",
        "WORK_COMPOSER_MBID_WIKIDATA_AMBIGUOUS",
        "WORK_COMPOSER_QID_MULTIPLE_MBIDS",
    ]
    typed_reviews = [review for review in reviews if review is not None]
    result = JsonlArtifactStore(tmp_path, tool_version="test").write(
        run_id="review-run",
        stage=ArtifactStage.RAW,
        metadata=connector.metadata,
        records=typed_reviews,
        retrieved_at=datetime(2026, 8, 5, tzinfo=UTC),
        dry_run=False,
        resume=True,
    )
    _, restored = read_artifact(result.manifest_path, WorkComposerDependencyReview)
    assert restored == typed_reviews
    resumed = JsonlArtifactStore(tmp_path, tool_version="test").write(
        run_id="review-run",
        stage=ArtifactStage.RAW,
        metadata=connector.metadata,
        records=typed_reviews,
        retrieved_at=datetime(2026, 8, 6, tzinfo=UTC),
        dry_run=False,
        resume=True,
    )
    assert resumed.mutation_count == 0
    underlying.close()


def test_dependency_dry_run_writes_no_artifact_or_checkpoint(tmp_path: Path) -> None:
    work_manifest, composer_manifest = _canonical_input_manifests(tmp_path / "inputs")
    plan = read_work_composer_dependency_plan(work_manifest, [composer_manifest])

    def handler(request: httpx.Request) -> httpx.Response:
        if request.url.host == "query.wikidata.org":
            return httpx.Response(
                200,
                json={"results": {"bindings": [_binding(_MISSING_MBID, "Q255")]}},
                request=request,
            )
        ids = request.url.params["ids"].split("|")
        return httpx.Response(
            200,
            json={"entities": {entity_id: _entity(entity_id) for entity_id in ids}},
            request=request,
        )

    connector, underlying = _connector(httpx.MockTransport(handler))
    artifact_root = tmp_path / "dry-artifacts"
    store = JsonlArtifactStore(artifact_root, tool_version="test")
    checkpoint_path = artifact_root / "dry-run/checkpoints/work-composer-dependencies.json"
    collection = collect_work_composer_dependencies(
        run_id="dry-run",
        plan=plan,
        connector=connector,
        artifact_store=store,
        artifacts_root=artifact_root,
        checkpoint_path=checkpoint_path,
        retrieved_at=datetime(2026, 8, 5, tzinfo=UTC),
        limit=1,
        batch_size=1,
        dry_run=True,
        resume=True,
    )
    aggregate = store.write(
        run_id="dry-run",
        stage=ArtifactStage.RAW,
        metadata=connector.metadata,
        records=collection.records,
        retrieved_at=datetime(2026, 8, 5, tzinfo=UTC),
        dry_run=True,
        resume=True,
    )
    assert collection.request_count == 1
    assert aggregate.mutation_count == 1
    assert not artifact_root.exists()
    assert not checkpoint_path.exists()
    underlying.close()


def _canonical_input_manifests(root: Path) -> tuple[Path, Path]:
    store = JsonlArtifactStore(root, tool_version="test")
    metadata = SourceMetadata(
        source=SourceName.MUSICBRAINZ_WORKS,
        source_uri="https://musicbrainz.org/ws/2/work",
        license="MusicBrainz core data: CC0-1.0",
        license_uri="https://musicbrainz.org/doc/About/Data_License",
    )
    work_seed_run_id = canonical_seed_run_id("work-input")
    work_records = [
        _piece_record(work_seed_run_id, "work:1", _MISSING_MBID),
        _piece_record(work_seed_run_id, "work:2", _EXISTING_MBID),
        _piece_record(work_seed_run_id, "work:3", _MISSING_MBID),
    ]
    work_result = store.write(
        run_id="work-input",
        stage=ArtifactStage.CANONICAL,
        metadata=metadata,
        records=work_records,
        retrieved_at=datetime(2026, 8, 5, tzinfo=UTC),
        dry_run=False,
        resume=True,
    )
    composer_result = store.write(
        run_id="composer-input",
        stage=ArtifactStage.CANONICAL,
        metadata=SourceMetadata(
            source=SourceName.WIKIDATA,
            source_uri="https://query.wikidata.org/sparql",
            license="CC0-1.0",
            license_uri="https://www.wikidata.org/wiki/Wikidata:Licensing",
        ),
        records=[
            CanonicalLoadRecord(
                seed_run_id=canonical_seed_run_id("composer-input"),
                table=LoadTable.COMPOSERS,
                natural_key=f"musicbrainz_artist:{_EXISTING_MBID}",
                values={"name": "기존 작곡가"},
            ),
            CanonicalLoadRecord(
                seed_run_id=canonical_seed_run_id("composer-input"),
                table=LoadTable.COMPOSERS,
                natural_key="manual:legacy-composer",
                values={"name": "수동 작곡가"},
            ),
        ],
        retrieved_at=datetime(2026, 8, 5, tzinfo=UTC),
        dry_run=False,
        resume=True,
    )
    return work_result.manifest_path, composer_result.manifest_path


def _piece_record(seed_run_id: str, natural_key: str, composer_mbid: str) -> CanonicalLoadRecord:
    return CanonicalLoadRecord(
        seed_run_id=seed_run_id,
        table=LoadTable.PIECES,
        natural_key=natural_key,
        values={"title": natural_key},
        foreign_keys=(
            LoadForeignKey(
                column="composer_id",
                target_table=LoadTable.COMPOSERS,
                target_natural_key=f"musicbrainz_artist:{composer_mbid}",
                resolution=ForeignKeyResolution.BUNDLE_OR_EXISTING,
            ),
        ),
    )


def _connector(
    handler: httpx.MockTransport,
) -> tuple[WorkComposerDependencyConnector, httpx.Client]:
    underlying = httpx.Client(transport=handler)
    http_client = JsonHttpClient(
        user_agent="ClassicMapSeed/test",
        rate_limiter=NoopRateLimiter(),
        retry_policy=RetryPolicy(max_attempts=1),
        client=underlying,
    )
    wikidata = WikidataConnector(http_client)
    return WorkComposerDependencyConnector(http_client, wikidata), underlying


def _binding(mbid: str, entity_id: str) -> dict[str, object]:
    return {
        "mbid": {"value": mbid},
        "entity": {"value": f"http://www.wikidata.org/entity/{entity_id}"},
    }


def _statement(value: object) -> dict[str, object]:
    return {"mainsnak": {"snaktype": "value", "datavalue": {"value": value}}}


def _entity(
    entity_id: str,
    *,
    mbids: tuple[str, ...] | None = None,
) -> dict[str, object]:
    if entity_id == "Q36834":
        return {
            "id": entity_id,
            "labels": {"en": {"value": "composer"}, "ko": {"value": "작곡가"}},
            "aliases": {},
            "claims": {},
        }
    if entity_id == "Q183":
        return {
            "id": entity_id,
            "labels": {"en": {"value": "Germany"}, "ko": {"value": "독일"}},
            "aliases": {},
            "claims": {"P297": [_statement("DE")]},
        }
    musicbrainz_ids = mbids or (_MISSING_MBID,)
    return {
        "id": entity_id,
        "labels": {
            "en": {"value": "Ludwig van Beethoven"},
            "ko": {"value": "루트비히 판 베토벤"},
        },
        "aliases": {"en": [{"value": "Beethoven"}]},
        "claims": {
            "P106": [_statement({"id": "Q36834"})],
            "P27": [_statement({"id": "Q183"})],
            "P434": [_statement(mbid) for mbid in musicbrainz_ids],
            "P569": [_statement({"time": "+1770-12-17T00:00:00Z"})],
            "P570": [_statement({"time": "+1827-03-26T00:00:00Z"})],
        },
    }
