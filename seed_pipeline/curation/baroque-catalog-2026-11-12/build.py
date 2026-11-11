# ruff: noqa: E501 — 한국어 설명과 원어 제목을 그대로 둔다.
"""바로크 작곡가(텔레만·퍼셀·스카를라티·몬테베르디) 작품 목록을 손으로 고른 작품으로 만든다.

리하르트 슈트라우스 때(../richard-strauss-catalog-2026-11-11/build.py)와 같은 방식이다. 4차 자동 규칙은
MusicBrainz 관계 때문에 주요 작품을 빼고 잡음을 넣어서, 작품은 <작곡가>/works.tsv 에 손으로 고르고
곡은 MusicBrainz parts 관계나 <작곡가>/parts.tsv(손으로 순서·이름을 정한 곡 목록)에서 가져온다.
출력은 4차 gen_catalog.py 가 읽는 catalog.json 꼴이고, --migration 을 주면 gen_catalog 까지 돌려
마이그레이션(머리 설명 + catalog.sql + 장르·형식)을 쓴다.

슈트라우스 build.py 와 다른 점:
- works.tsv 에 kind(single·multi·coll)·existing(운영 작품 id)·parts(-·mb·file) 칸이 있다.
- 묶음 안 곡이 다시 악장으로 나뉘면 두 겹(children)까지 붙인다.
- 카탈로그 번호에 쌍점이 있는 체계(TWV 43:G1, SV 154:3)를 위해 「: 」(쌍점+빈칸)으로만 자른다.
- 운영 작품 대부분이 MBID 가 없어 gen_catalog 의 MBID·제목 검사로는 중복을 못 막는다. 그래서 existing 이
  비어 있는 줄의 작품번호가 같은 작곡가 운영 작품의 작품번호와 같으면 멈춘다.

사용(seed_pipeline 에서):
    uv run python curation/baroque-catalog-2026-11-12/build.py --composer telemann \
        --db <운영 읽기 덤프 폴더> --out <작업 폴더> [--migration ../migrations/<파일>.sql]
"""

from __future__ import annotations

import argparse
import csv
import importlib.util
import json
import os
import re
import subprocess
import sys
from dataclasses import dataclass, field
from typing import Any

HERE = os.path.dirname(os.path.abspath(__file__))
CURATION = os.path.dirname(HERE)
FETCH = os.path.join(CURATION, "catalog-wave6-2026-11-10", "tools", "fetch.py")
GEN = os.path.join(CURATION, "catalog-wave4-2026-10-12", "gen_catalog.py")
_spec = importlib.util.spec_from_file_location("fetch", FETCH)
assert _spec and _spec.loader
_fetch: Any = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_fetch)
mb = _fetch.mb

# slug → (composer_id, MusicBrainz artist MBID)
COMPOSERS: dict[str, tuple[int, str]] = {
    "telemann": (11, "8f831f50-e409-47c3-8598-71a61bc8cfb3"),
    "purcell": (8, "ddea5540-2c7d-4266-8507-b367c2635d35"),
    "scarlatti": (9, "95c7a1d1-5cfd-41d5-99f9-0611262de8e1"),
    "monteverdi": (5, "9a33a7ad-f725-473a-b50a-1d1796183af1"),
}

# piece_forms(form_key → genre). 운영 표를 그대로 옮겼다(2026-11-12).
FORMS: dict[str, str] = {
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
    "soundtrack": "screen",
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
}

