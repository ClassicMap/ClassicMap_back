from __future__ import annotations

import hashlib
import json
import os
import re
import sqlite3
import tarfile
from collections.abc import Iterable, Iterator, Sequence
from contextlib import AbstractContextManager
from dataclasses import dataclass
from datetime import UTC, date, datetime
from pathlib import Path
from tempfile import NamedTemporaryFile, TemporaryDirectory
from typing import IO, ClassVar, Literal

from pydantic import Field, ValidationError, field_validator, model_validator

from classicmap_seed.artifacts import JsonlArtifactStore, read_artifact
from classicmap_seed.models import (
    ArtifactStage,
    CommandReport,
    EntityKind,
    InputFileProvenance,
    JsonObject,
    JsonValue,
    SourceMetadata,
    SourceName,
    SourceRecord,
    StrictModel,
)

_OFFICIAL_DUMP_URL = re.compile(
    r"^https://data\.metabrainz\.org/pub/musicbrainz/data/fullexport/"
    r"(?P<export_id>[0-9]{8}-[0-9]{6})/mbdump\.tar\.bz2$"
)
_MBID_PATTERN = re.compile(
    r"^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$"
)
_ISRC_PATTERN = re.compile(r"^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$")
_ISWC_PATTERN = re.compile(r"^T-?[0-9]{3}\.?[0-9]{3}\.?[0-9]{3}[-.]?[0-9]$")
_HASH_CHUNK_SIZE = 1024 * 1024
_MAX_METADATA_BYTES = 1024 * 1024
_MAX_COPY_LINE_BYTES = 16 * 1024 * 1024
_INDEX_COMMIT_INTERVAL = 50_000
_EXPECTED_SCHEMA_SEQUENCE = 31
_COMPOSER_RELATION_TYPE_MBID = "d59d99ea-23d4-4a80-b066-edca32ee158f"
_PERFORMANCE_RELATION_TYPE_MBID = "a3005666-a872-32c3-ad06-98af558e99b0"


class MusicBrainzDumpReleaseMetadata(StrictModel):
    schema_version: Literal["1"] = "1"
    release_date: date
    source_url: str
    sha256: str
    size_bytes: int = Field(ge=1)

    @field_validator("sha256")
    @classmethod
    def validate_sha256(cls, value: str) -> str:
        if not re.fullmatch(r"[0-9a-f]{64}", value):
            raise ValueError("dump sha256은 소문자 64자리 16진수여야 합니다.")
        return value

    @model_validator(mode="after")
    def require_official_dated_source(self) -> MusicBrainzDumpReleaseMetadata:
        matched = _OFFICIAL_DUMP_URL.fullmatch(self.source_url)
        if matched is None:
            raise ValueError(
                "source_url은 timestamp가 고정된 공식 MusicBrainz fullexport URL이어야 합니다."
            )
        url_date = datetime.strptime(matched.group("export_id")[:8], "%Y%m%d").date()
        if url_date != self.release_date:
            raise ValueError("source_url export 날짜와 release_date가 일치해야 합니다.")
        return self

    def to_input_provenance(self) -> InputFileProvenance:
        return InputFileProvenance(
            sha256=self.sha256,
            size_bytes=self.size_bytes,
            dump_date=self.release_date,
            source_url=self.source_url,
        )


class MusicBrainzDumpMalformedReview(StrictModel):
    review_kind: Literal["malformed"] = "malformed"
    entity_kind: EntityKind
    musicbrainz_internal_id: int = Field(ge=1)
    entity_ordinal: int = Field(ge=0)
    member_name: str
    row_number: int = Field(ge=1)
    reason_code: str
    evidence: JsonObject


class MusicBrainzDumpUnresolvedReview(StrictModel):
    review_kind: Literal["unresolved"] = "unresolved"
    entity_kind: EntityKind
    musicbrainz_internal_id: int = Field(ge=1)
    entity_mbid: str
    entity_ordinal: int = Field(ge=0)
    reason_code: str
    evidence: JsonObject


class MusicBrainzDumpCheckpoint(StrictModel):
    schema_version: Literal["1"] = "1"
    run_id: str
    input_provenance: InputFileProvenance
    partition_start_ordinal: int = Field(ge=0)
    partition_end_ordinal: int | None = Field(default=None, ge=1)
    next_ordinal: int = Field(ge=0)
    record_manifest_paths: tuple[str, ...] = ()
    malformed_manifest_paths: tuple[str, ...] = ()
    unresolved_manifest_paths: tuple[str, ...] = ()
    record_count: int = Field(default=0, ge=0)
    malformed_count: int = Field(default=0, ge=0)
    unresolved_count: int = Field(default=0, ge=0)
    complete: bool = False


class MusicBrainzDumpCommandReport(CommandReport):
    command: Literal["snapshot-musicbrainz-dump"] = "snapshot-musicbrainz-dump"
    input_sha256: str
    input_size_bytes: int
    release_date: date
    source_url: str
    partition_start_ordinal: int
    partition_end_ordinal: int | None
    next_ordinal: int
    complete: bool
    scanned_entity_count: int = Field(ge=0)
    malformed_count: int = Field(ge=0)
    unresolved_count: int = Field(ge=0)
    resumed_output_count: int = Field(ge=0)
    resumed_malformed_count: int = Field(ge=0)
    resumed_unresolved_count: int = Field(ge=0)
    data_path: str
    manifest_path: str
    malformed_data_path: str | None = None
    malformed_manifest_path: str | None = None
    unresolved_data_path: str | None = None
    unresolved_manifest_path: str | None = None


@dataclass(frozen=True, slots=True)
class MusicBrainzDumpCollectionResult:
    records: tuple[SourceRecord, ...]
    malformed_reviews: tuple[MusicBrainzDumpMalformedReview, ...]
    unresolved_reviews: tuple[MusicBrainzDumpUnresolvedReview, ...]
    next_ordinal: int
    scanned_entity_count: int
    resumed_record_count: int
    resumed_malformed_count: int
    resumed_unresolved_count: int
    artifact_mutation_count: int
    complete: bool


@dataclass(frozen=True, slots=True)
class _IndexedEntity:
    ordinal: int
    entity_kind: EntityKind
    internal_id: int


@dataclass(frozen=True, slots=True)
class _EntityResult:
    record: SourceRecord | None
    malformed: tuple[MusicBrainzDumpMalformedReview, ...]
    unresolved: tuple[MusicBrainzDumpUnresolvedReview, ...]


def read_musicbrainz_dump_release_metadata(path: Path) -> MusicBrainzDumpReleaseMetadata:
    try:
        with path.open("rb") as source:
            content = source.read(_MAX_METADATA_BYTES + 1)
    except OSError as error:
        raise ValueError(f"release metadata를 읽을 수 없습니다: {path}") from error
    if len(content) > _MAX_METADATA_BYTES:
        raise ValueError("release metadata는 1 MiB 이하여야 합니다.")
    try:
        return MusicBrainzDumpReleaseMetadata.model_validate_json(content)
    except ValidationError as error:
        raise ValueError(f"MusicBrainz dump release metadata 계약 오류: {error}") from error


