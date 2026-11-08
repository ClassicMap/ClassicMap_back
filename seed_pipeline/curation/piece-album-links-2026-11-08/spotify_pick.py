"""Spotify 검색 결과(search_raw/)에서 세트마다 앨범을 고른다.

고르는 규칙은 album_pick.pick 과 같다(Spotify 트랙을 iTunes 꼴로 바꿔 넘긴다).
- 지금 작품 링크가 앨범이고 그 앨범에 작품 트랙이 곡 수 이상 있으면, 또는 트랙 이름으로는
  못 알아봐도 앨범 이름이 이 작품을 가리키면 그대로 둔다('kept').
- 앨범 트랙 목록은 임베드 페이지(open.spotify.com/embed/album/<id>, 로그인 없음)의
  __NEXT_DATA__ 에서 받아 raw/<album_id>.json 에 둔다(0.8초 간격). 막힌 응답은 저장하지 않는다.
- --second 를 주면 못 찾았거나 일부만 든 세트를 짧은 검색어(성 + 작품번호)로 한 번 더 찾는다
  (search_raw_b/).
결과: <작업 폴더>/picks.jsonl(--second 면 picks-final.jsonl).
사용: uv run python spotify_pick.py <작업 폴더> <작업 폴더>/sets.tsv [--second]
"""

from __future__ import annotations

import csv
import json
import os
import re
import sys
import time
import urllib.error
import urllib.request
from typing import Any

import album_pick as albumpick
from apple_search import short_term_of
from spotify_search import Session

UA = (
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)"
    " AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0 Safari/537.36"
)
WORK = "."
RAW = SECOND = ""


def from_search(data: dict[str, Any]) -> list[dict[str, Any]]:
    items = (((data.get("data") or {}).get("searchV2") or {}).get("tracksV2") or {}).get(
        "items"
    ) or []
    out = []
    for item in items:
        track = (item.get("item") or {}).get("data") or {}
        album = track.get("albumOfTrack") or {}
        track_id = str(track.get("uri", "")).rsplit(":", 1)[-1]
        if not track_id or not album.get("id"):
            continue
        artists = ", ".join(
            a.get("profile", {}).get("name", "")
            for a in (track.get("artists") or {}).get("items", [])
        )
        out.append(
            {
                "wrapperType": "track",
                "trackId": track_id,
                "trackName": track.get("name", ""),
                "trackViewUrl": f"https://open.spotify.com/track/{track_id}",
                "collectionId": album["id"],
                "collectionName": album.get("name", ""),
                "collectionViewUrl": f"https://open.spotify.com/album/{album['id']}",
                "artistName": artists,
            }
        )
    return out


def album_tracks(album_id: str) -> list[dict[str, Any]]:
    """임베드 페이지의 트랙 목록(앨범 순서). raw/<id>.json 에 저장해 두고 다시 쓴다."""
    path = os.path.join(RAW, f"{album_id}.json")
    if os.path.exists(path):
        with open(path, encoding="utf-8") as handle:
            cached: list[dict[str, Any]] = json.load(handle)["results"]
        return cached
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
                return []
            time.sleep(20 * (attempt + 1))
        except (urllib.error.URLError, OSError):
            time.sleep(10 * (attempt + 1))
    else:
        return []
    m = re.search(r'<script id="__NEXT_DATA__" type="application/json">(.*?)</script>', html, re.S)
    try:
        entity = (
            json.loads(m.group(1))["props"]["pageProps"]["state"]["data"]["entity"] if m else None
        )
    except (KeyError, TypeError, ValueError):
        entity = None
    if not entity:
        # 막힌 응답일 수 있으니 저장하지 않는다
        return []
    results = []
    for number, track in enumerate(entity.get("trackList") or [], start=1):
        track_id = str(track.get("uri", "")).rsplit(":", 1)[-1]
        results.append(
            {
                "wrapperType": "track",
                "trackId": track_id,
                "trackName": track.get("title", ""),
                "trackViewUrl": f"https://open.spotify.com/track/{track_id}",
                "collectionId": album_id,
                "collectionName": entity.get("name", ""),
                "collectionViewUrl": f"https://open.spotify.com/album/{album_id}",
                "artistName": track.get("subtitle", ""),
                "discNumber": 1,
                "trackNumber": number,
            }
        )
    with open(path, "w", encoding="utf-8") as handle:
        json.dump({"results": results}, handle, ensure_ascii=False)
    time.sleep(0.8)
    return results


