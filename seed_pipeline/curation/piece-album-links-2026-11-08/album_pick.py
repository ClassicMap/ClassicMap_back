"""작품마다 그 작품 트랙이 다 든 앨범을 고르는 규칙(Apple Music·Spotify 공통).

- 작품 트랙: 트랙 이름에 작품번호(match.catalogue_regex)와 본제목(쉼표 앞)의 뜻 있는 낱말이 있다.
  작품번호가 없으면 조성을 뺀 제목 구절이 트랙 이름에 있고, 트랙에 다른 조성이 적혀 있지 않다.
- 트랙 이름이 악장 이름뿐인 앨범은 앨범 이름에 작품번호가 있고 트랙 수가 곡 수와 같을 때만 쓴다.
- 앨범 이름이나 아티스트 이름에 작곡가 성이 있어야 한다.
- 작품 트랙 수가 곡 수와 같은 앨범 → 곡 수 이상 → 앨범 이름에 작품번호·제목이 있는 앨범 → 검색 순서.
  작품 트랙이 곡 수보다 적으면 'partial'(앨범 트랙을 다 받아 다시 세야 한다).
검색 1위 앨범을 그냥 쓰지 않는다(쇼팽 피아노 협주곡 2번 검색 1위가 녹턴 앨범이었다).
"""

from __future__ import annotations

import importlib.util
import re
import unicodedata
from collections import defaultdict
from collections.abc import Callable
from pathlib import Path
from types import ModuleType
from typing import Any

MATCH_PATH = Path(__file__).resolve().parent.parent / "part-apple-links-2026-11-08" / "match.py"


def _load_match() -> ModuleType:
    spec = importlib.util.spec_from_file_location("part_apple_match", MATCH_PATH)
    if spec is None or spec.loader is None:
        raise ImportError(str(MATCH_PATH))
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


_match = _load_match()
GENERIC: re.Pattern[str] = _match.GENERIC
KEY_EN: re.Pattern[str] = _match.KEY_EN
catalogue_regex: Callable[[str], str | None] = _match.catalogue_regex
norm: Callable[[str], str] = _match.norm

TITLE_SKIP = {
    "major",
    "minor",
    "flat",
    "sharp",
    "for",
    "and",
    "with",
    "from",
    "the",
    "pour",
    "und",
    "fur",
    "piano",
    "orchestra",
    "no",
    "op",
    "nos",
    "book",
    "version",
}


def plain(text: str) -> str:
    text = unicodedata.normalize("NFKD", text)
    return "".join(c for c in text if not unicodedata.combining(c)).lower()


def surname_of(name: str) -> str:
    parts = re.sub(r"[^a-z ]", " ", plain(name)).split()
    return parts[-1] if parts else ""


def title_words(title: str) -> list[str]:
    """제목에서 작품을 가리키는 낱말(앞 5글자): Concerto·Sonata·Préludes 등."""
    text = re.sub(r"\([^)]*\)", " ", norm(title))
    words = re.sub(r"[^a-z ]", " ", text).split()
    return [w[:5] for w in words if len(w) >= 5 and w not in TITLE_SKIP]


def title_phrase(title: str) -> str | None:
    """작품번호가 없는 작품의 제목 구절. 조성은 트랙마다 쓰는 법이 달라(C# / C-Sharp) 뺀다."""
    text = re.sub(r"\([^)]*\)", " ", norm(title))
    text = re.sub(r"[\"“”«»<>]", " ", text)
    text = re.sub(r"\b(?:in\s+)?" + KEY_EN.pattern, " ", text)
    text = " ".join(text.split()).strip(" ,.-")
    rest = re.sub(r"[^a-z ]", " ", GENERIC.sub(" ", text))
    return text if len("".join(rest.split())) >= 5 else None


def key_of(text: str) -> str | None:
    """조성을 한 가지 꼴로: 'c# minor'·'c-sharp minor'·'c sharp minor' → 'c#minor'."""
    m = KEY_EN.search(norm(text))
    if not m:
        return None
    accidental = {"sharp": "#", "#": "#", "flat": "b"}.get(m.group(2) or "", "")
    return f"{m.group(1)}{accidental}{m.group(3)}"


def names_work(row: dict[str, str], album_name: str) -> bool:
    """앨범 이름이 이 작곡가의 이 작품을 가리킨다.

    작곡가 성 + 작품번호, 작품번호가 없으면 제목 구절.
    """
    surname = surname_of(row["composer_en"])
    name = norm(album_name)
    if not surname or surname not in plain(album_name):
        return False
    cat = catalogue_regex(row["catalogue"]) if row["catalogue"] else None
    if cat:
        return re.search(cat, name) is not None
    phrase = title_phrase(row["title_en"])
    bare_name = " ".join(re.sub(r"\b(?:in\s+)?" + KEY_EN.pattern, " ", name).split())
    return (
        phrase is not None and re.search(re.escape(phrase) + r"(?![0-9a-z])", bare_name) is not None
    )


