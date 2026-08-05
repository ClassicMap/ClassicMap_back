from __future__ import annotations

import re
from collections.abc import Iterable
from typing import ClassVar

from classicmap_seed.http import JsonHttpClient
from classicmap_seed.models import (
    EntityKind,
    JsonObject,
    JsonValue,
    SourceMetadata,
    SourceName,
    SourceRecord,
    WikidataScope,
)
from classicmap_seed.sources.base import optional_string, require_list, require_object
from classicmap_seed.sources.pagination import SourcePage

_CURSOR_PATTERN = re.compile(r"^https?://www\.wikidata\.org/entity/Q[1-9][0-9]*$")
_QID_PATTERN = re.compile(r"^Q[1-9][0-9]*$")


class WikidataConnector:
    _QUERY_URL = "https://query.wikidata.org/sparql"
    _ENTITY_URL = "https://www.wikidata.org/w/api.php"
    _SCOPE_PATTERN: ClassVar[dict[WikidataScope, str]] = {
        WikidataScope.COMPOSERS: "?entity wdt:P106/wdt:P279* wd:Q36834 .",
        WikidataScope.PERFORMERS: "?entity wdt:P106/wdt:P279* wd:Q639669 .",
        WikidataScope.ENSEMBLES: "?entity wdt:P31/wdt:P279* wd:Q2088357 .",
    }

    def __init__(self, http_client: JsonHttpClient) -> None:
        self._http_client = http_client

    @property
    def metadata(self) -> SourceMetadata:
        return SourceMetadata(
            source=SourceName.WIKIDATA,
            source_uri=self._QUERY_URL,
            license="CC0-1.0",
            license_uri="https://www.wikidata.org/wiki/Wikidata:Licensing",
        )

    def fetch(self, *, limit: int) -> list[SourceRecord]:
        return list(
            self.fetch_page(
                scope=WikidataScope.COMPOSERS,
                page_size=min(limit, 100),
                cursor=None,
            ).records
        )

    def fetch_page(
        self,
        *,
        scope: WikidataScope,
        page_size: int,
        cursor: str | None,
    ) -> SourcePage:
        if not 1 <= page_size <= 1_000:
            raise ValueError("Wikidata page_size는 1~1000이어야 합니다.")
        cursor_filter = ""
        if cursor is not None:
            if not _CURSOR_PATTERN.fullmatch(cursor):
                raise ValueError("Wikidata cursor 형식이 올바르지 않습니다.")
            cursor_filter = f'FILTER(STR(?entity) > "{cursor}")'
        payload = self._http_client.get_json(
            self._QUERY_URL,
            params={
                "query": self._build_scope_query(scope, page_size, cursor_filter),
                "format": "json",
            },
        )
        root = require_object(payload, field="Wikidata scope response")
        results = require_object(root.get("results"), field="results")
        bindings = require_list(results.get("bindings"), field="results.bindings")
        entity_uris = [self._binding_entity_uri(binding) for binding in bindings]
        if not entity_uris:
            return SourcePage(records=(), next_cursor=None, complete=True)

        entity_ids = [entity_uri.rsplit("/", 1)[-1] for entity_uri in entity_uris]
        entities = self._fetch_entities(entity_ids)
        linked_ids = sorted(
            {
                qid
                for entity in entities
                for property_id in ("P27", "P495", "P106", "P1303")
                for qid in self._claim_item_ids(entity, property_id)
            }
        )
        linked_entities = {
            self._entity_id(entity): entity for entity in self._fetch_entities(linked_ids)
        }
        records = tuple(self._to_record(entity, scope, linked_entities) for entity in entities)
        return SourcePage(
            records=records,
            next_cursor=entity_uris[-1] if len(entity_uris) == page_size else None,
            complete=len(entity_uris) < page_size,
        )

    @classmethod
    def _build_scope_query(
        cls,
        scope: WikidataScope,
        page_size: int,
        cursor_filter: str,
    ) -> str:
        return f"""
PREFIX wd: <http://www.wikidata.org/entity/>
PREFIX wdt: <http://www.wikidata.org/prop/direct/>
SELECT DISTINCT ?entity WHERE {{
  {cls._SCOPE_PATTERN[scope]}
  {cursor_filter}
}}
ORDER BY STR(?entity)
LIMIT {page_size}
""".strip()

    def _fetch_entities(self, entity_ids: list[str]) -> list[JsonObject]:
        entities: list[JsonObject] = []
        for offset in range(0, len(entity_ids), 50):
            chunk = entity_ids[offset : offset + 50]
            if not chunk:
                continue
            payload = self._http_client.get_json(
                self._ENTITY_URL,
                params={
                    "action": "wbgetentities",
                    "ids": "|".join(chunk),
                    "props": "labels|aliases|claims",
                    "languages": "en|ko",
                    "format": "json",
                    "formatversion": 2,
                },
            )
            root = require_object(payload, field="Wikidata entity response")
            entity_map = require_object(root.get("entities"), field="entities")
            for entity_id in chunk:
                entity = require_object(entity_map.get(entity_id), field=f"entities.{entity_id}")
                if entity.get("missing") is not None:
                    raise ValueError(f"Wikidata entity가 없습니다: {entity_id}")
                entities.append(entity)
        return entities

    @staticmethod
    def _to_record(
        entity: JsonObject,
        scope: WikidataScope,
        linked_entities: dict[str, JsonObject],
    ) -> SourceRecord:
        entity_id = WikidataConnector._entity_id(entity)
        labels = require_object(entity.get("labels"), field=f"{entity_id}.labels")
        aliases = require_object(entity.get("aliases"), field=f"{entity_id}.aliases")
        label_en = WikidataConnector._localized_value(labels.get("en"))
        label_ko = WikidataConnector._localized_value(labels.get("ko"))
        aliases_en = WikidataConnector._localized_aliases(aliases.get("en"))
        aliases_ko = WikidataConnector._localized_aliases(aliases.get("ko"))
        localized_names: list[JsonValue] = []
        for locale, canonical_name, localized_aliases in (
            ("en", label_en, aliases_en),
            ("ko", label_ko, aliases_ko),
        ):
            if canonical_name is not None:
                localized_names.append(
                    {"locale": locale, "name_kind": "canonical", "name": canonical_name}
                )
            localized_names.extend(
                {"locale": locale, "name_kind": "alias", "name": alias}
                for alias in localized_aliases
            )

        role_codes = WikidataConnector._claim_item_ids(entity, "P106")
        instrument_codes = WikidataConnector._claim_item_ids(entity, "P1303")
        country_entity_ids = sorted(
            {
                *WikidataConnector._claim_item_ids(entity, "P27"),
                *WikidataConnector._claim_item_ids(entity, "P495"),
            }
        )
        country_codes = sorted(
            {
                code.upper()
                for country_id in country_entity_ids
                for code in WikidataConnector._claim_strings(
                    linked_entities.get(country_id, {}), "P297"
                )
                if len(code) == 2
            }
        )
        selected_payload: JsonObject = {
            "id": entity_id,
            "name": label_en or label_ko or entity_id,
            "scope": scope,
            "aliases": WikidataConnector._json_strings(sorted({*aliases_en, *aliases_ko})),
            "localized_names": localized_names,
            "role_codes": WikidataConnector._json_strings(role_codes),
            "role_labels": WikidataConnector._linked_labels(role_codes, linked_entities),
            "instrument_codes": WikidataConnector._json_strings(instrument_codes),
            "instrument_labels": WikidataConnector._linked_labels(
                instrument_codes, linked_entities
            ),
            "country_codes": WikidataConnector._json_strings(country_codes),
            "country_entity_ids": WikidataConnector._json_strings(country_entity_ids),
            "country_labels": WikidataConnector._linked_labels(country_entity_ids, linked_entities),
            "commons_image_ids": WikidataConnector._json_strings(
                WikidataConnector._claim_strings(entity, "P18")
            ),
            "external_identifiers": {
                "musicbrainz_artist": WikidataConnector._json_strings(
                    WikidataConnector._claim_strings(entity, "P434")
                ),
                "gnd": WikidataConnector._json_strings(
                    WikidataConnector._claim_strings(entity, "P227")
                ),
                "viaf": WikidataConnector._json_strings(
                    WikidataConnector._claim_strings(entity, "P214")
                ),
                "isni": WikidataConnector._json_strings(
                    WikidataConnector._claim_strings(entity, "P213")
                ),
                "rism": WikidataConnector._json_strings(
                    WikidataConnector._claim_strings(entity, "P5504")
                ),
            },
            "date_of_birth": WikidataConnector._first_claim_time(entity, "P569"),
            "date_of_death": WikidataConnector._first_claim_time(entity, "P570"),
            "entity_data_source": WikidataConnector._ENTITY_URL,
        }
        entity_kind = EntityKind.ENSEMBLE if scope is WikidataScope.ENSEMBLES else EntityKind.PERSON
        return SourceRecord(
            source=SourceName.WIKIDATA,
            source_record_id=entity_id,
            entity_kind=entity_kind,
            payload=selected_payload,
        )

    @staticmethod
    def _binding_entity_uri(value: JsonValue) -> str:
        binding = require_object(value, field="binding")
        entity_binding = require_object(binding.get("entity"), field="binding.entity")
        entity_uri = optional_string(entity_binding.get("value"))
        if entity_uri is None or not _CURSOR_PATTERN.fullmatch(entity_uri):
            raise ValueError("Wikidata entity URI가 올바르지 않습니다.")
        return entity_uri

    @staticmethod
    def _entity_id(entity: JsonObject) -> str:
        entity_id = optional_string(entity.get("id"))
        if entity_id is None or not _QID_PATTERN.fullmatch(entity_id):
            raise ValueError("Wikidata entity id가 올바르지 않습니다.")
        return entity_id

    @staticmethod
    def _claim_values(entity: JsonObject, property_id: str) -> list[JsonValue]:
        claims = entity.get("claims")
        if not isinstance(claims, dict):
            return []
        statements = claims.get(property_id)
        if not isinstance(statements, list):
            return []
        values: list[JsonValue] = []
        for statement_value in statements:
            if not isinstance(statement_value, dict):
                continue
            mainsnak = statement_value.get("mainsnak")
            if not isinstance(mainsnak, dict) or mainsnak.get("snaktype") != "value":
                continue
            datavalue = mainsnak.get("datavalue")
            if isinstance(datavalue, dict) and "value" in datavalue:
                values.append(datavalue["value"])
        return values

    @staticmethod
    def _claim_strings(entity: JsonObject, property_id: str) -> list[str]:
        return sorted(
            {
                value.strip()
                for value in WikidataConnector._claim_values(entity, property_id)
                if isinstance(value, str) and value.strip()
            }
        )

    @staticmethod
    def _claim_item_ids(entity: JsonObject, property_id: str) -> list[str]:
        identifiers: set[str] = set()
        for value in WikidataConnector._claim_values(entity, property_id):
            if not isinstance(value, dict):
                continue
            entity_id = optional_string(value.get("id"))
            if entity_id is not None and _QID_PATTERN.fullmatch(entity_id):
                identifiers.add(entity_id)
        return sorted(identifiers)

    @staticmethod
    def _first_claim_time(entity: JsonObject, property_id: str) -> str | None:
        times = sorted(
            time
            for value in WikidataConnector._claim_values(entity, property_id)
            if isinstance(value, dict) and (time := optional_string(value.get("time"))) is not None
        )
        return times[0] if times else None

    @staticmethod
    def _localized_value(value: JsonValue) -> str | None:
        if not isinstance(value, dict):
            return None
        return optional_string(value.get("value"))

    @staticmethod
    def _localized_aliases(value: JsonValue) -> list[str]:
        if not isinstance(value, list):
            return []
        return sorted(
            {
                alias
                for item in value
                if isinstance(item, dict)
                and (alias := optional_string(item.get("value"))) is not None
            }
        )

    @staticmethod
    def _linked_labels(
        entity_ids: list[str], linked_entities: dict[str, JsonObject]
    ) -> list[JsonValue]:
        labels: list[JsonValue] = []
        for entity_id in entity_ids:
            entity = linked_entities.get(entity_id)
            if entity is None:
                continue
            localized = entity.get("labels")
            if not isinstance(localized, dict):
                continue
            for locale in ("en", "ko"):
                name = WikidataConnector._localized_value(localized.get(locale))
                if name is not None:
                    labels.append({"code": entity_id, "locale": locale, "name": name})
        return labels

    @staticmethod
    def _json_strings(values: Iterable[str]) -> list[JsonValue]:
        return [value for value in values]
