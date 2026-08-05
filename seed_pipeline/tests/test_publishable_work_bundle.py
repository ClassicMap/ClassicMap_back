from __future__ import annotations

from datetime import UTC, datetime

import pytest

from classicmap_seed.export import build_publishable_work_bundle
from classicmap_seed.models import (
    ArtifactStage,
    CanonicalLoadRecord,
    ForeignKeyResolution,
    LoadForeignKey,
    LoadTable,
    SnapshotManifest,
    SourceName,
)

RUN_ID = "11111111-1111-4111-8111-111111111111"


def manifest(source: SourceName, sha: str) -> SnapshotManifest:
    return SnapshotManifest(
        run_id="work-run",
        stage=ArtifactStage.CANONICAL,
        source=source,
        snapshot_id=sha,
        retrieved_at=datetime(2026, 8, 5, tzinfo=UTC),
        source_uri="https://example.invalid/source",
        license="CC0-1.0",
        license_uri="https://example.invalid/license",
        sha256=sha,
        row_count=1,
        relative_data_path=f"{sha}.jsonl",
        tool_version="test",
    )


def record(
    table: LoadTable,
    natural_key: str,
    *,
    foreign_keys: tuple[LoadForeignKey, ...] = (),
    values: dict[str, object] | None = None,
) -> CanonicalLoadRecord:
    return CanonicalLoadRecord(
        seed_run_id=RUN_ID,
        table=table,
        natural_key=natural_key,
        values=values or {},
        foreign_keys=foreign_keys,
    )


def fk(column: str, table: LoadTable, natural_key: str) -> LoadForeignKey:
    return LoadForeignKey(
        column=column,
        target_table=table,
        target_natural_key=natural_key,
        resolution=ForeignKeyResolution.BUNDLE_OR_EXISTING,
    )


def test_withholds_unresolved_composer_piece_and_all_dependents() -> None:
    seed_run = record(LoadTable.SEED_RUNS, RUN_ID)
    kept_piece = record(
        LoadTable.PIECES,
        "musicbrainz_work:kept",
        foreign_keys=(fk("composer_id", LoadTable.COMPOSERS, "musicbrainz_artist:known"),),
    )
    withheld_piece = record(
        LoadTable.PIECES,
        "musicbrainz_work:withheld",
        foreign_keys=(fk("composer_id", LoadTable.COMPOSERS, "musicbrainz_artist:missing"),),
    )
    withheld_alias = record(
        LoadTable.PIECE_ALIASES,
        "alias:withheld",
        foreign_keys=(fk("piece_id", LoadTable.PIECES, withheld_piece.natural_key),),
    )
    withheld_relation = record(
        LoadTable.PIECE_RELATIONS,
        "relation:kept-withheld",
        foreign_keys=(
            fk("from_piece_id", LoadTable.PIECES, kept_piece.natural_key),
            fk("to_piece_id", LoadTable.PIECES, withheld_piece.natural_key),
        ),
    )
    withheld_provenance = record(
        LoadTable.FIELD_PROVENANCE,
        "provenance:withheld",
        values={"target_table": "pieces", "target_id": withheld_piece.natural_key},
    )
    source_record = record(LoadTable.SOURCE_RECORDS, "source:withheld")
    composer = record(LoadTable.COMPOSERS, "musicbrainz_artist:known")

    result = build_publishable_work_bundle(
        work_manifest=manifest(SourceName.MUSICBRAINZ_WORKS, "a" * 64),
        work_records=[
            seed_run,
            kept_piece,
            withheld_piece,
            withheld_alias,
            withheld_relation,
            withheld_provenance,
            source_record,
        ],
        composer_bundles=[
            (manifest(SourceName.WIKIDATA, "b" * 64), [composer]),
        ],
    )

    identities = {(item.table, item.natural_key) for item in result.records}
    assert (LoadTable.PIECES, kept_piece.natural_key) in identities
    assert (LoadTable.PIECES, withheld_piece.natural_key) not in identities
    assert (LoadTable.PIECE_ALIASES, withheld_alias.natural_key) not in identities
    assert (LoadTable.PIECE_RELATIONS, withheld_relation.natural_key) not in identities
    assert (LoadTable.FIELD_PROVENANCE, withheld_provenance.natural_key) not in identities
    assert (LoadTable.SOURCE_RECORDS, source_record.natural_key) in identities
    reviews = [item for item in result.records if item.table is LoadTable.REVIEW_QUEUE]
    assert len(reviews) == 1
    assert reviews[0].values["reason_code"] == "WORK_COMPOSER_UNAVAILABLE"
    assert reviews[0].values["evidence"] == {
        "composer_natural_key": "musicbrainz_artist:missing",
        "work_manifest_sha256": "a" * 64,
        "composer_manifest_sha256s": ["b" * 64],
    }
    assert result.retained_piece_count == 1
    assert result.withheld_piece_count == 1
    assert result.dropped_dependent_count == 3


def test_rejects_duplicate_composer_natural_keys_across_manifests() -> None:
    piece = record(
        LoadTable.PIECES,
        "musicbrainz_work:piece",
        foreign_keys=(fk("composer_id", LoadTable.COMPOSERS, "musicbrainz_artist:known"),),
    )
    composer = record(LoadTable.COMPOSERS, "musicbrainz_artist:known")
    with pytest.raises(ValueError, match="중복 natural key"):
        build_publishable_work_bundle(
            work_manifest=manifest(SourceName.MUSICBRAINZ_WORKS, "a" * 64),
            work_records=[piece],
            composer_bundles=[
                (manifest(SourceName.WIKIDATA, "b" * 64), [composer]),
                (manifest(SourceName.WIKIDATA, "c" * 64), [composer]),
            ],
        )
