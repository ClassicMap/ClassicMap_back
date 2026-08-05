from datetime import UTC, datetime, timedelta
from pathlib import Path

import pytest

from classicmap_seed.artifacts import (
    ArtifactIntegrityError,
    JsonlArtifactStore,
    read_artifact,
)
from classicmap_seed.models import (
    ArtifactStage,
    EntityKind,
    RunOptions,
    SourceMetadata,
    SourceName,
    SourceRecord,
)


def _metadata() -> SourceMetadata:
    return SourceMetadata(
        source=SourceName.WIKIDATA,
        source_uri="https://query.wikidata.org/sparql",
        license="CC0-1.0",
        license_uri="https://www.wikidata.org/wiki/Wikidata:Licensing",
    )


def _records() -> list[SourceRecord]:
    return [
        SourceRecord(
            source=SourceName.WIKIDATA,
            source_record_id="Q123",
            entity_kind=EntityKind.PERSON,
            payload={"id": "Q123", "name": "Example Composer"},
        )
    ]


def test_dry_run_does_not_write_and_reports_expected_mutation(tmp_path: Path) -> None:
    store = JsonlArtifactStore(tmp_path, tool_version="test")

    result = store.write(
        run_id="run-1",
        stage=ArtifactStage.RAW,
        metadata=_metadata(),
        records=_records(),
        retrieved_at=datetime(2026, 8, 5, tzinfo=UTC),
        dry_run=True,
        resume=True,
    )

    assert result.mutation_count == 1
    assert not result.data_path.exists()
    assert not result.manifest_path.exists()


def test_second_write_is_idempotent_and_reuses_original_manifest(tmp_path: Path) -> None:
    store = JsonlArtifactStore(tmp_path, tool_version="test")
    retrieved_at = datetime(2026, 8, 5, tzinfo=UTC)

    first = store.write(
        run_id="run-1",
        stage=ArtifactStage.RAW,
        metadata=_metadata(),
        records=_records(),
        retrieved_at=retrieved_at,
        dry_run=False,
        resume=True,
    )
    second = store.write(
        run_id="run-1",
        stage=ArtifactStage.RAW,
        metadata=_metadata(),
        records=_records(),
        retrieved_at=retrieved_at + timedelta(hours=1),
        dry_run=True,
        resume=True,
    )

    assert first.created is True
    assert first.mutation_count == 1
    assert second.created is False
    assert second.mutation_count == 0
    assert second.manifest.retrieved_at == retrieved_at
    manifest, records = read_artifact(first.manifest_path, SourceRecord)
    assert manifest.sha256 == first.manifest.sha256
    assert records == _records()


def test_modified_data_fails_integrity_validation(tmp_path: Path) -> None:
    store = JsonlArtifactStore(tmp_path, tool_version="test")
    result = store.write(
        run_id="run-1",
        stage=ArtifactStage.RAW,
        metadata=_metadata(),
        records=_records(),
        retrieved_at=datetime(2026, 8, 5, tzinfo=UTC),
        dry_run=False,
        resume=True,
    )
    result.data_path.write_text("tampered\n")

    with pytest.raises(ArtifactIntegrityError, match="SHA-256 불일치"):
        read_artifact(result.manifest_path, SourceRecord)


def test_run_id_rejects_path_traversal() -> None:
    with pytest.raises(ValueError, match="안전한 경로 이름"):
        RunOptions(run_id="../outside")


def test_wikidata_dump_manifest_requires_input_provenance(tmp_path: Path) -> None:
    metadata = SourceMetadata(
        source=SourceName.WIKIDATA,
        source_uri=(
            "https://dumps.wikimedia.org/wikidatawiki/entities/"
            "20260801/wikidata-20260801-all.json.bz2"
        ),
        license="CC0-1.0",
        license_uri="https://www.wikidata.org/wiki/Wikidata:Licensing",
    )

    with pytest.raises(ValueError, match="input_provenance"):
        JsonlArtifactStore(tmp_path, tool_version="test").write(
            run_id="dump-run",
            stage=ArtifactStage.RAW,
            metadata=metadata,
            records=_records(),
            retrieved_at=datetime(2026, 8, 5, tzinfo=UTC),
            dry_run=True,
            resume=True,
        )
