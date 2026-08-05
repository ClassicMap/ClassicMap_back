from __future__ import annotations

import hashlib
import io
import tarfile
from datetime import UTC, date, datetime
from pathlib import Path

import pytest

from classicmap_seed.artifacts import JsonlArtifactStore
from classicmap_seed.export import build_canonical_load_bundle
from classicmap_seed.models import (
    ArtifactStage,
    EntityKind,
    InputFileProvenance,
    LoadTable,
    ResolutionAction,
    ResolutionDecision,
    SnapshotManifest,
    SourceName,
)
from classicmap_seed.normalize import normalize_records
from classicmap_seed.sources.musicbrainz_dump import (
    MusicBrainzDumpCollectionResult,
    MusicBrainzDumpReleaseMetadata,
    collect_musicbrainz_dump,
    verify_musicbrainz_dump_input,
)

_COMPOSER_MBID = "11111111-1111-4111-8111-111111111111"
_PERFORMER_MBID = "22222222-2222-4222-8222-222222222222"
_WORK_TYPE_MBID = "33333333-3333-4333-8333-333333333333"
_WORK_MBID = "44444444-4444-4444-8444-444444444444"
_RECORDING_MBID = "55555555-5555-4555-8555-555555555555"
_CREDIT_MBID = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
_COMPOSER_RELATION_MBID = "d59d99ea-23d4-4a80-b066-edca32ee158f"
_PERFORMANCE_RELATION_MBID = "a3005666-a872-32c3-ad06-98af558e99b0"


def _copy_row(*fields: object) -> bytes:
    return ("\t".join("\\N" if field is None else str(field) for field in fields) + "\n").encode()


def _member_rows(
    *,
    schema_sequence: int = 31,
    isrc: str = "USABC2600001",
    include_performer: bool = True,
) -> dict[str, bytes]:
    artist_rows = _copy_row(
        1,
        _COMPOSER_MBID,
        "Composer",
        "Composer",
        None,
        None,
        None,
        None,
        None,
        None,
        None,
        None,
        None,
        "",
        0,
        "2026-08-01",
        "f",
        None,
        None,
    )
    if include_performer:
        artist_rows += _copy_row(
            2,
            _PERFORMER_MBID,
            "Performer",
            "Performer",
            None,
            None,
            None,
            None,
            None,
            None,
            None,
            None,
            None,
            "",
            0,
            "2026-08-01",
            "f",
            None,
            None,
        )
    return {
        "mbdump/SCHEMA_SEQUENCE": f"{schema_sequence}\n".encode(),
        "mbdump/artist": artist_rows,
        "mbdump/artist_credit": _copy_row(10, "Performer", 1, 1, "2026-08-01", 0, _CREDIT_MBID),
        "mbdump/artist_credit_name": _copy_row(10, 0, 2, "Performer", ""),
        "mbdump/recording": _copy_row(
            200,
            _RECORDING_MBID,
            "Performance",
            10,
            123000,
            "",
            0,
            "2026-08-01",
            "f",
        ),
        "mbdump/isrc": _copy_row(1, 200, isrc, 0, "2026-08-01"),
        "mbdump/work": _copy_row(100, _WORK_MBID, "Symphony", 1, "", 0, "2026-08-01"),
        "mbdump/iswc": _copy_row(1, 100, "T-123.456.789-0", 0, "2026-08-01"),
        "mbdump/work_type": _copy_row(1, "Symphony", None, 0, "Symphonic work", _WORK_TYPE_MBID),
        "mbdump/link": b"".join(
            (
                _copy_row(1, 1, None, None, None, None, None, None, 0, "2026-08-01", "f"),
                _copy_row(2, 2, None, None, None, None, None, None, 0, "2026-08-01", "f"),
            )
        ),
        "mbdump/link_type": b"".join(
            (
                _copy_row(
                    1,
                    None,
                    0,
                    _COMPOSER_RELATION_MBID,
                    "artist",
                    "work",
                    "composer",
                    "",
                    "composed",
                    "composer",
                    "",
                    "2026-08-01",
                    "f",
                    "f",
                    0,
                    0,
                ),
                _copy_row(
                    2,
                    None,
                    0,
                    _PERFORMANCE_RELATION_MBID,
                    "recording",
                    "work",
                    "performance",
                    "",
                    "performance",
                    "performed as",
                    "",
                    "2026-08-01",
                    "f",
                    "f",
                    0,
                    0,
                ),
            )
        ),
        "mbdump/l_recording_work": _copy_row(2, 2, 200, 100, 0, "2026-08-01", 0, None, None),
        "mbdump/l_artist_work": _copy_row(1, 1, 1, 100, 0, "2026-08-01", 0, None, None),
    }


