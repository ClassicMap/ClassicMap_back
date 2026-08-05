from __future__ import annotations

from collections.abc import Callable
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path

from classicmap_seed.artifacts import JsonlArtifactStore, read_artifact
from classicmap_seed.models import ArtifactStage, SourceMetadata, SourceRecord
from classicmap_seed.sources.pagination import (
    CollectionCheckpoint,
    SourcePage,
    read_checkpoint,
    write_checkpoint,
)


@dataclass(frozen=True, slots=True)
class PaginatedCollectionResult:
    records: tuple[SourceRecord, ...]
    request_count: int
    resumed_record_count: int
    checkpoint: CollectionCheckpoint


def collect_paginated(
    *,
    run_id: str,
    scope: str,
    metadata: SourceMetadata,
    fetch_page: Callable[[int, str | None], SourcePage],
    artifact_store: JsonlArtifactStore,
    artifacts_root: Path,
    checkpoint_path: Path,
    retrieved_at: datetime,
    limit: int,
    page_size: int,
    max_pages: int | None,
    dry_run: bool,
    resume: bool,
) -> PaginatedCollectionResult:
    checkpoint = CollectionCheckpoint(
        run_id=run_id,
        source=metadata.source,
        scope=scope,
        next_cursor=None,
    )
    records: list[SourceRecord] = []
    if checkpoint_path.exists():
        if not resume:
            raise ValueError("checkpoint가 이미 존재합니다. --resume을 사용해야 합니다.")
        checkpoint = read_checkpoint(checkpoint_path)
        _require_checkpoint_identity(checkpoint, run_id, metadata, scope)
        records = _read_checkpoint_records(artifacts_root, checkpoint)
        if len(records) != checkpoint.total_records:
            raise ValueError("checkpoint total_records와 page artifact가 일치하지 않습니다.")
        if len(records) > limit:
            raise ValueError("--limit은 기존 checkpoint 누적 건수보다 작을 수 없습니다.")

    resumed_record_count = len(records)
    request_count = 0
    page_manifest_paths = list(checkpoint.page_manifest_paths)
    next_cursor = checkpoint.next_cursor
    complete = checkpoint.complete

    while not complete and len(records) < limit:
        if max_pages is not None and request_count >= max_pages:
            break
        request_limit = min(page_size, limit - len(records))
        page = fetch_page(request_limit, next_cursor)
        request_count += 1
        if len(page.records) > request_limit:
            raise ValueError("source page가 요청한 page_size보다 많은 행을 반환했습니다.")
        if not page.records and not page.complete:
            raise ValueError("빈 page는 complete여야 합니다.")
        records.extend(page.records)
        next_cursor = page.next_cursor
        complete = page.complete

        if not dry_run:
            page_result = artifact_store.write(
                run_id=run_id,
                stage=ArtifactStage.RAW,
                metadata=metadata,
                records=page.records,
                retrieved_at=retrieved_at,
                dry_run=False,
                resume=resume,
            )
            relative_manifest = page_result.manifest_path.relative_to(artifacts_root).as_posix()
            if relative_manifest not in page_manifest_paths:
                page_manifest_paths.append(relative_manifest)
            checkpoint = CollectionCheckpoint(
                run_id=run_id,
                source=metadata.source,
                scope=scope,
                next_cursor=next_cursor,
                page_manifest_paths=tuple(page_manifest_paths),
                page_count=len(page_manifest_paths),
                total_records=len(records),
                complete=complete,
            )
            write_checkpoint(checkpoint_path, checkpoint)

    checkpoint = CollectionCheckpoint(
        run_id=run_id,
        source=metadata.source,
        scope=scope,
        next_cursor=next_cursor,
        page_manifest_paths=tuple(page_manifest_paths),
        page_count=len(page_manifest_paths),
        total_records=len(records),
        complete=complete,
    )
    return PaginatedCollectionResult(
        records=tuple(records),
        request_count=request_count,
        resumed_record_count=resumed_record_count,
        checkpoint=checkpoint,
    )


def _require_checkpoint_identity(
    checkpoint: CollectionCheckpoint,
    run_id: str,
    metadata: SourceMetadata,
    scope: str,
) -> None:
    if (
        checkpoint.run_id != run_id
        or checkpoint.source != metadata.source
        or checkpoint.scope != scope
    ):
        raise ValueError("checkpoint가 현재 run/source/scope와 일치하지 않습니다.")


def _read_checkpoint_records(
    artifacts_root: Path,
    checkpoint: CollectionCheckpoint,
) -> list[SourceRecord]:
    root = artifacts_root.resolve()
    records: list[SourceRecord] = []
    for relative_path in checkpoint.page_manifest_paths:
        manifest_path = (artifacts_root / relative_path).resolve()
        if not manifest_path.is_relative_to(root):
            raise ValueError("checkpoint page manifest 경로가 artifact 루트 밖을 가리킵니다.")
        _, page_records = read_artifact(manifest_path, SourceRecord)
        records.extend(page_records)
    return records
