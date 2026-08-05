from classicmap_seed.models import EntityKind, IdentifierStrength, SourceName, SourceRecord
from classicmap_seed.normalize.entities import normalize_name, normalize_record


def test_normalizes_unicode_whitespace_and_preserves_source_id() -> None:
    record = SourceRecord(
        source=SourceName.WIKIDATA,
        source_record_id="Q255",
        entity_kind=EntityKind.PERSON,
        payload={
            "name": "  루트비히   판 베토벤  ",
            "date_of_birth": "1770-12-17",
            "musicbrainz_artist_id": "1f9df192-a621-4f54-8850-2c5373b7eac9",
        },
    )

    candidate = normalize_record(record)

    assert candidate.preferred_name == "루트비히   판 베토벤"
    assert candidate.normalized_name == "루트비히 판 베토벤"
    assert candidate.external_identifiers[0].namespace == "wikidata"
    assert candidate.external_identifiers[0].strength is IdentifierStrength.STRONG
    assert candidate.external_identifiers[1].namespace == "musicbrainz_artist"
    assert candidate.facts == {
        "date_of_birth": "1770-12-17",
        "musicbrainz_artist_id": "1f9df192-a621-4f54-8850-2c5373b7eac9",
    }


def test_open_opus_identifier_is_not_strong_merge_evidence() -> None:
    record = SourceRecord(
        source=SourceName.OPEN_OPUS,
        source_record_id="87",
        entity_kind=EntityKind.PERSON,
        payload={
            "name": "L. Beethoven",
            "complete_name": "Ludwig van Beethoven",
            "epoch": "Classical",
        },
    )

    candidate = normalize_record(record)

    assert candidate.aliases == ("Ludwig van Beethoven",)
    assert candidate.external_identifiers[0].strength is IdentifierStrength.WEAK
    assert normalize_name("\uff21  B") == "a b"
