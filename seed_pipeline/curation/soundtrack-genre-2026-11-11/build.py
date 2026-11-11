# ruff: noqa: E501 — 한국어 설명을 그대로 둔다.
"""영화·드라마·게임 음악 작품에 장르 사운드트랙(screen)·형식 soundtrack 을 붙이는 SQL 을 만든다.

고르는 것(장르·형식이 모두 비어 있는 보이는 작품만. 사람이나 규칙이 장르를 정한 작품은 두지 않는다)
1. 제목(우리말·원어)에 「사운드트랙」「영화음악」「영화 음악」「Soundtrack」「Original Score」「OST」「Motion Picture」가 있는 작품
   (쇼스타코비치·프로코피예프·본 윌리엄스·글래스·나이먼 등의 영화음악 포함).
2. 6차 카탈로그가 만든 음반 묶음 가운데 MusicBrainz 음반 갈래에 Soundtrack 이 있는 것
   (../catalog-wave6-2026-11-10/<작곡가>/groups.json 의 types). 「Orphée」 같은 일반 음반은 두지 않는다.
3. 1·2 작품의 세트 안 곡(piece_parts.linked_piece_id)으로 들어간 작품.

입력: 운영 읽기 덤프(보이는 작품 genre.tsv: id·composer_id·title·title_en·genre·form_key, piece_parts.tsv)
사용: python3 build.py --genre <genre.tsv> --parts <piece_parts.tsv> > ../../../migrations/202611110902_fill_soundtrack_genre.sql
"""

from __future__ import annotations

import argparse
import csv
import glob
import json
import os
import re
from collections import Counter

HERE = os.path.dirname(os.path.abspath(__file__))
WAVE6 = os.path.join(os.path.dirname(HERE), "catalog-wave6-2026-11-10")
PATTERN = re.compile(
    r"사운드트랙|영화음악|영화 음악|soundtrack|original score|\bOST\b|motion picture", re.I
)
FILM_COMPOSERS = os.path.join(WAVE6, "film_composers.txt")

csv.field_size_limit(10_000_000)


def q(value: str) -> str:
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def soundtrack_bundles() -> dict[str, set[str]]:
    """작곡가 id → Soundtrack 갈래 음반 묶음 제목."""
    slug_to_id: dict[str, str] = {}
    with open(FILM_COMPOSERS, encoding="utf-8") as handle:
        for line in handle:
            parts = line.split()
            if len(parts) >= 2 and not parts[0].startswith("#"):
                slug_to_id[parts[1]] = parts[0]
    out: dict[str, set[str]] = {}
    for path in sorted(glob.glob(os.path.join(WAVE6, "*", "groups.json"))):
        slug = os.path.basename(os.path.dirname(path))
        if slug not in slug_to_id:
            continue
        with open(path, encoding="utf-8") as handle:
            groups = json.load(handle)
        items = groups if isinstance(groups, list) else list(groups.values())
        titles = {str(g["title"]) for g in items if "Soundtrack" in (g.get("types") or [])}
        out[slug_to_id[slug]] = titles
    return out


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--genre", required=True)
    parser.add_argument("--parts", required=True)
    args = parser.parse_args()
    with open(args.genre, encoding="utf-8") as handle:
        rows = {r["id"]: r for r in csv.DictReader(handle, delimiter="\t")}
    children: dict[str, list[str]] = {}
    linked: set[str] = set()
    with open(args.parts, encoding="utf-8") as handle:
        for part in csv.DictReader(handle, delimiter="\t"):
            if part["linked_piece_id"] != "NULL":
                children.setdefault(part["piece_id"], []).append(part["linked_piece_id"])
                linked.add(part["linked_piece_id"])
    bundles = soundtrack_bundles()

    def empty(row: dict[str, str]) -> bool:
        return row["genre"] == "NULL" and row["form_key"] == "NULL"

    picked: dict[str, str] = {}
    for row in rows.values():
        if row["id"] in linked or not empty(row):
            continue
        text = row["title"] + " " + (row["title_en"] if row["title_en"] != "NULL" else "")
        if PATTERN.search(text):
            picked[row["id"]] = "title"
        elif row["title"] in bundles.get(row["composer_id"], set()):
            picked[row["id"]] = "bundle"
    for parent in list(picked):
        for child in children.get(parent, []):
            child_row = rows.get(child)
            if child_row and empty(child_row) and child not in picked:
                picked[child] = "part"
    counts = Counter(picked.values())
    by_composer = Counter(rows[pid]["english_name"] for pid, why in picked.items() if why != "part")
    out = [
        "-- 영화·드라마·게임 음악 작품에 장르 사운드트랙(screen)·형식 soundtrack 을 붙인다.",
        f"-- 제목에 사운드트랙·영화음악 등 {counts['title']}, Soundtrack 갈래 음반 묶음 {counts['bundle']}, 그 세트 안 곡 {counts['part']}.",
        "-- 작곡가별(세트 안 곡 빼고): "
        + ", ".join(f"{name} {n}" for name, n in by_composer.most_common()),
        "-- 생성기: seed_pipeline/curation/soundtrack-genre-2026-11-11/build.py. 장르·형식이 비어 있을 때만 바꾼다.",
        "",
    ]
    for pid in sorted(picked, key=int):
        row = rows[pid]
        out.append(
            "UPDATE pieces SET genre = 'screen', form_key = 'soundtrack'\n"
            f"WHERE id = {pid} AND composer_id = {row['composer_id']} AND title = {q(row['title'])}\n"
            "  AND genre IS NULL AND form_key IS NULL;"
        )
    print("\n".join(out))


if __name__ == "__main__":
    main()
