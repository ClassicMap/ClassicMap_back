# ruff: noqa: E501 — 한국어 설명을 그대로 둔다.
"""사운드트랙 맨 위 작품마다 Apple Music·Spotify 앨범 후보를 모으고 후보 앨범의 트랙 목록을 받는다.

- 검색어: 작곡가 성 + 작품 원어 제목의 핵심(사운드트랙 꼬리·작품번호를 뗀 것). 6차 음반 묶음은 음반 이름.
- Apple: iTunes Search(us, entity=album, 25개, 3.3초 간격 — 분당 20회쯤에서 막힘) → apple_search/<piece>.json,
  후보 앨범과 MusicBrainz url-rels 앨범(mb_urls.json)의 트랙은 iTunes Lookup(20개 묶음) → apple_albums/<id>.json.
  Lookup 이 빈 앨범은 없어진 앨범이다(MusicBrainz 의 옛 iTunes id 가 그렇다).
- Spotify: 웹 플레이어 트랙 검색(../piece-album-links-2026-11-08/spotify_search.py 의 Session, 1.5초 간격)
  → spotify_search/<piece>.json, 후보·url-rels 앨범 트랙은 임베드 페이지 → spotify_albums/<id>.json.
- 받은 것은 작업 폴더에 남겨 다시 부르지 않는다(커밋하지 않음).

사용: PLAYWRIGHT_MODULE=<playwright> uv run python fetch_albums.py <작업 폴더> [apple|spotify]
"""

from __future__ import annotations

import importlib.util
import json
import os
import re
import sys
import time
import urllib.error
import urllib.parse
import urllib.request
from typing import Any

from common import CURATION, SOUNDTRACK_TAIL, key_title, norm, read_tsv, wave6_groups

UA = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0 Safari/537.36"
PICK_DIR = os.path.join(CURATION, "piece-album-links-2026-11-08")


def surname(name: str) -> str:
    return name.replace("J. A. C. ", "").split()[-1]


def split_cue(row: dict[str, str]) -> tuple[str, str]:
    """「Le Mari de la coiffeuse: Michael Nyman 5」 꼴 낱곡 → (영화 이름, 곡 이름). 아니면 (제목, "")."""
    title = row["title_en"] or row["title"]
    if ": " in title and not re.search(r"(soundtrack|score)\b", title.split(": ", 1)[1], re.I):
        head, tail = title.split(": ", 1)
        return head, tail
    return title, ""


def display_key(row: dict[str, str], group: dict[str, Any] | None) -> str:
    title = str(group["rgTitle"]) if group else split_cue(row)[0]
    title = re.sub(r"\((film score|soundtrack|a time for us|\d{4})\)", "", title, flags=re.I)
    title = re.sub(r",?\s*(op\.|fp|wd)\s*\d+[a-z]?\b.*$", "", title, flags=re.I)
    title = SOUNDTRACK_TAIL.sub("", title)
    return re.sub(r"[,:\s]+$", "", title).strip()


def term_of(row: dict[str, str], group: dict[str, Any] | None) -> str:
    return f"{surname(row['english_name'])} {display_key(row, group)}"


def get_json(url: str, tries: int = 6) -> Any:
    for attempt in range(tries):
        try:
            req = urllib.request.Request(url, headers={"User-Agent": UA})
            with urllib.request.urlopen(req, timeout=40) as res:
                return json.load(res)
        except urllib.error.HTTPError as err:
            if err.code in (403, 429) or err.code >= 500:
                time.sleep(60 * (attempt + 1))
                continue
            raise
        except (urllib.error.URLError, OSError, ValueError):
            time.sleep(15 * (attempt + 1))
    raise RuntimeError(url)


