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


class OpenOpusConnector:
    _URL = "https://api.openopus.org/composer/list/rec.json"

    def __init__(self, http_client: JsonHttpClient) -> None:
        self._http_client = http_client

    @property
    def metadata(self) -> SourceMetadata:
        return SourceMetadata(
            source=SourceName.OPEN_OPUS,
            source_uri=self._URL,
            license="Public domain (Open Opus provider claim; candidate discovery only)",
            license_uri="https://www.openopus.org/",
        )

    def fetch(self, *, limit: int) -> list[SourceRecord]:
        payload = self._http_client.get_json(self._URL)
        root = require_object(payload, field="Open Opus response")
        composers = require_list(root.get("composers"), field="composers")
        return [self._to_record(item) for item in composers[:limit]]

    @staticmethod
    def _to_record(item: JsonValue) -> SourceRecord:
        composer = require_object(item, field="composer")
        composer_id = require_string(composer.get("id"), field="composer.id")
        name = require_string(composer.get("name"), field="composer.name")
        selected_payload: JsonObject = {
            "id": composer_id,
            "name": name,
            "complete_name": composer.get("complete_name"),
            "epoch": composer.get("epoch"),
            "birth": composer.get("birth"),
            "death": composer.get("death"),
            "popular": composer.get("popular"),
            "recommended": composer.get("recommended"),
        }
        return SourceRecord(
            source=SourceName.OPEN_OPUS,
            source_record_id=composer_id,
            entity_kind=EntityKind.PERSON,
            payload=selected_payload,
        )
