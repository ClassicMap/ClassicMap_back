# ruff: noqa: E501 — 한국어 문장을 그대로 둔다.
"""카드가 2장 이하였던 작곡가(백남준·R. 슈트라우스·J.C. 바흐)의 「처음 듣는다면」 카드와, 그 카드에 필요한 작품 고침을 SQL 로 만든다.

- 백남준 385·387: 제목·연도·설명이 실제 작품과 달라(근거 README) 실제 작품으로 고친다. 지금 제목일 때만 바꾼다.
- 슈트라우스 카드 작품(202611110701 로 넣는 작품)에 Apple Music 앨범 링크를 넣는다. 비어 있을 때만.
- 카드: 기존 자동 줄(source='auto')은 이유·순서·상태만 바꾸고, 새 줄은 source='editor' 로 넣는다(이미 있으면 넣지 않음).
  새 작품은 (composer_id, title) 로 찾는다(운영·개발의 id 가 다를 수 있다).

사용: python3 build.py > ../../../migrations/202611110702_fill_thin_composer_highlights.sql
"""

from __future__ import annotations

import json
import os
from typing import Any

HERE = os.path.dirname(os.path.abspath(__file__))

PAIK_FIXES: list[dict[str, Any]] = [
    {
        "id": 385,
        "old_title": "존 케이지를 위한 교향곡",
        "title": "존 케이지에게 바치는 경의",
        "title_en": "Hommage à John Cage: Music for Tapes and Piano",
        "year": 1959,
        "description": "1959년 11월 뒤셀도르프 갤러리 22에서 선보인 백남준의 데뷔 공연. 녹음테이프 콜라주와 피아노 연주에 피아노를 넘어뜨리는 행위를 더했다.",
        "description_en": "Paik's debut performance, given at Galerie 22 in Düsseldorf in November 1959. It combines a tape collage and piano playing with the act of toppling a piano.",
        "spotify_url": None,
    },
    {
        "id": 387,
        "old_title": "조작된 피아노를 위한 연습곡",
        "title": "피아노포르테를 위한 연습곡",
        "title_en": "Étude for Pianoforte",
        "year": 1960,
        "description": "1960년 10월 쾰른 마리 바우어마이스터의 작업실에서 선보인 행위 음악. 피아노를 치던 백남준이 객석의 존 케이지와 데이비드 튜더에게 다가가 옷을 자르고 머리에 샴푸를 부었다.",
        "description_en": "Action music first performed in October 1960 at Mary Bauermeister's studio in Cologne. Paik left the piano, cut the clothes of John Cage and David Tudor in the audience and poured shampoo over their heads.",
        # 음반 「Works 1958-1979」(Sub Rosa)에 「Hommage à John Cage」와 「Etude for Pianoforte」가 함께 실려 있다(385 와 같은 앨범).
        "spotify_url": "https://open.spotify.com/album/28DeGPXSSRdjhx9hba3aKm",
    },
]

STRAUSS_LINKS: dict[str, str] = {
    "연가곡집 <네 개의 마지막 노래>": "https://music.apple.com/us/album/strauss-four-last-songs/1452223225",
    "교향시 <돈 후안>": "https://music.apple.com/us/album/richard-strauss-tone-poems/1452343256",
    "교향시 <틸 오일렌슈피겔의 유쾌한 장난>": "https://music.apple.com/us/album/richard-strauss-tone-poems/1452343256",
    "오페라 <장미의 기사>": "https://music.apple.com/us/album/richard-strauss-der-rosenkavalier/1293724292",
    "오페라 <살로메>": "https://music.apple.com/us/album/strauss-salome/1452375364",
}


def q(value: str | int | None) -> str:
    if value is None:
        return "NULL"
    if isinstance(value, int):
        return str(value)
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def main() -> None:
    with open(os.path.join(HERE, "cards.json"), encoding="utf-8") as handle:
        cards: list[dict[str, Any]] = json.load(handle)["cards"]
    out = [
        "-- 「처음 듣는다면」 카드가 2장 이하였던 작곡가를 채운다(백남준 1→3, R. 슈트라우스 1→6, J.C. 바흐 2→5).",
        "-- 안익태(2장)는 근거와 음원이 있는 작품이 더 없어 그대로 둔다.",
        "-- 자료: seed_pipeline/curation/thin-composer-highlights-2026-11-11/(cards.json, build.py, README 의 근거).",
        "-- 슈트라우스 작품은 202611110701 이 넣는다. 두 번 돌려도 같다.",
        "",
        "-- 백남준: 실제 작품으로 고친다(지금 제목일 때만).",
    ]
    for fix in PAIK_FIXES:
        spotify = (
            f",\n    spotify_url = COALESCE(spotify_url, {q(fix['spotify_url'])})"
            if fix["spotify_url"]
            else ""
        )
        out.append(
            f"UPDATE pieces SET title = {q(fix['title'])}, title_en = {q(fix['title_en'])},\n"
            f"    composition_year = {q(fix['year'])},\n"
            f"    description = {q(fix['description'])},\n"
            f"    description_en = {q(fix['description_en'])}{spotify}\n"
            f"WHERE id = {fix['id']} AND composer_id = 102 AND title = {q(fix['old_title'])};"
        )
    out += [
        "",
        "-- 슈트라우스 카드 작품 Apple Music 앨범(트랙 목록에 작품 전곡이 있는 음반). 비어 있을 때만.",
    ]
    for title, url in STRAUSS_LINKS.items():
        out.append(
            f"UPDATE pieces SET apple_music_url = {q(url)}\n"
            f"WHERE composer_id = 498 AND title = {q(title)} AND apple_music_url IS NULL;"
        )
    out += ["", "-- 카드"]
    for card in cards:
        composer = int(card["composer"])
        if card.get("status_from"):
            out.append(
                f"UPDATE composer_highlights SET reason = {q(card['ko'])}, reason_en = {q(card['en'])},\n"
                f"    sort_order = {card['order']}, status = 'PUBLISHED'\n"
                f"WHERE composer_id = {composer} AND piece_id = {card['piece']} AND source = 'auto';"
            )
            continue
        where = (
            f"p.id = {card['piece']} AND p.composer_id = {composer}"
            if card.get("piece")
            else f"p.composer_id = {composer} AND p.title = {q(card['title'])}"
        )
        out.append(
            "INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)\n"
            f"SELECT p.composer_id, p.id, NULL, {card['order']}, {q(card['ko'])}, {q(card['en'])}, 'editor', 'PUBLISHED'\n"
            f"FROM pieces p\nWHERE {where} AND p.hidden_reason IS NULL\n"
            "AND NOT EXISTS (SELECT 1 FROM composer_highlights h WHERE h.composer_id = p.composer_id AND h.piece_id = p.id);"
        )
    print("\n".join(out))


if __name__ == "__main__":
    main()
