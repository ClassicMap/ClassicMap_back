"""세트 안 곡(최상위 part)에 Apple Music(또는 Spotify, --column spotify_url) 트랙 링크를 붙인다.

작품에 이미 붙은 Apple Music 앨범 링크의 트랙 목록(iTunes Lookup, 공개)을 받아, 세트 안 곡마다
그 곡을 가리키는 트랙을 찾는다. 이름만 비슷한 트랙을 붙이지 않도록 아래 규칙 중 하나에 맞을 때만
붙이고, 한 트랙이 두 곡에 걸리면 둘 다 버린다.

1. 번호: 트랙 이름에 세트 작품번호 바로 뒤 No. N(또는 /N)이 있다(「Études Op. 25 No. 1」).
2. 번호 범위: 세트 작품번호가 범위(BWV 1007-1012)이고 곡 수와 같으면, N번째 곡은 범위의
   N번째 번호(BWV 1007)가 트랙에 있다.
3. 악장: 세트가 악장으로 나뉜 작품이면 트랙에 작품번호와 로마 숫자 N 이 있다(「Op. 58: I.」).
4. 이름: 곡 이름(원어, 따옴표 안 가사 첫 줄, 앞 No. N 을 뗀 영문 이름 중 하나)이 흔한
   빠르기·조성 말이 아니고 트랙 이름에 들어 있으며, 그런 트랙이 하나뿐이다
   (「5 Lieder, Op. 47: No. 1, Botschaft」,
   「Johannes-Passion, BWV 245, Pt. 1: No. 1, Chor. "Herr, unser Herrscher"」).
5. 곡 부분 이름: 트랙 이름의 마지막 「:」 뒤(곡 부분)와 곡 이름(빠르기말을 뗀 것도)이
   서로 들어 있고, 그런 트랙이 하나뿐이다(「…, Op. 22: Andante spianato」, 「…: Grande Polonaise」).
6. 순서: 작품번호가 든 트랙 수가 곡 수와 같고, 트랙에 적힌 번호가 순서와 어긋나지 않고,
   곡 이름이 순서상 짝이 아닌 다른 트랙에서 보이지 않으면 앨범 순서대로 붙인다
   (「K. 550: 1. Molto Allegro」). 앨범이 세트 일부만 담았거나 순서가 다르면 이렇게 걸러진다.
   앞 규칙으로 붙은 곡이 그 순서와 어긋나면 이 세트에는 쓰지 않는다.
같은 곡에 맞는 트랙이 여럿이면(다악장 곡, 같은 곡 두 번) 앨범 순서로 첫 트랙을 붙인다.
번호가 우리와 앨범에서 다르게 매겨진 경우를 거르려고, 곡과 트랙에 조성이 둘 다 있으면 같아야 하고
악장(또는 원어 이름이 있는 곡)은 곡 이름과 트랙 이름의 첫 낱말 중 하나가 다른 쪽에 있어야 한다.
곡 이름의 따옴표 가사가 다른 트랙 하나에만 있으면 번호·악장으로 찾은 트랙은 버린다.

--nested 를 주면 곡 안 곡(「소나타 1번 → 1~4악장」)만 붙인다(match_children). 안에 곡이 있는 곡마다
그 곡의 트랙을 먼저 가려낸다(이 곡만 가진 작품번호 「RV 27」, 세트 작품번호 + 번호 「Op. 2, No. 1」,
이름의 「Wq. 183 no. 1」 순). 가려낸 트랙이 형제 곡과 겹치거나 조성이 다르면 그 곡은 건너뛴다.
그 트랙 안에서 위 규칙으로 곡 안 곡을 붙이고, 안에 곡이 있는 곡의 링크가 비었으면 첫 곡 트랙을 준다.

운영 DB 에 직접 쓰지 않는다. 결과는 matches.jsonl 과 마이그레이션 SQL 로만 낸다.
사용: python3 match.py --parts <parts.tsv> --raw <트랙 JSON 폴더> --out <폴더> --migration <SQL>
"""

from __future__ import annotations

import argparse
import csv
import json
import os
import re
import unicodedata
from collections import Counter, defaultdict
from typing import Any

ROMAN = ["", "i", "ii", "iii", "iv", "v", "vi", "vii", "viii", "ix", "x", "xi", "xii"]
# 이름 규칙에서 곡을 가려 주지 못하는 말(빠르기·조성·형식 이름)
GENERIC = re.compile(
    r"\b(allegro|allegretto|andante|andantino|adagio|largo|lento|presto|prestissimo|vivace|moderato|"
    r"maestoso|grave|scherzo|menuet|minuet|menuetto|trio|finale|rondo|prelude|praeludium|fugue|fuga|"
    r"theme|variation|variations|aria|recitative|chorale|sinfonia|overture|intermezzo|etude|study|"
    r"major|minor|flat|sharp|in|no|op|and|the|of|a|b|c|d|e|f|g|ma|non|troppo|molto|con|assai|"
    r"sostenuto|cantabile|espressivo|poco|piu|tempo|di|e)\b"
)
# 트랙 이름의 작품번호(「Op. 18」「BWV 1052」「D. 944」)
CATALOGUE_TOKEN = re.compile(r"\b(op|opus|bwv|kv?|hob|hwv|rv|wab|sz|bb|fwv|woo|trv|d)\.?\s*(\d+)")
# 발췌 음반 표시(norm 한 이름에서). 단수 「extrait de」는 「…에서」라 뺀다
EXCERPT = re.compile(r"\b(?:excerpts?|highlights?|auszug|auszuge|ausschnitte|extraits)\b")
# 막·부 전체인 곡 이름(「3막」「Act III」「Part 2」)
WHOLE_SECTION = re.compile(
    r"^\s*(?:\d+\s*막|\d+\s*부|(?:act|acte|akt|part)\s+[ivx\d]+)\s*$", re.IGNORECASE
)


