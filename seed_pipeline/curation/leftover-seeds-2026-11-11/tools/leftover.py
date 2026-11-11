# ruff: noqa: E501 — SQL 머리 주석과 규칙 표는 한 줄로 둔다.
"""남은 원어 seed(4·5·6차가 판단을 못 한 unreviewed) 정리 결정과 마이그레이션.

4·5·6차 자동 카탈로그는 「Antigonae: I. …」·「Première concert: La Flore」처럼 콜론 앞 이름의 부모
작품이 MusicBrainz 에 없거나 부모 관계(parts)가 걸리지 않은 악장·대목 work 를 판단하지 못해 그대로 뒀다
(auto_catalog.py 의 `odd`). 여기서는 seed 마다 다음 순서로 정한다.

1. 중복(--dup-decisions): 같은 작품이 이미 손 작품으로 있는 seed 는 중복 정리 방식
   (duplicate-pieces-2026-11-11/gen_sql.py)으로 숨기고 참조를 남길 작품으로 옮긴다.
2. MB 에서 편곡·다른 판이거나, 같은 MB work 를 다른 작품이 이미 쓰면 숨긴다(catalog_unmatched).
3. 카탈로그 작품의 part 와 같은 곡이면 그 part 에 잇는다. 같은 곡으로 보는 조건은
   MB 제목이 정규화해서 같거나, 콜론 앞 작품번호(Op.·G.·S. …)가 겹치고 악장 번호와 악장 이름이 같을 때다.
   part 가 이미 다른 작품을 가리키면 seed 는 그 작품의 중복이라 숨긴다.
4. 같은 작곡가에서 콜론 앞 이름이 같은 seed 가 둘 이상이면 그 이름으로 묶음 작품을 새로 만들고
   seed 를 그 안 곡으로 잇는다(6차 음반 묶음처럼 「<묶음> 중 "<곡>"」). 「Himno: …」처럼 콜론 앞이
   갈래 이름뿐이거나 곡마다 작품번호가 다른 것(「Scherzo: …, S. 81」)은 묶지 않는다. 같은 곡 이름이 절반 넘게
   한 카탈로그 작품의 part 와 같고 그 작품과 이름·번호가 어긋나지 않으면 그 part 에 잇는다. 묶음 이름이 카탈로그 작품과
   같은 작품으로 보이면 만들지 않고 그대로 둔다.
5. 남은 낱개 seed 는 녹음이 실린 MusicBrainz 음반(release group)이 같은 것끼리 셋 이상이면
   음반 묶음을 만든다(6차 film_catalog.py 의 음반 고르기와 같은 순서). 모음집·실황·전집처럼
   음반 이름이 작품 이름이 될 수 없는 음반과, 작품번호가 있어 따로 선 작품인 seed 는 빼고 본다.
6. 그 밖은 그대로 둔다(판단 보류, 숨기지 않음).

사용(seed_pipeline 에서):
    CM_FETCH_CACHE=<캐시> uv run python curation/leftover-seeds-2026-11-11/tools/leftover.py \\
        --db <덤프 폴더> --dup-decisions curation/leftover-seeds-2026-11-11/dup_decisions.json \\
        --dup-gen curation/duplicate-pieces-2026-11-11/gen_sql.py \\
        --out <작업 폴더> --migrations ../migrations --first 202611110601
"""

import argparse
import csv
import hashlib
import json
import os
import re
import sys
import unicodedata
from collections import Counter, defaultdict
from dataclasses import dataclass, field
from typing import Any

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import mbwork
import sqlparts

auto: Any = mbwork.auto
gen: Any = mbwork.gen
classify: Any = mbwork.classify
fetch: Any = sys.modules["fetch"]

csv.field_size_limit(10_000_000)

FOLDER = "seed_pipeline/curation/leftover-seeds-2026-11-11"
MARKER = re.compile(
    r"^(?:(?P<roman>[IVXL]+)\.|(?:No\.|Nr\.|N°)\s*(?P<no>\d+)[a-z]?\.?|(?P<num>\d+)\.)\s*(?P<text>.*)$"
)
COLON = re.compile(r"\s*:\s+")
PART_ORDINAL = re.compile(
    r"^(premiere|deuxieme|troisieme|quatrieme|first|second|third|fourth)\s+(partie|part|acte|act)\b"
)
PART_NUMBERS = {
    "prem": 1,
    "firs": 1,
    "deux": 2,
    "seco": 2,
    "troi": 3,
    "thir": 3,
    "quat": 4,
    "four": 4,
}
KOREAN_PART = re.compile(r'^(?P<head>.+?) 중 (?:"(?P<quoted>.+)"|(?P<bare>[^"]+))$')
# 「Himno: …」「Scherzo: …」처럼 콜론 앞이 작품 이름이 아니라 갈래 이름뿐인 것은 묶지 않는다
GENERIC_HEADS = {
    "himno",
    "hymn",
    "scherzo",
    "study",
    "etude",
    "song",
    "scene",
    "prologue",
    "chorus",
    "epistola",
    "psalmus",
    "motet",
    "aria",
    "romance",
    "prelude",
    "march",
    "allegretto",
}
# 모음집·전집 같은 음반 이름은 작품 이름이 될 수 없다
COMPILATION_TITLE = re.compile(
    r"/|\b(vol(ume)?\.?|collection|sammlung|plays|essential|complete|music|works|best of|"
    r"anthology|songbook|portrait|edition)\b",
    re.I,
)
SIDE_TYPES = {"Compilation", "Live", "Remix", "DJ-mix", "Mixtape/Street", "Demo", "Interview"}
ROMAN_VALUES = {"I": 1, "V": 5, "X": 10, "L": 50}


Row = dict[str, str]
Work = dict[str, Any]


@dataclass
class Seed:
    row: Row
    pid: int
    cid: int
    mbid: str | None = None
    mb_title: str = ""
    head: str | None = None
    rest: str = ""
    index: int | None = None
    roman: str | None = None
    text: str = ""
    decision: dict[str, Any] = field(default_factory=dict)


