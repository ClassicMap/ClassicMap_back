from __future__ import annotations

import bz2
import hashlib
import json
import os
import re
import sqlite3
from collections import OrderedDict
from collections.abc import Iterator, Sequence
from contextlib import AbstractContextManager
from dataclasses import dataclass
from datetime import UTC, date, datetime, time
from pathlib import Path
from tempfile import NamedTemporaryFile, TemporaryDirectory
from typing import BinaryIO, ClassVar, Literal

from pydantic import Field, ValidationError, field_validator, model_validator

from classicmap_seed.artifacts import JsonlArtifactStore, read_artifact
from classicmap_seed.models import (
    ArtifactStage,
    CommandReport,
    InputFileProvenance,
    JsonObject,
    JsonValue,
    SourceMetadata,
    SourceName,
    SourceRecord,
    StrictModel,
    WikidataScope,
)
from classicmap_seed.sources.base import optional_string
from classicmap_seed.sources.wikidata import WikidataConnector

_OFFICIAL_DUMP_URL = re.compile(
    r"^https://dumps\.wikimedia\.org/wikidatawiki/entities/"
    r"(?P<date>[0-9]{8})/wikidata-(?P=date)-all\.json\.bz2$"
)
_QID_PATTERN = re.compile(r"^Q[1-9][0-9]*$")
_HASH_CHUNK_SIZE = 1024 * 1024
_MAX_ENTITY_LINE_BYTES = 128 * 1024 * 1024
_INDEX_COMMIT_INTERVAL = 10_000
_SQLITE_LOOKUP_BATCH = 500
_SCOPE_CACHE_SIZE = 10_000


class WikidataDumpReleaseMetadata(StrictModel):
    schema_version: Literal["1"] = "1"
    dump_date: date
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
    def require_official_dated_source(self) -> WikidataDumpReleaseMetadata:
        matched = _OFFICIAL_DUMP_URL.fullmatch(self.source_url)
        if matched is None:
            raise ValueError(
                "source_url은 날짜가 고정된 공식 Wikidata entities dump URL이어야 합니다."
            )
        url_date = datetime.strptime(matched.group("date"), "%Y%m%d").date()
        if url_date != self.dump_date:
            raise ValueError("source_url 날짜와 dump_date가 일치해야 합니다.")
        return self

    def to_input_provenance(self) -> InputFileProvenance:
        return InputFileProvenance(
            sha256=self.sha256,
            size_bytes=self.size_bytes,
            dump_date=self.dump_date,
            source_url=self.source_url,
        )


class WikidataDumpScopeReview(StrictModel):
    qid: str
    entity_ordinal: int = Field(ge=0)
    reason_code: Literal["UNKNOWN_SCOPE_EVIDENCE", "AMBIGUOUS_SCOPE"]
    matched_scopes: tuple[WikidataScope, ...] = ()
    role_codes: tuple[str, ...] = ()
    instance_of_codes: tuple[str, ...] = ()
    evidence: JsonObject


class WikidataDumpCheckpoint(StrictModel):
    schema_version: Literal["1"] = "1"
    run_id: str
    input_provenance: InputFileProvenance
    partition_start_ordinal: int = Field(ge=0)
    partition_end_ordinal: int | None = Field(default=None, ge=1)
    next_ordinal: int = Field(ge=0)
    record_manifest_paths: tuple[str, ...] = ()
    review_manifest_paths: tuple[str, ...] = ()
    record_count: int = Field(default=0, ge=0)
    review_count: int = Field(default=0, ge=0)
    complete: bool = False


class WikidataDumpCommandReport(CommandReport):
    command: Literal["snapshot-wikidata-dump"] = "snapshot-wikidata-dump"
    input_sha256: str
    input_size_bytes: int
    dump_date: date
    source_url: str
    partition_start_ordinal: int
    partition_end_ordinal: int | None
    next_ordinal: int
    complete: bool
    scanned_entity_count: int = Field(ge=0)
    review_count: int = Field(ge=0)
    resumed_output_count: int = Field(ge=0)
    resumed_review_count: int = Field(ge=0)
    data_path: str
    manifest_path: str
    review_data_path: str | None = None
    review_manifest_path: str | None = None


