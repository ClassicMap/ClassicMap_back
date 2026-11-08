"""작품 목록(tsv)의 작품마다 iTunes Search(song, 200개)를 불러 <out>/<piece_id>.json 에 둔다.

검색어는 '작곡가 성 + 본제목 여섯 낱말 + 작품번호'. 조성·괄호·따옴표는 걷는다(♭ 이 있으면 0건).
이미 받은 작품은 건너뛴다. 분당 20회쯤 제한이라 3.3초 간격, 403·429·5xx 는 쉬었다가 다시.
사용: uv run python apple_search.py <작업 폴더>/candidates.tsv <작업 폴더>/search_raw
"""

from __future__ import annotations

import csv
import json
import os
import re
import sys
import time
import unicodedata
import urllib.error
import urllib.parse
import urllib.request
from typing import Any

UA = "ClassicMapLinkCuration/0.1 (kang3171611@naver.com)"


def plain(text: str) -> str:
    text = unicodedata.normalize("NFKD", text)
    return "".join(c for c in text if not unicodedata.combining(c))


def clean_title(row: dict[str, str]) -> str:
    """제목에서 조성·작품번호·괄호·따옴표를 걷는다(♭·♯ 는 검색에 걸리지 않는다)."""
    title = plain(row["title_en"]).replace("\u266d", "-flat").replace("\u266f", "-sharp")
    if row["catalogue"].strip():
        title = title.replace(plain(row["catalogue"]).strip(), " ")
    title = re.sub(r"[<>\"“”«»]", " ", title)
    title = re.sub(r"\([^)]*\)", " ", title)
    title = re.sub(
        r"\b(in\s+[A-G](?:[- ]?(?:flat|sharp|#|b))?\s+(?:major|minor))\b", " ", title, flags=re.I
    )
    title = re.sub(
        r",?\s*\b(?:op|bwv|k|kv|hob|d|woo|s|rv|hwv|l|m|r|fp|h|g|sz|bb|jw|trv|wab)\.?\s*[\w.:/-]*\d[\w.:/-]*",
        " ",
        title,
        flags=re.I,
    )
    return title


def term_of(row: dict[str, str]) -> str:
    surname = plain(row["composer_en"]).split()[-1] if row["composer_en"].strip() else ""
    title = clean_title(row)
    if row["catalogue"].strip():
        # 작품번호가 있으면 편성 설명("for violin and viola")은 트랙 이름에 없어 검색을 막는다
        title = re.split(r"\s(?:for|from)\s", title, maxsplit=1, flags=re.I)[0]
    words = [w for w in re.split(r"[\s,;:]+", title) if w and w not in "-'"][:6]
    return " ".join(x for x in [surname, " ".join(words), plain(row["catalogue"])] if x).strip()


def short_term_of(row: dict[str, str]) -> str:
    """두 번째 검색어: 작품번호가 있으면 성 + 작품번호, 없으면 성 + 제목 앞 네 낱말."""
    surname = plain(row["composer_en"]).split()[-1] if row["composer_en"].strip() else ""
    if row["catalogue"].strip():
        return f"{surname} {plain(row['catalogue'])}".strip()
    words = [w for w in re.split(r"[\s,;:]+", clean_title(row)) if w and w not in "-'"][:4]
    return " ".join([surname, *words]).strip()


def fetch(term: str) -> dict[str, Any]:
    url = "https://itunes.apple.com/search?" + urllib.parse.urlencode(
        {"term": term, "entity": "song", "limit": 200, "country": "us"}
    )
    for attempt in range(6):
        try:
            req = urllib.request.Request(url, headers={"User-Agent": UA})
            with urllib.request.urlopen(req, timeout=40) as res:
                data: dict[str, Any] = json.load(res)
                return data
        except urllib.error.HTTPError as err:
            if err.code == 404:
                # 검색어에 따라 iTunes 가 404 를 준다(결과 없음과 같다)
                return {"resultCount": 0, "results": []}
            if err.code in (403, 429) or err.code >= 500:
                time.sleep(30 * (attempt + 1))
                continue
            raise
        except (urllib.error.URLError, OSError):
            time.sleep(15 * (attempt + 1))
    raise RuntimeError(f"failed: {term}")


def main() -> None:
    src, out = sys.argv[1], sys.argv[2]
    os.makedirs(out, exist_ok=True)
    with open(src, encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle, delimiter="\t"))
    done = 0
    for row in rows:
        path = os.path.join(out, f"{row['piece_id']}.json")
        if os.path.exists(path):
            continue
        term = term_of(row)
        data = fetch(term)
        data["term"] = term
        with open(path + ".tmp", "w", encoding="utf-8") as handle:
            json.dump(data, handle, ensure_ascii=False)
        os.replace(path + ".tmp", path)
        done += 1
        if done % 50 == 0:
            print(time.strftime("%H:%M:%S"), "fetched", done, flush=True)
        time.sleep(3.3)
    print("all done", flush=True)


if __name__ == "__main__":
    main()
