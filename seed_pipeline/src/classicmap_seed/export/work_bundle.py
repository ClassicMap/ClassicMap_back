from __future__ import annotations

from dataclasses import dataclass
from typing import Final

from classicmap_seed.models import (
    CanonicalLoadRecord,
    ForeignKeyResolution,
    JsonObject,
    LoadForeignKey,
    LoadTable,
    SnapshotManifest,
)

_COMPOSER_FK_COLUMN: Final = "composer_id"


@dataclass(frozen=True, slots=True)
class PublishableWorkBundleResult:
    records: tuple[CanonicalLoadRecord, ...]
    retained_piece_count: int
    withheld_piece_count: int
    dropped_dependent_count: int


def build_publishable_work_bundle(
    *,
    work_manifest: SnapshotManifest,
    work_records: list[CanonicalLoadRecord],
    composer_bundles: list[tuple[SnapshotManifest, list[CanonicalLoadRecord]]],
) -> PublishableWorkBundleResult:
    if not composer_bundles:
        raise ValueError("composer canonical manifest를 하나 이상 제공해야 합니다.")
    known_composer_keys = _known_composer_keys(composer_bundles)
    pieces = [record for record in work_records if record.table is LoadTable.PIECES]
    if not pieces:
        raise ValueError("work canonical bundle에 pieces 행이 없습니다.")

    composer_key_by_piece: dict[str, str] = {}
    for piece in pieces:
        composer_foreign_keys = [
            foreign_key
            for foreign_key in piece.foreign_keys
            if foreign_key.column == _COMPOSER_FK_COLUMN
            and foreign_key.target_table is LoadTable.COMPOSERS
        ]
        if len(composer_foreign_keys) != 1:
            raise ValueError(
                f"piece는 정확히 한 composer_id 외래키를 가져야 합니다: {piece.natural_key}"
            )
        composer_key_by_piece[piece.natural_key] = composer_foreign_keys[0].target_natural_key

    withheld_piece_keys = {
        piece_key
        for piece_key, composer_key in composer_key_by_piece.items()
        if composer_key not in known_composer_keys
    }
    dropped_identities: set[tuple[LoadTable, str]] = {
        (LoadTable.PIECES, piece_key) for piece_key in withheld_piece_keys
    }
    retained: list[CanonicalLoadRecord] = []
    dropped_dependent_count = 0

    changed = True
    while changed:
        changed = False
        for record in work_records:
            identity = (record.table, record.natural_key)
            if identity in dropped_identities:
                continue
            if _targets_dropped_identity(record, dropped_identities) or _is_dropped_provenance(
                record, withheld_piece_keys
            ):
                dropped_identities.add(identity)
                dropped_dependent_count += 1
                changed = True

    for record in work_records:
        if (record.table, record.natural_key) not in dropped_identities:
            retained.append(record)

    seed_run_id = _single_seed_run_id(work_records)
    composer_manifest_sha256s = sorted(manifest.sha256 for manifest, _ in composer_bundles)
    for piece_key in sorted(withheld_piece_keys):
        composer_key = composer_key_by_piece[piece_key]
        retained.append(
            CanonicalLoadRecord(
                seed_run_id=seed_run_id,
                table=LoadTable.REVIEW_QUEUE,
                natural_key=f"work-composer-unavailable:{piece_key}",
                values={
                    "seed_run_id": seed_run_id,
                    "target_type": "piece",
                    "target_id": piece_key,
                    "reason_code": "WORK_COMPOSER_UNAVAILABLE",
                    "status": "OPEN",
                    "evidence": {
                        "composer_natural_key": composer_key,
                        "work_manifest_sha256": work_manifest.sha256,
                        "composer_manifest_sha256s": composer_manifest_sha256s,
                    },
                },
                foreign_keys=(
                    LoadForeignKey(
                        column="seed_run_id",
                        target_table=LoadTable.SEED_RUNS,
                        target_natural_key=seed_run_id,
                        resolution=ForeignKeyResolution.BUNDLE,
                    ),
                ),
                evidence={
                    "selection_policy": "exact_composer_natural_key_v1",
                    "work_manifest_sha256": work_manifest.sha256,
                    "composer_manifest_sha256s": composer_manifest_sha256s,
                },
            )
        )

    return PublishableWorkBundleResult(
        records=tuple(sorted(retained, key=lambda record: (record.table, record.natural_key))),
        retained_piece_count=len(pieces) - len(withheld_piece_keys),
        withheld_piece_count=len(withheld_piece_keys),
        dropped_dependent_count=dropped_dependent_count,
    )


def _known_composer_keys(
    composer_bundles: list[tuple[SnapshotManifest, list[CanonicalLoadRecord]]],
) -> set[str]:
    known: set[str] = set()
    for manifest, records in composer_bundles:
        bundle_keys = {
            record.natural_key for record in records if record.table is LoadTable.COMPOSERS
        }
        duplicates = known.intersection(bundle_keys)
        if duplicates:
            example = sorted(duplicates)[0]
            raise ValueError(
                "composer canonical manifest 사이에 중복 natural key가 있습니다: "
                f"{example} ({manifest.sha256})"
            )
        known.update(bundle_keys)
    return known


def _targets_dropped_identity(
    record: CanonicalLoadRecord,
    dropped_identities: set[tuple[LoadTable, str]],
) -> bool:
    return any(
        (foreign_key.target_table, foreign_key.target_natural_key) in dropped_identities
        for foreign_key in record.foreign_keys
    )


def _is_dropped_provenance(
    record: CanonicalLoadRecord,
    withheld_piece_keys: set[str],
) -> bool:
    if record.table is not LoadTable.FIELD_PROVENANCE:
        return False
    values: JsonObject = record.values
    return (
        values.get("target_table") == LoadTable.PIECES.value
        and values.get("target_id") in withheld_piece_keys
    )


def _single_seed_run_id(records: list[CanonicalLoadRecord]) -> str:
    seed_run_ids = {record.seed_run_id for record in records}
    if len(seed_run_ids) != 1:
        raise ValueError("work canonical bundle은 정확히 한 seed_run_id를 가져야 합니다.")
    return next(iter(seed_run_ids))