def read_tsv(path: str) -> list[Row]:
    with open(path, encoding="utf-8") as handle:
        return list(csv.DictReader(handle, delimiter="\t", quoting=csv.QUOTE_NONE))


def null(value: str | None) -> str:
    return "" if value in (None, "NULL") else str(value)


def norm(text: str) -> str:
    """악장 이름 비교용: 악센트·문장부호·대소문자를 뗀다."""
    ascii_text = unicodedata.normalize("NFKD", text).encode("ascii", "ignore").decode().lower()
    return re.sub(r"[^a-z0-9]+", "", ascii_text)


def roman_value(text: str) -> int:
    total = 0
    for i, char in enumerate(text):
        value = ROMAN_VALUES[char]
        if i + 1 < len(text) and ROMAN_VALUES[text[i + 1]] > value:
            total -= value
        else:
            total += value
    return total


def movement(rest: str) -> tuple[int | None, str | None, str]:
    """「IV. v10 "Dux…"」 → (4, 'IV', 'v10 "Dux…"'). 번호가 없으면 (None, None, rest)."""
    match = MARKER.match(rest)
    if not match:
        part = PART_ORDINAL.match(norm_words(rest))
        if part:
            # 「Deuxième partie : …」 같은 부·막 순서(번호가 겹쳐 악장 번호로는 쓰지 않음)
            return PART_NUMBERS[part.group(1)[:4]], None, rest
        return None, None, rest
    text = match.group("text").lstrip(" ,.:;-")
    if match.group("roman"):
        return roman_value(match.group("roman")), match.group("roman"), text
    number = match.group("no") or match.group("num")
    return int(number), None, text


def split_mb(title: str) -> tuple[str | None, str]:
    """MB 제목을 (작품, 곡)으로. 곡 번호(I.·No. 2.·3.)가 붙은 마지막 콜론을 먼저 본다."""
    colons = list(COLON.finditer(title))
    for match in reversed(colons):
        after = title[match.end() :]
        if MARKER.match(after):
            return title[: match.start()].strip(), after.strip()
    if colons:
        first = colons[0]
        return title[: first.start()].strip(), title[first.end() :].strip()
    return None, title.strip()


def base_tokens(text: str) -> set[str]:
    return {token.split("/")[0] for token in auto.catalogue_tokens(text)}


def slug_of(name: str) -> str:
    ascii_name = unicodedata.normalize("NFKD", name).encode("ascii", "ignore").decode().lower()
    return re.sub(r"[^a-z0-9]+", "-", ascii_name).strip("-") or "composer"


class Catalog:
    def __init__(self, db: str) -> None:
        self.composers = {int(r["id"]): r for r in read_tsv(os.path.join(db, "composers.tsv"))}
        self.rows = read_tsv(os.path.join(db, "pieces.tsv"))
        self.by_id = {int(r["id"]): r for r in self.rows}
        self.by_composer: dict[int, list[Row]] = defaultdict(list)
        for row in self.rows:
            self.by_composer[int(row["composer_id"])].append(row)
        self.taken = {
            r["external_id"]: int(r["piece_id"])
            for r in read_tsv(os.path.join(db, "all_mbids_taken.tsv"))
        }
        self.parts: dict[int, list[Row]] = defaultdict(list)
        for part in read_tsv(os.path.join(db, "parts_full.tsv")):
            self.parts[int(part["piece_id"])].append(part)

    def leftover(self) -> list[Row]:
        return [
            r
            for r in self.rows
            if r["origin"] == "seed"
            and r["editor_locked"] == "0"
            and r["hidden_reason"] == "NULL"
            and self.composers[int(r["composer_id"])]["hidden_reason"] == "NULL"
        ]

    def artists(self, cid: int) -> set[str]:
        return {a for a in null(self.composers[cid]["mb_artist"]).split(",") if a}


def load_seed(catalog: Catalog, row: Row) -> Seed:
    seed = Seed(row=row, pid=int(row["id"]), cid=int(row["composer_id"]))
    mbids = [m for m in null(row["mbids"]).split(",") if m]
    if mbids:
        data = mbwork.work(mbids[0])
        if data:
            seed.mbid = str(data["id"])
            seed.mb_title = str(data["title"])
            seed.decision["mbWork"] = {
                "id": data["id"],
                "requested": mbids[0],
                "title": data["title"],
                "type": data.get("type"),
                "url": "https://musicbrainz.org/work/" + str(data["id"]),
                "parents": mbwork.parents(data),
                "composerOk": bool(mbwork.composers(data) & catalog.artists(seed.cid)),
            }
            artist = next(iter(catalog.artists(seed.cid)), "")
            derived = auto.derived_reason(data, artist)
            if derived:
                seed.decision["derived"] = derived
    title = seed.mb_title or null(row["title_en"]) or row["title"]
    seed.head, seed.rest = split_mb(title)
    seed.index, seed.roman, seed.text = movement(seed.rest)
    return seed


def decide(seed: Seed, action: str, evidence: str, **extra: Any) -> None:
    seed.decision.update(action=action, evidence=evidence, **extra)


# ---------------------------------------------------------------- 3. 카탈로그 part 에 잇기


@dataclass
class PartKey:
    piece_id: int
    part: Row
    head: str | None
    index: int | None
    text: str
    full: str


def part_keys(catalog: Catalog, cid: int, skip: set[int]) -> list[PartKey]:
    keys: list[PartKey] = []
    for row in catalog.by_composer[cid]:
        pid = int(row["id"])
        if pid in skip or row["hidden_reason"] != "NULL":
            continue
        for part in catalog.parts.get(pid, []):
            name = null(part["name_en"]) or null(part["name_ko"])
            if not name:
                continue
            head, rest = split_mb(name)
            index, _, text = movement(rest)
            if head is None:
                text_head, _ = auto.split_title(rest)
                text = text_head
            if index is None and head is None and part["sequence_number"] not in ("", "NULL"):
                index = int(part["sequence_number"])
            keys.append(PartKey(pid, part, head, index, text, name))
    return keys


