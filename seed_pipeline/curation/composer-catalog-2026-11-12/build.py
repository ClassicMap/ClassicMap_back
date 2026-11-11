# ruff: noqa: E501, RUF001 — 한국어 설명과 원어 제목을 그대로 둔다.
"""손으로 고른 작품으로 작곡가 작품 목록(catalog.json)을 만든다. 클레멘티·슈타미츠·쇤베르크·리게티.

리하르트 슈트라우스 본보기(../richard-strauss-catalog-2026-11-11/build.py)를 여러 작곡가에 쓰게 고친 것이다.
작곡가마다 하위 폴더의 works.tsv 에 작품을 손으로 고르고(MusicBrainz work MBID 앞 8자·우리말 제목·작품번호·연도·
장르·형식·곡 붙이는 법·기존 작품 id), 곡은 MusicBrainz parts 관계 순서대로 붙인다. 세트 안 곡이 다시 악장으로
나뉘면(클레멘티 소나타 묶음, 「달에 홀린 피에로」 3부 7곡씩) 두 겹까지 붙이고 그 아래는 버린다.
출력은 4차 gen_catalog.py 가 읽는 catalog.json 꼴이다.

works.tsv 칸: MBID 앞 8자(없으면 -)·제목·작품번호·연도·genre·form_key·곡·기존 작품 id·영어 제목(MBID 없을 때)
  곡: n(곡 없음) | y(그 work 의 parts 전부) | y:4-6(그 work 의 parts 중 4~6번째) | <MBID 앞 8자>:1-6(다른 work 의 parts 중 1~6번째)
parts_ko.tsv 칸(없어도 됨): 곡 MBID 앞 8자·우리말 이름(비우면 자동)·이을 기존 작품 id(비우면 없음)

사용(seed_pipeline 에서):
    uv run python curation/composer-catalog-2026-11-12/build.py --composer clementi --out <폴더>
그다음 4차 gen_catalog.py 로 SQL 을 만들고 genres.sql(장르·형식)을 이어 붙인다.
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
_spec = importlib.util.spec_from_file_location("fetch", FETCH)
assert _spec and _spec.loader
_fetch: Any = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_fetch)
mb = _fetch.mb

Work = dict[str, Any]
Rel = dict[str, Any]


@dataclass(frozen=True)
class Composer:
    composer_id: int
    artist: str


COMPOSERS: dict[str, Composer] = {
    "clementi": Composer(25, "25f46ed2-ac8a-4428-ad09-5a3fa5162086"),
    "stamitz": Composer(24, "d82b930c-87d0-451f-b0b0-7e7fa5e2b243"),
    "schoenberg": Composer(82, "9b490b96-ad82-4d7b-9055-f0a196ad64cc"),
    "ligeti": Composer(499, "da5e774b-026a-4117-82a4-11d246c05a8b"),
}

# piece_forms 의 form_key → genre (운영 표 그대로). 짝이 안 맞으면 멈춘다.
FORM_GENRE: dict[str, str] = {
    **dict.fromkeys(
        [
            "string_quartet",
            "string_ensemble",
            "piano_chamber",
            "duo_sonata",
            "wind_chamber",
            "solo",
            "chamber_other",
        ],
        "chamber",
    ),
    **dict.fromkeys(
        [
            "piano_concerto",
            "violin_concerto",
            "cello_concerto",
            "wind_concerto",
            "other_concerto",
            "concerto_grosso",
            "concertante",
            "concerto_other",
        ],
        "concerto",
    ),
    **dict.fromkeys(
        [
            "overture",
            "symphonic_poem",
            "orch_suite",
            "serenade",
            "dance_march",
            "incidental",
            "orchestral_other",
        ],
        "orchestral",
    ),
    **dict.fromkeys(
        [
            "sonata",
            "etude",
            "prelude_fugue",
            "ballade",
            "scherzo",
            "nocturne",
            "impromptu",
            "fantasia",
            "character",
            "mazurka",
            "polonaise",
            "waltz",
            "dance",
            "variations",
            "rondo",
            "keyboard_suite",
            "four_hands",
            "organ",
            "piano_other",
        ],
        "piano",
    ),
    **dict.fromkeys(["opera", "operetta", "ballet", "stage_excerpt", "stage_other"], "stage"),
    **dict.fromkeys(["symphony", "sinfonia", "symphony_other"], "symphony"),
    **dict.fromkeys(
        [
            "song",
            "concert_aria",
            "mass_requiem",
            "oratorio_passion",
            "cantata",
            "sacred",
            "choral",
            "folk",
            "vocal_other",
        ],
        "vocal",
    ),
    "soundtrack": "screen",
}

# 세트 안 곡: 「Sonata in C major, op. 2 no. 2」 → 「피아노 소나타 2번 C장조」 (하이든 「현악 4중주 Op. 76」 의 곡 이름과 같은 꼴).
SET_ITEM = re.compile(
    r"^(?P<genre>Piano Sonata|Violin Sonata|Orchestral Trio|Sonatina|Sonata|Capriccio|Symphony)"
    r"(?: for Piano)? in (?P<note>[A-G])(?P<acc>-flat|-sharp)? (?P<mode>major|minor)"
    r"(?:,?\s*op\.\s*\w+\.?,?\s*no\.\s*(?P<no>\d+))?(?P<rest>.*)$",
    re.I,
)
SET_GENRE_KO = {
    "piano sonata": "피아노 소나타",
    "sonata": "피아노 소나타",
    "violin sonata": "바이올린 소나타",
    "orchestral trio": "관현악 3중주",
    "sonatina": "소나티네",
    "capriccio": "카프리치오",
    "symphony": "교향곡",
}

# 악장 이름 첫머리의 갈래어만 우리말로(운영 관례: 「피날레. Presto」·「미뉴에트와 트리오」·「전주곡」).
HEAD_KO: dict[str, str] = {
    "Menuetto and Trio": "미뉴에트와 트리오",
    "Menuetto e Trio": "미뉴에트와 트리오",
    "Menuet and Trio": "미뉴에트와 트리오",
    "Menuett. Trio": "미뉴에트와 트리오",
    "Menuetto - Trio": "미뉴에트와 트리오",
    "Minuetto - Trio": "미뉴에트와 트리오",
    "Menuetto – Trio": "미뉴에트와 트리오",
    "Thema mit Variationen": "주제와 변주",
    "Air with Variations": "주제와 변주",
    "Introduction": "서주",
    "Introduzione": "서주",
    "Prelude": "전주곡",
    "Präludium": "전주곡",
    "Praeludium": "전주곡",
    "Prélude": "전주곡",
    "Fugue": "푸가",
    "Fuge": "푸가",
    "Finale": "피날레",
    "Menuetto": "미뉴에트",
    "Minuetto": "미뉴에트",
    "Menuet": "미뉴에트",
    "Menuett": "미뉴에트",
    "Minuet": "미뉴에트",
    "Rondo": "론도",
    "Rondeau": "론도",
    "Rondeaux": "론도",
    "Scherzo": "스케르초",
    "Gigue": "지그",
    "Gavotte": "가보트",
    "Sarabande": "사라방드",
    "Musette": "뮈제트",
    "Ouverture": "서곡",
    "Overture": "서곡",
    "Overtüre": "서곡",
    "Marsch": "행진곡",
    "March": "행진곡",
    "Marche": "행진곡",
    "Theme": "주제",
    "Thema": "주제",
    "Tema": "주제",
    "Variation": "변주",
    "Variationen": "변주곡",
    "Variations": "변주곡",
    "Intermezzo": "인테르메초",
    "Passacaglia": "파사칼리아",
    "Toccata": "토카타",
    "Romanze": "로망스",
    "Romance": "로망스",
}
HEAD_SEPARATORS = (". ", ": ", ", ", " - ", " – ", " (")
ROMAN = re.compile(r"^(?P<num>[IVXL]+)(?:[.:]\s*|\s*$)(?P<rest>.*)$")
ROMAN_VALUES = {"I": 1, "V": 5, "X": 10, "L": 50}


def roman_value(text: str) -> int:
    total = 0
    for i, ch in enumerate(text):
        value = ROMAN_VALUES[ch]
        nxt = ROMAN_VALUES[text[i + 1]] if i + 1 < len(text) else 0
        total += -value if value < nxt else value
    return total


def key_ko(note: str, acc: str | None, mode: str) -> str:
    sign = {"-flat": "♭", "-sharp": "#"}.get((acc or "").lower(), "")
    return f"{note.upper()}{sign}{'장조' if mode.lower() == 'major' else '단조'}"


def translate_head(name: str) -> str:
    variation = re.match(r"^Variation (\d+)$", name)
    if variation:
        return f"변주 {variation.group(1)}"
    for word in sorted(HEAD_KO, key=len, reverse=True):
        if name == word:
            return HEAD_KO[word]
        for sep in HEAD_SEPARATORS:
            if name.startswith(word + sep):
                tail = name[len(word) + len(sep) :]
                joint = ". " if sep in (". ", ": ") else sep
                return HEAD_KO[word] + joint + tail
    return name


def tail_of(title: str, parent_title: str) -> str:
    """부모 work 이름을 뗀 곡 이름. 「Suite für Klavier, op. 25: II. Gavotte: Etwas …」→「II. Gavotte: Etwas …」."""
    if title.startswith(parent_title + ":"):
        return title[len(parent_title) + 1 :].strip()
    if ": " in title:
        return title.split(": ", 1)[1].strip()
    return title


def movement_name(title: str, parent_title: str) -> tuple[str, str, str | None]:
    """(우리말 이름, 영어 이름, 악장 번호). 이름은 번호·작품번호·따옴표를 뗀다."""
    tail = tail_of(title, parent_title)
    name_en = tail
    tail = re.sub(r",?\s*op\.\s*\d+\w*(?:,?\s*no\.\s*\d+)?$", "", tail, flags=re.I).strip()
    movement = None
    roman = ROMAN.match(tail)
    if roman:
        movement, tail = roman.group("num"), roman.group("rest").strip()
    tail = re.sub(r"^(?:(?:No|Nr)\.\s*)?\d+[a-z]?\.\s+", "", tail).strip()
    # 따옴표로 싼 이름: 「„Mondestrunken“」→「Mondestrunken」, 「“Litanei”. Langsam」→「Litanei. Langsam」
    tail = re.sub(r"^[„“\"]([^„“”\"]+)[“”\"]", r"\1", tail).rstrip(" –-").strip()
    return translate_head(tail), name_en, movement


def set_item_name(title: str) -> str | None:
    match = SET_ITEM.match(title)
    if not match or match.group("rest").strip():
        return None
    genre = SET_GENRE_KO[match.group("genre").lower()]
    key = key_ko(match.group("note"), match.group("acc"), match.group("mode"))
    number = match.group("no")
    return f"{genre} {number}번 {key}" if number else f"{genre} {key}"


def position(rel: Rel) -> int | None:
    if rel.get("ordering-key") is not None:
        return int(rel["ordering-key"])
    tail = tail_of(rel["work"]["title"], "")
    tail = tail.split(": ")[-1] if ": " in tail else tail
    numbered = re.match(r"^(?:(?:No|Nr)\.\s*)?(\d+)[a-z]?\.", tail)
    if numbered:
        return int(numbered.group(1))
    roman = ROMAN.match(tail)
    if roman:
        return roman_value(roman.group("num"))
    return None


def ordered_parts(work: Work) -> list[Rel]:
    """parts 관계를 순서대로. 같은 곡이 두 번 걸린 관계는 하나로, 순서를 알 수 없으면 멈춘다."""
    by_id: dict[str, Rel] = {}
    for rel in work.get("relations", []):
        if rel.get("target-type") != "work" or rel["type"] != "parts":
            continue
        if rel["direction"] != "forward":
            continue
        previous = by_id.get(rel["work"]["id"])
        if previous is None or (
            previous.get("ordering-key") is None and rel.get("ordering-key") is not None
        ):
            by_id[rel["work"]["id"]] = rel
    by_position: dict[int, Rel] = {}
    for rel in by_id.values():
        at = position(rel)
        if at is None:
            raise SystemExit(f"순서를 알 수 없는 곡: {work['title']} / {rel['work']['title']}")
        if at in by_position:
            raise SystemExit(f"같은 자리 곡 둘: {work['title']} / {rel['work']['title']}")
        by_position[at] = rel
    return [by_position[at] for at in sorted(by_position)]


def composed_by(work: Work, artist: str) -> bool:
    return any(
        rel.get("target-type") == "artist"
        and rel["type"] == "composer"
        and rel.get("artist", {}).get("id") == artist
        for rel in work.get("relations", [])
    )


@dataclass
class PartOverride:
    name_ko: str | None
    existing_piece_id: int | None


class Builder:
    def __init__(self, slug: str, works: dict[str, Work], overrides: dict[str, PartOverride]):
        self.slug = slug
        self.works = works
        self.overrides = overrides
        self.used_overrides: set[str] = set()
        self.warnings: list[str] = []

    def part(self, rel: Rel, seq: int, parent_title: str, depth: int) -> dict[str, Any]:
        title = str(rel["work"]["title"])
        mbid = str(rel["work"]["id"])
        child_work = self.works.get(mbid)
        children: list[dict[str, Any]] = []
        if depth == 0 and child_work is not None:
            children = [
                self.part(child, i + 1, title, depth + 1)
                for i, child in enumerate(ordered_parts(child_work))
            ]
        override = self.overrides.get(mbid[:8])
        set_name = set_item_name(title) if children or depth == 0 else None
        if set_name:
            name_ko, name_en, movement = set_name, title, None
        else:
            name_ko, name_en, movement = movement_name(title, parent_title)
        if override is not None:
            self.used_overrides.add(mbid[:8])
            if override.name_ko:
                name_ko = override.name_ko
        if not name_ko or re.fullmatch(r"[IVXL]+\.?", name_ko):
            raise SystemExit(f"이름 없는 곡(parts_ko.tsv 에 적을 것): {mbid[:8]} {title}")
        return {
            "seq": seq,
            "mbid": mbid,
            "mbTitle": title,
            "nameKo": name_ko,
            "nameEn": name_en,
            "movementNumber": movement,
            "catalogueAlt": None,
            "existingPieceId": override.existing_piece_id if override else None,
            "existingPartId": None,
            "children": children,
        }

    def parts(self, work: Work, spec: str) -> list[dict[str, Any]]:
        if spec == "n":
            return []
        source = work
        lo, hi = 1, 10_000
        if spec != "y":
            prefix, _, span = spec.partition(":")
            if prefix != "y":
                source = resolve(self.works, prefix)
            first, _, last = span.partition("-")
            lo, hi = int(first), int(last or first)
        rels = ordered_parts(source)
        picked = rels[lo - 1 : hi]
        if not picked:
            raise SystemExit(f"곡이 없음: {work['title']} {spec}")
        # 일부만 고르면(리게티 연습곡 2권 = 7~14번) 순번을 원래 번호로 둔다.
        parts = [self.part(rel, lo + i, str(source["title"]), 0) for i, rel in enumerate(picked)]
        names = [p["nameKo"] for p in parts]
        dupes = sorted({n for n in names if names.count(n) > 1})
        if dupes:
            self.warnings.append(f"같은 이름 곡: {work['title']} {dupes}")
        return parts


def fetch_works(artist: str) -> dict[str, Work]:
    works: dict[str, Work] = {}
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


def resolve(works: dict[str, Work], prefix: str) -> Work:
    hits = [w for wid, w in works.items() if wid.startswith(prefix)]
    if len(hits) != 1:
        raise SystemExit(f"MBID {prefix}: {len(hits)}개")
    return hits[0]


def read_rows(path: str) -> list[list[str]]:
    if not os.path.exists(path):
        return []
    with open(path, encoding="utf-8") as handle:
        lines = [line for line in handle if not line.startswith("#") and line.strip()]
    return [row + [""] * (9 - len(row)) for row in csv.reader(lines, delimiter="\t")]


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--composer", required=True, choices=sorted(COMPOSERS))
    parser.add_argument("--out", required=True)
    args = parser.parse_args()
    composer = COMPOSERS[args.composer]
    folder = os.path.join(HERE, args.composer)
    works = fetch_works(composer.artist)
    overrides = {
        row[0]: PartOverride(row[1] or None, int(row[2]) if row[2] else None)
        for row in read_rows(os.path.join(folder, "parts_ko.tsv"))
    }
    builder = Builder(args.composer, works, overrides)
    catalog: list[dict[str, Any]] = []
    genres: list[tuple[str, str, str]] = []
    titles: set[str] = set()
    for index, row in enumerate(read_rows(os.path.join(folder, "works.tsv"))):
        prefix, title, catalogue, year, genre, form, spec, existing, english = row
        if FORM_GENRE.get(form) != genre:
            raise SystemExit(f"genre·form_key 짝이 틀림: {title} {genre} {form}")
        if title in titles:
            raise SystemExit(f"제목 겹침: {title}")
        titles.add(title)
        work: Work | None = None if prefix == "-" else resolve(works, prefix)
        if work is not None and not composed_by(work, composer.artist):
            raise SystemExit(f"이 작곡가가 composer 가 아닌 work: {prefix} {work['title']}")
        parts = builder.parts(work or {"title": title}, spec)
        has_children = any(p["children"] for p in parts)
        kind = (
            "single"
            if not parts
            else ("collection" if has_children or genre == "vocal" else "multi_movement")
        )
        catalog.append(
            {
                "key": f"{args.composer}-{work['id'][:8] if work else f'noid-{index}'}",
                "kind": kind,
                "catalogue": catalogue or None,
                "catalogueAlt": None,
                "titleKo": title,
                "titleEn": work["title"] if work else english or None,
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
        if not existing:
            genres.append((title, genre, form))
    unused = sorted(set(overrides) - builder.used_overrides)
    if unused:
        raise SystemExit(f"parts_ko.tsv 에서 안 쓴 줄: {unused}")
    os.makedirs(args.out, exist_ok=True)
    with open(os.path.join(args.out, "catalog.json"), "w", encoding="utf-8") as handle:
        json.dump(catalog, handle, ensure_ascii=False, indent=1)
    with open(os.path.join(args.out, "seed_map.json"), "w", encoding="utf-8") as handle:
        json.dump([], handle)
    with open(os.path.join(args.out, "genres.sql"), "w", encoding="utf-8") as handle:
        handle.write(genre_sql(composer.composer_id, genres))
    for warning in builder.warnings:
        print("주의:", warning)
    count = sum(len(w["parts"]) + sum(len(p["children"]) for p in w["parts"]) for w in catalog)
    print(json.dumps({"works": len(catalog), "parts": count}))


def q(value: str) -> str:
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def genre_sql(composer_id: int, genres: list[tuple[str, str, str]]) -> str:
    """새로 넣은 작품의 장르·형식. 이미 값이 있으면(사람이 고쳤으면) 두지 않고 비어 있을 때만 채운다."""
    out = ["-- 장르·형식(works.tsv). 비어 있을 때만 채운다."]
    for title, genre, form in genres:
        out.append(
            f"UPDATE pieces SET genre = {q(genre)}, form_key = {q(form)}\n"
            f"WHERE composer_id = {composer_id} AND title = {q(title)} AND genre IS NULL AND form_key IS NULL;"
        )
    return "\n".join(out) + "\n"


if __name__ == "__main__":
    main()
