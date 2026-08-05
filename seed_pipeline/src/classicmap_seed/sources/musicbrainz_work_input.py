from __future__ import annotations

from pathlib import Path

from classicmap_seed.artifacts import read_artifact
from classicmap_seed.models import (
    ArtifactStage,
    CanonicalLoadRecord,
    JsonValue,
    LoadTable,
    SourceRecord,
)


def read_verified_musicbrainz_artist_ids(manifest_path: Path) -> tuple[str, ...]:
    manifest, records = read_artifact(manifest_path, CanonicalLoadRecord)
    if manifest.stage is not ArtifactStage.CANONICAL:
        raise ValueError("artist manifest는 canonical artifact여야 합니다.")
    identifiers: set[str] = set()
    for record in records:
        if record.table is not LoadTable.EXTERNAL_IDENTIFIERS:
            continue
        if record.values.get("namespace") != "musicbrainz_artist":
            continue
        external_id = record.values.get("external_id")
        if not isinstance(external_id, str) or not external_id:
            continue
        if record.evidence.get("strength") != "strong":
            continue
        if not any(
            foreign_key.column == "authority_entity_id"
            and foreign_key.target_table is LoadTable.AUTHORITY_ENTITIES
            for foreign_key in record.foreign_keys
        ):
            continue
        identifiers.add(external_id)
    if not identifiers:
        raise ValueError("verified MusicBrainz artist ID가 없습니다.")
    return tuple(sorted(identifiers))


def merge_duplicate_work_records(records: list[SourceRecord]) -> list[SourceRecord]:
    merged: dict[str, SourceRecord] = {}
    for record in records:
        existing = merged.get(record.source_record_id)
        if existing is None:
            merged[record.source_record_id] = record
            continue
        existing_payload = dict(existing.payload)
        incoming_payload = dict(record.payload)
        existing_artists = _string_set(existing_payload.pop("browsed_artist_ids", []))
        incoming_artists = _string_set(incoming_payload.pop("browsed_artist_ids", []))
        if existing_payload != incoming_payload:
            raise ValueError(
                f"동일 MusicBrainz work MBID의 payload가 충돌합니다: {record.source_record_id}"
            )
        browsed_artist_ids: list[JsonValue] = []
        browsed_artist_ids.extend(sorted(existing_artists | incoming_artists))
        existing_payload["browsed_artist_ids"] = browsed_artist_ids
        merged[record.source_record_id] = existing.model_copy(update={"payload": existing_payload})
    return [merged[key] for key in sorted(merged)]


def _string_set(value: object) -> set[str]:
    if not isinstance(value, list):
        return set()
    return {item for item in value if isinstance(item, str) and item}
