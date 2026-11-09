"""작품 링크(Apple Music·Spotify)가 가리키는 앨범·트랙을 받는다.

- Apple Music 앨범: iTunes Lookup(공개, 키 없음)에 앨범 ID 를 20개씩 묶어 묻는다(entity=song,
  앨범마다 트랙 200개까지). 분당 20회쯤 제한이라 3.3초 간격. apple_raw/<앨범 ID>.json
- Apple Music 앨범(apple-page): Lookup 이 막힐 때 앨범 웹 페이지의 schema.org 데이터
  (트랙 이름·주소)를 네 갈래로 받아 Lookup 과 같은 꼴로 둔다. 같은 apple_raw 에 쓰고,
  먼저 받은 쪽을 쓴다.
- Spotify 앨범: 임베드 페이지의 트랙 목록(../nested-part-links-2026-11-09/fetch_spotify_tracks.py)을
  네 갈래로 받는다. spotify_raw/<앨범 ID>.json
- Spotify 트랙: 임베드 페이지(embed/track/<id>)의 이름·아티스트. spotify_track_raw/<트랙 ID>.json
이미 받은 것은 건너뛴다(이어 받기). 막힌 응답은 저장하지 않는다.
사용: python3 -I fetch_links.py <links.tsv> <작업 폴더> apple|spotify|spotify-track
"""

from __future__ import annotations

import csv
import importlib.util
import json
import os
import re
import sys
import time
import urllib.error
import urllib.request
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
from types import ModuleType
from typing import Any

UA = "Mozilla/5.0 (ClassicMapResearch/1.0)"
NEXT_DATA = re.compile(r'<script id="__NEXT_DATA__" type="application/json">(.*?)</script>', re.S)
SPOTIFY_PATH = (
    Path(__file__).resolve().parent.parent
    / "nested-part-links-2026-11-09"
    / "fetch_spotify_tracks.py"
)


def _load_spotify() -> ModuleType:
    spec = importlib.util.spec_from_file_location("fetch_spotify_tracks", SPOTIFY_PATH)
    if spec is None or spec.loader is None:
        raise ImportError(str(SPOTIFY_PATH))
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def get(url: str) -> bytes | None:
    for attempt in range(6):
        try:
            request = urllib.request.Request(url, headers={"User-Agent": UA})
            with urllib.request.urlopen(request, timeout=40) as response:
                body: bytes = response.read()
                return body
        except urllib.error.HTTPError as error:
            if error.code == 404:
                return b""
            time.sleep(20 * (attempt + 1))
        except OSError:
            time.sleep(10 * (attempt + 1))
    return None


def apple(rows: list[dict[str, str]], work: str) -> None:
    albums: dict[str, str] = {}
    for row in rows:
        m = re.match(
            r"https://music\.apple\.com/([a-z]{2})/album/[^/]*/(\d+)", row["apple_music_url"]
        )
        if m:
            albums.setdefault(m.group(2), m.group(1))
    raw = f"{work}/apple_raw"
    todo = [a for a in sorted(albums) if not os.path.exists(f"{raw}/{a}.json")]
    print(f"apple albums {len(albums)} todo {len(todo)}", flush=True)
    by_country: dict[str, list[str]] = {}
    for album in todo:
        by_country.setdefault(albums[album], []).append(album)
    batches = [
        (country, ids[i : i + 20])
        for country, ids in by_country.items()
        for i in range(0, len(ids), 20)
    ]
    for index, (country, ids) in enumerate(batches, 1):
        body = get(
            "https://itunes.apple.com/lookup?id="
            + ",".join(ids)
            + f"&entity=song&limit=200&country={country}"
        )
        if body:
            results: list[dict[str, Any]] = json.loads(body).get("results", [])
            for album in ids:
                mine = [r for r in results if str(r.get("collectionId")) == album]
                # 없어진 앨범도 빈 결과로 남겨 다시 묻지 않는다
                with open(f"{raw}/{album}.json", "w", encoding="utf-8") as handle:
                    json.dump({"results": mine}, handle, ensure_ascii=False)
        else:
            print(f"failed batch {ids[0]}", flush=True)
        if index % 25 == 0:
            print(index, "/", len(batches), flush=True)
        time.sleep(3.3)
    print("DONE apple", flush=True)


LD_JSON = re.compile(r"<script[^>]*application/ld\+json[^>]*>(.*?)</script>", re.S)


