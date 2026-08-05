from __future__ import annotations

import hashlib
import json
import re
from collections.abc import Iterable
from uuid import NAMESPACE_URL, uuid5

from classicmap_seed.load import canonical_seed_run_id
from classicmap_seed.models import (
    CanonicalLoadRecord,
    EntityKind,
    ForeignKeyResolution,
    IdentifierStrength,
    JsonObject,
    JsonValue,
    LoadForeignKey,
    LoadTable,
    NormalizedEntityCandidate,
    ResolutionAction,
    ResolutionDecision,
    SnapshotManifest,
    SourceName,
    SourceRecord,
)
from classicmap_seed.projection_overrides import (
    ProjectionOverrideRecord,
    ProjectionOverrideSet,
    ProjectionTarget,
)

_AUTHORITY_KINDS = {
    EntityKind.PERSON,
    EntityKind.ENSEMBLE,
    EntityKind.ORCHESTRA,
    EntityKind.CHOIR,
    EntityKind.ORGANIZATION,
}


def build_canonical_load_bundle(
    *,
    run_id: str,
    source_manifest: SnapshotManifest,
    raw_records: list[SourceRecord],
    candidates: list[NormalizedEntityCandidate],
    decisions: list[ResolutionDecision],
    projection_overrides: ProjectionOverrideSet | None = None,
) -> list[CanonicalLoadRecord]:
    snapshot_key = f"{source_manifest.source}:{source_manifest.sha256}"
    raw_by_identity = {(record.source, record.source_record_id): record for record in raw_records}
    candidate_by_id = {candidate.candidate_id: candidate for candidate in candidates}
    source_key_by_candidate: dict[str, str] = {}
    available_work_mbids, work_parent_by_mbid = _work_hierarchy_index(candidates)
    records = _run_and_snapshot_records(run_id, source_manifest, snapshot_key)
    used_projection_overrides: set[tuple[ProjectionTarget, str, str]] = set()

    for candidate in sorted(candidates, key=lambda item: item.candidate_id):
        raw_record = raw_by_identity.get((candidate.source, candidate.source_record_id))
        if raw_record is None:
            raise ValueError(
                f"normalized candidate의 raw source record가 없습니다: {candidate.candidate_id}"
            )
        source_record_key = f"{snapshot_key}:{candidate.source_record_id}"
        source_key_by_candidate[candidate.candidate_id] = source_record_key
        records.append(
            _source_record(
                run_id,
                snapshot_key=snapshot_key,
                source_record_key=source_record_key,
                raw_record=raw_record,
            )
        )

    for decision in sorted(decisions, key=lambda item: item.decision_id):
        group = [
            candidate_by_id[candidate_id]
            for candidate_id in decision.candidate_ids
            if candidate_id in candidate_by_id
        ]
        if not group:
            continue
        if decision.action is ResolutionAction.REVIEW_REQUIRED:
            records.append(_review_record(run_id, decision, group))
            continue

        representative = _choose_representative(group)
        if representative.entity_kind in _AUTHORITY_KINDS:
            records.extend(
                _authority_records(
                    run_id,
                    group,
                    decision,
                    source_key_by_candidate,
                    projection_overrides,
                    used_projection_overrides,
                )
            )
        elif representative.entity_kind is EntityKind.WORK:
            if representative.source is SourceName.MUSICBRAINZ_DUMP:
                records.append(
                    _review_for_unsupported_entity(
                        run_id,
                        decision,
                        "MUSICBRAINZ_DUMP_WORK_RAW_ONLY",
                    )
                )
            else:
                records.extend(
                    _work_records(
                        run_id,
                        group,
                        decision,
                        source_key_by_candidate,
                        available_work_mbids,
                        work_parent_by_mbid,
                    )
                )
        elif representative.entity_kind is EntityKind.RECORDING:
            reason_code = (
                "MUSICBRAINZ_DUMP_RECORDING_RAW_ONLY"
                if representative.source is SourceName.MUSICBRAINZ_DUMP
                else "RECORDING_LOAD_NOT_MAPPED"
            )
            records.append(_review_for_unsupported_entity(run_id, decision, reason_code))
        else:
            records.append(_review_for_unsupported_entity(run_id, decision, "UNKNOWN_ENTITY_KIND"))

    if projection_overrides is not None:
        unused = {record.key for record in projection_overrides.records}.difference(
            used_projection_overrides
        )
        if unused:
            target, qid, field = sorted(
                unused,
                key=lambda key: (key[0].value, key[1], key[2]),
            )[0]
            raise ValueError(
                "projection override가 현재 resolved bundle의 누락 필드와 일치하지 않습니다: "
                f"{target.value}:{qid}:{field}"
            )
    return sorted(records, key=lambda record: (record.table, record.natural_key))


