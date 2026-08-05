from __future__ import annotations

import re
import unicodedata
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
    return tuple(identifiers)


def _extract_aliases(record: SourceRecord) -> tuple[str, ...]:
    if record.source is not SourceName.OPEN_OPUS:
        return ()
    complete_name = optional_string(record.payload.get("complete_name"))
    preferred_name = require_string(record.payload.get("name"), field="payload.name")
    if complete_name is None or normalize_name(complete_name) == normalize_name(preferred_name):
        return ()
    return (complete_name,)


def _extract_facts(record: SourceRecord) -> JsonObject:
    allowed_fields = {
        SourceName.MUSICBRAINZ: (
            "sort_name",
            "type",
            "country",
            "disambiguation",
            "life_span",
        ),
        SourceName.OPEN_OPUS: (
            "epoch",
            "birth",
            "death",
            "popular",
            "recommended",
        ),
        SourceName.WIKIDATA: (
            "date_of_birth",
            "date_of_death",
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
    return facts
