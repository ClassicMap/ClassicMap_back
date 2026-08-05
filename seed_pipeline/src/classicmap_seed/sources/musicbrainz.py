from __future__ import annotations

from classicmap_seed.http import JsonHttpClient
from classicmap_seed.models import (
    EntityKind,
    JsonObject,
    JsonValue,
    SourceMetadata,
    SourceName,
    SourceRecord,
)
from classicmap_seed.sources.base import require_list, require_object, require_string


class MusicBrainzConnector:
    _URL = "https://musicbrainz.org/ws/2/artist/"

    def __init__(self, http_client: JsonHttpClient) -> None:
        self._http_client = http_client

    @property
    def metadata(self) -> SourceMetadata:
        return SourceMetadata(
            source=SourceName.MUSICBRAINZ,
            source_uri=self._URL,
            license="MusicBrainz core data: CC0-1.0",
            license_uri="https://musicbrainz.org/doc/About/Data_License",
        )

    def fetch(self, *, limit: int) -> list[SourceRecord]:
        payload = self._http_client.get_json(
            self._URL,
            params={"query": "tag:classical", "fmt": "json", "limit": min(limit, 100)},
        )
        root = require_object(payload, field="MusicBrainz response")
        artists = require_list(root.get("artists"), field="artists")
        return [self._to_record(item) for item in artists[:limit]]

    @staticmethod
    def _to_record(item: JsonValue) -> SourceRecord:
        artist = require_object(item, field="artist")
        artist_id = require_string(artist.get("id"), field="artist.id")
        name = require_string(artist.get("name"), field="artist.name")
        artist_type = artist.get("type")
        kind = EntityKind.PERSON if artist_type == "Person" else EntityKind.ORGANIZATION
        selected_payload: JsonObject = {
            "id": artist_id,
            "name": name,
            "sort_name": artist.get("sort-name"),
            "type": artist_type,
            "country": artist.get("country"),
            "disambiguation": artist.get("disambiguation"),
            "life_span": MusicBrainzConnector._copy_object(artist.get("life-span")),
        }
        return SourceRecord(
            source=SourceName.MUSICBRAINZ,
            source_record_id=artist_id,
            entity_kind=kind,
            payload=selected_payload,
        )

    @staticmethod
    def _copy_object(value: JsonValue) -> JsonObject:
        return value if isinstance(value, dict) else {}