def _run_and_snapshot_records(
    run_id: str,
    source_manifest: SnapshotManifest,
    snapshot_key: str,
) -> list[CanonicalLoadRecord]:
    seed_run_id = canonical_seed_run_id(run_id)
    seed_run = _record(
        run_id,
        LoadTable.SEED_RUNS,
        seed_run_id,
        {
            "id": seed_run_id,
            "run_kind": "global_seed",
            "command": f"classicmap-seed export-canonical --run-id {run_id}",
            "status": "PENDING",
            "dry_run": False,
            "source_code_version": source_manifest.tool_version,
            "manifest": {
                "db_contract_version": "global-seed-v1",
                "run_slug": run_id,
                "source_snapshot_sha256": source_manifest.sha256,
            },
            "summary": {},
        },
    )
    snapshot = _record(
        run_id,
        LoadTable.SOURCE_SNAPSHOTS,
        snapshot_key,
        {
            "seed_run_id": seed_run_id,
            "source": source_manifest.source,
            "source_uri": source_manifest.source_uri,
            "retrieved_at": source_manifest.retrieved_at.isoformat(),
            "source_version": source_manifest.snapshot_id,
            "license": source_manifest.license,
            "sha256": source_manifest.sha256,
            "row_count": source_manifest.row_count,
            "tool_version": source_manifest.tool_version,
            "storage_path": (
                f"{run_id}/{source_manifest.stage}/{source_manifest.source}/"
                f"{source_manifest.relative_data_path}"
            ),
        },
        foreign_keys=(
            LoadForeignKey(
                column="seed_run_id",
                target_table=LoadTable.SEED_RUNS,
                target_natural_key=seed_run_id,
            ),
        ),
        evidence={"license_uri": source_manifest.license_uri},
    )
    return [seed_run, snapshot]


def _source_record(
    run_id: str,
    *,
    snapshot_key: str,
    source_record_key: str,
    raw_record: SourceRecord,
) -> CanonicalLoadRecord:
    payload_sha256 = _json_sha256(raw_record.payload)
    return _record(
        run_id,
        LoadTable.SOURCE_RECORDS,
        source_record_key,
        {
            "source_record_id": raw_record.source_record_id,
            "entity_type": raw_record.entity_kind,
            "payload_sha256": payload_sha256,
            "payload": raw_record.payload,
        },
        foreign_keys=(
            LoadForeignKey(
                column="snapshot_id",
                target_table=LoadTable.SOURCE_SNAPSHOTS,
                target_natural_key=snapshot_key,
            ),
        ),
    )


def _authority_records(
    run_id: str,
    candidates: list[NormalizedEntityCandidate],
    decision: ResolutionDecision,
    source_key_by_candidate: dict[str, str],
    projection_overrides: ProjectionOverrideSet | None,
    used_projection_overrides: set[tuple[ProjectionTarget, str, str]],
) -> list[CanonicalLoadRecord]:
    representative = _choose_representative(candidates)
    entity_id = _canonical_entity_id(candidates)
    source_record_key = source_key_by_candidate[representative.candidate_id]
    records = [
        _record(
            run_id,
            LoadTable.AUTHORITY_ENTITIES,
            entity_id,
            {
                "id": entity_id,
                "entity_kind": representative.entity_kind,
                "editorial_status": "IDENTIFIERS_MATCHED",
                "origin": "seed",
                "editor_locked": False,
            },
            foreign_keys=(
                LoadForeignKey(
                    column="canonical_source_record_id",
                    target_table=LoadTable.SOURCE_RECORDS,
                    target_natural_key=source_record_key,
                ),
            ),
            evidence={
                "resolution_action": decision.action,
                "resolution_reason_code": decision.reason_code,
                "candidate_ids": _json_strings(candidate.candidate_id for candidate in candidates),
            },
        )
    ]
    records.extend(_authority_name_records(run_id, entity_id, candidates, source_key_by_candidate))
    records.extend(_authority_fact_records(run_id, entity_id, candidates, source_key_by_candidate))
    records.extend(
        _authority_identifier_records(run_id, entity_id, candidates, source_key_by_candidate)
    )
    records.extend(
        _provenance_records(
            run_id,
            target_table=LoadTable.AUTHORITY_ENTITIES,
            target_id=entity_id,
            candidates=candidates,
            source_key_by_candidate=source_key_by_candidate,
        )
    )
    records.extend(
        _legacy_projection_records(
            run_id,
            entity_id,
            candidates,
            source_key_by_candidate,
            projection_overrides,
            used_projection_overrides,
        )
    )
    return records


def _authority_name_records(
    run_id: str,
    entity_id: str,
    candidates: list[NormalizedEntityCandidate],
    source_key_by_candidate: dict[str, str],
) -> list[CanonicalLoadRecord]:
    records: list[CanonicalLoadRecord] = []
    seen: set[tuple[str, str]] = set()
    for candidate in candidates:
        names = _localized_names(candidate)
        for locale, name_kind, name in names:
            normalized = name.casefold().strip()
            identity = (f"{locale}:{name_kind}", normalized)
            if identity in seen:
                continue
            seen.add(identity)
            natural_key = f"{entity_id}:{locale}:{name_kind}:{normalized}"
            records.append(
                _record(
                    run_id,
                    LoadTable.ENTITY_NAMES,
                    natural_key,
                    {
                        "locale": locale,
                        "name_kind": name_kind,
                        "name_value": name,
                        "normalized_value": normalized,
                        "is_preferred": name_kind == "canonical",
                        "origin": "seed",
                        "editor_locked": False,
                    },
                    foreign_keys=(
                        _fk("authority_entity_id", LoadTable.AUTHORITY_ENTITIES, entity_id),
                        _fk(
                            "source_record_id",
                            LoadTable.SOURCE_RECORDS,
                            source_key_by_candidate[candidate.candidate_id],
                        ),
                    ),
                )
            )
    return records