def same_movement(left: str, right: str) -> bool:
    """악장 이름이 철자만 다른가: 하나가 다른 하나로 시작하거나 첫 낱말이 같다(악장 번호가 같을 때만 씀).

    「Minuetto e Trio」·「Minuetto - Trio」, 「Allemande」·「Allemande Légère」.
    """
    a, b = norm(left), norm(right)
    if not a or not b:
        return False
    if a.startswith(b) or b.startswith(a):
        return True
    first = [re.findall(r"[a-z0-9]+", norm_words(x))[:1] for x in (left, right)]
    return bool(first[0]) and first[0] == first[1] and len(first[0][0]) >= 4


def norm_words(text: str) -> str:
    return unicodedata.normalize("NFKD", text).encode("ascii", "ignore").decode().lower()


def part_matches(seed: Seed, key: PartKey) -> bool:
    if not seed.mb_title:
        return False
    if norm(seed.mb_title) == norm(key.full):
        return True
    if not seed.head or not norm(seed.text):
        return False
    if seed.index is not None and key.index is not None and seed.index != key.index:
        return False
    if norm(seed.text) != norm(key.text) and not (
        seed.index is not None and seed.index == key.index and same_movement(seed.text, key.text)
    ):
        return False
    mine = auto.catalogue_tokens(seed.head)
    theirs = auto.catalogue_tokens(key.head or key.full)
    if mine & theirs:
        return True
    if seed.index is not None and {f"{t}/{seed.index}" for t in mine} & theirs:
        # 「Three Motets, op. 2: II. Ave Maria」 ↔ part 「Ave Maria, op. 2 no. 2」
        return True
    return bool(base_tokens(seed.head) & base_tokens(key.head or key.full)) and not (
        mine and theirs
    )


def part_title(catalog: Catalog, key: PartKey) -> str:
    """이은 seed 의 새 제목 「<작품>[ <part 묶음>] 중 "<곡>"」(gen_catalog 의 retitle_linked_seed 꼴)."""
    owner = catalog.by_id[key.piece_id]
    head = owner["title"]
    parent_id = null(key.part["parent_part_id"])
    if parent_id:
        parent = next(
            (p for p in catalog.parts[key.piece_id] if p["id"] == parent_id),
            None,
        )
        if parent is not None:
            head = f"{head} {null(parent['name_ko']) or null(parent['name_en'])}"
    name = null(key.part["name_ko"]) or null(key.part["name_en"])
    return f'{head} 중 "{name}"'


# ---------------------------------------------------------------- 4·5. 묶음


def korean_head(seeds: list[Seed]) -> str | None:
    heads = {m.group("head") for s in seeds if (m := KOREAN_PART.match(s.row["title"]))}
    return heads.pop() if len(heads) == 1 else None


def korean_name(seed: Seed, multi: bool) -> str:
    match = KOREAN_PART.match(seed.row["title"])
    if match:
        name = match.group("quoted") or match.group("bare")
        if multi:
            name = re.sub(r"^\d+(번|악장)\s+", "", name)
        return name
    if multi:
        return seed.text.strip(" .") or f"{seed.index}악장"
    return seed.rest


def bundle_title(head: str, seeds: list[Seed]) -> tuple[str, str | None]:
    ko = korean_head(seeds)
    plain, catalogue = auto.split_title(head)
    if ko:
        return ko, catalogue
    title, translated = auto.translate(plain, None)
    if translated:
        if catalogue and not title.endswith(catalogue):
            title = f"{title} {catalogue}"
        return title, catalogue
    return head, catalogue


def free_title(title: str, head: str, taken: set[str]) -> str | None:
    for option in (title, f"{title} ({head})" if head != title else title, f"{title} (묶음)"):
        if option[:250] not in taken:
            return option[:250]
    return None


def genre_of(cid: int, title: str, title_en: str, catalogue: str | None, parts: int) -> Any:
    row = classify.Row(
        piece_id=0,
        composer_id=cid,
        title=title,
        title_en=title_en,
        work_type="",
        catalogue=catalogue or "",
        parts=parts,
    )
    form, rule = classify.classify_text(row, set())
    genre = classify.FORM_GENRE.get(form) if form else None
    return (genre, form if genre else None, rule)


def same_as_catalog(catalog: Catalog, cid: int, head: str, skip: set[int]) -> Row | None:
    """묶음 이름이 이미 있는 카탈로그 작품과 같은 작품인가(이름·작품번호가 맞음)."""
    plain, _ = auto.split_title(head)
    wanted = norm(plain)
    tokens = auto.catalogue_tokens(head)
    for row in catalog.by_composer[cid]:
        if int(row["id"]) in skip or row["hidden_reason"] != "NULL":
            continue
        for label in (null(row["title_en"]), row["title"]):
            if not label:
                continue
            other_plain, _ = auto.split_title(label)
            other_tokens = auto.catalogue_tokens(label)
            if norm(other_plain) == wanted and (
                not tokens or not other_tokens or tokens & other_tokens
            ):
                return row
    return None


def mb_parent(head: str, artists: set[str]) -> dict[str, Any] | None:
    """콜론 앞 이름과 제목이 같은 이 작곡가의 MB work(부모 관계는 안 걸려 있어도 작품은 있는 경우)."""
    plain, _ = auto.split_title(head)
    wanted = norm(plain)
    if not wanted:
        return None
    for artist in sorted(artists):
        phrase = plain.replace('"', " ")
        found = fetch.mb("work", {"query": f'work:"{phrase}" AND arid:{artist}', "limit": 100})
        for work in (found or {}).get("works", []):
            title_plain, _ = auto.split_title(str(work.get("title") or ""))
            if norm(title_plain) == wanted:
                return dict(work)
    return None


