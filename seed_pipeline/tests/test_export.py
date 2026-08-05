from datetime import UTC, datetime
from pathlib import Path

from classicmap_seed.artifacts import JsonlArtifactStore
from classicmap_seed.export import build_canonical_load_bundle
from classicmap_seed.load import can_apply_seed_value
from classicmap_seed.models import (
    ArtifactStage,
    DataOrigin,
    EntityKind,
    ExistingFieldState,
    LoadTable,
    NormalizedEntityCandidate,
    ResolutionAction,
    ResolutionDecision,
    SnapshotManifest,
    SourceMetadata,
    SourceName,
    SourceRecord,
    WritePolicy,
)
from classicmap_seed.normalize import normalize_records


def _manifest() -> SnapshotManifest:
    digest = "a" * 64
    return SnapshotManifest(
        run_id="run-1",
        stage=ArtifactStage.RAW,
        source=SourceName.WIKIDATA,
        snapshot_id=digest,
        retrieved_at=datetime(2026, 8, 5, tzinfo=UTC),
        source_uri="https://query.wikidata.org/sparql",
        license="CC0-1.0",
        license_uri="https://www.wikidata.org/wiki/Wikidata:Licensing",
        sha256=digest,
        row_count=1,
        relative_data_path=f"{digest}.jsonl",
        tool_version="test",
    )


def _raw(kind: EntityKind = EntityKind.PERSON) -> SourceRecord:
    return SourceRecord(
        source=SourceName.WIKIDATA,
        source_record_id="Q255",
        entity_kind=kind,
        payload={"name": "Ludwig van Beethoven", "date_of_birth": "1770-12-17"},
    )


def _candidate(kind: EntityKind = EntityKind.PERSON) -> NormalizedEntityCandidate:
    return normalize_records([_raw(kind)])[0]


def test_canonical_bundle_is_deterministic_and_preserves_manual_fields() -> None:
    candidate = _candidate()
    decision = ResolutionDecision(
        decision_id="decision-1",
        action=ResolutionAction.CREATE,
        candidate_ids=(candidate.candidate_id,),
        reason_code="NO_MATCHING_STABLE_IDENTIFIER",
    )

    first = build_canonical_load_bundle(
        run_id="run-1",
        source_manifest=_manifest(),
        raw_records=[_raw()],
        candidates=[candidate],
        decisions=[decision],
    )
    second = build_canonical_load_bundle(
        run_id="run-1",
        source_manifest=_manifest(),
        raw_records=[_raw()],
        candidates=[candidate],
        decisions=[decision],
    )

    assert first == second
    assert all(record.origin is DataOrigin.SEED for record in first)
    assert all(record.editor_locked is False for record in first)
    assert all(record.write_policy is WritePolicy.PRESERVE_MANUAL_OR_LOCKED for record in first)
    assert any(record.table is LoadTable.AUTHORITY_ENTITIES for record in first)
    assert any(record.table is LoadTable.FIELD_PROVENANCE for record in first)


def test_review_decision_does_not_create_canonical_entity() -> None:
    candidate = _candidate()
    decision = ResolutionDecision(
        decision_id="decision-review",
        action=ResolutionAction.REVIEW_REQUIRED,
        candidate_ids=(candidate.candidate_id,),
        reason_code="NAME_ONLY_MATCH_FORBIDDEN",
    )

    bundle = build_canonical_load_bundle(
        run_id="run-1",
        source_manifest=_manifest(),
        raw_records=[_raw()],
        candidates=[candidate],
        decisions=[decision],
    )

    assert any(record.table is LoadTable.REVIEW_QUEUE for record in bundle)
    assert not any(record.table is LoadTable.AUTHORITY_ENTITIES for record in bundle)


def test_second_export_dry_run_is_byte_identical_and_zero_mutation(tmp_path: Path) -> None:
    candidate = _candidate()
    decision = ResolutionDecision(
        decision_id="decision-idempotent",
        action=ResolutionAction.CREATE,
        candidate_ids=(candidate.candidate_id,),
        reason_code="NO_MATCHING_STABLE_IDENTIFIER",
    )
    bundle = build_canonical_load_bundle(
        run_id="run-1",
        source_manifest=_manifest(),
        raw_records=[_raw()],
        candidates=[candidate],
        decisions=[decision],
    )
    store = JsonlArtifactStore(tmp_path, tool_version="test")
    first = store.write(
        run_id="run-1",
        stage=ArtifactStage.CANONICAL,
        metadata=SourceMetadata(
            source=SourceName.WIKIDATA,
            source_uri="https://query.wikidata.org/sparql",
            license="CC0-1.0",
            license_uri="https://www.wikidata.org/wiki/Wikidata:Licensing",
        ),
        records=bundle,
        retrieved_at=datetime(2026, 8, 5, tzinfo=UTC),
        dry_run=False,
        resume=True,
    )
    second = store.write(
        run_id="run-1",
        stage=ArtifactStage.CANONICAL,
        metadata=SourceMetadata(
            source=SourceName.WIKIDATA,
            source_uri="https://query.wikidata.org/sparql",
            license="CC0-1.0",
            license_uri="https://www.wikidata.org/wiki/Wikidata:Licensing",
        ),
        records=bundle,
        retrieved_at=datetime(2026, 8, 6, tzinfo=UTC),
        dry_run=True,
        resume=True,
    )

    assert first.manifest.sha256 == second.manifest.sha256
    assert second.mutation_count == 0


def test_unmapped_work_and_recording_are_review_only() -> None:
    for kind in (EntityKind.WORK, EntityKind.RECORDING):
        candidate = _candidate(kind)
        decision = ResolutionDecision(
            decision_id=f"decision-{kind}",
            action=ResolutionAction.CREATE,
            candidate_ids=(candidate.candidate_id,),
            reason_code="NO_MATCHING_STABLE_IDENTIFIER",
        )
        bundle = build_canonical_load_bundle(
            run_id="run-1",
            source_manifest=_manifest(),
            raw_records=[_raw(kind)],
            candidates=[candidate],
            decisions=[decision],
        )
        assert any(record.table is LoadTable.REVIEW_QUEUE for record in bundle)
        assert not any(
            record.table in {LoadTable.PIECES, LoadTable.RECORDINGS} for record in bundle
        )


def test_load_contract_blocks_manual_or_locked_fields() -> None:
    assert can_apply_seed_value(None) is True
    assert (
        can_apply_seed_value(
            ExistingFieldState(origin=DataOrigin.SEED, editor_locked=False),
        )
        is True
    )
    assert (
        can_apply_seed_value(
            ExistingFieldState(origin=DataOrigin.MANUAL, editor_locked=False),
        )
        is False
    )
    assert (
        can_apply_seed_value(
            ExistingFieldState(origin=DataOrigin.SEED, editor_locked=True),
        )
        is False
    )
