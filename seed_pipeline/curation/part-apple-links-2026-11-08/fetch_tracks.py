"""작품에 붙은 Apple Music 앨범의 트랙 목록을 iTunes Lookup(공개, 키 없음)으로 받는다.

앨범마다 raw/<앨범 ID>.json 에 둔다.

이미 받은 앨범은 건너뛴다(이어 받기). 분당 20회쯤 제한이라 3.2초 간격으로 부른다.
사용: python3 -I fetch_tracks.py <parts.tsv> <raw 폴더>
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

UA = "ClassicMapResearch/1.0"


def album_of(url: str) -> tuple[str, str] | None:
    m = re.match(r"https://music\.apple\.com/([a-z]{2})/album/[^/]*/(\d+)$", url.strip())
    return (m.group(1), m.group(2)) if m else None


def main() -> None:
    parts_path, raw = sys.argv[1], sys.argv[2]
    albums: dict[str, str] = {}
    with open(parts_path, encoding="utf-8") as handle:
        for row in csv.DictReader(handle, delimiter="\t"):
            found = album_of(row["apple_music_url"])
            if found:
                albums[found[1]] = found[0]
    todo = [a for a in sorted(albums) if not os.path.exists(f"{raw}/{a}.json")]
    print(f"albums {len(albums)} todo {len(todo)}", flush=True)
    for index, album in enumerate(todo, 1):
        url = f"https://itunes.apple.com/lookup?id={album}&entity=song&limit=200&country={albums[album]}"
        for attempt in range(5):
            try:
                request = urllib.request.Request(url, headers={"User-Agent": UA})
                with urllib.request.urlopen(request, timeout=30) as response:
                    body = response.read()
                json.loads(body)
                with open(f"{raw}/{album}.json", "wb") as handle:
                    handle.write(body)
                break
            except (urllib.error.URLError, TimeoutError, json.JSONDecodeError) as error:
                wait = 20 * (attempt + 1)
                print(f"retry {album} {error} wait {wait}", flush=True)
                time.sleep(wait)
        if index % 50 == 0:
            print(index, flush=True)
        time.sleep(3.2)
    print("DONE", flush=True)


if __name__ == "__main__":
    main()