ORDINALS = {
    "premier": 1,
    "premiere": 1,
    "1re": 1,
    "1er": 1,
    "first": 1,
    "deuxieme": 2,
    "second": 2,
    "seconde": 2,
    "2e": 2,
    "troisieme": 3,
    "third": 3,
    "3e": 3,
    "quatrieme": 4,
    "fourth": 4,
    "4e": 4,
}
NUMBERS_IN_TITLE = re.compile(
    r"\b(?:no|nr|n°|number)\.?\s*(\d+)|(\d+)\s*번|\b(\d+)(?:re|er|e|st|nd|rd|th)\b", re.I
)


def title_numbers(text: str) -> set[int]:
    found = {int(next(g for g in m.groups() if g)) for m in NUMBERS_IN_TITLE.finditer(text)}
    ascii_text = unicodedata.normalize("NFKD", text).encode("ascii", "ignore").decode().lower()
    found |= {ORDINALS[w] for w in re.findall(r"[a-z0-9]+", ascii_text) if w in ORDINALS}
    return found


SOLFEGE = {"ut": "C", "do": "C", "re": "D", "mi": "E", "fa": "F", "sol": "G", "la": "A", "si": "B"}
ROMANCE_KEY = re.compile(
    r"\b(ut|do|re|mi|fa|sol|la|si)(?:[\s-]+(bemol|bemolle|diese|diesis))?[\s-]+"
    r"(majeur|mineur|maggiore|minore)\b",
    re.I,
)
KOREAN_KEY = re.compile(r"([A-G][♯♭]?)(장조|단조)")


def key_signature(text: str) -> str | None:
    """조성(「B♭장조」 꼴). 영어·독일어는 4차 key_ko, 프랑스어·이탈리아어 계이름, 우리말 제목."""
    found = KOREAN_KEY.search(text)
    if found:
        return found.group(0)
    english = auto.key_ko(text)
    if english:
        return str(english)
    ascii_text = unicodedata.normalize("NFKD", text).encode("ascii", "ignore").decode().lower()
    romance = ROMANCE_KEY.search(ascii_text)
    if romance:
        sign = {"bemol": "♭", "bemolle": "♭", "diese": "♯", "diesis": "♯"}.get(
            romance.group(2) or "", ""
        )
        mode = "장조" if romance.group(3) in ("majeur", "maggiore") else "단조"
        return SOLFEGE[romance.group(1)] + sign + mode
    return None


def heads_compatible(head: str, row: Row) -> bool:
    """seed 묶음 이름과 카탈로그 작품이 같은 작품일 수 있나: 번호·작품번호가 어긋나지 않고 이름이 닮음."""
    for label in (null(row["title_en"]), row["title"]):
        if not label:
            continue
        mine, theirs = auto.catalogue_tokens(head), auto.catalogue_tokens(label)
        if mine and theirs and not (base_tokens(head) & base_tokens(label)):
            continue
        numbers, other = title_numbers(head), title_numbers(label)
        if numbers and other and not numbers & other:
            continue
        mine_key, their_key = key_signature(head), key_signature(label)
        if mine_key and their_key and mine_key != their_key:
            return False
        # 우리말 제목은 영문 낱말이 거의 없어 닮음을 잴 수 없다. 영어 제목끼리만 잰다
        if label == row["title"] and re.search(r"[가-힣]", label):
            continue
        if auto.similar(auto.split_title(head)[0], auto.split_title(label)[0]):
            return True
    return False


def twin_by_parts(
    catalog: Catalog, cid: int, members: list[Seed], skip: set[int]
) -> tuple[int, dict[int, Row]] | None:
    """seed 곡 이름 절반 넘게가 한 카탈로그 작품의 part 이름과 같으면 (그 작품, seed→part)."""
    best: tuple[int, dict[int, Row]] | None = None
    for row in catalog.by_composer[cid]:
        pid = int(row["id"])
        if pid in skip or row["hidden_reason"] != "NULL" or not catalog.parts.get(pid):
            continue
        head = members[0].head or ""
        if not heads_compatible(head, row):
            continue
        by_text: dict[str, list[Row]] = defaultdict(list)
        for part in catalog.parts[pid]:
            name = null(part["name_en"]) or null(part["name_ko"])
            _, rest = split_mb(name)
            by_text[norm(movement(rest)[2])].append(part)
            by_text[norm(null(part["name_ko"]))].append(part)
        hits: dict[int, Row] = {}
        for seed in members:
            parts = {p["id"]: p for p in by_text.get(norm(seed.text), [])}
            if not parts:
                # 「Allemande」·「Allemande Légère」처럼 철자만 다른 악장 이름
                parts = {
                    p["id"]: p
                    for text, found in by_text.items()
                    if text
                    and norm(seed.text)
                    and (text.startswith(norm(seed.text)) or norm(seed.text).startswith(text))
                    for p in found
                }
            if len(parts) == 1:
                hits[seed.pid] = next(iter(parts.values()))
        if (
            len(hits) >= 2
            and len(hits) * 2 > len(members)
            and (best is None or len(hits) > len(best[1]))
        ):
            best = (pid, hits)
    return best


def release_groups(seed: Seed) -> list[dict[str, Any]]:
    """seed work 의 녹음(앞 둘)이 실린 음반들."""
    if not seed.mbid:
        return []
    data = fetch.mb("work/" + seed.mbid, {"inc": "recording-rels"})
    recordings = [
        rel["recording"]["id"]
        for rel in (data or {}).get("relations", [])
        if rel.get("target-type") == "recording"
    ]
    out: list[dict[str, Any]] = []
    for recording in recordings[:2]:
        detail = fetch.mb("recording/" + recording, {"inc": "releases+release-groups"})
        for release in (detail or {}).get("releases", []):
            group = release.get("release-group") or {}
            if group.get("id"):
                out.append(
                    {
                        "rg": group["id"],
                        "title": group.get("title") or "",
                        "secondary": group.get("secondary-types") or [],
                        "date": release.get("date") or "9999",
                        "status": release.get("status"),
                        "release": release["id"],
                    }
                )
    return out


