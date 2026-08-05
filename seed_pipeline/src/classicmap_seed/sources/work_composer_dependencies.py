from __future__ import annotations

import hashlib
import json
import os
import re
from collections.abc import Sequence
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path
from tempfile import NamedTemporaryFile
from typing import Literal
from uuid import UUID

from pydantic import Field, model_validator

from classicmap_seed.artifacts import JsonlArtifactStore, read_artifact
from classicmap_seed.http import JsonHttpClient
from classicmap_seed.models import (
    ArtifactStage,
    CanonicalLoadRecord,
    CommandReport,
    JsonValue,
    LoadTable,
    SourceMetadata,
    SourceRecord,
    StrictModel,
    WikidataScope,
)
from classicmap_seed.sources.base import optional_string, require_list, require_object
from classicmap_seed.sources.wikidata import WikidataConnector

_COMPOSER_KEY_PREFIX = "musicbrainz_artist:"
_ENTITY_URI_PATTERN = re.compile(r"^https?://www\.wikidata\.org/entity/(Q[1-9][0-9]*)$")


class WorkComposerDependencyReview(StrictModel):
    composer_key: str
    musicbrainz_artist_id: str
    matched_qids: tuple[str, ...]
    reason_code: Literal[
        "WORK_COMPOSER_MBID_WIKIDATA_NOT_FOUND",
        "WORK_COMPOSER_MBID_WIKIDATA_AMBIGUOUS",
        "WORK_COMPOSER_QID_MULTIPLE_MBIDS",
    ]


class WorkComposerDependencyBatchRecord(StrictModel):
    musicbrainz_artist_id: str
    matched_qids: tuple[str, ...]
    source_record: SourceRecord | None = None
    review: WorkComposerDependencyReview | None = None

    @model_validator(mode="after")
    def require_result(self) -> WorkComposerDependencyBatchRecord:
        if (self.source_record is None) == (self.review is None):
            raise ValueError(
                "dependency batch 결과는 source_record 또는 review 중 하나여야 합니다."
            )
        return self


class WorkComposerDependencyCheckpoint(StrictModel):
    schema_version: Literal["1"] = "1"
    run_id: str
    input_identity: str
    processed_mbids: tuple[str, ...] = ()
    batch_manifest_paths: tuple[str, ...] = ()
    request_count: int = Field(default=0, ge=0)


class WorkComposerDependencyCommandReport(CommandReport):
    required_composer_count: int = Field(ge=0)
    existing_composer_count: int = Field(ge=0)
    missing_composer_count: int = Field(ge=0)
    selected_composer_count: int = Field(ge=0)
    resolved_composer_count: int = Field(ge=0)
    review_count: int = Field(ge=0)
    resumed_composer_count: int = Field(ge=0)
    request_count: int = Field(ge=0)
    review_data_path: str | None = None
    review_manifest_path: str | None = None


@dataclass(frozen=True, slots=True)
class WorkComposerDependencyPlan:
    required_composer_keys: tuple[str, ...]
    existing_composer_keys: tuple[str, ...]
    missing_composer_mbids: tuple[str, ...]
    input_identity: str


@dataclass(frozen=True, slots=True)
class WorkComposerDependencyCollection:
    records: tuple[SourceRecord, ...]
    reviews: tuple[WorkComposerDependencyReview, ...]
    resumed_composer_count: int
    request_count: int
    artifact_mutation_count: int