def _authority_fact_records(
    run_id: str,
    entity_id: str,
    candidates: list[NormalizedEntityCandidate],
    source_key_by_candidate: dict[str, str],
) -> list[CanonicalLoadRecord]:
    records: list[CanonicalLoadRecord] = []
    seen: set[tuple[LoadTable, str]] = set()
    for candidate in candidates:
        source_key = source_key_by_candidate[candidate.candidate_id]
        fact_specs = (
            ("role_codes", LoadTable.ENTITY_ROLES, "role_code"),
            ("instrument_codes", LoadTable.ENTITY_INSTRUMENTS, "instrument_code"),
            ("country_codes", LoadTable.ENTITY_COUNTRIES, "country_code"),
        )
        for fact_name, table, value_field in fact_specs:
            for value in _fact_strings(candidate, fact_name):
                identity = (table, value)
                if identity in seen:
                    continue
                seen.add(identity)
                values: JsonObject = {value_field: value}
                if table is LoadTable.ENTITY_ROLES or table is LoadTable.ENTITY_INSTRUMENTS:
                    values["is_primary"] = False
                else:
                    values["relation_type"] = "nationality"
                records.append(
                    _record(
                        run_id,
                        table,
                        f"{entity_id}:{value}",
                        values,
                        foreign_keys=(
                            _fk(
                                "authority_entity_id",
                                LoadTable.AUTHORITY_ENTITIES,
                                entity_id,
                            ),
                            _fk("source_record_id", LoadTable.SOURCE_RECORDS, source_key),
                        ),
                    )
                )
        for image_url in _fact_strings(candidate, "commons_image_urls"):
            identity = (LoadTable.ENTITY_IMAGES, image_url)
            if identity in seen:
                continue
            seen.add(identity)
            records.append(
                _record(
                    run_id,
                    LoadTable.ENTITY_IMAGES,
                    f"{entity_id}:{image_url}",
                    {
                        "image_kind": "profile",
                        "source_url": image_url,
                        "file_url": image_url,
                        "is_primary": False,
                        "editorial_status": "REVIEW_REQUIRED",
                    },
                    foreign_keys=(
                        _fk(
                            "authority_entity_id",
                            LoadTable.AUTHORITY_ENTITIES,
                            entity_id,
                        ),
                        _fk("source_record_id", LoadTable.SOURCE_RECORDS, source_key),
                    ),
                    evidence={"rights_status": "UNVERIFIED"},
                )
            )
    return records


def _authority_identifier_records(
    run_id: str,
    entity_id: str,
    candidates: list[NormalizedEntityCandidate],
    source_key_by_candidate: dict[str, str],
) -> list[CanonicalLoadRecord]:
    records: list[CanonicalLoadRecord] = []
    seen: set[tuple[str, str]] = set()
    for candidate in candidates:
        for identifier in candidate.external_identifiers:
            identity = (identifier.namespace, identifier.value)
            if identity in seen:
                continue
            seen.add(identity)
            natural_key = f"{identifier.namespace}:{identifier.value}"
            records.append(
                _record(
                    run_id,
                    LoadTable.EXTERNAL_IDENTIFIERS,
                    natural_key,
                    {
                        "namespace": identifier.namespace,
                        "external_id": identifier.value,
                    },
                    foreign_keys=(
                        _fk(
                            "authority_entity_id",
                            LoadTable.AUTHORITY_ENTITIES,
                            entity_id,
                        ),
                        _fk(
                            "source_record_id",
                            LoadTable.SOURCE_RECORDS,
                            source_key_by_candidate[candidate.candidate_id],
                        ),
                    ),
                    evidence={"strength": identifier.strength, "source": identifier.source},
                )
            )
    return records


def _localized_names(
    candidate: NormalizedEntityCandidate,
) -> tuple[tuple[str, str, str], ...]:
    localized = candidate.facts.get("localized_names")
    names: list[tuple[str, str, str]] = []
    if isinstance(localized, list):
        for value in localized:
            if not isinstance(value, dict):
                continue
            locale = _object_string(value, "locale")
            name_kind = _object_string(value, "name_kind")
            name = _object_string(value, "name")
            if (
                locale is not None
                and name_kind in {"canonical", "alias", "transliteration", "former"}
                and name is not None
            ):
                names.append((locale, name_kind, name))
    if names:
        return tuple(names)
    return (
        ("und", "canonical", candidate.preferred_name),
        *(("und", "alias", alias) for alias in candidate.aliases),
    )


def _legacy_projection_records(
    run_id: str,
    entity_id: str,
    candidates: list[NormalizedEntityCandidate],
    source_key_by_candidate: dict[str, str],
    projection_overrides: ProjectionOverrideSet | None,
    used_projection_overrides: set[tuple[ProjectionTarget, str, str]],
) -> list[CanonicalLoadRecord]:
    scopes = set(_all_fact_strings(candidates, "scope"))
    role_codes = set(_all_fact_strings(candidates, "role_codes"))
    is_composer = "composers" in scopes or "Q36834" in role_codes
    is_artist = bool(scopes.intersection({"performers", "ensembles"}))
    records: list[CanonicalLoadRecord] = []
    wikidata_qid = _unique_identifier(candidates, "wikidata")
    if is_composer:
        override = _nationality_override(
            projection_overrides,
            ProjectionTarget.COMPOSER,
            wikidata_qid,
            candidates,
            used_projection_overrides,
        )
        projection = _composer_projection_or_review(
            run_id,
            entity_id,
            candidates,
            source_key_by_candidate,
            override,
            projection_overrides,
        )
        records.append(projection)
        if override is not None and projection.table is LoadTable.COMPOSERS:
            records.append(
                _projection_override_provenance(
                    run_id,
                    projection,
                    candidates,
                    source_key_by_candidate,
                    override,
                    projection_overrides,
                )
            )
    if is_artist:
        override = _nationality_override(
            projection_overrides,
            ProjectionTarget.ARTIST,
            wikidata_qid,
            candidates,
            used_projection_overrides,
        )
        projection = _artist_projection_or_review(
            run_id,
            entity_id,
            candidates,
            source_key_by_candidate,
            override,
            projection_overrides,
        )
        records.append(projection)
        if override is not None and projection.table is LoadTable.ARTISTS:
            records.append(
                _projection_override_provenance(
                    run_id,
                    projection,
                    candidates,
                    source_key_by_candidate,
                    override,
                    projection_overrides,
                )
            )
    return records