# MB 악장 이름 중 이름이 아닌 것
PART_NAME_FIX = {"No Tempo Indication": "(빠르기 표시 없음)"}
KINDS = {"single": "single", "multi": "multi_movement", "coll": "collection"}
ROMAN = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII", "XIII", "XIV"]
ROMAN += ["XV", "XVI", "XVII", "XVIII", "XIX", "XX", "XXI", "XXII", "XXIII", "XXIV", "XXV"]
ROMAN_VALUE = {"I": 1, "V": 5, "X": 10, "L": 50, "C": 100}
CATALOGUE = re.compile(
    r"\b(SV|ZT|ZD|Z|TWV|Kk|K|L|BWV|HWV|RV)\.?\s*(\d+[a-z]?(?::[A-Za-z]{0,3}\d+[a-z]?)?)"
)
CATALOGUE_TAIL = re.compile(
    r"[,;]?\s*\(?\b(?:SV|ZT|ZD|Z|TWV|Kk|K|L|BWV|HWV|RV)\.?\s*(?:A|S|Anh\.?\s*)?\d[\w:.\-\u2013/]*\)?\s*$"
)
KEY_EN = re.compile(r"\bin ([A-Ga-g])(?:[- ]?(flat|sharp|♭|#))?[- ]+(major|minor)\b", re.I)
# 「Sonata no. 2 in D」처럼 장·단조가 빠진 꼴. 바로크 카탈로그 관례대로 대문자는 장조로 본다.
KEY_BARE = re.compile(r"\bin ([A-G])(?:[- ]?(flat|sharp))?\s*(?=,|$|\()")
KEY_DE = re.compile(r"\b([A-Ga-g])(is|es|s)?-(Dur|Moll)\b", re.I)
ITEM_GENRE = re.compile(
    r"^(?:\d+\s+)?(Fantasia|Fantasie|Fantaisie|Sonata|Sonate|Suite|Concerto|Quartet|Quatuor|Trio|Overture|Ouverture|Partita|Solo)\b",
    re.I,
)


@dataclass
class Ctx:
    slug: str
    composer_id: int
    works: dict[str, dict[str, Any]]
    existing: dict[int, dict[str, str]]
    errors: list[str] = field(default_factory=list)
    notes: list[str] = field(default_factory=list)


def fetch_works(artist: str) -> dict[str, dict[str, Any]]:
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


def get_work(ctx: Ctx, mbid: str) -> dict[str, Any]:
    """작곡가 목록에 없는 곡(작곡가 관계가 없는 part)은 하나씩 받는다(캐시)."""
    work = ctx.works.get(mbid)
    if work is None:
        work = mb(f"work/{mbid}", {"inc": "aliases+work-rels+artist-rels"})
        ctx.works[mbid] = work
    return work


def resolve(ctx: Ctx, prefix: str, among: list[str] | None = None) -> dict[str, Any]:
    pool = among if among is not None else list(ctx.works)
    hits = [wid for wid in pool if wid.startswith(prefix)]
    if len(hits) != 1:
        raise SystemExit(f"{ctx.slug}: MBID {prefix} 가 {len(hits)}개")
    return get_work(ctx, hits[0])


def roman_value(text: str) -> int:
    total = 0
    for i, ch in enumerate(text):
        value = ROMAN_VALUE[ch]
        nxt = ROMAN_VALUE[text[i + 1]] if i + 1 < len(text) else 0
        total += -value if value < nxt else value
    return total


def strip_catalogue(text: str) -> str:
    previous = None
    while previous != text:
        previous = text
        text = CATALOGUE_TAIL.sub("", text).strip()
    return text


def tail_of(title: str, parent_title: str) -> str:
    """part 제목에서 묶음 이름을 떼어 낸다. 「Paris Quartets, Concerto 1 …, TWV 43:G1: I. Grave」→「I. Grave」."""
    text = title
    for head in (parent_title, strip_catalogue(parent_title)):
        if head and text.startswith(head) and len(text) > len(head) + 1:
            text = text[len(head) :].lstrip(" :,.-\u2013").strip()
            # 번호로 시작하면 남은 쌍점은 곡 이름의 일부다(「I. Prèlude: Vivement」).
            # 아니면 부제가 하나 더 붙은 것이다(「"Good Luck at Last": I. Overture」).
            if re.match(r"^([IVXLC]+[a-z]?\.|No\.|Nr\.|\d+\.)\s", text) or ": " not in text:
                return text
            return text.split(": ", 1)[1].strip()
    if ": " in text:
        text = text.split(": ", 1)[1]
    return text.strip()


