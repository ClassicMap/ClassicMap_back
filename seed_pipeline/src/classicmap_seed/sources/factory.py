from __future__ import annotations

from classicmap_seed.http import FixedIntervalRateLimiter, JsonHttpClient
from classicmap_seed.models import SourceName
from classicmap_seed.sources.base import SourceConnector
from classicmap_seed.sources.musicbrainz import MusicBrainzConnector
from classicmap_seed.sources.open_opus import OpenOpusConnector
from classicmap_seed.sources.wikidata import WikidataConnector


def build_connector(
    source: SourceName,
    *,
    contact: str | None,
) -> tuple[SourceConnector, JsonHttpClient]:
    user_agent = _build_user_agent(source, contact)
    if source is SourceName.MUSICBRAINZ:
        client = JsonHttpClient(
            user_agent=user_agent,
            rate_limiter=FixedIntervalRateLimiter(1.0),
        )
        return MusicBrainzConnector(client), client
    if source is SourceName.WIKIDATA:
        client = JsonHttpClient(
            user_agent=user_agent,
            rate_limiter=FixedIntervalRateLimiter(0.5),
        )
        return WikidataConnector(client), client
    if source is SourceName.OPEN_OPUS:
        client = JsonHttpClient(
            user_agent=user_agent,
            rate_limiter=FixedIntervalRateLimiter(1.0),
        )
        return OpenOpusConnector(client), client
    raise ValueError(f"snapshot connector가 없는 source입니다: {source.value}")


def _build_user_agent(source: SourceName, contact: str | None) -> str:
    normalized_contact = contact.strip() if contact is not None else ""
    if source in {SourceName.MUSICBRAINZ, SourceName.WIKIDATA} and not normalized_contact:
        raise ValueError(f"{source.value} 요청에는 --contact가 필요합니다.")
    suffix = f" ({normalized_contact})" if normalized_contact else ""
    return f"ClassicMapSeed/0.1.0{suffix}"