def norm(text: str) -> str:
    text = unicodedata.normalize("NFKD", text or "")
    text = "".join(c for c in text if not unicodedata.combining(c)).lower()
    text = (
        text.replace("♭", " flat")
        .replace("♯", " sharp")
        .replace("\u2013", "-")
        .replace("\u2014", "-")
    )
    return " ".join(re.sub(r"[^a-z0-9#/:,.\- ]", " ", text).split())


KEY_KO = re.compile(r"([A-G])\s*(♭|#|♯)?\s*(장조|단조)")
KEY_EN = re.compile(r"\b([a-g])(?:\s*-?\s*(flat|sharp|#))?\s+(major|minor)\b")
LEAD = re.compile(r"^.*?(?:\b[ivxl]+\.\s+|:\s*(?:no\.?\s*\d+[.,]?\s*)?)")


def key_of(text: str) -> tuple[str, str, str] | None:
    """이름의 마지막 조성(으뜸음, 올림·내림, 장·단조)."""
    found = KEY_KO.findall(text)
    if found:
        letter, accidental, mode = found[-1]
        sign = {"♭": "flat", "#": "sharp", "♯": "sharp"}.get(accidental, "")
        return (letter.lower(), sign, "major" if mode == "장조" else "minor")
    found_en = KEY_EN.findall(norm(text))
    if found_en:
        letter, accidental, mode = found_en[-1]
        return (letter, "sharp" if accidental == "#" else accidental, mode)
    return None


def words(text: str) -> list[str]:
    """뜻 있는 낱말의 앞 다섯 글자(Introduction·Introducción 을 같게 본다)."""
    plain = re.sub(r"[^a-z ]", " ", norm(text))
    return [w[:5] for w in plain.split() if len(w) >= 4 and w not in {"major", "minor", "flat"}]


def same_lead(name: str, track: str) -> bool:
    """곡 이름과 트랙의 곡 부분(로마 숫자·No. 뒤) 첫 낱말 중 하나가 다른 쪽에 있다."""
    mine, theirs = words(name), words(LEAD.sub("", norm(track)))
    if not mine or not theirs:
        return True
    return mine[0] in theirs or theirs[0] in mine


def catalogue_regex(label: str) -> str | None:
    """「Op. 25」「K. 331」「Op. 10, No. 12」을 트랙 이름(norm)에서 찾는 정규식. 범위는 None."""
    text = norm(label)
    if not text or re.search(r"\d\s*-\s*\d", text):
        return None
    pieces = re.findall(r"([a-z]+)\.?\s*(\d+[a-z]?)", text)
    if not pieces:
        return None
    body = r"[\s,.:]*".join(rf"{re.escape(word)}\.?\s*{re.escape(num)}" for word, num in pieces)
    return rf"\b{body}(?![\d])"


def bare_tracks(track_names: list[str], title_en: str, catalogue: str) -> bool:
    """트랙 이름(norm)에 다른 작품번호도, 작품과 다른 번호(「Piano Concerto No. 2: …」)도 없다.

    악장 이름뿐인 앨범을 작품 트랙으로 볼 때 쓴다. 두 작품이 든 앨범에서 다른 작품 트랙만
    받아 둔 경우(협주곡 1번 앨범에 2번 트랙만)를 거른다. 작품 자신의 번호 일부
    (「Op. 104, B. 191」의 「Op. 104」)는 괜찮다.
    """
    own = {(word, num) for word, num in re.findall(r"([a-z]+)\.?\s*(\d+)", norm(catalogue))}
    # 번호 매기는 법이 여럿이라(「Quintet no. 52 … op. 29/4」 ↔ 트랙 「String Quintet No. 4」)
    # 제목·작품번호의 어느 숫자와도 다를 때만 다른 작품으로 본다
    numbers = set(re.findall(r"\d+", norm(f"{title_en} {catalogue}")))
    for name in track_names:
        if any((m.group(1), m.group(2)) not in own for m in CATALOGUE_TOKEN.finditer(name)):
            return False
        lead = name.split(":", 1)[0] if ":" in name else ""
        number = re.search(r"\bno\.?\s*(\d+)", lead)
        if number and number.group(1) not in numbers:
            return False
    return True


def catalogue_range(label: str) -> tuple[str, int, int] | None:
    m = re.fullmatch(r"([a-z]+)\.?\s*(\d+)\s*-\s*(\d+)", norm(label))
    return (m.group(1), int(m.group(2)), int(m.group(3))) if m else None


QUOTED = re.compile(
    r"[\"\u201c\u201e\u00ab]\s*([^\"\u201c\u201d\u00bb]+?)\s*[\"\u201d\u201c\u00bb]"
)


def original_name(part: dict[str, str]) -> str:
    """곡 이름의 원어. 「헌정 (Widmung)」이면 괄호 안, 아니면 영문 이름."""
    m = re.search(r"\(([^()]*[A-Za-z][^()]*)\)\s*$", part["name_ko"])
    return m.group(1) if m else part["name_en"]


