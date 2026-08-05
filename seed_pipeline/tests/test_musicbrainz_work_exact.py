from datetime import UTC, datetime
from pathlib import Path

import httpx
import pytest
from typer.testing import CliRunner

from classicmap_seed.artifacts import JsonlArtifactStore, read_artifact
from classicmap_seed.cli import app
from classicmap_seed.export import build_canonical_load_bundle
from classicmap_seed.http import JsonHttpClient, NoopRateLimiter, RetryPolicy
from classicmap_seed.models import (
    ArtifactStage,
    CanonicalLoadRecord,
    LoadTable,
    NormalizedEntityCandidate,
    ResolutionDecision,
    SourceRecord,
)
from classicmap_seed.normalize import normalize_records
from classicmap_seed.resolve import resolve_candidates
from classicmap_seed.sources.collector import PaginatedCollectionResult, collect_paginated
from classicmap_seed.sources.musicbrainz_work_exact import (
    ExactWorkHierarchyCollectionResult,
    collect_exact_work_hierarchy,
    fetch_exact_work_request_page,
)
from classicmap_seed.sources.musicbrainz_work_exact_input import (
    MusicBrainzWorkEntityRequest,
    extract_comparison_candidate_work_requests,
    read_musicbrainz_work_entity_requests,
)
from classicmap_seed.sources.musicbrainz_works import MusicBrainzWorkConnector

_WORK_A = "0a957e8a-0b86-30c5-bfa9-ad095ee43be8"
_WORK_B = "6ee8d38d-70fb-3442-af41-5669434c494f"
_OTHER_WORK = "7a8d4ff2-f178-39c5-b03b-4050606e11ef"
_COMPOSER_MBID = "1f9df192-a621-4f54-8850-2c5373b7eac9"


def _connector(handler: httpx.MockTransport) -> tuple[MusicBrainzWorkConnector, httpx.Client]:
    underlying = httpx.Client(transport=handler)
    client = JsonHttpClient(
        user_agent="ClassicMapSeed/test",
        rate_limiter=NoopRateLimiter(),
        retry_policy=RetryPolicy(max_attempts=1),
        client=underlying,
    )
    return MusicBrainzWorkConnector(client), underlying


def _pilot_dir() -> Path:
    return Path(__file__).parents[1] / "curation" / "pilot-2026-08-05"


def _work(work_mbid: str) -> dict[str, object]:
    return {
        "id": work_mbid,
        "title": f"Fixture Work {work_mbid[:8]}",
        "type": "Étude",
        "languages": ["zxx"],
        "iswcs": [f"T-{work_mbid[:3].upper()}.000.001-0"],
        "aliases": [{"name": f"Alias {work_mbid[:8]}", "locale": "en"}],
        "attributes": [{"type": "Work catalogue", "value": "Op. 1"}],
        "relations": [
            {
                "type": "composer",
                "direction": "backward",
                "target-type": "artist",
                "artist": {"id": _COMPOSER_MBID, "name": "Fixture Composer"},
            }
        ],
    }


def _work_with_parent(work_mbid: str, parent_mbid: str) -> dict[str, object]:
    work = _work(work_mbid)
    relations = work["relations"]
    assert isinstance(relations, list)
    relations.append(
        {
            "type": "parts",
            "direction": "backward",
            "target-type": "work",
            "work": {"id": parent_mbid, "title": "Fixture Parent"},
            "ordering-key": 1,
        }
    )
    return work


def test_committed_manifest_is_exact_deterministic_pilot_work_dependency() -> None:
    pilot_dir = _pilot_dir()
    extracted = extract_comparison_candidate_work_requests(pilot_dir / "candidates.jsonl")
    committed = read_musicbrainz_work_entity_requests(pilot_dir / "musicbrainz-works.jsonl")

    assert committed == extracted
    assert len(committed) == 5
    assert len({request.mbid for request in committed}) == 5
    assert tuple(request.mbid for request in committed) == tuple(
        sorted(request.mbid for request in committed)
    )