def verify_musicbrainz_dump_input(
    input_path: Path,
    release: MusicBrainzDumpReleaseMetadata,
) -> InputFileProvenance:
    if input_path.name != "mbdump.tar.bz2":
        raise ValueError("MusicBrainz dump 입력 파일명은 mbdump.tar.bz2여야 합니다.")
    try:
        size_bytes = input_path.stat().st_size
    except OSError as error:
        raise ValueError(f"MusicBrainz dump 입력을 읽을 수 없습니다: {input_path}") from error
    if size_bytes != release.size_bytes:
        raise ValueError(
            f"MusicBrainz dump 파일 크기 불일치: metadata={release.size_bytes} actual={size_bytes}"
        )
    actual_sha256 = _sha256_file(input_path)
    if actual_sha256 != release.sha256:
        raise ValueError(
            f"MusicBrainz dump SHA-256 불일치: metadata={release.sha256} actual={actual_sha256}"
        )
    return release.to_input_provenance()


def musicbrainz_dump_metadata(provenance: InputFileProvenance) -> SourceMetadata:
    return SourceMetadata(
        source=SourceName.MUSICBRAINZ_DUMP,
        source_uri=provenance.source_url,
        license="CC0-1.0",
        license_uri="https://musicbrainz.org/doc/About/Data_License",
    )


def musicbrainz_dump_retrieved_at(provenance: InputFileProvenance) -> datetime:
    matched = _OFFICIAL_DUMP_URL.fullmatch(provenance.source_url)
    if matched is None:
        raise ValueError("MusicBrainz dump provenance URL이 공식 fullexport 형식이 아닙니다.")
    parsed = datetime.strptime(matched.group("export_id"), "%Y%m%d-%H%M%S")
    return parsed.replace(tzinfo=UTC)


def _sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as source:
        while chunk := source.read(_HASH_CHUNK_SIZE):
            digest.update(chunk)
    return digest.hexdigest()


def _decode_copy_field(raw: bytes) -> str | None:
    if raw == b"\\N":
        return None
    decoded = bytearray()
    index = 0
    simple_escapes = {
        ord("b"): 8,
        ord("f"): 12,
        ord("n"): 10,
        ord("r"): 13,
        ord("t"): 9,
        ord("v"): 11,
        ord("\\"): 92,
    }
    while index < len(raw):
        value = raw[index]
        if value != 92:
            decoded.append(value)
            index += 1
            continue
        index += 1
        if index >= len(raw):
            raise ValueError("COPY field가 단독 backslash로 끝납니다.")
        escaped = raw[index]
        if escaped in simple_escapes:
            decoded.append(simple_escapes[escaped])
            index += 1
            continue
        if 48 <= escaped <= 55:
            end = index
            while end < len(raw) and end < index + 3 and 48 <= raw[end] <= 55:
                end += 1
            decoded.append(int(raw[index:end], 8))
            index = end
            continue
        decoded.append(escaped)
        index += 1
    try:
        return decoded.decode("utf-8")
    except UnicodeDecodeError as error:
        raise ValueError("COPY field가 UTF-8이 아닙니다.") from error


def _iter_copy_rows(source: IO[bytes], member_name: str) -> Iterator[tuple[int, list[str | None]]]:
    row_number = 0
    while True:
        line = source.readline(_MAX_COPY_LINE_BYTES + 1)
        if not line:
            break
        row_number += 1
        if len(line) > _MAX_COPY_LINE_BYTES and not line.endswith(b"\n"):
            raise ValueError(
                f"{member_name} {row_number}행이 {_MAX_COPY_LINE_BYTES} byte 제한을 넘었습니다."
            )
        line = line.removesuffix(b"\n").removesuffix(b"\r")
        if line == b"\\.":
            break
        try:
            yield row_number, [_decode_copy_field(field) for field in line.split(b"\t")]
        except ValueError as error:
            raise ValueError(f"{member_name} {row_number}행 COPY decode 오류: {error}") from error


def _required_text(fields: list[str | None], index: int, field_name: str) -> str:
    if index >= len(fields):
        raise ValueError(f"필수 column 누락: {field_name}")
    value = fields[index]
    if value is None or not value:
        raise ValueError(f"필수 값 누락: {field_name}")
    return value


def _required_int(fields: list[str | None], index: int, field_name: str) -> int:
    value = _required_text(fields, index, field_name)
    try:
        parsed = int(value)
    except ValueError as error:
        raise ValueError(f"정수 형식 오류: {field_name}") from error
    if parsed < 1:
        raise ValueError(f"양의 정수 필요: {field_name}")
    return parsed


def _optional_int(fields: list[str | None], index: int, field_name: str) -> int | None:
    if index >= len(fields) or fields[index] is None:
        return None
    return _required_int(fields, index, field_name)


def _required_nonnegative_int(fields: list[str | None], index: int, field_name: str) -> int:
    value = _required_text(fields, index, field_name)
    try:
        parsed = int(value)
    except ValueError as error:
        raise ValueError(f"정수 형식 오류: {field_name}") from error
    if parsed < 0:
        raise ValueError(f"0 이상 정수 필요: {field_name}")
    return parsed


def _optional_nonnegative_int(fields: list[str | None], index: int, field_name: str) -> int | None:
    if index >= len(fields) or fields[index] is None:
        return None
    return _required_nonnegative_int(fields, index, field_name)


def _require_mbid(value: str, field_name: str) -> str:
    if not _MBID_PATTERN.fullmatch(value):
        raise ValueError(f"canonical MBID 형식 오류: {field_name}")
    return value


def _json_strings(values: Iterable[str]) -> list[JsonValue]:
    return [value for value in values]


def _json_objects(values: Iterable[JsonObject]) -> list[JsonValue]:
    return [value for value in values]