def track_order(members: list[Seed]) -> list[str]:
    """악장 번호로 순서를 못 정하는 묶음: seed 가 가장 많이 실린 공식 판의 트랙 순서(MB work id)."""
    count: Counter[str] = Counter()
    for seed in members:
        seen: set[str] = set()
        for entry in release_groups(seed):
            if entry["status"] == "Official" and entry["release"] not in seen:
                seen.add(entry["release"])
                count[entry["release"]] += 1
    if not count:
        return []
    release = sorted(count, key=lambda r: (-count[r], r))[0]
    return album_order(release, {s.mbid for s in members if s.mbid})


def album_order(release: str, wanted: set[str]) -> list[str]:
    """대표 판 트랙 순서대로 wanted 안의 work id."""
    data = fetch.mb("release/" + release, {"inc": "recordings+work-rels+recording-level-rels"})
    order: list[str] = []
    for medium in (data or {}).get("media", []):
        for track in medium.get("tracks", []):
            for rel in (track.get("recording") or {}).get("relations", []):
                if rel.get("target-type") == "work" and rel.get("type") == "performance":
                    wid = rel["work"]["id"]
                    if wid in wanted and wid not in order:
                        order.append(wid)
    return order


# ---------------------------------------------------------------- 실행


@dataclass
class ComposerPlan:
    cid: int
    slug: str
    name: str
    works: list[Work] = field(default_factory=list)
    links: list[str] = field(default_factory=list)
    hide: dict[str, list[int]] = field(default_factory=lambda: defaultdict(list))
    genres: list[str] = field(default_factory=list)
    counts: Counter[str] = field(default_factory=Counter)


def bundle_work(
    plan: ComposerPlan,
    key: str,
    title: str,
    head: str,
    catalogue: str | None,
    members: list[Seed],
    multi: bool,
    names: dict[int, str],
    mbid: str | None = None,
) -> Work:
    parts: list[dict[str, Any]] = []
    for seq, seed in enumerate(members, start=1):
        parts.append(
            {
                "seq": seq,
                "mbid": seed.mbid,
                "mbTitle": seed.mb_title,
                "nameKo": names[seed.pid][:500],
                "nameEn": (seed.text if multi else seed.rest)[:500],
                "movementNumber": seed.roman if multi else None,
                "catalogueAlt": None,
                "existingPieceId": seed.pid,
                "existingPartId": None,
                "children": [],
            }
        )
    return {
        "key": key,
        "kind": "multi_movement" if multi else "collection",
        "catalogue": catalogue if catalogue and title.endswith(catalogue) else None,
        "catalogueAlt": None,
        "titleKo": title,
        "titleEn": head[:250],
        "year": None,
        "yearText": None,
        "genre": None,
        "authenticity": "authentic",
        "mbid": mbid,
        "mbTitle": head,
        "existingPieceId": None,
        "parts": parts,
    }


def link_seed(
    catalog: Catalog,
    plan: "ComposerPlan",
    seed: Seed,
    key: PartKey,
    used: dict[str, int],
    cid: int,
    why: str,
) -> None:
    linked = null(key.part["linked_piece_id"])
    part_ref = f"작품 {key.piece_id} part {key.part['id']} 「{key.full}」"
    if linked and int(linked) != seed.pid:
        decide(
            seed,
            "hide",
            f"{part_ref} 가 이미 작품 {linked} 를 가리킴(같은 곡)",
            duplicateOf=int(linked),
        )
        plan.hide["카탈로그 part 가 이미 같은 곡을 가리키는"].append(seed.pid)
        return
    if key.part["id"] in used:
        decide(
            seed,
            "keep",
            f"{part_ref} 에 먼저 이어진 seed {used[key.part['id']]} 가 있음(같은 곡인지 불확실)",
        )
        return
    if key.part["editorial_status"] not in ("EDITOR_REVIEWED", "PUBLISHED"):
        decide(seed, "keep", f"{part_ref} 가 화면에 안 보이는 part 라 잇지 않음")
        return
    used[key.part["id"]] = seed.pid
    title = part_title(catalog, key)
    # 영어 제목은 seed 의 MB 원제를 그대로 둔다(부모 제목을 이어 붙이면 같은 말이 두 번 나온다)
    title_en = null(seed.row["title_en"]) or seed.mb_title or title
    decide(seed, "link", f"{part_ref} 와 {why}", piece=key.piece_id, part=key.part["id"])
    seed.decision["newTitle"] = title
    plan.links.append(
        sqlparts.link_existing_part(
            cid, key.piece_id, key.part["part_key"], seed.pid, title, title_en
        )
    )


