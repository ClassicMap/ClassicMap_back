# ruff: noqa: E501, RUF001 — 한국어 설명과 원어 문장부호를 그대로 둔다.
"""사운드트랙 링크 도구가 같이 쓰는 것: 입력 읽기, 6차 음반 묶음, 이름 정규화, MusicBrainz 수집기."""

from __future__ import annotations

import csv
import glob
import importlib.util
import json
import os
import re
import unicodedata
from typing import Any

HERE = os.path.dirname(os.path.abspath(__file__))
CURATION = os.path.dirname(HERE)
WAVE6 = os.path.join(CURATION, "catalog-wave6-2026-11-10")

csv.field_size_limit(10_000_000)


def load_fetch() -> Any:
    spec = importlib.util.spec_from_file_location("fetch", os.path.join(WAVE6, "tools", "fetch.py"))
    assert spec and spec.loader
    module: Any = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def read_tsv(path: str) -> list[dict[str, str]]:
    with open(path, encoding="utf-8") as handle:
        return [
            {k: ("" if v == "NULL" else v) for k, v in row.items()}
            for row in csv.DictReader(handle, delimiter="\t")
        ]


def wave6_groups() -> dict[tuple[str, str], dict[str, Any]]:
    """(composer_id, 묶음 제목) → 6차 groups.json 항목(MusicBrainz release group·release)."""
    slug_to_id: dict[str, str] = {}
    with open(os.path.join(WAVE6, "film_composers.txt"), encoding="utf-8") as handle:
        for line in handle:
            parts = line.split()
            if len(parts) >= 2 and not parts[0].startswith("#"):
                slug_to_id[parts[1]] = parts[0]
    out: dict[tuple[str, str], dict[str, Any]] = {}
    for path in sorted(glob.glob(os.path.join(WAVE6, "*", "groups.json"))):
        slug = os.path.basename(os.path.dirname(path))
        if slug not in slug_to_id:
            continue
        with open(path, encoding="utf-8") as handle:
            groups = json.load(handle)
        for item in groups if isinstance(groups, list) else list(groups.values()):
            out[(slug_to_id[slug], str(item["title"]))] = item
    return out


def norm(text: str) -> str:
    """비교용: 악센트·대소문자·구두점을 없애고 낱말 사이를 한 칸으로."""
    text = unicodedata.normalize("NFKD", text)
    text = "".join(ch for ch in text if not unicodedata.combining(ch))
    text = text.lower().replace("’", "'").replace("&", " and ")
    text = re.sub(r"[\W_]+", " ", text)
    return re.sub(r"\s+", " ", text).strip()


SOUNDTRACK_TAIL = re.compile(
    r"[\s,:(\-–]*(original (motion picture|television|video game|film|series)? ?(soundtrack|score)"
    r"|music from the (motion picture|original)|motion picture soundtrack|soundtrack|ost|film score|original score)"
    r"\b.*$",
    re.I,
)


def key_title(title_en: str) -> str:
    """작품 원어 제목에서 앨범 이름과 견줄 핵심(사운드트랙 꼬리·작품번호·괄호 설명을 뗀 것)."""
    text = re.sub(r"\((film score|soundtrack|a time for us|\d{4})\)", "", title_en, flags=re.I)
    text = re.sub(r",?\s*(op\.|fp|wd)\s*\d+[a-z]?\b.*$", "", text, flags=re.I)
    text = SOUNDTRACK_TAIL.sub("", text)
    return norm(text)


def track_name_core(name: str) -> str:
    """트랙·곡 이름 비교용: 「(From "X")」·「- Remastered」 같은 꼬리와 앞 번호를 뗀다."""
    text = re.sub(
        r"\s*[\(\[][^)\]]*(from|remaster|version|edit|ost|soundtrack|theme from)[^)\]]*[\)\]]",
        "",
        name,
        flags=re.I,
    )
    text = re.sub(r"\s+-\s+(remaster|from|live|single|edit).*$", "", text, flags=re.I)
    text = re.sub(r"^\s*(\d+|[ivx]+)[\.\)]\s+", "", text, flags=re.I)
    return norm(text)