def clean(text: str) -> tuple[str, str | None]:
    """앞 번호(「I.」·「No. 3」·「3.」·「a.」)와 뒤 카탈로그 번호를 떼고 (이름, 로마 숫자)를 준다."""
    movement = None
    match = re.match(r"^([IVXLC]+)\.\s+(.*)$", text)
    if match:
        movement, text = match.group(1), match.group(2)
    text = re.sub(r"^(?:No\.|Nr\.|n\.)\s*\d+[a-z]?[.,:]?\s+", "", text)
    text = re.sub(r"^\d+[a-z]?\.\s+", "", text)
    text = re.sub(r"^[a-h]\.\s+", "", text)
    text = strip_catalogue(text).strip(" ,;")
    if len(text) > 1 and text[0] in "\"“„«'" and text[-1] in "\"”»'":
        text = text[1:-1].strip()
    return text, movement


def key_ko(text: str) -> str | None:
    match = KEY_EN.search(text)
    if match:
        note, accidental, mode = (
            match.group(1).upper(),
            (match.group(2) or "").lower(),
            match.group(3),
        )
        sign = {"flat": "♭", "♭": "♭", "sharp": "#", "#": "#"}.get(accidental, "")
        return f"{note}{sign}{'장조' if mode.lower() == 'major' else '단조'}"
    match = KEY_BARE.search(text)
    if match:
        sign = {"flat": "♭", "sharp": "#"}.get((match.group(2) or "").lower(), "")
        return f"{match.group(1)}{sign}장조"
    match = KEY_DE.search(text)
    if match:
        note, accidental, mode = match.group(1), (match.group(2) or "").lower(), match.group(3)
        upper = note.upper()
        if accidental in ("es", "s"):
            sign = "♭"
        elif accidental == "is":
            sign = "#"
        else:
            sign = ""
        if upper == "H" or (note.lower() == "b" and not accidental):
            upper, sign = ("B", "") if note.lower() == "h" else ("B", "♭")
        return f"{upper}{sign}{'장조' if mode.lower() == 'dur' else '단조'}"
    return None


def position(rel: dict[str, Any], parent_title: str) -> tuple[int, float, str]:
    """part 순서: ordering-key → 제목의 로마 숫자·번호 → 제목의 카탈로그 번호 → 제목."""
    title = rel["work"]["title"]
    key = rel.get("ordering-key")
    if key:
        return (0, float(key), title)
    tail = tail_of(title, parent_title)
    match = re.match(r"^([IVXLC]+)\.\s", tail)
    if match:
        return (1, float(roman_value(match.group(1))), title)
    match = re.match(r"^(?:No\.|Nr\.)?\s*(\d+)[a-z]?[.,:]?\s", tail)
    if match:
        return (1, float(match.group(1)), title)
    # 몬테베르디 마드리갈집처럼 순서 표시가 없는 곡은 제목의 SV·Z 번호 순(묶음과 같은 번호는 순서가 아님)
    match = CATALOGUE.search(title)
    number = re.match(r"\d+", match.group(2)) if match else None
    parent_numbers = {m.group(2) for m in CATALOGUE.finditer(parent_title)}
    if match and number and match.group(2) not in parent_numbers:
        return (2, float(number.group(0)), title)
    return (3, 0.0, title)


def forward_parts(work: dict[str, Any]) -> list[dict[str, Any]]:
    return [
        rel
        for rel in work.get("relations", [])
        if rel.get("target-type") == "work"
        and rel["type"] == "parts"
        and rel["direction"] == "forward"
    ]