def _composer_projection_or_review(
    run_id: str,
    entity_id: str,
    candidates: list[NormalizedEntityCandidate],
    source_key_by_candidate: dict[str, str],
    nationality_override: ProjectionOverrideRecord | None,
    projection_overrides: ProjectionOverrideSet | None,
) -> CanonicalLoadRecord:
    mbid = _unique_identifier(candidates, "musicbrainz_artist")
    name_en = _canonical_name(candidates, "en")
    name_ko = _canonical_name(candidates, "ko")
    display_name = name_ko or name_en
    birth_year = _year_from_fact(candidates, "date_of_birth")
    death_year = _year_from_fact(candidates, "date_of_death")
    nationality = _verified_country_name(candidates) or (
        nationality_override.value if nationality_override is not None else None
    )
    period = _period_from_birth_year(birth_year) if birth_year is not None else None
    missing = [
        field
        for field, value in (
            ("musicbrainz_artist", mbid),
            ("name", display_name),
            ("english_name", name_en),
            ("birth_year", birth_year),
            ("nationality", nationality),
            ("period", period),
        )
        if value is None
    ]
    if missing:
        return _projection_review(
            run_id,
            entity_id,
            "legacy_composer",
            "LEGACY_COMPOSER_REQUIRED_FIELDS_MISSING",
            missing,
        )
    representative = _choose_representative(candidates)
    values: JsonObject = {
        "name": display_name,
        "full_name": display_name,
        "english_name": name_en,
        "period": period,
        "birth_year": birth_year,
        "nationality": nationality,
        "origin": "seed",
        "editor_locked": False,
    }
    if death_year is not None:
        values["death_year"] = death_year
    evidence: JsonObject = {
        "derived_fields": {
            "period": {
                "rule": "birth_year_boundaries_v1",
                "birth_year": birth_year,
            }
        }
    }
    if nationality_override is not None and projection_overrides is not None:
        evidence["manual_projection_override"] = _override_evidence(
            nationality_override,
            projection_overrides,
        )
    return _record(
        run_id,
        LoadTable.COMPOSERS,
        f"musicbrainz_artist:{mbid}",
        values,
        foreign_keys=(
            _fk("authority_entity_id", LoadTable.AUTHORITY_ENTITIES, entity_id),
            _fk(
                "source_record_id",
                LoadTable.SOURCE_RECORDS,
                source_key_by_candidate[representative.candidate_id],
            ),
        ),
        evidence=evidence,
    )


def _artist_projection_or_review(
    run_id: str,
    entity_id: str,
    candidates: list[NormalizedEntityCandidate],
    source_key_by_candidate: dict[str, str],
    nationality_override: ProjectionOverrideRecord | None,
    projection_overrides: ProjectionOverrideSet | None,
) -> CanonicalLoadRecord:
    mbid = _unique_identifier(candidates, "musicbrainz_artist")
    name_en = _canonical_name(candidates, "en")
    name_ko = _canonical_name(candidates, "ko")
    display_name = name_ko or name_en
    nationality = _verified_country_name(candidates) or (
        nationality_override.value if nationality_override is not None else None
    )
    category = _verified_instrument_name(candidates)
    missing = [
        field
        for field, value in (
            ("musicbrainz_artist", mbid),
            ("name", display_name),
            ("english_name", name_en),
            ("category", category),
            ("nationality", nationality),
        )
        if value is None
    ]
    if missing:
        return _projection_review(
            run_id,
            entity_id,
            "legacy_artist",
            "LEGACY_ARTIST_REQUIRED_FIELDS_MISSING",
            missing,
        )
    representative = _choose_representative(candidates)
    values: JsonObject = {
        "name": display_name,
        "english_name": name_en,
        "category": category,
        "nationality": nationality,
        "origin": "seed",
        "editor_locked": False,
    }
    birth_year = _year_from_fact(candidates, "date_of_birth")
    if birth_year is not None:
        values["birth_year"] = str(birth_year)
    evidence: JsonObject = {}
    if nationality_override is not None and projection_overrides is not None:
        evidence["manual_projection_override"] = _override_evidence(
            nationality_override,
            projection_overrides,
        )
    return _record(
        run_id,
        LoadTable.ARTISTS,
        f"musicbrainz_artist:{mbid}",
        values,
        foreign_keys=(
            _fk("authority_entity_id", LoadTable.AUTHORITY_ENTITIES, entity_id),
            _fk(
                "source_record_id",
                LoadTable.SOURCE_RECORDS,
                source_key_by_candidate[representative.candidate_id],
            ),
        ),
        evidence=evidence,
    )


def _nationality_override(
    projection_overrides: ProjectionOverrideSet | None,
    target: ProjectionTarget,
    wikidata_qid: str | None,
    candidates: list[NormalizedEntityCandidate],
    used_projection_overrides: set[tuple[ProjectionTarget, str, str]],
) -> ProjectionOverrideRecord | None:
    if projection_overrides is None:
        return None
    override = projection_overrides.get(target, wikidata_qid, "nationality")
    if override is None:
        return None
    if _verified_country_name(candidates) is not None:
        raise ValueError(
            "검증된 nationality가 이미 있으므로 수동 projection override를 적용하지 않습니다: "
            f"{target.value}:{override.wikidata_qid}"
        )
    used_projection_overrides.add(override.key)
    return override


