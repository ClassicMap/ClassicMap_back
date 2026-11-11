# ruff: noqa: E501, RUF001, RUF003 — 한국어 설명과 원어 문장부호를 그대로 둔다.
"""새 카탈로그 링크 도구가 같이 쓰는 것: 입력 읽기, 검색어, 앞선 도구(album_pick·match·spotify_search) 불러오기."""

from __future__ import annotations

import csv
import importlib.util
import json
import os
import re
import sys
import unicodedata
from typing import Any

HERE = os.path.dirname(os.path.abspath(__file__))
CURATION = os.path.dirname(HERE)
PICK_DIR = os.path.join(CURATION, "piece-album-links-2026-11-08")
MATCH_PATH = os.path.join(CURATION, "part-apple-links-2026-11-08", "match.py")
UA = "ClassicMapLinkCuration/0.1 (kang3171611@naver.com)"
BROWSER_UA = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0 Safari/537.36"
# 한글 이름·제목으로 찾는 작곡가(홍난파·김동진). 윤이상은 원어 제목이 있어 원어로 먼저 찾는다
KOREAN = {"89", "103"}
YUN = "90"

csv.field_size_limit(10_000_000)


def load_module(name: str, path: str) -> Any:
    if os.path.dirname(path) not in sys.path:
        sys.path.insert(0, os.path.dirname(path))
    if name in sys.modules:
        return sys.modules[name]
    spec = importlib.util.spec_from_file_location(name, path)
    assert spec and spec.loader
    module: Any = importlib.util.module_from_spec(spec)
    # 앞선 도구끼리 「import album_pick」으로 서로 부르므로 같은 모듈을 쓰게 등록한다
    sys.modules[name] = module
    spec.loader.exec_module(module)
    return module


def read_tsv(path: str) -> list[dict[str, str]]:
    with open(path, encoding="utf-8") as handle:
        return [
            {k: ("" if v == "NULL" else v) for k, v in row.items()}
            for row in csv.DictReader(handle, delimiter="\t")
        ]


def load_json(path: str) -> Any:
    with open(path, encoding="utf-8") as handle:
        return json.load(handle)


def plain(text: str) -> str:
    text = unicodedata.normalize("NFKD", text)
    return "".join(c for c in text if not unicodedata.combining(c))


# 제목에 붙은 작품번호(「, SV 23–39」「K 3, L 378」「(Wolf F3)」「WolS G2」「TWV 55:C3」)
CAT_TOKEN = re.compile(
    r",?\s*\b(?:op|opus|sv|z|twv|kais|wols|wolf|av|trv|kk|k|l|woo|hob|bwv)\.?\s*[\w.:/–-]*\d[\w.:/–-]*",
    re.I,
)
KEY = re.compile(
    r"\b(?:in\s+)?[A-G](?:[- ]?(?:flat|sharp)|♭|♯|#|b)?\s+(?:major|minor|dur|moll)\b", re.I
)
# 「Gagok <봉선화>」「Opera <Sim Tjong>」처럼 꺾쇠 안이 제목인 꼴
ANGLE = re.compile(r"<([^<>]+)>")


def core_title(title: str) -> str:
    """검색·비교용 제목 핵심: 꺾쇠 안, 작품번호·조성·괄호·따옴표를 뗀 것."""
    m = ANGLE.search(title)
    text = m.group(1) if m else title
    text = plain(text).replace("♭", " flat").replace("♯", " sharp")
    text = re.sub(r"\([^)]*\)", " ", text)
    text = CAT_TOKEN.sub(" ", text)
    text = KEY.sub(" ", text)
    text = re.sub(r"[\"“”«»„'’]", " ", text)
    text = re.sub(r"\s*[,:;]\s*(?=[,:;]|$)", " ", text)
    return " ".join(text.split()).strip(" ,.:;-")


def korean_core(title: str) -> str:
    """한글 제목의 핵심: 「가곡 <봉선화>」 → 봉선화, 「동요 <고향의 봄>」 → 고향의 봄."""
    m = ANGLE.search(title)
    text = m.group(1) if m else title
    text = re.sub(r"\([^)]*\)", " ", text)
    return " ".join(text.split())


def surname(row: dict[str, str]) -> str:
    return plain(row["composer_en"]).split()[-1] if row["composer_en"].strip() else ""


def is_range(catalogue: str) -> bool:
    return bool(re.search(r"\d\s*[-–]\s*\d", catalogue))


def terms(row: dict[str, str]) -> list[str]:
    """작품마다 검색어 둘. 작품번호가 있으면 성 + 작품번호, 성 + 제목 낱말. 한국 작곡가는 한글 이름 + 한글 제목."""
    if row["composer_id"] in KOREAN:
        ko = korean_core(row["title"])
        kind = "동요" if row["title"].startswith("동요") else "가곡"
        return [f"{row['composer_ko']} {ko}", f"{ko} {kind}"]
    title = core_title(row["title_en"])
    words = [w for w in re.split(r"[\s,;:]+", title) if w and w not in "-'"]
    cat = plain(row["catalogue"]).strip()
    name = "Isang Yun" if row["composer_id"] == YUN else surname(row)
    out = []
    if cat and not is_range(cat):
        # 「Kk. 380 (L. 23)」는 앞 번호만
        out.append(name + " " + re.sub(r"\s*\(.*$", "", cat))
    out.append(" ".join([name, *words[:6]]))
    if row["composer_id"] == YUN:
        out.append(f"윤이상 {korean_core(row['title'])}")
    elif len(out) < 2:
        out.append(" ".join([name, *words[:3]]))
    return list(dict.fromkeys(t.strip() for t in out if t.strip()))