def name_candidates(part: dict[str, str]) -> list[str]:
    """이름 규칙에 쓸 원어 이름들: 원어 이름, 따옴표 안 가사, 앞 「No. 1」을 뗀 영문 이름 순."""
    found = [original_name(part)]
    for text in (part["name_ko"], part["name_en"]):
        found += [m.group(1) for m in QUOTED.finditer(text)]
    found.append(re.sub(r"^\s*(?:no|nr)\.?\s*\d+[a-z]?[.,:]?\s+", "", part["name_en"], flags=re.I))
    return list(dict.fromkeys(name for name in found if name.strip()))


def distinctive(name: str) -> str | None:
    text = norm(name)
    rest = re.sub(r"[^a-z ]", " ", GENERIC.sub(" ", text))
    return text if len("".join(rest.split())) >= 5 else None


def tail_of(track_name: str) -> str:
    """트랙 이름의 곡 부분: 마지막 「:」 뒤에서 앞 번호(「1.」「No. 2」「II.」)를 뗀 것."""
    tail = norm(track_name).rsplit(":", 1)[-1]
    return re.sub(r"^\s*(?:(?:no|nr)\.?\s*)?(?:\d+[a-z]?|[ivxl]+)[.,]?\s+", "", tail).strip()


ROMAN_VALUE = {"i": 1, "v": 5, "x": 10, "l": 50}


def index_of(track_name: str) -> int | None:
    """트랙 곡 부분 앞의 번호(「No. 19, …」「II. …」「3. …」). 없으면 None."""
    text = norm(track_name)
    tail = text.rsplit(":", 1)[-1].strip()
    m = re.match(r"(?:(?:no|nr)\.?\s*(\d+)|(\d+)[.,)]\s|([ivxl]+)\.\s)", tail)
    if not m:
        # 「Op. 35 No. 9: Andante」처럼 번호가 곡 부분 앞에 있는 트랙
        numbers = re.findall(r"\b(?:no|nr)\.?\s*(\d+)\b", text)
        return int(numbers[-1]) if numbers else None
    if m.group(1) or m.group(2):
        return int(m.group(1) or m.group(2))
    total = 0
    values = [ROMAN_VALUE[c] for c in m.group(3)]
    for i, value in enumerate(values):
        total += -value if i + 1 < len(values) and value < values[i + 1] else value
    return total


def short_candidates(part: dict[str, str]) -> list[str]:
    """곡 이름들과, 첫 「. 」 앞에서 자른 것(뒤 빠르기말을 뗀다)."""
    found = []
    for name in name_candidates(part):
        found.append(name)
        cut = re.split(r"\.\s", name, maxsplit=1)[0]
        if cut != name:
            found.append(cut)
    return list(dict.fromkeys(found))


def tracks_of(raw: str, album: str) -> list[dict[str, Any]]:
    path = f"{raw}/{album}.json"
    if not os.path.exists(path):
        return []
    with open(path, encoding="utf-8") as handle:
        results = json.load(handle).get("results", [])
    tracks = [r for r in results if r.get("wrapperType") == "track" and r.get("trackViewUrl")]
    return sorted(tracks, key=lambda r: (r.get("discNumber") or 0, r.get("trackNumber") or 0))


def track_url(track: dict[str, Any]) -> str:
    return re.sub(r"&uo=\d+$", "", str(track["trackViewUrl"]))


