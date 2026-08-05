from datetime import UTC, datetime
from pathlib import Path

from classicmap_seed.artifacts import JsonlArtifactStore
from classicmap_seed.export import build_canonical_load_bundle
from classicmap_seed.load import can_apply_seed_value
from classicmap_seed.models import (
    ArtifactStage,
    DataOrigin,
    EntityKind,
    ExistingFieldState,
    ExternalIdentifier,
    IdentifierStrength,
    LoadTable,
    NormalizedEntityCandidate,
    ResolutionAction,
    ResolutionDecision,
    SnapshotManifest,
    SourceMetadata,
    SourceName,
    SourceRecord,
    WritePolicy,
)
from classicmap_seed.normalize import normalize_records
from classicmap_seed.projection_overrides import (
    ProjectionOverrideRecord,
    ProjectionOverrideSet,
    projection_override_fingerprint,
)


def _manifest() -> SnapshotManifest:
    digest = "a" * 64
    return SnapshotManifest(
        run_id="run-1",
        stage=ArtifactStage.RAW,
        source=SourceName.WIKIDATA,
        snapshot_id=digest,
        retrieved_at=datetime(2026, 8, 5, tzinfo=UTC),
        source_uri="https://query.wikidata.org/sparql",
        license="CC0-1.0",
        license_uri="https://www.wikidata.org/wiki/Wikidata:Licensing",
        sha256=digest,
        row_count=1,
        relative_data_path=f"{digest}.jsonl",
        tool_version="test",
    )


def _raw(kind: EntityKind = EntityKind.PERSON) -> SourceRecord:
    return SourceRecord(
        source=SourceName.WIKIDATA,
        source_record_id="Q255",
        entity_kind=kind,
        payload={"name": "Ludwig van Beethoven", "date_of_birth": "1770-12-17"},
    )


def _candidate(kind: EntityKind = EntityKind.PERSON) -> NormalizedEntityCandidate:
    return normalize_records([_raw(kind)])[0]


def test_canonical_bundle_is_deterministic_and_preserves_manual_fields() -> None:
    candidate = _candidate()
    decision = ResolutionDecision(
        decision_id="decision-1",
        action=ResolutionAction.CREATE,
        candidate_ids=(candidate.candidate_id,),
        reason_code="NO_MATCHING_STABLE_IDENTIFIER",
    )

    first = build_canonical_load_bundle(
        run_id="run-1",
        source_manifest=_manifest(),
        raw_records=[_raw()],
        candidates=[candidate],
        decisions=[decision],
    )
    second = build_canonical_load_bundle(
        run_id="run-1",
        source_manifest=_manifest(),
        raw_records=[_raw()],
        candidates=[candidate],
        decisions=[decision],
    )

    assert first == second
    assert all(record.origin is DataOrigin.SEED for record in first)
    assert all(record.editor_locked is False for record in first)
    assert all(record.write_policy is WritePolicy.PRESERVE_MANUAL_OR_LOCKED for record in first)
    assert any(record.table is LoadTable.AUTHORITY_ENTITIES for record in first)
    assert any(record.table is LoadTable.FIELD_PROVENANCE for record in first)


def test_review_decision_does_not_create_canonical_entity() -> None:
    candidate = _candidate()
    decision = ResolutionDecision(
        decision_id="decision-review",
        action=ResolutionAction.REVIEW_REQUIRED,
        candidate_ids=(candidate.candidate_id,),
        reason_code="NAME_ONLY_MATCH_FORBIDDEN",
    )

    bundle = build_canonical_load_bundle(
        run_id="run-1",
        source_manifest=_manifest(),
        raw_records=[_raw()],
        candidates=[candidate],
        decisions=[decision],
    )

    assert any(record.table is LoadTable.REVIEW_QUEUE for record in bundle)
    assert not any(record.table is LoadTable.AUTHORITY_ENTITIES for record in bundle)