def ordered_parts(ctx: Ctx, work: dict[str, Any]) -> list[dict[str, Any]]:
    """같은 자리에 두 벌 걸린 곡(같은 ordering-key 또는 같은 번호)은 제목이 긴 것 하나만 쓰고 적어 둔다."""
    rels = sorted(forward_parts(work), key=lambda rel: position(rel, work["title"]))
    unordered = [rel for rel in rels if position(rel, work["title"])[0] == 3]
    if unordered:
        # 순서를 알 수 없는 곡을 제목 순으로 늘어놓지 않는다. 그런 작품은 parts.tsv 로 손으로 정하거나 낱곡으로 둔다.
        ctx.errors.append(
            f"순서 모르는 part {len(unordered)}/{len(rels)}개: {work['title']} — "
            + "; ".join(rel["work"]["title"][-50:] for rel in unordered[:3])
        )
    out: list[dict[str, Any]] = []
    seen: dict[tuple[int, float], dict[str, Any]] = {}
    for rel in rels:
        pos = position(rel, work["title"])
        slot = (pos[0], pos[1])
        if pos[0] < 3 and slot in seen:
            kept = seen[slot]
            if len(rel["work"]["title"]) > len(kept["work"]["title"]):
                out[out.index(kept)] = rel
                seen[slot] = rel
                dropped = kept
            else:
                dropped = rel
            ctx.notes.append(f"겹친 part 뺌: {work['title']} / {dropped['work']['title']}")
            continue
        seen[slot] = rel
        out.append(rel)
    return out


def movement_parts(ctx: Ctx, work: dict[str, Any]) -> list[dict[str, Any]]:
    parts: list[dict[str, Any]] = []
    for seq, rel in enumerate(ordered_parts(ctx, work), start=1):
        # 악장 번호는 순서대로 붙인다. MB 제목의 번호는 겹치거나(「VII. Minuet I」·「VII. Minuet II」) 빠진 곳이 있다.
        name, _ = clean(tail_of(rel["work"]["title"], work["title"]))
        name = PART_NAME_FIX.get(name, name)
        parts.append(part_dict(seq, rel["work"]["id"], rel["work"]["title"], name, ROMAN[seq - 1]))
    return parts


GENRE_KO = {
    "fantasia": "환상곡",
    "fantasie": "환상곡",
    "fantaisie": "환상곡",
    "sonata": "소나타",
    "sonate": "소나타",
    "suite": "모음곡",
    "concerto": "협주곡",
    "quartet": "4중주",
    "quatuor": "4중주",
    "trio": "트리오",
    "overture": "서곡",
    "ouverture": "서곡",
    "partita": "파르티타",
    "solo": "솔로",
}


def item_genre(name: str) -> str | None:
    match = ITEM_GENRE.match(name)
    return GENRE_KO[match.group(1).lower()] if match else None


def item_name(title: str, parent_title: str, mixed: bool) -> str:
    """묶음 안 곡 이름. 「Fantasia No. 1 in A major」처럼 갈래·번호·조성뿐이면 조성만(「A장조」),
    갈래가 섞인 묶음(협주곡 6곡 + 모음곡 6곡)이면 「협주곡 D장조」."""
    name, _ = clean(tail_of(title, parent_title))
    key = key_ko(name)
    genre = item_genre(name)
    if key and genre:
        return f"{genre} {key}" if mixed else key
    if key and name.lower().startswith("in "):
        return key
    return name


def part_dict(
    seq: int,
    mbid: str | None,
    mb_title: str | None,
    name: str,
    movement: str | None,
    existing: int | None = None,
    children: list[dict[str, Any]] | None = None,
) -> dict[str, Any]:
    return {
        "seq": seq,
        "mbid": mbid,
        "mbTitle": mb_title,
        "nameKo": name,
        "nameEn": mb_title or name,
        "movementNumber": movement,
        "catalogueAlt": None,
        "existingPieceId": existing,
        "existingPartId": None,
        "children": children or [],
    }


def collection_parts(ctx: Ctx, work: dict[str, Any]) -> list[dict[str, Any]]:
    rels = ordered_parts(ctx, work)
    genres = {item_genre(clean(tail_of(rel["work"]["title"], work["title"]))[0]) for rel in rels}
    parts: list[dict[str, Any]] = []
    for seq, rel in enumerate(rels, start=1):
        child = get_work(ctx, rel["work"]["id"])
        parts.append(
            part_dict(
                seq,
                child["id"],
                child["title"],
                item_name(child["title"], work["title"], len(genres) > 1),
                None,
                children=movement_parts(ctx, child),
            )
        )
    return parts