class _MusicBrainzDumpIndex(AbstractContextManager["_MusicBrainzDumpIndex"]):
    _MEMBERS: ClassVar[dict[str, str]] = {
        "mbdump/SCHEMA_SEQUENCE": "schema_sequence",
        "mbdump/artist": "artist",
        "mbdump/artist_credit": "artist_credit",
        "mbdump/artist_credit_name": "artist_credit_name",
        "mbdump/recording": "recording",
        "mbdump/isrc": "isrc",
        "mbdump/work": "work",
        "mbdump/iswc": "iswc",
        "mbdump/work_type": "work_type",
        "mbdump/link": "link",
        "mbdump/link_type": "link_type",
        "mbdump/l_recording_work": "l_recording_work",
        "mbdump/l_artist_work": "l_artist_work",
    }

    def __init__(
        self,
        *,
        input_path: Path,
        provenance: InputFileProvenance,
        artifacts_root: Path,
        dry_run: bool,
    ) -> None:
        self._input_path = input_path
        self._provenance = provenance
        self._temporary_directory: TemporaryDirectory[str] | None = None
        if dry_run:
            self._temporary_directory = TemporaryDirectory(prefix="classicmap-mb-index-")
            index_path = Path(self._temporary_directory.name) / "musicbrainz.sqlite"
        else:
            index_path = artifacts_root / "_indexes" / "musicbrainz" / f"{provenance.sha256}.sqlite"
            index_path.parent.mkdir(parents=True, exist_ok=True)
        self._connection = sqlite3.connect(index_path)
        self._connection.row_factory = sqlite3.Row
        try:
            self._initialize_schema()
            self._build_or_resume()
        except Exception:
            self._connection.close()
            if self._temporary_directory is not None:
                self._temporary_directory.cleanup()
            raise

    def __exit__(
        self,
        exc_type: type[BaseException] | None,
        exc_value: BaseException | None,
        traceback: object,
    ) -> None:
        self._connection.close()
        if self._temporary_directory is not None:
            self._temporary_directory.cleanup()

    def _initialize_schema(self) -> None:
        self._connection.executescript(
            """
            CREATE TABLE IF NOT EXISTS metadata (
              key TEXT PRIMARY KEY,
              value TEXT NOT NULL
            );
            CREATE TABLE IF NOT EXISTS artists (
              internal_id INTEGER PRIMARY KEY,
              mbid TEXT,
              name TEXT
            );
            CREATE TABLE IF NOT EXISTS artist_credits (
              internal_id INTEGER PRIMARY KEY,
              mbid TEXT,
              name TEXT,
              artist_count INTEGER NOT NULL
            );
            CREATE TABLE IF NOT EXISTS artist_credit_names (
              credit_id INTEGER NOT NULL,
              position INTEGER NOT NULL,
              artist_id INTEGER NOT NULL,
              credited_name TEXT NOT NULL,
              join_phrase TEXT NOT NULL,
              PRIMARY KEY (credit_id, position)
            ) WITHOUT ROWID;
            CREATE INDEX IF NOT EXISTS artist_credit_names_artist_idx
              ON artist_credit_names(artist_id);
            CREATE TABLE IF NOT EXISTS work_types (
              internal_id INTEGER PRIMARY KEY,
              mbid TEXT,
              name TEXT
            );
            CREATE TABLE IF NOT EXISTS works (
              internal_id INTEGER PRIMARY KEY,
              mbid TEXT,
              name TEXT,
              type_id INTEGER,
              comment TEXT,
              member_name TEXT NOT NULL,
              row_number INTEGER NOT NULL
            );
            CREATE TABLE IF NOT EXISTS recordings (
              internal_id INTEGER PRIMARY KEY,
              mbid TEXT,
              name TEXT,
              artist_credit_id INTEGER,
              duration_ms INTEGER,
              comment TEXT,
              member_name TEXT NOT NULL,
              row_number INTEGER NOT NULL
            );
            CREATE TABLE IF NOT EXISTS isrcs (
              recording_id INTEGER NOT NULL,
              isrc TEXT NOT NULL,
              PRIMARY KEY (recording_id, isrc)
            ) WITHOUT ROWID;
            CREATE TABLE IF NOT EXISTS iswcs (
              work_id INTEGER NOT NULL,
              iswc TEXT NOT NULL,
              PRIMARY KEY (work_id, iswc)
            ) WITHOUT ROWID;
            CREATE TABLE IF NOT EXISTS link_types (
              internal_id INTEGER PRIMARY KEY,
              mbid TEXT,
              entity_type0 TEXT,
              entity_type1 TEXT,
              name TEXT,
              link_phrase TEXT,
              reverse_link_phrase TEXT,
              is_deprecated INTEGER NOT NULL
            );
            CREATE TABLE IF NOT EXISTS links (
              internal_id INTEGER PRIMARY KEY,
              link_type_id INTEGER NOT NULL
            );
            CREATE TABLE IF NOT EXISTS recording_work_relations (
              relation_id INTEGER PRIMARY KEY,
              link_id INTEGER NOT NULL,
              recording_id INTEGER NOT NULL,
              work_id INTEGER NOT NULL,
              link_order INTEGER NOT NULL
            );
            CREATE INDEX IF NOT EXISTS recording_work_recording_idx
              ON recording_work_relations(recording_id);
            CREATE TABLE IF NOT EXISTS artist_work_relations (
              relation_id INTEGER PRIMARY KEY,
              link_id INTEGER NOT NULL,
              artist_id INTEGER NOT NULL,
              work_id INTEGER NOT NULL,
              link_order INTEGER NOT NULL
            );
            CREATE INDEX IF NOT EXISTS artist_work_work_idx
              ON artist_work_relations(work_id);
            CREATE TABLE IF NOT EXISTS issues (
              entity_kind TEXT NOT NULL,
              internal_id INTEGER NOT NULL,
              category TEXT NOT NULL,
              member_name TEXT NOT NULL,
              row_number INTEGER NOT NULL,
              reason_code TEXT NOT NULL,
              evidence_json TEXT NOT NULL,
              PRIMARY KEY (
                entity_kind, internal_id, category, member_name, row_number, reason_code
              )
            ) WITHOUT ROWID;
            """
        )
        expected = {
            "schema_version": "1",
            "input_sha256": self._provenance.sha256,
            "input_size_bytes": str(self._provenance.size_bytes),
            "release_date": self._provenance.dump_date.isoformat(),
            "source_url": self._provenance.source_url,
        }
        existing = dict(self._connection.execute("SELECT key, value FROM metadata"))
        if existing:
            for key, value in expected.items():
                if existing.get(key) != value:
                    raise ValueError(f"MusicBrainz dump index provenance 불일치: {key}")
        else:
            self._connection.executemany(
                "INSERT INTO metadata(key, value) VALUES (?, ?)",
                (*expected.items(), ("complete", "0")),
            )
            self._connection.commit()

    def _build_or_resume(self) -> None:
        metadata = dict(self._connection.execute("SELECT key, value FROM metadata"))
        if metadata.get("complete") == "1":
            return
        seen_members: set[str] = set()
        pending = 0
        try:
            with tarfile.open(self._input_path, mode="r|bz2") as archive:
                for member in archive:
                    handler_name = self._MEMBERS.get(member.name)
                    if handler_name is None:
                        continue
                    if member.name in seen_members:
                        raise ValueError(f"MusicBrainz dump member가 중복됩니다: {member.name}")
                    if not member.isfile():
                        raise ValueError(
                            f"MusicBrainz dump member가 regular file이 아닙니다: {member.name}"
                        )
                    seen_members.add(member.name)
                    extracted = archive.extractfile(member)
                    if extracted is None:
                        raise ValueError(
                            f"MusicBrainz dump member를 읽을 수 없습니다: {member.name}"
                        )
                    with extracted:
                        for row_number, fields in _iter_copy_rows(extracted, member.name):
                            self._index_row(handler_name, member.name, row_number, fields)
                            pending += 1
                            if pending >= _INDEX_COMMIT_INTERVAL:
                                self._connection.commit()
                                pending = 0
        except (OSError, EOFError, tarfile.TarError) as error:
            raise ValueError(f"MusicBrainz tar.bz2 압축 또는 파일 읽기 오류: {error}") from error
        missing = set(self._MEMBERS) - seen_members
        if missing:
            raise ValueError(f"MusicBrainz core dump member 누락: {', '.join(sorted(missing))}")
        self._connection.execute(
            "INSERT OR REPLACE INTO metadata(key, value) VALUES ('complete', '1')"
        )
        self._connection.commit()

    def _index_row(
        self,
        handler_name: str,
        member_name: str,
        row_number: int,
        fields: list[str | None],
    ) -> None:
        handler = getattr(self, f"_index_{handler_name}")
        handler(member_name, row_number, fields)

    def _issue(
        self,
        *,
        entity_kind: EntityKind,
        internal_id: int,
        category: Literal["malformed", "unresolved"],
        member_name: str,
        row_number: int,
        reason_code: str,
        evidence: JsonObject,
    ) -> None:
        self._connection.execute(
            """
            INSERT OR REPLACE INTO issues(
              entity_kind, internal_id, category, member_name, row_number,
              reason_code, evidence_json
            ) VALUES (?, ?, ?, ?, ?, ?, ?)
            """,
            (
                entity_kind.value,
                internal_id,
                category,
                member_name,
                row_number,
                reason_code,
                json.dumps(evidence, ensure_ascii=False, sort_keys=True, separators=(",", ":")),
            ),
        )

    def _index_artist(self, member_name: str, row_number: int, fields: list[str | None]) -> None:
        del member_name, row_number
        internal_id = _required_int(fields, 0, "artist.id")
        mbid = _require_mbid(_required_text(fields, 1, "artist.gid"), "artist.gid")
        name = _required_text(fields, 2, "artist.name")
        self._connection.execute(
            "INSERT OR REPLACE INTO artists(internal_id, mbid, name) VALUES (?, ?, ?)",
            (internal_id, mbid, name),
        )

    def _index_schema_sequence(
        self, member_name: str, row_number: int, fields: list[str | None]
    ) -> None:
        del member_name, row_number
        schema_sequence = _required_nonnegative_int(fields, 0, "SCHEMA_SEQUENCE")
        if schema_sequence != _EXPECTED_SCHEMA_SEQUENCE:
            raise ValueError(
                "지원하지 않는 MusicBrainz schema sequence: "
                f"expected={_EXPECTED_SCHEMA_SEQUENCE} actual={schema_sequence}"
            )

    def _index_artist_credit(
        self, member_name: str, row_number: int, fields: list[str | None]
    ) -> None:
        del member_name, row_number
        internal_id = _required_int(fields, 0, "artist_credit.id")
        name = _required_text(fields, 1, "artist_credit.name")
        artist_count = _required_nonnegative_int(fields, 2, "artist_credit.artist_count")
        mbid = _require_mbid(_required_text(fields, 6, "artist_credit.gid"), "artist_credit.gid")
        self._connection.execute(
            """
            INSERT OR REPLACE INTO artist_credits(internal_id, mbid, name, artist_count)
            VALUES (?, ?, ?, ?)
            """,
            (internal_id, mbid, name, artist_count),
        )

    def _index_artist_credit_name(
        self, member_name: str, row_number: int, fields: list[str | None]
    ) -> None:
        del member_name, row_number
        credit_id = _required_int(fields, 0, "artist_credit_name.artist_credit")
        position = _required_nonnegative_int(fields, 1, "artist_credit_name.position")
        artist_id = _required_int(fields, 2, "artist_credit_name.artist")
        name = _required_text(fields, 3, "artist_credit_name.name")
        join_phrase = fields[4] if len(fields) > 4 and fields[4] is not None else ""
        self._connection.execute(
            """
            INSERT OR REPLACE INTO artist_credit_names(
              credit_id, position, artist_id, credited_name, join_phrase
            ) VALUES (?, ?, ?, ?, ?)
            """,
            (credit_id, position, artist_id, name, join_phrase),
        )

    def _index_work_type(self, member_name: str, row_number: int, fields: list[str | None]) -> None:
        del member_name, row_number
        internal_id = _required_int(fields, 0, "work_type.id")
        name = _required_text(fields, 1, "work_type.name")
        mbid = _require_mbid(_required_text(fields, 5, "work_type.gid"), "work_type.gid")
        self._connection.execute(
            "INSERT OR REPLACE INTO work_types(internal_id, mbid, name) VALUES (?, ?, ?)",
            (internal_id, mbid, name),
        )

    def _index_work(self, member_name: str, row_number: int, fields: list[str | None]) -> None:
        internal_id = _required_int(fields, 0, "work.id")
        mbid = fields[1] if len(fields) > 1 else None
        name = fields[2] if len(fields) > 2 else None
        type_id = _optional_int(fields, 3, "work.type")
        comment = fields[4] if len(fields) > 4 else None
        self._connection.execute(
            """
            INSERT OR REPLACE INTO works(
              internal_id, mbid, name, type_id, comment, member_name, row_number
            ) VALUES (?, ?, ?, ?, ?, ?, ?)
            """,
            (internal_id, mbid, name, type_id, comment, member_name, row_number),
        )
        if mbid is None or not _MBID_PATTERN.fullmatch(mbid):
            self._issue(
                entity_kind=EntityKind.WORK,
                internal_id=internal_id,
                category="malformed",
                member_name=member_name,
                row_number=row_number,
                reason_code="INVALID_WORK_MBID",
                evidence={"value": mbid},
            )
        if name is None or not name:
            self._issue(
                entity_kind=EntityKind.WORK,
                internal_id=internal_id,
                category="malformed",
                member_name=member_name,
                row_number=row_number,
                reason_code="WORK_NAME_MISSING",
                evidence={},
            )

    def _index_recording(self, member_name: str, row_number: int, fields: list[str | None]) -> None:
        internal_id = _required_int(fields, 0, "recording.id")
        mbid = fields[1] if len(fields) > 1 else None
        name = fields[2] if len(fields) > 2 else None
        credit_id = _optional_int(fields, 3, "recording.artist_credit")
        duration_ms = _optional_nonnegative_int(fields, 4, "recording.length")
        comment = fields[5] if len(fields) > 5 else None
        self._connection.execute(
            """
            INSERT OR REPLACE INTO recordings(
              internal_id, mbid, name, artist_credit_id, duration_ms, comment,
              member_name, row_number
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            """,
            (
                internal_id,
                mbid,
                name,
                credit_id,
                duration_ms,
                comment,
                member_name,
                row_number,
            ),
        )
        if mbid is None or not _MBID_PATTERN.fullmatch(mbid):
            self._issue(
                entity_kind=EntityKind.RECORDING,
                internal_id=internal_id,
                category="malformed",
                member_name=member_name,
                row_number=row_number,
                reason_code="INVALID_RECORDING_MBID",
                evidence={"value": mbid},
            )
        if name is None or not name:
            self._issue(
                entity_kind=EntityKind.RECORDING,
                internal_id=internal_id,
                category="malformed",
                member_name=member_name,
                row_number=row_number,
                reason_code="RECORDING_NAME_MISSING",
                evidence={},
            )

    def _index_isrc(self, member_name: str, row_number: int, fields: list[str | None]) -> None:
        recording_id = _required_int(fields, 1, "isrc.recording")
        isrc = _required_text(fields, 2, "isrc.isrc")
        if not _ISRC_PATTERN.fullmatch(isrc):
            self._issue(
                entity_kind=EntityKind.RECORDING,
                internal_id=recording_id,
                category="malformed",
                member_name=member_name,
                row_number=row_number,
                reason_code="INVALID_ISRC",
                evidence={"value": isrc},
            )
            return
        self._connection.execute(
            "INSERT OR IGNORE INTO isrcs(recording_id, isrc) VALUES (?, ?)",
            (recording_id, isrc),
        )

    def _index_iswc(self, member_name: str, row_number: int, fields: list[str | None]) -> None:
        work_id = _required_int(fields, 1, "iswc.work")
        iswc = _required_text(fields, 2, "iswc.iswc")
        if not _ISWC_PATTERN.fullmatch(iswc):
            self._issue(
                entity_kind=EntityKind.WORK,
                internal_id=work_id,
                category="malformed",
                member_name=member_name,
                row_number=row_number,
                reason_code="INVALID_ISWC",
                evidence={"value": iswc},
            )
            return
        self._connection.execute(
            "INSERT OR IGNORE INTO iswcs(work_id, iswc) VALUES (?, ?)",
            (work_id, iswc),
        )

    def _index_link_type(self, member_name: str, row_number: int, fields: list[str | None]) -> None:
        del member_name, row_number
        internal_id = _required_int(fields, 0, "link_type.id")
        mbid = _require_mbid(_required_text(fields, 3, "link_type.gid"), "link_type.gid")
        entity_type0 = _required_text(fields, 4, "link_type.entity_type0")
        entity_type1 = _required_text(fields, 5, "link_type.entity_type1")
        name = _required_text(fields, 6, "link_type.name")
        link_phrase = _required_text(fields, 8, "link_type.link_phrase")
        reverse_link_phrase = _required_text(fields, 9, "link_type.reverse_link_phrase")
        is_deprecated_raw = _required_text(fields, 12, "link_type.is_deprecated")
        if is_deprecated_raw not in {"t", "f"}:
            raise ValueError("boolean 형식 오류: link_type.is_deprecated")
        is_deprecated = int(is_deprecated_raw == "t")
        self._connection.execute(
            """
            INSERT OR REPLACE INTO link_types(
              internal_id, mbid, entity_type0, entity_type1, name,
              link_phrase, reverse_link_phrase, is_deprecated
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            """,
            (
                internal_id,
                mbid,
                entity_type0,
                entity_type1,
                name,
                link_phrase,
                reverse_link_phrase,
                is_deprecated,
            ),
        )

    def _index_link(self, member_name: str, row_number: int, fields: list[str | None]) -> None:
        del member_name, row_number
        internal_id = _required_int(fields, 0, "link.id")
        link_type_id = _required_int(fields, 1, "link.link_type")
        self._connection.execute(
            "INSERT OR REPLACE INTO links(internal_id, link_type_id) VALUES (?, ?)",
            (internal_id, link_type_id),
        )

    def _index_l_recording_work(
        self, member_name: str, row_number: int, fields: list[str | None]
    ) -> None:
        del member_name, row_number
        relation_id = _required_int(fields, 0, "l_recording_work.id")
        link_id = _required_int(fields, 1, "l_recording_work.link")
        recording_id = _required_int(fields, 2, "l_recording_work.entity0")
        work_id = _required_int(fields, 3, "l_recording_work.entity1")
        link_order = _optional_nonnegative_int(fields, 6, "l_recording_work.link_order") or 0
        self._connection.execute(
            """
            INSERT OR REPLACE INTO recording_work_relations(
              relation_id, link_id, recording_id, work_id, link_order
            ) VALUES (?, ?, ?, ?, ?)
            """,
            (relation_id, link_id, recording_id, work_id, link_order),
        )

    def _index_l_artist_work(
        self, member_name: str, row_number: int, fields: list[str | None]
    ) -> None:
        del member_name, row_number
        relation_id = _required_int(fields, 0, "l_artist_work.id")
        link_id = _required_int(fields, 1, "l_artist_work.link")
        artist_id = _required_int(fields, 2, "l_artist_work.entity0")
        work_id = _required_int(fields, 3, "l_artist_work.entity1")
        link_order = _optional_nonnegative_int(fields, 6, "l_artist_work.link_order") or 0
        self._connection.execute(
            """
            INSERT OR REPLACE INTO artist_work_relations(
              relation_id, link_id, artist_id, work_id, link_order
            ) VALUES (?, ?, ?, ?, ?)
            """,
            (relation_id, link_id, artist_id, work_id, link_order),
        )

    def iter_entities(self) -> Iterator[_IndexedEntity]:
        ordinal = 0
        for kind, table_name in (
            (EntityKind.WORK, "works"),
            (EntityKind.RECORDING, "recordings"),
        ):
            rows = self._connection.execute(
                f"SELECT internal_id FROM {table_name} ORDER BY internal_id"
            )
            for row in rows:
                yield _IndexedEntity(
                    ordinal=ordinal,
                    entity_kind=kind,
                    internal_id=int(row["internal_id"]),
                )
                ordinal += 1

    def build_entity(self, entity: _IndexedEntity) -> _EntityResult:
        if entity.entity_kind is EntityKind.WORK:
            return self._build_work(entity)
        return self._build_recording(entity)

    def _malformed_reviews(
        self, entity: _IndexedEntity
    ) -> tuple[MusicBrainzDumpMalformedReview, ...]:
        rows = self._connection.execute(
            """
            SELECT member_name, row_number, reason_code, evidence_json
            FROM issues
            WHERE entity_kind = ? AND internal_id = ? AND category = 'malformed'
            ORDER BY member_name, row_number, reason_code
            """,
            (entity.entity_kind.value, entity.internal_id),
        )
        reviews: list[MusicBrainzDumpMalformedReview] = []
        for row in rows:
            evidence = json.loads(str(row["evidence_json"]))
            if not isinstance(evidence, dict):
                raise ValueError("MusicBrainz dump issue evidence가 object가 아닙니다.")
            reviews.append(
                MusicBrainzDumpMalformedReview(
                    entity_kind=entity.entity_kind,
                    musicbrainz_internal_id=entity.internal_id,
                    entity_ordinal=entity.ordinal,
                    member_name=str(row["member_name"]),
                    row_number=int(row["row_number"]),
                    reason_code=str(row["reason_code"]),
                    evidence=evidence,
                )
            )
        return tuple(reviews)

    @staticmethod
    def _unresolved_review(
        entity: _IndexedEntity,
        entity_mbid: str,
        reason_code: str,
        evidence: JsonObject,
    ) -> MusicBrainzDumpUnresolvedReview:
        return MusicBrainzDumpUnresolvedReview(
            entity_kind=entity.entity_kind,
            musicbrainz_internal_id=entity.internal_id,
            entity_mbid=entity_mbid,
            entity_ordinal=entity.ordinal,
            reason_code=reason_code,
            evidence=evidence,
        )

    def _build_work(self, entity: _IndexedEntity) -> _EntityResult:
        row = self._connection.execute(
            """
            SELECT work.mbid, work.name, work.type_id, work.comment,
                   work_type.mbid AS type_mbid, work_type.name AS type_name
            FROM works AS work
            LEFT JOIN work_types AS work_type ON work_type.internal_id = work.type_id
            WHERE work.internal_id = ?
            """,
            (entity.internal_id,),
        ).fetchone()
        if row is None:
            raise ValueError(f"MusicBrainz work index 누락: {entity.internal_id}")
        malformed = self._malformed_reviews(entity)
        mbid = row["mbid"]
        name = row["name"]
        if not isinstance(mbid, str) or not _MBID_PATTERN.fullmatch(mbid):
            return _EntityResult(None, malformed, ())
        if not isinstance(name, str) or not name:
            return _EntityResult(None, malformed, ())
        unresolved: list[MusicBrainzDumpUnresolvedReview] = []
        if row["type_id"] is not None and row["type_mbid"] is None:
            unresolved.append(
                self._unresolved_review(
                    entity,
                    mbid,
                    "WORK_TYPE_NOT_FOUND",
                    {"work_type_internal_id": int(row["type_id"])},
                )
            )
        iswcs = [
            str(value["iswc"])
            for value in self._connection.execute(
                "SELECT iswc FROM iswcs WHERE work_id = ? ORDER BY iswc",
                (entity.internal_id,),
            )
        ]
        artist_relations: list[JsonObject] = []
        composer_mbids: set[str] = set()
        relation_rows = self._connection.execute(
            """
            SELECT relation.relation_id, relation.link_id, relation.link_order,
                   relation.artist_id, artist.mbid AS artist_mbid,
                   link.link_type_id, link_type.mbid AS relation_type_mbid,
                   link_type.entity_type0, link_type.entity_type1,
                   link_type.name AS relation_type_name, link_type.is_deprecated
            FROM artist_work_relations AS relation
            LEFT JOIN artists AS artist ON artist.internal_id = relation.artist_id
            LEFT JOIN links AS link ON link.internal_id = relation.link_id
            LEFT JOIN link_types AS link_type ON link_type.internal_id = link.link_type_id
            WHERE relation.work_id = ?
            ORDER BY relation.link_order, relation.relation_id
            """,
            (entity.internal_id,),
        )
        for relation in relation_rows:
            relation_payload: JsonObject = {
                "relation_id": int(relation["relation_id"]),
                "link_id": int(relation["link_id"]),
                "artist_internal_id": int(relation["artist_id"]),
                "link_order": int(relation["link_order"]),
            }
            for key in (
                "artist_mbid",
                "relation_type_mbid",
                "entity_type0",
                "entity_type1",
                "relation_type_name",
            ):
                value = relation[key]
                if isinstance(value, str):
                    relation_payload[key] = value
            deprecated = bool(relation["is_deprecated"] or False)
            relation_payload["is_deprecated"] = deprecated
            artist_relations.append(relation_payload)
            artist_mbid = relation["artist_mbid"]
            type_mbid = relation["relation_type_mbid"]
            if artist_mbid is None or type_mbid is None:
                unresolved.append(
                    self._unresolved_review(
                        entity,
                        mbid,
                        "ARTIST_WORK_RELATION_FK_UNRESOLVED",
                        relation_payload,
                    )
                )
                continue
            is_composer = type_mbid == _COMPOSER_RELATION_TYPE_MBID
            exact_orientation = (
                relation["entity_type0"] == "artist" and relation["entity_type1"] == "work"
            )
            if is_composer and (deprecated or not exact_orientation):
                unresolved.append(
                    self._unresolved_review(
                        entity,
                        mbid,
                        "COMPOSER_RELATION_CONTRACT_MISMATCH",
                        relation_payload,
                    )
                )
            elif is_composer and isinstance(artist_mbid, str):
                composer_mbids.add(artist_mbid)
        payload: JsonObject = {
            "name": name,
            "musicbrainz_internal_id": entity.internal_id,
            "iswcs": _json_strings(iswcs),
            "artist_relations": _json_objects(artist_relations),
            "composer_mbids": _json_strings(sorted(composer_mbids)),
        }
        if isinstance(row["type_name"], str):
            payload["type"] = row["type_name"]
        if isinstance(row["type_mbid"], str):
            payload["work_type_mbid"] = row["type_mbid"]
        if isinstance(row["comment"], str) and row["comment"]:
            payload["disambiguation"] = row["comment"]
        return _EntityResult(
            SourceRecord(
                source=SourceName.MUSICBRAINZ_DUMP,
                source_record_id=mbid,
                entity_kind=EntityKind.WORK,
                payload=payload,
            ),
            malformed,
            tuple(unresolved),
        )

    def _build_recording(self, entity: _IndexedEntity) -> _EntityResult:
        row = self._connection.execute(
            """
            SELECT mbid, name, artist_credit_id, duration_ms, comment
            FROM recordings WHERE internal_id = ?
            """,
            (entity.internal_id,),
        ).fetchone()
        if row is None:
            raise ValueError(f"MusicBrainz recording index 누락: {entity.internal_id}")
        malformed = self._malformed_reviews(entity)
        mbid = row["mbid"]
        name = row["name"]
        if not isinstance(mbid, str) or not _MBID_PATTERN.fullmatch(mbid):
            return _EntityResult(None, malformed, ())
        if not isinstance(name, str) or not name:
            return _EntityResult(None, malformed, ())
        unresolved: list[MusicBrainzDumpUnresolvedReview] = []
        artist_credit = self._recording_artist_credit(entity, mbid, row, unresolved)
        relations, performance_work_mbids = self._recording_work_relations(entity, mbid, unresolved)
        isrcs = [
            str(value["isrc"])
            for value in self._connection.execute(
                "SELECT isrc FROM isrcs WHERE recording_id = ? ORDER BY isrc",
                (entity.internal_id,),
            )
        ]
        payload: JsonObject = {
            "name": name,
            "musicbrainz_internal_id": entity.internal_id,
            "isrcs": _json_strings(isrcs),
            "recording_work_relations": _json_objects(relations),
            "performance_work_mbids": _json_strings(performance_work_mbids),
        }
        if artist_credit is not None:
            payload["artist_credit"] = artist_credit
        if row["duration_ms"] is not None:
            payload["duration_ms"] = int(row["duration_ms"])
        if isinstance(row["comment"], str) and row["comment"]:
            payload["disambiguation"] = row["comment"]
        return _EntityResult(
            SourceRecord(
                source=SourceName.MUSICBRAINZ_DUMP,
                source_record_id=mbid,
                entity_kind=EntityKind.RECORDING,
                payload=payload,
            ),
            malformed,
            tuple(unresolved),
        )

    def _recording_artist_credit(
        self,
        entity: _IndexedEntity,
        entity_mbid: str,
        recording_row: sqlite3.Row,
        unresolved: list[MusicBrainzDumpUnresolvedReview],
    ) -> JsonObject | None:
        credit_id = recording_row["artist_credit_id"]
        if credit_id is None:
            unresolved.append(
                self._unresolved_review(entity, entity_mbid, "ARTIST_CREDIT_ID_MISSING", {})
            )
            return None
        credit = self._connection.execute(
            "SELECT mbid, name, artist_count FROM artist_credits WHERE internal_id = ?",
            (int(credit_id),),
        ).fetchone()
        if credit is None:
            unresolved.append(
                self._unresolved_review(
                    entity,
                    entity_mbid,
                    "ARTIST_CREDIT_NOT_FOUND",
                    {"artist_credit_internal_id": int(credit_id)},
                )
            )
            return None
        names: list[JsonObject] = []
        rows = self._connection.execute(
            """
            SELECT credit_name.position, credit_name.artist_id,
                   credit_name.credited_name, credit_name.join_phrase,
                   artist.mbid AS artist_mbid
            FROM artist_credit_names AS credit_name
            LEFT JOIN artists AS artist ON artist.internal_id = credit_name.artist_id
            WHERE credit_name.credit_id = ?
            ORDER BY credit_name.position
            """,
            (int(credit_id),),
        )
        for credit_name in rows:
            value: JsonObject = {
                "position": int(credit_name["position"]),
                "artist_internal_id": int(credit_name["artist_id"]),
                "credited_name": str(credit_name["credited_name"]),
                "join_phrase": str(credit_name["join_phrase"]),
            }
            artist_mbid = credit_name["artist_mbid"]
            if isinstance(artist_mbid, str):
                value["artist_mbid"] = artist_mbid
            else:
                unresolved.append(
                    self._unresolved_review(
                        entity,
                        entity_mbid,
                        "ARTIST_CREDIT_ARTIST_NOT_FOUND",
                        {
                            "artist_credit_internal_id": int(credit_id),
                            "artist_internal_id": int(credit_name["artist_id"]),
                            "position": int(credit_name["position"]),
                        },
                    )
                )
            names.append(value)
        if len(names) != int(credit["artist_count"]):
            unresolved.append(
                self._unresolved_review(
                    entity,
                    entity_mbid,
                    "ARTIST_CREDIT_COUNT_MISMATCH",
                    {
                        "artist_credit_internal_id": int(credit_id),
                        "expected_count": int(credit["artist_count"]),
                        "actual_count": len(names),
                    },
                )
            )
        return {
            "artist_credit_internal_id": int(credit_id),
            "artist_credit_mbid": str(credit["mbid"]),
            "display_name": str(credit["name"]),
            "names": _json_objects(names),
        }

    def _recording_work_relations(
        self,
        entity: _IndexedEntity,
        entity_mbid: str,
        unresolved: list[MusicBrainzDumpUnresolvedReview],
    ) -> tuple[list[JsonObject], list[str]]:
        relations: list[JsonObject] = []
        performance_work_mbids: set[str] = set()
        rows = self._connection.execute(
            """
            SELECT relation.relation_id, relation.link_id, relation.link_order,
                   relation.work_id, work.mbid AS work_mbid,
                   link.link_type_id, link_type.mbid AS relation_type_mbid,
                   link_type.entity_type0, link_type.entity_type1,
                   link_type.name AS relation_type_name, link_type.is_deprecated
            FROM recording_work_relations AS relation
            LEFT JOIN works AS work ON work.internal_id = relation.work_id
            LEFT JOIN links AS link ON link.internal_id = relation.link_id
            LEFT JOIN link_types AS link_type ON link_type.internal_id = link.link_type_id
            WHERE relation.recording_id = ?
            ORDER BY relation.link_order, relation.relation_id
            """,
            (entity.internal_id,),
        )
        for row in rows:
            payload: JsonObject = {
                "relation_id": int(row["relation_id"]),
                "link_id": int(row["link_id"]),
                "work_internal_id": int(row["work_id"]),
                "link_order": int(row["link_order"]),
            }
            for key in (
                "work_mbid",
                "relation_type_mbid",
                "entity_type0",
                "entity_type1",
                "relation_type_name",
            ):
                value = row[key]
                if isinstance(value, str):
                    payload[key] = value
            deprecated = bool(row["is_deprecated"] or False)
            payload["is_deprecated"] = deprecated
            relations.append(payload)
            work_mbid = row["work_mbid"]
            type_mbid = row["relation_type_mbid"]
            if work_mbid is None or type_mbid is None:
                unresolved.append(
                    self._unresolved_review(
                        entity,
                        entity_mbid,
                        "RECORDING_WORK_RELATION_FK_UNRESOLVED",
                        payload,
                    )
                )
                continue
            is_performance = type_mbid == _PERFORMANCE_RELATION_TYPE_MBID
            exact_orientation = row["entity_type0"] == "recording" and row["entity_type1"] == "work"
            if is_performance and (deprecated or not exact_orientation):
                unresolved.append(
                    self._unresolved_review(
                        entity,
                        entity_mbid,
                        "PERFORMANCE_RELATION_CONTRACT_MISMATCH",
                        payload,
                    )
                )
            elif is_performance and isinstance(work_mbid, str):
                performance_work_mbids.add(work_mbid)
        return relations, sorted(performance_work_mbids)


