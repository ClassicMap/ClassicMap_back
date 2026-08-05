from classicmap_seed.models import (
    CanonicalLoadRecord,
    LoadTable,
    ValidationRuleCode,
    ValidationRuleResult,
)
from classicmap_seed.validate import validate_canonical_bundle


def _record(
    table: LoadTable,
    natural_key: str,
    values: dict[str, str],
) -> CanonicalLoadRecord:
    return CanonicalLoadRecord(table=table, natural_key=natural_key, values=values)


def _valid_records() -> list[CanonicalLoadRecord]:
    return [
        _record(
            LoadTable.SEED_RUNS,
            "run-1",
            {"run_id": "run-1", "status": "DISCOVERED"},
        ),
        _record(
            LoadTable.SOURCE_SNAPSHOTS,
            "snapshot-1",
            {"sha256": "snapshot-1"},
        ),
        _record(
            LoadTable.SOURCE_RECORDS,
            "wikidata:Q1",
            {"snapshot_sha256": "snapshot-1", "candidate_id": "candidate-1"},
        ),
        _record(
            LoadTable.AUTHORITY_ENTITIES,
            "entity-1",
            {
                "preferred_name": "Composer",
                "resolution_action": "create",
                "resolution_reason_code": "NO_MATCHING_STABLE_IDENTIFIER",
            },
        ),
        _record(
            LoadTable.EXTERNAL_IDENTIFIERS,
            "wikidata:Q1",
            {"entity_id": "entity-1", "namespace": "wikidata", "value": "Q1"},
        ),
        _record(
            LoadTable.FIELD_PROVENANCE,
            "entity-1:preferred_name:wikidata:Q1",
            {"entity_id": "entity-1", "field_name": "preferred_name"},
        ),
    ]


def _rule(
    records: list[CanonicalLoadRecord],
    code: ValidationRuleCode,
) -> ValidationRuleResult:
    rules = validate_canonical_bundle(
        records,
        idempotent_mutation_count=0,
        example_limit=10,
    )
    return next(rule for rule in rules if rule.rule is code)


def test_valid_bundle_passes_every_rule() -> None:
    rules = validate_canonical_bundle(
        _valid_records(),
        idempotent_mutation_count=0,
        example_limit=10,
    )

    assert all(rule.passed for rule in rules)


def test_duplicate_external_identifier_and_orphan_are_blocking() -> None:
    records = _valid_records()
    records.append(
        _record(
            LoadTable.EXTERNAL_IDENTIFIERS,
            "wikidata:Q1",
            {"entity_id": "missing-entity", "namespace": "wikidata", "value": "Q1"},
        )
    )

    assert _rule(records, ValidationRuleCode.EXTERNAL_ID_UNIQUE).passed is False
    assert _rule(records, ValidationRuleCode.FOREIGN_KEYS_PRESENT).passed is False


def test_name_only_auto_match_and_missing_provenance_are_blocking() -> None:
    records = [
        record for record in _valid_records() if record.table is not LoadTable.FIELD_PROVENANCE
    ]
    entity_index = next(
        index
        for index, record in enumerate(records)
        if record.table is LoadTable.AUTHORITY_ENTITIES
    )
    records[entity_index] = _record(
        LoadTable.AUTHORITY_ENTITIES,
        "entity-1",
        {
            "preferred_name": "Composer",
            "resolution_action": "auto_match",
            "resolution_reason_code": "NAME_ONLY_MATCH_FORBIDDEN",
        },
    )

    assert _rule(records, ValidationRuleCode.NO_NAME_ONLY_AUTO_MATCH).passed is False
    assert _rule(records, ValidationRuleCode.PUBLIC_FIELDS_HAVE_PROVENANCE).passed is False


def test_streaming_isrc_mismatch_and_direct_work_link_are_blocking() -> None:
    records = _valid_records()
    records.extend(
        [
            _record(
                LoadTable.RECORDING_TRACKS,
                "track-1",
                {"id": "track-1", "isrc": "USAAA0000001"},
            ),
            _record(
                LoadTable.PLATFORM_LINKS,
                "spotify:KR:track-1",
                {
                    "track_id": "track-1",
                    "target_type": "work",
                    "source_isrc": "USAAA0000001",
                    "target_isrc": "USAAA0000002",
                    "storefront": "KR",
                    "checked_at": "2026-08-05T00:00:00Z",
                    "match_status": "auto_confirmed",
                },
            ),
        ]
    )

    assert _rule(records, ValidationRuleCode.STREAMING_ISRC_MATCH).passed is False
    assert _rule(records, ValidationRuleCode.NO_DIRECT_ALBUM_WORK_LINK).passed is False


def test_nonzero_second_dry_run_is_blocking() -> None:
    rules = validate_canonical_bundle(
        _valid_records(),
        idempotent_mutation_count=3,
        example_limit=10,
    )
    rule = next(rule for rule in rules if rule.rule is ValidationRuleCode.SECOND_DRY_RUN_ZERO)

    assert rule.passed is False
    assert rule.examples == ("mutation_count:3",)