def match_set(
    rows: list[dict[str, str]], tracks: list[dict[str, Any]], cat_pattern: str | None = None
) -> dict[int, tuple[str, str, str]]:
    """세트 하나의 곡마다 (트랙 링크, 트랙 이름, 규칙).

    cat_pattern 을 주면 세트 작품번호 대신 그 정규식을 작품번호로 본다(곡 안 곡: 「Op. 2, No. 1」).
    """
    head = rows[0]
    names = [norm(str(t.get("trackName", ""))) for t in tracks]
    cat = cat_pattern or catalogue_regex(head["catalogue"])
    span = None if cat_pattern else catalogue_range(head["catalogue"])
    movement = all(r["movement"].strip() for r in rows)
    picked: dict[int, tuple[int, str]] = {}
    for row in rows:
        n = int(row["seq"])
        found: list[int] = []
        rule = ""
        if cat and not movement:
            pattern = re.compile(rf"{cat}[\s,.:;]*(?:(?:no|nr|n|#)\.?\s*|/\s*){n}(?![\d])")
            found, rule = [i for i, t in enumerate(names) if pattern.search(t)], "number"
        if not found and span and span[2] - span[1] + 1 == len(rows):
            pattern = re.compile(rf"\b{span[0]}\.?\s*{span[1] + n - 1}(?![\d])")
            found, rule = [i for i, t in enumerate(names) if pattern.search(t)], "range"
        if not found and movement and cat and n < len(ROMAN):
            pattern = re.compile(rf"(?:^|[:\-]\s*|\.\s)({ROMAN[n]})\.\s")
            found = [i for i, t in enumerate(names) if re.search(cat, t) and pattern.search(t)]
            rule = "movement"
        for candidate in [] if found else name_candidates(row):
            name = distinctive(candidate)
            if not name:
                continue
            hits = [i for i, t in enumerate(names) if name in t and (not cat or re.search(cat, t))]
            if len(hits) == 1:
                found, rule = hits, "name"
                break
        if not found:
            tails = [tail_of(str(t.get("trackName", ""))) for t in tracks]
            for candidate in short_candidates(row):
                name = distinctive(candidate)
                if not name:
                    continue
                hits = [
                    i
                    for i, tail in enumerate(tails)
                    if distinctive(tail)
                    and (name in tail or tail in name)
                    and (not cat or re.search(cat, names[i]))
                ]
                if len(hits) == 1:
                    found, rule = hits, "tail"
                    break
        mine_key = key_of(row["name_ko"]) or key_of(row["name_en"])
        name = original_name(row)
        # 번호로 찾았는데 따옴표 가사가 다른 트랙 하나에만 있으면 번호가 어긋난 것이다
        elsewhere = set()
        for lyric in (
            m.group(1) for text in (row["name_ko"], row["name_en"]) for m in QUOTED.finditer(text)
        ):
            lyric_norm = distinctive(lyric)
            hits = [i for i, t in enumerate(names) if lyric_norm and lyric_norm in t]
            if len(hits) == 1:
                elsewhere.add(hits[0])
        checked = []
        for index in found:
            theirs = key_of(str(tracks[index].get("trackName", "")))
            if mine_key and theirs and mine_key != theirs:
                continue
            if elsewhere and index not in elsewhere:
                continue
            check_lead = rule == "movement" or (rule == "number" and distinctive(name))
            if check_lead and re.search(r"[A-Za-z]", name) and not same_lead(name, names[index]):
                continue
            checked.append(index)
        if checked:
            picked[int(row["part_id"])] = (checked[0], rule)
    if cat and len(picked) < len(rows):
        work = [i for i, t in enumerate(names) if re.search(cat, t)]
        ordered = sorted(rows, key=lambda r: int(r["seq"]))
        # 트랙에 적힌 번호가 우리 순서와 하나라도 다르면 앨범이 세트 일부만 담은 것이다
        numbered = [
            (int(r["seq"]), index_of(str(tracks[index].get("trackName", ""))))
            for r, index in zip(ordered, work, strict=False)
        ]
        # 곡 이름이 순서상 짝이 아닌 다른 트랙의 곡 부분에 있으면 앨범과 순서가 다른 것이다
        work_tails = {index: tail_of(str(tracks[index].get("trackName", ""))) for index in work}

        def elsewhere_hit(row: dict[str, str], index: int) -> bool:
            for candidate in short_candidates(row):
                name = distinctive(candidate)
                if not name:
                    continue
                hits = {
                    i
                    for i, tail in work_tails.items()
                    if distinctive(tail) and (name in tail or tail in name)
                }
                if hits and index not in hits:
                    return True
            return False

        if (
            len(work) == len(rows)
            and not any(elsewhere_hit(r, index) for r, index in zip(ordered, work, strict=True))
            and all(found is None or found == seq for seq, found in numbered)
            and all(
                picked.get(int(r["part_id"]), (index, ""))[0] == index
                for r, index in zip(ordered, work, strict=True)
            )
        ):
            for row, index in zip(ordered, work, strict=True):
                part_id = int(row["part_id"])
                if part_id in picked:
                    continue
                mine_key = key_of(row["name_ko"]) or key_of(row["name_en"])
                theirs = key_of(str(tracks[index].get("trackName", "")))
                if mine_key and theirs and mine_key != theirs:
                    continue
                picked[part_id] = (index, "order")
    # 트랙 이름이 악장 이름뿐인 앨범("I. Allegretto"): 앨범 이름에 작품번호가 있고
    # 트랙 수가 곡 수와 같을 때만 순서대로 붙인다
    album = norm(str(tracks[0].get("collectionName", ""))) if tracks else ""
    if (
        cat
        and not picked
        and len(tracks) == len(rows)
        and re.search(cat, album)
        and not any(re.search(cat, t) for t in names)
        and bare_tracks(names, head["title_en"], head["catalogue"])
    ):
        ordered = sorted(rows, key=lambda r: int(r["seq"]))
        indexes = [index_of(str(t.get("trackName", ""))) for t in tracks]
        if all(
            found is None or found == int(r["seq"])
            for r, found in zip(ordered, indexes, strict=True)
        ):
            for index, row in enumerate(ordered):
                mine_key = key_of(row["name_ko"]) or key_of(row["name_en"])
                theirs = key_of(str(tracks[index].get("trackName", "")))
                if mine_key and theirs and mine_key != theirs:
                    continue
                picked[int(row["part_id"])] = (index, "album")
    # 막·부 전체인 곡에 발췌 트랙 한 곡을 붙이지 않는다
    # (「3막」 ← 「Henry VIII, R. 291, Act III (Excerpts): Marche du Synode」)
    whole = {
        int(r["part_id"])
        for r in rows
        if WHOLE_SECTION.match(r["name_ko"]) or WHOLE_SECTION.match(r["name_en"])
    }
    for part_id, (index, _) in list(picked.items()):
        if part_id in whole and EXCERPT.search(names[index]):
            del picked[part_id]
    # 한 트랙이 두 곡에 걸리면 어느 쪽인지 모르므로 둘 다 버린다
    used = Counter(index for index, _ in picked.values())
    return {
        part_id: (track_url(tracks[index]), str(tracks[index].get("trackName", "")), rule)
        for part_id, (index, rule) in picked.items()
        if used[index] == 1
    }