def read_work_composer_dependency_plan(
    work_manifest_path: Path,
    composer_manifest_paths: Sequence[Path],
) -> WorkComposerDependencyPlan:
    if not composer_manifest_paths:
        raise ValueError("--composer-manifest를 하나 이상 입력해야 합니다.")
    work_manifest, work_records = read_artifact(work_manifest_path, CanonicalLoadRecord)
    if work_manifest.stage is not ArtifactStage.CANONICAL:
        raise ValueError("work manifest stage는 canonical이어야 합니다.")

    required_keys = sorted(
        {
            foreign_key.target_natural_key
            for record in work_records
            if record.table is LoadTable.PIECES
            for foreign_key in record.foreign_keys
            if foreign_key.column == "composer_id"
            and foreign_key.target_table is LoadTable.COMPOSERS
        }
    )
    required_mbids = {_composer_mbid(key) for key in required_keys}
    if len(required_mbids) != len(required_keys):
        raise ValueError("work composer FK에 중복 canonical MBID가 있습니다.")

    existing_keys: set[str] = set()
    composer_manifest_hashes: set[str] = set()
    for manifest_path in composer_manifest_paths:
        manifest, records = read_artifact(manifest_path, CanonicalLoadRecord)
        if manifest.stage is not ArtifactStage.CANONICAL:
            raise ValueError("composer manifest stage는 canonical이어야 합니다.")
        composer_manifest_hashes.add(manifest.sha256)
        for record in records:
            if record.table is not LoadTable.COMPOSERS:
                continue
            if not record.natural_key.startswith(_COMPOSER_KEY_PREFIX):
                continue
            _composer_mbid(record.natural_key)
            existing_keys.add(record.natural_key)

    missing_keys = sorted(set(required_keys) - existing_keys)
    missing_mbids = tuple(_composer_mbid(key) for key in missing_keys)
    identity_payload = {
        "work_manifest_sha256": work_manifest.sha256,
        "composer_manifest_sha256s": sorted(composer_manifest_hashes),
        "required_composer_keys": required_keys,
    }
    input_identity = hashlib.sha256(
        json.dumps(
            identity_payload,
            ensure_ascii=False,
            sort_keys=True,
            separators=(",", ":"),
        ).encode()
    ).hexdigest()
    return WorkComposerDependencyPlan(
        required_composer_keys=tuple(required_keys),
        existing_composer_keys=tuple(sorted(existing_keys.intersection(required_keys))),
        missing_composer_mbids=missing_mbids,
        input_identity=input_identity,
    )


class WorkComposerDependencyConnector:
    _QUERY_URL = "https://query.wikidata.org/sparql"

    def __init__(
        self,
        http_client: JsonHttpClient,
        wikidata_connector: WikidataConnector,
    ) -> None:
        self._http_client = http_client
        self._wikidata_connector = wikidata_connector

    @property
    def metadata(self) -> SourceMetadata:
        return self._wikidata_connector.metadata

    def fetch_batch(
        self,
        musicbrainz_artist_ids: Sequence[str],
    ) -> tuple[WorkComposerDependencyBatchRecord, ...]:
        mbids = tuple(sorted({_canonical_mbid(value) for value in musicbrainz_artist_ids}))
        if not mbids:
            return ()
        payload = self._http_client.get_json(
            self._QUERY_URL,
            params={"query": self._build_query(mbids), "format": "json"},
        )
        root = require_object(payload, field="Wikidata MBID dependency response")
        results = require_object(root.get("results"), field="results")
        bindings = require_list(results.get("bindings"), field="results.bindings")
        qids_by_mbid: dict[str, set[str]] = {mbid: set() for mbid in mbids}
        for binding_value in bindings:
            binding = require_object(binding_value, field="results.bindings[]")
            mbid = _binding_value(binding.get("mbid"), field="binding.mbid")
            if mbid not in qids_by_mbid:
                raise ValueError(
                    f"WDQS가 요청하지 않은 MusicBrainz artist ID를 반환했습니다: {mbid}"
                )
            entity_uri = _binding_value(binding.get("entity"), field="binding.entity")
            match = _ENTITY_URI_PATTERN.fullmatch(entity_uri)
            if match is None:
                raise ValueError("Wikidata entity URI가 올바르지 않습니다.")
            qids_by_mbid[mbid].add(match.group(1))

        unique_qids = sorted(
            {
                qids[0]
                for qids in (sorted(values) for values in qids_by_mbid.values())
                if len(qids) == 1
            }
        )
        records_by_qid = self._enrich_qids(unique_qids)
        batch_records: list[WorkComposerDependencyBatchRecord] = []
        for mbid in mbids:
            qids = tuple(sorted(qids_by_mbid[mbid]))
            composer_key = f"{_COMPOSER_KEY_PREFIX}{mbid}"
            if not qids:
                review = WorkComposerDependencyReview(
                    composer_key=composer_key,
                    musicbrainz_artist_id=mbid,
                    matched_qids=(),
                    reason_code="WORK_COMPOSER_MBID_WIKIDATA_NOT_FOUND",
                )
                batch_records.append(
                    WorkComposerDependencyBatchRecord(
                        musicbrainz_artist_id=mbid,
                        matched_qids=(),
                        review=review,
                    )
                )
                continue
            if len(qids) > 1:
                review = WorkComposerDependencyReview(
                    composer_key=composer_key,
                    musicbrainz_artist_id=mbid,
                    matched_qids=qids,
                    reason_code="WORK_COMPOSER_MBID_WIKIDATA_AMBIGUOUS",
                )
                batch_records.append(
                    WorkComposerDependencyBatchRecord(
                        musicbrainz_artist_id=mbid,
                        matched_qids=qids,
                        review=review,
                    )
                )
                continue

            record = records_by_qid[qids[0]]
            entity_mbids = _record_musicbrainz_artist_ids(record)
            if entity_mbids != (mbid,):
                review = WorkComposerDependencyReview(
                    composer_key=composer_key,
                    musicbrainz_artist_id=mbid,
                    matched_qids=qids,
                    reason_code="WORK_COMPOSER_QID_MULTIPLE_MBIDS",
                )
                batch_records.append(
                    WorkComposerDependencyBatchRecord(
                        musicbrainz_artist_id=mbid,
                        matched_qids=qids,
                        review=review,
                    )
                )
                continue
            batch_records.append(
                WorkComposerDependencyBatchRecord(
                    musicbrainz_artist_id=mbid,
                    matched_qids=qids,
                    source_record=record,
                )
            )
        return tuple(batch_records)

    @staticmethod
    def _build_query(mbids: Sequence[str]) -> str:
        values = " ".join(f'"{_canonical_mbid(mbid)}"' for mbid in mbids)
        return f"""
PREFIX wdt: <http://www.wikidata.org/prop/direct/>
SELECT DISTINCT ?mbid ?entity WHERE {{
  VALUES ?mbid {{ {values} }}
  ?entity wdt:P434 ?mbid .
}}
ORDER BY ?mbid STR(?entity)
""".strip()

    def _enrich_qids(self, qids: list[str]) -> dict[str, SourceRecord]:
        entities = self._wikidata_connector._fetch_entities(qids)
        linked_ids = sorted(
            {
                qid
                for entity in entities
                for property_id in ("P27", "P495", "P106", "P1303")
                for qid in self._wikidata_connector._claim_item_ids(entity, property_id)
            }
        )
        linked_entities = {
            self._wikidata_connector._entity_id(entity): entity
            for entity in self._wikidata_connector._fetch_entities(linked_ids)
        }
        return {
            self._wikidata_connector._entity_id(entity): self._wikidata_connector._to_record(
                entity,
                WikidataScope.COMPOSERS,
                linked_entities,
            )
            for entity in entities
        }


