#!/usr/bin/env python3
"""작품마다 한국영상자료원 KMDb 오픈 API 에서 포스터를 찾아 posters.json 에 적는다.

    KMDB_SERVICE_KEY=... python3 probe_posters.py          # 아직 안 찾은 작품만
    KMDB_SERVICE_KEY=... python3 probe_posters.py --all    # 전부 다시

- 인증키는 환경변수로만 받고 파일·출력 어디에도 남기지 않는다(오류 메시지에도 주소를 찍지 않는다)
- KMDb 등록 id(identifiers.kmdb)가 있으면 그 id 로, 없으면 한국어 제목 + 제작 연도(±1)로 찾는다
- 제목이 맞는 후보가 하나일 때만 고른다. 여럿이거나 없으면 사람이 보고 OVERRIDES 에 id 를 적는다
- build_titles.py 는 `status` 가 `ok` 인 것만 posterUrl·posterCredit 으로 싣는다
"""

from __future__ import annotations

import json
import os
import re
import sys
import unicodedata
import urllib.parse
import urllib.request
from pathlib import Path
from typing import Any

# KMDb 응답·작품 줄은 구조가 느슨해서 JSON 값 그대로 다룬다
Json = dict[str, Any]

HERE = Path(__file__).resolve().parent
OUT = HERE / "posters.json"
API = "https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp"
CREDIT = "KMDb"
# 한국어 제목·원제와 맞춰 볼 KMDb 제목 필드
TITLE_FIELDS = ("title", "titleEng", "titleOrg")
# 사람이 확인한 KMDb 등록 id. 제목 검색으로 못 고른 작품만 적는다 (slug → "K/06066")
OVERRIDES: dict[str, str] = {
    # 같은 제목 하네케 「피아니스트」(2001, F/08129)와 갈린다
    "the-pianist": "F/08176",
}
# 포스터를 쓰지 않을 작품 (slug → 이유)
SKIP: dict[str, str] = {
    # KMDb 에는 같은 제목의 미국 다큐(2023, B/11268)만 있다
    "maestra-strings-of-truth": "tvN 드라마는 KMDb 에 없다",
}
# 첫 포스터가 재개봉판처럼 원래 개봉 포스터가 아닐 때 고를 순번 (slug → posters 안 순번)
# 2026-10-07 포스터를 하나씩 열어 보고 골랐다
POSTER_CHOICE: dict[str, int] = {
    "amadeus": 1,  # 0 은 2025 재개봉, 1 은 1985 국내 개봉
    "fantasia": 1,  # 0 은 50주년(1990) 재개봉
    "melancholia": 4,  # 0 은 그림 주소가 404, 4 는 국내 개봉
    "my-paparotti": 1,  # 0 은 가로 배너
    "oldboy": 1,  # 0 은 20주년 재개봉
    "raging-bull": 1,  # 1 이 1980 개봉 포스터
    "tar": 1,  # 0 은 그림 주소가 404, 1 은 국내 개봉
    "the-shawshank-redemption": 2,  # 0 은 2026, 1 은 2016 재개봉, 2 는 1995 국내 개봉
    "the-silence-of-the-lambs": 1,  # 0 은 2025 재개봉, 1 은 1991 국내 개봉
}


def normalize(text: str) -> str:
    text = re.sub(r"!H[SE]", "", text or "")
    text = unicodedata.normalize("NFKC", text).lower()
    return re.sub(r"[\s\W_]+", "", text)


def call(params: dict[str, str]) -> list[Json]:
    key = os.environ.get("KMDB_SERVICE_KEY", "").strip()
    if not key:
        sys.exit("KMDB_SERVICE_KEY 환경변수가 필요함")
    query = urllib.parse.urlencode(
        {"collection": "kmdb_new2", "detail": "Y", "listCount": "20", **params, "ServiceKey": key}
    )
    request = urllib.request.Request(f"{API}?{query}", headers={"User-Agent": "ClassicMap seed"})
    try:
        with urllib.request.urlopen(request, timeout=30) as response:
            body = response.read().decode("utf-8", "replace")
    except OSError as error:
        raise RuntimeError(f"KMDb 요청 실패: {type(error).__name__}") from None
    try:
        payload = json.loads(body)
    except json.JSONDecodeError:
        raise RuntimeError(f"KMDb 응답이 JSON 이 아님: {body.strip()[:80]}") from None
    results: list[Json] = []
    for block in payload.get("Data") or []:
        results.extend(block.get("Result") or [])
    return results


