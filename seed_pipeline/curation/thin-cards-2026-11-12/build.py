# ruff: noqa: E501 — 한국어 문장을 그대로 둔다.
"""작품 목록을 채운 S·A 작곡가 중 「처음 듣는다면」 카드가 5장이 안 되던 작곡가의 카드·링크 SQL 을 만든다.

- links: 카드 작품의 Apple Music·Spotify 앨범(트랙 목록으로 확인). 비어 있을 때만 채운다.
- cards: 새 줄은 source='editor'·PUBLISHED. 작품은 (composer_id, title) 로 찾는다(이미 있으면 넣지 않음).
  part_key 가 있으면 그 작품 안 곡을 카드의 대표 곡으로 단다.
- fixes(있으면): 근거 있는 사실 고침. 지금 값일 때만 바꾸는 가드.

사용: python3 build.py > ../../../migrations/<번호>_fill_thin_composer_cards.sql
"""

from __future__ import annotations

import json
import os
from typing import Any

HERE = os.path.dirname(os.path.abspath(__file__))


def q(value: str | int | None) -> str:
    if value is None:
        return "NULL"
    if isinstance(value, int):
        return str(value)
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def main() -> None:
    with open(os.path.join(HERE, "cards.json"), encoding="utf-8") as handle:
        data: dict[str, Any] = json.load(handle)
    out = [
        "-- 작품 목록을 채운 S·A 작곡가(2026-11-12) 중 「처음 듣는다면」 카드가 5장이 안 되던 작곡가의 카드와 그 작품 링크.",
        "-- 자료·근거: seed_pipeline/curation/thin-cards-2026-11-12/(cards.json, build.py, README). 두 번 돌려도 같다.",
        "",
        "-- 카드 작품 링크(트랙 목록으로 확인한 앨범). 비어 있을 때만.",
    ]
    for link in data.get("links", []):
        where = f"composer_id = {link['composer']} AND title = {q(link['title'])}"
        for column, key in (("apple_music_url", "apple"), ("spotify_url", "spotify")):
            if link.get(key):
                out.append(
                    f"UPDATE pieces SET {column} = {q(link[key])}\nWHERE {where} AND {column} IS NULL;"
                )
    out += ["", "-- 카드"]
    for card in data["cards"]:
        composer = int(card["composer"])
        part = (
            f"(SELECT part.id FROM piece_parts part WHERE part.piece_id = p.id AND part.part_key = {q(card['part_key'])})"
            if card.get("part_key")
            else "NULL"
        )
        out.append(
            "INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)\n"
            f"SELECT p.composer_id, p.id, {part}, {card['order']}, {q(card['ko'])}, {q(card['en'])}, 'editor', 'PUBLISHED'\n"
            f"FROM pieces p\nWHERE p.composer_id = {composer} AND p.title = {q(card['title'])} AND p.hidden_reason IS NULL\n"
            "AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);"
        )
    print("\n".join(out))


if __name__ == "__main__":
    main()
