# ruff: noqa: E501 — 사용법 줄은 한 줄로 둔다.
"""'기타'(갈래 없음) 작품의 MusicBrainz work 를 받아 한 파일로 묶는다.

요청 간격·User-Agent·응답 캐시는 6차 수집 도구(../catalog-wave6-2026-11-10/tools/fetch.py)를 그대로 쓴다
(MusicBrainz 1.1초 간격, 시드 도구 공용 연락처). 캐시 폴더는 환경 변수 CM_FETCH_CACHE 로 정한다.
여러 프로세스가 같은 캐시 폴더를 쓰면 잠금 파일 하나로 간격을 나눠 지킨다.

사용(seed_pipeline 에서):
    CM_FETCH_CACHE=<캐시 폴더> uv run python curation/piece-genre-fill-2026-11-17/fetch_mb.py fetch --mbids <목록>
    CM_FETCH_CACHE=<캐시 폴더> uv run python curation/piece-genre-fill-2026-11-17/fetch_mb.py pack --mbids <목록> --out mb_works.jsonl.gz

pack 은 네트워크를 쓰지 않고 캐시에 있는 응답 원문만 MBID 순으로 gzip JSONL({"mbid", "work"})에 담는다
(없는 work 는 work 가 null). 캐시에 없는 MBID 는 빼고 그 수를 알린다. fill.py 는 이 파일만 읽는다.
"""

import argparse
import gzip
import hashlib
import json
import os
import sys
import urllib.parse
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parent / "catalog-wave6-2026-11-10" / "tools"))

from fetch import CACHE, mb  # type: ignore[import-not-found,unused-ignore]  # noqa: E402

INC = "artist-rels+work-rels+tags+genres"


def url(mbid: str) -> str:
    """fetch.mb 가 캐시 키로 쓰는 주소와 같은 꼴."""
    query = urllib.parse.urlencode(sorted({"inc": INC, "fmt": "json"}.items()))
    return f"https://musicbrainz.org/ws/2/work/{mbid}?{query}"


def cached(mbid: str) -> str | None:
    path = os.path.join(CACHE, "mb", hashlib.sha1(url(mbid).encode("utf-8")).hexdigest())
    if not os.path.exists(path):
        return None
    with open(path, encoding="utf-8") as handle:
        return handle.read()


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("cmd", choices=["fetch", "pack"])
    parser.add_argument("--mbids", type=Path, required=True)
    parser.add_argument("--out", type=Path)
    args = parser.parse_args()
    mbids = [line.strip() for line in args.mbids.read_text().splitlines() if line.strip()]
    if args.cmd == "fetch":
        for index, mbid in enumerate(mbids, 1):
            mb(f"work/{mbid}", {"inc": INC})
            if index % 200 == 0:
                print(index, len(mbids), flush=True)
        print("done", len(mbids), flush=True)
        return
    assert args.out is not None
    missing = 0
    with gzip.open(args.out, "wt", encoding="utf-8") as handle:
        for mbid in sorted(set(mbids)):
            body = cached(mbid)
            if body is None:
                missing += 1
                continue
            work = json.loads(body) if body else None
            handle.write(
                json.dumps({"mbid": mbid, "work": work}, ensure_ascii=False, sort_keys=True) + "\n"
            )
    print("packed", len(set(mbids)) - missing, "missing", missing)


if __name__ == "__main__":
    main()