# 곡 이름에 적힌 자기 작품번호(「RV 27」「G. 283」「Hob. III:75」).
# 체계 이름 바로 뒤에 숫자가 와야 한다
OWN_TOKEN = re.compile(
    r"\b(op|opus|bwv|kv?|hob|hwv|rv|wab|sz|bb|fwv|woo|trv|wq|twv|lwv|zwv|ms|fp|kk|[dhgblms])"
    r"\.?\s*((?:[ivx]+\s*:\s*)?\d+[a-z]?)(?![\d])"
)
# 곡 이름의 「Wq. 183 no. 1」「op. 18 no. 1」「op. 59 n 2」(norm 한 것)
OWN_NUMBERED = re.compile(
    r"\b(op|opus|wq|hob|bwv|hwv|rv|kv?)\.?\s*(\d+)[\s,.:;]*(?:no|nr|n|#)\.?\s*(\d+)\b"
)
LEAD_NUMBER = re.compile(r"^\s*(?:no|nr)\.?\s*(\d+)\b")
# 막·부·권·장면(「Act I」「Première partie」「Volume II」「Tableau I」).
# 트랙에서는 같은 갈래의 다른 말로도 찾는다
SECTION_WORDS = {
    "act": r"act|acte|akt|atto|aufzug",
    "part": r"part|partie|teil|pt|parte",
    "book": r"book|bk|volume|vol|livre|heft|band",
    "tableau": r"tableau|bild",
}
ORDINALS = {
    "1": r"first|premiere|erster|erste|prima|primo",
    "2": r"second|seconde|deuxieme|zweiter|zweite|seconda|secondo",
    "3": r"third|troisieme|dritter|dritte|terza|terzo",
}
ROMAN_NUMBER = {roman: str(i) for i, roman in enumerate(ROMAN) if roman}
# 곡 이름 앞 「a. 」「b. 」(한 부 안의 곡 순서)
LETTER_LEAD = re.compile(r"^\s*[a-z]\.\s+")
# 이름 끝 괄호(출연자 목록)
CAST = re.compile(r"\s*\([^()]*\)\s*$")
# 곡 이름의 자기 번호: 맨 앞이나 마지막 「:」 뒤의 「No. 3」(「No. 2e」처럼 글자가 붙으면 뺀다)
NAME_NUMBER = re.compile(r"(?:^|:\s*)(?:no|nr)\.?\s*(\d+)\b(?![^:]*:)")
ROMAN_LEAD = re.compile(r"(?:^|:\s*)([IVXL]+)\.\s")


def token_regex(system: str, number: str) -> str:
    system = "kv?" if system in {"k", "kv"} else "op(?:us)?" if system in {"op", "opus"} else system
    number = re.sub(r"\s*:\s*", r"\\s*:\\s*", re.escape(number).replace("\\ ", " "))
    return rf"\b{system}\.?\s*{number}(?![\d])"


def own_tokens(name: str) -> set[tuple[str, str]]:
    found = set()
    for m in OWN_TOKEN.finditer(norm(name)):
        system = {"kv": "k", "opus": "op"}.get(m.group(1), m.group(1))
        found.add((system, re.sub(r"\s+", "", m.group(2))))
    return found


def work_patterns(
    part: dict[str, str], siblings: list[dict[str, str]], set_catalogue: str
) -> list[str]:
    """곡 안 곡을 가진 곡(「No. 1: Violin Sonata in G minor, RV 27」)의 트랙을 가려낼 정규식들.

    앞이 먼저다.

    1. 이 곡만 가진 작품번호(형제 곡에 없는 「RV 27」「H. 663」)
    2. 세트 작품번호 + 순서 또는 이름의 번호(「Op. 2, No. 1」)
    3. 이름의 「Wq. 183 no. 1」
    """
    names = (part["name_en"], part["name_ko"])
    mine = own_tokens(" ".join(names))
    others: set[tuple[str, str]] = set()
    for sibling in siblings:
        if sibling["part_id"] != part["part_id"]:
            others |= own_tokens(f"{sibling['name_en']} {sibling['name_ko']}")
    # 세트 작품번호(「Op. 59」)는 어느 곡 이름에 있어도 그 곡만의 번호가 아니다
    others |= own_tokens(set_catalogue)
    patterns = [token_regex(system, number) for system, number in sorted(mine - others)]
    cat = catalogue_regex(set_catalogue) if set_catalogue else None
    if cat:
        numbers = [part["seq"]]
        lead = LEAD_NUMBER.match(norm(part["name_en"]))
        if lead and lead.group(1) not in numbers:
            numbers.append(lead.group(1))
        patterns += [
            rf"{cat}[\s,.:;]*(?:(?:no|nr|n|#)\.?\s*|/\s*){number}(?![\d])" for number in numbers
        ]
    for m in OWN_NUMBERED.finditer(norm(part["name_en"])):
        system = {"kv": "k", "opus": "op"}.get(m.group(1), m.group(1))
        token = token_regex(system, m.group(2))
        patterns.append(rf"{token}[\s,.:;]*(?:no|nr|n|#)\.?\s*{m.group(3)}(?![\d])")
        # 「Sonatina No. 1 for oboe d'amore…, Op. 194:」처럼 번호가 작품번호 앞에 온 트랙
        patterns.append(rf"^[^:]*\b(?:no|nr)\.?\s*{m.group(3)}(?![\d])[^:]*{token}")
    # 작품번호 범위의 N번째(「BWV 1007-1012」의 1번째 = BWV 1007). 맨 위 곡 수와 범위가 같을 때만
    span = catalogue_range(set_catalogue) if set_catalogue else None
    if span and span[2] - span[1] + 1 == len(siblings):
        patterns.append(token_regex(span[0], str(span[1] + int(part["seq"]) - 1)))
    # 이름의 「Brandenburg Concerto No. 1」(조성·콜론 앞)
    phrase = re.split(
        r"\s+in\s+[a-g](?:[\s-]*(?:flat|sharp))?\s+(?:major|minor)|[:,(]", norm(part["name_en"])
    )[0]
    if re.search(r"[a-z]{4}.*\bno\.?\s*\d+\s*$", phrase.strip()):
        body = re.escape(phrase.strip()).replace(r"no\.", r"no\.?").replace("\\ ", r"\s*")
        patterns.append(rf"{body}(?![\d])")
    # 「No. 4 "Da versammelten…"」: 세트 작품번호 뒤 콜론·쉼표 다음의 No. 4
    lead = LEAD_NUMBER.match(norm(part["name_en"]))
    if cat and lead:
        patterns.append(rf"{cat}.*?[:,/]\s*(?:no|nr)\.?\s*{lead.group(1)}(?![\d])")
        # 「Sonate di Lucca, Op. 3, MS 133, Sonata No. 2:」
        patterns.append(rf"{cat}[^:]*?\b(?:no|nr)\.?\s*{lead.group(1)}(?![\d])")
        # 「Duetto No. 6 for Violin and Guitar, MS 110:」
        patterns.append(rf"^[^:]*\b(?:no|nr)\.?\s*{lead.group(1)}(?![\d])[^:]*{cat}")
    # 막·부·권·장면
    for kind, words in SECTION_WORDS.items():
        found = re.search(rf"\b(?:{words})\.?\s*([ivx]+|\d+)(?![\w])", norm(part["name_en"]))
        number = ROMAN_NUMBER.get(found.group(1), found.group(1)) if found else None
        if kind == "part" and not number:
            ordinal = re.search(
                rf"\b({'|'.join(ORDINALS.values())})\s+(?:{words})\b", norm(part["name_en"])
            )
            number = next(
                (n for n, w in ORDINALS.items() if ordinal and re.fullmatch(w, ordinal.group(1))),
                None,
            )
        if not number:
            continue
        options = [number] + ([ROMAN[int(number)]] if int(number) < len(ROMAN) else [])
        alternatives = [rf"\b(?:{words})\.?\s*(?:{'|'.join(options)})(?![\w])"]
        if number in ORDINALS:
            alternatives.append(rf"\b(?:{ORDINALS[number]})\s+(?:{words})\b")
        patterns.append("(?:" + "|".join(f"(?:{a})" for a in alternatives) + ")")
    return list(dict.fromkeys(patterns))


