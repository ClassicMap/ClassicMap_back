import httpx

from classicmap_seed.http import JsonHttpClient, NoopRateLimiter, RetryPolicy
from classicmap_seed.models import EntityKind, SourceName
from classicmap_seed.sources.musicbrainz import MusicBrainzConnector


def test_musicbrainz_connector_creates_small_typed_fixture() -> None:
    def handler(request: httpx.Request) -> httpx.Response:
        return httpx.Response(
            200,
            json={
                "artists": [
                    {
                        "id": "1f9df192-a621-4f54-8850-2c5373b7eac9",
                        "name": "Ludwig van Beethoven",
                        "sort-name": "Beethoven, Ludwig van",
                        "type": "Person",
                        "country": "DE",
                        "life-span": {"begin": "1770-12-17", "end": "1827-03-26"},
                    }
                ]
            },
            request=request,
        )

    underlying = httpx.Client(transport=httpx.MockTransport(handler))
    http_client = JsonHttpClient(
        user_agent="ClassicMapSeed/test",
        rate_limiter=NoopRateLimiter(),
        retry_policy=RetryPolicy(max_attempts=1),
        client=underlying,
    )
    connector = MusicBrainzConnector(http_client)

    records = connector.fetch(limit=1)

    assert len(records) == 1
    assert records[0].source is SourceName.MUSICBRAINZ
    assert records[0].entity_kind is EntityKind.PERSON
    assert records[0].payload["name"] == "Ludwig van Beethoven"
    underlying.close()
