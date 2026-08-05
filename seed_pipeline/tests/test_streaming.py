from pathlib import Path

import pytest
from pydantic import ValidationError

from classicmap_seed.models import LoadTable, ValidationRuleCode
from classicmap_seed.streaming import (
    StreamingLinkCandidate,
    build_streaming_load_bundle,
    read_streaming_candidates,
)
from classicmap_seed.streaming.adapter import evaluate_streaming_match
from classicmap_seed.streaming.models import StreamingMatchStatus
from classicmap_seed.validate import validate_canonical_bundle

_FIXTURES = Path(__file__).parent / "fixtures"


def test_spotify_export_auto_confirms_only_isrc_artist_and_duration_match() -> None:
    candidate = read_streaming_candidates(_FIXTURES / "spotify_tracks.jsonl")[0]

    decision = evaluate_streaming_match(candidate)
    bundle = build_streaming_load_bundle([candidate], run_id="run-streaming")

    assert decision.status is StreamingMatchStatus.AUTO_CONFIRMED
    assert decision.reason_codes == ()
    link = next(record for record in bundle if record.table is LoadTable.PLATFORM_LINKS)
    assert link.values["target_type"] == "recording_track"
    assert link.values["source_isrc"] == link.values["target_isrc"]
    assert link.values["storefront"] == "KR"
    assert link.values["checked_at"] == "2026-08-05T00:00:00+00:00"
    assert not any(record.table is LoadTable.WORKS for record in bundle)

    rules = validate_canonical_bundle(
        bundle,
        idempotent_mutation_count=0,
        example_limit=10,
    )
    assert all(rule.passed for rule in rules)


def test_apple_export_conflicts_are_review_only_and_block_publication() -> None:
    candidate = read_streaming_candidates(_FIXTURES / "apple_music_tracks.jsonl")[0]

    decision = evaluate_streaming_match(candidate)
    bundle = build_streaming_load_bundle([candidate], run_id="run-streaming")

    assert decision.status is StreamingMatchStatus.REVIEW_REQUIRED
    assert decision.reason_codes == (
        "ISRC_CONFLICT",
        "ARTIST_CONFLICT",
        "DURATION_CONFLICT",
    )
    assert any(record.table is LoadTable.REVIEW_QUEUE for record in bundle)
    assert not any(record.table is LoadTable.PLATFORM_LINKS for record in bundle)

    rules = validate_canonical_bundle(
        bundle,
        idempotent_mutation_count=0,
        example_limit=10,
    )
    review_rule = next(rule for rule in rules if rule.rule is ValidationRuleCode.REVIEW_QUEUE_EMPTY)
    assert review_rule.passed is False


def test_same_track_id_with_conflicting_source_facts_requires_review() -> None:
    candidate = read_streaming_candidates(_FIXTURES / "spotify_tracks.jsonl")[0]
    conflicting = candidate.model_copy(
        update={
            "source_isrc": "USAAA2400099",
            "source_duration_ms": candidate.source_duration_ms + 30_000,
        }
    )

    bundle = build_streaming_load_bundle([candidate, conflicting], run_id="run-streaming")
    review = next(record for record in bundle if record.table is LoadTable.REVIEW_QUEUE)

    assert review.values["reason_codes"] == ["SOURCE_TRACK_CONFLICT"]


def test_platform_export_rejects_nonofficial_track_host() -> None:
    content = (_FIXTURES / "spotify_tracks.jsonl").read_text()
    invalid_json = content.replace(
        "https://open.spotify.com/track/spotify-track-fixture-001",
        "https://example.test/not-a-spotify-track",
    )

    with pytest.raises(ValidationError, match="공식 track URL host"):
        StreamingLinkCandidate.model_validate_json(invalid_json)