def _projection_override_provenance(
    run_id: str,
    projection: CanonicalLoadRecord,
    candidates: list[NormalizedEntityCandidate],
    source_key_by_candidate: dict[str, str],
    override: ProjectionOverrideRecord,
    projection_overrides: ProjectionOverrideSet | None,
) -> CanonicalLoadRecord:
    if projection_overrides is None:
        raise ValueError("projection override provenance에 입력 bundle 정보가 없습니다.")
    representative = _choose_representative(candidates)
    evidence = _override_evidence(override, projection_overrides)
    return _record(
        run_id,
        LoadTable.FIELD_PROVENANCE,
        (f"{projection.table.value}:{projection.natural_key}:nationality:manual-override"),
        {
            "seed_run_id": canonical_seed_run_id(run_id),
            "target_table": projection.table.value,
            "target_id": projection.natural_key,
            "field_name": "nationality",
            "origin": "manual",
            "editorial_status": "EDITOR_REVIEWED",
            "evidence": evidence,
        },
        foreign_keys=(
            _fk("seed_run_id", LoadTable.SEED_RUNS, canonical_seed_run_id(run_id)),
            _fk(
                "source_record_id",
                LoadTable.SOURCE_RECORDS,
                source_key_by_candidate[representative.candidate_id],
            ),
        ),
        evidence=evidence,
    )


def _override_evidence(
    override: ProjectionOverrideRecord,
    projection_overrides: ProjectionOverrideSet,
) -> JsonObject:
    return {
        "contract_version": override.contract_version,
        "target": override.target.value,
        "wikidata_qid": override.wikidata_qid,
        "field": override.field,
        "value": override.value,
        "reviewer": override.reviewer,
        "reviewed_at": override.reviewed_at.isoformat().replace("+00:00", "Z"),
        "evidence_url": override.evidence_url,
        "evidence_note": override.evidence_note,
        "record_fingerprint": override.record_fingerprint,
        "input_sha256": projection_overrides.input_sha256,
    }


def _projection_review(
    run_id: str,
    entity_id: str,
    target_type: str,
    reason_code: str,
    missing_fields: list[str],
) -> CanonicalLoadRecord:
    natural_key = f"projection:{target_type}:{entity_id}"
    return _record(
        run_id,
        LoadTable.REVIEW_QUEUE,
        natural_key,
        {
            "seed_run_id": canonical_seed_run_id(run_id),
            "target_type": target_type,
            "target_id": entity_id,
            "reason_code": reason_code,
            "status": "OPEN",
            "evidence": {"missing_fields": _json_strings(missing_fields)},
        },
        foreign_keys=(_fk("seed_run_id", LoadTable.SEED_RUNS, canonical_seed_run_id(run_id)),),
    )


def _canonical_name(candidates: list[NormalizedEntityCandidate], locale: str) -> str | None:
    names = sorted(
        name
        for candidate in candidates
        for localized_locale, name_kind, name in _localized_names(candidate)
        if localized_locale == locale and name_kind == "canonical"
    )
    return names[0] if names else None


def _unique_identifier(candidates: list[NormalizedEntityCandidate], namespace: str) -> str | None:
    values = {
        identifier.value
        for candidate in candidates
        for identifier in candidate.external_identifiers
        if identifier.namespace == namespace
    }
    return next(iter(values)) if len(values) == 1 else None


def _year_from_fact(candidates: list[NormalizedEntityCandidate], field: str) -> int | None:
    years = {
        int(match.group(1))
        for value in _all_fact_strings(candidates, field)
        if (match := re.match(r"^\+?(\d{4})", value)) is not None
    }
    return next(iter(years)) if len(years) == 1 else None


def _period_from_birth_year(birth_year: int) -> str:
    if birth_year < 1400:
        return "중세"
    if birth_year < 1600:
        return "르네상스"
    if birth_year < 1750:
        return "바로크"
    if birth_year < 1810:
        return "고전주의"
    if birth_year < 1860:
        return "낭만주의"
    return "근현대"


def _verified_country_name(candidates: list[NormalizedEntityCandidate]) -> str | None:
    country_codes = set(_all_fact_strings(candidates, "country_codes"))
    country_ids = set(_all_fact_strings(candidates, "country_entity_ids"))
    if len(country_codes) != 1:
        return None
    country_code = next(iter(country_codes))
    linked_country_ids = _country_ids_for_code(candidates, country_code)
    if _has_country_code_links(candidates):
        if len(linked_country_ids) != 1:
            return None
        return _preferred_linked_label(
            candidates,
            "country_labels",
            next(iter(linked_country_ids)),
        )
    if len(country_ids) != 1:
        return None
    return _preferred_linked_label(candidates, "country_labels", next(iter(country_ids)))


def _has_country_code_links(candidates: list[NormalizedEntityCandidate]) -> bool:
    return any(
        isinstance(candidate.facts.get("country_code_links"), list) for candidate in candidates
    )


def _country_ids_for_code(
    candidates: list[NormalizedEntityCandidate], country_code: str
) -> set[str]:
    country_ids: set[str] = set()
    for candidate in candidates:
        values = candidate.facts.get("country_code_links")
        if not isinstance(values, list):
            continue
        for value in values:
            if not isinstance(value, dict):
                continue
            if _object_string(value, "country_code") != country_code:
                continue
            country_id = _object_string(value, "country_entity_id")
            if country_id is not None:
                country_ids.add(country_id)
    return country_ids


def _verified_instrument_name(candidates: list[NormalizedEntityCandidate]) -> str | None:
    instrument_codes = set(_all_fact_strings(candidates, "instrument_codes"))
    if len(instrument_codes) != 1:
        return None
    return _preferred_linked_label(
        candidates,
        "instrument_labels",
        next(iter(instrument_codes)),
    )


