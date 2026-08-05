from __future__ import annotations

import os
from pathlib import Path
from tempfile import NamedTemporaryFile

from pydantic import Field

from classicmap_seed.models import SourceName, SourceRecord, StrictModel


class SourcePage(StrictModel):
    records: tuple[SourceRecord, ...]
    next_cursor: str | None
    complete: bool


class CollectionCheckpoint(StrictModel):
    schema_version: str = "1"
    run_id: str
    source: SourceName
    scope: str
    next_cursor: str | None
    page_manifest_paths: tuple[str, ...] = ()
    page_count: int = Field(default=0, ge=0)
    total_records: int = Field(default=0, ge=0)
    complete: bool = False


def read_checkpoint(path: Path) -> CollectionCheckpoint:
    return CollectionCheckpoint.model_validate_json(path.read_bytes())


def write_checkpoint(path: Path, checkpoint: CollectionCheckpoint) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    content = f"{checkpoint.model_dump_json(indent=2)}\n".encode()
    with NamedTemporaryFile(dir=path.parent, delete=False) as temporary_file:
        temporary_file.write(content)
        temporary_path = Path(temporary_file.name)
    try:
        os.replace(temporary_path, path)
    finally:
        temporary_path.unlink(missing_ok=True)
