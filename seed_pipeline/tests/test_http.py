import httpx

from classicmap_seed.http import JsonHttpClient, NoopRateLimiter, RetryPolicy


def test_retries_429_using_retry_after() -> None:
    call_count = 0
    delays: list[float] = []

    def handler(request: httpx.Request) -> httpx.Response:
        nonlocal call_count
        call_count += 1
        if call_count == 1:
            return httpx.Response(429, headers={"Retry-After": "2"}, request=request)
        return httpx.Response(200, json={"ok": True}, request=request)

    transport = httpx.MockTransport(handler)
    underlying = httpx.Client(transport=transport)
    client = JsonHttpClient(
        user_agent="ClassicMapSeed/test",
        rate_limiter=NoopRateLimiter(),
        retry_policy=RetryPolicy(max_attempts=2, max_delay_seconds=5),
        client=underlying,
        sleep=delays.append,
    )

    result = client.get_json("https://example.test/data")

    assert result == {"ok": True}
    assert call_count == 2
    assert delays == [2.0]
    underlying.close()
