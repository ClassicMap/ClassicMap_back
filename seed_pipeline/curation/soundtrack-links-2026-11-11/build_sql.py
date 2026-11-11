# ruff: noqa: E501 — 한국어 설명을 그대로 둔다.
"""decisions.jsonl → 마이그레이션. 비어 있을 때만 채우고, 바꾸거나 지울 땐 지금 값이 본 값과 같을 때만.

사용: python3 build_sql.py <decisions.jsonl> > ../../../migrations/202611111001_fill_soundtrack_links.sql
"""

from __future__ import annotations

import json
import sys
from collections import Counter
from typing import Any

COLUMN = {"apple": "apple_music_url", "spotify": "spotify_url"}


def q(value: str) -> str:
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def statement(item: dict[str, Any]) -> str:
    col = COLUMN[item["service"]]
    table = "piece_parts" if item["kind"] == "part" else "pieces"
    target = item["partId"] if item["kind"] == "part" else item["pieceId"]
    where = f"id = {target}"
    if item["kind"] == "part":
        where += f" AND piece_id = {item['pieceId']}"
    new = q(item["new"]) if item.get("new") else "NULL"
    if item["decision"] == "fill":
        return f"UPDATE {table} SET {col} = {new} WHERE {where} AND ({col} IS NULL OR {col} = '');"
    return f"UPDATE {table} SET {col} = {new} WHERE {where} AND {col} = {q(item['old'])};"


def main() -> None:
    with open(sys.argv[1], encoding="utf-8") as handle:
        items = [json.loads(line) for line in handle if line.strip()]
    items = [i for i in items if i["decision"] != "not-found"]
    counts = Counter(f"{i['kind']} {i['service']} {i['decision']}" for i in items)
    out = [
        "-- 사운드트랙 장르 작품의 Apple Music·Spotify 링크(맨 위 작품 = 앨범, 안 곡·안 곡으로 이어진 작품 = 트랙).",
        "-- 6차 음반 묶음은 MusicBrainz url-rels·검색, 영화음악은 검색으로 앨범을 고르고 트랙 목록으로 확인했다.",
        "-- 자료·규칙: seed_pipeline/curation/soundtrack-links-2026-11-11/(README, pick.py, decisions.jsonl).",
        "-- 비어 있으면 채우고, 작곡가가 없는 앨범을 가리키던 링크는 지금 값이 본 값과 같을 때만 바꾸거나 지운다. 두 번 돌려도 같다.",
        "-- " + ", ".join(f"{k} {v}" for k, v in sorted(counts.items())),
        "",
    ]
    for item in items:
        if item["kind"] == "piece":
            out.append(
                f"-- {item['composer']} {item['pieceId']} {item['title']} ({item['service']} {item['decision']}: {item.get('album') or ''})"
            )
        out.append(statement(item))
    print("\n".join(out))


if __name__ == "__main__":
    main()