def apple(work: str) -> None:
    rows = read_tsv(os.path.join(work, "top.tsv"))
    groups = wave6_groups()
    with open(os.path.join(work, "mb_urls.json"), encoding="utf-8") as handle:
        mb_urls: dict[str, dict[str, Any]] = json.load(handle)
    search_dir = os.path.join(work, "apple_search")
    album_dir = os.path.join(work, "apple_albums")
    os.makedirs(search_dir, exist_ok=True)
    os.makedirs(album_dir, exist_ok=True)
    wanted: list[str] = []
    for row in rows:
        group = groups.get((row["composer_id"], row["title"]))
        path = os.path.join(search_dir, f"{row['id']}.json")
        if not os.path.exists(path):
            term = term_of(row, group)
            query = urllib.parse.urlencode(
                {"term": term, "entity": "album", "country": "us", "limit": 25}
            )
            data = get_json(f"https://itunes.apple.com/search?{query}")
            data["term"] = term
            with open(path, "w", encoding="utf-8") as handle:
                json.dump(data, handle, ensure_ascii=False)
            time.sleep(3.3)
        with open(path, encoding="utf-8") as handle:
            data = json.load(handle)
        sur = norm(surname(row["english_name"]))
        key = key_title(display_key(row, group))
        for item in data.get("results", []):
            text = norm(item.get("collectionName", ""))
            artist = norm(item.get("artistName", ""))
            if (sur in artist or sur in text) and key and (key in text or text in key):
                wanted.append(str(item["collectionId"]))
        if not group:
            # 영화음악은 작곡가 모음 음반에 실린 경우가 많아 트랙으로도 찾는다
            song_path = os.path.join(work, "apple_search_song", f"{row['id']}.json")
            os.makedirs(os.path.dirname(song_path), exist_ok=True)
            if not os.path.exists(song_path):
                query = urllib.parse.urlencode(
                    {"term": term_of(row, group), "entity": "song", "country": "us", "limit": 50}
                )
                songs = get_json(f"https://itunes.apple.com/search?{query}")
                with open(song_path, "w", encoding="utf-8") as handle:
                    json.dump(songs, handle, ensure_ascii=False)
                time.sleep(3.3)
            with open(song_path, encoding="utf-8") as handle:
                songs = json.load(handle)
            for item in songs.get("results", []):
                text = norm(item.get("collectionName", "")) + " " + norm(item.get("artistName", ""))
                if sur in text and key and key in norm(item.get("trackName", "")):
                    wanted.append(str(item["collectionId"]))
        wanted += mb_urls.get(row["id"], {}).get("apple", [])
    todo = [
        a for a in dict.fromkeys(wanted) if not os.path.exists(os.path.join(album_dir, f"{a}.json"))
    ]
    print(f"apple albums to look up {len(todo)}", flush=True)
    for start in range(0, len(todo), 20):
        chunk = todo[start : start + 20]
        query = urllib.parse.urlencode(
            {"id": ",".join(chunk), "entity": "song", "limit": 200, "country": "us"}
        )
        data = get_json(f"https://itunes.apple.com/lookup?{query}")
        by_album: dict[str, list[dict[str, Any]]] = {a: [] for a in chunk}
        for item in data.get("results", []):
            album = str(item.get("collectionId"))
            if album in by_album:
                by_album[album].append(item)
        for album, items in by_album.items():
            with open(os.path.join(album_dir, f"{album}.json"), "w", encoding="utf-8") as handle:
                json.dump({"results": items}, handle, ensure_ascii=False)
        time.sleep(3.3)


