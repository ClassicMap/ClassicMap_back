from __future__ import annotations

import hashlib
import json
import re
from dataclasses import dataclass
from datetime import UTC, datetime
from enum import StrEnum
from pathlib import Path
from typing import Literal
from urllib.parse import urlparse

from pydantic import Field, field_validator, model_validator

from classicmap_seed.models import StrictModel

_QID_PATTERN = re.compile(r"^Q[1-9][0-9]*$")
_SHA256_PATTERN = re.compile(r"^[0-9a-f]{64}$")
_MAX_OVERRIDE_FILE_BYTES = 2 * 1024 * 1024


class ProjectionTarget(StrEnum):
    COMPOSER = "composer"
    ARTIST = "artist"


class ProjectionOverrideRecord(StrictModel):
    contract_version: Literal["projection-override-v1"] = "projection-override-v1"
    target: ProjectionTarget
    wikidata_qid: str
    field: Literal["nationality"]
    value: str = Field(min_length=1, max_length=200)
    reviewer: str = Field(min_length=1, max_length=200)
    reviewed_at: datetime
    evidence_url: str
    evidence_note: str = Field(min_length=1, max_length=2000)
    record_fingerprint: str

    @field_validator("wikidata_qid")
    @classmethod
    def validate_qid(cls, value: str) -> str:
        if not _QID_PATTERN.fullmatch(value):
            raise ValueError("wikidata_qid는 정규 QID여야 합니다.")
        return value

    @field_validator("value", "reviewer", "evidence_note")
    @classmethod
    def strip_non_empty(cls, value: str) -> str:
        stripped = value.strip()
        if not stripped:
            raise ValueError("수동 projection override 문자열은 비어 있을 수 없습니다.")
        return stripped

    @field_validator("reviewed_at")
    @classmethod
    def require_timezone(cls, value: datetime) -> datetime:
        if value.tzinfo is None:
            raise ValueError("reviewed_at에는 timezone이 필요합니다.")
        return value.astimezone(UTC)

    @field_validator("evidence_url")
    @classmethod
    def require_https_url(cls, value: str) -> str:
        parsed = urlparse(value)
        if parsed.scheme != "https" or not parsed.netloc:
            raise ValueError("evidence_url은 HTTPS URL이어야 합니다.")
        return value

    @field_validator("record_fingerprint")
    @classmethod
    def validate_record_fingerprint(cls, value: str) -> str:
        if not _SHA256_PATTERN.fullmatch(value):
            raise ValueError("record_fingerprint는 소문자 SHA-256이어야 합니다.")
        return value

    @model_validator(mode="after")
    def require_exact_fingerprint(self) -> ProjectionOverrideRecord:
        actual = projection_override_fingerprint(
            self.model_dump(mode="json", exclude={"record_fingerprint"})
        )
        if self.record_fingerprint != actual:
            raise ValueError("projection override record_fingerprint가 내용과 다릅니다.")
        return self

    @property
    def key(self) -> tuple[ProjectionTarget, str, str]:
        return (self.target, self.wikidata_qid, self.field)


@dataclass(frozen=True, slots=True)
class ProjectionOverrideSet:
    records: tuple[ProjectionOverrideRecord, ...]
    input_sha256: str

    def get(
        self,
        target: ProjectionTarget,
        wikidata_qid: str | None,
        field: str,
    ) -> ProjectionOverrideRecord | None:
        if wikidata_qid is None:
            return None
        return next(
            (record for record in self.records if record.key == (target, wikidata_qid, field)),
            None,
        )


def projection_override_fingerprint(payload: dict[str, object]) -> str:
    encoded = json.dumps(
        payload,
        ensure_ascii=False,
        sort_keys=True,
        separators=(",", ":"),
    ).encode()
    return hashlib.sha256(encoded).hexdigest()


def read_projection_overrides(path: Path) -> ProjectionOverrideSet:
    try:
        content = path.read_bytes()
    except OSError as error:
        raise ValueError(f"projection override 파일을 읽을 수 없습니다: {path}") from error
    if len(content) > _MAX_OVERRIDE_FILE_BYTES:
        raise ValueError("projection override 파일은 2 MiB 이하여야 합니다.")
    records: list[ProjectionOverrideRecord] = []
    seen: set[tuple[ProjectionTarget, str, str]] = set()
    for line_number, raw_line in enumerate(content.splitlines(), start=1):
        if not raw_line.strip():
            raise ValueError(f"projection override {line_number}행이 비어 있습니다.")
        try:
            record = ProjectionOverrideRecord.model_validate_json(raw_line)
        except ValueError as error:
            raise ValueError(f"projection override {line_number}행 계약 오류: {error}") from error
        if record.key in seen:
            raise ValueError(f"projection override {line_number}행 target/QID/field가 중복됩니다.")
        seen.add(record.key)
        records.append(record)
    if not records:
        raise ValueError("projection override 파일이 비어 있습니다.")
    return ProjectionOverrideSet(
        records=tuple(records),
        input_sha256=hashlib.sha256(content).hexdigest(),
    )