def with_movement(row: dict[str, str]) -> dict[str, str]:
    """곡 안 곡을 맞추기 좋게 고친 행(match_set 에만 쓰고 결과에는 원래 행을 쓴다).

    앞 「a. 」와 끝 출연자 괄호를 떼고, 이름의 번호를 순서로 쓴다. 악장 번호 칸이 비었어도
    이름이 「I. Allegro」「…: I. Allegro」꼴이고 순서와 같으면 악장으로 본다.
    """
    if LETTER_LEAD.match(row["name_en"]):
        row = {
            **row,
            "name_en": LETTER_LEAD.sub("", row["name_en"]),
            "name_ko": LETTER_LEAD.sub("", row["name_ko"]),
        }
    # 따옴표 가사가 있으면 끝 괄호는 출연자(「(Hérode, Phanuel, Chœur)」)라 이름으로 쓰지 않는다
    if QUOTED.search(row["name_en"]) or re.search(r"[«“]", row["name_en"]):
        row = {
            **row,
            "name_en": CAST.sub("", row["name_en"]),
            "name_ko": CAST.sub("", row["name_ko"]),
        }
    # 이름에 번호가 있으면(「…Book 1: No. 3. Come With Us!」) 순서 대신 그 번호로 찾는다
    number = NAME_NUMBER.search(norm(row["name_en"]))
    if number and number.group(1) != row["seq"]:
        row = {**row, "seq": number.group(1)}
    if row["movement"].strip():
        return row
    m = ROMAN_LEAD.search(row["name_en"])
    seq = int(row["seq"])
    if m and seq < len(ROMAN) and m.group(1).lower() == ROMAN[seq]:
        return {**row, "movement": m.group(1)}
    return row


