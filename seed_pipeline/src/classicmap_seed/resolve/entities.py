from __future__ import annotations

from collections import defaultdict
from uuid import NAMESPACE_URL, uuid5

from classicmap_seed.models import (
    IdentifierStrength,
    NormalizedEntityCandidate,
    ResolutionAction,
    ResolutionDecision,
)


def resolve_candidates(
    candidates: list[NormalizedEntityCandidate],
) -> list[ResolutionDecision]:
    if not candidates:
        return []

    by_identifier: dict[tuple[str, str], list[NormalizedEntityCandidate]] = defaultdict(list)
    by_name: dict[str, list[NormalizedEntityCandidate]] = defaultdict(list)
    for candidate in candidates:
        by_name[candidate.normalized_name].append(candidate)
        for identifier in candidate.external_identifiers:
            if identifier.strength is IdentifierStrength.STRONG:
                by_identifier[(identifier.namespace, identifier.value)].append(candidate)

    candidate_by_id = {candidate.candidate_id: candidate for candidate in candidates}
    parent = {candidate_id: candidate_id for candidate_id in candidate_by_id}

    def find(candidate_id: str) -> str:
        root = candidate_id
        while parent[root] != root:
            root = parent[root]
        while parent[candidate_id] != candidate_id:
            next_id = parent[candidate_id]
            parent[candidate_id] = root
            candidate_id = next_id
        return root

    def union(left_id: str, right_id: str) -> None:
        left_root = find(left_id)
        right_root = find(right_id)
        if left_root == right_root:
            return
        parent[max(left_root, right_root)] = min(left_root, right_root)

    for identifier_group in by_identifier.values():
        group = _unique_candidates(identifier_group)
        for candidate in group[1:]:
            union(group[0].candidate_id, candidate.candidate_id)

    components: dict[str, list[NormalizedEntityCandidate]] = defaultdict(list)
    for candidate in candidates:
        components[find(candidate.candidate_id)].append(candidate)

    auto_matched: set[str] = set()
    decisions: list[ResolutionDecision] = []

    for root in sorted(components):
        group = _unique_candidates(components[root])
        if len(group) < 2:
            continue
        candidate_ids = tuple(sorted(candidate.candidate_id for candidate in group))
        shared_evidence = tuple(
            f"{namespace}:{value}"
            for (namespace, value), identifier_group in sorted(by_identifier.items())
            if len(_unique_candidates(identifier_group)) >= 2
            and any(candidate.candidate_id in candidate_ids for candidate in identifier_group)
        )
        decisions.append(
            _decision(
                ResolutionAction.AUTO_MATCH,
                candidate_ids,
                reason_code="SHARED_STRONG_EXTERNAL_IDENTIFIER",
                evidence=shared_evidence,
            )
        )
        auto_matched.update(candidate_ids)

    reviewed: set[str] = set()
    for normalized_name in sorted(by_name):
        group = _unique_candidates(by_name[normalized_name])
        component_roots = {find(candidate.candidate_id) for candidate in group}
        if len(component_roots) < 2:
            continue
        candidate_ids = tuple(sorted(candidate.candidate_id for candidate in group))
        decisions.append(
            _decision(
                ResolutionAction.REVIEW_REQUIRED,
                candidate_ids,
                reason_code="NAME_ONLY_MATCH_FORBIDDEN",
                evidence=(f"normalized_name:{normalized_name}",),
            )
        )
        reviewed.update(candidate_ids)

    for candidate in sorted(candidates, key=lambda item: item.candidate_id):
        if candidate.candidate_id in auto_matched or candidate.candidate_id in reviewed:
            continue
        decisions.append(
            _decision(
                ResolutionAction.CREATE,
                (candidate.candidate_id,),
                reason_code="NO_MATCHING_STABLE_IDENTIFIER",
            )
        )

    return sorted(decisions, key=lambda decision: decision.decision_id)


def _unique_candidates(
    candidates: list[NormalizedEntityCandidate],
) -> list[NormalizedEntityCandidate]:
    by_id = {candidate.candidate_id: candidate for candidate in candidates}
    return list(by_id.values())


def _decision(
    action: ResolutionAction,
    candidate_ids: tuple[str, ...],
    *,
    reason_code: str,
    evidence: tuple[str, ...] = (),
) -> ResolutionDecision:
    identity = "|".join((action, reason_code, *candidate_ids, *evidence))
    return ResolutionDecision(
        decision_id=str(uuid5(NAMESPACE_URL, f"classicmap-resolution:{identity}")),
        action=action,
        candidate_ids=candidate_ids,
        reason_code=reason_code,
        evidence=evidence,
    )
