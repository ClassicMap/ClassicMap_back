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
from classicmap_seed.sources.base import (
    optional_string,
    require_list,
    require_object,
    require_string,
)
from classicmap_seed.sources.pagination import SourcePage


class MusicBrainzWorkConnector:
    _URL = "https://musicbrainz.org/ws/2/work"

    def __init__(self, http_client: JsonHttpClient) -> None:
        self._http_client = http_client

    @property
    def metadata(self) -> SourceMetadata:
        return SourceMetadata(
            source=SourceName.MUSICBRAINZ_WORKS,
            source_uri=self._URL,
            license="MusicBrainz core data: CC0-1.0",
            license_uri="https://musicbrainz.org/doc/About/Data_License",
        )

    def fetch_page(self, *, artist_mbid: str, offset: int, page_size: int) -> SourcePage:
        if not 1 <= page_size <= 100:
            raise ValueError("MusicBrainz work page_size는 1~100이어야 합니다.")
        if offset < 0:
            raise ValueError("MusicBrainz offset은 음수일 수 없습니다.")
        payload = self._http_client.get_json(
            self._URL,
            params={
                "artist": artist_mbid,
                "fmt": "json",
                "limit": page_size,
                "offset": offset,
                "inc": "aliases+artist-rels+work-rels",
            },
        )
        root = require_object(payload, field="MusicBrainz work response")
        works = require_list(root.get("works"), field="works")
        work_count = root.get("work-count")
        if not isinstance(work_count, int) or isinstance(work_count, bool) or work_count < 0:
            raise ValueError("MusicBrainz work-count가 올바르지 않습니다.")
        records = tuple(self._to_record(work, artist_mbid) for work in works)
        next_offset = offset + len(records)
        complete = next_offset >= work_count or len(records) < page_size
        return SourcePage(
            records=records,
            next_cursor=None if complete else str(next_offset),
            complete=complete,
        )

    @staticmethod
    def _to_record(value: JsonValue, browsed_artist_mbid: str) -> SourceRecord:
        work = require_object(value, field="work")
        work_id = require_string(work.get("id"), field="work.id")
        title = require_string(work.get("title"), field="work.title")
        aliases, localized_names = MusicBrainzWorkConnector._aliases(work.get("aliases"))
        relations = MusicBrainzWorkConnector._relations(work.get("relations"))
        composer_mbids = MusicBrainzWorkConnector._composer_mbids(relations)
        iswcs = MusicBrainzWorkConnector._string_list(work.get("iswcs"))
        languages = MusicBrainzWorkConnector._string_list(work.get("languages"))
        attributes = MusicBrainzWorkConnector._attributes(work.get("attributes"))
        selected_payload: JsonObject = {
            "id": work_id,
            "name": title,
            "title": title,
            "type": work.get("type"),
            "languages": MusicBrainzWorkConnector._json_strings(languages),
            "iswcs": MusicBrainzWorkConnector._json_strings(iswcs),
            "aliases": MusicBrainzWorkConnector._json_strings(aliases),
            "localized_names": localized_names,
            "attributes": attributes,
            "catalogue_attributes": MusicBrainzWorkConnector._catalogue_attributes(attributes),
            "relations": relations,
            "composer_mbids": MusicBrainzWorkConnector._json_strings(composer_mbids),
            "browsed_artist_ids": [browsed_artist_mbid],
        }
        return SourceRecord(
            source=SourceName.MUSICBRAINZ_WORKS,
            source_record_id=work_id,
            entity_kind=EntityKind.WORK,
            payload=selected_payload,
        )

    @staticmethod
    def _aliases(value: JsonValue) -> tuple[list[str], list[JsonValue]]:
        if not isinstance(value, list):
            return [], []
        aliases: set[str] = set()
        localized: list[JsonValue] = []
        for alias_value in value:
            if not isinstance(alias_value, dict):
                continue
            name = optional_string(alias_value.get("name"))
            if name is None:
                continue
            aliases.add(name)
            locale = optional_string(alias_value.get("locale")) or "und"
            localized.append({"locale": locale, "name_kind": "alias", "name": name})
        return sorted(aliases), localized

    @staticmethod
    def _relations(value: JsonValue) -> list[JsonValue]:
        if not isinstance(value, list):
            return []
        relations: list[JsonValue] = []
        for relation_value in value:
            if not isinstance(relation_value, dict):
                continue
            relation_type = optional_string(relation_value.get("type"))
            direction = optional_string(relation_value.get("direction"))
            target_type = optional_string(relation_value.get("target-type"))
            if relation_type is None or direction is None or target_type is None:
                continue
            selected: JsonObject = {
                "relation_type": relation_type,
                "direction": direction,
                "target_type": target_type,
                "attributes": relation_value.get("attributes") or [],
            }
            ordering_key = relation_value.get("ordering-key")
            if isinstance(ordering_key, int) and not isinstance(ordering_key, bool):
                selected["ordering_key"] = ordering_key
            artist = relation_value.get("artist")
            if isinstance(artist, dict):
                selected["target_artist_id"] = artist.get("id")
                selected["target_artist_name"] = artist.get("name")
            related_work = relation_value.get("work")
            if isinstance(related_work, dict):
                selected["target_work_id"] = related_work.get("id")
                selected["target_work_title"] = related_work.get("title")
            relations.append(selected)
        return relations

    @staticmethod
    def _attributes(value: JsonValue) -> list[JsonValue]:
        if not isinstance(value, list):
            return []
        attributes: list[JsonValue] = []
        for attribute_value in value:
            if not isinstance(attribute_value, dict):
                continue
            attribute_type = optional_string(attribute_value.get("type"))
            attribute_value_text = optional_string(attribute_value.get("value"))
            if attribute_type is None or attribute_value_text is None:
                continue
            attributes.append({"type": attribute_type, "value": attribute_value_text})
        return attributes

    @staticmethod
    def _composer_mbids(relations: list[JsonValue]) -> list[str]:
        identifiers: set[str] = set()
        for relation in relations:
            if not isinstance(relation, dict) or relation.get("relation_type") != "composer":
                continue
            artist_id = relation.get("target_artist_id")
            if isinstance(artist_id, str) and artist_id:
                identifiers.add(artist_id)
        return sorted(identifiers)

    @staticmethod
    def _catalogue_attributes(attributes: list[JsonValue]) -> list[JsonValue]:
        catalogue: list[JsonValue] = []
        for attribute in attributes:
            if not isinstance(attribute, dict):
                continue
            attribute_type = attribute.get("type")
            if isinstance(attribute_type, str) and "catalog" in attribute_type.casefold():
                catalogue.append(attribute)
        return catalogue

    @staticmethod
    def _string_list(value: JsonValue) -> list[str]:
        if not isinstance(value, list):
            return []
        return sorted({item for item in value if isinstance(item, str) and item})

    @staticmethod
    def _json_strings(values: list[str]) -> list[JsonValue]:
        output: list[JsonValue] = []
        output.extend(values)
        return output