@dataclass(frozen=True, slots=True)
class WikidataDumpCollectionResult:
    records: tuple[SourceRecord, ...]
    reviews: tuple[WikidataDumpScopeReview, ...]
    next_ordinal: int
    scanned_entity_count: int
    resumed_record_count: int
    resumed_review_count: int
    artifact_mutation_count: int
    complete: bool


def read_wikidata_dump_release_metadata(path: Path) -> WikidataDumpReleaseMetadata:
    try:
        with path.open("rb") as source:
            content = source.read(1024 * 1024 + 1)
    except OSError as error:
        raise ValueError(f"release metadata를 읽을 수 없습니다: {path}") from error
    if len(content) > 1024 * 1024:
        raise ValueError("release metadata는 1 MiB 이하여야 합니다.")
    try:
        return WikidataDumpReleaseMetadata.model_validate_json(content)
    except ValidationError as error:
        raise ValueError(f"Wikidata dump release metadata 계약 오류: {error}") from error


def verify_wikidata_dump_input(
    input_path: Path,
    release: WikidataDumpReleaseMetadata,
) -> InputFileProvenance:
    if not (input_path.name.endswith(".json.bz2") or input_path.suffix == ".json"):
        raise ValueError("Wikidata dump 입력은 .json.bz2 또는 .json이어야 합니다.")
    try:
        size_bytes = input_path.stat().st_size
    except OSError as error:
        raise ValueError(f"Wikidata dump 입력을 읽을 수 없습니다: {input_path}") from error
    if size_bytes != release.size_bytes:
        raise ValueError(
            f"Wikidata dump 파일 크기 불일치: metadata={release.size_bytes} actual={size_bytes}"
        )
    actual_sha256 = sha256_file(input_path)
    if actual_sha256 != release.sha256:
        raise ValueError(
            f"Wikidata dump SHA-256 불일치: metadata={release.sha256} actual={actual_sha256}"
        )
    return release.to_input_provenance()


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as source:
        while chunk := source.read(_HASH_CHUNK_SIZE):
            digest.update(chunk)
    return digest.hexdigest()


def wikidata_dump_metadata(provenance: InputFileProvenance) -> SourceMetadata:
    return SourceMetadata(
        source=SourceName.WIKIDATA,
        source_uri=provenance.source_url,
        license="CC0-1.0",
        license_uri="https://www.wikidata.org/wiki/Wikidata:Licensing",
    )


def dump_retrieved_at(provenance: InputFileProvenance) -> datetime:
    return datetime.combine(provenance.dump_date, time.min, tzinfo=UTC)


def iter_wikidata_dump(path: Path) -> Iterator[tuple[int, JsonObject]]:
    try:
        yield from _iter_wikidata_dump(path)
    except (EOFError, OSError) as error:
        raise ValueError(f"Wikidata dump 압축 또는 파일 읽기 오류: {error}") from error


def _iter_wikidata_dump(path: Path) -> Iterator[tuple[int, JsonObject]]:
    with _open_dump(path) as source:
        started = False
        ended = False
        ordinal = 0
        line_number = 0
        while True:
            raw_line = source.readline(_MAX_ENTITY_LINE_BYTES + 1)
            if not raw_line:
                break
            line_number += 1
            if len(raw_line) > _MAX_ENTITY_LINE_BYTES and not raw_line.endswith(b"\n"):
                raise ValueError(
                    f"Wikidata dump entity line이 {_MAX_ENTITY_LINE_BYTES} byte 제한을 넘었습니다."
                )
            stripped = raw_line.strip()
            if not stripped:
                continue
            if not started:
                if stripped != b"[":
                    raise ValueError("Wikidata dump는 줄 단위 JSON array 형식이어야 합니다.")
                started = True
                continue
            if stripped == b"]":
                ended = True
                break
            if stripped.endswith(b","):
                stripped = stripped[:-1].rstrip()
            try:
                value = json.loads(stripped)
            except json.JSONDecodeError as error:
                raise ValueError(
                    f"Wikidata dump {line_number}행 JSON이 올바르지 않습니다: {error.msg}"
                ) from error
            if not isinstance(value, dict):
                raise ValueError(f"Wikidata dump {line_number}행 entity는 object여야 합니다.")
            yield ordinal, value
            ordinal += 1
        if not started or not ended:
            raise ValueError("Wikidata dump JSON array가 완결되지 않았습니다.")