def plan_composer(
    catalog: Catalog, cid: int, seeds: list[Seed], dup_ids: set[int], all_seed_ids: set[int]
) -> ComposerPlan:
    composer = catalog.composers[cid]
    plan = ComposerPlan(
        cid=cid, slug=slug_of(composer["english_name"] or composer["name"]), name=composer["name"]
    )
    titles = {r["title"] for r in catalog.by_composer[cid]}
    open_seeds: list[Seed] = []

    # 2. 편곡·다른 판, 이미 다른 작품이 쓰는 MB work
    for seed in seeds:
        if seed.pid in dup_ids:
            continue
        if seed.decision.get("derived"):
            decide(seed, "hide", f"MusicBrainz 에서 {seed.decision['derived']} 로 표시된 work")
            plan.hide["MB 에서 편곡·다른 판으로 표시된"].append(seed.pid)
        elif seed.mbid and catalog.taken.get(seed.mbid, seed.pid) != seed.pid:
            other = catalog.taken[seed.mbid]
            decide(seed, "hide", f"같은 MB work 를 작품 {other} 가 이미 씀", duplicateOf=other)
            plan.hide["같은 MB work 를 다른 작품이 쓰는"].append(seed.pid)
        else:
            open_seeds.append(seed)

    # 3. 카탈로그 part 에 잇기
    keys = part_keys(catalog, cid, all_seed_ids)
    used: dict[str, int] = {}
    rest: list[Seed] = []
    for seed in sorted(open_seeds, key=lambda s: s.pid):
        hits = [k for k in keys if part_matches(seed, k)]
        if len({(k.piece_id, k.part["id"]) for k in hits}) != 1:
            if len(hits) > 1:
                seed.decision["note"] = "카탈로그 part 여럿과 맞아 잇지 않음: " + ", ".join(
                    f"{k.piece_id}/{k.part['id']}" for k in hits[:5]
                )
            rest.append(seed)
            continue
        link_seed(catalog, plan, seed, hits[0], used, cid, "같은 곡")

    # 4. 콜론 앞 이름 묶음
    groups: dict[str, list[Seed]] = defaultdict(list)
    for seed in rest:
        if seed.head:
            groups[seed.head].append(seed)
    singles: list[Seed] = [s for s in rest if not s.head or len(groups[s.head]) < 2]
    for head, members in sorted(groups.items()):
        if len(members) < 2:
            continue
        plain, catalogue = auto.split_title(head)
        rest_tokens = [auto.catalogue_tokens(s.rest) for s in members]
        separate = (
            not auto.catalogue_tokens(head)
            and all(rest_tokens)
            and len({frozenset(t) for t in rest_tokens}) == len(members)
        )
        if norm(plain) in GENERIC_HEADS or separate:
            # 갈래 이름만 같은 서로 다른 작품(「Himno: …」, 「Scherzo: …, S. 81」·「…, S. 82」)
            note = (
                f"「{head}」 뒤 곡마다 작품번호가 달라 서로 다른 작품으로 보고 묶지 않음"
                if separate
                else f"「{head}」은 갈래 이름이라 묶지 않음"
            )
            for seed in members:
                seed.decision["note"] = note
                seed.decision["generic"] = not separate
            singles.extend(members)
            continue
        twin = same_as_catalog(catalog, cid, head, all_seed_ids)
        ko_head = korean_head(members)
        if twin is None and ko_head:
            twin = next(
                (
                    r
                    for r in catalog.by_composer[cid]
                    if r["title"] == ko_head
                    and r["hidden_reason"] == "NULL"
                    and int(r["id"]) not in all_seed_ids
                ),
                None,
            )
        overlap = twin_by_parts(catalog, cid, members, all_seed_ids)
        found = mb_parent(head, catalog.artists(cid))
        if found and found["id"] in catalog.taken and twin is None:
            taken_row = catalog.by_id.get(catalog.taken[found["id"]])
            if taken_row is not None and taken_row["hidden_reason"] == "NULL":
                twin = taken_row
        if overlap is not None and (twin is None or int(twin["id"]) == overlap[0]):
            owner = overlap[0]
            for seed in members:
                part = overlap[1].get(seed.pid)
                if part is None:
                    decide(
                        seed,
                        "keep",
                        f"같은 묶음의 다른 곡은 작품 {owner} 의 part 에 이었지만 이 곡은 맞는 part 가 없음",
                    )
                    continue
                key = PartKey(owner, part, None, None, "", null(part["name_en"]))
                link_seed(catalog, plan, seed, key, used, cid, "곡 이름이 같은 part")
            continue
        if twin is not None:
            for seed in members:
                decide(
                    seed,
                    "keep",
                    f"묶음 이름 「{head}」이 카탈로그 작품 {twin['id']} 「{twin['title']}」와"
                    " 같은 작품으로 보이나 part 가 맞지 않아 그대로 둠",
                )
            continue
        indexes = [s.index for s in members]
        multi = all(i is not None for i in indexes) and len(set(indexes)) == len(indexes)
        order = [] if multi else track_order(members)
        members.sort(
            key=lambda s: (
                s.index if s.index is not None else 9999,
                order.index(s.mbid) if s.mbid in order else 9999,
                s.rest,
                s.pid,
            )
        )
        title, catalogue = bundle_title(head, members)
        if title == head and found and found.get("type") in auto.MB_TYPE_KO:
            title = f"{auto.MB_TYPE_KO[found['type']]} <{plain}>"
        free = free_title(title, head, titles)
        if free is None:
            for seed in members:
                decide(seed, "keep", f"묶음 제목 「{title}」이 겹쳐 만들지 않음")
            continue
        titles.add(free)
        names = {s.pid: korean_name(s, multi) for s in members}
        work_key = f"{plan.slug}-p-{hashlib.sha1(head.encode()).hexdigest()[:8]}"
        mbid = str(found["id"]) if found and found["id"] not in catalog.taken else None
        work = bundle_work(plan, work_key, free, head, catalogue, members, multi, names, mbid)
        plan.works.append(work)
        plan.counts["new_bundles"] += 1
        why = f"MB 에 부모 관계가 없는 「{head}: …」 work {len(members)}개를 한 작품으로 묶음"
        if found:
            why += f" (같은 이름의 MB 작품 https://musicbrainz.org/work/{found['id']})"
        for seed in members:
            decide(
                seed,
                "bundle",
                why,
                bundle=free,
                newTitle=f'{free} 중 "{names[seed.pid]}"',
            )
        genre, form, _rule = genre_of(cid, free, head, catalogue, len(members))
        if genre:
            plan.genres.append(sqlparts.set_genre(cid, free, genre, form))
            work["genre"] = genre

    # 5. 낱개는 음반 묶음
    albums = os.environ.get("LEFTOVER_NO_ALBUMS") != "1"
    rg_of: dict[int, list[dict[str, Any]]] = {
        s.pid: release_groups(s) if albums else [] for s in singles
    }
    info: dict[str, dict[str, Any]] = {}
    for seed in singles:
        if seed.decision.get("generic") or auto.catalogue_tokens(
            seed.mb_title or seed.row["title"]
        ):
            # 작품번호가 있는 seed 는 따로 선 작품이라 음반으로 묶지 않는다(아이브스 연습곡 S. 90 …)
            continue
        for entry in sorted(rg_of[seed.pid], key=lambda e: (e["status"] != "Official", e["date"])):
            if set(entry["secondary"]) & SIDE_TYPES or COMPILATION_TITLE.search(entry["title"]):
                continue
            group = info.setdefault(entry["rg"], {**entry, "members": set()})
            group["members"].add(seed.pid)

    def rank(rgid: str) -> tuple[bool, int, str, str]:
        group = info[rgid]
        side = bool(set(group["secondary"]) & SIDE_TYPES)
        return (side, -len(group["members"]), group["date"], rgid)

    banned: set[str] = set()
    while True:
        assigned: dict[int, str] = {}
        for rgid in sorted((g for g in info if g not in banned), key=rank):
            for pid in info[rgid]["members"]:
                assigned.setdefault(pid, rgid)
        small = {g for g, n in Counter(assigned.values()).items() if n < 3}
        if not small:
            break
        banned |= small
    by_pid = {s.pid: s for s in singles}
    for rgid in sorted(set(assigned.values()), key=rank):
        group = info[rgid]
        members = [by_pid[pid] for pid, g in assigned.items() if g == rgid]
        order = album_order(group["release"], {s.mbid for s in members if s.mbid})
        members.sort(
            key=lambda s: (order.index(s.mbid) if s.mbid in order else 9999, s.mb_title, s.pid)
        )
        album = str(group["title"])
        free = free_title(album, album, titles) if album not in titles else None
        if free is None:
            free = free_title(f"{album} (음반)", album, titles)
        if free is None:
            for seed in members:
                decide(seed, "keep", f"음반 묶음 제목 「{album}」이 겹쳐 만들지 않음")
            continue
        titles.add(free)
        names = {}
        for seed in members:
            name = seed.mb_title or seed.row["title"]
            for sep in (":", " -", " \u2013", ","):
                if name.lower().startswith(album.lower() + sep):
                    name = name[len(album) + len(sep) :].strip()
                    break
            names[seed.pid] = name
        work_key = f"{plan.slug}-rg-{rgid[:8]}"
        work = bundle_work(plan, work_key, free, album, None, members, False, names)
        for part, seed in zip(work["parts"], members, strict=True):
            part["nameEn"] = names[seed.pid][:500]
        plan.works.append(work)
        plan.counts["new_albums"] += 1
        url = "https://musicbrainz.org/release-group/" + rgid
        for seed in members:
            decide(
                seed,
                "album",
                f"녹음이 같은 음반 「{album}」({url})에 실린 seed {len(members)}개를 음반 묶음으로",
                bundle=free,
                newTitle=f'{free} 중 "{names[seed.pid]}"',
            )

    for seed in singles:
        if "action" not in seed.decision:
            why = "MB 에 부모 작품이 없고 같은 이름·같은 음반으로 묶을 seed 가 없음"
            if not seed.head:
                why = "콜론 없는 낱곡(따로 선 작품)이라 그대로 둠"
            if not seed.mbid:
                why = "MusicBrainz 식별자가 없음"
            decide(seed, "keep", why)
    for seed in rest:
        if "action" not in seed.decision:
            decide(seed, "keep", "판단 보류")
    for seed in seeds:
        plan.counts[seed.decision.get("action", "dup")] += 1
    return plan