def apple_page_album(album: str, country: str = "us") -> list[dict[str, Any]] | None:
    """앨범 웹 페이지의 schema.org 트랙 목록을 Lookup 꼴로. 받지 못하면 None."""
    body = get(f"https://music.apple.com/{country}/album/{album}")
    if body is None:
        return None
    m = LD_JSON.search(body.decode("utf-8")) if body else None
    data: dict[str, Any] = json.loads(m.group(1)) if m else {}
    name = str(data.get("name", ""))
    by = data.get("byArtist") or []
    artist = ", ".join(str(a.get("name", "")) for a in (by if isinstance(by, list) else [by]))
    results: list[dict[str, Any]] = []
    for number, track in enumerate(data.get("tracks") or [], start=1):
        song = re.search(r"/(\d+)$", str(track.get("url", "")))
        if not song:
            continue
        slug = re.sub(r"[^a-z0-9]+", "-", str(track.get("name", "")).lower()).strip("-") or "track"
        results.append(
            {
                "wrapperType": "track",
                "trackId": int(song.group(1)),
                "trackName": track.get("name", ""),
                "trackViewUrl": f"https://music.apple.com/{country}/album/{slug}/{album}"
                f"?i={song.group(1)}",
                "collectionId": int(album),
                "collectionName": name,
                "artistName": artist,
                "discNumber": 1,
                "trackNumber": number,
            }
        )
    return results


def apple_page(rows: list[dict[str, str]], work: str) -> None:
    albums: dict[str, str] = {}
    for row in rows:
        m = re.match(
            r"https://music\.apple\.com/([a-z]{2})/album/[^/]*/(\d+)", row["apple_music_url"]
        )
        if m:
            albums.setdefault(m.group(2), m.group(1))
    raw = f"{work}/apple_raw"
    todo = [a for a in sorted(albums, reverse=True) if not os.path.exists(f"{raw}/{a}.json")]
    print(f"apple pages todo {len(todo)}", flush=True)

    def one(album: str) -> bool:
        if os.path.exists(f"{raw}/{album}.json"):
            return True
        results = apple_page_album(album, albums[album])
        if results is None:
            return False
        temp = f"{raw}/.{album}.json"
        with open(temp, "w", encoding="utf-8") as handle:
            json.dump({"results": results, "source": "page"}, handle, ensure_ascii=False)
        os.replace(temp, f"{raw}/{album}.json")
        time.sleep(0.3)
        return True

    done = failed = 0
    with ThreadPoolExecutor(max_workers=4) as pool:
        for ok in pool.map(one, todo):
            done += 1
            failed += 0 if ok else 1
            if done % 200 == 0:
                print(done, "/", len(todo), "failed", failed, flush=True)
    print(f"DONE apple-page failed {failed}", flush=True)


def spotify(rows: list[dict[str, str]], work: str) -> None:
    module = _load_spotify()
    albums = sorted(
        {
            m.group(1)
            for row in rows
            if (m := re.search(r"/album/([A-Za-z0-9]+)", row["spotify_url"]))
        }
    )
    raw = f"{work}/spotify_raw"
    todo = [a for a in albums if not os.path.exists(f"{raw}/{a}.json")]
    print(f"spotify albums {len(albums)} todo {len(todo)}", flush=True)

    def one(album: str) -> bool:
        results = module.fetch(album)
        if results is None:
            return False
        with open(f"{raw}/{album}.json", "w", encoding="utf-8") as handle:
            json.dump({"results": results}, handle, ensure_ascii=False)
        time.sleep(0.5)
        return True

    done = failed = 0
    with ThreadPoolExecutor(max_workers=4) as pool:
        for ok in pool.map(one, todo):
            done += 1
            failed += 0 if ok else 1
            if done % 100 == 0:
                print(done, "/", len(todo), "failed", failed, flush=True)
    print(f"DONE spotify failed {failed}", flush=True)


def spotify_track(rows: list[dict[str, str]], work: str) -> None:
    tracks = sorted(
        {
            m.group(1)
            for row in rows
            if (m := re.search(r"/track/([A-Za-z0-9]+)", row["spotify_url"]))
        }
    )
    raw = f"{work}/spotify_track_raw"
    for track in tracks:
        if os.path.exists(f"{raw}/{track}.json"):
            continue
        body = get(f"https://open.spotify.com/embed/track/{track}")
        m = NEXT_DATA.search(body.decode("utf-8")) if body else None
        if not m:
            print(f"failed {track}", flush=True)
            continue
        entity = json.loads(m.group(1))["props"]["pageProps"]["state"]["data"]["entity"]
        out = {
            "trackName": entity.get("name", ""),
            "artistName": ", ".join(a.get("name", "") for a in entity.get("artists") or []),
        }
        with open(f"{raw}/{track}.json", "w", encoding="utf-8") as handle:
            json.dump(out, handle, ensure_ascii=False)
        time.sleep(0.8)
    print("DONE spotify-track", flush=True)


def main() -> None:
    links, work, kind = sys.argv[1], sys.argv[2], sys.argv[3]
    with open(links, encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle, delimiter="\t"))
    {
        "apple": apple,
        "apple-page": apple_page,
        "spotify": spotify,
        "spotify-track": spotify_track,
    }[kind](rows, work)


if __name__ == "__main__":
    main()
