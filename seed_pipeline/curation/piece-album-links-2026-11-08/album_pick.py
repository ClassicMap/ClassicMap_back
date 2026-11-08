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
EXCERPT: re.Pattern[str] = _match.EXCERPT
bare_tracks: Callable[[list[str], str, str], bool] = _match.bare_tracks
CATALOGUE_TOKEN: re.Pattern[str] = _match.CATALOGUE_TOKEN
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

# 원곡 연주가 아닌 음반(재즈 편곡, 다시 지은 곡, 태교·수면용 모음). 앨범 이름에서 찾는다
NOT_ORIGINAL = re.compile(
    r"jazz version|[\[(]jazz|recomposed|for babies|prenatal|pregnan|newborn|baby sleep|"
    r"sleep music|soothing|relaxing|lullaby vol|lo-?fi|remix"
)
# 작곡가가 정해진 작품번호 체계(WoO 는 여럿이 써서 뺀다). 트랙에 다른 작곡가의 번호가 있으면
# 다른 작품이다
# (비발디 「Op. 5」를 찾다 헨델 「Op. 5, HWV 399」 트랙을 세었다)
SYSTEM_OWNER = {
    "bwv": "bach",
    "hwv": "handel",
    "rv": "vivaldi",
    "hob": "haydn",
    "wab": "bruckner",
    "sz": "bartok",
    "bb": "bartok",
    "fwv": "franck",
    "trv": "strauss",
}
SYSTEM_TOKEN = re.compile(r"\b(" + "|".join(SYSTEM_OWNER) + r")\.?\s*\d")


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
        # 앨범 이름만 본다(크럼 「Apparition」 가사에 「soothing death」가 있다)
        if NOT_ORIGINAL.search(norm(str(track.get("collectionName", "")))):
            return False
        if any(SYSTEM_OWNER[m.group(1)] != surname for m in SYSTEM_TOKEN.finditer(name)):
            return False
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

    # 아티스트 이름에서는 이름과 성을 다 본다. 성만 보면 연주자 이름에 걸린다
    # (아서 벤저민 ← 「Benjamin Schmid」, 프란츠 슈미트 ← 연주자 「… Schmidt」)
    given = re.sub(r"[^a-z ]", " ", plain(row["composer_en"])).split()[:1]

    def by_composer(track: dict[str, Any]) -> bool:
        if surname in plain(str(track.get("collectionName", ""))):
            return True
        artist = re.sub(r"[^a-z ]", " ", plain(str(track.get("artistName", "")))).split()
        return surname in artist and all(word in artist for word in given)

    def other_composer(track: dict[str, Any]) -> bool:
        """여러 작곡가 모음 음반에서, 제목 구절로 찾은 트랙에 작품번호가 있는데
        앨범 이름의 이 작곡가 몫(「성: …」)에 그 구절이 없다.

        「Rózsa: Violin Concerto, Op. 24 … - Benjamin: Romantic Fantasy」의 로자 협주곡을
        벤저민 「Violin Concerto」로 세지 않는다.
        """
        if cat or phrase is None:
            return False
        if not CATALOGUE_TOKEN.search(norm(str(track.get("trackName", "")))):
            return False
        segments = re.split(r"\s+[-\u2013/]\s+|;", norm(str(track.get("collectionName", ""))))
        composers = [segment for segment in segments if re.match(r"\s*[^:]{2,40}:", segment)]
        mine = [segment for segment in composers if surname in plain(segment.split(":", 1)[0])]
        return (
            len(composers) >= 2
            and bool(mine)
            and not any(re.search(re.escape(phrase), segment) for segment in mine)
        )

    want = int(row["nparts"])
    albums: dict[str, list[int]] = defaultdict(list)
    for index, track in enumerate(tracks):
        if is_work(track) and by_composer(track) and not other_composer(track):
            albums[str(track["collectionId"])].append(index)
    if cat:
        # 트랙 이름이 악장 이름뿐인 앨범: 앨범 이름에 작품번호가 있고,
        # 작품번호 붙은 트랙이 하나도 없고, 트랙 수가 곡 수와 같으면 그 트랙들이 작품이다
        # (match.py 의 'album' 규칙과 같은 조건)
        bare: dict[str, list[int]] = defaultdict(list)
        for index, track in enumerate(tracks):
            album_name = norm(str(track.get("collectionName", "")))
            if (
                by_composer(track)
                and re.search(cat, album_name)
                and not NOT_ORIGINAL.search(album_name)
            ):
                bare[str(track["collectionId"])].append(index)
        for album, indexes in bare.items():
            if album in albums or len(indexes) != want:
                continue
            names = [norm(str(tracks[i].get("trackName", ""))) for i in indexes]
            if not any(re.search(cat, name) for name in names) and bare_tracks(
                names, row["title_en"], row["catalogue"]
            ):
                albums[album] = indexes
    if not albums:
        return None

    def excerpted(indexes: list[int]) -> bool:
        # 발췌·하이라이트 음반은 트랙이 곡 수보다 많아도 작품이 다 든 것이 아니다
        # (막으로 나눈 오페라의 발췌 음반이 '곡 수 이상'으로 잡혔다).
        # 트랙은 작품 이름 쪽(첫 「:」 앞)만 본다.
        # 베리오 「Recital I」에는 「Excerpts: …」라는 대목이 있다
        names = [str(tracks[i].get("trackName", "")).split(":", 1)[0] for i in indexes]
        names.append(str(tracks[indexes[0]].get("collectionName", "")))
        return any(EXCERPT.search(plain(name)) for name in names)

    def score(item: tuple[str, list[int]]) -> tuple[int, int, int, int]:
        _, indexes = item
        first = tracks[indexes[0]]
        names = norm(str(first.get("collectionName", "")))
        dedicated = bool(
            (cat and re.search(cat, names))
            or (phrase and re.search(re.escape(phrase) + r"(?![0-9a-z])", names))
        )
        exact = len(indexes) == want
        enough = exact or (len(indexes) > want and not excerpted(indexes))
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
        else ("more" if len(indexes) > want and not excerpted(indexes) else "partial"),
        "current": row.get("current_url", ""),
        "tracks": [tracks[i]["trackName"] for i in indexes[:4]],
    }
