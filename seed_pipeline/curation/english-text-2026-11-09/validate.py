"""번역 결과(out/*.jsonl)를 원문(in/*.jsonl)과 견줘 검사한다.

id·순서, 빠진 영어 칸, 영어에 남은 한글, 사실 태그 수, 길이 제한을 본다.
사용: python3 -I validate.py <작업 폴더(in/, out/ 이 있는 곳)>
"""

from __future__ import annotations

import glob
import json
import os
import re
import sys
from typing import Any

HANGUL = re.compile(r"[가-힣]")
# 원제가 라틴 문자(악센트·곧은/굽은 따옴표·대시 포함)면 영어 제목을 따로 옮기지 않았다
LATIN = re.compile(r"^[\x00-\x7f\u00c0-\u024f\u2018-\u201d\u2013\u2014\u00b7]*$")
FIELDS: dict[str, list[str]] = {
    "composers": ["bio", "style", "influence"],
    "artists": ["bio", "style"],
    "awards": ["award_name"],
    "pieces": ["description"],
    "sectors": ["description", "name_ko"],
    "notes": ["headline", "note", "facts"],
    "pairs": ["title", "note"],
    "screen_titles": ["title_ko"],
    "screen_cues": ["part_label", "scene_note"],
}
LIMIT = {"headline_en": 60, "title_en": 60, "scene_note_en": 600}


def load(path: str) -> list[dict[str, Any]]:
    with open(path, encoding="utf-8") as handle:
        return [json.loads(line) for line in handle if line.strip()]


def problems(kind: str, source: dict[str, Any], record: dict[str, Any]) -> list[str]:
    found: list[str] = []
    key = source["id"]
    for field in FIELDS[kind]:
        korean = source.get(field)
        if field == "name_ko":
            if source.get("name_en"):
                continue
            english = record.get("name_en")
        elif field == "title_ko":
            if LATIN.match(source.get("title_original") or "") and source.get("title_original"):
                continue
            english = record.get("title_ko_en") or record.get("title_en")
        elif field == "facts":
            facts = json.loads(korean) if isinstance(korean, str) and korean else korean or []
            tags = record.get("facts_en")
            if facts and (not isinstance(tags, list) or len(tags) != len(facts)):
                found.append(f"{key} facts 수")
            if isinstance(tags, list) and any(HANGUL.search(tag) for tag in tags):
                found.append(f"{key} facts 한글")
            continue
        else:
            english = record.get(f"{field}_en")
        if korean and not english:
            found.append(f"{key} {field}_en 없음")
        if english and HANGUL.search(str(english)):
            found.append(f"{key} {field}_en 한글")
        limit = LIMIT.get(f"{field}_en")
        if english and limit and len(str(english)) > limit:
            found.append(f"{key} {field}_en 길이 {len(str(english))}")
    return found


def main() -> None:
    work = sys.argv[1]
    total = 0
    for path in sorted(glob.glob(os.path.join(work, "out", "*.jsonl"))):
        name = os.path.basename(path)[: -len(".jsonl")]
        kind = name.split("_", 1)[1]
        sources = {str(row["id"]): row for row in load(os.path.join(work, "in", f"{kind}.jsonl"))}
        records = load(path)
        found: list[str] = []
        for record in records:
            source = sources.get(str(record["id"]))
            if source is None:
                found.append(f"{record['id']} 원문 없음")
                continue
            found += problems(kind, source, record)
        total += len(records)
        print(f"{name:20} {len(records):4} problems={len(found)}", found[:6])
    print("records", total)


if __name__ == "__main__":
    main()
