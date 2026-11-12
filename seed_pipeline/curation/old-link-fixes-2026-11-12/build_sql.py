# ruff: noqa: E501 — 한국어 설명을 그대로 둔다.
"""decisions.jsonl → 마이그레이션 둘(작품 링크, 안 곡 링크).

- fill: 비어 있을 때만 채운다.
- replace: 지금 값이 decisions 의 old 와 같을 때만 바꾼다(그사이 사람이 고쳤으면 그대로 둔다).

사용: uv run python build_sql.py decisions.jsonl --pieces <작품 SQL> --parts <안 곡 SQL>
"""

from __future__ import annotations

import argparse
import json
from collections import Counter
from typing import Any

COLUMN = {"apple": "apple_music_url", "spotify": "spotify_url"}
SOURCE = "seed_pipeline/curation/old-link-fixes-2026-11-12/"


def q(value: str) -> str:
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def guard(item: dict[str, Any], col: str) -> str:
    if item["decision"] == "fill":
        return f"({col} IS NULL OR {col} = '')"
    return f"{col} = {q(item['old'])}"


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("decisions")
    parser.add_argument("--pieces", required=True)
    parser.add_argument("--parts", required=True)
    args = parser.parse_args()
    with open(args.decisions, encoding="utf-8") as handle:
        items: list[dict[str, Any]] = [json.loads(line) for line in handle if line.strip()]
    pieces = [i for i in items if i["kind"] == "piece"]
    parts = [i for i in items if i["kind"] == "part"]
    assert len({(i["pieceId"], i["service"]) for i in pieces}) == len(pieces)
    assert len({(i["partId"], i["service"]) for i in parts}) == len(parts)

    counts = Counter(f"{i['service']} {i['decision']}" for i in pieces)
    out = [
        "-- 틀린 옛 작품 링크를 바꾸고(편곡·다른 작품·발췌 음반), 빈 타펠무지크 Apple 작품 링크를 채운다.",
        "-- 타펠무지크(52) Spotify, 클레멘티 Op. 24(33936) Apple, 압델라자르(38) 두 서비스, 디도의 탄식(35) 두 서비스,",
        "-- 스카를라티 K. 27(41) Apple. 바꾸는 것은 지금 값이 그때 본 값과 같을 때만, 채우는 것은 비어 있을 때만.",
        f"-- 자료·까닭: {SOURCE}(README, fixes.tsv, decisions.jsonl). 두 번 돌려도 같다.",
        "-- " + ", ".join(f"{k} {v}" for k, v in sorted(counts.items())),
        "",
    ]
    for item in sorted(pieces, key=lambda i: (i["pieceId"], i["service"])):
        col = COLUMN[item["service"]]
        out.append(
            f"-- {item['pieceId']} {item['title']} ({item['service']} {item['decision']}: {item['albumName']})"
        )
        out.append(
            f"UPDATE pieces SET {col} = {q(item['new'])} WHERE id = {item['pieceId']} AND composer_id = {item['composerId']} AND {guard(item, col)};"
        )
    with open(args.pieces, "w", encoding="utf-8") as handle:
        handle.write("\n".join(out) + "\n")

    counts = Counter(f"{i['service']} {i['decision']}" for i in parts)
    out = [
        "-- 작품 링크는 있는데 안 곡 링크가 빈 작품(12명 중 0501 전부터 두 링크가 있던 것과 위에서 고친 작품)의 안 곡 링크.",
        "-- 작품 앨범이 그 작품을 다 담았는지 먼저 보고(트랙 수·작품번호·맨 위 곡 8할), 담은 앨범에서만 곡 이름·번호가 맞는 트랙을 붙였다.",
        "-- 작품 링크를 바꾼 서비스에서 옛 앨범 트랙을 가리키던 곡은 새 앨범 트랙으로 바꾼다(지금 값이 옛 값과 같을 때만).",
        f"-- 자료: {SOURCE}(fix.py, decisions.jsonl). 두 번 돌려도 같다.",
        "-- " + ", ".join(f"{k} {v}" for k, v in sorted(counts.items())),
        "",
    ]
    for item in sorted(parts, key=lambda i: (i["pieceId"], i["partId"], i["service"])):
        col = COLUMN[item["service"]]
        out.append(
            f"UPDATE piece_parts SET {col} = {q(item['new'])} WHERE id = {item['partId']} AND piece_id = {item['pieceId']} AND {guard(item, col)};"
        )
    with open(args.parts, "w", encoding="utf-8") as handle:
        handle.write("\n".join(out) + "\n")
    print(
        json.dumps(
            {
                "pieces": dict(Counter(f"{i['service']} {i['decision']}" for i in pieces)),
                "parts": dict(counts),
            },
            ensure_ascii=False,
        )
    )


if __name__ == "__main__":
    main()