def spotify(work: str) -> None:
    # 웹 플레이어 검색 세션은 앨범 링크 도구의 것을 그대로 쓴다(그 모듈이 같은 폴더의 apple_search 를 읽는다)
    sys.path.insert(0, PICK_DIR)
    spec = importlib.util.spec_from_file_location(
        "spotify_search", os.path.join(PICK_DIR, "spotify_search.py")
    )
    assert spec and spec.loader
    module: Any = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    Session = module.Session

    rows = read_tsv(os.path.join(work, "top.tsv"))
    groups = wave6_groups()
    with open(os.path.join(work, "mb_urls.json"), encoding="utf-8") as handle:
        mb_urls: dict[str, dict[str, Any]] = json.load(handle)
    search_dir = os.path.join(work, "spotify_search")
    album_dir = os.path.join(work, "spotify_albums")
    os.makedirs(search_dir, exist_ok=True)
    os.makedirs(album_dir, exist_ok=True)
    session: Any = None
    wanted: list[str] = []
    for row in rows:
        group = groups.get((row["composer_id"], row["title"]))
        path = os.path.join(search_dir, f"{row['id']}.json")
        if not os.path.exists(path):
            if session is None:
                session = Session(os.path.join(work, "captured.json"))
            term = term_of(row, group)
            data = session.search(term)
            data["term"] = term
            with open(path, "w", encoding="utf-8") as handle:
                json.dump(data, handle, ensure_ascii=False)
            time.sleep(1.5)
        with open(path, encoding="utf-8") as handle:
            data = json.load(handle)
        sur = norm(surname(row["english_name"]))
        key = key_title(display_key(row, group))
        for item in spotify_tracks_of_search(data):
            text = norm(item["album"])
            if not (sur in norm(item["artists"]) or sur in text) or not key:
                continue
            if key in text or text in key or (not group and key in norm(item["track"])):
                wanted.append(item["albumId"])
        wanted += mb_urls.get(row["id"], {}).get("spotify", [])
    todo = [
        a for a in dict.fromkeys(wanted) if not os.path.exists(os.path.join(album_dir, f"{a}.json"))
    ]
    print(f"spotify albums to fetch {len(todo)}", flush=True)
    for album in todo:
        tracks = embed_album(album)
        if tracks is not None:
            with open(os.path.join(album_dir, f"{album}.json"), "w", encoding="utf-8") as handle:
                json.dump(tracks, handle, ensure_ascii=False)
        time.sleep(0.8)


def spotify_tracks_of_search(data: dict[str, Any]) -> list[dict[str, str]]:
    items = (((data.get("data") or {}).get("searchV2") or {}).get("tracksV2") or {}).get(
        "items"
    ) or []
    out = []
    for item in items:
        track = (item.get("item") or {}).get("data") or {}
        album = track.get("albumOfTrack") or {}
        if not album.get("id"):
            continue
        artists = ", ".join(
            a.get("profile", {}).get("name", "")
            for a in (track.get("artists") or {}).get("items", [])
        )
        out.append(
            {
                "albumId": str(album["id"]),
                "album": str(album.get("name", "")),
                "artists": artists,
                "track": str(track.get("name", "")),
            }
        )
    return out


def embed_album(album_id: str) -> dict[str, Any] | None:
    """임베드 페이지의 앨범 이름·아티스트·트랙(앞 100곡). 막힌 응답은 None."""
    for attempt in range(5):
        try:
            req = urllib.request.Request(
                f"https://open.spotify.com/embed/album/{album_id}", headers={"User-Agent": UA}
            )
            with urllib.request.urlopen(req, timeout=30) as res:
                html = res.read().decode("utf-8")
            break
        except urllib.error.HTTPError as err:
            if err.code == 404:
                return {"name": "", "artists": "", "tracks": [], "gone": True}
            time.sleep(20 * (attempt + 1))
        except (urllib.error.URLError, OSError):
            time.sleep(10 * (attempt + 1))
    else:
        return None
    m = re.search(r'<script id="__NEXT_DATA__" type="application/json">(.*?)</script>', html, re.S)
    try:
        entity = (
            json.loads(m.group(1))["props"]["pageProps"]["state"]["data"]["entity"] if m else None
        )
    except (KeyError, TypeError, ValueError):
        entity = None
    if not entity:
        return None
    tracks = [
        {
            "id": str(t.get("uri", "")).rsplit(":", 1)[-1],
            "name": str(t.get("title", "")),
            "artists": str(t.get("subtitle", "")),
        }
        for t in entity.get("trackList") or []
    ]
    return {
        "name": str(entity.get("name", "")),
        "artists": str(entity.get("subtitle", "")),
        "tracks": tracks,
    }


def main() -> None:
    work = sys.argv[1]
    which = sys.argv[2] if len(sys.argv) > 2 else "both"
    if which in ("apple", "both"):
        apple(work)
    if which in ("spotify", "both"):
        spotify(work)
    print("done", flush=True)


if __name__ == "__main__":
    main()
