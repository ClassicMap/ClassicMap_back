from __future__ import annotations

from collections.abc import Iterable
from uuid import NAMESPACE_URL, uuid5

from classicmap_seed.models import (
    CanonicalLoadRecord,
    EntityKind,
    IdentifierStrength,
    JsonObject,
    JsonValue,
    LoadTable,
    NormalizedEntityCandidate,
    ResolutionAction,
    ResolutionDecision,
    SnapshotManifest,
)


def build_canonical_load_bundle(
    *,
    run_id: str,
    source_manifest: SnapshotManifest,
    candidates: list[NormalizedEntityCandidate],
    decisions: list[ResolutionDecision],
) -> list[CanonicalLoadRecord]:
    candidate_by_id = {candidate.candidate_id: candidate for candidate in candidates}
    records: list[CanonicalLoadRecord] = [
        _record(
            LoadTable.SEED_RUNS,
            run_id,
            {
                "run_id": run_id,
                "status": "DISCOVERED",
                "source_snapshot_sha256": source_manifest.sha256,
            },
        ),
        _record(
            LoadTable.SOURCE_SNAPSHOTS,
            source_manifest.sha256,
            {
                "run_id": run_id,
                "source": source_manifest.source,
                "source_uri": source_manifest.source_uri,
                "license": source_manifest.license,
                "license_uri": source_manifest.license_uri,
                "retrieved_at": source_manifest.retrieved_at.isoformat(),
                "sha256": source_manifest.sha256,
                "row_count": source_manifest.row_count,
            },
        ),
    ]

    for candidate in sorted(candidates, key=lambda item: item.candidate_id):
        records.append(
            _record(
                LoadTable.SOURCE_RECORDS,
                f"{candidate.source}:{candidate.source_record_id}",
                {
                    "run_id": run_id,
                    "snapshot_sha256": source_manifest.sha256,
                    "source": candidate.source,
                    "source_record_id": candidate.source_record_id,
                    "candidate_id": candidate.candidate_id,
                    "entity_kind": candidate.entity_kind,
                    "payload": _candidate_payload(candidate),
                },
            )
        )

    entity_id_by_candidate: dict[str, str] = {}
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

        entity_id = _canonical_entity_id(group)
        for candidate in group:
            entity_id_by_candidate[candidate.candidate_id] = entity_id
        records.append(_entity_record(run_id, entity_id, group))

    records.extend(_identifier_records(run_id, candidates, entity_id_by_candidate))
    records.extend(_provenance_records(run_id, candidates, entity_id_by_candidate))
    return sorted(records, key=lambda record: (record.table, record.natural_key))


def _entity_record(
    run_id: str,
    entity_id: str,
    candidates: list[NormalizedEntityCandidate],
) -> CanonicalLoadRecord:
    representative = _choose_representative(candidates)
    table = _entity_table(representative.entity_kind)
    return _record(
        table,
        entity_id,
        {
            "id": entity_id,
            "run_id": run_id,
            "entity_kind": representative.entity_kind,
            "preferred_name": representative.preferred_name,
            "normalized_name": representative.normalized_name,
            "candidate_ids": _json_strings(candidate.candidate_id for candidate in candidates),
            "publication_state": "IDENTIFIERS_MATCHED",
        },
    )


def _review_record(
    run_id: str,
    decision: ResolutionDecision,
    candidates: list[NormalizedEntityCandidate],
) -> CanonicalLoadRecord:
    return _record(
        LoadTable.REVIEW_QUEUE,
        decision.decision_id,
        {
            "id": decision.decision_id,
            "run_id": run_id,
            "reason_code": decision.reason_code,
            "candidate_ids": _json_strings(candidate.candidate_id for candidate in candidates),
            "evidence": _json_strings(decision.evidence),
            "status": "REVIEW_REQUIRED",
        },
    )


def _identifier_records(
    run_id: str,
    candidates: list[NormalizedEntityCandidate],
    entity_id_by_candidate: dict[str, str],
) -> list[CanonicalLoadRecord]:
    by_natural_key: dict[str, CanonicalLoadRecord] = {}
    for candidate in candidates:
        entity_id = entity_id_by_candidate.get(candidate.candidate_id)
        if entity_id is None:
            continue
        for identifier in candidate.external_identifiers:
            natural_key = f"{identifier.namespace}:{identifier.value}"
            by_natural_key[natural_key] = _record(
                LoadTable.EXTERNAL_IDENTIFIERS,
                natural_key,
                {
                    "run_id": run_id,
                    "entity_id": entity_id,
                    "namespace": identifier.namespace,
                    "value": identifier.value,
                    "strength": identifier.strength,
                    "source": identifier.source,
                },
            )
    return list(by_natural_key.values())


def _provenance_records(
    run_id: str,
    candidates: list[NormalizedEntityCandidate],
    entity_id_by_candidate: dict[str, str],
) -> list[CanonicalLoadRecord]:
    records: list[CanonicalLoadRecord] = []
    seen: set[str] = set()
    for candidate in candidates:
        entity_id = entity_id_by_candidate.get(candidate.candidate_id)
        if entity_id is None:
            continue
        fields = ("preferred_name", *sorted(candidate.facts))
        for field in fields:
            natural_key = f"{entity_id}:{field}:{candidate.source}:{candidate.source_record_id}"
            if natural_key in seen:
                continue
            seen.add(natural_key)
            records.append(
                _record(
                    LoadTable.FIELD_PROVENANCE,
                    natural_key,
                    {
                        "run_id": run_id,
                        "entity_id": entity_id,
                        "field_name": field,
                        "source": candidate.source,
                        "source_record_id": candidate.source_record_id,
                        "candidate_id": candidate.candidate_id,
                    },
                )
            )
    return records


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
    source_priority = {"musicbrainz": 0, "wikidata": 1, "open-opus": 2}
    return min(
        candidates,
        key=lambda candidate: (
            source_priority[candidate.source],
            candidate.preferred_name.casefold(),
            candidate.candidate_id,
        ),
    )


def _entity_table(entity_kind: EntityKind) -> LoadTable:
    if entity_kind is EntityKind.WORK:
        return LoadTable.WORKS
    if entity_kind is EntityKind.RECORDING:
        return LoadTable.RECORDINGS
    return LoadTable.AUTHORITY_ENTITIES


def _candidate_payload(candidate: NormalizedEntityCandidate) -> JsonObject:
    return {
        "candidate_id": candidate.candidate_id,
        "source": candidate.source,
        "source_record_id": candidate.source_record_id,
        "entity_kind": candidate.entity_kind,
        "preferred_name": candidate.preferred_name,
        "normalized_name": candidate.normalized_name,
        "aliases": _json_strings(candidate.aliases),
        "external_identifiers": [
            {
                "namespace": identifier.namespace,
                "value": identifier.value,
                "strength": identifier.strength,
                "source": identifier.source,
            }
            for identifier in candidate.external_identifiers
        ],
        "facts": candidate.facts,
    }


def _record(table: LoadTable, natural_key: str, values: JsonObject) -> CanonicalLoadRecord:
    return CanonicalLoadRecord(
        table=table,
        natural_key=natural_key,
        values=values,
    )


def _json_strings(values: Iterable[str]) -> list[JsonValue]:
    return list(values)
