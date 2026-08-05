from __future__ import annotations

import json
from pathlib import Path

import pytest

from classicmap_seed.projection_overrides import (
    projection_override_fingerprint,
    read_projection_overrides,
)


def payload(qid: str = "Q1339") -> dict[str, object]:
    return {
        "contract_version": "projection-override-v1",
        "target": "composer",
        "wikidata_qid": qid,
        "field": "nationality",
        "value": "독일",
        "reviewer": "fixture-reviewer",
        "reviewed_at": "2026-08-05T00:00:00Z",
        "evidence_url": f"https://www.wikidata.org/wiki/{qid}",
        "evidence_note": "legacy 대표 표시값을 명시적으로 검수했습니다.",
    }


def row(qid: str = "Q1339") -> dict[str, object]:
    value = payload(qid)
    return {**value, "record_fingerprint": projection_override_fingerprint(value)}


def write_rows(path: Path, rows: list[dict[str, object]]) -> None:
    path.write_text("".join(f"{json.dumps(item, ensure_ascii=False)}\n" for item in rows))


def test_reads_strict_fingerprinted_overrides(tmp_path: Path) -> None:
    path = tmp_path / "overrides.jsonl"
    write_rows(path, [row()])

    overrides = read_projection_overrides(path)

    assert len(overrides.records) == 1
    assert overrides.records[0].value == "독일"
    assert len(overrides.input_sha256) == 64


def test_rejects_tamper_and_duplicate_target(tmp_path: Path) -> None:
    tampered = row()
    tampered["value"] = "다른 값"
    tampered_path = tmp_path / "tampered.jsonl"
    write_rows(tampered_path, [tampered])
    with pytest.raises(ValueError, match="record_fingerprint"):
        read_projection_overrides(tampered_path)

    duplicate_path = tmp_path / "duplicate.jsonl"
    write_rows(duplicate_path, [row(), row()])
    with pytest.raises(ValueError, match="중복"):
        read_projection_overrides(duplicate_path)
