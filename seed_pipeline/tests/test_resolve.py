from classicmap_seed.models import (
    EntityKind,
    ExternalIdentifier,
    IdentifierStrength,
    NormalizedEntityCandidate,
    ResolutionAction,
    SourceName,
    SourceRecord,
)
from classicmap_seed.normalize import normalize_records
from classicmap_seed.resolve import resolve_candidates


def _candidate(
    candidate_id: str,
    *,
    source: SourceName,
    name: str,
    namespace: str,
    value: str,
    strength: IdentifierStrength = IdentifierStrength.STRONG,
) -> NormalizedEntityCandidate:
    return NormalizedEntityCandidate(
        candidate_id=candidate_id,
        source=source,
        source_record_id=value,
        entity_kind=EntityKind.PERSON,
        preferred_name=name,
        normalized_name=name.casefold(),
        external_identifiers=(
            ExternalIdentifier(
                namespace=namespace,
                value=value,
                strength=strength,
                source=source,
            ),
        ),
    )


def test_shared_strong_identifier_is_auto_match() -> None:
    candidates = [
        _candidate(
            "a",
            source=SourceName.MUSICBRAINZ,
            name="Ludwig van Beethoven",
            namespace="wikidata",
            value="Q255",
        ),
        _candidate(
            "b",
            source=SourceName.WIKIDATA,
            name="Beethoven",
            namespace="wikidata",
            value="Q255",
        ),
    ]

    decisions = resolve_candidates(candidates)

    assert len(decisions) == 1
    assert decisions[0].action is ResolutionAction.AUTO_MATCH
    assert decisions[0].reason_code == "SHARED_STRONG_EXTERNAL_IDENTIFIER"


def test_same_name_with_different_ids_requires_review() -> None:
    candidates = [
        _candidate(
            "a",
            source=SourceName.MUSICBRAINZ,
            name="John Smith",
            namespace="musicbrainz_artist",
            value="mbid-a",
        ),
        _candidate(
            "b",
            source=SourceName.WIKIDATA,
            name="John Smith",
            namespace="wikidata",
            value="Q999",
        ),
    ]

    decisions = resolve_candidates(candidates)

    assert len(decisions) == 1
    assert decisions[0].action is ResolutionAction.REVIEW_REQUIRED
    assert decisions[0].reason_code == "NAME_ONLY_MATCH_FORBIDDEN"


def test_weak_identifier_never_auto_matches() -> None:
    candidates = [
        _candidate(
            "a",
            source=SourceName.OPEN_OPUS,
            name="Anonymous",
            namespace="openopus_composer",
            value="1",
            strength=IdentifierStrength.WEAK,
        ),
        _candidate(
            "b",
            source=SourceName.OPEN_OPUS,
            name="Anonymous",
            namespace="openopus_composer",
            value="1",
            strength=IdentifierStrength.WEAK,
        ),
    ]

    decisions = resolve_candidates(candidates)

    assert len(decisions) == 1
    assert decisions[0].action is ResolutionAction.REVIEW_REQUIRED


def test_transitive_strong_identifier_matches_form_one_component() -> None:
    candidate_a = _candidate(
        "a",
        source=SourceName.MUSICBRAINZ,
        name="Composer A",
        namespace="musicbrainz_artist",
        value="mbid-1",
    )
    candidate_b = NormalizedEntityCandidate(
        candidate_id="b",
        source=SourceName.WIKIDATA,
        source_record_id="Q1",
        entity_kind=EntityKind.PERSON,
        preferred_name="Composer A",
        normalized_name="composer a",
        external_identifiers=(
            ExternalIdentifier(
                namespace="musicbrainz_artist",
                value="mbid-1",
                strength=IdentifierStrength.STRONG,
                source=SourceName.WIKIDATA,
            ),
            ExternalIdentifier(
                namespace="wikidata",
                value="Q1",
                strength=IdentifierStrength.STRONG,
                source=SourceName.WIKIDATA,
            ),
        ),
    )
    candidate_c = _candidate(
        "c",
        source=SourceName.MUSICBRAINZ,
        name="Different label",
        namespace="wikidata",
        value="Q1",
    )

    decisions = resolve_candidates([candidate_a, candidate_b, candidate_c])
    auto_matches = [
        decision for decision in decisions if decision.action is ResolutionAction.AUTO_MATCH
    ]

    assert len(auto_matches) == 1
    assert auto_matches[0].candidate_ids == ("a", "b", "c")


def test_wikidata_cross_identifier_matches_musicbrainz_record() -> None:
    raw_records = [
        SourceRecord(
            source=SourceName.MUSICBRAINZ,
            source_record_id="mbid-1",
            entity_kind=EntityKind.PERSON,
            payload={"name": "Composer"},
        ),
        SourceRecord(
            source=SourceName.WIKIDATA,
            source_record_id="Q1",
            entity_kind=EntityKind.PERSON,
            payload={"name": "Completely different label", "musicbrainz_artist_id": "mbid-1"},
        ),
    ]

    decisions = resolve_candidates(normalize_records(raw_records))

    assert len(decisions) == 1
    assert decisions[0].action is ResolutionAction.AUTO_MATCH
    assert decisions[0].evidence == ("musicbrainz_artist:mbid-1",)