def _preferred_linked_label(
    candidates: list[NormalizedEntityCandidate], field: str, code: str
) -> str | None:
    names_by_locale: dict[str, set[str]] = {"ko": set(), "en": set()}
    for candidate in candidates:
        values = candidate.facts.get(field)
        if not isinstance(values, list):
            continue
        for value in values:
            if not isinstance(value, dict) or _object_string(value, "code") != code:
                continue
            locale = _object_string(value, "locale")
            name = _object_string(value, "name")
            if locale in names_by_locale and name is not None:
                names_by_locale[locale].add(name)
    for locale in ("ko", "en"):
        names = names_by_locale[locale]
        if len(names) == 1:
            return next(iter(names))
    return None


def _all_fact_strings(candidates: list[NormalizedEntityCandidate], field: str) -> tuple[str, ...]:
    values: set[str] = set()
    for candidate in candidates:
        value = candidate.facts.get(field)
        if isinstance(value, str) and value:
            values.add(value)
        elif isinstance(value, list):
            values.update(item for item in value if isinstance(item, str) and item)
    return tuple(sorted(values))


def _work_records(
    run_id: str,
    candidates: list[NormalizedEntityCandidate],
    decision: ResolutionDecision,
    source_key_by_candidate: dict[str, str],
    available_work_mbids: set[str],
    work_parent_by_mbid: dict[str, str],
) -> list[CanonicalLoadRecord]:
    representative = _choose_representative(candidates)
    source_key = source_key_by_candidate[representative.candidate_id]
    work_mbid = _identifier_value(representative, "musicbrainz_work")
    if work_mbid is None:
        return [_review_for_unsupported_entity(run_id, decision, "WORK_MBID_MISSING")]
    parent_relations = _work_relations(representative, relation_type="parts", direction="backward")
    if len(parent_relations) > 1:
        return [_review_for_unsupported_entity(run_id, decision, "MULTIPLE_WORK_PARENTS")]
    if parent_relations:
        parent = parent_relations[0]
        parent_mbid = _object_string(parent, "target_work_id")
        if parent_mbid is None:
            return [_review_for_unsupported_entity(run_id, decision, "WORK_PARENT_ID_MISSING")]
        if parent_mbid not in available_work_mbids:
            return [_review_for_unsupported_entity(run_id, decision, "WORK_PARENT_NOT_IN_BUNDLE")]
        root_mbid, hierarchy_error = _root_work_mbid(
            work_mbid,
            work_parent_by_mbid,
            available_work_mbids,
        )
        if hierarchy_error is not None or root_mbid is None:
            return [
                _review_for_unsupported_entity(
                    run_id,
                    decision,
                    hierarchy_error or "WORK_PARENT_HIERARCHY_INVALID",
                )
            ]
        ordering_key = _object_int(parent, "ordering_key") or 0
        foreign_keys = [
            _fk(
                "piece_id",
                LoadTable.PIECES,
                f"musicbrainz_work:{root_mbid}",
                ForeignKeyResolution.BUNDLE_OR_EXISTING,
            ),
            _fk("source_record_id", LoadTable.SOURCE_RECORDS, source_key),
        ]
        if parent_mbid != root_mbid:
            foreign_keys.append(
                _fk(
                    "parent_part_id",
                    LoadTable.PIECE_PARTS,
                    f"musicbrainz_work_part:{parent_mbid}",
                    ForeignKeyResolution.BUNDLE_OR_EXISTING,
                )
            )
        return [
            _record(
                run_id,
                LoadTable.PIECE_PARTS,
                f"musicbrainz_work_part:{work_mbid}",
                {
                    "part_key": f"musicbrainz:{work_mbid}",
                    "sequence_number": ordering_key,
                    "name_en": representative.preferred_name,
                    "editorial_status": "IDENTIFIERS_MATCHED",
                    "origin": "seed",
                    "editor_locked": False,
                },
                foreign_keys=tuple(foreign_keys),
                evidence={
                    "resolution_action": decision.action,
                    "resolution_reason_code": decision.reason_code,
                },
            )
        ]

    composer_mbids = _fact_strings(representative, "composer_mbids")
    if len(composer_mbids) != 1:
        return [
            _review_for_unsupported_entity(
                run_id,
                decision,
                "WORK_COMPOSER_NOT_UNIQUE",
            )
        ]
    piece_key = f"musicbrainz_work:{work_mbid}"
    records = [
        _record(
            run_id,
            LoadTable.PIECES,
            piece_key,
            {
                "title": representative.preferred_name,
                "title_en": representative.preferred_name,
                "type": "song",
                "work_type": _fact_string(representative, "work_type"),
                "origin": "seed",
                "editor_locked": False,
            },
            foreign_keys=(
                _fk(
                    "composer_id",
                    LoadTable.COMPOSERS,
                    f"musicbrainz_artist:{composer_mbids[0]}",
                    ForeignKeyResolution.BUNDLE_OR_EXISTING,
                ),
                _fk("source_record_id", LoadTable.SOURCE_RECORDS, source_key),
            ),
            evidence={
                "resolution_action": decision.action,
                "resolution_reason_code": decision.reason_code,
                "languages": _json_strings(_fact_strings(representative, "languages")),
            },
        )
    ]
    records.extend(
        _work_identifier_and_alias_records(
            run_id,
            piece_key,
            representative,
            source_key,
        )
    )
    records.extend(_work_relation_records(run_id, piece_key, representative, source_key))
    records.extend(
        _provenance_records(
            run_id,
            target_table=LoadTable.PIECES,
            target_id=piece_key,
            candidates=candidates,
            source_key_by_candidate=source_key_by_candidate,
        )
    )
    return records