class Second:
    """두 번째 검색(짧은 검색어). 웹 플레이어 세션은 처음 쓸 때 연다."""

    def __init__(self) -> None:
        self.session: Any = None
        os.makedirs(SECOND, exist_ok=True)

    def results(self, row: dict[str, str], first_term: str) -> list[dict[str, Any]]:
        term = short_term_of(row)
        if term == first_term:
            return []
        path = os.path.join(SECOND, f"{row['piece_id']}.json")
        if not os.path.exists(path):
            if self.session is None:
                self.session = Session(os.path.join(WORK, "captured.json"))
            data = self.session.search(term)
            data["term"] = term
            with open(path, "w", encoding="utf-8") as handle:
                json.dump(data, handle, ensure_ascii=False)
            time.sleep(1.5)
        with open(path, encoding="utf-8") as handle:
            return from_search(json.load(handle))


def settle(row: dict[str, str], results: list[dict[str, Any]]) -> dict[str, Any] | None:
    """검색 결과로 고르고, 앨범 전체 트랙으로 다시 센다(검색 결과에는 일부만 있을 수 있다)."""
    found = albumpick.pick(row, results)
    if found:
        full = albumpick.pick(row, album_tracks(found["albumId"]))
        if full and full["albumId"] == found["albumId"]:
            found = full
    return found


def main() -> None:
    global WORK, RAW, SECOND
    WORK = sys.argv[1]
    RAW, SECOND = os.path.join(WORK, "raw"), os.path.join(WORK, "search_raw_b")
    os.makedirs(RAW, exist_ok=True)
    second = Second() if "--second" in sys.argv else None
    stats: dict[str, int] = {}
    picks = []
    with open(sys.argv[2], encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle, delimiter="\t"))
    for count, row in enumerate(rows, start=1):
        found = None
        current = re.match(
            r"https://open\.spotify\.com/album/([A-Za-z0-9]+)", row.get("current_url", "")
        )
        if current:
            # 지금 링크가 맞는 앨범이면 그대로 쓴다
            tracks = album_tracks(current.group(1))
            checked = albumpick.pick(row, tracks)
            if checked and checked["status"] in ("exact", "more"):
                found = dict(checked, status="kept")
            elif (
                not checked
                and tracks
                and albumpick.names_work(row, str(tracks[0]["collectionName"]))
            ):
                # 트랙 이름으로는 못 알아보지만 앨범 이름이 이 작품을 가리키면 지금 링크를 둔다
                found = {
                    "pieceId": int(row["piece_id"]),
                    "albumId": current.group(1),
                    "albumUrl": row["current_url"],
                    "albumName": tracks[0]["collectionName"],
                    "workTracks": 0,
                    "parts": int(row["nparts"]),
                    "status": "kept",
                    "tracks": [],
                }
        if not found:
            path = os.path.join(WORK, "search_raw", f"{row['piece_id']}.json")
            if not os.path.exists(path):
                stats["not_fetched"] = stats.get("not_fetched", 0) + 1
                continue
            with open(path, encoding="utf-8") as raw:
                first = json.load(raw)
            results = from_search(first)
            found = settle(row, results)
            if second and (not found or found["status"] == "partial"):
                again = settle(row, results + second.results(row, str(first.get("term", ""))))
                if again and (not found or again["status"] != "partial"):
                    found = dict(again, second=True)
        if not found:
            stats["no_album"] = stats.get("no_album", 0) + 1
            continue
        found["current"] = row.get("current_url", "")
        stats[found["status"]] = stats.get(found["status"], 0) + 1
        picks.append(found)
        if count % 500 == 0:
            print(time.strftime("%H:%M:%S"), count, stats, flush=True)
    name = "picks-final.jsonl" if second else "picks.jsonl"
    with open(os.path.join(WORK, name), "w", encoding="utf-8") as handle:
        for item in picks:
            handle.write(json.dumps(item, ensure_ascii=False) + "\n")
    print(json.dumps(stats), flush=True)


if __name__ == "__main__":
    main()