@pytest.mark.parametrize(
    "contents, message",
    [
        (f'{{"mbid":"{_WORK_A}","name":"forbidden"}}\n', "extra_forbidden"),
        ('{"mbid":"not-a-uuid"}\n', "canonical UUID"),
        (f'{{"mbid":"{_WORK_A.upper()}"}}\n', "canonical UUID"),
        (f'{{"mbid":"{_WORK_A}"}}\n{{"mbid":"{_WORK_A}"}}\n', "중복 work MBID"),
    ],
)
def test_exact_input_rejects_unknown_bad_noncanonical_and_duplicate(
    tmp_path: Path,
    contents: str,
    message: str,
) -> None:
    path = tmp_path / "invalid.jsonl"
    path.write_text(contents, encoding="utf-8")

    with pytest.raises(ValueError, match=message):
        read_musicbrainz_work_entity_requests(path)


def test_candidate_extraction_rejects_natural_key_identifier_mismatch(tmp_path: Path) -> None:
    path = tmp_path / "candidate.jsonl"
    path.write_text(
        "{"
        f'"workCandidate":{{"naturalKey":"musicbrainz-work:{_WORK_A}",'
        f'"externalIdentifiers":[{{"namespace":"musicbrainz_work","value":"{_WORK_B}"}}]}}'
        "}\n",
        encoding="utf-8",
    )

    with pytest.raises(ValueError, match="naturalKey와 같은"):
        extract_comparison_candidate_work_requests(path)


def test_exact_connector_uses_single_work_endpoint_and_preserves_contract() -> None:
    requests: list[httpx.Request] = []

    def handler(request: httpx.Request) -> httpx.Response:
        requests.append(request)
        return httpx.Response(200, json=_work(_WORK_A), request=request)

    connector, underlying = _connector(httpx.MockTransport(handler))
    record = connector.fetch_exact(work_mbid=_WORK_A)

    assert len(requests) == 1
    assert requests[0].url.path == f"/ws/2/work/{_WORK_A}"
    assert dict(requests[0].url.params) == {
        "fmt": "json",
        "inc": "aliases+artist-rels+work-rels",
    }
    assert record.source_record_id == _WORK_A
    assert record.payload["composer_mbids"] == [_COMPOSER_MBID]
    assert record.payload["browsed_artist_ids"] == []
    underlying.close()


def test_exact_connector_rejects_returned_id_mismatch() -> None:
    def handler(request: httpx.Request) -> httpx.Response:
        return httpx.Response(200, json=_work(_OTHER_WORK), request=request)

    connector, underlying = _connector(httpx.MockTransport(handler))

    with pytest.raises(ValueError, match="응답 ID가 요청 MBID와 일치하지 않습니다"):
        connector.fetch_exact(work_mbid=_WORK_A)
    underlying.close()


def test_exact_hierarchy_collects_only_parts_parents_and_resumes(tmp_path: Path) -> None:
    requested_mbids: list[str] = []

    def handler(request: httpx.Request) -> httpx.Response:
        work_mbid = request.url.path.rsplit("/", maxsplit=1)[-1]
        requested_mbids.append(work_mbid)
        payload = (
            _work_with_parent(work_mbid, _WORK_B) if work_mbid == _WORK_A else _work(work_mbid)
        )
        return httpx.Response(200, json=payload, request=request)

    connector, underlying = _connector(httpx.MockTransport(handler))
    run_id = "exact-work-hierarchy-fixture"
    retrieved_at = datetime(2026, 8, 5, tzinfo=UTC)
    store = JsonlArtifactStore(tmp_path, tool_version="test")
    checkpoint_path = tmp_path / run_id / "checkpoints" / "hierarchy.json"

    def collect() -> ExactWorkHierarchyCollectionResult:
        return collect_exact_work_hierarchy(
            connector=connector,
            requests=(MusicBrainzWorkEntityRequest(mbid=_WORK_A),),
            input_sha256="a" * 64,
            run_id=run_id,
            metadata=connector.metadata,
            artifact_store=store,
            artifacts_root=tmp_path,
            checkpoint_path=checkpoint_path,
            retrieved_at=retrieved_at,
            root_limit=1,
            max_depth=4,
            max_records=10,
            dry_run=False,
            resume=True,
        )

    first = collect()
    resumed = collect()
    raw_result = store.write(
        run_id=run_id,
        stage=ArtifactStage.RAW,
        metadata=connector.metadata,
        records=first.records,
        retrieved_at=retrieved_at,
        dry_run=False,
        resume=True,
    )
    normalized = normalize_records(list(first.records))
    decisions = resolve_candidates(normalized)
    canonical = build_canonical_load_bundle(
        run_id=run_id,
        source_manifest=raw_result.manifest,
        raw_records=list(first.records),
        candidates=normalized,
        decisions=decisions,
    )

    assert requested_mbids == [_WORK_A, _WORK_B]
    assert first.request_count == 2
    assert resumed.request_count == 0
    assert resumed.resumed_record_count == 2
    assert resumed.artifact_mutation_count == 0
    assert {record.source_record_id for record in first.records} == {_WORK_A, _WORK_B}
    assert first.records[0].payload["exact_hierarchy"] == {
        "root_mbid": _WORK_A,
        "depth": 0,
        "relation_type": "root",
    }
    assert {record.natural_key for record in canonical if record.table is LoadTable.PIECES} == {
        f"musicbrainz_work:{_WORK_B}",
    }
    assert {
        record.natural_key for record in canonical if record.table is LoadTable.PIECE_PARTS
    } == {f"musicbrainz_work_part:{_WORK_A}"}
    assert not any(record.table is LoadTable.REVIEW_QUEUE for record in canonical)
    underlying.close()