def test_second_export_dry_run_is_byte_identical_and_zero_mutation(tmp_path: Path) -> None:
    candidate = _candidate()
    decision = ResolutionDecision(
        decision_id="decision-idempotent",
        action=ResolutionAction.CREATE,
        candidate_ids=(candidate.candidate_id,),
        reason_code="NO_MATCHING_STABLE_IDENTIFIER",
    )
    bundle = build_canonical_load_bundle(
        run_id="run-1",
        source_manifest=_manifest(),
        raw_records=[_raw()],
        candidates=[candidate],
        decisions=[decision],
    )
    store = JsonlArtifactStore(tmp_path, tool_version="test")
    first = store.write(
        run_id="run-1",
        stage=ArtifactStage.CANONICAL,
        metadata=SourceMetadata(
            source=SourceName.WIKIDATA,
            source_uri="https://query.wikidata.org/sparql",
            license="CC0-1.0",
            license_uri="https://www.wikidata.org/wiki/Wikidata:Licensing",
        ),
        records=bundle,
        retrieved_at=datetime(2026, 8, 5, tzinfo=UTC),
        dry_run=False,
        resume=True,
    )
    second = store.write(
        run_id="run-1",
        stage=ArtifactStage.CANONICAL,
        metadata=SourceMetadata(
            source=SourceName.WIKIDATA,
            source_uri="https://query.wikidata.org/sparql",
            license="CC0-1.0",
            license_uri="https://www.wikidata.org/wiki/Wikidata:Licensing",
        ),
        records=bundle,
        retrieved_at=datetime(2026, 8, 6, tzinfo=UTC),
        dry_run=True,
        resume=True,
    )

    assert first.manifest.sha256 == second.manifest.sha256
    assert second.mutation_count == 0


def test_unmapped_work_and_recording_are_review_only() -> None:
    for kind in (EntityKind.WORK, EntityKind.RECORDING):
        candidate = _candidate(kind)
        decision = ResolutionDecision(
            decision_id=f"decision-{kind}",
            action=ResolutionAction.CREATE,
            candidate_ids=(candidate.candidate_id,),
            reason_code="NO_MATCHING_STABLE_IDENTIFIER",
        )
        bundle = build_canonical_load_bundle(
            run_id="run-1",
            source_manifest=_manifest(),
            raw_records=[_raw(kind)],
            candidates=[candidate],
            decisions=[decision],
        )
        assert any(record.table is LoadTable.REVIEW_QUEUE for record in bundle)
        assert not any(
            record.table in {LoadTable.PIECES, LoadTable.RECORDINGS} for record in bundle
        )


def test_localized_names_and_verified_composer_projection_use_real_db_fields() -> None:
    raw = _wikidata_projection_raw(scope="composers")
    candidate = normalize_records([raw])[0]
    decision = ResolutionDecision(
        decision_id="decision-composer-projection",
        action=ResolutionAction.CREATE,
        candidate_ids=(candidate.candidate_id,),
        reason_code="NO_MATCHING_STABLE_IDENTIFIER",
    )
    bundle = build_canonical_load_bundle(
        run_id="run-1",
        source_manifest=_manifest(),
        raw_records=[raw],
        candidates=[candidate],
        decisions=[decision],
    )

    names = [record for record in bundle if record.table is LoadTable.ENTITY_NAMES]
    assert {(record.values["locale"], record.values["name_value"]) for record in names} >= {
        ("en", "Ludwig van Beethoven"),
        ("ko", "루트비히 판 베토벤"),
    }
    composer = next(record for record in bundle if record.table is LoadTable.COMPOSERS)
    assert composer.natural_key == "musicbrainz_artist:mbid-beethoven"
    assert composer.values["name"] == "루트비히 판 베토벤"
    assert composer.values["nationality"] == "독일"
    assert composer.values["period"] == "고전주의"
    assert "avatar_url" not in composer.values
    assert composer.evidence["derived_fields"] == {
        "period": {"rule": "birth_year_boundaries_v1", "birth_year": 1770}
    }


def test_verified_performer_projection_requires_instrument_and_country_labels() -> None:
    raw = _wikidata_projection_raw(scope="performers")
    candidate = normalize_records([raw])[0]
    decision = ResolutionDecision(
        decision_id="decision-artist-projection",
        action=ResolutionAction.CREATE,
        candidate_ids=(candidate.candidate_id,),
        reason_code="NO_MATCHING_STABLE_IDENTIFIER",
    )
    bundle = build_canonical_load_bundle(
        run_id="run-1",
        source_manifest=_manifest(),
        raw_records=[raw],
        candidates=[candidate],
        decisions=[decision],
    )

    artist = next(record for record in bundle if record.table is LoadTable.ARTISTS)
    assert artist.natural_key == "musicbrainz_artist:mbid-beethoven"
    assert artist.values["category"] == "피아노"
    assert artist.values["nationality"] == "독일"
    assert "image_url" not in artist.values


