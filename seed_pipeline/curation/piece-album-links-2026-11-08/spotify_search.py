"""세트마다 Spotify 웹 플레이어 트랙 검색(searchTracks, 100개)을 불러 <out>/<piece_id>.json 에 둔다.

공개 Web API 는 웹 플레이어 토큰으로 429 가 나서, 웹 플레이어가 보내는 요청(spotify_capture.cjs 가
잡은 주소·헤더·본문)을 검색어만 바꿔 다시 보낸다. 토큰이 끝나면(401) 또는 40분마다 새로 잡는다.
잡은 요청(captured.json)에는 토큰이 있으니 작업 폴더에만 두고 커밋하지 않는다.
검색어는 apple_search.term_of 와 같다. 이미 받은 세트는 건너뛴다. 1.5초 간격.
사용: uv run python spotify_search.py <작업 폴더>/sets.tsv <작업 폴더>/search_raw
"""

from __future__ import annotations

import csv
import json
import os
import subprocess
import sys
import time
import urllib.error
import urllib.request
from typing import Any

from apple_search import term_of

HERE = os.path.dirname(os.path.abspath(__file__))
KEEP = {
    "authorization",
    "client-token",
    "app-platform",
    "spotify-app-version",
    "content-type",
    "accept",
    "accept-language",
    "user-agent",
}


class Session:
    """웹 플레이어 검색 요청을 다시 보내는 세션. captured 는 잡은 요청을 쓸 파일."""

    def __init__(self, captured: str) -> None:
        self.captured = captured
        self.refresh()

    def refresh(self) -> None:
        script = os.path.join(HERE, "spotify_capture.cjs")
        subprocess.run(["node", script, self.captured], check=True, stdout=subprocess.DEVNULL)
        with open(self.captured, encoding="utf-8") as handle:
            captured = json.load(handle)
        request = next(
            c
            for c in captured
            if c["body"] and json.loads(c["body"])["operationName"] == "searchTracks"
        )
        self.url = request["url"]
        self.body = json.loads(request["body"])
        self.headers = {k: v for k, v in request["headers"].items() if k.lower() in KEEP}
        self.at = time.time()

    def search(self, term: str) -> dict[str, Any]:
        if time.time() - self.at > 40 * 60:
            self.refresh()
        body = dict(self.body)
        body["variables"] = dict(body["variables"], searchTerm=term, limit=100, offset=0)
        for attempt in range(6):
            req = urllib.request.Request(
                self.url, data=json.dumps(body).encode(), headers=self.headers, method="POST"
            )
            try:
                with urllib.request.urlopen(req, timeout=40) as res:
                    data: dict[str, Any] = json.load(res)
                    return data
            except urllib.error.HTTPError as err:
                if err.code == 401:
                    self.refresh()
                    continue
                if err.code == 429 or err.code >= 500:
                    wait = int(err.headers.get("Retry-After") or 0) or 30 * (attempt + 1)
                    time.sleep(min(wait, 300))
                    continue
                raise
            except (urllib.error.URLError, OSError):
                time.sleep(15 * (attempt + 1))
        raise RuntimeError(f"failed: {term}")


def main() -> None:
    src, out = sys.argv[1], sys.argv[2]
    os.makedirs(out, exist_ok=True)
    with open(src, encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle, delimiter="\t"))
    session = Session(os.path.join(os.path.dirname(os.path.abspath(out)), "captured.json"))
    done = 0
    for row in rows:
        path = os.path.join(out, f"{row['piece_id']}.json")
        if os.path.exists(path):
            continue
        term = term_of(row)
        data = session.search(term)
        data["term"] = term
        with open(path + ".tmp", "w", encoding="utf-8") as handle:
            json.dump(data, handle, ensure_ascii=False)
        os.replace(path + ".tmp", path)
        done += 1
        if done % 50 == 0:
            print(time.strftime("%H:%M:%S"), "fetched", done, flush=True)
        time.sleep(1.5)
    print("all done", flush=True)


if __name__ == "__main__":
    main()
