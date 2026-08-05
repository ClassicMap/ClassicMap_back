from __future__ import annotations

import hashlib
import os
from collections.abc import Sequence
from datetime import datetime
from pathlib import Path
from tempfile import NamedTemporaryFile

from pydantic import BaseModel

from classicmap_seed.models import (
    ArtifactStage,
    ArtifactWriteResult,
    SnapshotManifest,
    SourceMetadata,
)


class ArtifactIntegrityError(RuntimeError):
    """Immutable artifact가 manifest와 일치하지 않을 때 발생합니다."""


def serialize_jsonl(records: Sequence[BaseModel]) -> bytes:
    lines = [record.model_dump_json(exclude_none=True) for record in records]
    if not lines:
        return b""
    joined = "\n".join(lines)
    return f"{joined}\n".encode()


def sha256_bytes(content: bytes) -> str:
    return hashlib.sha256(content).hexdigest()


def read_manifest(manifest_path: Path) -> SnapshotManifest:
    return SnapshotManifest.model_validate_json(manifest_path.read_bytes())


def read_artifact[RecordT: BaseModel](
    manifest_path: Path,
    record_type: type[RecordT],
) -> tuple[SnapshotManifest, list[RecordT]]:
    manifest = read_manifest(manifest_path)
    data_path = manifest_path.parent / manifest.relative_data_path
    content = data_path.read_bytes()
    actual_sha256 = sha256_bytes(content)
    if actual_sha256 != manifest.sha256:
        raise ArtifactIntegrityError(
            f"artifact SHA-256 불일치: expected={manifest.sha256} actual={actual_sha256}"
        )

    records = [
        record_type.model_validate_json(line) for line in content.splitlines() if line.strip()
    ]
    if len(records) != manifest.row_count:
        raise ArtifactIntegrityError(
            f"artifact row_count 불일치: expected={manifest.row_count} actual={len(records)}"
        )
    return manifest, records


class JsonlArtifactStore:
    def __init__(self, root: Path, *, tool_version: str) -> None:
        self._root = root
        self._tool_version = tool_version

    def write(
        self,
        *,
        run_id: str,
        stage: ArtifactStage,
        metadata: SourceMetadata,
        records: Sequence[BaseModel],
        retrieved_at: datetime,
        dry_run: bool,
        resume: bool,
        parent_sha256: str | None = None,
    ) -> ArtifactWriteResult:
        content = serialize_jsonl(records)
        digest = sha256_bytes(content)
        directory = self._root / run_id / stage / metadata.source
        data_path = directory / f"{digest}.jsonl"
        manifest_path = directory / f"{digest}.manifest.json"
        manifest = SnapshotManifest(
            run_id=run_id,
            stage=stage,
            source=metadata.source,
            snapshot_id=digest,
            retrieved_at=retrieved_at,
            source_uri=metadata.source_uri,
            license=metadata.license,
            license_uri=metadata.license_uri,
            sha256=digest,
            row_count=len(records),
            relative_data_path=data_path.name,
            parent_sha256=parent_sha256,
            tool_version=self._tool_version,
        )

        data_exists = data_path.exists()
        manifest_exists = manifest_path.exists()
        if data_exists:
            self._verify_existing_data(data_path, content)
        if manifest_exists:
            existing_manifest = read_manifest(manifest_path)
            self._verify_existing_manifest(existing_manifest, manifest)
            manifest = existing_manifest

        if data_exists and manifest_exists:
            if not resume:
                raise ArtifactIntegrityError(
                    "동일 artifact가 이미 존재합니다. 재사용하려면 --resume을 사용해야 합니다."
                )
            return ArtifactWriteResult(
                manifest=manifest,
                data_path=data_path,
                manifest_path=manifest_path,
                created=False,
                mutation_count=0,
            )

        if (data_exists or manifest_exists) and not resume:
            raise ArtifactIntegrityError(
                "일부 artifact만 존재합니다. --resume 없이 복구할 수 없습니다."
            )

        mutation_count = len(records)
        if dry_run:
            return ArtifactWriteResult(
                manifest=manifest,
                data_path=data_path,
                manifest_path=manifest_path,
                created=False,
                mutation_count=mutation_count,
            )

        directory.mkdir(parents=True, exist_ok=True)
        if not data_exists:
            self._write_immutable(data_path, content)
        if not manifest_exists:
            manifest_content = f"{manifest.model_dump_json(indent=2)}\n".encode()
            self._write_immutable(manifest_path, manifest_content)

        return ArtifactWriteResult(
            manifest=manifest,
            data_path=data_path,
            manifest_path=manifest_path,
            created=True,
            mutation_count=mutation_count,
        )

    @staticmethod
    def _write_immutable(destination: Path, content: bytes) -> None:
        with NamedTemporaryFile(dir=destination.parent, delete=False) as temporary_file:
            temporary_file.write(content)
            temporary_path = Path(temporary_file.name)
        try:
            os.link(temporary_path, destination)
        except FileExistsError:
            if destination.read_bytes() != content:
                raise ArtifactIntegrityError(f"immutable artifact 충돌: {destination}") from None
        finally:
            temporary_path.unlink(missing_ok=True)

    @staticmethod
    def _verify_existing_data(data_path: Path, expected_content: bytes) -> None:
        existing_content = data_path.read_bytes()
        if existing_content != expected_content:
            raise ArtifactIntegrityError(f"content-addressed artifact 내용 충돌: {data_path}")

    @staticmethod
    def _verify_existing_manifest(
        existing: SnapshotManifest,
        expected: SnapshotManifest,
    ) -> None:
        comparable_fields = (
            "run_id",
            "stage",
            "source",
            "snapshot_id",
            "source_uri",
            "license",
            "license_uri",
            "sha256",
            "row_count",
            "relative_data_path",
            "parent_sha256",
            "tool_version",
        )
        for field in comparable_fields:
            if getattr(existing, field) != getattr(expected, field):
                raise ArtifactIntegrityError(f"immutable manifest metadata 충돌: field={field}")
