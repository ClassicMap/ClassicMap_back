# ruff: noqa: E501 — 한국어 설명과 원어 제목을 그대로 둔다.
"""리하르트 슈트라우스(composer_id 498) 작품 목록을 손으로 고른 작품으로 만든다.

4차 자동 규칙(auto_catalog.py)은 MusicBrainz 의 「based on」·「other version」·「revision of」 관계가 있는
작품을 편곡·다른 판으로 보고 빼서, 슈트라우스는 「살로메」·「낙소스섬의 아리아드네」·「군트람」 같은 오페라와
「첼로 소나타」가 빠지고 「Also Rock Zarathustra (CD-ROM)」 같은 잡음이 들어갔다. 그래서 works.tsv 에
작품을 손으로 고르고(MusicBrainz work MBID 앞 8자·우리말 제목·작품번호·연도·장르·형식), 세트·다악장 작품의 곡은
MusicBrainz parts 관계 순서대로 붙인다. 출력은 4차 gen_catalog.py 가 읽는 catalog.json 꼴이다.

사용(seed_pipeline 에서):
    uv run python curation/richard-strauss-catalog-2026-11-11/build.py --db <운영 읽기 덤프> --out <폴더>
그다음 4차 gen_catalog.py 로 SQL 을 만들고, genre_sql() 결과(장르·형식)를 이어 붙인다.
"""

from __future__ import annotations

import argparse
import csv
import importlib.util
import json
import os
import re
from typing import Any

HERE = os.path.dirname(os.path.abspath(__file__))
FETCH = os.path.join(os.path.dirname(HERE), "catalog-wave6-2026-11-10", "tools", "fetch.py")
_spec = importlib.util.spec_from_file_location("fetch", FETCH)
assert _spec and _spec.loader
_fetch: Any = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_fetch)
mb = _fetch.mb

ARTIST = "4cb43d82-824e-4034-b03d-1a98f36f6e16"
COMPOSER_ID = 498
SLUG = "richard-strauss"
ZARATHUSTRA_MBID = "fec1c6a5-ece2-393b-89ed-00cdf5cf2afa"
ZARATHUSTRA_PIECE = 26025

# 널리 쓰는 우리말 이름이 있는 곡만 「우리말 (원제)」로 쓴다. 나머지는 원제.
PART_KO: dict[str, str] = {
    "Zueignung": "헌정",
    "Die Nacht": "밤",
    "Allerseelen": "만령절",
    "Ständchen": "세레나데",
    "Ruhe, meine Seele!": "쉬어라, 내 영혼아",
    "Ruhe, meine Seele": "쉬어라, 내 영혼아",
    "Cäcilie": "체칠리에",
    "Heimliche Aufforderung": "은밀한 초대",
    "Morgen!": "내일!",
    "Wiegenlied": "자장가",
    "Frühling": "봄",
    "September": "9월",
    "Beim Schlafengehen": "잠자리에 들 때",
    "Im Abendrot": "저녁노을에",
}


def fetch_works() -> dict[str, dict[str, Any]]:
    works: dict[str, dict[str, Any]] = {}
    offset = 0
    while True:
        page = mb(
            "work",
            {
                "artist": ARTIST,
                "limit": 100,
                "offset": offset,
                "inc": "aliases+work-rels+artist-rels",
            },
        )
        for work in page["works"]:
            works[work["id"]] = work
        offset += 100
        if offset >= page["work-count"]:
            return works


def resolve(works: dict[str, dict[str, Any]], prefix: str) -> dict[str, Any]:
    hits = [w for wid, w in works.items() if wid.startswith(prefix)]
    if len(hits) != 1:
        raise SystemExit(f"MBID {prefix}: {len(hits)}개")
    return hits[0]


def part_name(title: str) -> tuple[str, str | None]:
    """「Morgen!, op. 27 no. 4」→ 「내일! (Morgen!)」, 「Heldenleben: II. Des Helden Widersacher」→ 원제 꼬리."""
    tail = title.split(":", 1)[1].strip() if ":" in title else title
    # 「Three songs after … Hamlet: I. Wie erkenn' ich …」처럼 묶음 이름이 한 겹 더 붙은 곡
    inner = re.search(r":\s+([IVX]+\.\s+.*|\".*\")$", tail)
    if inner:
        tail = inner.group(1)
    tail = re.sub(r",?\s*(op\.?|TrV|AV)\s*\d+.*$", "", tail, flags=re.I).strip()
    movement = None
    match = re.match(r"^([IVXLC]+)\.\s+(.*)$", tail)
    if match:
        movement, tail = match.group(1), match.group(2)
    tail = re.sub(r"^(Nr\.|No\.)?\s*\d+\.\s+", "", tail).strip('„“”" ')
    base = re.sub(r"\s*\(.*\)$", "", tail).strip()
    ko = PART_KO.get(base)
    return (f"{ko} ({tail})" if ko else tail), movement


