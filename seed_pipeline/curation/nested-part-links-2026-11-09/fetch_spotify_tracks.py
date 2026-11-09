"""작품에 붙은 Spotify 앨범의 트랙 목록을 임베드 페이지(로그인 없음)에서 받는다.

`open.spotify.com/embed/album/<id>` 의 `__NEXT_DATA__` → `entity.trackList`(앨범 순서)를
match.py 가 읽는 꼴(iTunes Lookup 과 같은 `results`)로 raw/<앨범 ID>.json 에 둔다.
이미 받은 앨범은 건너뛴다(이어 받기). 막힌 응답은 저장하지 않는다.
사용: python3 -I fetch_spotify_tracks.py <parts.tsv> <raw 폴더>
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

UA = "Mozilla/5.0 (ClassicMapResearch/1.0)"
NEXT_DATA = re.compile(r'<script id="__NEXT_DATA__" type="application/json">(.*?)</script>', re.S)


def album_of(url: str) -> str | None:
    m = re.match(r"https://open\.spotify\.com/album/([A-Za-z0-9]+)$", url.strip())
    return m.group(1) if m else None


def fetch(album: str) -> list[dict[str, Any]] | None:
    """앨범 트랙. 없는 앨범이면 빈 목록, 받지 못하면 None."""
    html = ""
    for attempt in range(5):
        try:
            request = urllib.request.Request(
                f"https://open.spotify.com/embed/album/{album}", headers={"User-Agent": UA}
            )
            with urllib.request.urlopen(request, timeout=30) as response:
                html = response.read().decode("utf-8")
            break
        except urllib.error.HTTPError as error:
            if error.code == 404:
                return []
            time.sleep(20 * (attempt + 1))
        except OSError:
            time.sleep(10 * (attempt + 1))
    else:
        return None
    m = NEXT_DATA.search(html)
    try:
        entity = (
            json.loads(m.group(1))["props"]["pageProps"]["state"]["data"]["entity"] if m else None
        )
    except (KeyError, TypeError, ValueError):
        entity = None
    if not entity:
        return None
    results = []
    for number, track in enumerate(entity.get("trackList") or [], start=1):
        track_id = str(track.get("uri", "")).rsplit(":", 1)[-1]
        results.append(
            {
                "wrapperType": "track",
                "trackId": track_id,
                "trackName": track.get("title", ""),
                "trackViewUrl": f"https://open.spotify.com/track/{track_id}",
                "collectionId": album,
                "collectionName": entity.get("name", ""),
                "collectionViewUrl": f"https://open.spotify.com/album/{album}",
                "artistName": track.get("subtitle", ""),
                "discNumber": 1,
                "trackNumber": number,
            }
        )
    return results


def main() -> None:
    parts_path, raw = sys.argv[1], sys.argv[2]
    albums: set[str] = set()
    with open(parts_path, encoding="utf-8") as handle:
        for row in csv.DictReader(handle, delimiter="\t"):
            found = album_of(row["spotify_url"])
            if found:
                albums.add(found)
    todo = [a for a in sorted(albums) if not os.path.exists(f"{raw}/{a}.json")]
    print(f"albums {len(albums)} todo {len(todo)}", flush=True)
    failed = 0
    for index, album in enumerate(todo, 1):
        results = fetch(album)
        if results is None:
            failed += 1
            print(f"failed {album}", flush=True)
        else:
            with open(f"{raw}/{album}.json", "w", encoding="utf-8") as handle:
                json.dump({"results": results}, handle, ensure_ascii=False)
        if index % 50 == 0:
            print(index, flush=True)
        time.sleep(0.8)
    print(f"DONE failed {failed}", flush=True)


if __name__ == "__main__":
    main()
