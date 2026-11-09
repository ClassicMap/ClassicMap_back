"""애매한 링크(의심·어긋남·전집 상자)의 앨범 트랙을 끝까지 받는다.

fetch_links.py 는 Apple Lookup 200곡, Spotify 임베드 100곡에서 끊긴다. 전집 상자는 그 뒤에
작품이 있을 수 있어 끝까지 받는다.
- Apple Music: 앨범 웹 페이지의 schema.org 트랙 목록(fetch_links.apple_page_album, 300곡쯤까지)
- Spotify: 웹 플레이어의 getAlbum 요청(spotify_album_capture.cjs 가 잡음)을 offset 만 바꿔
  다시 보낸다. 잡은 요청(captured_album.json)에는 토큰이 있어 작업 폴더에만 두고 커밋하지 않는다.
결과는 <작업 폴더>/full_raw/<서비스>/<앨범 ID>.json(Lookup 꼴). 이미 받은 것은 건너뛴다.
사용: uv run python fetch_full_albums.py <decisions.jsonl> apple|spotify <작업 폴더>
"""

from __future__ import annotations

import importlib.util
import json
import os
import re
import subprocess
import sys
import time
import urllib.error
import urllib.request
from pathlib import Path
from types import ModuleType
from typing import Any

HERE = Path(__file__).resolve().parent
AMBIGUOUS = ("doubt", "box", "conflict")
KEEP_HEADERS = {
    "authorization",
    "client-token",
    "app-platform",
    "spotify-app-version",
    "content-type",
    "accept",
    "accept-language",
    "user-agent",
}


def _load(path: Path, name: str) -> ModuleType:
    spec = importlib.util.spec_from_file_location(name, path)
    if spec is None or spec.loader is None:
        raise ImportError(str(path))
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


class AlbumSession:
    """getAlbum 을 다시 보내는 세션. 토큰이 끝나면(401) 새로 잡는다."""

    def __init__(self, captured: str, sample_album: str) -> None:
        self.captured = captured
        self.sample = sample_album
        self.request: dict[str, Any] = {}

    def capture(self) -> None:
        subprocess.run(
            ["node", str(HERE / "spotify_album_capture.cjs"), self.sample, self.captured],
            check=True,
            timeout=120,
        )
        with open(self.captured, encoding="utf-8") as handle:
            seen = json.load(handle)
        self.request = next(
            s
            for s in seen
            if s.get("body") and json.loads(s["body"]).get("operationName") == "getAlbum"
        )

    def page(self, album: str, offset: int) -> dict[str, Any]:
        if not self.request:
            self.capture()
        for attempt in range(4):
            body = json.loads(self.request["body"])
            body["variables"].update(
                {"uri": f"spotify:album:{album}", "offset": offset, "limit": 100}
            )
            headers = {
                k: v for k, v in self.request["headers"].items() if k.lower() in KEEP_HEADERS
            }
            request = urllib.request.Request(
                self.request["url"], data=json.dumps(body).encode(), headers=headers, method="POST"
            )
            try:
                with urllib.request.urlopen(request, timeout=30) as response:
                    data: dict[str, Any] = json.load(response)
                    return data
            except urllib.error.HTTPError as error:
                if error.code == 401:
                    self.capture()
                    continue
                time.sleep(20 * (attempt + 1))
            except OSError:
                time.sleep(10 * (attempt + 1))
        raise RuntimeError(f"getAlbum failed: {album}")


def spotify_album(session: AlbumSession, album: str) -> list[dict[str, Any]]:
    results: list[dict[str, Any]] = []
    offset = 0
    while True:
        data = session.page(album, offset)
        union = (data.get("data") or {}).get("albumUnion") or {}
        tracks = union.get("tracksV2") or {}
        items = tracks.get("items") or []
        for item in items:
            track = item.get("track") or {}
            track_id = str(track.get("uri", "")).rsplit(":", 1)[-1]
            artists = ", ".join(
                a.get("profile", {}).get("name", "")
                for a in (track.get("artists") or {}).get("items", [])
            )
            results.append(
                {
                    "wrapperType": "track",
                    "trackId": track_id,
                    "trackName": track.get("name", ""),
                    "trackViewUrl": f"https://open.spotify.com/track/{track_id}",
                    "collectionId": album,
                    "collectionName": union.get("name", ""),
                    "artistName": artists,
                    "discNumber": track.get("discNumber") or 1,
                    "trackNumber": len(results) + 1,
                }
            )
        offset += len(items)
        if not items or offset >= int(tracks.get("totalCount") or 0):
            return results
        time.sleep(0.5)


def main() -> None:
    decisions, service, work = sys.argv[1], sys.argv[2], sys.argv[3]
    with open(decisions, encoding="utf-8") as handle:
        rows = [json.loads(line) for line in handle if line.strip()]
    pattern = r"/(\d+)(?:\?|$)" if service == "apple" else r"/album/([A-Za-z0-9]+)"
    albums = sorted(
        {
            m.group(1)
            for row in rows
            if row["action"] == "keep" and row["verdict"] in AMBIGUOUS
            for m in [re.search(pattern, row["current"])]
            if m
        }
    )
    out = os.path.join(work, "full_raw", service)
    os.makedirs(out, exist_ok=True)
    todo = [a for a in albums if not os.path.exists(f"{out}/{a}.json")]
    print(f"{service} albums {len(albums)} todo {len(todo)}", flush=True)
    links = _load(HERE / "fetch_links.py", "fetch_links")
    session = AlbumSession(os.path.join(work, "captured_album.json"), todo[0]) if todo else None
    for album in todo:
        if service == "apple":
            results = links.apple_page_album(album)
            time.sleep(1.0)
        else:
            assert session is not None
            results = spotify_album(session, album)
        if results is None:
            print(f"failed {album}", flush=True)
            continue
        with open(f"{out}/{album}.json", "w", encoding="utf-8") as handle:
            json.dump({"results": results}, handle, ensure_ascii=False)
    print("DONE", flush=True)


if __name__ == "__main__":
    main()