def collect_musicbrainz_dump(
    *,
    input_path: Path,
    provenance: InputFileProvenance,
    run_id: str,
    artifact_store: JsonlArtifactStore,
    artifacts_root: Path,
    checkpoint_path: Path,
    start_ordinal: int,
    end_ordinal: int | None,
    limit: int,
    checkpoint_every: int,
    dry_run: bool,
    resume: bool,
) -> MusicBrainzDumpCollectionResult:
    if end_ordinal is not None and end_ordinal <= start_ordinal:
        raise ValueError("--end-ordinal은 --start-ordinal보다 커야 합니다.")
    if checkpoint_every < 1:
        raise ValueError("checkpoint_every는 1 이상이어야 합니다.")
    checkpoint = MusicBrainzDumpCheckpoint(
        run_id=run_id,
        input_provenance=provenance,
        partition_start_ordinal=start_ordinal,
        partition_end_ordinal=end_ordinal,
        next_ordinal=start_ordinal,
    )
    records: list[SourceRecord] = []
    malformed: list[MusicBrainzDumpMalformedReview] = []
    unresolved: list[MusicBrainzDumpUnresolvedReview] = []
    if checkpoint_path.exists():
        if not resume:
            raise ValueError(
                "MusicBrainz dump checkpoint가 이미 존재합니다. --resume이 필요합니다."
            )
        checkpoint = _read_checkpoint(checkpoint_path)
        _require_checkpoint_identity(
            checkpoint,
            run_id,
            provenance,
            start_ordinal,
            end_ordinal,
        )
        records = _read_checkpoint_artifacts(
            artifacts_root,
            checkpoint.record_manifest_paths,
            SourceRecord,
        )
        malformed = _read_checkpoint_artifacts(
            artifacts_root,
            checkpoint.malformed_manifest_paths,
            MusicBrainzDumpMalformedReview,
        )
        unresolved = _read_checkpoint_artifacts(
            artifacts_root,
            checkpoint.unresolved_manifest_paths,
            MusicBrainzDumpUnresolvedReview,
        )
        if (
            len(records) != checkpoint.record_count
            or len(malformed) != checkpoint.malformed_count
            or len(unresolved) != checkpoint.unresolved_count
        ):
            raise ValueError("MusicBrainz dump checkpoint count와 page artifact가 다릅니다.")
        if len(records) + len(malformed) + len(unresolved) > limit:
            raise ValueError("--limit은 checkpoint의 기존 누적 결과보다 작을 수 없습니다.")

    resumed_record_count = len(records)
    resumed_malformed_count = len(malformed)
    resumed_unresolved_count = len(unresolved)
    if checkpoint.complete or len(records) + len(malformed) + len(unresolved) >= limit:
        return MusicBrainzDumpCollectionResult(
            records=tuple(records),
            malformed_reviews=tuple(malformed),
            unresolved_reviews=tuple(unresolved),
            next_ordinal=checkpoint.next_ordinal,
            scanned_entity_count=0,
            resumed_record_count=resumed_record_count,
            resumed_malformed_count=resumed_malformed_count,
            resumed_unresolved_count=resumed_unresolved_count,
            artifact_mutation_count=0,
            complete=checkpoint.complete,
        )

    metadata = musicbrainz_dump_metadata(provenance)
    retrieved_at = musicbrainz_dump_retrieved_at(provenance)
    record_paths = list(checkpoint.record_manifest_paths)
    malformed_paths = list(checkpoint.malformed_manifest_paths)
    unresolved_paths = list(checkpoint.unresolved_manifest_paths)
    page_records: list[SourceRecord] = []
    page_malformed: list[MusicBrainzDumpMalformedReview] = []
    page_unresolved: list[MusicBrainzDumpUnresolvedReview] = []
    next_ordinal = checkpoint.next_ordinal
    scanned_entity_count = 0
    artifact_mutation_count = 0
    complete = False

    with _MusicBrainzDumpIndex(
        input_path=input_path,
        provenance=provenance,
        artifacts_root=artifacts_root,
        dry_run=dry_run,
    ) as index:
        for entity in index.iter_entities():
            if entity.ordinal < next_ordinal:
                continue
            if end_ordinal is not None and entity.ordinal >= end_ordinal:
                complete = True
                next_ordinal = entity.ordinal
                break
            result = index.build_entity(entity)
            scanned_entity_count += 1
            next_ordinal = entity.ordinal + 1
            if result.record is not None:
                page_records.append(result.record)
            page_malformed.extend(result.malformed)
            page_unresolved.extend(result.unresolved)
            emitted_count = (
                len(records)
                + len(malformed)
                + len(unresolved)
                + len(page_records)
                + len(page_malformed)
                + len(page_unresolved)
            )
            should_stop = emitted_count >= limit
            should_checkpoint = scanned_entity_count % checkpoint_every == 0
            if should_stop or should_checkpoint:
                if dry_run:
                    records.extend(page_records)
                    malformed.extend(page_malformed)
                    unresolved.extend(page_unresolved)
                    page_records.clear()
                    page_malformed.clear()
                    page_unresolved.clear()
                else:
                    artifact_mutation_count += _flush_page(
                        run_id=run_id,
                        metadata=metadata,
                        provenance=provenance,
                        retrieved_at=retrieved_at,
                        artifact_store=artifact_store,
                        artifacts_root=artifacts_root,
                        records=records,
                        malformed=malformed,
                        unresolved=unresolved,
                        page_records=page_records,
                        page_malformed=page_malformed,
                        page_unresolved=page_unresolved,
                        record_paths=record_paths,
                        malformed_paths=malformed_paths,
                        unresolved_paths=unresolved_paths,
                        checkpoint_path=checkpoint_path,
                        start_ordinal=start_ordinal,
                        end_ordinal=end_ordinal,
                        next_ordinal=next_ordinal,
                        complete=False,
                        resume=resume,
                    )
                if should_stop:
                    break
        else:
            complete = True

    if (
        page_records
        or page_malformed
        or page_unresolved
        or (not dry_run and complete != checkpoint.complete)
    ):
        if dry_run:
            records.extend(page_records)
            malformed.extend(page_malformed)
            unresolved.extend(page_unresolved)
        else:
            artifact_mutation_count += _flush_page(
                run_id=run_id,
                metadata=metadata,
                provenance=provenance,
                retrieved_at=retrieved_at,
                artifact_store=artifact_store,
                artifacts_root=artifacts_root,
                records=records,
                malformed=malformed,
                unresolved=unresolved,
                page_records=page_records,
                page_malformed=page_malformed,
                page_unresolved=page_unresolved,
                record_paths=record_paths,
                malformed_paths=malformed_paths,
                unresolved_paths=unresolved_paths,
                checkpoint_path=checkpoint_path,
                start_ordinal=start_ordinal,
                end_ordinal=end_ordinal,
                next_ordinal=next_ordinal,
                complete=complete,
                resume=resume,
            )

    return MusicBrainzDumpCollectionResult(
        records=tuple(records),
        malformed_reviews=tuple(malformed),
        unresolved_reviews=tuple(unresolved),
        next_ordinal=next_ordinal,
        scanned_entity_count=scanned_entity_count,
        resumed_record_count=resumed_record_count,
        resumed_malformed_count=resumed_malformed_count,
        resumed_unresolved_count=resumed_unresolved_count,
        artifact_mutation_count=artifact_mutation_count,
        complete=complete,
    )