def position_in_title(title: str) -> int | None:
    tail = title.split(":", 1)[1].strip() if ":" in title else ""
    match = re.match(r"^(\d+)\.", tail)
    if match:
        return int(match.group(1))
    match = re.match(r"^([IVX]+)\.", tail)
    if match:
        values = {"I": 1, "V": 5, "X": 10}
        total = 0
        for i, ch in enumerate(match.group(1)):
            value = values[ch]
            nxt = values[match.group(1)[i + 1]] if i + 1 < len(match.group(1)) else 0
            total += -value if value < nxt else value
        return total
    return None


def parts_of(work: dict[str, Any]) -> list[dict[str, Any]]:
    rels = [
        r
        for r in work.get("relations", [])
        if r.get("target-type") == "work" and r["type"] == "parts" and r["direction"] == "forward"
    ]
    # MusicBrainz 에 같은 악장이 두 벌 걸린 작품이 있다(관악 소나티네: 번호 없는 영어판 + 번호 있는 독일어판).
    # 자리(ordering-key 또는 제목의 「1.」·「I.」)마다 이름이 가장 긴 것 하나만 쓴다.
    by_position: dict[int, dict[str, Any]] = {}
    for order, rel in enumerate(sorted(rels, key=lambda r: r["work"]["title"])):
        position = (
            rel.get("ordering-key") or position_in_title(rel["work"]["title"]) or 1000 + order
        )
        best = by_position.get(position)
        if best is None or len(rel["work"]["title"]) > len(best["work"]["title"]):
            by_position[position] = rel
    parts: list[dict[str, Any]] = []
    for position in sorted(by_position):
        rel = by_position[position]
        name, movement = part_name(rel["work"]["title"])
        seq = len(parts) + 1
        parts.append(
            {
                "seq": seq,
                "mbid": rel["work"]["id"],
                "mbTitle": rel["work"]["title"],
                "nameKo": name,
                "nameEn": rel["work"]["title"],
                "movementNumber": movement,
                "catalogueAlt": None,
                "existingPieceId": None,
                "existingPartId": None,
                "children": [],
            }
        )
    return parts


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--out", required=True)
    args = parser.parse_args()
    works = fetch_works()
    catalog: list[dict[str, Any]] = []
    genres: list[tuple[str, str, str]] = []
    with open(os.path.join(HERE, "works.tsv"), encoding="utf-8") as handle:
        rows = [line for line in handle if not line.startswith("#") and line.strip()]
    for row in csv.reader(rows, delimiter="\t"):
        prefix, title, catalogue, year, genre, form, use_parts = row
        work = resolve(works, prefix)
        parts = parts_of(work) if use_parts == "y" else []
        kind = "single" if not parts else ("collection" if genre == "vocal" else "multi_movement")
        catalog.append(
            {
                "key": f"{SLUG}-{work['id'][:8]}",
                "kind": kind,
                "catalogue": catalogue or None,
                "catalogueAlt": None,
                "titleKo": title,
                "titleEn": work["title"],
                "year": int(year) if year else None,
                "yearText": None,
                "genre": None,
                "authenticity": "authentic",
                "mbid": work["id"],
                "mbTitle": work["title"],
                "existingPieceId": None,
                "parts": parts,
            }
        )
        genres.append((title, genre, form))
    # 이미 운영에 있는 「차라투스트라」(비교 구간 있음)는 제목·설명을 두고 MBID 와 단락만 잇는다.
    zarathustra = works[ZARATHUSTRA_MBID]
    catalog.insert(
        0,
        {
            "key": f"{SLUG}-fec1c6a5",
            "kind": "multi_movement",
            "catalogue": "Op. 30",
            "catalogueAlt": None,
            "titleKo": "교향시 <차라투스트라는 이렇게 말했다>",
            "titleEn": zarathustra["title"],
            "year": 1896,
            "yearText": None,
            "genre": None,
            "authenticity": "authentic",
            "mbid": ZARATHUSTRA_MBID,
            "mbTitle": zarathustra["title"],
            "existingPieceId": ZARATHUSTRA_PIECE,
            "parts": parts_of(zarathustra),
        },
    )
    os.makedirs(args.out, exist_ok=True)
    with open(os.path.join(args.out, "catalog.json"), "w", encoding="utf-8") as handle:
        json.dump(catalog, handle, ensure_ascii=False, indent=1)
    with open(os.path.join(args.out, "seed_map.json"), "w", encoding="utf-8") as handle:
        json.dump([], handle)
    with open(os.path.join(args.out, "genres.sql"), "w", encoding="utf-8") as handle:
        handle.write(genre_sql(genres))
    print(json.dumps({"works": len(catalog), "parts": sum(len(w["parts"]) for w in catalog)}))


def q(value: str) -> str:
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def genre_sql(genres: list[tuple[str, str, str]]) -> str:
    """새로 넣은 작품의 장르·형식. 이미 값이 있으면(사람이 고쳤으면) 두지 않고 비어 있을 때만 채운다."""
    out = ["-- 장르·형식(works.tsv). 비어 있을 때만 채운다."]
    for title, genre, form in genres:
        out.append(
            f"UPDATE pieces SET genre = {q(genre)}, form_key = {q(form)}\n"
            f"WHERE composer_id = {COMPOSER_ID} AND title = {q(title)} AND genre IS NULL AND form_key IS NULL;"
        )
    return "\n".join(out) + "\n"


if __name__ == "__main__":
    main()