def composer_sql(catalog: Catalog, plan: ComposerPlan) -> str:
    rows = catalog.by_composer[plan.cid]
    ctx = gen.Context(
        composer_id=plan.cid,
        slug=plan.slug,
        existing={int(r["id"]): r for r in rows},
        existing_titles=gen.titles_by_piece(rows),
        taken=catalog.taken,
    )
    blocks: list[str] = []
    titles: set[str] = set()
    for work in plan.works:
        block = gen.work_block(ctx, work, titles)
        if block:
            blocks.append("\n".join(block))
    if ctx.errors:
        raise SystemExit(f"{plan.name}: " + "; ".join(ctx.errors))
    head = (
        f"-- ===== {plan.name} (composer_id {plan.cid}) =====\n"
        f"-- 잇기 {plan.counts['link']}, 새 묶음 {plan.counts['new_bundles']}(이름)"
        f" + {plan.counts['new_albums']}(음반), 숨김 {sum(len(v) for v in plan.hide.values())},"
        f" 그대로 {plan.counts['keep']}\n"
    )
    out = [head]
    if plan.links:
        out.append("-- 카탈로그 part 에 잇기\n" + "\n".join(plan.links))
    out.extend(blocks)
    if plan.genres:
        out.append(
            "-- 새 묶음 갈래·형식(4차 이후 형식 규칙 classify.py)\n" + "\n".join(plan.genres)
        )
    for why, ids in plan.hide.items():
        out.append(sqlparts.hide(plan.cid, ids, why))
    return "\n".join(part for part in out if part) + "\n"