def match_children(
    parents: list[dict[str, str]],
    children_of: dict[str, list[dict[str, str]]],
    tracks: list[dict[str, Any]],
    set_catalogue: str,
    existing: str,
    flat: bool = True,
) -> dict[int, tuple[str, str, str]]:
    """곡 안 곡(악장 등)마다 (트랙 링크, 트랙 이름, 규칙).

    안에 곡이 있는 곡도 링크가 비었으면 첫 곡 트랙을 준다. 곡마다 그 곡 트랙만 가려내
    (work_patterns) 그 안에서 match_set 을 돌린다. 가려낸 트랙이 형제 곡과 겹치거나 조성이
    다르면 그 곡은 건너뛴다. 곡 안 곡이 또 곡을 가지면 같은 식으로 한 번 더 들어간다.
    flat 이면, 어느 곡도 가려내지 못한 앨범(「Requiem: III. Dies irae」처럼 트랙이 곡 안 곡을
    바로 담은 앨범)에서는 이름이 길고 세트 안에서 하나뿐인 곡만 이름·곡 부분 이름 규칙으로 붙인다.
    """
    names = [norm(str(t.get("trackName", ""))) for t in tracks]
    owned: dict[str, tuple[list[int], str]] = {}
    for part in parents:
        if part["part_id"] not in children_of:
            continue
        key = key_of(part["name_ko"]) or key_of(part["name_en"])
        for pattern in work_patterns(part, parents, set_catalogue):
            hits = [i for i, name in enumerate(names) if re.search(pattern, name)]
            if not hits:
                continue
            keys = {key_of(str(tracks[i].get("trackName", ""))) for i in hits} - {None}
            if key and keys and keys != {key}:
                break
            owned[part["part_id"]] = (hits, pattern)
            break
    claimed = Counter(i for hits, _ in owned.values() for i in hits)
    picked: dict[int, tuple[str, str, str]] = {}
    for part in parents:
        if part["part_id"] not in owned:
            continue
        hits, pattern = owned[part["part_id"]]
        if any(claimed[i] > 1 for i in hits):
            continue
        sub = [tracks[i] for i in hits]
        children = sorted(
            (with_movement(row) for row in children_of[part["part_id"]]),
            key=lambda r: int(r["seq"]),
        )
        found = match_set(children, sub, pattern)
        picked.update(
            (part_id, hit)
            for part_id, hit in found.items()
            if not next(r for r in children if int(r["part_id"]) == part_id)[existing].strip()
        )
        grand = [row for row in children if row["part_id"] in children_of]
        if grand:
            picked.update(match_children(grand, children_of, sub, "", existing, flat=False))
        if part[existing].strip():
            continue
        first = int(children[0]["part_id"])
        if first in found:
            url, name, _ = found[first]
            picked[int(part["part_id"])] = (url, name, "first")
        elif index_of(str(sub[0].get("trackName", ""))) == 1:
            picked[int(part["part_id"])] = (
                track_url(sub[0]),
                str(sub[0].get("trackName", "")),
                "first",
            )
    if flat and not owned:
        picked.update(match_flat(parents, children_of, tracks, existing))
    return picked


def strong_name(row: dict[str, str]) -> bool:
    """흔한 빠르기·형식 말과 로마 숫자를 빼고도 세 글자 넘는 낱말이 둘 넘게 남고 여덟 글자가
    넘는 이름(「Tuba mirum」「Dies irae」). 「Allemande」처럼 한 낱말이면 다른 곡의 것일 수 있다."""
    for name in name_candidates(row):
        rest = [
            w
            for w in re.sub(r"[^a-z ]", " ", GENERIC.sub(" ", norm(name))).split()
            if len(w) >= 3 and w not in ROMAN_NUMBER
        ]
        if len(rest) >= 2 and len("".join(rest)) >= 8:
            return True
    return False


