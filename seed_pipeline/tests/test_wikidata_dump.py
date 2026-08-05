from __future__ import annotations

import bz2
import hashlib
import json
from pathlib import Path

import pytest
from typer.testing import CliRunner

from classicmap_seed.artifacts import read_artifact, read_manifest
from classicmap_seed.cli import app
from classicmap_seed.models import CanonicalLoadRecord, LoadTable, SourceRecord
from classicmap_seed.sources.wikidata_dump import (
    WikidataDumpReleaseMetadata,
    WikidataDumpScopeReview,
    iter_wikidata_dump,
    read_wikidata_dump_release_metadata,
    verify_wikidata_dump_input,
)

_SOURCE_URL = (
    "https://dumps.wikimedia.org/wikidatawiki/entities/20260801/wikidata-20260801-all.json.bz2"
)


def _fixture_content() -> bytes:
    return (Path(__file__).parent / "fixtures" / "wikidata_dump.json").read_bytes()


def _write_input(tmp_path: Path, *, compressed: bool) -> tuple[Path, Path]:
    content = _fixture_content()
    if compressed:
        content = bz2.compress(content)
        input_path = tmp_path / "wikidata-20260801-all.json.bz2"
    else:
        input_path = tmp_path / "wikidata-fixture.json"
    input_path.write_bytes(content)
    metadata = WikidataDumpReleaseMetadata(
        dump_date="2026-08-01",
        source_url=_SOURCE_URL,
        sha256=hashlib.sha256(content).hexdigest(),
        size_bytes=len(content),
    )
    metadata_path = tmp_path / "wikidata-release.json"
    metadata_path.write_text(f"{metadata.model_dump_json(indent=2)}\n", encoding="utf-8")
    return input_path, metadata_path


@pytest.mark.parametrize("compressed", [False, True])
def test_dump_cli_streams_exact_scopes_reviews_and_resumes_zero(
    tmp_path: Path,
    compressed: bool,
) -> None:
    input_path, metadata_path = _write_input(tmp_path, compressed=compressed)
    artifacts = tmp_path / "artifacts"
    report_path = tmp_path / "first-report.json"
    runner = CliRunner()
    arguments = [
        "snapshot-wikidata-dump",
        "--run-id",
        "dump-fixture",
        "--input",
        str(input_path),
        "--release-metadata",
        str(metadata_path),
        "--start-ordinal",
        "6",
        "--end-ordinal",
        "12",
        "--limit",
        "10",
        "--checkpoint-every",
        "2",
        "--artifacts-dir",
        str(artifacts),
        "--json-report",
        str(report_path),
    ]

    first = runner.invoke(app, arguments)

    assert first.exit_code == 0, first.output
    first_report = json.loads(report_path.read_text(encoding="utf-8"))
    assert first_report["output_count"] == 3
    assert first_report["review_count"] == 2
    assert first_report["mutation_count"] == 5
    assert first_report["next_ordinal"] == 12
    assert first_report["complete"] is True
    manifest = read_manifest(Path(first_report["manifest_path"]))
    assert manifest.input_provenance is not None
    assert manifest.input_provenance.sha256 == hashlib.sha256(input_path.read_bytes()).hexdigest()
    _, records = read_artifact(Path(first_report["manifest_path"]), SourceRecord)
    assert [(record.source_record_id, record.payload["scope"]) for record in records] == [
        ("Q100", "composers"),
        ("Q101", "performers"),
        ("Q102", "ensembles"),
    ]
    composer = records[0]
    assert composer.payload["country_codes"] == ["DE"]
    assert composer.payload["country_entity_ids"] == ["Q123456", "Q183"]
    assert composer.payload["country_code_links"] == [
        {"country_code": "DE", "country_entity_id": "Q183"}
    ]
    country_labels = composer.payload["country_labels"]
    assert isinstance(country_labels, list)
    assert {label.get("code") for label in country_labels if isinstance(label, dict)} == {
        "Q123456",
        "Q183",
    }
    assert composer.payload["entity_data_source"] == _SOURCE_URL
    _, reviews = read_artifact(
        Path(first_report["review_manifest_path"]),
        WikidataDumpScopeReview,
    )
    assert [(review.qid, review.reason_code) for review in reviews] == [
        ("Q103", "AMBIGUOUS_SCOPE"),
        ("Q104", "UNKNOWN_SCOPE_EVIDENCE"),
    ]

    resume_report_path = tmp_path / "resume-report.json"
    resumed = runner.invoke(
        app,
        [
            *arguments[:-2],
            "--json-report",
            str(resume_report_path),
        ],
    )

    assert resumed.exit_code == 0, resumed.output
    resume_report = json.loads(resume_report_path.read_text(encoding="utf-8"))
    assert resume_report["scanned_entity_count"] == 0
    assert resume_report["resumed_output_count"] == 3
    assert resume_report["resumed_review_count"] == 2
    assert resume_report["mutation_count"] == 0


