from __future__ import annotations

import re
from datetime import UTC, datetime
from enum import StrEnum
from pathlib import Path
from typing import Literal

from pydantic import BaseModel, ConfigDict, Field, field_validator, model_validator

type JsonScalar = str | int | float | bool | None
type JsonValue = JsonScalar | list[JsonValue] | dict[str, JsonValue]
type JsonObject = dict[str, JsonValue]

_RUN_ID_PATTERN = re.compile(r"^[A-Za-z0-9][A-Za-z0-9._-]{0,127}$")
_SHA256_PATTERN = re.compile(r"^[0-9a-f]{64}$")


class StrictModel(BaseModel):
    model_config = ConfigDict(extra="forbid", frozen=True)


class SourceName(StrEnum):
    MUSICBRAINZ = "musicbrainz"
    OPEN_OPUS = "open-opus"
    WIKIDATA = "wikidata"


class ArtifactStage(StrEnum):
    RAW = "raw"
    NORMALIZED = "normalized"
    RESOLVED = "resolved"


class EntityKind(StrEnum):
    PERSON = "person"
    ENSEMBLE = "ensemble"
    ORCHESTRA = "orchestra"
    CHOIR = "choir"
    ORGANIZATION = "organization"
    WORK = "work"
    RECORDING = "recording"
    UNKNOWN = "unknown"


class IdentifierStrength(StrEnum):
    STRONG = "strong"
    WEAK = "weak"


class ResolutionAction(StrEnum):
    AUTO_MATCH = "auto_match"
    CREATE = "create"
    REVIEW_REQUIRED = "review_required"


class RunOptions(StrictModel):
    run_id: str
    dry_run: bool = False
    resume: bool = True
    limit: int = Field(default=20, ge=1, le=100_000)
    json_report: Path | None = None

    @field_validator("run_id")
    @classmethod
    def validate_run_id(cls, value: str) -> str:
        normalized = value.strip()
        if not _RUN_ID_PATTERN.fullmatch(normalized):
            raise ValueError("run_id는 영문자 또는 숫자로 시작하는 안전한 경로 이름이어야 합니다.")
        return normalized


class SourceMetadata(StrictModel):
    source: SourceName
    source_uri: str
    license: str
    license_uri: str


class SourceRecord(StrictModel):
    source: SourceName
    source_record_id: str
    entity_kind: EntityKind
    payload: JsonObject


class ExternalIdentifier(StrictModel):
    namespace: str
    value: str
    strength: IdentifierStrength
    source: SourceName


class NormalizedEntityCandidate(StrictModel):
    candidate_id: str
    source: SourceName
    source_record_id: str
    entity_kind: EntityKind
    preferred_name: str
    normalized_name: str
    aliases: tuple[str, ...] = ()
    external_identifiers: tuple[ExternalIdentifier, ...] = ()
    facts: JsonObject = Field(default_factory=dict)


class ResolutionDecision(StrictModel):
    decision_id: str
    action: ResolutionAction
    candidate_ids: tuple[str, ...]
    reason_code: str
    evidence: tuple[str, ...] = ()


class SnapshotManifest(StrictModel):
    schema_version: Literal["1"] = "1"
    run_id: str
    stage: ArtifactStage
    source: SourceName
    snapshot_id: str
    retrieved_at: datetime
    source_uri: str
    license: str
    license_uri: str
    sha256: str
    row_count: int = Field(ge=0)
    relative_data_path: str
    parent_sha256: str | None = None
    tool_version: str

    @field_validator("retrieved_at")
    @classmethod
    def require_timezone(cls, value: datetime) -> datetime:
        if value.tzinfo is None:
            raise ValueError("retrieved_at에는 timezone이 필요합니다.")
        return value.astimezone(UTC)

    @field_validator("sha256", "snapshot_id")
    @classmethod
    def validate_sha256(cls, value: str) -> str:
        if not _SHA256_PATTERN.fullmatch(value):
            raise ValueError("SHA-256은 소문자 64자리 16진수여야 합니다.")
        return value

    @field_validator("relative_data_path")
    @classmethod
    def validate_relative_data_path(cls, value: str) -> str:
        path = Path(value)
        if path.is_absolute() or len(path.parts) != 1 or path.name != value:
            raise ValueError("relative_data_path는 manifest와 같은 디렉터리의 파일명이어야 합니다.")
        if path.suffix != ".jsonl":
            raise ValueError("relative_data_path는 .jsonl 파일이어야 합니다.")
        return value

    @model_validator(mode="after")
    def require_snapshot_content_identity(self) -> SnapshotManifest:
        if self.snapshot_id != self.sha256:
            raise ValueError("snapshot_id는 JSONL SHA-256과 같아야 합니다.")
        return self


class ArtifactWriteResult(StrictModel):
    manifest: SnapshotManifest
    data_path: Path
    manifest_path: Path
    created: bool
    mutation_count: int = Field(ge=0)


class CommandReport(StrictModel):
    command: str
    run_id: str
    dry_run: bool
    input_count: int = Field(ge=0)
    output_count: int = Field(ge=0)
    mutation_count: int = Field(ge=0)
    data_path: str | None = None
    manifest_path: str | None = None
    notes: tuple[str, ...] = ()