def match_flat(
    parents: list[dict[str, str]],
    children_of: dict[str, list[dict[str, str]]],
    tracks: list[dict[str, Any]],
    existing: str,
) -> dict[int, tuple[str, str, str]]:
    """곡 안 곡을 앨범 전체에서 이름으로만 찾는다. 첫 곡이 붙으면 그 곡을 가진 곡에도 준다.

    막·부(「Act I」「II. Gloria」)로 나눈 곡만 본다. 조성·번호·작품번호가 있는 곡(「Partita No. 2
    in D minor」)은 작품 묶음이라 다른 작품과 악장 이름이 겹치고, 세트 앨범이 다른 작품인 일도 있다.
    """
    parents = [
        part
        for part in parents
        if not (key_of(part["name_ko"]) or key_of(part["name_en"]))
        and not LEAD_NUMBER.match(norm(part["name_en"]))
        and not re.search(r"\bno\.?\s*\d", norm(part["name_en"]))
        and not own_tokens(part["name_en"])
    ]
    children = [
        {**with_movement(row), "catalogue": "", "movement": ""}
        for part in parents
        for row in children_of.get(part["part_id"], [])
        if not row[existing].strip()
    ]
    seen = Counter(norm(row["name_en"]) for row in children)
    rows = [row for row in children if seen[norm(row["name_en"])] == 1 and strong_name(row)]
    if not rows:
        return {}
    found = {
        part_id: (url, name, f"flat-{rule}")
        for part_id, (url, name, rule) in match_set(rows, tracks).items()
        if rule in {"name", "tail"}
    }
    for part in parents:
        kids = sorted(children_of.get(part["part_id"], []), key=lambda r: int(r["seq"]))
        if kids and not part[existing].strip() and int(kids[0]["part_id"]) in found:
            url, name, _ = found[int(kids[0]["part_id"])]
            found[int(part["part_id"])] = (url, name, "first")
    return found


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--parts", required=True)
    parser.add_argument("--raw", required=True)
    parser.add_argument("--out", required=True)
    parser.add_argument("--migration", required=True)
    parser.add_argument("--name", default="matches.jsonl", help="결과 jsonl 파일 이름")
    parser.add_argument(
        "--column",
        default="apple_music_url",
        choices=["apple_music_url", "spotify_url"],
        help="parts.tsv 의 앨범 링크 칸이자 piece_parts 에 채울 칸",
    )
    parser.add_argument(
        "--source-dir", default="part-apple-links-2026-11-08", help="SQL 주석의 자료 폴더"
    )
    parser.add_argument(
        "--skip", action="append", default=[], help="이미 넣은 matches jsonl. 그 곡은 뺀다"
    )
    parser.add_argument(
        "--nested",
        action="store_true",
        help=(
            "곡 안 곡(악장 등)과 그 곡을 가진 곡만 붙인다."
            " parts.tsv 에 parent_part_id 칸이 있어야 한다"
        ),
    )
    args = parser.parse_args()
    skip: set[int] = set()
    for path in args.skip:
        with open(path, encoding="utf-8") as handle:
            skip |= {int(json.loads(line)["partId"]) for line in handle if line.strip()}

    sets: dict[int, list[dict[str, str]]] = defaultdict(list)
    with open(args.parts, encoding="utf-8") as handle:
        for row in csv.DictReader(handle, delimiter="\t"):
            sets[int(row["piece_id"])].append(row)

    matches: list[dict[str, Any]] = []
    rules: Counter[str] = Counter()
    fetched = 0
    for piece_id, rows in sorted(sets.items()):
        m = re.search(r"/([A-Za-z0-9]+)$", rows[0][args.column].strip())
        tracks = tracks_of(args.raw, m.group(1)) if m else []
        if not tracks:
            continue
        fetched += 1
        if args.nested:
            existing = "part_apple" if args.column == "apple_music_url" else "part_spotify"
            top = [r for r in rows if not r["parent_part_id"]]
            children_of: dict[str, list[dict[str, str]]] = defaultdict(list)
            for row in rows:
                if row["parent_part_id"]:
                    children_of[row["parent_part_id"]].append(row)
            found = match_children(top, children_of, tracks, rows[0]["catalogue"], existing)
        else:
            found = match_set(rows, tracks)
        for part_id, (url, name, rule) in sorted(found.items()):
            if part_id in skip:
                continue
            row = next(r for r in rows if int(r["part_id"]) == part_id)
            rules[rule] += 1
            matches.append(
                {
                    "partId": part_id,
                    "pieceId": piece_id,
                    "seq": int(row["seq"]),
                    **(
                        {
                            "parentPartId": int(row["parent_part_id"])
                            if row["parent_part_id"]
                            else None
                        }
                        if args.nested
                        else {}
                    ),
                    "part": row["name_ko"] or row["name_en"],
                    "track": name,
                    "rule": rule,
                    "url": url,
                }
            )

    with open(f"{args.out}/{args.name}", "w", encoding="utf-8") as handle:
        for item in matches:
            handle.write(json.dumps(item, ensure_ascii=False) + "\n")

    values = ",\n".join(
        "({}, {}, {}, {}'{}')".format(
            item["partId"],
            item["pieceId"],
            item["seq"],
            (f"{item['parentPartId'] or 'NULL'}, " if args.nested else ""),
            str(item["url"]).replace("'", "''"),
        )
        for item in matches
    )
    total_parts = sum(len(rows) for rows in sets.values())
    service = "Apple Music" if args.column == "apple_music_url" else "Spotify"
    temp = "tmp_part_apple" if args.column == "apple_music_url" else "tmp_part_spotify"
    scope = "곡 안 곡(악장 등)과 그 곡을 가진 곡" if args.nested else "세트 안 곡(최상위 part)"
    sql = [
        f"-- {scope}에 {service} 트랙 링크를 채운다. 자료와 규칙은",
        f"-- seed_pipeline/curation/{args.source_dir}/(match.py, {args.name}).",
        (
            f"-- 앨범 링크가 있는 세트의 곡 {total_parts}곡 중, "
            f"앞서 넣은 {len(skip)}곡을 빼고 {len(matches)}곡 더."
            if skip
            else f"-- 앨범 링크가 있는 세트의 곡 {total_parts}곡 중 {len(matches)}곡."
        ),
        (
            "-- 이미 링크가 있는 곡은 그대로 두고, id 와 함께 작품·부모 곡·순서가 같은 곡에만"
            " 넣는다."
            if args.nested
            else "-- 이미 링크가 있는 곡은 그대로 두고, id 와 함께 작품·순서가 같은 최상위 곡에만"
            " 넣는다."
        ),
        "-- 두 번 넣어도 같다.",
        "",
        f"CREATE TEMPORARY TABLE {temp} (",
        "    part_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,",
        "    piece_id INT NOT NULL,",
        "    sequence_number INT NOT NULL,",
        *(["    parent_part_id BIGINT UNSIGNED NULL,"] if args.nested else []),
        "    url VARCHAR(500) NOT NULL",
        ");",
    ]
    columns = "part_id, piece_id, sequence_number, " + ("parent_part_id, " if args.nested else "")
    if matches:
        sql.append(f"INSERT INTO {temp} ({columns}url) VALUES\n{values};")
    sql += [
        "",
        "UPDATE piece_parts part",
        f"JOIN {temp} link",
        "    ON link.part_id = part.id",
        "    AND link.piece_id = part.piece_id",
        "    AND link.sequence_number = part.sequence_number",
        *(["    AND part.parent_part_id <=> link.parent_part_id"] if args.nested else []),
        f"SET part.{args.column} = link.url",
        f"WHERE part.{args.column} IS NULL",
        *([] if args.nested else ["    AND part.parent_part_id IS NULL"]),
    ]
    sql[-1] += ";"
    sql += [
        "",
        f"DROP TEMPORARY TABLE {temp};",
        "",
    ]
    with open(args.migration, "w", encoding="utf-8") as handle:
        handle.write("\n".join(sql))
    print(
        json.dumps(
            {
                "sets": len(sets),
                "fetchedSets": fetched,
                "parts": total_parts,
                "matched": len(matches),
                "rules": rules,
            },
            ensure_ascii=False,
        )
    )


if __name__ == "__main__":
    main()