def posters_of(result: Json) -> list[str]:
    urls = [url.strip() for url in (result.get("posters") or "").split("|") if url.strip()]
    return [
        re.sub(r"^http://", "https://", url) for url in urls if "file.koreafilm.or.kr" in url
    ]


def directors_of(result: Json) -> str:
    people = ((result.get("directors") or {}).get("director")) or []
    names = (person.get("directorNm", "").strip() for person in people)
    return ", ".join(name for name in names if name)


def summary(result: Json) -> Json:
    return {
        "kmdb": f"{result.get('movieId', '')}/{result.get('movieSeq', '')}",
        "title": re.sub(r"\s*!H[SE]\s*", " ", result.get("title") or "").strip(),
        "titleEng": (result.get("titleEng") or "").strip(),
        "prodYear": (result.get("prodYear") or "").strip(),
        "nation": (result.get("nation") or "").strip(),
        "directors": directors_of(result),
        "posters": posters_of(result),
    }


def by_id(kmdb_id: str) -> list[Json]:
    movie_id, _, movie_seq = kmdb_id.partition("/")
    return call({"movieId": movie_id, "movieSeq": movie_seq})


def by_title(title: Json) -> list[Json]:
    params = {"title": title["titleKo"]}
    year = title.get("releaseYear")
    if year:
        params.update({"createDts": str(year - 1), "createDte": str(year + 1)})
    wanted = {normalize(title["titleKo"]), normalize(title.get("titleOriginal") or "")} - {""}
    return [
        result
        for result in call(params)
        if wanted & {normalize(result.get(field) or "") for field in TITLE_FIELDS}
    ]


def probe(title: Json) -> Json:
    slug = title["slug"]
    if slug in SKIP:
        return {"status": "skip", "reason": SKIP[slug]}
    kmdb_id = OVERRIDES.get(slug) or (title.get("identifiers") or {}).get("kmdb")
    results = by_id(kmdb_id) if kmdb_id else by_title(title)
    candidates = [summary(result) for result in results]
    with_poster = [candidate for candidate in candidates if candidate["posters"]]
    if len(with_poster) == 1:
        chosen = with_poster[0]
        index = POSTER_CHOICE.get(slug, 0)
        if not 0 <= index < len(chosen["posters"]):
            count = len(chosen["posters"])
            raise RuntimeError(f"POSTER_CHOICE 순번 {index} 이 포스터 수 {count} 밖")
        return {
            "status": "ok",
            **chosen,
            "posterUrl": chosen["posters"][index],
            "posterCredit": CREDIT,
        }
    if not with_poster:
        return {"status": "none", "candidates": candidates}
    return {"status": "ambiguous", "candidates": with_poster}


def main() -> int:
    titles = [json.loads(line) for line in (HERE / "titles.jsonl").read_text().splitlines()]
    known = json.loads(OUT.read_text()) if OUT.exists() and "--all" not in sys.argv else {}
    for title in titles:
        slug = title["slug"]
        if slug in known and known[slug].get("status") in ("ok", "skip"):
            continue
        try:
            known[slug] = probe(title)
        except RuntimeError as error:
            print(f"{slug}: {error}")
            continue
        entry = known[slug]
        found = f"{entry.get('kmdb', '')} {entry.get('title', '')} {entry.get('prodYear', '')}"
        print(f"{slug:36} {entry['status']:9} {found}")
    OUT.write_text(json.dumps(dict(sorted(known.items())), ensure_ascii=False, indent=1) + "\n")
    counts: dict[str, int] = {}
    for entry in known.values():
        counts[entry["status"]] = counts.get(entry["status"], 0) + 1
    print(f"{len(titles)}편: {counts}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