def test_exact_hierarchy_rejects_parent_beyond_depth_without_fetching_it(tmp_path: Path) -> None:
    requested_mbids: list[str] = []

    def handler(request: httpx.Request) -> httpx.Response:
        work_mbid = request.url.path.rsplit("/", maxsplit=1)[-1]
        requested_mbids.append(work_mbid)
        return httpx.Response(
            200,
            json=_work_with_parent(work_mbid, _WORK_B),
            request=request,
        )

    connector, underlying = _connector(httpx.MockTransport(handler))
    with pytest.raises(ValueError, match="max-hierarchy-depth"):
        collect_exact_work_hierarchy(
            connector=connector,
            requests=(MusicBrainzWorkEntityRequest(mbid=_WORK_A),),
            input_sha256="b" * 64,
            run_id="depth-limit",
            metadata=connector.metadata,
            artifact_store=JsonlArtifactStore(tmp_path, tool_version="test"),
            artifacts_root=tmp_path,
            checkpoint_path=tmp_path / "depth-limit" / "checkpoints" / "hierarchy.json",
            retrieved_at=datetime(2026, 8, 5, tzinfo=UTC),
            root_limit=1,
            max_depth=0,
            max_records=10,
            dry_run=True,
            resume=True,
        )

    assert requested_mbids == [_WORK_A]
    underlying.close()


