"""애매한 링크를 사람이 근거를 보고 정한 결과(review-decisions.jsonl)를 반영한다.

마이그레이션과 곡 링크를 다시 붙일 match.py 입력을 만든다.
review-decisions.jsonl 한 줄 = 서비스·작품·action(keep|replace|clear)·근거(reason).
replace 는 새 앨범 ID 도 있다.
- replace·clear: 작품 링크를 바꾸거나 지우고 그 서비스의 곡 링크를 비운다
  (지금 값이 판정 때 본 값과 같을 때만).
- replace: 새 앨범 트랙(끝까지)으로 곡 링크를 다시 붙일 match.py 입력을 쓴다.
- keep 인 전집 상자: 트랙을 끝까지 받은 앨범으로 빈 곡 링크만 채울 match.py 입력을 쓴다.
사용: uv run python apply_review.py <review-decisions.jsonl> apple|spotify <앨범 트랙 폴더>
      <parts.tsv(export_fix_parts.sql)> <out 폴더> <마이그레이션.sql>
"""

from __future__ import annotations

import csv
import importlib.util
import json
import sys
from pathlib import Path
from types import ModuleType
from typing import Any


def _load(path: Path, name: str) -> ModuleType:
    spec = importlib.util.spec_from_file_location(name, path)
    if spec is None or spec.loader is None:
        raise ImportError(str(path))
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


build_fix = _load(Path(__file__).resolve().parent / "build_fix.py", "build_fix")
COLUMN = build_fix.COLUMN
SERVICE = build_fix.SERVICE


def main() -> None:
    review, service, raw, parts_path, out, migration = sys.argv[1:7]
    column = COLUMN[service]
    with open(review, encoding="utf-8") as handle:
        rows = [r for r in map(json.loads, handle) if r["service"] == service]
    parts: dict[int, list[dict[str, str]]] = {}
    with open(parts_path, encoding="utf-8") as handle:
        for part in csv.DictReader(handle, delimiter="\t"):
            parts.setdefault(int(part["piece_id"]), []).append(part)

    changed: list[dict[str, Any]] = []
    refill: list[tuple[int, str]] = []
    for row in rows:
        if row["action"] == "replace":
            tracks = build_fix.ensure_tracks(service, row["albumId"], raw)
            row["new"] = build_fix.album_link(service, row["albumId"], tracks)
            changed.append(row)
            refill.append((int(row["pieceId"]), row["new"]))
        elif row["action"] == "clear":
            changed.append(row)
        elif row["verdict"] == "box":
            refill.append((int(row["pieceId"]), row["current"]))

    fields = list(next(iter(parts.values()))[0].keys()) if parts else []
    with (
        open(
            f"{out}/{service}-review-match-parts.tsv", "w", encoding="utf-8", newline=""
        ) as handle,
        open(
            f"{out}/{service}-review-match-top.tsv", "w", encoding="utf-8", newline=""
        ) as top_handle,
    ):
        writer = csv.DictWriter(handle, fieldnames=fields, delimiter="\t")
        top_writer = csv.DictWriter(top_handle, fieldnames=fields, delimiter="\t")
        writer.writeheader()
        top_writer.writeheader()
        cleared = {int(r["pieceId"]) for r in changed}
        for piece_id, album_url in refill:
            for part in parts.get(piece_id, []):
                fixed = dict(part) | {column: album_url}
                if piece_id in cleared:
                    fixed |= {"part_apple": "", "part_spotify": ""}
                writer.writerow(fixed)
                if not part["parent_part_id"]:
                    top_writer.writerow(fixed)

    values = ",\n".join(
        f"({r['pieceId']}, {build_fix.sql_text(r['current'])}, "
        + (build_fix.sql_text(r["new"]) if r["action"] == "replace" else "NULL")
        + ")"
        for r in changed
    )
    temp = f"tmp_review_piece_{service}"
    sql = [
        f"-- 애매한 작품 {SERVICE[service]} 링크를 근거를 보고 바로잡는다. 자료와 근거는",
        "-- seed_pipeline/curation/piece-link-audit-2026-11-09/",
        "-- (review-decisions.jsonl, apply_review.py).",
        f"-- 바꿈 {sum(r['action'] == 'replace' for r in changed)}곳, "
        f"지움 {sum(r['action'] == 'clear' for r in changed)}곳.",
        "-- 지금 값이 판정 때 본 값과 같을 때만 바꾸고, 그 작품의 곡 링크는 비운다",
        "-- (새 앨범에서 다시 채움).",
        "",
        f"CREATE TEMPORARY TABLE {temp} (",
        "    piece_id INT NOT NULL PRIMARY KEY,",
        "    old_url VARCHAR(500) NOT NULL,",
        "    new_url VARCHAR(500) NULL",
        ");",
    ]
    if changed:
        sql.append(f"INSERT INTO {temp} (piece_id, old_url, new_url) VALUES\n{values};")
    sql += [
        "",
        "UPDATE piece_parts part",
        f"JOIN {temp} fix ON fix.piece_id = part.piece_id",
        "JOIN pieces piece ON piece.id = fix.piece_id",
        f"SET part.{column} = NULL",
        f"WHERE piece.{column} = fix.old_url;",
        "",
        "UPDATE pieces piece",
        f"JOIN {temp} fix ON fix.piece_id = piece.id",
        f"SET piece.{column} = fix.new_url",
        f"WHERE piece.{column} = fix.old_url;",
        "",
        f"DROP TEMPORARY TABLE {temp};",
        "",
    ]
    with open(migration, "w", encoding="utf-8") as handle:
        handle.write("\n".join(sql))
    print(
        json.dumps(
            {
                "replace": sum(r["action"] == "replace" for r in changed),
                "clear": sum(r["action"] == "clear" for r in changed),
                "refill": len(refill),
            }
        )
    )


if __name__ == "__main__":
    main()
