# ruff: noqa: E501 — 한국어 설명을 그대로 둔다.
"""홍난파·김동진 작품 링크. 크레디트에 작곡가가 거의 안 적혀 있어 규칙으로 고르지 않고, 후보를 뽑아 눈으로 고른다.

1. candidates: 검색 결과(search.py, 한글 이름 + 한글 제목 / 한글 제목 + 가곡·동요)에서 트랙 이름이 제목(한글 제목,
   영어 제목, 로마자)과 같은 트랙을 앨범·아티스트와 함께 적는다(편곡·태교·힐링·오르골·자장가·재즈·피아노판은 뺀다).
2. 사람이 korean-picks.tsv(piece_id, service, url, 까닭)에 고른다. 기준:
   - 원곡 편성(목소리+피아노 또는 관현악 반주) 녹음. 가곡집·성악가 음반의 트랙.
   - 「사랑」「그리움」「진달래꽃」「휘파람」처럼 다른 작곡가나 대중가요에 같은 제목이 있으면 트랙·앨범에 작곡가
     (홍난파·김동진)가 적혀 있을 때만.
3. decisions: korean-picks.tsv → korean-decisions.jsonl(build_sql.py 입력).

사용: uv run python korean.py <작업 폴더> candidates | decisions
"""

from __future__ import annotations

import json
import os
import re
import sys
from typing import Any

from common import HERE, KOREAN, read_tsv
from pick import ARRANGED, search_tracks

PICKS = os.path.join(HERE, "korean-picks.tsv")


def squash(text: str) -> str:
    return re.sub(r"[\W_]+", "", text.lower())


def names_of(row: dict[str, str]) -> set[str]:
    """한글 제목, 영어 제목, 로마자(괄호 안)."""
    out = set()
    m = re.search(r"<([^<>]+)>", row["title"])
    out.add(re.sub(r"\([^)]*\)", "", m.group(1) if m else row["title"]))
    m = re.search(r"<([^<>]+)>", row["title_en"])
    english = m.group(1) if m else row["title_en"]
    out.add(re.sub(r"\([^)]*\)", "", english))
    out |= set(re.findall(r"\(([^)]+)\)", english))
    return {squash(n) for n in out if squash(n)}


COMPOSER = {
    "89": re.compile(r"홍난파|hong\s*nan-?\s*pa|nanpa", re.I),
    "103": re.compile(r"김동진|kim\s*dong-?\s*jin", re.I),
}


def candidates(work: str) -> None:
    """제목이 같은 트랙(괄호·「- 홍난파」 꼬리를 뗀 것)을, 작곡가가 적힌 것부터 서비스마다 여덟 개까지."""
    rows = [r for r in read_tsv(os.path.join(work, "top.tsv")) if r["composer_id"] in KOREAN]
    for row in rows:
        names = names_of(row)
        composer = COMPOSER[row["composer_id"]]
        print(f"## {row['piece_id']} {row['composer_ko']} {row['title']} / {row['title_en']}")
        for service in ("apple", "spotify"):
            if row["apple_music_url" if service == "apple" else "spotify_url"]:
                print(f"  {service}: 이미 있음")
                continue
            found = []
            for track in search_tracks(work, service, row["piece_id"]):
                name = str(track.get("trackName", ""))
                bare = composer.sub("", re.sub(r"\([^)]*\)|\[[^]]*\]", "", name))
                text = f"{name} {track.get('collectionName', '')}".lower()
                if squash(bare) not in names or ARRANGED.search(text):
                    continue
                credit = (
                    f"{name} | {track.get('collectionName', '')} | {track.get('artistName', '')}"
                )
                found.append((not composer.search(credit), credit, track_url(track)))
            for missing, credit, url in sorted(found, key=lambda f: f[0])[:8]:
                print(f"  {service[:2]}{'' if missing else '*'} {url} | {credit}")


def track_url(track: dict[str, Any]) -> str:
    return re.sub(r"&uo=\d+$", "", str(track.get("trackViewUrl", "")))


def decisions(work: str) -> None:
    rows = {
        r["piece_id"]: r
        for r in read_tsv(os.path.join(work, "top.tsv"))
        if r["composer_id"] in KOREAN
    }
    out: list[dict[str, Any]] = []
    picked: set[tuple[str, str]] = set()
    for pick in read_tsv(PICKS):
        row = rows[pick["piece_id"]]
        picked.add((pick["piece_id"], pick["service"]))
        out.append(
            {
                "kind": "piece",
                "pieceId": int(row["piece_id"]),
                "composerId": int(row["composer_id"]),
                "composer": row["composer_en"],
                "title": row["title_en"],
                "service": pick["service"],
                "decision": "fill",
                "new": pick["url"],
                "link": "track" if ("?i=" in pick["url"] or "/track/" in pick["url"]) else "album",
                "albumName": pick["album"],
                "why": pick["why"],
            }
        )
    for row in rows.values():
        for service, col in (("apple", "apple_music_url"), ("spotify", "spotify_url")):
            if not row[col] and (row["piece_id"], service) not in picked:
                out.append(
                    {
                        "kind": "piece",
                        "pieceId": int(row["piece_id"]),
                        "composerId": int(row["composer_id"]),
                        "composer": row["composer_en"],
                        "title": row["title_en"],
                        "service": service,
                        "decision": "not-found",
                        "new": None,
                    }
                )
    with open(os.path.join(HERE, "korean-decisions.jsonl"), "w", encoding="utf-8") as handle:
        for item in out:
            handle.write(json.dumps(item, ensure_ascii=False) + "\n")
    print(
        "fill",
        sum(1 for i in out if i["decision"] == "fill"),
        "not-found",
        sum(1 for i in out if i["decision"] != "fill"),
    )


def main() -> None:
    work, step = sys.argv[1], sys.argv[2]
    if step == "candidates":
        candidates(work)
    else:
        decisions(work)


if __name__ == "__main__":
    main()
