from __future__ import annotations

from collections.abc import Sequence
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path

from classicmap_seed.artifacts import JsonlArtifactStore, read_artifact
from classicmap_seed.models import ArtifactStage, SourceMetadata, SourceRecord
from classicmap_seed.sources.base import optional_string
from classicmap_seed.sources.musicbrainz_work_exact_input import (
    MusicBrainzWorkEntityRequest,
    is_musicbrainz_work_mbid,
)
from classicmap_seed.sources.musicbrainz_works import MusicBrainzWorkConnector
from classicmap_seed.sources.pagination import (
    CollectionCheckpoint,
    SourcePage,
    read_checkpoint,
    write_checkpoint,
)


@dataclass(frozen=True, slots=True)
class ExactWorkHierarchyCollectionResult:
    records: tuple[SourceRecord, ...]
    request_count: int
    resumed_record_count: int
    artifact_mutation_count: int
    checkpoint: CollectionCheckpoint


@dataclass(frozen=True, slots=True, order=True)
class _HierarchyNode:
    depth: int
    mbid: str
    root_mbid: str
    relation_type: str


def collect_exact_work_hierarchy(
    *,
    connector: MusicBrainzWorkConnector,
    requests: Sequence[MusicBrainzWorkEntityRequest],
    input_sha256: str,
    run_id: str,
    metadata: SourceMetadata,
    artifact_store: JsonlArtifactStore,
    artifacts_root: Path,
    checkpoint_path: Path,
    retrieved_at: datetime,
    root_limit: int,
    max_depth: int,
    max_records: int,
    dry_run: bool,
    resume: bool,
) -> ExactWorkHierarchyCollectionResult:
    """Collect exact roots plus only the `parts` parents required by canonical export."""
    if root_limit < 1:
        raise ValueError("MusicBrainz exact work root_limit은 1 이상이어야 합니다.")
    if max_depth < 0:
        raise ValueError("MusicBrainz work hierarchy max_depth는 음수일 수 없습니다.")
    if max_records < 1:
        raise ValueError("MusicBrainz work hierarchy max_records는 1 이상이어야 합니다.")

    roots = tuple(request.mbid for request in requests[:root_limit])
    scope = (
        f"exact-work-hierarchy:{input_sha256}:roots={len(roots)}:"
        f"depth={max_depth}:records={max_records}"
    )
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
        if (
            checkpoint.run_id != run_id
            or checkpoint.source != metadata.source
            or checkpoint.scope != scope
        ):
            raise ValueError("checkpoint가 현재 run/source/hierarchy 입력과 일치하지 않습니다.")
        records = _read_checkpoint_records(artifacts_root, checkpoint)
        if len(records) != checkpoint.total_records:
            raise ValueError("checkpoint total_records와 page artifact가 일치하지 않습니다.")
        if len(records) > max_records:
            raise ValueError("--max-hierarchy-records는 기존 checkpoint보다 작을 수 없습니다.")

    resumed_record_count = len(records)
    request_count = 0
    artifact_mutation_count = 0
    page_manifest_paths = list(checkpoint.page_manifest_paths)

    while True:
        pending = _pending_hierarchy_nodes(
            roots=roots,
            records=records,
            max_depth=max_depth,
        )
        if not pending:
            complete = True
            break
        if len(records) >= max_records:
            raise ValueError("MusicBrainz work hierarchy가 --max-hierarchy-records를 초과했습니다.")

        node = pending[0]
        record = connector.fetch_exact(work_mbid=node.mbid)
        request_count += 1
        annotated = _annotate_hierarchy_record(record, node)
        records.append(annotated)

        if not dry_run:
            page_result = artifact_store.write(
                run_id=run_id,
                stage=ArtifactStage.RAW,
                metadata=metadata,
                records=(annotated,),
                retrieved_at=retrieved_at,
                dry_run=False,
                resume=resume,
            )
            artifact_mutation_count += page_result.mutation_count
            relative_manifest = page_result.manifest_path.relative_to(artifacts_root).as_posix()
            if relative_manifest not in page_manifest_paths:
                page_manifest_paths.append(relative_manifest)
            complete = not _pending_hierarchy_nodes(
                roots=roots,
                records=records,
                max_depth=max_depth,
            )
            checkpoint = CollectionCheckpoint(
                run_id=run_id,
                source=metadata.source,
                scope=scope,
                next_cursor=None,
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
        next_cursor=None,
        page_manifest_paths=tuple(page_manifest_paths),
        page_count=len(page_manifest_paths),
        total_records=len(records),
        complete=complete,
    )
    return ExactWorkHierarchyCollectionResult(
        records=tuple(records),
        request_count=request_count,
        resumed_record_count=resumed_record_count,
        artifact_mutation_count=artifact_mutation_count,
        checkpoint=checkpoint,
    )


