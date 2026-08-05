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
from classicmap_seed.sources.base import optional_string, require_list, require_object


class WikidataConnector:
    _URL = "https://query.wikidata.org/sparql"

    def __init__(self, http_client: JsonHttpClient) -> None:
        self._http_client = http_client

    @property
    def metadata(self) -> SourceMetadata:
        return SourceMetadata(
            source=SourceName.WIKIDATA,
            source_uri=self._URL,
            license="CC0-1.0",
            license_uri="https://www.wikidata.org/wiki/Wikidata:Licensing",
        )

    def fetch(self, *, limit: int) -> list[SourceRecord]:
        query = f"""
SELECT ?entity ?entityLabel ?dateOfBirth ?dateOfDeath
       ?musicBrainzArtistId ?gndId ?viafId WHERE {{
  ?entity wdt:P106/wdt:P279* wd:Q36834 .
  OPTIONAL {{ ?entity wdt:P569 ?dateOfBirth . }}
  OPTIONAL {{ ?entity wdt:P570 ?dateOfDeath . }}
  OPTIONAL {{ ?entity wdt:P434 ?musicBrainzArtistId . }}
  OPTIONAL {{ ?entity wdt:P227 ?gndId . }}
  OPTIONAL {{ ?entity wdt:P214 ?viafId . }}
  SERVICE wikibase:label {{ bd:serviceParam wikibase:language \"en\". }}
}}
ORDER BY ?entity
LIMIT {min(limit, 100)}
""".strip()
        payload = self._http_client.get_json(
            self._URL,
            params={"query": query, "format": "json"},
        )
        root = require_object(payload, field="Wikidata response")
        results = require_object(root.get("results"), field="results")
        bindings = require_list(results.get("bindings"), field="results.bindings")
        return [self._to_record(item) for item in bindings[:limit]]

    @staticmethod
    def _to_record(item: JsonValue) -> SourceRecord:
        binding = require_object(item, field="binding")
        entity_uri = WikidataConnector._binding_value(binding.get("entity"))
        if entity_uri is None or "/entity/" not in entity_uri:
            raise ValueError("Wikidata entity URI가 올바르지 않습니다.")
        entity_id = entity_uri.rsplit("/", 1)[-1]
        label = WikidataConnector._binding_value(binding.get("entityLabel")) or entity_id
        selected_payload: JsonObject = {
            "id": entity_id,
            "name": label,
            "date_of_birth": WikidataConnector._binding_value(binding.get("dateOfBirth")),
            "date_of_death": WikidataConnector._binding_value(binding.get("dateOfDeath")),
            "musicbrainz_artist_id": WikidataConnector._binding_value(
                binding.get("musicBrainzArtistId")
            ),
            "gnd_id": WikidataConnector._binding_value(binding.get("gndId")),
            "viaf_id": WikidataConnector._binding_value(binding.get("viafId")),
        }
        return SourceRecord(
            source=SourceName.WIKIDATA,
            source_record_id=entity_id,
            entity_kind=EntityKind.PERSON,
            payload=selected_payload,
        )

    @staticmethod
    def _binding_value(value: JsonValue) -> str | None:
        if not isinstance(value, dict):
            return None
        return optional_string(value.get("value"))