HEADER = """-- 남은 원어 seed 정리({index}/{total}). 작곡가 {composers}명, seed {seeds}개:
-- 잇기 {link}, 묶음 안 곡 {bundled}(이름 묶음 {bundles}·음반 묶음 {albums}), 숨김 {hidden}, 그대로 {kept}.
--
-- 4·5·6차 자동 카탈로그가 판단하지 못한 seed(origin=seed, 잠기지 않음, 숨기지 않음)다. 대부분
-- 「Antigonae: I. …」처럼 MusicBrainz 에서 부모 작품 관계가 없는 악장·대목 work 라 목록 맨 위에 낱곡으로
-- 흩어져 보였다. 결정과 근거는 {folder}/decisions.jsonl, 규칙은 tools/leftover.py.
--   잇기: 카탈로그 작품의 part 와 같은 곡(MB 제목이 같거나, 작품번호가 겹치고 악장 번호·이름이 같음)이면
--     그 part 에 잇고 제목을 「<작품> 중 "<곡>"」으로 바꾼다. part 가 이미 다른 작품을 가리키면 숨긴다.
--   이름 묶음: 콜론 앞 이름이 같은 seed 가 둘 이상이면 그 이름으로 작품(manual, 묶음)을 새로 만들고
--     seed 를 그 안 곡으로 잇는다. 제목은 seed 의 우리말 제목 앞부분, 없으면 4차 제목 규칙.
--   음반 묶음: 낱개 seed 는 녹음이 실린 MB 음반이 같은 것끼리 셋 이상이면 음반 이름으로 묶는다
--     (모음집·실황·전집 음반과 작품번호가 있는 seed 는 빼고).
--   숨김: hidden_reason='catalog_unmatched'(지우지 않음). 비교 구간이 있거나 part 가 가리키면 숨기지 않는다.
--   두 번 넣어도 같다.
"""


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--db", required=True)
    parser.add_argument("--dup-decisions", required=True)
    parser.add_argument("--dup-gen", required=True)
    parser.add_argument("--out", required=True)
    parser.add_argument("--migrations", required=True)
    parser.add_argument("--first", type=int, required=True)
    parser.add_argument("--per-file", type=int, default=25)
    args = parser.parse_args()

    catalog = Catalog(args.db)
    rows = catalog.leftover()
    with open(args.dup_decisions, encoding="utf-8") as handle:
        dup_groups: list[dict[str, Any]] = json.load(handle)
    dup_of = {h["id"]: g for g in dup_groups for h in g["hide"]}
    seeds = [load_seed(catalog, row) for row in rows]
    all_ids = {s.pid for s in seeds}
    for seed in seeds:
        if seed.pid in dup_of:
            group = dup_of[seed.pid]
            decide(
                seed,
                "duplicate",
                group["evidence"],
                keep=group["keep"]["id"],
            )
    missing = [pid for pid in dup_of if pid not in all_ids]
    if missing:
        raise SystemExit(f"dup_decisions 의 숨길 작품이 남은 seed 가 아님: {missing}")

    by_composer: dict[int, list[Seed]] = defaultdict(list)
    for seed in seeds:
        by_composer[seed.cid].append(seed)
    plans = [
        plan_composer(catalog, cid, members, set(dup_of), all_ids)
        for cid, members in sorted(by_composer.items())
    ]

    os.makedirs(args.out, exist_ok=True)
    with open(os.path.join(args.out, "decisions.jsonl"), "w", encoding="utf-8") as handle:
        for seed in sorted(seeds, key=lambda s: (s.cid, s.pid)):
            record = {
                "pieceId": seed.pid,
                "composerId": seed.cid,
                "title": seed.row["title"],
                "titleEn": null(seed.row["title_en"]),
                "mbid": seed.mbid,
                **seed.decision,
            }
            handle.write(json.dumps(record, ensure_ascii=False) + "\n")
    for plan in plans:
        if plan.works:
            folder = os.path.join(args.out, "catalog")
            os.makedirs(folder, exist_ok=True)
            with open(os.path.join(folder, f"{plan.slug}.json"), "w", encoding="utf-8") as handle:
                json.dump(plan.works, handle, ensure_ascii=False, indent=1)

    dup_gen = mbwork.load("duplicate_gen_sql", args.dup_gen)
    dup_lines = [
        "-- 남은 원어 seed 가운데 같은 작품이 이미 손 작품으로 있는 것을 숨기고 남길 작품으로 합친다"
        f"(묶음 {len(dup_groups)}개).\n"
        f"-- 근거: {FOLDER}/dup_decisions.json. 본문은 duplicate-pieces-2026-11-11/gen_sql.py 와 같다:\n"
        "--   hidden_reason='duplicate'(지우지 않음), 숨긴 뒤 그 작품을 가리키던 행을 남길 작품으로 옮기고\n"
        "--   남길 작품의 빈 칸(설명·링크·연도)을 채운다. 비교 구간이 있거나 part 가 가리키면 숨기지 않는다.\n"
        "--   두 번 넣어도 같다.\n"
    ]
    for group in dup_groups:
        keep = group["keep"]
        hidden = ", ".join(f"{h['id']} 「{h['title']}」" for h in group["hide"])
        dup_lines.append(
            f"\n-- {group['composer']}: {keep['id']} 「{keep['title']}」 ← {hidden}\n"
            f"-- {group['evidence']}"
        )
        for hide in group["hide"]:
            dup_lines.append(dup_gen.hide_statement(group, hide))
            dup_lines.extend(dup_gen.move_statements(group, hide))
            dup_lines.extend(dup_gen.fill_statements(group, hide))
    first_path = os.path.join(args.migrations, f"{args.first}_merge_leftover_seed_duplicates.sql")
    with open(first_path, "w", encoding="utf-8") as handle:
        handle.write("\n".join(dup_lines) + "\n")
    print(os.path.basename(first_path), len(dup_of))

    busy = [p for p in plans if p.links or p.works or p.hide]
    chunks = [busy[i : i + args.per_file] for i in range(0, len(busy), args.per_file)]
    for index, chunk in enumerate(chunks):
        totals: Counter[str] = Counter()
        bodies = []
        for plan in chunk:
            totals.update(plan.counts)
            totals["hidden_rows"] += sum(len(v) for v in plan.hide.values())
            bodies.append(composer_sql(catalog, plan))
        bundled = sum(
            1
            for plan in chunk
            for seed in by_composer[plan.cid]
            if seed.decision.get("action") in ("bundle", "album")
        )
        header = HEADER.format(
            index=index + 1,
            total=len(chunks),
            composers=len(chunk),
            seeds=sum(len(by_composer[p.cid]) for p in chunk),
            link=totals["link"],
            bundled=bundled,
            bundles=totals["new_bundles"],
            albums=totals["new_albums"],
            hidden=totals["hidden_rows"],
            kept=totals["keep"],
            folder=FOLDER,
        )
        path = os.path.join(
            args.migrations,
            f"{args.first + 1 + index}_organize_leftover_seeds_{index + 1:02d}.sql",
        )
        with open(path, "w", encoding="utf-8") as handle:
            handle.write(header + "\n" + "\n".join(bodies))
        print(os.path.basename(path), dict(totals))
    actions = Counter(s.decision.get("action") for s in seeds)
    print(json.dumps(dict(actions), ensure_ascii=False))


if __name__ == "__main__":
    main()
