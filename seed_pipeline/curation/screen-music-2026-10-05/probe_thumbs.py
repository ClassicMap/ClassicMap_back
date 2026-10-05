#!/usr/bin/env python3
"""공식 클립 영상마다 있는 YouTube 썸네일 화질을 재서 thumbs.json 에 적는다.

없는 화질을 앱이 요청하면 YouTube 가 404 를 1~2초 늦게 줘서 그림이 늦게 뜬다.
그래서 영상마다 '그 화질부터 아래가 다 있는' 가장 높은 jpg·webp 화질을 미리 재어 둔다.
build_titles.py 가 이 값을 officialClip·coverClip 의 thumbJpg·thumbWebp 로 싣는다.

    python3 probe_thumbs.py            # 아직 안 잰 영상만
    python3 probe_thumbs.py --all      # 전부 다시
"""

from __future__ import annotations

import json
import sys
import urllib.error
import urllib.request
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

HERE = Path(__file__).resolve().parent
OUT = HERE / "thumbs.json"
# 높은 화질부터
QUALITIES = ["maxresdefault", "sddefault", "hqdefault", "mqdefault"]
URLS = {
    "jpg": "https://i.ytimg.com/vi/{video}/{quality}.jpg",
    "webp": "https://i.ytimg.com/vi_webp/{video}/{quality}.webp",
}


def video_ids() -> list[str]:
    ids: set[str] = set()
    for clip in json.loads((HERE / "covers.json").read_text()).values():
        ids.add(clip["videoId"])
    for path in sorted((HERE / "research").glob("*.json")):
        for cue in json.loads(path.read_text()).get("cues", []):
            clip = cue.get("officialClip")
            if clip and clip.get("videoId"):
                ids.add(clip["videoId"])
    return sorted(ids)


def exists(url: str, attempts: int = 3) -> bool:
    """있는 그림에도 가끔 404 가 와서, 세 번 중 한 번이라도 200 이면 있는 것으로 본다"""
    for _ in range(attempts):
        request = urllib.request.Request(
            url, method="HEAD", headers={"User-Agent": "ClassicMap seed"}
        )
        try:
            with urllib.request.urlopen(request, timeout=20) as response:
                if response.status == 200:
                    return True
        except (urllib.error.URLError, TimeoutError):
            pass
    return False


def best(video: str, kind: str) -> str | None:
    """그 화질부터 아래 화질이 모두 있는 가장 높은 화질"""
    found = [exists(URLS[kind].format(video=video, quality=quality)) for quality in QUALITIES]
    top = None
    for index in range(len(QUALITIES) - 1, -1, -1):
        if not found[index]:
            break
        top = QUALITIES[index]
    return top


def probe(video: str) -> tuple[str, dict[str, str | None]]:
    return video, {"jpg": best(video, "jpg"), "webp": best(video, "webp")}


def main() -> int:
    known = json.loads(OUT.read_text()) if OUT.exists() and "--all" not in sys.argv else {}
    todo = [video for video in video_ids() if video not in known]
    with ThreadPoolExecutor(max_workers=8) as pool:
        for video, result in pool.map(probe, todo):
            known[video] = result
            print(video, result["jpg"], result["webp"])
    missing = [video for video, result in known.items() if result["jpg"] is None]
    OUT.write_text(json.dumps(dict(sorted(known.items())), ensure_ascii=False, indent=1) + "\n")
    print(f"{len(known)}개 영상, 새로 잰 것 {len(todo)}개, jpg 썸네일이 없는 영상 {len(missing)}개")
    if missing:
        print("jpg 썸네일이 없음:", ", ".join(missing))
    return 1 if missing else 0


if __name__ == "__main__":
    sys.exit(main())