def _read_checkpoint(path: Path) -> MusicBrainzDumpCheckpoint:
    try:
        return MusicBrainzDumpCheckpoint.model_validate_json(path.read_bytes())
    except (OSError, ValidationError) as error:
        raise ValueError(f"MusicBrainz dump checkpoint 계약 오류: {error}") from error


def _require_checkpoint_identity(
    checkpoint: MusicBrainzDumpCheckpoint,
    run_id: str,
    provenance: InputFileProvenance,
    start_ordinal: int,
    end_ordinal: int | None,
) -> None:
    if (
        checkpoint.run_id != run_id
        or checkpoint.input_provenance != provenance
        or checkpoint.partition_start_ordinal != start_ordinal
        or checkpoint.partition_end_ordinal != end_ordinal
    ):
        raise ValueError(
            "MusicBrainz dump checkpoint가 현재 run/input provenance/partition과 다릅니다."
        )


def _read_checkpoint_artifacts[RecordT: StrictModel](
    artifacts_root: Path,
    manifest_paths: Sequence[str],
    record_type: type[RecordT],
) -> list[RecordT]:
    root = artifacts_root.resolve()
    records: list[RecordT] = []
    for relative_path in manifest_paths:
        manifest_path = (artifacts_root / relative_path).resolve()
        if not manifest_path.is_relative_to(root):
            raise ValueError("checkpoint manifest가 artifact 루트 밖을 가리킵니다.")
        _, page_records = read_artifact(manifest_path, record_type)
        records.extend(page_records)
    return records


