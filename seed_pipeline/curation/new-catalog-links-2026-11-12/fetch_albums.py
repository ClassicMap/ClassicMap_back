# ruff: noqa: E501 — 한국어 설명을 그대로 둔다.
"""후보 앨범(want_<service>.txt, pick.py want 가 적은 것)의 전체 트랙을 받아 <작업 폴더>/<service>_albums/<id>.json 에 둔다.

- Apple: iTunes Lookup(us, song, 200) 을 20개씩 묶어 3.3초 간격. 묶음 응답이 앨범 트랙 수(trackCount)보다 적게 오면
  그 앨범만 따로 다시 묻는다(트랙 수의 80% 미만일 때). Lookup 이 빈 앨범은 없어진 앨범이다(빈 결과로 둔다).
- Spotify: 임베드 페이지(open.spotify.com/embed/album/<id>, 앞 100곡) → iTunes 꼴(../piece-album-links-2026-11-08/spotify_pick.album_tracks).
iTunes 는 같은 IP 의 다른 작업과 나눠 쓰므로 검색(search.py apple)이 끝난 뒤에 돌린다.

사용: uv run python fetch_albums.py <작업 폴더> apple|spotify
"""

from __future__ import annotations

import json
import os
import sys
import time
import urllib.parse
from collections import defaultdict
from typing import Any

from common import PICK_DIR, load_module


def lookup(apple: Any, ids: list[str]) -> dict[str, list[dict[str, Any]]]:
    query = urllib.parse.urlencode(
        {"id": ",".join(ids), "entity": "song", "limit": 200, "country": "us"}
    )
    data: dict[str, Any] = apple.get(f"https://itunes.apple.com/lookup?{query}")
    by_album: dict[str, list[dict[str, Any]]] = defaultdict(list)
    for item in data.get("results", []):
        album = str(item.get("collectionId"))
        if album in ids:
            by_album[album].append(item)
    return by_album


def fetch_apple(work: str, ids: list[str]) -> None:
    apple: Any = load_module("apple_pick", os.path.join(PICK_DIR, "apple_pick.py"))
    out = os.path.join(work, "apple_albums")
    os.makedirs(out, exist_ok=True)
    todo = [a for a in ids if not os.path.exists(os.path.join(out, f"{a}.json"))]
    print("apple albums", len(todo), flush=True)
    for start in range(0, len(todo), 20):
        chunk = todo[start : start + 20]
        by_album = lookup(apple, chunk)
        for album in chunk:
            items = by_album.get(album, [])
            coll = next((i for i in items if i.get("wrapperType") == "collection"), None)
            tracks = [i for i in items if i.get("wrapperType") == "track"]
            # trackCount 에는 영상·부클릿처럼 song 이 아닌 것도 들어 하나쯤 모자란 것은 그대로 둔다
            if coll and len(tracks) < min(int(coll.get("trackCount") or 0), 200) * 0.8:
                items = lookup(apple, [album]).get(album, items)
            with open(os.path.join(out, f"{album}.json"), "w", encoding="utf-8") as handle:
                json.dump({"results": items}, handle, ensure_ascii=False)
        if start // 20 % 10 == 0:
            print(time.strftime("%H:%M:%S"), "apple", start + len(chunk), flush=True)


def fetch_spotify(work: str, ids: list[str]) -> None:
    spotify: Any = load_module("spotify_pick", os.path.join(PICK_DIR, "spotify_pick.py"))
    out = os.path.join(work, "spotify_albums")
    os.makedirs(out, exist_ok=True)
    spotify.RAW = out
    todo = [a for a in ids if not os.path.exists(os.path.join(out, f"{a}.json"))]
    print("spotify albums", len(todo), flush=True)
    for count, album in enumerate(todo, start=1):
        # 받은 앨범은 album_tracks 가 RAW 에 쓰고 0.8초 쉰다. 막힌 응답은 쓰지 않는다
        spotify.album_tracks(album)
        if count % 100 == 0:
            print(time.strftime("%H:%M:%S"), "spotify", count, flush=True)


def main() -> None:
    work, service = sys.argv[1], sys.argv[2]
    with open(os.path.join(work, f"want_{service}.txt"), encoding="utf-8") as handle:
        ids = [line.strip() for line in handle if line.strip()]
    if service == "apple":
        fetch_apple(work, ids)
    else:
        fetch_spotify(work, ids)
    print("done", service, flush=True)


if __name__ == "__main__":
    main()
