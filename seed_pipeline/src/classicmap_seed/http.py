from __future__ import annotations

import time
from collections.abc import Callable, Mapping
from dataclasses import dataclass
from threading import Lock
from typing import Protocol

import httpx
from pydantic import TypeAdapter

from classicmap_seed.models import JsonValue

_JSON_ADAPTER: TypeAdapter[JsonValue] = TypeAdapter(JsonValue)


class RateLimiter(Protocol):
    def wait(self) -> None: ...


class NoopRateLimiter:
    def wait(self) -> None:
        return


class FixedIntervalRateLimiter:
    def __init__(
        self,
        requests_per_second: float,
        *,
        monotonic: Callable[[], float] = time.monotonic,
        sleep: Callable[[float], None] = time.sleep,
    ) -> None:
        if requests_per_second <= 0:
            raise ValueError("requests_per_second는 0보다 커야 합니다.")
        self._interval = 1 / requests_per_second
        self._monotonic = monotonic
        self._sleep = sleep
        self._next_allowed_at = 0.0
        self._lock = Lock()

    def wait(self) -> None:
        with self._lock:
            now = self._monotonic()
            delay = self._next_allowed_at - now
            if delay > 0:
                self._sleep(delay)
                now = self._monotonic()
            self._next_allowed_at = max(now, self._next_allowed_at) + self._interval


@dataclass(frozen=True, slots=True)
class RetryPolicy:
    max_attempts: int = 4
    base_delay_seconds: float = 0.5
    max_delay_seconds: float = 8.0

    def __post_init__(self) -> None:
        if self.max_attempts < 1:
            raise ValueError("max_attempts는 1 이상이어야 합니다.")
        if self.base_delay_seconds < 0 or self.max_delay_seconds < 0:
            raise ValueError("retry delay는 음수일 수 없습니다.")


class JsonHttpClient:
    def __init__(
        self,
        *,
        user_agent: str,
        rate_limiter: RateLimiter,
        retry_policy: RetryPolicy | None = None,
        client: httpx.Client | None = None,
        sleep: Callable[[float], None] = time.sleep,
        timeout_seconds: float = 30.0,
    ) -> None:
        if not user_agent.strip():
            raise ValueError("user_agent는 비어 있을 수 없습니다.")
        self._rate_limiter = rate_limiter
        self._retry_policy = retry_policy or RetryPolicy()
        self._sleep = sleep
        self._owns_client = client is None
        self._client = client or httpx.Client(
            headers={"User-Agent": user_agent, "Accept": "application/json"},
            timeout=timeout_seconds,
            follow_redirects=True,
        )

    def close(self) -> None:
        if self._owns_client:
            self._client.close()

    def __enter__(self) -> JsonHttpClient:
        return self

    def __exit__(self, exc_type: object, exc_value: object, traceback: object) -> None:
        self.close()

    def get_json(
        self,
        url: str,
        *,
        params: Mapping[str, str | int] | None = None,
    ) -> JsonValue:
        attempts = self._retry_policy.max_attempts
        last_transport_error: httpx.TransportError | None = None

        for attempt in range(1, attempts + 1):
            self._rate_limiter.wait()
            try:
                response = self._client.get(url, params=params)
            except httpx.TransportError as error:
                last_transport_error = error
                if attempt == attempts:
                    raise
                self._sleep(self._retry_delay(attempt, None))
                continue

            if (response.status_code == 429 or response.status_code >= 500) and attempt < attempts:
                self._sleep(self._retry_delay(attempt, response))
                continue

            response.raise_for_status()
            return _JSON_ADAPTER.validate_json(response.content)

        if last_transport_error is not None:
            raise last_transport_error
        raise RuntimeError("HTTP retry 상태가 비정상적으로 종료되었습니다.")

    def _retry_delay(self, attempt: int, response: httpx.Response | None) -> float:
        if response is not None:
            retry_after = response.headers.get("Retry-After")
            if retry_after is not None:
                try:
                    return min(float(retry_after), self._retry_policy.max_delay_seconds)
                except ValueError:
                    pass
        exponential: float = self._retry_policy.base_delay_seconds * (2 ** (attempt - 1))
        return min(exponential, self._retry_policy.max_delay_seconds)
