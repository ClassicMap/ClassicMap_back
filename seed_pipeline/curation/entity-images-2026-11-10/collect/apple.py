"""애플 뮤직 아티스트 페이지의 머리 그림(artwork 정사각, wideArtwork 가로)을 모은다.

사용: apple.py <입력 jsonl: {key, appleId?, names:[이름...]}> <출력 jsonl>
appleId 가 없으면 iTunes 검색(분당 ~20회라 3.2초 간격)에서 이름이 정확히 같고
장르가 클래식·사운드트랙 쪽인 아티스트만 고른다. 이어 받기: 출력에 있는 key 는 건너뛴다.
"""

from __future__ import annotations

import json
import re
import sys
import time
import unicodedata
import urllib.parse
import urllib.request
from pathlib import Path
from typing import Any

BROWSER_UA = (
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 "
    "(KHTML, like Gecko) Version/17.0 Safari/605.1.15"
)
UA = "ClassicMapImageCuration/0.1 (kang3171611@naver.com)"
GENRES = {"Classical", "Soundtrack", "Opera", "Classical Crossover", "Chamber Music", "Orchestral"}
DATA = re.compile(
    r'<script type="application/json" id="serialized-server-data">(.*?)</script>', re.S
)
CANONICAL = re.compile(r'<link rel="canonical" href="([^"]+)"')


def norm(text: str) -> str:
    text = unicodedata.normalize("NFKD", text or "")
    text = "".join(ch for ch in text if not unicodedata.combining(ch)).lower()
    return re.sub(r"[^a-z0-9]+", "", text)


def fetch(url: str, browser: bool = False) -> bytes | None:
    for attempt in range(4):
        try:
            headers = {"User-Agent": BROWSER_UA if browser else UA}
            request = urllib.request.Request(url, headers=headers)
            with urllib.request.urlopen(request, timeout=60) as response:
                body: bytes = response.read()
                return body
        except Exception as error:
            status = getattr(error, "code", None)
            print("fail", url[:90], status, file=sys.stderr)
            if status == 404:
                return None
            time.sleep(20 * (attempt + 1) if status in (403, 429) else 5)
    return None


def search(names: list[str]) -> tuple[str | None, str | None]:
    wanted = {norm(name) for name in names if name}
    for name in names[:2]:
        body = fetch(
            "https://itunes.apple.com/search?entity=musicArtist&limit=10&country=us&term="
            + urllib.parse.quote(name)
        )
        time.sleep(3.2)
        if not body:
            continue
        for result in json.loads(body).get("results", []):
            genre = result.get("primaryGenreName") or ""
            # 동명이인을 줄이려고 클래식·사운드트랙 쪽 장르만 받는다
            if norm(result.get("artistName", "")) in wanted and genre in GENRES:
                return str(result["artistId"]), f"{result.get('artistName')} [{genre}]"
    return None, None


def artwork(entry: Any) -> dict[str, Any] | None:
    info = (entry or {}).get("dictionary") or {}
    if not info.get("url"):
        return None
    return {"template": info["url"], "width": info.get("width"), "height": info.get("height")}


def header(apple_id: str) -> dict[str, Any]:
    body = fetch(f"https://music.apple.com/us/artist/{apple_id}", browser=True)
    if not body:
        return {"error": "fetch"}
    page = body.decode("utf-8", "replace")
    match = DATA.search(page)
    if not match:
        return {"error": "nodata"}
    canonical = CANONICAL.search(page)
    for block in json.loads(match.group(1)).get("data", []):
        for section in block.get("data", {}).get("sections", []):
            if section.get("itemKind") != "artistDetailHeader":
                continue
            item = (section.get("items") or [{}])[0]
            return {
                "title": item.get("title"),
                "artwork": artwork(item.get("artwork")),
                "wide": artwork(item.get("wideArtwork")),
                "page": canonical.group(1) if canonical else None,
            }
    return {"error": "noheader"}


def main() -> None:
    source, target = Path(sys.argv[1]), Path(sys.argv[2])
    rows = [
        json.loads(line) for line in source.read_text(encoding="utf-8").splitlines() if line.strip()
    ]
    done: set[str] = set()
    if target.exists():
        done = {
            json.loads(line)["key"]
            for line in target.read_text(encoding="utf-8").splitlines()
            if line
        }
    for row in rows:
        if row["key"] in done:
            continue
        apple_id, matched = row.get("appleId"), None
        if not apple_id:
            apple_id, matched = search(row["names"])
        record: dict[str, Any] = {"key": row["key"], "appleId": apple_id, "matchedName": matched}
        if apple_id:
            record.update(header(apple_id))
            time.sleep(1.5)
        with target.open("a", encoding="utf-8") as handle:
            handle.write(json.dumps(record, ensure_ascii=False) + "\n")


if __name__ == "__main__":
    main()
