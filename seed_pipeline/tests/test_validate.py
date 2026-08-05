from classicmap_seed.load import canonical_seed_run_id
from classicmap_seed.models import (
    CanonicalLoadRecord,
    ForeignKeyResolution,
    JsonObject,
    LoadForeignKey,
    LoadTable,
    ValidationRuleCode,
    ValidationRuleResult,
)
from classicmap_seed.validate import validate_canonical_bundle

_SEED_RUN_ID = canonical_seed_run_id("run-1")


def _fk(
    column: str,
    table: LoadTable,
    natural_key: str,
    resolution: ForeignKeyResolution = ForeignKeyResolution.BUNDLE,
) -> LoadForeignKey:
    return LoadForeignKey(
        column=column,
        target_table=table,
        target_natural_key=natural_key,
        resolution=resolution,
    )


def _record(
    table: LoadTable,
    natural_key: str,
    values: JsonObject,
    *,
    foreign_keys: tuple[LoadForeignKey, ...] = (),
    evidence: JsonObject | None = None,
) -> CanonicalLoadRecord:
    return CanonicalLoadRecord(
        seed_run_id=_SEED_RUN_ID,
        table=table,
        natural_key=natural_key,
        values=values,
        foreign_keys=foreign_keys,
        evidence=evidence or {},
    )


def _valid_records() -> list[CanonicalLoadRecord]:
    return [
        _record(
            LoadTable.SEED_RUNS,
            _SEED_RUN_ID,
            {
                "id": _SEED_RUN_ID,
                "run_kind": "global_seed",
                "command": "test",
                "status": "PENDING",
                "dry_run": True,
            },
        ),
        _record(
            LoadTable.SOURCE_SNAPSHOTS,
            "wikidata:snapshot-1",
            {"sha256": "a" * 64},
            foreign_keys=(_fk("seed_run_id", LoadTable.SEED_RUNS, _SEED_RUN_ID),),
        ),
        _record(
            LoadTable.SOURCE_RECORDS,
            "wikidata:snapshot-1:Q1",
            {"source_record_id": "Q1", "entity_type": "person"},
            foreign_keys=(_fk("snapshot_id", LoadTable.SOURCE_SNAPSHOTS, "wikidata:snapshot-1"),),
        ),
        _record(
            LoadTable.AUTHORITY_ENTITIES,
            "entity-1",
            {"entity_kind": "person", "editorial_status": "IDENTIFIERS_MATCHED"},
            foreign_keys=(
                _fk(
                    "canonical_source_record_id",
                    LoadTable.SOURCE_RECORDS,
                    "wikidata:snapshot-1:Q1",
                ),
            ),
            evidence={
                "resolution_action": "create",
                "resolution_reason_code": "NO_MATCHING_STABLE_IDENTIFIER",
            },
        ),
        _record(
            LoadTable.EXTERNAL_IDENTIFIERS,
            "wikidata:Q1",
            {"namespace": "wikidata", "external_id": "Q1"},
            foreign_keys=(
                _fk("authority_entity_id", LoadTable.AUTHORITY_ENTITIES, "entity-1"),
                _fk("source_record_id", LoadTable.SOURCE_RECORDS, "wikidata:snapshot-1:Q1"),
            ),
        ),
        _record(
            LoadTable.FIELD_PROVENANCE,
            "authority_entities:entity-1:canonical_name:wikidata:Q1",
            {
                "target_table": "authority_entities",
                "target_id": "entity-1",
                "field_name": "canonical_name",
            },
            foreign_keys=(
                _fk("seed_run_id", LoadTable.SEED_RUNS, _SEED_RUN_ID),
                _fk("source_record_id", LoadTable.SOURCE_RECORDS, "wikidata:snapshot-1:Q1"),
            ),
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
            {"namespace": "wikidata", "external_id": "Q1"},
            foreign_keys=(
                _fk("authority_entity_id", LoadTable.AUTHORITY_ENTITIES, "missing-entity"),
            ),
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
        {"entity_kind": "person"},
        evidence={
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
                "recording-1:track-1",
                {"track_key": "track-1", "isrc": "USAAA0000001"},
                foreign_keys=(
                    _fk(
                        "recording_id",
                        LoadTable.RECORDINGS,
                        "recording-1",
                        ForeignKeyResolution.BUNDLE_OR_EXISTING,
                    ),
                ),
            ),
            _record(
                LoadTable.PLATFORM_LINKS,
                "spotify:KR:track-1",
                {
                    "platform": "spotify",
                    "platform_id": "track-1",
                    "storefront": "KR",
                    "verified_at": "2026-08-05T00:00:00Z",
                },
                foreign_keys=(_fk("piece_id", LoadTable.PIECES, "piece-1"),),
                evidence={
                    "source_isrc": "USAAA0000001",
                    "target_isrc": "USAAA0000002",
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
