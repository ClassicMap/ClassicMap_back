from __future__ import annotations

from typing import Protocol

from classicmap_seed.models import JsonObject, JsonValue, SourceMetadata, SourceRecord


class SourceConnector(Protocol):
    @property
    def metadata(self) -> SourceMetadata: ...

    def fetch(self, *, limit: int) -> list[SourceRecord]: ...


class SourcePayloadError(RuntimeError):
    """공식 source 응답이 예상 계약과 다를 때 발생합니다."""


def require_object(value: JsonValue, *, field: str) -> JsonObject:
    if not isinstance(value, dict):
        raise SourcePayloadError(f"{field}는 JSON object여야 합니다.")
    return value


def require_list(value: JsonValue, *, field: str) -> list[JsonValue]:
    if not isinstance(value, list):
        raise SourcePayloadError(f"{field}는 JSON array여야 합니다.")
    return value


def require_string(value: JsonValue, *, field: str) -> str:
    if not isinstance(value, str) or not value.strip():
        raise SourcePayloadError(f"{field}는 비어 있지 않은 문자열이어야 합니다.")
    return value


def optional_string(value: JsonValue) -> str | None:
    if isinstance(value, str) and value.strip():
        return value
    return None
