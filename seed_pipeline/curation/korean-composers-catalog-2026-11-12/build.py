# ruff: noqa: E501 — 한국어 설명과 원어 제목을 그대로 둔다.
"""한국 작곡가(윤이상·홍난파·김동진) 작품 목록을 손으로 고른 작품으로 만든다.

리하르트 슈트라우스(../richard-strauss-catalog-2026-11-11/build.py)와 같은 방식이다. 다만 한국 작곡가는
MusicBrainz 자료가 적어서(윤이상 work 31개만 이음, 홍난파 「봉선화」 하나, 김동진 0) MBID 가 없는 작품도 넣는다.

작곡가 폴더(<slug>/)마다:
    works.tsv     작품(키·MBID 앞 8자·기존 piece id·제목·영어 제목·연도·장르·형식·곡 출처)
    parts.tsv     MusicBrainz 에 없는 곡(악장·노래) 목록. 곡 출처가 tsv 인 작품만
    sources.jsonl 작품마다 근거 URL·작사·연도 메모. works.tsv 의 모든 키가 있어야 한다

곡 출처: n = 곡 없음(낱곡), mb = MusicBrainz parts 관계 순서, tsv = parts.tsv.
기존 piece id 가 있는 줄은 이미 운영에 있는 작품이다. 4차 gen_catalog.py 는 손으로 넣은 기존 작품의 제목·설명·링크를
바꾸지 않고, 비어 있는 연도와 아직 없는 MBID·곡만 더한다. 장르·형식도 새 작품에만 채운다.

사용(seed_pipeline 에서):
    uv run python curation/korean-composers-catalog-2026-11-12/build.py isang-yun --out <폴더>
그다음 4차 gen_catalog.py 로 catalog.sql 을 만들고 genres.sql 을 이어 붙인다(README).
"""

from __future__ import annotations

import argparse
import csv
import importlib.util
import json
import os
import re
from dataclasses import dataclass
from typing import Any

HERE = os.path.dirname(os.path.abspath(__file__))
FETCH = os.path.join(os.path.dirname(HERE), "catalog-wave6-2026-11-10", "tools", "fetch.py")


@dataclass(frozen=True)
class Composer:
    composer_id: int
    mb_artist: str | None


COMPOSERS: dict[str, Composer] = {
    "isang-yun": Composer(90, "27389a4f-e0b4-4889-91d3-0924c69307f7"),
    "hong-nanpa": Composer(89, "2a4704a3-e3cf-47b5-ab40-a668431c5d17"),
    "kim-dongjin": Composer(103, None),
}

# 이번에 쓰는 형식과 그 장르(운영 piece_forms 와 같다). 틀린 짝은 SQL 을 만들기 전에 멈춘다.
FORM_GENRE: dict[str, str] = {
    "opera": "stage",
    "cantata": "vocal",
    "choral": "vocal",
    "sacred": "vocal",
    "song": "vocal",
    "vocal_other": "vocal",
    "orchestral_other": "orchestral",
    "overture": "orchestral",
    "symphonic_poem": "orchestral",
    "orch_suite": "orchestral",
    "symphony": "symphony",
    "violin_concerto": "concerto",
    "wind_concerto": "concerto",
    "other_concerto": "concerto",
    "concertante": "concerto",
    "string_quartet": "chamber",
    "string_ensemble": "chamber",
    "piano_chamber": "chamber",
    "wind_chamber": "chamber",
    "duo_sonata": "chamber",
    "chamber_other": "chamber",
    "solo": "chamber",
    "character": "piano",
    "piano_other": "piano",
    "organ": "piano",
}

# MusicBrainz 곡 이름을 바꿔 쓸 것. 원제가 한국어인 칸타타 악장은 우리말로 쓴다
# (국제윤이상협회 작품 목록: I. Roksa, II·III. Hyon-shil I·II, IV. Mi-rae).
PART_NAME: dict[str, str] = {
    "My Land, My People!: I. History": "역사",
    "My Land, My People!: II. Presence I": "현실 I",
    "My Land, My People!: III. Presence II": "현실 II",
    "My Land, My People!: IV. Future": "미래",
}