def test_single_iso_country_link_selects_matching_label_among_historical_qids() -> None:
    raw = _wikidata_projection_raw(scope="composers")
    payload = dict(raw.payload)
    payload["country_entity_ids"] = ["Q183", "Q123456"]
    payload["country_labels"] = [
        {"code": "Q183", "locale": "en", "name": "Germany"},
        {"code": "Q183", "locale": "ko", "name": "독일"},
        {"code": "Q123456", "locale": "en", "name": "Historical state"},
        {"code": "Q123456", "locale": "ko", "name": "역사적 국가"},
    ]
    linked_raw = raw.model_copy(update={"payload": payload})
    candidate = normalize_records([linked_raw])[0]
    decision = ResolutionDecision(
        decision_id="decision-country-link",
        action=ResolutionAction.CREATE,
        candidate_ids=(candidate.candidate_id,),
        reason_code="NO_MATCHING_STABLE_IDENTIFIER",
    )

    bundle = build_canonical_load_bundle(
        run_id="run-country-link",
        source_manifest=_manifest(),
        raw_records=[linked_raw],
        candidates=[candidate],
        decisions=[decision],
    )

    composer = next(record for record in bundle if record.table is LoadTable.COMPOSERS)
    assert composer.values["nationality"] == "독일"


def test_multiple_iso_country_codes_keep_legacy_projection_in_review() -> None:
    raw = _wikidata_projection_raw(scope="composers")
    payload = dict(raw.payload)
    payload["country_codes"] = ["DE", "PL"]
    payload["country_code_links"] = [
        {"country_code": "DE", "country_entity_id": "Q183"},
        {"country_code": "PL", "country_entity_id": "Q36"},
    ]
    payload["country_entity_ids"] = ["Q183", "Q36"]
    payload["country_labels"] = [
        {"code": "Q183", "locale": "ko", "name": "독일"},
        {"code": "Q36", "locale": "ko", "name": "폴란드"},
    ]
    ambiguous_raw = raw.model_copy(update={"payload": payload})
    candidate = normalize_records([ambiguous_raw])[0]
    decision = ResolutionDecision(
        decision_id="decision-country-ambiguous",
        action=ResolutionAction.CREATE,
        candidate_ids=(candidate.candidate_id,),
        reason_code="NO_MATCHING_STABLE_IDENTIFIER",
    )

    bundle = build_canonical_load_bundle(
        run_id="run-country-ambiguous",
        source_manifest=_manifest(),
        raw_records=[ambiguous_raw],
        candidates=[candidate],
        decisions=[decision],
    )

    assert not any(record.table is LoadTable.COMPOSERS for record in bundle)
    assert any(
        record.table is LoadTable.REVIEW_QUEUE
        and record.values["reason_code"] == "LEGACY_COMPOSER_REQUIRED_FIELDS_MISSING"
        for record in bundle
    )


def test_reviewed_nationality_override_creates_projection_and_manual_provenance() -> None:
    raw = _wikidata_projection_raw(scope="composers")
    payload = dict(raw.payload)
    payload["country_codes"] = ["DE", "PL"]
    payload["country_code_links"] = [
        {"country_code": "DE", "country_entity_id": "Q183"},
        {"country_code": "PL", "country_entity_id": "Q36"},
    ]
    ambiguous_raw = raw.model_copy(update={"payload": payload})
    candidate = normalize_records([ambiguous_raw])[0]
    decision = ResolutionDecision(
        decision_id="decision-country-manual-override",
        action=ResolutionAction.CREATE,
        candidate_ids=(candidate.candidate_id,),
        reason_code="NO_MATCHING_STABLE_IDENTIFIER",
    )
    override_payload: dict[str, object] = {
        "contract_version": "projection-override-v1",
        "target": "composer",
        "wikidata_qid": "Q255",
        "field": "nationality",
        "value": "독일",
        "reviewer": "fixture-reviewer",
        "reviewed_at": "2026-08-05T00:00:00Z",
        "evidence_url": "https://www.wikidata.org/wiki/Q255",
        "evidence_note": "복수 국적 중 legacy 대표 표시값을 명시적으로 검수했습니다.",
    }
    override = ProjectionOverrideRecord.model_validate(
        {
            **override_payload,
            "record_fingerprint": projection_override_fingerprint(override_payload),
        }
    )
    overrides = ProjectionOverrideSet(records=(override,), input_sha256="b" * 64)

    bundle = build_canonical_load_bundle(
        run_id="run-country-manual-override",
        source_manifest=_manifest(),
        raw_records=[ambiguous_raw],
        candidates=[candidate],
        decisions=[decision],
        projection_overrides=overrides,
    )

    composer = next(record for record in bundle if record.table is LoadTable.COMPOSERS)
    assert composer.values["nationality"] == "독일"
    assert composer.evidence["manual_projection_override"] == {
        **override_payload,
        "record_fingerprint": override.record_fingerprint,
        "input_sha256": "b" * 64,
    }
    provenance = next(
        record
        for record in bundle
        if record.table is LoadTable.FIELD_PROVENANCE
        and record.values.get("target_table") == "composers"
        and record.values.get("field_name") == "nationality"
    )
    assert provenance.values["origin"] == "seed"
    assert provenance.values["editorial_status"] == "EDITOR_REVIEWED"
    assert not any(
        record.table is LoadTable.REVIEW_QUEUE
        and record.values["reason_code"] == "LEGACY_COMPOSER_REQUIRED_FIELDS_MISSING"
        for record in bundle
    )