def fetch_exact_work_request_page(
    connector: MusicBrainzWorkConnector,
    requests: Sequence[MusicBrainzWorkEntityRequest],
    *,
    page_size: int,
    cursor: str | None,
) -> SourcePage:
    if page_size != 1:
        raise ValueError("MusicBrainz exact work page_size는 1이어야 합니다.")
    offset = _parse_cursor(cursor, len(requests))
    if offset == len(requests):
        return SourcePage(records=(), next_cursor=None, complete=True)

    record = connector.fetch_exact(work_mbid=requests[offset].mbid)
    next_offset = offset + 1
    complete = next_offset >= len(requests)
    return SourcePage(
        records=(record,),
        next_cursor=None if complete else str(next_offset),
        complete=complete,
    )


def _parse_cursor(cursor: str | None, request_count: int) -> int:
    if cursor is None:
        return 0
    if (
        not cursor.isascii()
        or not cursor.isdecimal()
        or (len(cursor) > 1 and cursor.startswith("0"))
    ):
        raise ValueError("MusicBrainz exact work cursor는 정규 10진수 offset이어야 합니다.")
    offset = int(cursor)
    if offset < 0 or offset > request_count:
        raise ValueError("MusicBrainz exact work cursor가 입력 범위를 벗어났습니다.")
    return offset


def _pending_hierarchy_nodes(
    *,
    roots: tuple[str, ...],
    records: Sequence[SourceRecord],
    max_depth: int,
) -> list[_HierarchyNode]:
    record_by_mbid = {record.source_record_id: record for record in records}
    best: dict[str, _HierarchyNode] = {}
    queue = [
        _HierarchyNode(depth=0, mbid=mbid, root_mbid=mbid, relation_type="root") for mbid in roots
    ]
    while queue:
        queue.sort()
        node = queue.pop(0)
        previous = best.get(node.mbid)
        if previous is not None and previous <= node:
            continue
        best[node.mbid] = node
        record = record_by_mbid.get(node.mbid)
        if record is None:
            continue
        for parent_mbid in _parent_work_mbids(record):
            parent_depth = node.depth + 1
            if parent_depth > max_depth:
                raise ValueError(
                    "MusicBrainz work hierarchy가 --max-hierarchy-depth를 초과했습니다: "
                    f"root={node.root_mbid}, parent={parent_mbid}, depth={parent_depth}"
                )
            queue.append(
                _HierarchyNode(
                    depth=parent_depth,
                    mbid=parent_mbid,
                    root_mbid=node.root_mbid,
                    relation_type="parts:backward",
                )
            )
    return sorted(node for mbid, node in best.items() if mbid not in record_by_mbid)


def _parent_work_mbids(record: SourceRecord) -> tuple[str, ...]:
    relations = record.payload.get("relations")
    if not isinstance(relations, list):
        return ()
    parent_mbids: set[str] = set()
    for relation in relations:
        if not isinstance(relation, dict):
            continue
        if (
            optional_string(relation.get("relation_type")) != "parts"
            or optional_string(relation.get("direction")) != "backward"
            or optional_string(relation.get("target_type")) != "work"
        ):
            continue
        parent_mbid = optional_string(relation.get("target_work_id"))
        if parent_mbid is None or not is_musicbrainz_work_mbid(parent_mbid):
            raise ValueError("MusicBrainz parent work MBID가 canonical UUID가 아닙니다.")
        parent_mbids.add(parent_mbid)
    return tuple(sorted(parent_mbids))


def _annotate_hierarchy_record(
    record: SourceRecord,
    node: _HierarchyNode,
) -> SourceRecord:
    payload = dict(record.payload)
    payload["exact_hierarchy"] = {
        "root_mbid": node.root_mbid,
        "depth": node.depth,
        "relation_type": node.relation_type,
    }
    return record.model_copy(update={"payload": payload})


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
