# ruff: noqa: E501 — 한국어 설명을 그대로 둔다.
"""6차 음반 묶음(사운드트랙 장르 맨 위 작품)마다 MusicBrainz release group 의 모든 release 링크(url-rels)에서
Apple Music·Spotify 앨범 주소를 모은다. 출력: <작업 폴더>/mb_urls.json {piece_id: {"apple": [...], "spotify": [...]}}.

사용: uv run python mb_urls.py <작업 폴더>(top.tsv 가 있는 곳)
"""

from __future__ import annotations

import json
import os
import re
import sys

from common import load_fetch, read_tsv, wave6_groups

APPLE = re.compile(r"https?://(music|itunes)\.apple\.com/[a-z]{2}/album/[^?\s]*?(\d{6,})")
SPOTIFY = re.compile(r"https?://open\.spotify\.com/album/([A-Za-z0-9]{22})")


def main() -> None:
    work = sys.argv[1]
    fetch = load_fetch()
    groups = wave6_groups()
    out: dict[str, dict[str, list[str]]] = {}
    for row in read_tsv(os.path.join(work, "top.tsv")):
        group = groups.get((row["composer_id"], row["title"]))
        if not group:
            continue
        apple: list[str] = []
        spotify: list[str] = []
        page = fetch.mb(
            "release",
            {"release-group": group["releaseGroup"], "inc": "url-rels", "limit": 100},
        )
        releases = page.get("releases", []) if page else []
        # 묶음을 만든 대표 판을 먼저 본다
        releases.sort(key=lambda r: r["id"] != group.get("release"))
        for release in releases:
            for rel in release.get("relations", []):
                url = (rel.get("url") or {}).get("resource", "")
                match = APPLE.search(url)
                if match and match.group(2) not in apple:
                    apple.append(match.group(2))
                match = SPOTIFY.search(url)
                if match and match.group(1) not in spotify:
                    spotify.append(match.group(1))
        out[row["id"]] = {"apple": apple, "spotify": spotify, "rgTitle": group["rgTitle"]}
    with open(os.path.join(work, "mb_urls.json"), "w", encoding="utf-8") as handle:
        json.dump(out, handle, ensure_ascii=False, indent=1)
    have_a = sum(1 for v in out.values() if v["apple"])
    have_s = sum(1 for v in out.values() if v["spotify"])
    print(f"groups {len(out)} apple {have_a} spotify {have_s}")


if __name__ == "__main__":
    main()