def test_birth_year_period_fallback_keeps_chopin_and_debussy_out_of_classical() -> None:
    for birth_year, expected_period in ((1810, "낭만주의"), (1862, "근현대")):
        raw = _wikidata_projection_raw(scope="composers")
        payload = dict(raw.payload)
        payload["date_of_birth"] = f"+{birth_year}-01-01T00:00:00Z"
        dated_raw = raw.model_copy(update={"payload": payload})
        candidate = normalize_records([dated_raw])[0]
        decision = ResolutionDecision(
            decision_id=f"decision-period-{birth_year}",
            action=ResolutionAction.CREATE,
            candidate_ids=(candidate.candidate_id,),
            reason_code="NO_MATCHING_STABLE_IDENTIFIER",
        )
        bundle = build_canonical_load_bundle(
            run_id=f"run-period-{birth_year}",
            source_manifest=_manifest(),
            raw_records=[dated_raw],
            candidates=[candidate],
            decisions=[decision],
        )
        composer = next(record for record in bundle if record.table is LoadTable.COMPOSERS)
        assert composer.values["period"] == expected_period


def test_missing_verified_legacy_fields_are_reviewed_without_fake_defaults() -> None:
    raw = _wikidata_projection_raw(scope="composers")
    payload = dict(raw.payload)
    payload["country_labels"] = []
    incomplete_raw = raw.model_copy(update={"payload": payload})
    candidate = normalize_records([incomplete_raw])[0]
    decision = ResolutionDecision(
        decision_id="decision-incomplete-projection",
        action=ResolutionAction.CREATE,
        candidate_ids=(candidate.candidate_id,),
        reason_code="NO_MATCHING_STABLE_IDENTIFIER",
    )
    bundle = build_canonical_load_bundle(
        run_id="run-1",
        source_manifest=_manifest(),
        raw_records=[incomplete_raw],
        candidates=[candidate],
        decisions=[decision],
    )

    assert not any(record.table is LoadTable.COMPOSERS for record in bundle)
    review = next(
        record
        for record in bundle
        if record.table is LoadTable.REVIEW_QUEUE
        and record.values["reason_code"] == "LEGACY_COMPOSER_REQUIRED_FIELDS_MISSING"
    )
    evidence = review.values["evidence"]
    assert isinstance(evidence, dict)
    missing_fields = evidence["missing_fields"]
    assert isinstance(missing_fields, list)
    assert "nationality" in missing_fields


def test_work_part_without_parent_piece_in_bundle_is_reviewed() -> None:
    raw = SourceRecord(
        source=SourceName.MUSICBRAINZ_WORKS,
        source_record_id="child-work",
        entity_kind=EntityKind.WORK,
        payload={"name": "I. Allegro"},
    )
    candidate = NormalizedEntityCandidate(
        candidate_id="child-candidate",
        source=SourceName.MUSICBRAINZ_WORKS,
        source_record_id="child-work",
        entity_kind=EntityKind.WORK,
        preferred_name="I. Allegro",
        normalized_name="i. allegro",
        external_identifiers=(
            ExternalIdentifier(
                namespace="musicbrainz_work",
                value="child-work",
                strength=IdentifierStrength.STRONG,
                source=SourceName.MUSICBRAINZ_WORKS,
            ),
        ),
        facts={
            "work_relations": [
                {
                    "relation_type": "parts",
                    "direction": "backward",
                    "target_work_id": "missing-parent",
                    "ordering_key": 1,
                }
            ]
        },
    )
    decision = ResolutionDecision(
        decision_id="decision-child-work",
        action=ResolutionAction.CREATE,
        candidate_ids=(candidate.candidate_id,),
        reason_code="NO_MATCHING_STABLE_IDENTIFIER",
    )
    bundle = build_canonical_load_bundle(
        run_id="run-1",
        source_manifest=_manifest(),
        raw_records=[raw],
        candidates=[candidate],
        decisions=[decision],
    )

    assert not any(record.table is LoadTable.PIECE_PARTS for record in bundle)
    assert any(
        record.table is LoadTable.REVIEW_QUEUE
        and record.values["reason_code"] == "WORK_PARENT_NOT_IN_BUNDLE"
        for record in bundle
    )


