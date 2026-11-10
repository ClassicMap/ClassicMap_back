"""위키데이터·위키미디어 공용·위키백과에서 그림 후보를 모은다(읽기만, 순서대로 천천히).

wikimedia.py wikidata <qid 목록> <출력 json>
    P18(대표 그림)·P373(공용 분류)·P2850(애플 뮤직)·P1902(스포티파이)·생몰일
wikimedia.py files <파일 이름 목록> <출력 json>
    공용 파일 주소·크기·지은이·라이선스(extmetadata)
wikimedia.py category <tsv: key<TAB>분류> <출력 json>
    공용 분류(하위 분류 1단계)의 그림 파일 정보
wikimedia.py pageimages <qid 목록> <출력 json>
    위키백과 각 언어판 문서의 자유 라이선스 대표 그림 이름
"""

from __future__ import annotations

import html
import json
import re
import sys
import time
import urllib.parse
import urllib.request
from collections import defaultdict
from pathlib import Path
from typing import Any

UA = "ClassicMapImageCuration/0.1 (kang3171611@naver.com)"
TAG = re.compile(r"<[^>]+>")
SKIP = re.compile(
    r"grave|tomb|plaque|signature|autograph|score|manuscript|house|birthplace|street|stamp|"
    r"poster|grab|friedhof|cimeti|monument|statue|bust|memorial|program|cover|sheet",
    re.I,
)
PROPS = ("P18", "P373", "P2850", "P1902", "P569", "P570")
COMMONS_API = "https://commons.wikimedia.org/w/api.php?"


def get(url: str) -> Any:
    for attempt in range(6):
        try:
            request = urllib.request.Request(url, headers={"User-Agent": UA})
            with urllib.request.urlopen(request, timeout=60) as response:
                return json.load(response)
        except Exception as error:
            print("retry", error, file=sys.stderr)
            time.sleep(10 * (attempt + 1))
    raise RuntimeError(url)


def plain(value: object) -> str | None:
    if not isinstance(value, str):
        return None
    text = re.sub(r"\s+", " ", html.unescape(TAG.sub("", value))).strip()
    return text or None


def lines(path: str) -> list[str]:
    return [
        line.strip() for line in Path(path).read_text(encoding="utf-8").splitlines() if line.strip()
    ]


def save(path: str, data: object) -> None:
    Path(path).write_text(json.dumps(data, ensure_ascii=False, indent=1), encoding="utf-8")


def claim_value(claim: dict[str, Any]) -> object:
    value = claim["mainsnak"].get("datavalue", {}).get("value")
    if isinstance(value, dict):
        return value.get("id") or value.get("time")
    return value


def wikidata(qids: list[str]) -> dict[str, Any]:
    out: dict[str, Any] = {}
    for start in range(0, len(qids), 50):
        chunk = "|".join(qids[start : start + 50])
        data = get(
            "https://www.wikidata.org/w/api.php?action=wbgetentities&format=json"
            "&props=claims|labels&languages=en|ko&ids=" + urllib.parse.quote(chunk)
        )
        for qid, entity in data.get("entities", {}).items():
            labels = entity.get("labels", {})
            record: dict[str, Any] = {
                "label": labels.get("en", {}).get("value"),
                "labelKo": labels.get("ko", {}).get("value"),
            }
            for prop in PROPS:
                claims = [
                    c
                    for c in entity.get("claims", {}).get(prop, [])
                    if c.get("rank") != "deprecated"
                ]
                # preferred 를 앞으로
                claims.sort(key=lambda claim: 0 if claim.get("rank") == "preferred" else 1)
                record[prop] = [claim_value(claim) for claim in claims]
            out[qid] = record
        time.sleep(1.0)
    return out


def file_info(page: dict[str, Any]) -> dict[str, Any]:
    info = (page.get("imageinfo") or [{}])[0]
    meta = info.get("extmetadata", {})

    def field(key: str) -> str | None:
        return plain(meta.get(key, {}).get("value"))

    return {
        "title": page["title"],
        "missing": page.get("missing", False),
        "url": info.get("url"),
        "thumb": info.get("thumburl"),
        "descriptionUrl": info.get("descriptionurl"),
        "width": info.get("width"),
        "height": info.get("height"),
        "mime": info.get("mime"),
        "artist": field("Artist"),
        "license": field("LicenseShortName"),
        "licenseUrl": field("LicenseUrl"),
        "description": (field("ImageDescription") or "")[:400],
        "date": field("DateTimeOriginal"),
    }