def _work_hierarchy_index(
    candidates: list[NormalizedEntityCandidate],
) -> tuple[set[str], dict[str, str]]:
    available: set[str] = set()
    parent_by_mbid: dict[str, str] = {}
    for candidate in candidates:
        if candidate.entity_kind is not EntityKind.WORK:
            continue
        work_mbid = _identifier_value(candidate, "musicbrainz_work")
        if work_mbid is None:
            continue
        available.add(work_mbid)
        parents = _work_relations(candidate, relation_type="parts", direction="backward")
        if len(parents) != 1:
            continue
        parent_mbid = _object_string(parents[0], "target_work_id")
        if parent_mbid is not None:
            parent_by_mbid[work_mbid] = parent_mbid
    return available, parent_by_mbid


def _root_work_mbid(
    work_mbid: str,
    parent_by_mbid: dict[str, str],
    available_work_mbids: set[str],
) -> tuple[str | None, str | None]:
    current = work_mbid
    seen: set[str] = set()
    while current in parent_by_mbid:
        if current in seen:
            return None, "WORK_PARENT_CYCLE"
        seen.add(current)
        parent_mbid = parent_by_mbid[current]
        if parent_mbid not in available_work_mbids:
            return None, "WORK_PARENT_NOT_IN_BUNDLE"
        current = parent_mbid
    return current, None


def _work_identifier_and_alias_records(
    run_id: str,
    piece_key: str,
    candidate: NormalizedEntityCandidate,
    source_key: str,
) -> list[CanonicalLoadRecord]:
    records: list[CanonicalLoadRecord] = []
    for identifier in candidate.external_identifiers:
        if identifier.namespace not in {"musicbrainz_work", "iswc", "work_catalogue"}:
            continue
        records.append(
            _record(
                run_id,
                LoadTable.PIECE_IDENTIFIERS,
                f"{identifier.namespace}:{identifier.value}",
                {
                    "namespace": identifier.namespace,
                    "external_id": identifier.value,
                },
                foreign_keys=(
                    _fk("piece_id", LoadTable.PIECES, piece_key),
                    _fk("source_record_id", LoadTable.SOURCE_RECORDS, source_key),
                ),
            )
        )
    localized_aliases = [
        (locale, alias)
        for locale, name_kind, alias in _localized_names(candidate)
        if name_kind == "alias"
    ]
    if not localized_aliases:
        localized_aliases = [("und", alias) for alias in candidate.aliases]
    seen_aliases: set[tuple[str, str]] = set()
    for locale, alias in sorted(localized_aliases):
        normalized = alias.casefold().strip()
        identity = (locale, normalized)
        if identity in seen_aliases:
            continue
        seen_aliases.add(identity)
        records.append(
            _record(
                run_id,
                LoadTable.PIECE_ALIASES,
                f"{piece_key}:{locale}:{normalized}",
                {
                    "locale": locale,
                    "alias_kind": "alias",
                    "alias_value": alias,
                    "normalized_value": normalized,
                    "is_preferred": False,
                    "origin": "seed",
                    "editor_locked": False,
                },
                foreign_keys=(
                    _fk("piece_id", LoadTable.PIECES, piece_key),
                    _fk("source_record_id", LoadTable.SOURCE_RECORDS, source_key),
                ),
            )
        )
    return records


def _work_relation_records(
    run_id: str,
    piece_key: str,
    candidate: NormalizedEntityCandidate,
    source_key: str,
) -> list[CanonicalLoadRecord]:
    relation_map = {
        "arrangement": "arrangement_of",
        "revision of": "revision_of",
        "other version": "version_of",
        "based on": "based_on",
    }
    records: list[CanonicalLoadRecord] = []
    for relation in _work_relations(candidate):
        relation_type = _object_string(relation, "relation_type")
        direction = _object_string(relation, "direction")
        target_mbid = _object_string(relation, "target_work_id")
        mapped_type = relation_map.get(relation_type or "")
        if mapped_type is None or target_mbid is None or direction != "backward":
            continue
        target_key = f"musicbrainz_work:{target_mbid}"
        records.append(
            _record(
                run_id,
                LoadTable.PIECE_RELATIONS,
                f"{piece_key}:{mapped_type}:{target_key}",
                {"relation_type": mapped_type},
                foreign_keys=(
                    _fk("from_piece_id", LoadTable.PIECES, piece_key),
                    _fk(
                        "to_piece_id",
                        LoadTable.PIECES,
                        target_key,
                        ForeignKeyResolution.BUNDLE_OR_EXISTING,
                    ),
                    _fk("source_record_id", LoadTable.SOURCE_RECORDS, source_key),
                ),
            )
        )
    return records


def _provenance_records(
    run_id: str,
    *,
    target_table: LoadTable,
    target_id: str,
    candidates: list[NormalizedEntityCandidate],
    source_key_by_candidate: dict[str, str],
) -> list[CanonicalLoadRecord]:
    records: list[CanonicalLoadRecord] = []
    seen: set[str] = set()
    field_name = "title" if target_table is LoadTable.PIECES else "canonical_name"
    for candidate in candidates:
        source_key = source_key_by_candidate[candidate.candidate_id]
        natural_key = f"{target_table}:{target_id}:{field_name}:{source_key}"
        if natural_key in seen:
            continue
        seen.add(natural_key)
        records.append(
            _record(
                run_id,
                LoadTable.FIELD_PROVENANCE,
                natural_key,
                {
                    "seed_run_id": canonical_seed_run_id(run_id),
                    "target_table": target_table,
                    "target_id": target_id,
                    "field_name": field_name,
                    "origin": "seed",
                    "editorial_status": "IDENTIFIERS_MATCHED",
                    "evidence": {"candidate_id": candidate.candidate_id},
                },
                foreign_keys=(
                    _fk(
                        "seed_run_id",
                        LoadTable.SEED_RUNS,
                        canonical_seed_run_id(run_id),
                    ),
                    _fk("source_record_id", LoadTable.SOURCE_RECORDS, source_key),
                ),
            )
        )
    return records


