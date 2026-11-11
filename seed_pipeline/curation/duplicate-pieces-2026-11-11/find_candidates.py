# ruff: noqa: E501, RUF001 — 머리 설명은 한 줄로 두고, 따옴표 정규화 표에는 굽은 따옴표가 들어간다.
"""같은 작곡가 안 중복 작품 후보를 뽑는다. 후보일 뿐이고 묶음마다 사람이 확인해서 decisions.json 에 적는다.

입력은 운영 읽기 덤프(../catalog-wave6-2026-11-10/tools/dump.sh 의 pieces.tsv·composers.tsv)다.
보이는 작품(작품·작곡가 모두 hidden_reason 없음)끼리 세 가지로 짝을 찾는다.

- title: 제목이나 영어 제목을 정규화(갈래 머리말 「오페라 <」·작품번호·따옴표·괄호 국가명·악센트·공백 제거)해서 같다.
  두 작품 모두 작품번호가 있는데 하나도 안 겹치면 빼다(BWV 940 과 BWV 926 처럼 같은 이름 다른 곡).
- catalogue: 작품번호 묶음(Op.·BWV·K.·Hob.·Sz. …)이 똑같다. part 가 가리키는 작품(악장 낱곡)은 뺀다.
- similar: 손으로 넣은 처음 작품(id 1000 미만)과 영어 제목 낱말 자카드 0.5 이상이고 숫자가 겹친다.

사용: python3 find_candidates.py --db <덤프 폴더> > candidates.tsv
"""

import argparse
import csv
import re
import sys
import unicodedata
from collections import defaultdict
from itertools import combinations
from pathlib import Path

csv.field_size_limit(sys.maxsize)

Row = dict[str, str]

PREFIX = re.compile(
    r"^(오페라|오페레타|발레|뮤지컬|가곡|칸타타|오라토리오|영화|모음곡|교향시|연가곡|부수음악|"
    r"opera|operetta|ballet|musical|song|cantata|oratorio|suite|symphonic poem|tone poem)\s*",
    re.IGNORECASE,
)
CATALOGUE = re.compile(
    r"\b(op|opus|wd|bwv|k|kv|hob|rv|hwv|d|s|sz|bb|woo|l|fs|jw|trv|wq|h|g|twv|z|sv|m|cff)\.?\s*"
    r"([ivxlc]+|[0-9]+[a-z]?)(\s*[/.:-]\s*[0-9]+[a-z]?)*(\s*,?\s*no\.?\s*[0-9]+)?\b",
    re.IGNORECASE,
)
COUNTRY = re.compile(r"\((south korea|korea|대한민국|한국)\)", re.IGNORECASE)
STOP = {
    "in", "of", "the", "for", "and", "from", "no", "op", "major", "minor", "a", "an",
    "de", "la", "le", "les", "et", "pour", "with", "von", "und", "der", "die", "das",
}  # fmt: skip


def fold(text: str) -> str:
    text = unicodedata.normalize("NFKD", text.lower())
    return "".join(ch for ch in text if not unicodedata.combining(ch))


def norm_title(text: str) -> str:
    if text in ("", "NULL"):
        return ""
    text = COUNTRY.sub("", unicodedata.normalize("NFKC", text))
    text = re.sub(r"[<>«»\"'“”‘’「」『』《》]", " ", text)
    text = PREFIX.sub("", text.strip())
    text = CATALOGUE.sub(" ", text)
    text = re.sub(r"\b(no|nr|n°)\.?\s*", "no", text, flags=re.IGNORECASE)
    return re.sub(r"[\s\-_,.;:!?()\[\]/&·…]+", "", fold(text))


def catalogue_numbers(*texts: str) -> frozenset[str]:
    found: set[str] = set()
    for text in texts:
        if text in ("", "NULL"):
            continue
        for match in CATALOGUE.finditer(unicodedata.normalize("NFKC", text)):
            token = re.sub(r"[\s.,]", "", match.group(0).lower())
            found.add(token.replace("opus", "op").replace("kv", "k"))
    return frozenset(found)


def words(text: str) -> set[str]:
    return {w for w in re.findall(r"[a-z]+|[0-9]+", fold(text)) if w not in STOP}


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--db", type=Path, required=True)
    args = parser.parse_args()
    with (args.db / "composers.tsv").open(encoding="utf-8") as handle:
        composers = {row["id"]: row for row in csv.DictReader(handle, delimiter="\t")}
    with (args.db / "pieces.tsv").open(encoding="utf-8") as handle:
        visible = [
            row
            for row in csv.DictReader(handle, delimiter="\t")
            if row["hidden_reason"] == "NULL"
            and composers[row["composer_id"]]["hidden_reason"] == "NULL"
        ]
    numbers = {
        row["id"]: catalogue_numbers(row["title"], row["title_en"], row["opus_number"])
        for row in visible
    }
    by_composer: dict[str, list[Row]] = defaultdict(list)
    for row in visible:
        by_composer[row["composer_id"]].append(row)

    signals: dict[tuple[str, str], set[str]] = defaultdict(set)
    for rows in by_composer.values():
        keys: dict[str, list[str]] = defaultdict(list)
        for row in rows:
            for field in ("title", "title_en"):
                key = norm_title(row[field])
                if len(key) >= 3:
                    keys[key].append(row["id"])
        for ids in keys.values():
            unique = sorted(set(ids), key=int)
            if not 1 < len(unique) <= 6:
                continue
            for a, b in combinations(unique, 2):
                if numbers[a] and numbers[b] and not numbers[a] & numbers[b]:
                    continue
                signals[(a, b)].add("title")
        groups: dict[frozenset[str], list[str]] = defaultdict(list)
        for row in rows:
            if numbers[row["id"]] and row["linked_by"] == "0":
                groups[numbers[row["id"]]].append(row["id"])
        for ids in groups.values():
            if 1 < len(ids) <= 4:
                for a, b in combinations(sorted(ids, key=int), 2):
                    signals[(a, b)].add("catalogue")
        for row in rows:
            if row["origin"] != "manual" or int(row["id"]) >= 1000:
                continue
            mine = words(row["title_en"])
            for other in rows:
                if other["id"] == row["id"] or other["linked_by"] != "0" or not mine:
                    continue
                theirs = words(other["title_en"])
                if not theirs or len(mine & theirs) / len(mine | theirs) < 0.5:
                    continue
                digits_a = {w for w in mine if w.isdigit()}
                digits_b = {w for w in theirs if w.isdigit()}
                if digits_a and digits_b and not digits_a & digits_b:
                    continue
                pair = tuple(sorted((row["id"], other["id"]), key=int))
                signals[(pair[0], pair[1])].add("similar")

    by_id = {row["id"]: row for row in visible}
    out = csv.writer(sys.stdout, delimiter="\t", lineterminator="\n")
    out.writerow(["composer_id", "composer", "signals", "a", "a_title", "b", "b_title"])
    for (a, b), kinds in sorted(
        signals.items(), key=lambda item: (int(item[0][0]), int(item[0][1]))
    ):
        row_a, row_b = by_id[a], by_id[b]
        out.writerow(
            [
                row_a["composer_id"],
                composers[row_a["composer_id"]]["name"],
                ",".join(sorted(kinds)),
                a,
                row_a["title"],
                b,
                row_b["title"],
            ]
        )


if __name__ == "__main__":
    main()