def file_parts(
    ctx: Ctx, key: str, work: dict[str, Any] | None, kind: str, rows: list[list[str]]
) -> list[dict[str, Any]]:
    """parts.tsv: 묶음 key, part MBID 앞 8자(없으면 -), 이름, 이어 붙일 운영 작품 id(-), 악장(mb·-)."""
    pool = [rel["work"]["id"] for rel in forward_parts(work)] if work else None
    parts: list[dict[str, Any]] = []
    for seq, (prefix, name, existing, children) in enumerate(rows, start=1):
        movement = ROMAN[seq - 1] if kind == "multi" else None
        if prefix == "-":
            parts.append(part_dict(seq, None, None, name, movement, int_or_none(existing)))
            continue
        # 묶음의 MB parts 에서 먼저 찾고, 없으면(손으로 엮은 묶음) 작곡가 작품 전체에서 찾는다.
        in_parts = [wid for wid in pool or [] if wid.startswith(prefix)]
        part = get_work(ctx, in_parts[0]) if len(in_parts) == 1 else resolve(ctx, prefix)
        kids = movement_parts(ctx, part) if children == "mb" else []
        if children == "mb" and not kids:
            ctx.errors.append(f"악장 없음: {key} / {part['title']}")
        parts.append(
            part_dict(seq, part["id"], part["title"], name, movement, int_or_none(existing), kids)
        )
    return parts


def int_or_none(text: str) -> int | None:
    return None if text in ("", "-") else int(text)


def norm_catalogue(text: str) -> set[str]:
    """「Kk. 141 (L. 422)」→{K 141, L 422}, 「TWV 51:G9」→{TWV 51:G9}, 「Z 626」→{Z 626}."""
    out = set()
    for system, number in CATALOGUE.findall(text or ""):
        system = {"Kk": "K", "ZT": "Z", "ZD": "Z"}.get(system, system)
        out.add(f"{system} {number}")
    return out


def check_duplicate(ctx: Ctx, catalogue: str, title: str) -> None:
    mine = {item for item in norm_catalogue(catalogue) if not item.startswith("L ")}
    for pid, row in ctx.existing.items():
        theirs = norm_catalogue(row["opus_number"]) | norm_catalogue(
            f"{row['catalogue_system']} {row['catalogue_number']}"
        )
        if mine & theirs:
            ctx.errors.append(
                f"운영 작품 {pid}「{row['title']}」와 작품번호 겹침: {title} {catalogue}"
            )


def read_rows(path: str) -> list[list[str]]:
    if not os.path.exists(path):
        return []
    with open(path, encoding="utf-8") as handle:
        lines = [line for line in handle if line.strip() and not line.startswith("#")]
    return [row for row in csv.reader(lines, delimiter="\t", quoting=csv.QUOTE_NONE)]


def build(ctx: Ctx) -> tuple[list[dict[str, Any]], list[tuple[str, str, str]]]:
    folder = os.path.join(HERE, ctx.slug)
    part_rows: dict[str, list[list[str]]] = {}
    for row in read_rows(os.path.join(folder, "parts.tsv")):
        key, prefix, name, link, children = [*row, "-", "-"][:5]
        part_rows.setdefault(key, []).append([prefix, name, link, children])
    catalog: list[dict[str, Any]] = []
    genres: list[tuple[str, str, str]] = []
    for row in read_rows(os.path.join(folder, "works.tsv")):
        key, title, catalogue, year, genre, form, kind, existing_text, mode = row[:9]
        title_en = row[9] if len(row) > 9 else ""
        label = f"{title} {catalogue}"
        if FORMS.get(form) != genre:
            ctx.errors.append(f"piece_forms 에 없는 짝 {genre}/{form}: {label}")
        existing = int_or_none(existing_text)
        is_mb = re.fullmatch(r"[0-9a-f]{8}", key) is not None
        work = resolve(ctx, key) if is_mb else None
        if existing is not None:
            row_now = ctx.existing.get(existing)
            if row_now is None:
                ctx.errors.append(f"이 작곡가 운영 작품이 아님 {existing}: {label}")
            elif row_now["title"] != title:
                ctx.errors.append(f"운영 제목과 다름 {existing}「{row_now['title']}」: {label}")
        elif catalogue:
            check_duplicate(ctx, catalogue, title)
        if mode == "mb" and work is not None:
            parts = movement_parts(ctx, work) if kind == "multi" else collection_parts(ctx, work)
        elif mode == "file":
            parts = file_parts(ctx, key, work, kind, part_rows.pop(key, []))
        else:
            parts = []
        if (kind == "single") != (not parts):
            ctx.errors.append(f"kind {kind} 인데 part {len(parts)}개: {label}")
        catalog.append(
            {
                "key": f"{ctx.slug}-{key}",
                "kind": KINDS[kind],
                "catalogue": catalogue or None,
                "catalogueAlt": None,
                "titleKo": title,
                "titleEn": title_en or (work["title"] if work else title),
                "year": int(year) if year else None,
                "yearText": None,
                "genre": None,
                "authenticity": "authentic",
                "mbid": work["id"] if work else None,
                "mbTitle": work["title"] if work else None,
                "existingPieceId": existing,
                "parts": parts,
            }
        )
        if existing is None:
            genres.append((title, genre, form))
    for key in part_rows:
        ctx.errors.append(f"parts.tsv 에만 있는 묶음 key: {key}")
    return catalog, genres


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


