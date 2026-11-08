"""apple_search.py 결과(search_raw/)에서 작품마다 Apple Music 앨범을 고른다(album_pick.pick).

'partial' 앨범은 iTunes Lookup 으로 앨범 트랙을 다 받아 다시 세고, 못 찾았거나 여전히 partial 이면
짧은 검색어(성 + 작품번호)로 한 번 더 찾는다. Lookup·두 번째 검색은 3.3초 간격.
결과: <작업 폴더>/picks-final.jsonl, albums/<album_id>.json(match.py 가 읽는 앨범 트랙).
사용: uv run python apple_pick.py <작업 폴더> candidates-fix.tsv candidates.tsv
"""

from __future__ import annotations

import csv
import json
import os
import sys
import time
import urllib.error
import urllib.parse
import urllib.request
from collections import defaultdict
from typing import Any

from album_pick import pick
from apple_search import UA, fetch, short_term_of

WORK = "."
LOOKUP = SECOND = ALBUMS = ""


def get(url: str) -> dict[str, Any]:
    for attempt in range(6):
        try:
            req = urllib.request.Request(url, headers={"User-Agent": UA})
            with urllib.request.urlopen(req, timeout=40) as res:
                data: dict[str, Any] = json.load(res)
            time.sleep(3.3)
            return data
        except urllib.error.HTTPError as err:
            if err.code in (403, 429) or err.code >= 500:
                time.sleep(30 * (attempt + 1))
                continue
            raise
        except (urllib.error.URLError, OSError):
            time.sleep(15 * (attempt + 1))
    raise RuntimeError(f"failed: {url}")


def lookup(album_id: str) -> list[dict[str, Any]]:
    path = os.path.join(LOOKUP, f"{album_id}.json")
    if not os.path.exists(path):
        query = urllib.parse.urlencode(
            {"id": album_id, "entity": "song", "limit": 200, "country": "us"}
        )
        data = get(f"https://itunes.apple.com/lookup?{query}")
        with open(path, "w", encoding="utf-8") as handle:
            json.dump(data, handle, ensure_ascii=False)
    with open(path, encoding="utf-8") as handle:
        results: list[dict[str, Any]] = json.load(handle).get("results", [])
    return results


def second_search(row: dict[str, str], first_term: str) -> list[dict[str, Any]]:
    term = short_term_of(row)
    if term == first_term:
        return []
    path = os.path.join(SECOND, f"{row['piece_id']}.json")
    if not os.path.exists(path):
        data = fetch(term)
        data["term"] = term
        with open(path, "w", encoding="utf-8") as handle:
            json.dump(data, handle, ensure_ascii=False)
        time.sleep(3.3)
    with open(path, encoding="utf-8") as handle:
        results: list[dict[str, Any]] = json.load(handle).get("results", [])
    return results


def settle(row: dict[str, str], results: list[dict[str, Any]]) -> dict[str, Any] | None:
    """검색 결과로 고르고, 앨범 트랙이 모자라면 Lookup 으로 다시 센다."""
    found = pick(row, results)
    if found and found["status"] == "partial":
        full = pick(row, lookup(found["albumId"]))
        if full and full["albumId"] == found["albumId"]:
            full["lookup"] = True
            found = full
    return found


def main() -> None:
    global WORK, LOOKUP, SECOND, ALBUMS
    WORK = sys.argv[1]
    LOOKUP, SECOND, ALBUMS = (
        os.path.join(WORK, n) for n in ("lookup_raw", "search_raw_b", "albums")
    )
    for folder in (LOOKUP, SECOND, ALBUMS):
        os.makedirs(folder, exist_ok=True)
    rows: list[dict[str, str]] = []
    seen: set[str] = set()
    for source in sys.argv[2:]:
        with open(source, encoding="utf-8") as handle:
            for row in csv.DictReader(handle, delimiter="\t"):
                if row["piece_id"] not in seen:
                    seen.add(row["piece_id"])
                    rows.append(row)
    stats: dict[str, int] = defaultdict(int)
    picks = []
    tracks_of: dict[str, dict[str, dict[str, Any]]] = defaultdict(dict)
    for count, row in enumerate(rows, start=1):
        path = os.path.join(WORK, "search_raw", f"{row['piece_id']}.json")
        if not os.path.exists(path):
            stats["not_fetched"] += 1
            continue
        with open(path, encoding="utf-8") as handle:
            first = json.load(handle)
        results = first.get("results", [])
        found = settle(row, results)
        if not found or found["status"] == "partial":
            extra = second_search(row, str(first.get("term", "")))
            again = settle(row, results + extra)
            if again and (not found or again["status"] != "partial"):
                again["second"] = True
                found = again
            results = results + extra
        if not found:
            stats["no_album"] += 1
            continue
        stats[found["status"]] += 1
        picks.append(found)
        album = found["albumId"]
        source_tracks = lookup(album) if found.get("lookup") else results
        for track in source_tracks:
            if str(track.get("collectionId")) == album and track.get("wrapperType") == "track":
                tracks_of[album][str(track["trackId"])] = track
        if count % 200 == 0:
            print(time.strftime("%H:%M:%S"), count, dict(stats), flush=True)
    with open(os.path.join(WORK, "picks-final.jsonl"), "w", encoding="utf-8") as handle:
        for item in picks:
            handle.write(json.dumps(item, ensure_ascii=False) + "\n")
    for album, tracks in tracks_of.items():
        with open(os.path.join(ALBUMS, f"{album}.json"), "w", encoding="utf-8") as handle:
            json.dump({"results": list(tracks.values())}, handle, ensure_ascii=False)
    print(json.dumps(stats), flush=True)


if __name__ == "__main__":
    main()