def test_dump_checkpoint_rejects_checksum_drift_even_with_updated_sidecar(
    tmp_path: Path,
) -> None:
    input_path, metadata_path = _write_input(tmp_path, compressed=False)
    artifacts = tmp_path / "artifacts"
    runner = CliRunner()
    arguments = [
        "snapshot-wikidata-dump",
        "--run-id",
        "drift-run",
        "--input",
        str(input_path),
        "--release-metadata",
        str(metadata_path),
        "--limit",
        "1",
        "--artifacts-dir",
        str(artifacts),
    ]
    first = runner.invoke(app, arguments)
    assert first.exit_code == 0, first.output

    changed = input_path.read_bytes().replace(b"Out of scope", b"Changed scope")
    input_path.write_bytes(changed)
    changed_metadata = WikidataDumpReleaseMetadata(
        dump_date="2026-08-01",
        source_url=_SOURCE_URL,
        sha256=hashlib.sha256(changed).hexdigest(),
        size_bytes=len(changed),
    )
    metadata_path.write_text(
        f"{changed_metadata.model_dump_json(indent=2)}\n",
        encoding="utf-8",
    )

    resumed = runner.invoke(app, arguments)

    assert resumed.exit_code != 0
    assert "dump checkpoint" in resumed.output


def test_dump_dry_run_leaves_artifact_root_and_report_untouched(tmp_path: Path) -> None:
    input_path, metadata_path = _write_input(tmp_path, compressed=False)
    artifacts = tmp_path / "artifacts"
    report_path = tmp_path / "dry-run-report.json"

    result = CliRunner().invoke(
        app,
        [
            "snapshot-wikidata-dump",
            "--run-id",
            "dump-dry-run",
            "--input",
            str(input_path),
            "--release-metadata",
            str(metadata_path),
            "--start-ordinal",
            "6",
            "--end-ordinal",
            "12",
            "--limit",
            "10",
            "--dry-run",
            "--artifacts-dir",
            str(artifacts),
            "--json-report",
            str(report_path),
        ],
    )

    assert result.exit_code == 0, result.output
    report = json.loads(result.output)
    assert report["mutation_count"] == 5
    assert not artifacts.exists()
    assert not report_path.exists()