def _write_dump(
    path: Path,
    *,
    schema_sequence: int = 31,
    isrc: str = "USABC2600001",
    include_performer: bool = True,
) -> InputFileProvenance:
    rows = _member_rows(
        schema_sequence=schema_sequence,
        isrc=isrc,
        include_performer=include_performer,
    )
    with tarfile.open(path, "w:bz2") as archive:
        for name in reversed(tuple(rows)):
            content = rows[name]
            member = tarfile.TarInfo(name)
            member.size = len(content)
            archive.addfile(member, io.BytesIO(content))
    content = path.read_bytes()
    return InputFileProvenance(
        sha256=hashlib.sha256(content).hexdigest(),
        size_bytes=len(content),
        dump_date=date(2026, 8, 1),
        source_url=(
            "https://data.metabrainz.org/pub/musicbrainz/data/fullexport/"
            "20260801-002250/mbdump.tar.bz2"
        ),
    )


def _collect(
    tmp_path: Path,
    provenance: InputFileProvenance,
    *,
    start_ordinal: int = 0,
    end_ordinal: int | None = None,
    limit: int = 20,
    dry_run: bool = True,
    run_id: str = "mb-dump-test",
) -> MusicBrainzDumpCollectionResult:
    artifacts = tmp_path / "artifacts"
    return collect_musicbrainz_dump(
        input_path=tmp_path / "mbdump.tar.bz2",
        provenance=provenance,
        run_id=run_id,
        artifact_store=JsonlArtifactStore(artifacts, tool_version="test"),
        artifacts_root=artifacts,
        checkpoint_path=artifacts / run_id / "checkpoints" / "mb.json",
        start_ordinal=start_ordinal,
        end_ordinal=end_ordinal,
        limit=limit,
        checkpoint_every=1,
        dry_run=dry_run,
        resume=True,
    )


def test_dump_collects_exact_work_recording_credit_and_relationships(tmp_path: Path) -> None:
    provenance = _write_dump(tmp_path / "mbdump.tar.bz2")

    result = _collect(tmp_path, provenance)

    assert [record.entity_kind for record in result.records] == [
        EntityKind.WORK,
        EntityKind.RECORDING,
    ]
    work, recording = result.records
    assert work.source is SourceName.MUSICBRAINZ_DUMP
    assert work.source_record_id == _WORK_MBID
    assert work.payload["composer_mbids"] == [_COMPOSER_MBID]
    assert work.payload["iswcs"] == ["T-123.456.789-0"]
    assert recording.source_record_id == _RECORDING_MBID
    assert recording.payload["isrcs"] == ["USABC2600001"]
    assert recording.payload["performance_work_mbids"] == [_WORK_MBID]
    artist_credit = recording.payload["artist_credit"]
    assert isinstance(artist_credit, dict)
    assert artist_credit["artist_credit_mbid"] == _CREDIT_MBID
    assert artist_credit["names"] == [
        {
            "position": 0,
            "artist_internal_id": 2,
            "credited_name": "Performer",
            "join_phrase": "",
            "artist_mbid": _PERFORMER_MBID,
        }
    ]
    assert result.malformed_reviews == ()
    assert result.unresolved_reviews == ()
    assert result.complete is True

    candidates = normalize_records(list(result.records))
    work_identifiers = {
        (identifier.namespace, identifier.value)
        for identifier in candidates[0].external_identifiers
    }
    recording_identifiers = {
        (identifier.namespace, identifier.value)
        for identifier in candidates[1].external_identifiers
    }
    assert work_identifiers == {
        ("musicbrainz_work", _WORK_MBID),
        ("iswc", "T-123.456.789-0"),
    }
    assert recording_identifiers == {
        ("musicbrainz_recording", _RECORDING_MBID),
        ("isrc", "USABC2600001"),
    }


def test_partition_is_zero_based_work_then_recording(tmp_path: Path) -> None:
    provenance = _write_dump(tmp_path / "mbdump.tar.bz2")

    result = _collect(tmp_path, provenance, start_ordinal=1, end_ordinal=2)

    assert [record.source_record_id for record in result.records] == [_RECORDING_MBID]
    assert result.next_ordinal == 2
    assert result.complete is True


