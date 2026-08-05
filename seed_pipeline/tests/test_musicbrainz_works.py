from datetime import UTC, datetime
from pathlib import Path

import httpx

from classicmap_seed.artifacts import JsonlArtifactStore
from classicmap_seed.export import build_canonical_load_bundle
from classicmap_seed.http import JsonHttpClient, NoopRateLimiter, RetryPolicy
from classicmap_seed.load import canonical_seed_run_id
from classicmap_seed.models import (
    ArtifactStage,
    CanonicalLoadRecord,
    LoadForeignKey,
    LoadTable,
    ResolutionAction,
    ResolutionDecision,
    SnapshotManifest,
    SourceMetadata,
    SourceName,
)
from classicmap_seed.normalize import normalize_records
from classicmap_seed.sources.musicbrainz_work_input import (
    read_verified_musicbrainz_artist_ids,
)
from classicmap_seed.sources.musicbrainz_works import MusicBrainzWorkConnector

_COMPOSER_MBID = "1f9df192-a621-4f54-8850-2c5373b7eac9"
_PARENT_MBID = "00000000-0000-0000-0000-000000000001"
_CHILD_MBID = "00000000-0000-0000-0000-000000000002"


def _connector(handler: httpx.MockTransport) -> tuple[MusicBrainzWorkConnector, httpx.Client]:
    underlying = httpx.Client(transport=handler)
    client = JsonHttpClient(
        user_agent="ClassicMapSeed/test",
        rate_limiter=NoopRateLimiter(),
        retry_policy=RetryPolicy(max_attempts=1),
        client=underlying,
    )
    return MusicBrainzWorkConnector(client), underlying


def test_musicbrainz_work_browse_paginates_and_preserves_work_contract() -> None:
    offsets: list[str] = []

    def handler(request: httpx.Request) -> httpx.Response:
        offsets.append(request.url.params["offset"])
        work = _parent_work() if request.url.params["offset"] == "0" else _child_work()
        return httpx.Response(
            200,
            json={
                "work-count": 2,
                "work-offset": int(request.url.params["offset"]),
                "works": [work],
            },
            request=request,
        )

    connector, underlying = _connector(httpx.MockTransport(handler))
    first = connector.fetch_page(artist_mbid=_COMPOSER_MBID, offset=0, page_size=1)
    second = connector.fetch_page(
        artist_mbid=_COMPOSER_MBID,
        offset=int(first.next_cursor or "0"),
        page_size=1,
    )

    assert offsets == ["0", "1"]
    assert first.next_cursor == "1"
    assert second.complete is True
    parent = first.records[0]
    assert parent.source is SourceName.MUSICBRAINZ_WORKS
    assert parent.payload["iswcs"] == ["T-000.000.001-0"]
    assert parent.payload["composer_mbids"] == [_COMPOSER_MBID]
    assert parent.payload["catalogue_attributes"] == [{"type": "Work catalogue", "value": "Op. 1"}]
    underlying.close()


def test_musicbrainz_work_normalize_and_export_maps_piece_part_and_identifiers() -> None:
    def handler(request: httpx.Request) -> httpx.Response:
        offset = int(request.url.params["offset"])
        works = [_parent_work(), _child_work()][offset : offset + 1]
        return httpx.Response(
            200,
            json={"work-count": 2, "work-offset": offset, "works": works},
            request=request,
        )

    connector, underlying = _connector(httpx.MockTransport(handler))
    raw_records = [
        *connector.fetch_page(artist_mbid=_COMPOSER_MBID, offset=0, page_size=1).records,
        *connector.fetch_page(artist_mbid=_COMPOSER_MBID, offset=1, page_size=1).records,
    ]
    candidates = normalize_records(raw_records)
    decisions = [
        ResolutionDecision(
            decision_id=f"decision-{candidate.source_record_id}",
            action=ResolutionAction.CREATE,
            candidate_ids=(candidate.candidate_id,),
            reason_code="NO_MATCHING_STABLE_IDENTIFIER",
        )
        for candidate in candidates
    ]
    bundle = build_canonical_load_bundle(
        run_id="work-run",
        source_manifest=_manifest(row_count=2),
        raw_records=raw_records,
        candidates=candidates,
        decisions=decisions,
    )

    assert any(
        record.table is LoadTable.PIECES
        and record.natural_key == f"musicbrainz_work:{_PARENT_MBID}"
        for record in bundle
    )
    identifiers = [record for record in bundle if record.table is LoadTable.PIECE_IDENTIFIERS]
    assert {record.values["namespace"] for record in identifiers} == {
        "musicbrainz_work",
        "iswc",
        "work_catalogue",
    }
    part = next(record for record in bundle if record.table is LoadTable.PIECE_PARTS)
    assert any(
        foreign_key.column == "piece_id"
        and foreign_key.target_natural_key == f"musicbrainz_work:{_PARENT_MBID}"
        for foreign_key in part.foreign_keys
    )
    underlying.close()


