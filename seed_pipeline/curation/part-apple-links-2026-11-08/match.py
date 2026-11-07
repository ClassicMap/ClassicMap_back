"""세트 안 곡(최상위 part)에 Apple Music 트랙 링크를 붙인다.

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
같은 곡에 맞는 트랙이 여럿이면(다악장 곡, 같은 곡 두 번) 앨범 순서로 첫 트랙을 붙인다.
번호가 우리와 앨범에서 다르게 매겨진 경우를 거르려고, 곡과 트랙에 조성이 둘 다 있으면 같아야 하고
악장(또는 원어 이름이 있는 곡)은 곡 이름과 트랙 이름의 첫 낱말 중 하나가 다른 쪽에 있어야 한다.
곡 이름의 따옴표 가사가 다른 트랙 하나에만 있으면 번호·악장으로 찾은 트랙은 버린다.

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
    rows: list[dict[str, str]], tracks: list[dict[str, Any]]
) -> dict[int, tuple[str, str, str]]:
    """세트 하나의 곡마다 (트랙 링크, 트랙 이름, 규칙)."""
    head = rows[0]
    names = [norm(str(t.get("trackName", ""))) for t in tracks]
    cat = catalogue_regex(head["catalogue"])
    span = catalogue_range(head["catalogue"])
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
    # 한 트랙이 두 곡에 걸리면 어느 쪽인지 모르므로 둘 다 버린다
    used = Counter(index for index, _ in picked.values())
    return {
        part_id: (track_url(tracks[index]), str(tracks[index].get("trackName", "")), rule)
        for part_id, (index, rule) in picked.items()
        if used[index] == 1
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--parts", required=True)
    parser.add_argument("--raw", required=True)
    parser.add_argument("--out", required=True)
    parser.add_argument("--migration", required=True)
    args = parser.parse_args()

    sets: dict[int, list[dict[str, str]]] = defaultdict(list)
    with open(args.parts, encoding="utf-8") as handle:
        for row in csv.DictReader(handle, delimiter="\t"):
            sets[int(row["piece_id"])].append(row)

    matches: list[dict[str, Any]] = []
    rules: Counter[str] = Counter()
    fetched = 0
    for piece_id, rows in sorted(sets.items()):
        m = re.search(r"/(\d+)$", rows[0]["apple_music_url"].strip())
        tracks = tracks_of(args.raw, m.group(1)) if m else []
        if not tracks:
            continue
        fetched += 1
        for part_id, (url, name, rule) in sorted(match_set(rows, tracks).items()):
            row = next(r for r in rows if int(r["part_id"]) == part_id)
            rules[rule] += 1
            matches.append(
                {
                    "partId": part_id,
                    "pieceId": piece_id,
                    "seq": int(row["seq"]),
                    "part": row["name_ko"] or row["name_en"],
                    "track": name,
                    "rule": rule,
                    "url": url,
                }
            )

    with open(f"{args.out}/matches.jsonl", "w", encoding="utf-8") as handle:
        for item in matches:
            handle.write(json.dumps(item, ensure_ascii=False) + "\n")

    values = ",\n".join(
        "({}, {}, {}, '{}')".format(
            item["partId"], item["pieceId"], item["seq"], str(item["url"]).replace("'", "''")
        )
        for item in matches
    )
    total_parts = sum(len(rows) for rows in sets.values())
    sql = [
        "-- 세트 안 곡(최상위 part)에 Apple Music 트랙 링크를 채운다. 자료와 규칙은",
        "-- seed_pipeline/curation/part-apple-links-2026-11-08/(match.py, matches.jsonl).",
        f"-- 앨범 링크가 있는 세트의 곡 {total_parts}곡 중 {len(matches)}곡.",
        "-- 이미 링크가 있는 곡은 그대로 두고, id 와 함께 작품·순서가 같은 최상위 곡에만 넣는다.",
        "-- 두 번 넣어도 같다.",
        "",
        "CREATE TEMPORARY TABLE tmp_part_apple (",
        "    part_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,",
        "    piece_id INT NOT NULL,",
        "    sequence_number INT NOT NULL,",
        "    url VARCHAR(500) NOT NULL",
        ");",
    ]
    if matches:
        sql.append(
            "INSERT INTO tmp_part_apple (part_id, piece_id, sequence_number, url) VALUES\n"
            f"{values};"
        )
    sql += [
        "",
        "UPDATE piece_parts part",
        "JOIN tmp_part_apple link",
        "    ON link.part_id = part.id",
        "    AND link.piece_id = part.piece_id",
        "    AND link.sequence_number = part.sequence_number",
        "SET part.apple_music_url = link.url",
        "WHERE part.apple_music_url IS NULL",
        "    AND part.parent_part_id IS NULL;",
        "",
        "DROP TEMPORARY TABLE tmp_part_apple;",
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
