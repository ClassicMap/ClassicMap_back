# ruff: noqa: E501 — 한국어 설명을 그대로 둔다.
"""작품마다 검색어(common.terms) 둘로 Apple Music·Spotify 를 찾아 작업 폴더에 둔다(이미 받은 것은 건너뛴다).

- Apple: iTunes Search(us, song, 200개). 분당 20회쯤에서 막혀 3.3초 간격, 403·429 는 오래 쉰다
  (같은 IP 의 다른 작업과 나눠 쓰므로 간격을 줄이지 않는다) → apple_search/<piece>_<n>.json
- Spotify: 웹 플레이어 트랙 검색(../piece-album-links-2026-11-08/spotify_search.py 의 Session, 100개, 1.5초)
  → spotify_search/<piece>_<n>.json. 잡은 요청(captured.json)에는 토큰이 있어 커밋하지 않는다.

사용: PLAYWRIGHT_MODULE=<playwright> uv run python search.py <작업 폴더> apple|spotify
"""

from __future__ import annotations

import json
import os
import sys
import time
import urllib.parse
from typing import Any

from common import KOREAN, PICK_DIR, load_module, read_tsv, terms


def enough(work: str, service: str, row: dict[str, str]) -> bool:
    """앞 검색 결과로 이미 쓸 앨범이 있나(한국 작곡가는 늘 다음 검색어도 찾는다)."""
    if row["composer_id"] in KOREAN:
        return False
    import pick

    ranked = pick.rank_albums(row, pick.search_tracks(work, service, row["piece_id"]))
    if not ranked:
        return False
    return int(row["nparts"] or 0) == 0 or ranked[0][0][1] == 1


def main() -> None:
    work, service = sys.argv[1], sys.argv[2]
    rows = read_tsv(os.path.join(work, "top.tsv"))
    out = os.path.join(work, f"{service}_search")
    os.makedirs(out, exist_ok=True)
    apple: Any = load_module("apple_search", os.path.join(PICK_DIR, "apple_search.py"))
    session: Any = None
    done = 0
    # 첫 검색어를 모두 찾은 뒤, 첫 검색으로 쓸 앨범(안 곡이 있으면 곡 수 이상 든 앨범)을 못 찾은 작품만 다음 검색어로 찾는다
    todo = [(row, 1, terms(row)[0]) for row in rows]
    todo += [(row, n, term) for row in rows for n, term in enumerate(terms(row), start=1) if n > 1]
    for row, n, term in todo:
        path = os.path.join(out, f"{row['piece_id']}_{n}.json")
        if os.path.exists(path):
            continue
        if n > 1 and enough(work, service, row):
            continue
        if service == "apple":
            data = apple.fetch(term)
            pause = 3.3
        else:
            if session is None:
                spotify: Any = load_module(
                    "spotify_search", os.path.join(PICK_DIR, "spotify_search.py")
                )
                session = spotify.Session(os.path.join(work, "captured.json"))
            data = session.search(term)
            pause = 1.5
        data["term"] = term
        with open(path + ".tmp", "w", encoding="utf-8") as handle:
            json.dump(data, handle, ensure_ascii=False)
        os.replace(path + ".tmp", path)
        done += 1
        if done % 50 == 0:
            print(
                time.strftime("%H:%M:%S"), service, done, urllib.parse.quote(term)[:40], flush=True
            )
        time.sleep(pause)
    print("all done", service, done, flush=True)


if __name__ == "__main__":
    main()