def test_verified_artist_manifest_accepts_only_strong_authority_mbid(tmp_path: Path) -> None:
    seed_run_id = canonical_seed_run_id("artist-run")
    authority_id = "11111111-1111-1111-1111-111111111111"
    records = [
        CanonicalLoadRecord(
            seed_run_id=seed_run_id,
            table=LoadTable.AUTHORITY_ENTITIES,
            natural_key=authority_id,
            values={"id": authority_id, "entity_kind": "person"},
        ),
        CanonicalLoadRecord(
            seed_run_id=seed_run_id,
            table=LoadTable.EXTERNAL_IDENTIFIERS,
            natural_key=f"musicbrainz_artist:{_COMPOSER_MBID}",
            values={"namespace": "musicbrainz_artist", "external_id": _COMPOSER_MBID},
            foreign_keys=(
                LoadForeignKey(
                    column="authority_entity_id",
                    target_table=LoadTable.AUTHORITY_ENTITIES,
                    target_natural_key=authority_id,
                ),
            ),
            evidence={"strength": "strong"},
        ),
    ]
    result = JsonlArtifactStore(tmp_path, tool_version="test").write(
        run_id="artist-run",
        stage=ArtifactStage.CANONICAL,
        metadata=SourceMetadata(
            source=SourceName.WIKIDATA,
            source_uri="https://query.wikidata.org/sparql",
            license="CC0-1.0",
            license_uri="https://www.wikidata.org/wiki/Wikidata:Licensing",
        ),
        records=records,
        retrieved_at=datetime(2026, 8, 5, tzinfo=UTC),
        dry_run=False,
        resume=True,
    )

    assert read_verified_musicbrainz_artist_ids(result.manifest_path) == (_COMPOSER_MBID,)


def _manifest(*, row_count: int) -> SnapshotManifest:
    digest = "b" * 64
    return SnapshotManifest(
        run_id="work-run",
        stage=ArtifactStage.RAW,
        source=SourceName.MUSICBRAINZ_WORKS,
        snapshot_id=digest,
        retrieved_at=datetime(2026, 8, 5, tzinfo=UTC),
        source_uri="https://musicbrainz.org/ws/2/work",
        license="MusicBrainz core data: CC0-1.0",
        license_uri="https://musicbrainz.org/doc/About/Data_License",
        sha256=digest,
        row_count=row_count,
        relative_data_path=f"{digest}.jsonl",
        tool_version="test",
    )


def _parent_work() -> dict[str, object]:
    return {
        "id": _PARENT_MBID,
        "title": "Piano Concerto No. 1",
        "type": "Concerto",
        "languages": ["zxx"],
        "iswcs": ["T-000.000.001-0"],
        "aliases": [{"name": "Concerto No. 1", "locale": "en"}],
        "attributes": [{"type": "Work catalogue", "value": "Op. 1"}],
        "relations": [
            {
                "type": "composer",
                "direction": "backward",
                "target-type": "artist",
                "artist": {"id": _COMPOSER_MBID, "name": "Fixture Composer"},
            },
            {
                "type": "parts",
                "direction": "forward",
                "target-type": "work",
                "ordering-key": 1,
                "work": {"id": _CHILD_MBID, "title": "I. Allegro"},
            },
        ],
    }


def _child_work() -> dict[str, object]:
    return {
        "id": _CHILD_MBID,
        "title": "I. Allegro",
        "type": "Movement",
        "languages": ["zxx"],
        "iswcs": [],
        "aliases": [],
        "attributes": [],
        "relations": [
            {
                "type": "parts",
                "direction": "backward",
                "target-type": "work",
                "ordering-key": 1,
                "work": {"id": _PARENT_MBID, "title": "Piano Concerto No. 1"},
            }
        ],
    }