def test_dump_entities_normalize_but_canonical_export_remains_review_only(tmp_path: Path) -> None:
    provenance = _write_dump(tmp_path / "mbdump.tar.bz2")
    result = _collect(tmp_path, provenance)
    candidates = normalize_records(list(result.records))
    decisions = [
        ResolutionDecision(
            decision_id=f"decision-{candidate.candidate_id}",
            action=ResolutionAction.CREATE,
            candidate_ids=(candidate.candidate_id,),
            reason_code="NO_MATCHING_STABLE_IDENTIFIER",
        )
        for candidate in candidates
    ]
    digest = "a" * 64
    manifest = SnapshotManifest(
        run_id="mb-dump-test",
        stage=ArtifactStage.RAW,
        source=SourceName.MUSICBRAINZ_DUMP,
        snapshot_id=digest,
        retrieved_at=datetime(2026, 8, 1, tzinfo=UTC),
        source_uri=provenance.source_url,
        license="CC0-1.0",
        license_uri="https://musicbrainz.org/doc/About/Data_License",
        sha256=digest,
        row_count=2,
        relative_data_path=f"{digest}.jsonl",
        tool_version="test",
        input_provenance=provenance,
    )

    bundle = build_canonical_load_bundle(
        run_id="mb-dump-test",
        source_manifest=manifest,
        raw_records=list(result.records),
        candidates=candidates,
        decisions=decisions,
    )

    review_reasons = {
        record.values["reason_code"] for record in bundle if record.table is LoadTable.REVIEW_QUEUE
    }
    assert review_reasons == {
        "MUSICBRAINZ_DUMP_WORK_RAW_ONLY",
        "MUSICBRAINZ_DUMP_RECORDING_RAW_ONLY",
    }
    assert not any(record.table in {LoadTable.PIECES, LoadTable.RECORDINGS} for record in bundle)


def test_malformed_and_unresolved_are_separate_reviews(tmp_path: Path) -> None:
    provenance = _write_dump(
        tmp_path / "mbdump.tar.bz2",
        isrc="bad-isrc",
        include_performer=False,
    )

    result = _collect(tmp_path, provenance)

    assert [review.reason_code for review in result.malformed_reviews] == ["INVALID_ISRC"]
    assert {review.reason_code for review in result.unresolved_reviews} == {
        "ARTIST_CREDIT_ARTIST_NOT_FOUND"
    }
    assert len(result.records) == 2


def test_checkpoint_resume_reuses_page_artifacts(tmp_path: Path) -> None:
    provenance = _write_dump(tmp_path / "mbdump.tar.bz2")

    first = _collect(tmp_path, provenance, limit=1, dry_run=False)
    second = _collect(tmp_path, provenance, limit=20, dry_run=False)

    assert [record.source_record_id for record in first.records] == [_WORK_MBID]
    assert [record.source_record_id for record in second.records] == [
        _WORK_MBID,
        _RECORDING_MBID,
    ]
    assert second.resumed_record_count == 1
    assert second.complete is True


def test_release_sidecar_and_file_hash_are_strict(tmp_path: Path) -> None:
    provenance = _write_dump(tmp_path / "mbdump.tar.bz2")
    release = MusicBrainzDumpReleaseMetadata(
        release_date=provenance.dump_date,
        source_url=provenance.source_url,
        sha256=provenance.sha256,
        size_bytes=provenance.size_bytes,
    )

    assert verify_musicbrainz_dump_input(tmp_path / "mbdump.tar.bz2", release) == provenance
    with pytest.raises(ValueError, match="timestamp가 고정된"):
        MusicBrainzDumpReleaseMetadata(
            release_date=date(2026, 8, 1),
            source_url=(
                "https://data.metabrainz.org/pub/musicbrainz/data/fullexport/LATEST/mbdump.tar.bz2"
            ),
            sha256="a" * 64,
            size_bytes=1,
        )
    bad_release = release.model_copy(update={"sha256": "a" * 64})
    with pytest.raises(ValueError, match="SHA-256 불일치"):
        verify_musicbrainz_dump_input(tmp_path / "mbdump.tar.bz2", bad_release)


def test_schema_sequence_mismatch_is_rejected(tmp_path: Path) -> None:
    provenance = _write_dump(tmp_path / "mbdump.tar.bz2", schema_sequence=30)

    with pytest.raises(ValueError, match="schema sequence"):
        _collect(tmp_path, provenance)