def _flush_page(
    *,
    run_id: str,
    metadata: SourceMetadata,
    provenance: InputFileProvenance,
    retrieved_at: datetime,
    artifact_store: JsonlArtifactStore,
    artifacts_root: Path,
    records: list[SourceRecord],
    malformed: list[MusicBrainzDumpMalformedReview],
    unresolved: list[MusicBrainzDumpUnresolvedReview],
    page_records: list[SourceRecord],
    page_malformed: list[MusicBrainzDumpMalformedReview],
    page_unresolved: list[MusicBrainzDumpUnresolvedReview],
    record_paths: list[str],
    malformed_paths: list[str],
    unresolved_paths: list[str],
    checkpoint_path: Path,
    start_ordinal: int,
    end_ordinal: int | None,
    next_ordinal: int,
    complete: bool,
    resume: bool,
) -> int:
    mutation_count = _write_page_records(
        run_id=run_id,
        metadata=metadata,
        provenance=provenance,
        retrieved_at=retrieved_at,
        artifact_store=artifact_store,
        artifacts_root=artifacts_root,
        page=page_records,
        aggregate=records,
        paths=record_paths,
        resume=resume,
    )
    mutation_count += _write_page_records(
        run_id=run_id,
        metadata=metadata,
        provenance=provenance,
        retrieved_at=retrieved_at,
        artifact_store=artifact_store,
        artifacts_root=artifacts_root,
        page=page_malformed,
        aggregate=malformed,
        paths=malformed_paths,
        resume=resume,
    )
    mutation_count += _write_page_records(
        run_id=run_id,
        metadata=metadata,
        provenance=provenance,
        retrieved_at=retrieved_at,
        artifact_store=artifact_store,
        artifacts_root=artifacts_root,
        page=page_unresolved,
        aggregate=unresolved,
        paths=unresolved_paths,
        resume=resume,
    )
    checkpoint = MusicBrainzDumpCheckpoint(
        run_id=run_id,
        input_provenance=provenance,
        partition_start_ordinal=start_ordinal,
        partition_end_ordinal=end_ordinal,
        next_ordinal=next_ordinal,
        record_manifest_paths=tuple(record_paths),
        malformed_manifest_paths=tuple(malformed_paths),
        unresolved_manifest_paths=tuple(unresolved_paths),
        record_count=len(records),
        malformed_count=len(malformed),
        unresolved_count=len(unresolved),
        complete=complete,
    )
    _write_checkpoint(checkpoint_path, checkpoint)
    return mutation_count