def collect_work_composer_dependencies(
    *,
    run_id: str,
    plan: WorkComposerDependencyPlan,
    connector: WorkComposerDependencyConnector,
    artifact_store: JsonlArtifactStore,
    artifacts_root: Path,
    checkpoint_path: Path,
    retrieved_at: datetime,
    limit: int,
    batch_size: int,
    dry_run: bool,
    resume: bool,
) -> WorkComposerDependencyCollection:
    if not 1 <= batch_size <= 100:
        raise ValueError("batch_size는 1~100이어야 합니다.")
    selected_mbids = plan.missing_composer_mbids[:limit]
    checkpoint = WorkComposerDependencyCheckpoint(
        run_id=run_id,
        input_identity=plan.input_identity,
    )
    batch_records: list[WorkComposerDependencyBatchRecord] = []
    if checkpoint_path.exists():
        if not resume:
            raise ValueError("checkpoint가 이미 존재합니다. --resume을 사용해야 합니다.")
        checkpoint = read_work_composer_dependency_checkpoint(checkpoint_path)
        if checkpoint.run_id != run_id or checkpoint.input_identity != plan.input_identity:
            raise ValueError("checkpoint가 현재 run 또는 canonical 입력과 일치하지 않습니다.")
        if len(checkpoint.processed_mbids) > len(selected_mbids):
            raise ValueError("--limit은 checkpoint 처리 건수보다 작을 수 없습니다.")
        if selected_mbids[: len(checkpoint.processed_mbids)] != checkpoint.processed_mbids:
            raise ValueError("checkpoint 처리 순서가 현재 missing composer prefix와 다릅니다.")
        batch_records = _read_batch_records(artifacts_root, checkpoint.batch_manifest_paths)
        if tuple(record.musicbrainz_artist_id for record in batch_records) != (
            checkpoint.processed_mbids
        ):
            raise ValueError("checkpoint 처리 MBID와 immutable batch artifact가 일치하지 않습니다.")

    resumed_count = len(batch_records)
    request_count = 0
    artifact_mutation_count = 0
    manifest_paths = list(checkpoint.batch_manifest_paths)
    while len(batch_records) < len(selected_mbids):
        offset = len(batch_records)
        batch_mbids = selected_mbids[offset : offset + batch_size]
        fetched = connector.fetch_batch(batch_mbids)
        if tuple(record.musicbrainz_artist_id for record in fetched) != batch_mbids:
            raise ValueError("dependency batch 응답 순서가 요청 MBID 순서와 다릅니다.")
        request_count += 1
        batch_records.extend(fetched)
        if dry_run:
            continue
        page_result = artifact_store.write(
            run_id=run_id,
            stage=ArtifactStage.RAW,
            metadata=connector.metadata,
            records=fetched,
            retrieved_at=retrieved_at,
            dry_run=False,
            resume=resume,
        )
        artifact_mutation_count += page_result.mutation_count
        relative_manifest = page_result.manifest_path.relative_to(artifacts_root).as_posix()
        if relative_manifest not in manifest_paths:
            manifest_paths.append(relative_manifest)
        checkpoint = WorkComposerDependencyCheckpoint(
            run_id=run_id,
            input_identity=plan.input_identity,
            processed_mbids=tuple(record.musicbrainz_artist_id for record in batch_records),
            batch_manifest_paths=tuple(manifest_paths),
            request_count=checkpoint.request_count + 1,
        )
        write_work_composer_dependency_checkpoint(checkpoint_path, checkpoint)

    records = tuple(
        sorted(
            (record.source_record for record in batch_records if record.source_record is not None),
            key=lambda record: record.source_record_id,
        )
    )
    reviews = tuple(
        sorted(
            (record.review for record in batch_records if record.review is not None),
            key=lambda review: review.musicbrainz_artist_id,
        )
    )
    return WorkComposerDependencyCollection(
        records=records,
        reviews=reviews,
        resumed_composer_count=resumed_count,
        request_count=request_count,
        artifact_mutation_count=artifact_mutation_count,
    )


