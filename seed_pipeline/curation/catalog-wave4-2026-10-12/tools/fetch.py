"""여러 에이전트가 함께 쓰는 MusicBrainz·위키백과 수집 도구.

- 모든 프로세스가 같은 잠금 파일로 요청 간격을 맞춘다(MusicBrainz 1.1초, 위키백과 0.4초).
- 응답은 cache/ 아래에 남겨 같은 요청을 다시 보내지 않는다.
- User-Agent 는 "ClassicMapResearch/1.0" 고정이다. 개인정보를 넣지 않는다.

사용(파이썬 3.9):
    import sys; sys.path.insert(0, "<이 파일이 있는 폴더>")
    from fetch import mb, wiki_raw, wikidata
    mb("work", {"artist": "<artist mbid>", "limit": 100, "offset": 0, "inc": "aliases"})
    mb("work/<work mbid>", {"inc": "work-rels+aliases+annotation"})
    wiki_raw("List of compositions by Ludwig van Beethoven")

명령줄: python3 fetch.py mb 'work/<mbid>' 'inc=work-rels'   /   python3 fetch.py wiki '<title>'
"""

import fcntl
import hashlib
import json
import os
import sys
import time
import urllib.error
import urllib.parse
import urllib.request
from typing import Any

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CACHE = os.path.join(ROOT, "cache")
UA = "ClassicMapResearch/1.0"
INTERVALS = {"mb": 1.1, "wiki": 0.4, "wd": 0.3}


def _wait_turn(kind: str) -> None:
    """잠금 파일 안의 마지막 요청 시각을 보고, 간격이 찰 때까지 기다린 뒤 지금 시각을 적는다."""
    os.makedirs(CACHE, exist_ok=True)
    path = os.path.join(CACHE, "." + kind + ".lock")
    with open(path, "a+") as handle:
        fcntl.flock(handle, fcntl.LOCK_EX)
        handle.seek(0)
        text = handle.read().strip()
        last = float(text) if text else 0.0
        delay = last + INTERVALS[kind] - time.time()
        if delay > 0:
            time.sleep(delay)
        handle.seek(0)
        handle.truncate()
        handle.write(str(time.time()))
        handle.flush()
        fcntl.flock(handle, fcntl.LOCK_UN)


def _cached_get(kind: str, url: str) -> str:
    key = hashlib.sha1(url.encode("utf-8")).hexdigest()
    folder = os.path.join(CACHE, kind)
    os.makedirs(folder, exist_ok=True)
    path = os.path.join(folder, key)
    if os.path.exists(path):
        with open(path, encoding="utf-8") as handle:
            return handle.read()
    backoff = 5.0
    body: str = ""
    for attempt in range(6):
        _wait_turn(kind)
        headers = {"User-Agent": UA, "Accept": "application/json"}
        request = urllib.request.Request(url, headers=headers)
        try:
            with urllib.request.urlopen(request, timeout=60) as response:
                body = str(response.read().decode("utf-8"))
            break
        except urllib.error.HTTPError as error:
            if error.code in (429, 503) and attempt < 5:
                time.sleep(backoff)
                backoff *= 2
                continue
            if error.code == 404:
                body = ""
                break
            raise
    with open(path, "w", encoding="utf-8") as handle:
        handle.write(body)
    return body


def mb(path: str, params: dict[str, Any] | None = None) -> Any:
    """MusicBrainz ws/2 JSON. path 예: 'work', 'work/<mbid>'. 없으면 None."""
    query = dict(params or {})
    query["fmt"] = "json"
    query_string = urllib.parse.urlencode(sorted(query.items()))
    url = "https://musicbrainz.org/ws/2/" + path + "?" + query_string
    body = _cached_get("mb", url)
    return json.loads(body) if body else None


def wiki_raw(title: str, lang: str = "en") -> str:
    """위키백과 문서 위키텍스트(action=raw). 없으면 빈 문자열."""
    query_string = urllib.parse.urlencode({"title": title, "action": "raw"})
    url = f"https://{lang}.wikipedia.org/w/index.php?{query_string}"
    return _cached_get("wiki", url)


def wikidata(qid: str) -> Any:
    """Wikidata 항목 JSON(Special:EntityData). 없으면 None."""
    url = f"https://www.wikidata.org/wiki/Special:EntityData/{qid}.json"
    body = _cached_get("wd", url)
    return json.loads(body) if body else None


if __name__ == "__main__":
    if sys.argv[1] == "mb":
        params = dict(item.split("=", 1) for item in sys.argv[3:])
        print(json.dumps(mb(sys.argv[2], params), ensure_ascii=False, indent=1))
    else:
        print(wiki_raw(sys.argv[2], *(sys.argv[3:4] or [])))