def collect_wikidata_dump(
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
) -> WikidataDumpCollectionResult:
    if end_ordinal is not None and end_ordinal <= start_ordinal:
        raise ValueError("--end-ordinal은 --start-ordinal보다 커야 합니다.")
    if checkpoint_every < 1:
        raise ValueError("checkpoint_every는 1 이상이어야 합니다.")
    checkpoint = _initial_checkpoint(
        run_id,
        provenance,
        start_ordinal,
        end_ordinal,
    )
    records: list[SourceRecord] = []
    reviews: list[WikidataDumpScopeReview] = []
    if checkpoint_path.exists():
        if not resume:
            raise ValueError("dump checkpoint가 이미 존재합니다. --resume을 사용해야 합니다.")
        checkpoint = _read_dump_checkpoint(checkpoint_path)
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
        reviews = _read_checkpoint_artifacts(
            artifacts_root,
            checkpoint.review_manifest_paths,
            WikidataDumpScopeReview,
        )
        if len(records) != checkpoint.record_count or len(reviews) != checkpoint.review_count:
            raise ValueError("dump checkpoint count와 page artifact가 일치하지 않습니다.")
        if len(records) + len(reviews) > limit:
            raise ValueError("--limit은 기존 dump checkpoint 누적 결과보다 작을 수 없습니다.")

    resumed_record_count = len(records)
    resumed_review_count = len(reviews)
    if checkpoint.complete or len(records) + len(reviews) >= limit:
        return WikidataDumpCollectionResult(
            records=tuple(records),
            reviews=tuple(reviews),
            next_ordinal=checkpoint.next_ordinal,
            scanned_entity_count=0,
            resumed_record_count=resumed_record_count,
            resumed_review_count=resumed_review_count,
            artifact_mutation_count=0,
            complete=checkpoint.complete,
        )

    metadata = wikidata_dump_metadata(provenance)
    retrieved_at = dump_retrieved_at(provenance)
    record_paths = list(checkpoint.record_manifest_paths)
    review_paths = list(checkpoint.review_manifest_paths)
    artifact_mutation_count = 0
    page_records: list[SourceRecord] = []
    page_reviews: list[WikidataDumpScopeReview] = []
    next_ordinal = checkpoint.next_ordinal
    scanned_entity_count = 0
    complete = False

    with _DumpScopeIndex(
        input_path=input_path,
        provenance=provenance,
        artifacts_root=artifacts_root,
        dry_run=dry_run,
    ) as scope_index:
        for ordinal, entity in iter_wikidata_dump(input_path):
            if ordinal < next_ordinal:
                continue
            if end_ordinal is not None and ordinal >= end_ordinal:
                complete = True
                next_ordinal = ordinal
                break
            scanned_entity_count += 1
            next_ordinal = ordinal + 1
            if optional_string(entity.get("type")) == "item":
                classified = scope_index.classify(entity, ordinal, provenance)
                if isinstance(classified, SourceRecord):
                    page_records.append(classified)
                elif isinstance(classified, WikidataDumpScopeReview):
                    page_reviews.append(classified)

            emitted_count = len(records) + len(reviews) + len(page_records) + len(page_reviews)
            should_stop = emitted_count >= limit
            should_checkpoint = scanned_entity_count % checkpoint_every == 0
            if should_stop or should_checkpoint:
                if dry_run:
                    records.extend(page_records)
                    reviews.extend(page_reviews)
                    page_records.clear()
                    page_reviews.clear()
                else:
                    artifact_mutation_count += _flush_dump_page(
                        run_id=run_id,
                        metadata=metadata,
                        provenance=provenance,
                        retrieved_at=retrieved_at,
                        artifact_store=artifact_store,
                        artifacts_root=artifacts_root,
                        records=records,
                        reviews=reviews,
                        page_records=page_records,
                        page_reviews=page_reviews,
                        record_paths=record_paths,
                        review_paths=review_paths,
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

    if page_records or page_reviews or (not dry_run and complete != checkpoint.complete):
        if dry_run:
            records.extend(page_records)
            reviews.extend(page_reviews)
        else:
            artifact_mutation_count += _flush_dump_page(
                run_id=run_id,
                metadata=metadata,
                provenance=provenance,
                retrieved_at=retrieved_at,
                artifact_store=artifact_store,
                artifacts_root=artifacts_root,
                records=records,
                reviews=reviews,
                page_records=page_records,
                page_reviews=page_reviews,
                record_paths=record_paths,
                review_paths=review_paths,
                checkpoint_path=checkpoint_path,
                start_ordinal=start_ordinal,
                end_ordinal=end_ordinal,
                next_ordinal=next_ordinal,
                complete=complete,
                resume=resume,
            )

    return WikidataDumpCollectionResult(
        records=tuple(records),
        reviews=tuple(reviews),
        next_ordinal=next_ordinal,
        scanned_entity_count=scanned_entity_count,
        resumed_record_count=resumed_record_count,
        resumed_review_count=resumed_review_count,
        artifact_mutation_count=artifact_mutation_count,
        complete=complete,
    )


class _DumpScopeIndex(AbstractContextManager["_DumpScopeIndex"]):
    _TARGETS: ClassVar[dict[WikidataScope, str]] = {
        WikidataScope.COMPOSERS: "Q36834",
        WikidataScope.PERFORMERS: "Q639669",
        WikidataScope.ENSEMBLES: "Q2088357",
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
            self._temporary_directory = TemporaryDirectory(prefix="classicmap-wikidata-index-")
            index_path = Path(self._temporary_directory.name) / "scope.sqlite"
        else:
            index_path = (
                artifacts_root / "_indexes" / "wikidata" / f"{provenance.sha256}.scope.sqlite"
            )
            index_path.parent.mkdir(parents=True, exist_ok=True)
        self._connection = sqlite3.connect(index_path)
        self._scope_cache: OrderedDict[str, frozenset[WikidataScope]] = OrderedDict()
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

    def classify(
        self,
        entity: JsonObject,
        ordinal: int,
        provenance: InputFileProvenance,
    ) -> SourceRecord | WikidataDumpScopeReview | None:
        qid = WikidataConnector._entity_id(entity)
        role_codes = WikidataConnector._claim_item_ids(entity, "P106")
        instance_codes = WikidataConnector._claim_item_ids(entity, "P31")
        malformed = _has_malformed_item_claim(entity, "P106") or _has_malformed_item_claim(
            entity, "P31"
        )
        matched: set[WikidataScope] = set()
        for role_code in role_codes:
            matched.update(self._role_scopes(role_code))
        if WikidataScope.COMPOSERS in matched:
            matched.discard(WikidataScope.PERFORMERS)
        for instance_code in instance_codes:
            if self._is_subclass(instance_code, self._TARGETS[WikidataScope.ENSEMBLES]):
                matched.add(WikidataScope.ENSEMBLES)

        evidence: JsonObject = {
            "method": "wikidata-dump-p279-sqlite",
            "input_sha256": provenance.sha256,
            "composer_target_qid": self._TARGETS[WikidataScope.COMPOSERS],
            "performer_target_qid": self._TARGETS[WikidataScope.PERFORMERS],
            "ensemble_target_qid": self._TARGETS[WikidataScope.ENSEMBLES],
            "composer_precedence_over_performer": True,
        }
        if malformed:
            return WikidataDumpScopeReview(
                qid=qid,
                entity_ordinal=ordinal,
                reason_code="UNKNOWN_SCOPE_EVIDENCE",
                matched_scopes=tuple(sorted(matched, key=lambda scope: scope.value)),
                role_codes=tuple(role_codes),
                instance_of_codes=tuple(instance_codes),
                evidence=evidence,
            )
        if len(matched) > 1:
            return WikidataDumpScopeReview(
                qid=qid,
                entity_ordinal=ordinal,
                reason_code="AMBIGUOUS_SCOPE",
                matched_scopes=tuple(sorted(matched, key=lambda scope: scope.value)),
                role_codes=tuple(role_codes),
                instance_of_codes=tuple(instance_codes),
                evidence=evidence,
            )
        if not matched:
            return None
        scope = next(iter(matched))
        linked_ids = sorted(
            {
                qid
                for property_id in ("P27", "P495", "P106", "P1303")
                for qid in WikidataConnector._claim_item_ids(entity, property_id)
            }
        )
        linked_entities = self._linked_entities(linked_ids)
        return WikidataConnector._to_record(
            entity,
            scope,
            linked_entities,
            scope_validation={
                **evidence,
                "validated": True,
                "scope": scope.value,
            },
            entity_data_source=provenance.source_url,
        )

    def _role_scopes(self, role_code: str) -> frozenset[WikidataScope]:
        cached = self._scope_cache.get(role_code)
        if cached is not None:
            self._scope_cache.move_to_end(role_code)
            return cached
        scopes = frozenset(
            scope
            for scope in (WikidataScope.COMPOSERS, WikidataScope.PERFORMERS)
            if self._is_subclass(role_code, self._TARGETS[scope])
        )
        self._scope_cache[role_code] = scopes
        if len(self._scope_cache) > _SCOPE_CACHE_SIZE:
            self._scope_cache.popitem(last=False)
        return scopes

    def _is_subclass(self, child_qid: str, target_qid: str) -> bool:
        if child_qid == target_qid:
            return True
        result = self._connection.execute(
            """
            WITH RECURSIVE ancestors(qid) AS (
              VALUES (?)
              UNION
              SELECT edge.parent_qid
              FROM subclass_edges AS edge
              JOIN ancestors ON edge.child_qid = ancestors.qid
            )
            SELECT 1 FROM ancestors WHERE qid = ? LIMIT 1
            """,
            (child_qid, target_qid),
        ).fetchone()
        return result is not None

    def _linked_entities(self, qids: Sequence[str]) -> dict[str, JsonObject]:
        entities: dict[str, JsonObject] = {}
        for offset in range(0, len(qids), _SQLITE_LOOKUP_BATCH):
            chunk = qids[offset : offset + _SQLITE_LOOKUP_BATCH]
            if not chunk:
                continue
            placeholders = ",".join("?" for _ in chunk)
            rows = self._connection.execute(
                f"SELECT qid, entity_json FROM linked_entities WHERE qid IN ({placeholders})",
                tuple(chunk),
            )
            for qid, entity_json in rows:
                value = json.loads(entity_json)
                if isinstance(value, dict):
                    entities[str(qid)] = value
        return entities

    def _initialize_schema(self) -> None:
        self._connection.executescript(
            """
            CREATE TABLE IF NOT EXISTS metadata (
              key TEXT PRIMARY KEY,
              value TEXT NOT NULL
            );
            CREATE TABLE IF NOT EXISTS subclass_edges (
              child_qid TEXT NOT NULL,
              parent_qid TEXT NOT NULL,
              PRIMARY KEY (child_qid, parent_qid)
            ) WITHOUT ROWID;
            CREATE INDEX IF NOT EXISTS subclass_edges_parent_idx
              ON subclass_edges(parent_qid);
            CREATE TABLE IF NOT EXISTS linked_entities (
              qid TEXT PRIMARY KEY,
              entity_json TEXT NOT NULL
            ) WITHOUT ROWID;
            """
        )
        expected = {
            "schema_version": "1",
            "input_sha256": self._provenance.sha256,
            "input_size_bytes": str(self._provenance.size_bytes),
            "dump_date": self._provenance.dump_date.isoformat(),
            "source_url": self._provenance.source_url,
        }
        existing = dict(self._connection.execute("SELECT key, value FROM metadata"))
        if existing:
            for key, value in expected.items():
                if existing.get(key) != value:
                    raise ValueError(f"Wikidata dump scope index provenance 불일치: {key}")
        else:
            self._connection.executemany(
                "INSERT INTO metadata(key, value) VALUES (?, ?)",
                (*expected.items(), ("next_ordinal", "0"), ("complete", "0")),
            )
            self._connection.commit()

    def _build_or_resume(self) -> None:
        metadata = dict(self._connection.execute("SELECT key, value FROM metadata"))
        if metadata.get("complete") == "1":
            return
        next_ordinal = int(metadata.get("next_ordinal", "0"))
        pending = 0
        for ordinal, entity in iter_wikidata_dump(self._input_path):
            if ordinal < next_ordinal:
                continue
            if optional_string(entity.get("type")) == "item":
                qid = optional_string(entity.get("id"))
                if qid is not None and _QID_PATTERN.fullmatch(qid):
                    parent_qids = WikidataConnector._claim_item_ids(entity, "P279")
                    self._connection.executemany(
                        "INSERT OR IGNORE INTO subclass_edges(child_qid, parent_qid) VALUES (?, ?)",
                        ((qid, parent_qid) for parent_qid in parent_qids),
                    )
                    claims = entity.get("claims")
                    p297_claims: JsonValue = (
                        claims.get("P297", []) if isinstance(claims, dict) else []
                    )
                    linked_entity: JsonObject = {
                        "id": qid,
                        "labels": _en_ko_labels(entity.get("labels")),
                        "aliases": {},
                        "claims": {"P297": p297_claims},
                    }
                    self._connection.execute(
                        "INSERT OR REPLACE INTO linked_entities(qid, entity_json) VALUES (?, ?)",
                        (qid, json.dumps(linked_entity, ensure_ascii=False, separators=(",", ":"))),
                    )
            pending += 1
            if pending >= _INDEX_COMMIT_INTERVAL:
                self._connection.execute(
                    "INSERT OR REPLACE INTO metadata(key, value) VALUES ('next_ordinal', ?)",
                    (str(ordinal + 1),),
                )
                self._connection.commit()
                pending = 0
        self._connection.execute(
            "INSERT OR REPLACE INTO metadata(key, value) VALUES ('complete', '1')"
        )
        self._connection.execute(
            "INSERT OR REPLACE INTO metadata(key, value) VALUES ('next_ordinal', '-1')"
        )
        self._connection.commit()


def _open_dump(path: Path) -> BinaryIO | bz2.BZ2File:
    if path.name.endswith(".json.bz2"):
        return bz2.open(path, "rb")
    return path.open("rb")


def _initial_checkpoint(
    run_id: str,
    provenance: InputFileProvenance,
    start_ordinal: int,
    end_ordinal: int | None,
) -> WikidataDumpCheckpoint:
    return WikidataDumpCheckpoint(
        run_id=run_id,
        input_provenance=provenance,
        partition_start_ordinal=start_ordinal,
        partition_end_ordinal=end_ordinal,
        next_ordinal=start_ordinal,
    )


def _read_dump_checkpoint(path: Path) -> WikidataDumpCheckpoint:
    try:
        return WikidataDumpCheckpoint.model_validate_json(path.read_bytes())
    except ValidationError as error:
        raise ValueError(f"Wikidata dump checkpoint 계약 오류: {error}") from error


def _require_checkpoint_identity(
    checkpoint: WikidataDumpCheckpoint,
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
            "dump checkpoint가 현재 run/input provenance/partition과 일치하지 않습니다."
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
            raise ValueError("dump checkpoint manifest 경로가 artifact 루트 밖을 가리킵니다.")
        _, page_records = read_artifact(manifest_path, record_type)
        records.extend(page_records)
    return records


def _flush_dump_page(
    *,
    run_id: str,
    metadata: SourceMetadata,
    provenance: InputFileProvenance,
    retrieved_at: datetime,
    artifact_store: JsonlArtifactStore,
    artifacts_root: Path,
    records: list[SourceRecord],
    reviews: list[WikidataDumpScopeReview],
    page_records: list[SourceRecord],
    page_reviews: list[WikidataDumpScopeReview],
    record_paths: list[str],
    review_paths: list[str],
    checkpoint_path: Path,
    start_ordinal: int,
    end_ordinal: int | None,
    next_ordinal: int,
    complete: bool,
    resume: bool,
) -> int:
    mutation_count = 0
    if page_records:
        result = artifact_store.write(
            run_id=run_id,
            stage=ArtifactStage.RAW,
            metadata=metadata,
            records=page_records,
            retrieved_at=retrieved_at,
            dry_run=False,
            resume=resume,
            input_provenance=provenance,
        )
        mutation_count += result.mutation_count
        relative = result.manifest_path.relative_to(artifacts_root).as_posix()
        if relative not in record_paths:
            record_paths.append(relative)
        records.extend(page_records)
        page_records.clear()
    if page_reviews:
        result = artifact_store.write(
            run_id=run_id,
            stage=ArtifactStage.RAW,
            metadata=metadata,
            records=page_reviews,
            retrieved_at=retrieved_at,
            dry_run=False,
            resume=resume,
            input_provenance=provenance,
        )
        mutation_count += result.mutation_count
        relative = result.manifest_path.relative_to(artifacts_root).as_posix()
        if relative not in review_paths:
            review_paths.append(relative)
        reviews.extend(page_reviews)
        page_reviews.clear()
    checkpoint = WikidataDumpCheckpoint(
        run_id=run_id,
        input_provenance=provenance,
        partition_start_ordinal=start_ordinal,
        partition_end_ordinal=end_ordinal,
        next_ordinal=next_ordinal,
        record_manifest_paths=tuple(record_paths),
        review_manifest_paths=tuple(review_paths),
        record_count=len(records),
        review_count=len(reviews),
        complete=complete,
    )
    _write_dump_checkpoint(checkpoint_path, checkpoint)
    return mutation_count


def _write_dump_checkpoint(path: Path, checkpoint: WikidataDumpCheckpoint) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    content = f"{checkpoint.model_dump_json(indent=2)}\n".encode()
    with NamedTemporaryFile(dir=path.parent, delete=False) as temporary_file:
        temporary_file.write(content)
        temporary_path = Path(temporary_file.name)
    try:
        os.replace(temporary_path, path)
    finally:
        temporary_path.unlink(missing_ok=True)


def _has_malformed_item_claim(entity: JsonObject, property_id: str) -> bool:
    claims = entity.get("claims")
    if not isinstance(claims, dict) or property_id not in claims:
        return False
    statements = claims.get(property_id)
    if not isinstance(statements, list):
        return True
    for statement in statements:
        if not isinstance(statement, dict):
            return True
        mainsnak = statement.get("mainsnak")
        if not isinstance(mainsnak, dict):
            return True
        if mainsnak.get("snaktype") != "value":
            return True
        datavalue = mainsnak.get("datavalue")
        if not isinstance(datavalue, dict):
            return True
        value = datavalue.get("value")
        if not isinstance(value, dict):
            return True
        qid = optional_string(value.get("id"))
        if qid is None or not _QID_PATTERN.fullmatch(qid):
            return True
    return False


def _en_ko_labels(value: JsonValue) -> JsonObject:
    if not isinstance(value, dict):
        return {}
    labels: JsonObject = {}
    for locale in ("en", "ko"):
        localized = value.get(locale)
        if isinstance(localized, dict):
            name = optional_string(localized.get("value"))
            if name is not None:
                labels[locale] = {"language": locale, "value": name}
    return labels
