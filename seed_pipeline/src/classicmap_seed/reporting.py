from __future__ import annotations

import os
from pathlib import Path
from tempfile import NamedTemporaryFile

from classicmap_seed.models import CommandReport


def render_report(report: CommandReport) -> str:
    return report.model_dump_json(indent=2)


def write_report(report: CommandReport, destination: Path | None, *, dry_run: bool) -> None:
    if destination is None or dry_run:
        return

    destination.parent.mkdir(parents=True, exist_ok=True)
    serialized = f"{render_report(report)}\n".encode()
    with NamedTemporaryFile(dir=destination.parent, delete=False) as temporary_file:
        temporary_file.write(serialized)
        temporary_path = Path(temporary_file.name)
    os.replace(temporary_path, destination)