def test_work_aliases_with_same_locale_and_normalized_value_are_deduplicated() -> None:
    raw = SourceRecord(
        source=SourceName.MUSICBRAINZ_WORKS,
        source_record_id="work-with-duplicate-alias",
        entity_kind=EntityKind.WORK,
        payload={
            "name": "Adieu, mein kleiner Gardeoffizier",
            "localized_names": [
                {
                    "locale": "und",
                    "name_kind": "alias",
                    "name": "Adieu, mein kleiner Gardeoffizier",
                },
                {
                    "locale": "und",
                    "name_kind": "alias",
                    "name": "adieu, mein kleiner gardeoffizier",
                },
            ],
            "composer_mbids": ["composer-mbid"],
            "relations": [],
        },
    )
    candidate = normalize_records([raw])[0]
    decision = ResolutionDecision(
        decision_id="decision-duplicate-work-alias",
        action=ResolutionAction.CREATE,
        candidate_ids=(candidate.candidate_id,),
        reason_code="NO_MATCHING_STABLE_IDENTIFIER",
    )
    manifest = _manifest().model_copy(update={"source": SourceName.MUSICBRAINZ_WORKS})

    bundle = build_canonical_load_bundle(
        run_id="run-1",
        source_manifest=manifest,
        raw_records=[raw],
        candidates=[candidate],
        decisions=[decision],
    )
    aliases = [record for record in bundle if record.table is LoadTable.PIECE_ALIASES]

    assert len(aliases) == 1
    assert len({record.natural_key for record in aliases}) == 1


def _wikidata_projection_raw(*, scope: str) -> SourceRecord:
    return SourceRecord(
        source=SourceName.WIKIDATA,
        source_record_id="Q255",
        entity_kind=EntityKind.PERSON,
        payload={
            "id": "Q255",
            "name": "Ludwig van Beethoven",
            "scope": scope,
            "localized_names": [
                {"locale": "en", "name_kind": "canonical", "name": "Ludwig van Beethoven"},
                {"locale": "ko", "name_kind": "canonical", "name": "루트비히 판 베토벤"},
            ],
            "role_codes": ["Q36834"],
            "instrument_codes": ["Q5994"],
            "instrument_labels": [
                {"code": "Q5994", "locale": "en", "name": "piano"},
                {"code": "Q5994", "locale": "ko", "name": "피아노"},
            ],
            "country_codes": ["DE"],
            "country_code_links": [{"country_code": "DE", "country_entity_id": "Q183"}],
            "country_entity_ids": ["Q183"],
            "country_labels": [
                {"code": "Q183", "locale": "en", "name": "Germany"},
                {"code": "Q183", "locale": "ko", "name": "독일"},
            ],
            "commons_image_ids": ["Beethoven.jpg"],
            "external_identifiers": {
                "musicbrainz_artist": ["mbid-beethoven"],
                "gnd": ["118508288"],
                "viaf": ["32182557"],
                "isni": ["0000000121268987"],
            },
            "date_of_birth": "+1770-12-17T00:00:00Z",
            "date_of_death": "+1827-03-26T00:00:00Z",
        },
    )


def test_load_contract_blocks_manual_or_locked_fields() -> None:
    assert can_apply_seed_value(None) is True
    assert (
        can_apply_seed_value(
            ExistingFieldState(origin=DataOrigin.SEED, editor_locked=False),
        )
        is True
    )
    assert (
        can_apply_seed_value(
            ExistingFieldState(origin=DataOrigin.MANUAL, editor_locked=False),
        )
        is False
    )
    assert (
        can_apply_seed_value(
            ExistingFieldState(origin=DataOrigin.SEED, editor_locked=True),
        )
        is False
    )
