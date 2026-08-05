from __future__ import annotations

import re
import unicodedata
from pathlib import Path
from uuid import NAMESPACE_URL, uuid5

from classicmap_seed.load import canonical_seed_run_id
from classicmap_seed.models import (
    CanonicalLoadRecord,
    ForeignKeyResolution,
    JsonValue,
    LoadForeignKey,
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
    seed_run_id = canonical_seed_run_id(run_id)
    records: list[CanonicalLoadRecord] = [
        CanonicalLoadRecord(
            seed_run_id=seed_run_id,
            table=LoadTable.SEED_RUNS,
            natural_key=seed_run_id,
            values={
                "id": seed_run_id,
                "run_kind": "streaming_links",
                "command": f"classicmap-seed ingest-streaming --run-id {run_id}",
                "status": "PENDING",
                "dry_run": True,
                "manifest": {"db_contract_version": "global-seed-v1", "run_slug": run_id},
                "summary": {},
            },
        )
    ]
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
        seed_run_id=canonical_seed_run_id(run_id),
        table=LoadTable.RECORDING_TRACKS,
        natural_key=_track_natural_key(candidate),
        values={
            "track_key": candidate.track_id,
            "disc_number": candidate.disc_number,
            "track_number": candidate.track_number,
            "title": candidate.source_title,
            "isrc": candidate.source_isrc,
            "duration_ms": candidate.source_duration_ms,
            "origin": "seed",
            "editor_locked": False,
        },
        foreign_keys=(
            LoadForeignKey(
                column="recording_id",
                target_table=LoadTable.RECORDINGS,
                target_natural_key=candidate.recording_natural_key,
                resolution=ForeignKeyResolution.BUNDLE_OR_EXISTING,
            ),
        ),
        evidence={"artist_names": _json_strings(candidate.source_artist_names)},
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
        seed_run_id=canonical_seed_run_id(run_id),
        table=LoadTable.PLATFORM_LINKS,
        natural_key=natural_key,
        values={
            "platform": platform_track.platform,
            "platform_id": platform_track.platform_track_id,
            "storefront": platform_track.storefront,
            "url": platform_track.track_url,
            "isrc": platform_track.isrc,
            "verified_at": platform_track.checked_at.isoformat(),
        },
        foreign_keys=(
            LoadForeignKey(
                column="track_id",
                target_table=LoadTable.RECORDING_TRACKS,
                target_natural_key=_track_natural_key(candidate),
            ),
        ),
        evidence={
            "source_isrc": candidate.source_isrc,
            "target_isrc": platform_track.isrc,
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
        seed_run_id=canonical_seed_run_id(run_id),
        table=LoadTable.REVIEW_QUEUE,
        natural_key=review_id,
        values={
            "seed_run_id": canonical_seed_run_id(run_id),
            "target_type": "recording_track",
            "target_id": _track_natural_key(candidate),
            "reason_code": decision.reason_codes[0],
            "status": "OPEN",
            "evidence": {
                "reason_codes": _json_strings(decision.reason_codes),
                "platform": platform_track.platform,
                "platform_id": platform_track.platform_track_id,
                "source_isrc": candidate.source_isrc,
                "target_isrc": platform_track.isrc,
            },
        },
        foreign_keys=(
            LoadForeignKey(
                column="seed_run_id",
                target_table=LoadTable.SEED_RUNS,
                target_natural_key=canonical_seed_run_id(run_id),
            ),
        ),
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


def _track_natural_key(candidate: StreamingLinkCandidate) -> str:
    return f"{candidate.recording_natural_key}:{candidate.track_id}"


def _json_strings(values: tuple[str, ...]) -> list[JsonValue]:
    return list(values)