def test_exact_raw_resume_and_standard_pipeline_are_idempotent(tmp_path: Path) -> None:
    requested_mbids: list[str] = []

    def handler(request: httpx.Request) -> httpx.Response:
        work_mbid = request.url.path.rsplit("/", maxsplit=1)[-1]
        requested_mbids.append(work_mbid)
        return httpx.Response(200, json=_work(work_mbid), request=request)

    connector, underlying = _connector(httpx.MockTransport(handler))
    requests = (
        MusicBrainzWorkEntityRequest(mbid=_WORK_A),
        MusicBrainzWorkEntityRequest(mbid=_WORK_B),
    )
    run_id = "exact-work-fixture"
    retrieved_at = datetime(2026, 8, 5, tzinfo=UTC)
    store = JsonlArtifactStore(tmp_path, tool_version="test")
    checkpoint_path = tmp_path / run_id / "checkpoints" / "musicbrainz-work-exact.json"

    def collect() -> PaginatedCollectionResult:
        return collect_paginated(
            run_id=run_id,
            scope="exact-works:fixture",
            metadata=connector.metadata,
            fetch_page=lambda size, cursor: fetch_exact_work_request_page(
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
            page_size=1,
            max_pages=None,
            dry_run=False,
            resume=True,
        )

    first = collect_paginated(
        run_id=run_id,
        scope="exact-works:fixture",
        metadata=connector.metadata,
        fetch_page=lambda size, cursor: fetch_exact_work_request_page(
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
        page_size=1,
        max_pages=None,
        dry_run=False,
        resume=True,
    )
    raw_result = store.write(
        run_id=run_id,
        stage=ArtifactStage.RAW,
        metadata=connector.metadata,
        records=first.records,
        retrieved_at=retrieved_at,
        dry_run=False,
        resume=True,
    )
    request_count_after_first = len(requested_mbids)
    resumed = collect()
    second_raw = store.write(
        run_id=run_id,
        stage=ArtifactStage.RAW,
        metadata=connector.metadata,
        records=resumed.records,
        retrieved_at=retrieved_at,
        dry_run=False,
        resume=True,
    )

    assert first.request_count == 2
    assert requested_mbids == [_WORK_A, _WORK_B]
    assert resumed.request_count == 0
    assert resumed.artifact_mutation_count == 0
    assert len(requested_mbids) == request_count_after_first
    assert second_raw.mutation_count == 0

    normalized = normalize_records(list(first.records))
    normalized_result = store.write(
        run_id=run_id,
        stage=ArtifactStage.NORMALIZED,
        metadata=connector.metadata,
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
        metadata=connector.metadata,
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
        metadata=connector.metadata,
        records=canonical,
        retrieved_at=retrieved_at,
        dry_run=False,
        resume=True,
        parent_sha256=resolved_result.manifest.sha256,
    )
    second_canonical = store.write(
        run_id=run_id,
        stage=ArtifactStage.CANONICAL,
        metadata=connector.metadata,
        records=canonical,
        retrieved_at=retrieved_at,
        dry_run=True,
        resume=True,
        parent_sha256=resolved_result.manifest.sha256,
    )

    pieces = [record for record in canonical if record.table is LoadTable.PIECES]
    assert {record.natural_key for record in pieces} == {
        f"musicbrainz_work:{_WORK_A}",
        f"musicbrainz_work:{_WORK_B}",
    }
    assert all(
        any(
            foreign_key.column == "composer_id"
            and foreign_key.target_natural_key == f"musicbrainz_artist:{_COMPOSER_MBID}"
            for foreign_key in record.foreign_keys
        )
        for record in pieces
    )
    assert not any(record.table is LoadTable.REVIEW_QUEUE for record in canonical)
    assert second_canonical.mutation_count == 0
    assert second_canonical.manifest.sha256 == canonical_result.manifest.sha256
    _, raw_roundtrip = read_artifact(raw_result.manifest_path, SourceRecord)
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
    assert raw_roundtrip == list(first.records)
    assert normalized_roundtrip == normalized
    assert resolved_roundtrip == decisions
    assert canonical_roundtrip == canonical
    underlying.close()


def test_exact_collection_dry_run_writes_no_artifact_or_checkpoint(tmp_path: Path) -> None:
    def handler(request: httpx.Request) -> httpx.Response:
        work_mbid = request.url.path.rsplit("/", maxsplit=1)[-1]
        return httpx.Response(200, json=_work(work_mbid), request=request)

    connector, underlying = _connector(httpx.MockTransport(handler))
    artifact_root = tmp_path / "artifacts"
    checkpoint_path = artifact_root / "dry-run" / "checkpoints" / "exact.json"
    result = collect_paginated(
        run_id="dry-run",
        scope="exact-works:fixture",
        metadata=connector.metadata,
        fetch_page=lambda size, cursor: fetch_exact_work_request_page(
            connector,
            (MusicBrainzWorkEntityRequest(mbid=_WORK_A),),
            page_size=size,
            cursor=cursor,
        ),
        artifact_store=JsonlArtifactStore(artifact_root, tool_version="test"),
        artifacts_root=artifact_root,
        checkpoint_path=checkpoint_path,
        retrieved_at=datetime(2026, 8, 5, tzinfo=UTC),
        limit=1,
        page_size=1,
        max_pages=None,
        dry_run=True,
        resume=True,
    )

    assert result.request_count == 1
    assert result.artifact_mutation_count == 0
    assert not checkpoint_path.exists()
    assert not artifact_root.exists()
    underlying.close()


def test_exact_cli_exposes_required_common_options() -> None:
    result = CliRunner().invoke(app, ["snapshot-musicbrainz-work-entities", "--help"])

    assert result.exit_code == 0
    for option in (
        "--run-id",
        "--input",
        "--contact",
        "--dry-run",
        "--resume",
        "--limit",
        "--json-report",
    ):
        assert option in result.output
    assert "--max-hierarchy-" in result.output
