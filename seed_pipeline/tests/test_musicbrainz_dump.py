from __future__ import annotations

import hashlib
import io
import json
import tarfile
from datetime import date
from pathlib import Path

import pytest

from classicmap_seed.artifacts import JsonlArtifactStore, read_artifact
from classicmap_seed.export import build_canonical_load_bundle
from classicmap_seed.models import (
    EntityKind,
    InputFileProvenance,
    LoadTable,
    ResolutionAction,
    ResolutionDecision,
    SourceName,
    SourceRecord,
)
from classicmap_seed.normalize import normalize_records
from classicmap_seed.sources.musicbrainz_dump import (
    MusicBrainzDumpCollectionResult,
    MusicBrainzDumpMalformedReview,
    MusicBrainzDumpReleaseMetadata,
    MusicBrainzDumpUnresolvedReview,
    collect_musicbrainz_dump,
    verify_musicbrainz_dump_input,
)

_COMPOSER_MBID = "11111111-1111-4111-8111-111111111111"
_PERFORMER_MBID = "22222222-2222-4222-8222-222222222222"
_WORK_TYPE_MBID = "33333333-3333-4333-8333-333333333333"
_WORK_MBID = "44444444-4444-4444-8444-444444444444"
_RECORDING_MBID = "55555555-5555-4555-8555-555555555555"
_CREDIT_MBID = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
_ATTRIBUTE_MBID = "66666666-6666-4666-8666-666666666666"
_COMPOSER_RELATION_MBID = "d59d99ea-23d4-4a80-b066-edca32ee158f"
_PERFORMANCE_RELATION_MBID = "a3005666-a872-32c3-ad06-98af558e99b0"


def _copy_row(*fields: object) -> bytes:
    return ("\t".join("\\N" if field is None else str(field) for field in fields) + "\n").encode()