def _review_record(
    run_id: str,
    decision: ResolutionDecision,
    candidates: list[NormalizedEntityCandidate],
) -> CanonicalLoadRecord:
    return _record(
        run_id,
        LoadTable.REVIEW_QUEUE,
        decision.decision_id,
        {
            "seed_run_id": canonical_seed_run_id(run_id),
            "target_type": "resolution_candidate",
            "target_id": decision.decision_id,
            "reason_code": decision.reason_code,
            "status": "OPEN",
            "evidence": {
                "candidate_ids": _json_strings(candidate.candidate_id for candidate in candidates),
                "resolution_evidence": _json_strings(decision.evidence),
            },
        },
        foreign_keys=(
            _fk(
                "seed_run_id",
                LoadTable.SEED_RUNS,
                canonical_seed_run_id(run_id),
            ),
        ),
    )


def _review_for_unsupported_entity(
    run_id: str,
    decision: ResolutionDecision,
    reason_code: str,
) -> CanonicalLoadRecord:
    return _record(
        run_id,
        LoadTable.REVIEW_QUEUE,
        f"{decision.decision_id}:{reason_code}",
        {
            "seed_run_id": canonical_seed_run_id(run_id),
            "target_type": "resolution_candidate",
            "target_id": decision.decision_id,
            "reason_code": reason_code,
            "status": "OPEN",
            "evidence": {"candidate_ids": _json_strings(decision.candidate_ids)},
        },
        foreign_keys=(
            _fk(
                "seed_run_id",
                LoadTable.SEED_RUNS,
                canonical_seed_run_id(run_id),
            ),
        ),
    )


def _canonical_entity_id(candidates: list[NormalizedEntityCandidate]) -> str:
    strong_keys = sorted(
        f"{identifier.namespace}:{identifier.value}"
        for candidate in candidates
        for identifier in candidate.external_identifiers
        if identifier.strength is IdentifierStrength.STRONG
    )
    identity_parts = strong_keys or sorted(candidate.candidate_id for candidate in candidates)
    return str(uuid5(NAMESPACE_URL, f"classicmap-entity:{'|'.join(identity_parts)}"))


def _choose_representative(
    candidates: list[NormalizedEntityCandidate],
) -> NormalizedEntityCandidate:
    source_priority = {
        "musicbrainz": 0,
        "musicbrainz-works": 0,
        "wikidata": 1,
        "open-opus": 2,
    }
    return min(
        candidates,
        key=lambda candidate: (
            source_priority.get(candidate.source, 99),
            candidate.preferred_name.casefold(),
            candidate.candidate_id,
        ),
    )


def _record(
    run_id: str,
    table: LoadTable,
    natural_key: str,
    values: JsonObject,
    *,
    foreign_keys: tuple[LoadForeignKey, ...] = (),
    evidence: JsonObject | None = None,
) -> CanonicalLoadRecord:
    return CanonicalLoadRecord(
        seed_run_id=canonical_seed_run_id(run_id),
        table=table,
        natural_key=natural_key,
        values=values,
        foreign_keys=foreign_keys,
        evidence=evidence or {},
    )


def _fk(
    column: str,
    target_table: LoadTable,
    target_natural_key: str,
    resolution: ForeignKeyResolution = ForeignKeyResolution.BUNDLE,
) -> LoadForeignKey:
    return LoadForeignKey(
        column=column,
        target_table=target_table,
        target_natural_key=target_natural_key,
        resolution=resolution,
    )


def _json_sha256(value: JsonObject) -> str:
    content = json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(",", ":"))
    return hashlib.sha256(content.encode()).hexdigest()


def _identifier_value(
    candidate: NormalizedEntityCandidate,
    namespace: str,
) -> str | None:
    return next(
        (
            identifier.value
            for identifier in candidate.external_identifiers
            if identifier.namespace == namespace
        ),
        None,
    )


def _fact_strings(candidate: NormalizedEntityCandidate, field: str) -> tuple[str, ...]:
    value = candidate.facts.get(field)
    if not isinstance(value, list):
        return ()
    return tuple(item for item in value if isinstance(item, str) and item)


def _fact_string(candidate: NormalizedEntityCandidate, field: str) -> str | None:
    value = candidate.facts.get(field)
    return value if isinstance(value, str) and value else None


def _work_relations(
    candidate: NormalizedEntityCandidate,
    *,
    relation_type: str | None = None,
    direction: str | None = None,
) -> list[JsonObject]:
    value = candidate.facts.get("work_relations")
    if not isinstance(value, list):
        return []
    relations = [item for item in value if isinstance(item, dict)]
    if relation_type is not None:
        relations = [
            item for item in relations if _object_string(item, "relation_type") == relation_type
        ]
    if direction is not None:
        relations = [item for item in relations if _object_string(item, "direction") == direction]
    return relations


def _object_string(value: JsonObject, field: str) -> str | None:
    item = value.get(field)
    return item if isinstance(item, str) and item else None


def _object_int(value: JsonObject, field: str) -> int | None:
    item = value.get(field)
    return item if isinstance(item, int) and not isinstance(item, bool) else None


def _json_strings(values: Iterable[str]) -> list[JsonValue]:
    return list(values)