def load_fetch() -> Any:
    spec = importlib.util.spec_from_file_location("fetch", FETCH)
    assert spec and spec.loader
    module: Any = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def fetch_works(artist: str) -> dict[str, dict[str, Any]]:
    mb = load_fetch().mb
    works: dict[str, dict[str, Any]] = {}
    offset = 0
    while True:
        page = mb(
            "work",
            {
                "artist": artist,
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
    """「String Quartet no. 6: I. Pesante」→ (「Pesante」, 「I」), 「5 Piano Pieces: No. 1. Adagio」→ 「Adagio」."""
    tail = title.split(":", 1)[1].strip() if ":" in title else title
    movement = None
    match = re.match(r"^([IVXLC]+)\.\s+(.*)$", tail)
    if match:
        movement, tail = match.group(1), match.group(2)
    tail = re.sub(r"^(Nr\.|No\.)?\s*\d+\.\s+", "", tail).strip()
    return PART_NAME.get(title, tail), movement


def mb_parts(work: dict[str, Any]) -> list[dict[str, Any]]:
    rels = sorted(
        (
            r
            for r in work.get("relations", [])
            if r.get("target-type") == "work"
            and r["type"] == "parts"
            and r["direction"] == "forward"
        ),
        key=lambda r: (r.get("ordering-key") or 1000, r["work"]["title"]),
    )
    parts: list[dict[str, Any]] = []
    for rel in rels:
        name, movement = part_name(rel["work"]["title"])
        if not name:
            raise SystemExit(f"이름 없는 곡: {rel['work']['title']}")
        parts.append(part(len(parts) + 1, name, rel["work"]["title"], movement, rel["work"]["id"]))
    return parts


def part(
    seq: int, name_ko: str, name_en: str | None, movement: str | None, mbid: str | None
) -> dict[str, Any]:
    return {
        "seq": seq,
        "mbid": mbid,
        "mbTitle": name_en if mbid else None,
        "nameKo": name_ko,
        "nameEn": name_en or None,
        "movementNumber": movement or None,
        "catalogueAlt": None,
        "existingPieceId": None,
        "existingPartId": None,
        "children": [],
    }


def read_rows(path: str) -> list[list[str]]:
    if not os.path.exists(path):
        return []
    with open(path, encoding="utf-8") as handle:
        lines = [line for line in handle if not line.startswith("#") and line.strip()]
    return [row for row in csv.reader(lines, delimiter="\t", quoting=csv.QUOTE_NONE)]


def tsv_parts(folder: str) -> dict[str, list[dict[str, Any]]]:
    out: dict[str, list[dict[str, Any]]] = {}
    for key, seq, movement, name_ko, name_en in read_rows(os.path.join(folder, "parts.tsv")):
        rows = out.setdefault(key, [])
        if int(seq) != len(rows) + 1:
            raise SystemExit(f"parts.tsv 순서: {key} {seq}")
        rows.append(part(int(seq), name_ko, name_en, movement, None))
    return out


def check_sources(folder: str, keys: list[str]) -> None:
    seen: set[str] = set()
    with open(os.path.join(folder, "sources.jsonl"), encoding="utf-8") as handle:
        for line in handle:
            entry = json.loads(line)
            if not entry.get("sources"):
                raise SystemExit(f"근거 없는 작품: {entry['key']}")
            seen.add(entry["key"])
    missing = [key for key in keys if key not in seen]
    extra = sorted(seen - set(keys))
    if missing or extra:
        raise SystemExit(f"sources.jsonl 짝이 안 맞음: 없음 {missing}, 남음 {extra}")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("composer", choices=sorted(COMPOSERS))
    parser.add_argument("--out", required=True)
    args = parser.parse_args()
    slug: str = args.composer
    composer = COMPOSERS[slug]
    folder = os.path.join(HERE, slug)
    rows = read_rows(os.path.join(folder, "works.tsv"))
    works = fetch_works(composer.mb_artist) if composer.mb_artist else {}
    manual_parts = tsv_parts(folder)

    catalog: list[dict[str, Any]] = []
    genres: list[tuple[str, str, str]] = []
    keys: list[str] = []
    titles: set[str] = set()
    for row in rows:
        key, prefix, existing, title, title_en, year, genre, form, source = row
        if not re.fullmatch(r"[a-z0-9-]+", key) or key in keys:
            raise SystemExit(f"키가 ASCII 가 아니거나 겹침: {key}")
        if title in titles:
            raise SystemExit(f"제목 겹침: {title}")
        keys.append(key)
        titles.add(title)
        work = resolve(works, prefix) if prefix else None
        if source == "mb":
            if work is None:
                raise SystemExit(f"MBID 없이 mb 곡: {key}")
            parts = mb_parts(work)
        elif source == "tsv":
            parts = manual_parts.pop(key)
        elif source == "n":
            parts = []
        else:
            raise SystemExit(f"곡 출처는 n·mb·tsv: {key} {source}")
        if existing:
            if genre or form:
                raise SystemExit(f"기존 작품의 장르·형식은 건드리지 않음: {key}")
        elif FORM_GENRE.get(form) != genre:
            raise SystemExit(f"장르·형식 짝이 틀림: {key} {genre}/{form}")
        else:
            genres.append((title, genre, form))
        kind = (
            "single"
            if not parts
            else ("collection" if genre == "vocal" and form == "song" else "multi_movement")
        )
        catalog.append(
            {
                "key": f"{slug}-{key}",
                "kind": kind,
                "catalogue": None,
                "catalogueAlt": None,
                "titleKo": title,
                "titleEn": title_en or None,
                "year": int(year) if year else None,
                "yearText": None,
                "genre": None,
                "authenticity": "authentic",
                "mbid": work["id"] if work else None,
                "mbTitle": work["title"] if work else None,
                "existingPieceId": int(existing) if existing else None,
                "parts": parts,
            }
        )
    if manual_parts:
        raise SystemExit(f"works.tsv 에 없는 parts.tsv 작품: {sorted(manual_parts)}")
    check_sources(folder, keys)

    os.makedirs(args.out, exist_ok=True)
    with open(os.path.join(args.out, "catalog.json"), "w", encoding="utf-8") as handle:
        json.dump(catalog, handle, ensure_ascii=False, indent=1)
    with open(os.path.join(args.out, "seed_map.json"), "w", encoding="utf-8") as handle:
        json.dump([], handle)
    with open(os.path.join(args.out, "genres.sql"), "w", encoding="utf-8") as handle:
        handle.write(genre_sql(composer.composer_id, genres))
    new = sum(1 for work in catalog if not work["existingPieceId"])
    print(
        json.dumps(
            {
                "works": len(catalog),
                "new": new,
                "with_mbid": sum(1 for work in catalog if work["mbid"]),
                "parts": sum(len(work["parts"]) for work in catalog),
            }
        )
    )


def q(value: str) -> str:
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def genre_sql(composer_id: int, genres: list[tuple[str, str, str]]) -> str:
    """새로 넣은 작품의 장르·형식. 이미 값이 있으면(사람이 고쳤으면) 두지 않고 비어 있을 때만 채운다."""
    out = ["-- 장르·형식(works.tsv). 비어 있을 때만 채운다."]
    for title, genre, form in genres:
        out.append(
            f"UPDATE pieces SET genre = {q(genre)}, form_key = {q(form)}\n"
            f"WHERE composer_id = {composer_id} AND title = {q(title)} AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;"
        )
    return "\n".join(out) + "\n"


if __name__ == "__main__":
    main()
