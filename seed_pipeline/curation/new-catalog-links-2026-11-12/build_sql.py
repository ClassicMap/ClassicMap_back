# ruff: noqa: E501 — 한국어 설명을 그대로 둔다.
"""decisions.jsonl(+ korean-decisions.jsonl) → 마이그레이션 둘. 비어 있을 때만 채운다(바꾸거나 지우지 않는다).

사용: uv run python build_sql.py <decisions.jsonl>... --pieces <작품 SQL> --parts <안 곡 SQL>
"""

from __future__ import annotations

import argparse
import json
from collections import Counter
from typing import Any

COLUMN = {"apple": "apple_music_url", "spotify": "spotify_url"}
SOURCE = "seed_pipeline/curation/new-catalog-links-2026-11-12/"


def q(value: str) -> str:
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def piece_sql(item: dict[str, Any]) -> str:
    col = COLUMN[item["service"]]
    return (
        f"UPDATE pieces SET {col} = {q(item['new'])} WHERE id = {item['pieceId']}"
        f" AND composer_id = {item['composerId']} AND ({col} IS NULL OR {col} = '');"
    )


def part_sql(item: dict[str, Any]) -> str:
    col = COLUMN[item["service"]]
    return (
        f"UPDATE piece_parts SET {col} = {q(item['new'])} WHERE id = {item['partId']}"
        f" AND piece_id = {item['pieceId']} AND ({col} IS NULL OR {col} = '');"
    )


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("decisions", nargs="+")
    parser.add_argument("--pieces", required=True)
    parser.add_argument("--parts", required=True)
    args = parser.parse_args()
    items: list[dict[str, Any]] = []
    for path in args.decisions:
        with open(path, encoding="utf-8") as handle:
            items += [json.loads(line) for line in handle if line.strip()]
    fills = [i for i in items if i["decision"] == "fill" and i.get("new")]
    pieces = [i for i in fills if i["kind"] == "piece"]
    parts = [i for i in fills if i["kind"] == "part"]
    assert len({(i["pieceId"], i["service"]) for i in pieces}) == len(pieces), (
        "작품·서비스가 겹친다"
    )
    assert len({(i["partId"], i["service"]) for i in parts}) == len(parts), "곡·서비스가 겹친다"

    links = Counter(f"{i['service']} {i.get('link', '')}" for i in pieces)
    out = [
        "-- 새로 넣은 작품(슈트라우스·클레멘티·슈타미츠·쇤베르크·리게티·텔레만·퍼셀·스카를라티·몬테베르디·윤이상·홍난파·김동진)의",
        "-- 빈 Apple Music·Spotify 링크를 채운다. 안 곡이 있는 작품은 그 작품이 다 든 앨범, 안 곡이 없는 작품은",
        "-- 작품 트랙이 하나면 그 트랙·여러 트랙(오페라 전곡 등)이면 앨범. 한국 가곡은 원곡 녹음만 눈으로 골랐다.",
        f"-- 자료·규칙: {SOURCE}(README, pick.py, korean.py, decisions.jsonl).",
        "-- 비어 있을 때만 채우고 있는 링크는 건드리지 않는다. 두 번 돌려도 같다.",
        "-- " + ", ".join(f"{k.strip()} {v}" for k, v in sorted(links.items())),
        "",
    ]
    for item in sorted(pieces, key=lambda i: (i["composerId"], i["pieceId"], i["service"])):
        out.append(
            f"-- {item['pieceId']} {item['title']} ({item['service']}: {item.get('albumName') or ''})"
        )
        out.append(piece_sql(item))
    with open(args.pieces, "w", encoding="utf-8") as handle:
        handle.write("\n".join(out) + "\n")

    by_service = Counter(i["service"] for i in parts)
    out = [
        "-- 새로 넣은 작품(12명)의 안 곡(곡 안 곡 포함)에 Apple Music·Spotify 트랙 링크를 채운다.",
        "-- 작품 링크로 고른 앨범(또는 이미 있던 앨범 링크)의 전체 트랙에서 곡 이름·번호·작품번호가 맞는 트랙만 붙였다",
        "-- (../part-apple-links-2026-11-08/match.py 의 match_set·match_children).",
        f"-- 자료: {SOURCE}(decisions.jsonl). 비어 있을 때만 채운다. 두 번 돌려도 같다.",
        "-- " + ", ".join(f"{k} {v}" for k, v in sorted(by_service.items())),
        "",
    ]
    out += [
        part_sql(i) for i in sorted(parts, key=lambda i: (i["pieceId"], i["partId"], i["service"]))
    ]
    with open(args.parts, "w", encoding="utf-8") as handle:
        handle.write("\n".join(out) + "\n")
    print(json.dumps({"pieces": dict(links), "parts": dict(by_service)}, ensure_ascii=False))


if __name__ == "__main__":
    main()
