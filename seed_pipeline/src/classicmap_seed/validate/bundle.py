from __future__ import annotations

from collections import Counter, defaultdict

from classicmap_seed.models import (
    CanonicalLoadRecord,
    DataOrigin,
    LoadTable,
    ValidationRuleCode,
    ValidationRuleResult,
    WritePolicy,
)

_ENTITY_TABLES = {
    LoadTable.AUTHORITY_ENTITIES,
    LoadTable.WORKS,
    LoadTable.RECORDINGS,
}


def validate_canonical_bundle(
    records: list[CanonicalLoadRecord],
    *,
    idempotent_mutation_count: int,
    example_limit: int,
) -> tuple[ValidationRuleResult, ...]:
    rules = (
        _artifact_integrity(records),
        _external_identifiers_unique(records, example_limit),
        _foreign_keys_present(records, example_limit),
        _no_name_only_auto_match(records, example_limit),
        _public_fields_have_provenance(records, example_limit),
        _streaming_isrc_matches(records, example_limit),
        _no_direct_album_work_links(records, example_limit),
        _manual_fields_are_protected(records, example_limit),
        _second_dry_run_is_zero(idempotent_mutation_count),
        _review_queue_is_empty(records, example_limit),
    )
    return rules


def _artifact_integrity(records: list[CanonicalLoadRecord]) -> ValidationRuleResult:
    return _result(ValidationRuleCode.ARTIFACT_INTEGRITY, len(records), [])


def _external_identifiers_unique(
    records: list[CanonicalLoadRecord],
    example_limit: int,
) -> ValidationRuleResult:
    identifiers = [
        record
        for record in records
        if record.table in {LoadTable.EXTERNAL_IDENTIFIERS, LoadTable.PLATFORM_LINKS}
    ]
    entity_ids_by_key: dict[str, set[str]] = defaultdict(set)
    counts: Counter[str] = Counter()
    for record in identifiers:
        entity_id = _string(record, "entity_id")
        counts[record.natural_key] += 1
        if entity_id is not None:
            entity_ids_by_key[record.natural_key].add(entity_id)
    violations = [
        key for key, count in counts.items() if count > 1 or len(entity_ids_by_key[key]) > 1
    ]
    return _result(
        ValidationRuleCode.EXTERNAL_ID_UNIQUE,
        len(identifiers),
        violations,
        example_limit,
    )


def _foreign_keys_present(
    records: list[CanonicalLoadRecord],
    example_limit: int,
) -> ValidationRuleResult:
    entity_ids = {record.natural_key for record in records if record.table in _ENTITY_TABLES}
    snapshot_ids = {
        record.natural_key for record in records if record.table is LoadTable.SOURCE_SNAPSHOTS
    }
    track_ids = {
        record.natural_key for record in records if record.table is LoadTable.RECORDING_TRACKS
    }
    violations: list[str] = []
    checked = 0
    for record in records:
        if record.table in {LoadTable.EXTERNAL_IDENTIFIERS, LoadTable.FIELD_PROVENANCE}:
            checked += 1
            entity_id = _string(record, "entity_id")
            if entity_id is None or entity_id not in entity_ids:
                violations.append(f"{record.table}:{record.natural_key}:entity_id")
        elif record.table is LoadTable.SOURCE_RECORDS:
            checked += 1
            snapshot_id = _string(record, "snapshot_sha256")
            if snapshot_id is None or snapshot_id not in snapshot_ids:
                violations.append(f"source_records:{record.natural_key}:snapshot_sha256")
        elif record.table in {LoadTable.PLATFORM_LINKS, LoadTable.TRACK_PIECE_LINKS}:
            checked += 1
            track_id = _string(record, "track_id")
            if track_id is None or track_id not in track_ids:
                violations.append(f"{record.table}:{record.natural_key}:track_id")
    return _result(
        ValidationRuleCode.FOREIGN_KEYS_PRESENT,
        checked,
        violations,
        example_limit,
    )


def _no_name_only_auto_match(
    records: list[CanonicalLoadRecord],
    example_limit: int,
) -> ValidationRuleResult:
    entities = [record for record in records if record.table in _ENTITY_TABLES]
    violations: list[str] = []
    for record in entities:
        action = _string(record, "resolution_action")
        reason = _string(record, "resolution_reason_code")
        valid_create = action == "create" and reason == "NO_MATCHING_STABLE_IDENTIFIER"
        valid_auto_match = action == "auto_match" and reason == "SHARED_STRONG_EXTERNAL_IDENTIFIER"
        if not valid_create and not valid_auto_match:
            violations.append(record.natural_key)
    return _result(
        ValidationRuleCode.NO_NAME_ONLY_AUTO_MATCH,
        len(entities),
        violations,
        example_limit,
    )


