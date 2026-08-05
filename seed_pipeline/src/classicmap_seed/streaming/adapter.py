from __future__ import annotations

import re
import unicodedata
from pathlib import Path
from uuid import NAMESPACE_URL, uuid5

from classicmap_seed.models import (
    CanonicalLoadRecord,
    JsonValue,
    LoadTable,
    SourceMetadata,
    SourceName,
)
from classicmap_seed.streaming.models import (
    StreamingLinkCandidate,
    StreamingMatchDecision,
    StreamingMatchStatus,
    StreamingPlatform,
)

_NON_ALPHANUMERIC = re.compile(r"[^\w]+", flags=re.UNICODE)


def read_streaming_candidates(path: Path) -> list[StreamingLinkCandidate]:
    return [
        StreamingLinkCandidate.model_validate_json(line)
        for line in path.read_bytes().splitlines()
        if line.strip()
    ]


def streaming_source_metadata(platform: StreamingPlatform) -> SourceMetadata:
    if platform is StreamingPlatform.SPOTIFY:
        return SourceMetadata(
            source=SourceName.SPOTIFY_EXPORT,
            source_uri="https://developer.spotify.com/documentation/web-api/reference/get-track",
            license="Spotify platform metadata; links only, subject to Developer Policy",
            license_uri="https://developer.spotify.com/policy",
        )
    return SourceMetadata(
        source=SourceName.APPLE_MUSIC_EXPORT,
        source_uri="https://developer.apple.com/documentation/applemusicapi/songs",
        license="Apple Music catalog metadata; links only, subject to developer terms",
        license_uri="https://developer.apple.com/documentation/applemusicapi",
    )


def build_streaming_load_bundle(
    candidates: list[StreamingLinkCandidate],
    *,
    run_id: str,
) -> list[CanonicalLoadRecord]:
    records: list[CanonicalLoadRecord] = []
    source_signatures: dict[str, tuple[str, tuple[str, ...], int]] = {}
    for candidate in sorted(candidates, key=_candidate_sort_key):
        source_signature = (
            candidate.source_isrc,
            tuple(sorted(_normalize_artist_name(name) for name in candidate.source_artist_names)),
            candidate.source_duration_ms,
        )
        existing_signature = source_signatures.get(candidate.track_id)
        if existing_signature is None:
            source_signatures[candidate.track_id] = source_signature
            records.append(_track_record(candidate, run_id))
        if existing_signature is not None and existing_signature != source_signature:
            decision = StreamingMatchDecision(
                candidate=candidate,
                status=StreamingMatchStatus.REVIEW_REQUIRED,
                reason_codes=("SOURCE_TRACK_CONFLICT",),
            )
        else:
            decision = evaluate_streaming_match(candidate)
        if decision.status is StreamingMatchStatus.AUTO_CONFIRMED:
            records.append(_platform_link_record(decision, run_id))
        else:
            records.append(_review_record(decision, run_id))
    return sorted(records, key=lambda record: (record.table, record.natural_key))


def evaluate_streaming_match(candidate: StreamingLinkCandidate) -> StreamingMatchDecision:
    reasons: list[str] = []
    platform_track = candidate.platform_track
    if candidate.source_isrc != platform_track.isrc:
        reasons.append("ISRC_CONFLICT")

    source_artists = {_normalize_artist_name(name) for name in candidate.source_artist_names}
    platform_artists = {_normalize_artist_name(name) for name in platform_track.artist_names}
    if not source_artists.intersection(platform_artists):
        reasons.append("ARTIST_CONFLICT")

    duration_tolerance_ms = max(2_000, round(candidate.source_duration_ms * 0.02))
    if abs(candidate.source_duration_ms - platform_track.duration_ms) > duration_tolerance_ms:
        reasons.append("DURATION_CONFLICT")

    return StreamingMatchDecision(
        candidate=candidate,
        status=(
            StreamingMatchStatus.REVIEW_REQUIRED if reasons else StreamingMatchStatus.AUTO_CONFIRMED
        ),
        reason_codes=tuple(reasons),
    )


def _track_record(candidate: StreamingLinkCandidate, run_id: str) -> CanonicalLoadRecord:
    return CanonicalLoadRecord(
        table=LoadTable.RECORDING_TRACKS,
        natural_key=candidate.track_id,
        values={
            "id": candidate.track_id,
            "run_id": run_id,
            "title": candidate.source_title,
            "isrc": candidate.source_isrc,
            "artist_names": _json_strings(candidate.source_artist_names),
            "duration_ms": candidate.source_duration_ms,
        },
    )


def _platform_link_record(
    decision: StreamingMatchDecision,
    run_id: str,
) -> CanonicalLoadRecord:
    candidate = decision.candidate
    platform_track = candidate.platform_track
    natural_key = (
        f"{platform_track.platform}:{platform_track.storefront}:{platform_track.platform_track_id}"
    )
    return CanonicalLoadRecord(
        table=LoadTable.PLATFORM_LINKS,
        natural_key=natural_key,
        values={
            "run_id": run_id,
            "track_id": candidate.track_id,
            "target_type": "recording_track",
            "platform": platform_track.platform,
            "platform_track_id": platform_track.platform_track_id,
            "storefront": platform_track.storefront,
            "track_url": platform_track.track_url,
            "source_isrc": candidate.source_isrc,
            "target_isrc": platform_track.isrc,
            "checked_at": platform_track.checked_at.isoformat(),
            "match_status": decision.status,
            "album_id": platform_track.album_id,
        },
    )


def _review_record(
    decision: StreamingMatchDecision,
    run_id: str,
) -> CanonicalLoadRecord:
    candidate = decision.candidate
    platform_track = candidate.platform_track
    identity = (
        f"{candidate.track_id}:{platform_track.platform}:"
        f"{platform_track.storefront}:{platform_track.platform_track_id}:"
        f"{candidate.source_isrc}:{candidate.source_duration_ms}"
    )
    review_id = str(uuid5(NAMESPACE_URL, f"classicmap-streaming-review:{identity}"))
    return CanonicalLoadRecord(
        table=LoadTable.REVIEW_QUEUE,
        natural_key=review_id,
        values={
            "id": review_id,
            "run_id": run_id,
            "status": "REVIEW_REQUIRED",
            "reason_codes": _json_strings(decision.reason_codes),
            "track_id": candidate.track_id,
            "platform": platform_track.platform,
            "platform_track_id": platform_track.platform_track_id,
            "source_isrc": candidate.source_isrc,
            "target_isrc": platform_track.isrc,
        },
    )


def _normalize_artist_name(value: str) -> str:
    normalized = unicodedata.normalize("NFKC", value).casefold()
    return _NON_ALPHANUMERIC.sub("", normalized)


def _candidate_sort_key(candidate: StreamingLinkCandidate) -> tuple[str, str, str, str, int]:
    platform_track = candidate.platform_track
    return (
        candidate.track_id,
        platform_track.platform,
        platform_track.platform_track_id,
        candidate.source_isrc,
        candidate.source_duration_ms,
    )


def _json_strings(values: tuple[str, ...]) -> list[JsonValue]:
    return list(values)