def _write_page_records[RecordT: StrictModel](
    *,
    run_id: str,
    metadata: SourceMetadata,
    provenance: InputFileProvenance,
    retrieved_at: datetime,
    artifact_store: JsonlArtifactStore,
    artifacts_root: Path,
    page: list[RecordT],
    aggregate: list[RecordT],
    paths: list[str],
    resume: bool,
) -> int:
    if not page:
        return 0
    result = artifact_store.write(
        run_id=run_id,
        stage=ArtifactStage.RAW,
        metadata=metadata,
        records=page,
        retrieved_at=retrieved_at,
        dry_run=False,
        resume=resume,
        input_provenance=provenance,
    )
    relative = result.manifest_path.relative_to(artifacts_root).as_posix()
    if relative not in paths:
        paths.append(relative)
    aggregate.extend(page)
    page.clear()
    return result.mutation_count


def _write_checkpoint(path: Path, checkpoint: MusicBrainzDumpCheckpoint) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    content = f"{checkpoint.model_dump_json(indent=2)}\n".encode()
    with NamedTemporaryFile(dir=path.parent, delete=False) as temporary_file:
        temporary_file.write(content)
        temporary_path = Path(temporary_file.name)
    try:
        os.replace(temporary_path, path)
    finally:
        temporary_path.unlink(missing_ok=True)