def test_dump_provenance_and_country_links_reach_canonical_projection(tmp_path: Path) -> None:
    input_path, metadata_path = _write_input(tmp_path, compressed=True)
    artifacts = tmp_path / "artifacts"
    runner = CliRunner()
    dump_report_path = tmp_path / "dump.json"
    snapshot = runner.invoke(
        app,
        [
            "snapshot-wikidata-dump",
            "--run-id",
            "dump-canonical",
            "--input",
            str(input_path),
            "--release-metadata",
            str(metadata_path),
            "--start-ordinal",
            "6",
            "--end-ordinal",
            "7",
            "--limit",
            "1",
            "--artifacts-dir",
            str(artifacts),
            "--json-report",
            str(dump_report_path),
        ],
    )
    assert snapshot.exit_code == 0, snapshot.output
    dump_report = json.loads(dump_report_path.read_text(encoding="utf-8"))

    normalize_report_path = tmp_path / "normalize.json"
    normalized = runner.invoke(
        app,
        [
            "normalize",
            "--run-id",
            "dump-canonical",
            "--manifest",
            dump_report["manifest_path"],
            "--limit",
            "1",
            "--artifacts-dir",
            str(artifacts),
            "--json-report",
            str(normalize_report_path),
        ],
    )
    assert normalized.exit_code == 0, normalized.output
    normalize_report = json.loads(normalize_report_path.read_text(encoding="utf-8"))
    normalized_manifest = read_manifest(Path(normalize_report["manifest_path"]))
    assert normalized_manifest.input_provenance is not None

    resolve_report_path = tmp_path / "resolve.json"
    resolved = runner.invoke(
        app,
        [
            "resolve",
            "--run-id",
            "dump-canonical",
            "--manifest",
            normalize_report["manifest_path"],
            "--limit",
            "1",
            "--artifacts-dir",
            str(artifacts),
            "--json-report",
            str(resolve_report_path),
        ],
    )
    assert resolved.exit_code == 0, resolved.output
    resolve_report = json.loads(resolve_report_path.read_text(encoding="utf-8"))

    canonical_report_path = tmp_path / "canonical.json"
    canonical = runner.invoke(
        app,
        [
            "export-canonical",
            "--run-id",
            "dump-canonical",
            "--manifest",
            resolve_report["manifest_path"],
            "--limit",
            "1",
            "--artifacts-dir",
            str(artifacts),
            "--json-report",
            str(canonical_report_path),
        ],
    )
    assert canonical.exit_code == 0, canonical.output
    canonical_report = json.loads(canonical_report_path.read_text(encoding="utf-8"))
    canonical_manifest = read_manifest(Path(canonical_report["manifest_path"]))
    assert canonical_manifest.input_provenance == normalized_manifest.input_provenance
    _, load_records = read_artifact(
        Path(canonical_report["manifest_path"]),
        CanonicalLoadRecord,
    )
    composer = next(record for record in load_records if record.table is LoadTable.COMPOSERS)
    assert composer.values["nationality"] == "독일"


def test_dump_reader_never_calls_read_bytes_for_dump_input(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
) -> None:
    input_path, metadata_path = _write_input(tmp_path, compressed=True)
    release = read_wikidata_dump_release_metadata(metadata_path)
    original_read_bytes = Path.read_bytes

    def guarded_read_bytes(path: Path) -> bytes:
        if path == input_path:
            raise AssertionError("dump 전체 read_bytes 호출 금지")
        return original_read_bytes(path)

    monkeypatch.setattr(Path, "read_bytes", guarded_read_bytes)

    provenance = verify_wikidata_dump_input(input_path, release)
    row_count = sum(1 for _ in iter_wikidata_dump(input_path))
    runner = CliRunner()
    result = runner.invoke(
        app,
        [
            "snapshot-wikidata-dump",
            "--run-id",
            "bounded-reader",
            "--input",
            str(input_path),
            "--release-metadata",
            str(metadata_path),
            "--limit",
            "1",
            "--artifacts-dir",
            str(tmp_path / "artifacts"),
        ],
    )

    assert provenance.size_bytes == input_path.stat().st_size
    assert row_count == 12
    assert result.exit_code == 0, result.output


def test_release_metadata_requires_official_dated_url(tmp_path: Path) -> None:
    input_path, _ = _write_input(tmp_path, compressed=False)
    invalid = tmp_path / "invalid-release.json"
    invalid.write_text(
        json.dumps(
            {
                "schema_version": "1",
                "dump_date": "2026-08-01",
                "source_url": "https://example.com/wikidata.json.bz2",
                "sha256": hashlib.sha256(input_path.read_bytes()).hexdigest(),
                "size_bytes": input_path.stat().st_size,
            }
        ),
        encoding="utf-8",
    )

    with pytest.raises(ValueError, match="공식 Wikidata"):
        read_wikidata_dump_release_metadata(invalid)