def album_url(track: dict[str, Any]) -> str:
    url = re.sub(r"\?.*$", "", str(track.get("collectionViewUrl", "")))
    if "music.apple.com" not in url:
        return url
    # 트랙 검색 결과의 앨범 주소에는 트랙 이름 꼬리표가 붙어 있어 앨범 이름으로 다시 만든다
    slug = (
        re.sub(r"[^a-z0-9]+", "-", plain(str(track.get("collectionName", "")))).strip("-")
        or "album"
    )
    return f"https://music.apple.com/us/album/{slug}/{track['collectionId']}"


def pick(row: dict[str, str], results: list[dict[str, Any]]) -> dict[str, Any] | None:
    surname = surname_of(row["composer_en"])
    tracks = [r for r in results if r.get("wrapperType") == "track" and r.get("trackViewUrl")]
    if not surname or not tracks:
        return None
    cat = catalogue_regex(row["catalogue"]) if row["catalogue"] else None
    # 쉼표 앞 본제목의 낱말만 본다
    # (「La mer, trois esquisses symphoniques」의 부제는 트랙 이름에 없다)
    words = title_words(row["title_en"].split(",", 1)[0])
    phrase = None if cat else title_phrase(row["title_en"])
    if not cat and not phrase:
        return None
    key = key_of(row["title_en"])

    def is_work(track: dict[str, Any]) -> bool:
        name = norm(str(track.get("trackName", "")))
        if cat:
            if not re.search(cat, name):
                return False
            plain_name = re.sub(r"[^a-z ]", " ", name)
            return not words or any(w in plain_name for w in words)
        # 제목 구절에서 조성을 뺐으니 트랙 이름에서도 빼고 찾는다
        bare_name = " ".join(re.sub(r"\b(?:in\s+)?" + KEY_EN.pattern, " ", name).split())
        if phrase is None or re.search(re.escape(phrase) + r"(?![0-9a-z])", bare_name) is None:
            return False
        # 제목 구절에서 조성을 뺐으니, 트랙에 다른 조성이 적혀 있으면 다른 작품이다
        track_key = key_of(name)
        return key is None or track_key is None or track_key == key

    def by_composer(track: dict[str, Any]) -> bool:
        who = plain(f"{track.get('collectionName', '')} {track.get('artistName', '')}")
        return surname in who

    want = int(row["nparts"])
    albums: dict[str, list[int]] = defaultdict(list)
    for index, track in enumerate(tracks):
        if is_work(track) and by_composer(track):
            albums[str(track["collectionId"])].append(index)
    if cat:
        # 트랙 이름이 악장 이름뿐인 앨범: 앨범 이름에 작품번호가 있고,
        # 작품번호 붙은 트랙이 하나도 없고, 트랙 수가 곡 수와 같으면 그 트랙들이 작품이다
        # (match.py 의 'album' 규칙과 같은 조건)
        bare: dict[str, list[int]] = defaultdict(list)
        for index, track in enumerate(tracks):
            if by_composer(track) and re.search(cat, norm(str(track.get("collectionName", "")))):
                bare[str(track["collectionId"])].append(index)
        for album, indexes in bare.items():
            if album in albums or len(indexes) != want:
                continue
            if not any(re.search(cat, norm(str(tracks[i].get("trackName", "")))) for i in indexes):
                albums[album] = indexes
    if not albums:
        return None

    def score(item: tuple[str, list[int]]) -> tuple[int, int, int, int]:
        _, indexes = item
        first = tracks[indexes[0]]
        names = norm(str(first.get("collectionName", "")))
        dedicated = bool(
            (cat and re.search(cat, names))
            or (phrase and re.search(re.escape(phrase) + r"(?![0-9a-z])", names))
        )
        exact = len(indexes) == want
        enough = len(indexes) >= want
        return (int(exact), int(enough), int(dedicated), -indexes[0])

    album_id, indexes = max(albums.items(), key=score)
    first = tracks[indexes[0]]
    return {
        "pieceId": int(row["piece_id"]),
        "albumId": album_id,
        "albumUrl": album_url(first),
        "albumName": first.get("collectionName", ""),
        "workTracks": len(indexes),
        "parts": want,
        "status": "exact"
        if len(indexes) == want
        else ("more" if len(indexes) > want else "partial"),
        "current": row.get("current_url", ""),
        "tracks": [tracks[i]["trackName"] for i in indexes[:4]],
    }