def files(names: list[str]) -> dict[str, Any]:
    out: dict[str, Any] = {}
    for start in range(0, len(names), 40):
        chunk = names[start : start + 40]
        data = get(
            COMMONS_API
            + urllib.parse.urlencode(
                {
                    "action": "query",
                    "format": "json",
                    "formatversion": 2,
                    "prop": "imageinfo",
                    "iiprop": "url|size|mime|extmetadata",
                    "iiurlwidth": 500,
                    "titles": "|".join("File:" + name for name in chunk),
                }
            )
        )
        normalized = {item["to"]: item["from"] for item in data["query"].get("normalized", [])}
        for page in data["query"]["pages"]:
            original = normalized.get(page["title"], page["title"]).removeprefix("File:")
            out[original] = file_info(page)
        time.sleep(1.5)
    return out


def category_files(category: str) -> list[dict[str, Any]]:
    data = get(
        COMMONS_API
        + urllib.parse.urlencode(
            {
                "action": "query",
                "format": "json",
                "formatversion": 2,
                "generator": "categorymembers",
                "gcmtitle": "Category:" + category,
                "gcmtype": "file",
                "gcmlimit": 60,
                "prop": "imageinfo",
                "iiprop": "url|size|mime|extmetadata",
                "iiurlwidth": 500,
            }
        )
    )
    return [file_info(page) for page in data.get("query", {}).get("pages", [])]


def subcategories(category: str) -> list[str]:
    data = get(
        COMMONS_API
        + urllib.parse.urlencode(
            {
                "action": "query",
                "format": "json",
                "formatversion": 2,
                "list": "categorymembers",
                "cmtitle": "Category:" + category,
                "cmtype": "subcat",
                "cmlimit": 20,
            }
        )
    )
    members = data.get("query", {}).get("categorymembers", [])
    return [str(item["title"]).removeprefix("Category:") for item in members]


def category(rows: list[str]) -> dict[str, Any]:
    out: dict[str, Any] = {}
    for row in rows:
        key, name = row.split("\t")
        found = category_files(name)
        for sub in subcategories(name)[:6]:
            if not SKIP.search(sub):
                time.sleep(1.0)
                found.extend(category_files(sub))
        seen: set[str] = set()
        kept = []
        for item in found:
            mime = item["mime"] or ""
            if item["title"] in seen or not mime.startswith("image/"):
                continue
            seen.add(item["title"])
            if not SKIP.search(item["title"]) and (item["width"] or 0) >= 150:
                kept.append(item)
        out[key] = kept
        time.sleep(1.0)
    return out


def pageimages(qids: list[str]) -> dict[str, Any]:
    titles: dict[str, list[tuple[str, str]]] = defaultdict(list)
    for start in range(0, len(qids), 50):
        chunk = "|".join(qids[start : start + 50])
        data = get(
            "https://www.wikidata.org/w/api.php?action=wbgetentities&format=json&props=sitelinks&ids="
            + urllib.parse.quote(chunk)
        )
        for qid, entity in data.get("entities", {}).items():
            for site, link in entity.get("sitelinks", {}).items():
                special = site in ("commonswiki", "specieswiki", "metawiki")
                if site.endswith("wiki") and not special and "_" not in site:
                    titles[site].append((qid, link["title"]))
        time.sleep(1.0)
    out: dict[str, list[dict[str, str]]] = defaultdict(list)
    for site, pairs in sorted(titles.items()):
        for start in range(0, len(pairs), 50):
            by_title = {title: qid for qid, title in pairs[start : start + 50]}
            data = get(
                f"https://{site[:-4]}.wikipedia.org/w/api.php?action=query&format=json&formatversion=2"
                "&prop=pageimages&piprop=name&pilicense=free&redirects=1&titles="
                + urllib.parse.quote("|".join(by_title))
            )
            query = data.get("query", {})
            back = {
                item["to"]: item["from"]
                for item in query.get("normalized", []) + query.get("redirects", [])
            }
            for page in query.get("pages", []):
                if not page.get("pageimage"):
                    continue
                original = back.get(page["title"], page["title"])
                qid = by_title.get(back.get(original, original))
                if qid:
                    out[qid].append(
                        {"wiki": site[:-4], "title": page["title"], "image": page["pageimage"]}
                    )
            time.sleep(0.5)
    return dict(out)


def main() -> None:
    command, source, target = sys.argv[1:4]
    if command == "wikidata":
        save(target, wikidata(lines(source)))
    elif command == "files":
        save(target, files(lines(source)))
    elif command == "category":
        save(target, category(lines(source)))
    elif command == "pageimages":
        save(target, pageimages(lines(source)))
    else:
        raise SystemExit(f"unknown command {command}")


if __name__ == "__main__":
    main()
