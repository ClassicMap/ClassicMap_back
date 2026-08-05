from __future__ import annotations

import re
import unicodedata
from urllib.parse import quote
from uuid import NAMESPACE_URL, uuid5

from classicmap_seed.models import (
    ExternalIdentifier,
    IdentifierStrength,
    JsonObject,
    JsonValue,
    NormalizedEntityCandidate,
    SourceName,
    SourceRecord,
)
from classicmap_seed.sources.base import optional_string, require_string

_WHITESPACE_PATTERN = re.compile(r"\s+")


def normalize_records(records: list[SourceRecord]) -> list[NormalizedEntityCandidate]:
    return [normalize_record(record) for record in records]


def normalize_record(record: SourceRecord) -> NormalizedEntityCandidate:
    name = require_string(record.payload.get("name"), field="payload.name")
    aliases = _extract_aliases(record)
    identifiers = _extract_identifiers(record)
    facts = _extract_facts(record)
    candidate_identity = f"classicmap:{record.source}:{record.source_record_id}"
    candidate_id = str(uuid5(NAMESPACE_URL, candidate_identity))
    return NormalizedEntityCandidate(
        candidate_id=candidate_id,
        source=record.source,
        source_record_id=record.source_record_id,
        entity_kind=record.entity_kind,
        preferred_name=name.strip(),
        normalized_name=normalize_name(name),
        aliases=aliases,
        external_identifiers=identifiers,
        facts=facts,
    )


def normalize_name(value: str) -> str:
    unicode_normalized = unicodedata.normalize("NFKC", value)
    return _WHITESPACE_PATTERN.sub(" ", unicode_normalized).strip().casefold()


def _extract_identifiers(record: SourceRecord) -> tuple[ExternalIdentifier, ...]:
    namespace_by_source = {
        SourceName.MUSICBRAINZ: "musicbrainz_artist",
        SourceName.MUSICBRAINZ_WORKS: "musicbrainz_work",
        SourceName.OPEN_OPUS: "openopus_composer",
        SourceName.WIKIDATA: "wikidata",
    }
    strength = (
        IdentifierStrength.WEAK
        if record.source is SourceName.OPEN_OPUS
        else IdentifierStrength.STRONG
    )
    identifiers = [
        ExternalIdentifier(
            namespace=namespace_by_source[record.source],
            value=record.source_record_id,
            strength=strength,
            source=record.source,
        )
    ]
    if record.source is SourceName.WIKIDATA:
        external = record.payload.get("external_identifiers")
        if isinstance(external, dict):
            for namespace in ("musicbrainz_artist", "gnd", "viaf", "isni", "rism"):
                values = external.get(namespace)
                if not isinstance(values, list):
                    continue
                for value in values:
                    if not isinstance(value, str) or not value.strip():
                        continue
                    identifiers.append(
                        ExternalIdentifier(
                            namespace=namespace,
                            value=value.strip(),
                            strength=IdentifierStrength.STRONG,
                            source=record.source,
                        )
                    )
        else:
            cross_identifier_fields = {
                "musicbrainz_artist_id": "musicbrainz_artist",
                "gnd_id": "gnd",
                "viaf_id": "viaf",
            }
            for field, namespace in cross_identifier_fields.items():
                value = optional_string(record.payload.get(field))
                if value is None:
                    continue
                identifiers.append(
                    ExternalIdentifier(
                        namespace=namespace,
                        value=value,
                        strength=IdentifierStrength.STRONG,
                        source=record.source,
                    )
                )
    if record.source is SourceName.MUSICBRAINZ_WORKS:
        iswcs = record.payload.get("iswcs")
        if isinstance(iswcs, list):
            for iswc in iswcs:
                if isinstance(iswc, str) and iswc:
                    identifiers.append(
                        ExternalIdentifier(
                            namespace="iswc",
                            value=iswc,
                            strength=IdentifierStrength.STRONG,
                            source=record.source,
                        )
                    )
        catalogue_attributes = record.payload.get("catalogue_attributes")
        if isinstance(catalogue_attributes, list):
            for attribute in catalogue_attributes:
                if not isinstance(attribute, dict):
                    continue
                attribute_type = optional_string(attribute.get("type"))
                value = optional_string(attribute.get("value"))
                if attribute_type is not None and value is not None:
                    identifiers.append(
                        ExternalIdentifier(
                            namespace="work_catalogue",
                            value=f"{attribute_type}:{value}",
                            strength=IdentifierStrength.WEAK,
                            source=record.source,
                        )
                    )
    return tuple(dict.fromkeys(identifiers))


def _extract_aliases(record: SourceRecord) -> tuple[str, ...]:
    preferred_name = require_string(record.payload.get("name"), field="payload.name")
    aliases: list[str] = []
    payload_aliases = record.payload.get("aliases")
    if isinstance(payload_aliases, list):
        aliases.extend(
            value.strip() for value in payload_aliases if isinstance(value, str) and value.strip()
        )
    if record.source is SourceName.OPEN_OPUS:
        complete_name = optional_string(record.payload.get("complete_name"))
        if complete_name is not None:
            aliases.append(complete_name)
    preferred_normalized = normalize_name(preferred_name)
    return tuple(
        dict.fromkeys(alias for alias in aliases if normalize_name(alias) != preferred_normalized)
    )


def _extract_facts(record: SourceRecord) -> JsonObject:
    allowed_fields = {
        SourceName.MUSICBRAINZ: (
            "sort_name",
            "type",
            "country",
            "disambiguation",
            "life_span",
        ),
        SourceName.MUSICBRAINZ_WORKS: (
            "localized_names",
            "type",
            "languages",
            "attributes",
            "catalogue_attributes",
            "relations",
            "composer_mbids",
            "browsed_artist_ids",
        ),
        SourceName.OPEN_OPUS: (
            "epoch",
            "birth",
            "death",
            "popular",
            "recommended",
        ),
        SourceName.WIKIDATA: (
            "scope",
            "localized_names",
            "role_codes",
            "role_labels",
            "instrument_codes",
            "instrument_labels",
            "country_codes",
            "country_entity_ids",
            "country_labels",
            "commons_image_ids",
            "date_of_birth",
            "date_of_death",
            "entity_data_source",
            "musicbrainz_artist_id",
            "gnd_id",
            "viaf_id",
        ),
    }
    facts: JsonObject = {}
    for field in allowed_fields[record.source]:
        value: JsonValue = record.payload.get(field)
        if value is not None and value != "":
            facts[field] = value
    if record.source is SourceName.WIKIDATA:
        image_ids = facts.get("commons_image_ids")
        if isinstance(image_ids, list):
            facts["commons_image_urls"] = [
                f"https://commons.wikimedia.org/wiki/Special:FilePath/{quote(image_id)}"
                for image_id in image_ids
                if isinstance(image_id, str) and image_id
            ]
    if record.source is SourceName.MUSICBRAINZ_WORKS:
        facts["work_type"] = record.payload.get("type")
        facts["work_attributes"] = record.payload.get("attributes") or []
        facts["work_relations"] = record.payload.get("relations") or []
    return facts