def _public_fields_have_provenance(
    records: list[CanonicalLoadRecord],
    example_limit: int,
) -> ValidationRuleResult:
    entity_ids = {record.natural_key for record in records if record.table in _ENTITY_TABLES}
    provenance_fields: set[tuple[str, str]] = set()
    for record in records:
        if record.table is not LoadTable.FIELD_PROVENANCE:
            continue
        entity_id = _string(record, "entity_id")
        field_name = _string(record, "field_name")
        if entity_id is not None and field_name is not None:
            provenance_fields.add((entity_id, field_name))
    violations = [
        f"{entity_id}:preferred_name"
        for entity_id in entity_ids
        if (entity_id, "preferred_name") not in provenance_fields
    ]
    return _result(
        ValidationRuleCode.PUBLIC_FIELDS_HAVE_PROVENANCE,
        len(entity_ids),
        violations,
        example_limit,
    )


def _streaming_isrc_matches(
    records: list[CanonicalLoadRecord],
    example_limit: int,
) -> ValidationRuleResult:
    links = [record for record in records if record.table is LoadTable.PLATFORM_LINKS]
    violations: list[str] = []
    for record in links:
        source_isrc = _string(record, "source_isrc")
        target_isrc = _string(record, "target_isrc")
        storefront = _string(record, "storefront")
        checked_at = _string(record, "checked_at")
        match_status = _string(record, "match_status")
        if match_status == "auto_confirmed" and (
            source_isrc is None
            or target_isrc is None
            or source_isrc != target_isrc
            or storefront is None
            or checked_at is None
        ):
            violations.append(record.natural_key)
    return _result(
        ValidationRuleCode.STREAMING_ISRC_MATCH,
        len(links),
        violations,
        example_limit,
    )


def _no_direct_album_work_links(
    records: list[CanonicalLoadRecord],
    example_limit: int,
) -> ValidationRuleResult:
    violations: list[str] = []
    checked = 0
    for record in records:
        if record.table is LoadTable.WORKS:
            checked += 1
            forbidden_fields = {"spotify_url", "apple_music_url", "album_id"}
            if forbidden_fields.intersection(record.values):
                violations.append(record.natural_key)
        elif record.table is LoadTable.PLATFORM_LINKS:
            checked += 1
            if _string(record, "target_type") != "recording_track":
                violations.append(record.natural_key)
    return _result(
        ValidationRuleCode.NO_DIRECT_ALBUM_WORK_LINK,
        checked,
        violations,
        example_limit,
    )


def _manual_fields_are_protected(
    records: list[CanonicalLoadRecord],
    example_limit: int,
) -> ValidationRuleResult:
    violations = [
        record.natural_key
        for record in records
        if record.origin is not DataOrigin.SEED
        or record.editor_locked
        or record.write_policy is not WritePolicy.PRESERVE_MANUAL_OR_LOCKED
    ]
    return _result(
        ValidationRuleCode.MANUAL_FIELD_PROTECTION,
        len(records),
        violations,
        example_limit,
    )


def _second_dry_run_is_zero(mutation_count: int) -> ValidationRuleResult:
    violations = [] if mutation_count == 0 else [f"mutation_count:{mutation_count}"]
    return _result(ValidationRuleCode.SECOND_DRY_RUN_ZERO, 1, violations)


def _review_queue_is_empty(
    records: list[CanonicalLoadRecord],
    example_limit: int,
) -> ValidationRuleResult:
    review_records = [record for record in records if record.table is LoadTable.REVIEW_QUEUE]
    return _result(
        ValidationRuleCode.REVIEW_QUEUE_EMPTY,
        len(review_records),
        [record.natural_key for record in review_records],
        example_limit,
    )


def _string(record: CanonicalLoadRecord, field: str) -> str | None:
    value = record.values.get(field)
    return value if isinstance(value, str) and value else None


def _result(
    rule: ValidationRuleCode,
    checked_count: int,
    violations: list[str],
    example_limit: int = 20,
) -> ValidationRuleResult:
    return ValidationRuleResult(
        rule=rule,
        passed=not violations,
        checked_count=checked_count,
        violation_count=len(violations),
        examples=tuple(sorted(violations)[:example_limit]),
    )
