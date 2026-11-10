"""수집 결과(raw/)와 눈으로 본 결정(review.json)으로 S·A 연주자 배너 목록을 만든다.

- artist-banners.jsonl: review.json 의 bannerChoice 에 적은 연주자.
  출처(spotify | apple_music | wikimedia, 위키미디어는 공용 파일 이름)와 초점을 거기서 정한다.
- missing-artist-banners.tsv: 배너를 못 넣은 연주자(빈칸으로 둔다).

사용: uv run python curation/entity-images-2026-11-10/build_banners.py
"""

from __future__ import annotations

import csv
import json
import re
from pathlib import Path
from typing import Any

HERE = Path(__file__).resolve().parent
RAW = HERE / "raw"
APPLE_SIZE = "2880x1440sr.webp"
UNKNOWN_AUTHOR = re.compile(
    r"unknown|anonymous|unidentified|non identifi|name is not written|not known", re.I
)
MAILTO = re.compile(r"\s*<mailto:[^>]*>")


def read_jsonl(name: str) -> dict[str, dict[str, Any]]:
    with (RAW / name).open(encoding="utf-8") as handle:
        rows = [json.loads(line) for line in handle if line.strip()]
    return {row["key"]: row for row in rows}


def spotify_banner(row: dict[str, Any]) -> dict[str, Any]:
    header = row["header"]
    return {
        "url": header["url"],
        "width": header["width"],
        "height": header["height"],
        "sourceUrl": f"https://open.spotify.com/artist/{row['spotifyId']}",
    }


def apple_banner(row: dict[str, Any]) -> dict[str, Any]:
    wide = row["wide"]
    return {
        "url": wide["template"].replace("{w}x{h}{c}.{f}", APPLE_SIZE),
        "width": wide["width"],
        "height": wide["height"],
        "sourceUrl": f"https://music.apple.com/us/artist/{row['appleId']}",
    }


def wikimedia_banner(info: dict[str, Any]) -> dict[str, Any]:
    url = info["url"].split("?", 1)[0]
    if info["mime"] == "image/tiff":
        # 브라우저가 TIFF 를 못 그려서 공용 썸네일(jpg)로 쓴다
        head, name = url.rsplit("/", 1)
        head = head.replace("/wikipedia/commons/", "/wikipedia/commons/thumb/", 1)
        url = f"{head}/{name}/lossy-page1-1920px-{name}.jpg"
    author = MAILTO.sub("", info.get("artist") or "").strip()
    return {
        "url": url,
        "width": info["width"],
        "height": info["height"],
        "sourceUrl": info["descriptionUrl"].split("?", 1)[0],
        "author": None if not author or UNKNOWN_AUTHOR.search(author) else author,
        "license": info["license"],
        "licenseUrl": info.get("licenseUrl"),
    }


def main() -> None:
    review = json.loads((HERE / "review.json").read_text(encoding="utf-8"))
    files: dict[str, Any] = json.loads(
        (RAW / "commons-artist-files.json").read_text(encoding="utf-8")
    )
    choices: dict[str, dict[str, str]] = review["bannerChoice"]
    rejects: dict[str, str] = review["bannerReject"]
    spotify = read_jsonl("spotify-artists.jsonl")
    apple = read_jsonl("apple-artists.jsonl")
    with (RAW / "artist-targets.tsv").open(encoding="utf-8") as handle:
        targets = list(csv.DictReader(handle, delimiter="\t"))
    banners: list[dict[str, Any]] = []
    missing: list[list[str]] = []
    for target in targets:
        key = f"a{target['id']}"
        choice = choices.get(key)
        if choice is None:
            if target["authority_entity_id"] == "NULL":
                reason = "인물 기록(authority_entity_id)이 없어 배너를 넣을 수 없음"
            else:
                reason = (
                    rejects.get(key)
                    or "스포티파이·애플 뮤직 머리 그림 없음, 위키미디어에 쓸 가로 사진 없음"
                )
            missing.append(
                [target["id"], target["tier"], target["name"], target["english_name"], reason]
            )
            continue
        assert key not in rejects, key
        if choice["source"] == "spotify":
            picked = spotify_banner(spotify[key])
        elif choice["source"] == "apple_music":
            picked = apple_banner(apple[key])
        else:
            picked = wikimedia_banner(files[choice["file"].removeprefix("File:")])
        banners.append(
            {
                "id": int(target["id"]),
                "name": target["name"],
                "englishName": target["english_name"],
                "tier": target["tier"],
                "source": choice["source"],
                "focal": choice["focal"],
                **picked,
            }
        )
    with (HERE / "artist-banners.jsonl").open("w", encoding="utf-8") as handle:
        for row in banners:
            handle.write(json.dumps(row, ensure_ascii=False) + "\n")
    with (HERE / "missing-artist-banners.tsv").open("w", encoding="utf-8") as handle:
        writer = csv.writer(handle, delimiter="\t", lineterminator="\n")
        writer.writerow(["id", "tier", "name", "english_name", "reason"])
        writer.writerows(missing)
    print("banners", len(banners), "missing", len(missing))


if __name__ == "__main__":
    main()
