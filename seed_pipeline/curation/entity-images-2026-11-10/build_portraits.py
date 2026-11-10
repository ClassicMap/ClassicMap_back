"""수집 결과(raw/)와 눈으로 본 결정(review.json)으로 작곡가 초상 목록을 만든다.

- composer-portraits.jsonl: 위키미디어 공용 초상. 위키데이터 대표 그림(P18) 첫 장이 기본이고,
  review.json 의 portraitChoice 로 다른 장(P18 둘째 장, 공용 분류의 파일)을 고른다.
- composer-portraits-services.jsonl: 공용에 쓸 초상이 없던 작곡가의
  애플 뮤직·스포티파이 아티스트 그림. review.json 의 serviceAccept 에 적은 것만 쓴다.
- missing-composer-portraits.tsv: 어디서도 못 찾은 작곡가(빈칸으로 둔다).

사용: uv run python curation/entity-images-2026-11-10/build_portraits.py
"""

from __future__ import annotations

import csv
import json
import re
from pathlib import Path
from typing import Any

HERE = Path(__file__).resolve().parent
RAW = HERE / "raw"
UNKNOWN_AUTHOR = re.compile(
    r"unknown|anonymous|unidentified|non identifi|name is not written|not known", re.I
)
MAILTO = re.compile(r"\s*<mailto:[^>]*>")
# 브라우저가 못 그리는 원본은 공용 썸네일(jpg)로 쓴다
THUMB_ONLY = {"image/tiff"}


def read_json(name: str) -> Any:
    with (RAW / name).open(encoding="utf-8") as handle:
        return json.load(handle)


def strip_query(url: str) -> str:
    return url.split("?", 1)[0]


def display_url(info: dict[str, Any]) -> str:
    url = strip_query(info["url"])
    if info["mime"] not in THUMB_ONLY:
        return url
    # .../commons/a/ab/F.tif → .../commons/thumb/a/ab/F.tif/lossy-page1-960px-F.tif.jpg
    width = 960 if info["width"] >= 960 else 500 if info["width"] >= 500 else 250
    head, file_name = url.rsplit("/", 1)
    head = head.replace("/wikipedia/commons/", "/wikipedia/commons/thumb/", 1)
    return f"{head}/{file_name}/lossy-page1-{width}px-{file_name}.jpg"


def page_url(info: dict[str, Any]) -> str:
    url = strip_query(info["descriptionUrl"])
    assert url.startswith("https://commons.wikimedia.org/wiki/File:"), info
    return url


def author_of(info: dict[str, Any]) -> str | None:
    # 화면에 보일 글이라 메일 주소는 뺀다
    author = MAILTO.sub("", info.get("artist") or "").strip()
    if not author or UNKNOWN_AUTHOR.search(author):
        return None
    return author


def main() -> None:
    review = json.loads((HERE / "review.json").read_text(encoding="utf-8"))
    wikidata: dict[str, Any] = read_json("wikidata-composers.json")
    files: dict[str, Any] = read_json("commons-files.json")
    with (RAW / "composer-targets.tsv").open(encoding="utf-8") as handle:
        targets = list(csv.DictReader(handle, delimiter="\t"))
    accepted_services: dict[str, dict[str, str]] = review.get("serviceAccept", {})
    portraits: list[dict[str, Any]] = []
    from_services: list[dict[str, Any]] = []
    missing: list[list[str]] = []
    for target in targets:
        cid = target["id"]
        item = wikidata[target["qid"]]
        choice = review["portraitChoice"].get(cid)
        file_name: str | None = None
        via = "P18"
        if choice and "file" in choice:
            file_name = choice["file"].removeprefix("File:")
            via = choice["via"]
        elif choice and "p18" in choice:
            file_name = item["P18"][choice["p18"]]
        elif item["P18"] and cid not in review["portraitReject"]:
            file_name = item["P18"][0]
        base = {"id": int(cid), "name": target["name"], "englishName": target["english_name"]}
        if file_name:
            info = files[file_name]
            portraits.append(
                {
                    **base,
                    "source": "wikimedia",
                    "via": via,
                    "file": file_name,
                    "url": display_url(info),
                    "width": info["width"],
                    "height": info["height"],
                    "sourceUrl": page_url(info),
                    "author": author_of(info),
                    "license": info["license"],
                    "licenseUrl": info.get("licenseUrl"),
                }
            )
            continue
        accepted = accepted_services.get(f"c{cid}")
        if accepted:
            from_services.append({**base, **accepted})
            continue
        reason = (
            review["portraitReject"].get(cid)
            or "위키데이터 대표 그림 없음, 애플 뮤직·스포티파이에도 쓸 그림 없음"
        )
        missing.append([cid, target["tier"], target["name"], target["english_name"], reason])
    with (HERE / "composer-portraits.jsonl").open("w", encoding="utf-8") as handle:
        for row in portraits:
            handle.write(json.dumps(row, ensure_ascii=False) + "\n")
    with (HERE / "composer-portraits-services.jsonl").open("w", encoding="utf-8") as handle:
        for row in from_services:
            handle.write(json.dumps(row, ensure_ascii=False) + "\n")
    with (HERE / "missing-composer-portraits.tsv").open("w", encoding="utf-8") as handle:
        writer = csv.writer(handle, delimiter="\t", lineterminator="\n")
        writer.writerow(["id", "tier", "name", "english_name", "reason"])
        writer.writerows(missing)
    print("wikimedia", len(portraits), "services", len(from_services), "missing", len(missing))


if __name__ == "__main__":
    main()