def read_work_composer_dependency_checkpoint(
    path: Path,
) -> WorkComposerDependencyCheckpoint:
    return WorkComposerDependencyCheckpoint.model_validate_json(path.read_bytes())


def write_work_composer_dependency_checkpoint(
    path: Path,
    checkpoint: WorkComposerDependencyCheckpoint,
) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    content = f"{checkpoint.model_dump_json(indent=2)}\n".encode()
    with NamedTemporaryFile(dir=path.parent, delete=False) as temporary_file:
        temporary_file.write(content)
        temporary_path = Path(temporary_file.name)
    try:
        os.replace(temporary_path, path)
    finally:
        temporary_path.unlink(missing_ok=True)


def _read_batch_records(
    artifacts_root: Path,
    manifest_paths: Sequence[str],
) -> list[WorkComposerDependencyBatchRecord]:
    root = artifacts_root.resolve()
    records: list[WorkComposerDependencyBatchRecord] = []
    for relative_path in manifest_paths:
        manifest_path = (artifacts_root / relative_path).resolve()
        if not manifest_path.is_relative_to(root):
            raise ValueError("checkpoint batch manifest 경로가 artifact 루트 밖을 가리킵니다.")
        _, page_records = read_artifact(manifest_path, WorkComposerDependencyBatchRecord)
        records.extend(page_records)
    return records


def _composer_mbid(composer_key: str) -> str:
    if not composer_key.startswith(_COMPOSER_KEY_PREFIX):
        raise ValueError(
            f"composer natural key가 MusicBrainz artist 형식이 아닙니다: {composer_key}"
        )
    return _canonical_mbid(composer_key.removeprefix(_COMPOSER_KEY_PREFIX))


def _canonical_mbid(value: str) -> str:
    try:
        parsed = UUID(value)
    except ValueError as error:
        raise ValueError(f"MusicBrainz artist ID가 UUID 형식이 아닙니다: {value}") from error
    canonical = str(parsed)
    if canonical != value:
        raise ValueError(f"MusicBrainz artist ID는 canonical 소문자 UUID여야 합니다: {value}")
    return canonical


def _binding_value(value: JsonValue, *, field: str) -> str:
    binding = require_object(value, field=field)
    result = optional_string(binding.get("value"))
    if result is None:
        raise ValueError(f"{field}.value가 없습니다.")
    return result


def _record_musicbrainz_artist_ids(record: SourceRecord) -> tuple[str, ...]:
    identifiers = record.payload.get("external_identifiers")
    if not isinstance(identifiers, dict):
        return ()
    values = identifiers.get("musicbrainz_artist")
    if not isinstance(values, list):
        return ()
    return tuple(sorted({_canonical_mbid(value) for value in values if isinstance(value, str)}))