def read_pieces(path: str, composer_id: int) -> dict[int, dict[str, str]]:
    with open(path, encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle, delimiter="\t", quoting=csv.QUOTE_NONE))
    return {int(row["id"]): row for row in rows if int(row["composer_id"]) == composer_id}


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--composer", required=True, choices=sorted(COMPOSERS))
    parser.add_argument(
        "--db", required=True, help="dump.sh 덤프 폴더(pieces.tsv·all_mbids_taken.tsv)"
    )
    parser.add_argument("--out", required=True)
    parser.add_argument("--migration")
    args = parser.parse_args()
    composer_id, artist = COMPOSERS[args.composer]
    ctx = Ctx(
        slug=args.composer,
        composer_id=composer_id,
        works=fetch_works(artist),
        existing=read_pieces(os.path.join(args.db, "pieces.tsv"), composer_id),
    )
    catalog, genres = build(ctx)
    for note in ctx.notes:
        print(note, file=sys.stderr)
    if ctx.errors:
        print("\n".join(ctx.errors), file=sys.stderr)
        sys.exit(1)
    out = os.path.join(args.out, args.composer)
    os.makedirs(out, exist_ok=True)
    with open(os.path.join(out, "catalog.json"), "w", encoding="utf-8") as handle:
        json.dump(catalog, handle, ensure_ascii=False, indent=1)
    with open(os.path.join(out, "seed_map.json"), "w", encoding="utf-8") as handle:
        json.dump([], handle)
    with open(os.path.join(out, "genres.sql"), "w", encoding="utf-8") as handle:
        handle.write(genre_sql(composer_id, genres))
    parts = sum(len(w["parts"]) for w in catalog)
    children = sum(len(p["children"]) for w in catalog for p in w["parts"])
    print(json.dumps({"works": len(catalog), "parts": parts, "children": children}))
    if not args.migration:
        return
    gen = [
        sys.executable,
        GEN,
        "--composer-id",
        str(composer_id),
        "--slug",
        args.composer,
        "--catalog",
        os.path.join(out, "catalog.json"),
        "--pieces",
        os.path.join(args.db, "pieces.tsv"),
        "--taken",
        os.path.join(args.db, "all_mbids_taken.tsv"),
        "--seed-map",
        os.path.join(out, "seed_map.json"),
        "--out",
        os.path.join(out, "catalog.sql"),
    ]
    subprocess.run(gen, check=True)
    with open(os.path.join(HERE, args.composer, "header.sql"), encoding="utf-8") as handle:
        header = handle.read()
    with open(os.path.join(out, "catalog.sql"), encoding="utf-8") as handle:
        body = handle.read()
    with open(args.migration, "w", encoding="utf-8") as handle:
        handle.write(
            header.rstrip("\n")
            + "\n\n"
            + body.rstrip("\n")
            + "\n\n"
            + genre_sql(composer_id, genres)
        )


if __name__ == "__main__":
    main()