def _member_rows(
    *,
    schema_sequence: int = 31,
    isrc: str = "USABC2600001",
    include_performer: bool = True,
    work_mbid: str = _WORK_MBID,
    orphan_isrc: bool = False,
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
    isrc_rows = _copy_row(1, 200, isrc, 0, "2026-08-01")
    if orphan_isrc:
        isrc_rows += _copy_row(2, 999, "GBXYZ2600002", 0, "2026-08-01")
    return {
        "SCHEMA_SEQUENCE": f"{schema_sequence}\n".encode(),
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
        "mbdump/isrc": isrc_rows,
        "mbdump/work": _copy_row(100, work_mbid, "Symphony", 1, "", 0, "2026-08-01"),
        "mbdump/iswc": _copy_row(1, 100, "T-123.456.789-0", 0, "2026-08-01"),
        "mbdump/work_type": _copy_row(1, "Symphony", None, 0, "Symphonic work", _WORK_TYPE_MBID),
        "mbdump/link": b"".join(
            (
                _copy_row(1, 1, None, None, None, None, None, None, 0, "2026-08-01", "f"),
                _copy_row(2, 2, 2020, 1, 2, 2020, 1, 3, 1, "2026-08-01", "t"),
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
        "mbdump/link_attribute_type": _copy_row(
            1, None, 1, 0, _ATTRIBUTE_MBID, "live", "Live recording", "2026-08-01"
        ),
        "mbdump/link_attribute": _copy_row(2, 1, "2026-08-01"),
        "mbdump/l_recording_work": _copy_row(
            2, 2, 200, 100, 0, "2026-08-01", 0, "solo credit", "work credit"
        ),
        "mbdump/l_artist_work": _copy_row(1, 1, 1, 100, 0, "2026-08-01", 0, None, None),
    }


def _write_dump(
    path: Path,
    *,
    schema_sequence: int = 31,
    isrc: str = "USABC2600001",
    include_performer: bool = True,
    work_mbid: str = _WORK_MBID,
    orphan_isrc: bool = False,
) -> InputFileProvenance:
    rows = _member_rows(
        schema_sequence=schema_sequence,
        isrc=isrc,
        include_performer=include_performer,
        work_mbid=work_mbid,
        orphan_isrc=orphan_isrc,
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
    dry_run: bool = False,
    resume: bool = True,
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
        resume=resume,
    )


def _raw_records(result: MusicBrainzDumpCollectionResult) -> list[SourceRecord]:
    return read_artifact(result.record_artifact.manifest_path, SourceRecord)[1]


def _malformed_reviews(
    result: MusicBrainzDumpCollectionResult,
) -> list[MusicBrainzDumpMalformedReview]:
    if result.malformed_artifact is None:
        return []
    return read_artifact(result.malformed_artifact.manifest_path, MusicBrainzDumpMalformedReview)[1]


def _unresolved_reviews(
    result: MusicBrainzDumpCollectionResult,
) -> list[MusicBrainzDumpUnresolvedReview]:
    if result.unresolved_artifact is None:
        return []
    return read_artifact(result.unresolved_artifact.manifest_path, MusicBrainzDumpUnresolvedReview)[
        1
    ]


def test_dump_collects_exact_work_recording_credit_and_relationships(tmp_path: Path) -> None:
    provenance = _write_dump(tmp_path / "mbdump.tar.bz2")

    result = _collect(tmp_path, provenance)

    records = _raw_records(result)
    assert [record.entity_kind for record in records] == [
        EntityKind.WORK,
        EntityKind.RECORDING,
    ]
    work, recording = records
    assert work.source is SourceName.MUSICBRAINZ_DUMP
    assert work.source_record_id == _WORK_MBID
    assert work.payload["composer_mbids"] == [_COMPOSER_MBID]
    assert work.payload["iswcs"] == ["T-123.456.789-0"]
    assert recording.source_record_id == _RECORDING_MBID
    assert recording.payload["isrcs"] == ["USABC2600001"]
    assert recording.payload["performance_work_mbids"] == [_WORK_MBID]
    relations = recording.payload["recording_work_relations"]
    assert isinstance(relations, list)
    relation = relations[0]
    assert isinstance(relation, dict)
    assert relation["attributes"] == [
        {
            "attribute_type_internal_id": 1,
            "attribute_type_mbid": _ATTRIBUTE_MBID,
            "name": "live",
        }
    ]
    assert relation["dates"] == {
        "begin_date_year": 2020,
        "begin_date_month": 1,
        "begin_date_day": 2,
        "end_date_year": 2020,
        "end_date_month": 1,
        "end_date_day": 3,
    }
    assert relation["ended"] is True
    assert relation["entity0_credit"] == "solo credit"
    assert relation["entity1_credit"] == "work credit"
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
    assert _malformed_reviews(result) == []
    assert _unresolved_reviews(result) == []
    assert result.complete is True

    candidates = normalize_records(records)
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

    assert [record.source_record_id for record in _raw_records(result)] == [_RECORDING_MBID]
    assert result.next_ordinal == 2
    assert result.complete is True


def test_dump_entities_normalize_but_canonical_export_remains_review_only(tmp_path: Path) -> None:
    provenance = _write_dump(tmp_path / "mbdump.tar.bz2")
    result = _collect(tmp_path, provenance)
    raw_records = _raw_records(result)
    candidates = normalize_records(raw_records)
    decisions = [
        ResolutionDecision(
            decision_id=f"decision-{candidate.candidate_id}",
            action=ResolutionAction.CREATE,
            candidate_ids=(candidate.candidate_id,),
            reason_code="NO_MATCHING_STABLE_IDENTIFIER",
        )
        for candidate in candidates
    ]
    bundle = build_canonical_load_bundle(
        run_id="mb-dump-test",
        source_manifest=result.record_artifact.manifest,
        raw_records=raw_records,
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

    assert [review.reason_code for review in _malformed_reviews(result)] == ["INVALID_ISRC"]
    assert {review.reason_code for review in _unresolved_reviews(result)} == {
        "ARTIST_CREDIT_ARTIST_NOT_FOUND"
    }
    assert result.record_count == 2


def test_checkpoint_resume_reuses_page_artifacts(tmp_path: Path) -> None:
    provenance = _write_dump(tmp_path / "mbdump.tar.bz2")

    first = _collect(tmp_path, provenance, limit=1, dry_run=False)
    second = _collect(tmp_path, provenance, limit=20, dry_run=False)

    assert [record.source_record_id for record in _raw_records(first)] == [_WORK_MBID]
    assert [record.source_record_id for record in _raw_records(second)] == [
        _WORK_MBID,
        _RECORDING_MBID,
    ]
    assert second.resumed_record_count == 1
    assert second.complete is True


def test_no_resume_first_page_can_finalize_aggregate(tmp_path: Path) -> None:
    provenance = _write_dump(tmp_path / "mbdump.tar.bz2")

    result = _collect(tmp_path, provenance, limit=1, resume=False)

    assert [record.source_record_id for record in _raw_records(result)] == [_WORK_MBID]
    assert result.resumed_record_count == 0
    assert result.complete is False


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


def test_empty_root_schema_sequence_is_rejected(tmp_path: Path) -> None:
    rows = _member_rows()
    rows["SCHEMA_SEQUENCE"] = b""
    path = tmp_path / "mbdump.tar.bz2"
    with tarfile.open(path, "w:bz2") as archive:
        for name, content in rows.items():
            member = tarfile.TarInfo(name)
            member.size = len(content)
            archive.addfile(member, io.BytesIO(content))
    content = path.read_bytes()
    provenance = InputFileProvenance(
        sha256=hashlib.sha256(content).hexdigest(),
        size_bytes=len(content),
        dump_date=date(2026, 8, 1),
        source_url=(
            "https://data.metabrainz.org/pub/musicbrainz/data/fullexport/"
            "20260801-002250/mbdump.tar.bz2"
        ),
    )

    with pytest.raises(ValueError, match="SCHEMA_SEQUENCE"):
        _collect(tmp_path, provenance)


def test_malformed_work_mbid_is_not_promoted_to_exact_performance_link(
    tmp_path: Path,
) -> None:
    provenance = _write_dump(tmp_path / "mbdump.tar.bz2", work_mbid="not-a-mbid")

    result = _collect(tmp_path, provenance)
    records = _raw_records(result)

    assert [record.entity_kind for record in records] == [EntityKind.RECORDING]
    assert records[0].payload["performance_work_mbids"] == []
    assert [review.reason_code for review in _malformed_reviews(result)] == ["INVALID_WORK_MBID"]
    assert {review.reason_code for review in _unresolved_reviews(result)} == {
        "RECORDING_WORK_TARGET_MBID_INVALID"
    }


def test_orphan_child_identifier_is_emitted_as_unresolved_review(tmp_path: Path) -> None:
    provenance = _write_dump(tmp_path / "mbdump.tar.bz2", orphan_isrc=True)

    result = _collect(tmp_path, provenance)

    orphan = next(
        review
        for review in _unresolved_reviews(result)
        if review.reason_code == "ORPHAN_ISRC_RECORDING"
    )
    assert orphan.musicbrainz_internal_id == 999
    assert orphan.entity_mbid is None
    assert orphan.entity_ordinal is None
    assert orphan.evidence == {"isrc": "GBXYZ2600002"}


def test_checkpoint_rejects_page_manifest_from_another_run(tmp_path: Path) -> None:
    provenance = _write_dump(tmp_path / "mbdump.tar.bz2")
    _collect(tmp_path, provenance, limit=1, run_id="run-one")
    other = _collect(tmp_path, provenance, limit=1, run_id="run-two")
    artifacts = tmp_path / "artifacts"
    checkpoint_path = artifacts / "run-one" / "checkpoints" / "mb.json"
    checkpoint = json.loads(checkpoint_path.read_text())
    checkpoint["record_manifest_paths"] = [
        other.record_artifact.manifest_path.relative_to(artifacts).as_posix()
    ]
    checkpoint_path.write_text(json.dumps(checkpoint))

    with pytest.raises(ValueError, match="provenance 불일치"):
        _collect(tmp_path, provenance, limit=20, run_id="run-one")


def test_dry_run_hashes_without_writing_pages_or_checkpoint(tmp_path: Path) -> None:
    provenance = _write_dump(tmp_path / "mbdump.tar.bz2")

    result = _collect(tmp_path, provenance, dry_run=True)

    assert result.record_count == 2
    assert result.record_artifact.data_path.exists() is False
    assert (tmp_path / "artifacts" / "mb-dump-test" / "checkpoints" / "mb.json").exists() is False


def test_completed_resume_dry_run_reports_zero_artifact_mutation(tmp_path: Path) -> None:
    provenance = _write_dump(tmp_path / "mbdump.tar.bz2")
    written = _collect(tmp_path, provenance)

    result = _collect(tmp_path, provenance, dry_run=True)

    assert result.scanned_entity_count == 0
    assert result.artifact_mutation_count == 0
    assert result.record_artifact.manifest.sha256 == written.record_artifact.manifest.sha256
