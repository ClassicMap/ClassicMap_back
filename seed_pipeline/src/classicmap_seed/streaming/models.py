from __future__ import annotations

import re
from datetime import UTC, datetime
from enum import StrEnum
from urllib.parse import urlparse

from pydantic import Field, field_validator, model_validator

from classicmap_seed.models import StrictModel

_ISRC_PATTERN = re.compile(r"^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$")


class StreamingPlatform(StrEnum):
    SPOTIFY = "spotify"
    APPLE_MUSIC = "apple_music"


class StreamingMatchStatus(StrEnum):
    AUTO_CONFIRMED = "auto_confirmed"
    REVIEW_REQUIRED = "review_required"


class PlatformTrackExport(StrictModel):
    platform: StreamingPlatform
    platform_track_id: str = Field(min_length=1)
    storefront: str = Field(min_length=2, max_length=16)
    isrc: str
    artist_names: tuple[str, ...] = Field(min_length=1)
    duration_ms: int = Field(gt=0)
    track_url: str
    album_id: str | None = None
    checked_at: datetime

    @field_validator("isrc")
    @classmethod
    def normalize_isrc(cls, value: str) -> str:
        normalized = value.replace("-", "").replace(" ", "").upper()
        if not _ISRC_PATTERN.fullmatch(normalized):
            raise ValueError("ISRC 형식이 올바르지 않습니다.")
        return normalized

    @field_validator("artist_names")
    @classmethod
    def require_artist_names(cls, values: tuple[str, ...]) -> tuple[str, ...]:
        normalized = tuple(value.strip() for value in values if value.strip())
        if not normalized:
            raise ValueError("platform artist_names가 필요합니다.")
        return normalized

    @field_validator("storefront")
    @classmethod
    def normalize_storefront(cls, value: str) -> str:
        normalized = value.strip().upper()
        if not 2 <= len(normalized) <= 16:
            raise ValueError("storefront 길이가 올바르지 않습니다.")
        return normalized

    @field_validator("track_url")
    @classmethod
    def require_https_url(cls, value: str) -> str:
        if not value.startswith("https://"):
            raise ValueError("track_url은 HTTPS URL이어야 합니다.")
        return value

    @field_validator("checked_at")
    @classmethod
    def require_checked_at_timezone(cls, value: datetime) -> datetime:
        if value.tzinfo is None:
            raise ValueError("checked_at에는 timezone이 필요합니다.")
        return value.astimezone(UTC)

    @model_validator(mode="after")
    def require_official_track_host(self) -> PlatformTrackExport:
        host = (urlparse(self.track_url).hostname or "").casefold()
        expected_host = (
            "open.spotify.com" if self.platform is StreamingPlatform.SPOTIFY else "music.apple.com"
        )
        if host != expected_host:
            raise ValueError(f"{self.platform.value} 공식 track URL host가 아닙니다.")
        return self


class StreamingLinkCandidate(StrictModel):
    recording_natural_key: str = Field(min_length=1)
    track_id: str = Field(min_length=1)
    disc_number: int = Field(default=1, ge=1)
    track_number: int = Field(ge=1)
    source_title: str = Field(min_length=1)
    source_isrc: str
    source_artist_names: tuple[str, ...] = Field(min_length=1)
    source_duration_ms: int = Field(gt=0)
    platform_track: PlatformTrackExport

    @field_validator("source_isrc")
    @classmethod
    def normalize_source_isrc(cls, value: str) -> str:
        normalized = value.replace("-", "").replace(" ", "").upper()
        if not _ISRC_PATTERN.fullmatch(normalized):
            raise ValueError("source ISRC 형식이 올바르지 않습니다.")
        return normalized

    @field_validator("source_artist_names")
    @classmethod
    def require_source_artist_names(cls, values: tuple[str, ...]) -> tuple[str, ...]:
        normalized = tuple(value.strip() for value in values if value.strip())
        if not normalized:
            raise ValueError("source_artist_names가 필요합니다.")
        return normalized


class StreamingMatchDecision(StrictModel):
    candidate: StreamingLinkCandidate
    status: StreamingMatchStatus
    reason_codes: tuple[str, ...] = ()
