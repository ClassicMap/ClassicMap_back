# ruff: noqa: E501, RUF001, RUF002 — 한국어 설명과 원어 문장부호를 그대로 둔다.
"""새로 넣은 작품(12명)의 Apple Music·Spotify 링크를 고른다. 홍난파·김동진은 korean.py 에서 따로 본다.

앨범 고르기는 ../piece-album-links-2026-11-08/album_pick.pick 의 규칙(작품번호·제목 구절·작곡가·원곡 음반·발췌)을
앨범마다 돌려 쓰고, 그 앞에 트랙을 거른다.
- 작곡가: 같은 성의 다른 작곡가 표기(요한·요제프 슈트라우스, 카를 슈타미츠, 알레산드로 스카를라티, 대니얼 퍼셀,
  루카스 리게티)가 있으면 버린다. 요한 슈타미츠는 「Johann」「J. Stamitz」「Stamic」, 윤이상은 「Isang」「윤이상」「Yun:」이
  앨범·아티스트·트랙 어딘가에 있어야 한다(「yun」이 「Hyun」「Yunchan」에 걸리지 않게).
  스카를라티는 작품번호(K.)가 없는 성악곡이면 「Domenico」「D. Scarlatti」가 있어야 한다.
- 편곡: 트랙이나 앨범 이름에 arr.·arranged·transcription·Bearbeitung·version for·기타·마림바판 따위가 있으면 버린다.
- 작품번호: 「K. 3」은 「Kk. 3」도 본다. TWV 의 조성 글자는 대소문자가 뜻이 있어(55:G2 장조, 55:g2 단조) 원래 꼴로 견준다.
- 조성: 제목에 조성이 있으면 트랙의 작품 이름 쪽(첫 「:」 앞)에 적힌 조성이 같아야 한다.

맨 위 작품
- 안 곡이 있는 작품: 작품 트랙 수가 곡 수와 같은 앨범(exact) → 곡 수 이상(more) → 앨범 이름에 작품번호·제목 → 검색 순서.
  exact·more 만 작품 링크로 쓴다. partial 앨범은 안 곡 링크에만 쓴다.
- 안 곡이 없는 작품: 오페라·칸타타·미사 같은 큰 작품은 작품 트랙이 둘 이상이고(발췌 음반이 아니고) 앨범 이름이 그 작품을
  가리키거나 작품 트랙이 넷 이상인 앨범의 앨범 링크만 쓴다(아리아 한 곡 트랙을 붙이지 않는다).
  그 밖은 작품 트랙이 하나면 그 트랙 링크, 둘 이상이면(여러 악장) 앨범 링크.
안 곡: 고른 앨범(이미 링크가 있으면 그 앨범)의 전체 트랙에 ../part-apple-links-2026-11-08/match.py 의 match_set(맨 위 곡)과
match_children(곡 안 곡)을 돌린다. 이미 링크가 있는 곡은 건드리지 않는다.

순서: pick.py <작업 폴더> want → fetch_albums.py 로 후보 앨범 전체 트랙을 받고 → pick.py <작업 폴더> decide → decisions.jsonl
"""

from __future__ import annotations

import difflib
import json
import os
import re
import sys
from collections import defaultdict
from typing import Any

from common import HERE, KOREAN, PICK_DIR, YUN, load_json, load_module, plain, read_tsv

album_pick: Any = load_module("album_pick", os.path.join(PICK_DIR, "album_pick.py"))
match: Any = album_pick._match
spotify_pick: Any = load_module("spotify_pick", os.path.join(PICK_DIR, "spotify_pick.py"))

_catalogue_regex = match.catalogue_regex


TWV_LABEL = re.compile(r"^\s*TV?WV\s*(\d+)\s*:\s*([A-Za-z]*)\s*(\d+)\s*$")


def catalogue_regex(label: str) -> str | None:
    """「K. 3」(스카를라티)은 「Kk. 3」도 찾는다. 「TWV 5:30」은 콜론 뒤 번호까지 본다
    (match.catalogue_regex 는 「TWV 5:30」을 「TWV 5」로 읽어 「Matthäus-Passion, TWV 5:15」에 걸렸다)."""
    twv = TWV_LABEL.match(plain(label))
    if twv:
        letters = rf"{twv.group(2).lower()}\s*" if twv.group(2) else ""
        return rf"\btwv\.?\s*{twv.group(1)}\s*:\s*{letters}{twv.group(3)}(?![\d])"
    found: str | None = _catalogue_regex(label)
    if found and found.startswith(r"\bk\.?"):
        found = r"\bkk?\.?" + found[len(r"\bk\.?") :]
    return found


album_pick.catalogue_regex = catalogue_regex
match.catalogue_regex = catalogue_regex

NEGATIVE = {
    "498": re.compile(
        r"\b(johann|josef|eduard|oscar|j\.)\s*strauss|\bstrauss (ii|jr|sohn|vater)\b|\bstraus\b"
    ),
    "24": re.compile(r"\b(carl|karl|anton|c\.|k\.)\s*stamitz"),
    "9": re.compile(r"\b(alessandro|a\.)\s*scarlatti"),
    "8": re.compile(r"\bdaniel purcell"),
    "499": re.compile(r"\blukas ligeti"),
}
POSITIVE = {
    "24": re.compile(
        r"\bjohann\b[^|]*stamitz|\bj\.\s*(w\.\s*)?(a\.\s*)?stamitz|stamic|\bjan\b[^|]*stamitz"
    ),
    YUN: re.compile(r"\bisang\b|윤이상|\byun\s*:"),
}
SCARLATTI_VOCAL = re.compile(r"\bdomenico\b|\bd\.\s*scarlatti")
ARRANGED = re.compile(
    r"\b(arr|arranged|arrangements?|arrangiert|transcri\w*|bearb\w*|version for|for guitar|for marimba|"
    r"guitar version|piano version|music box|karaoke|8[- ]?bit|cover|remix|lo-?fi|jazz|reali[sz]\w*)\b|편곡|태교|오르골|자장가|힐링"
)
TWV = re.compile(r"TWV\s*(\d+)\s*:\s*([A-Za-z]+)\s*(\d+)")
# 안 곡이 없어도 여러 트랙인 큰 작품. 낱곡·아리아 트랙을 붙이지 않는다
BIG = re.compile(
    r"\b(opera|oper|semi-opera|masque|cantata|kantate|oratorio|oratorium|passion|mass|messe|missa|requiem|"
    r"vespro|vespers|singspiel|serenata|ode|ballet|ballett|tanzspiel|melodram\w*)\b",
    re.I,
)


def review_skip() -> dict[tuple[str, str, str], str]:
    """눈으로 보고 뺀 고르기(review-skip.tsv: piece_id, service, album_id, 까닭). 그 앨범이면 다음 후보를 본다."""
    path = os.path.join(HERE, "review-skip.tsv")
    if not os.path.exists(path):
        return {}
    return {(r["piece_id"], r["service"], r["album_id"]): r["why"] for r in read_tsv(path)}


REVIEW_SKIP = review_skip()


def composer_text(track: dict[str, Any]) -> str:
    return plain(
        f"{track.get('collectionName', '')} | {track.get('artistName', '')} | {track.get('trackName', '')}"
    ).lower()


def twv_ok(track_name: str, catalogue: str) -> bool:
    mine = TWV.search(plain(catalogue))
    if not mine:
        return True
    for theirs in TWV.finditer(plain(track_name)):
        same_number = theirs.group(1) == mine.group(1) and theirs.group(3) == mine.group(3)
        same_letter = theirs.group(2).lower() == mine.group(2).lower()
        if same_number and same_letter and theirs.group(2) != mine.group(2):
            return False
    return True


def usable(row: dict[str, str], track: dict[str, Any]) -> bool:
    """작품 트랙 후보로 볼 수 있는 트랙인가(작곡가·편곡·TWV 대소문자·조성)."""
    text = composer_text(track)
    cid = row["composer_id"]
    if cid in NEGATIVE and NEGATIVE[cid].search(text):
        return False
    if cid in POSITIVE and not POSITIVE[cid].search(text):
        # Spotify 트랙 아티스트로 작곡가를 확인한 앨범과 이름이 같은 Apple 앨범은 같은 음반으로 본다
        # (「Stamitz: Symphonies, Op. 3 Nos. 1 & 3-6」 — Apple 은 아티스트에 연주자만 적는다)
        trusted = row.get("trusted", "")
        if not trusted or match.norm(str(track.get("collectionName", ""))) not in trusted.split(
            "|"
        ):
            return False
    if cid == "9" and not row["catalogue"] and not SCARLATTI_VOCAL.search(text):
        return False
    name = str(track.get("trackName", ""))
    # Spotify 는 클래식 트랙 아티스트에 작곡가를 적는다. 여러 작곡가 모음 음반에서 앨범 이름의 성만 보고
    # 다른 작곡가 곡(쿨라우 「Sonatina Op. 20 No. 1」을 클레멘티 Op. 20 으로)을 세지 않게 트랙 쪽 표기를 본다
    if "open.spotify.com" in str(track.get("trackViewUrl", "")):
        sur = album_pick.surname_of(row["composer_en"])
        own = plain(f"{track.get('artistName', '')} {name}").lower()
        if sur and sur not in own and not (cid == YUN and POSITIVE[YUN].search(own)):
            return False
    if ARRANGED.search(name.lower()) or ARRANGED.search(
        str(track.get("collectionName", "")).lower()
    ):
        return False
    if not twv_ok(name, row["catalogue"]):
        return False
    mine = match.key_of(row["title_en"])
    theirs = match.key_of(name.split(":", 1)[0])
    if mine and theirs and mine != theirs:
        return False
    head = match.norm(name.split(":", 1)[0])
    cat = catalogue_regex(row["catalogue"]) if row["catalogue"] else None
    if (
        cat
        and re.search(cat, match.norm(name))
        and several_composers(str(track.get("collectionName", "")), row)
    ):
        # 「Schoenberg: Violin Concerto - Sibelius: Violin Concerto」처럼 작곡가가 여럿인 앨범에서 작품번호와
        # 흔한 낱말(Violin)만 맞으면 다른 작곡가의 같은 번호(시벨리우스 Op. 47)일 수 있어 제목 첫 낱말을 본다
        words = album_pick.title_words(pick_row(row)["title_en"].split(",", 1)[0])
        track_words = re.sub(r"[^a-z ]", " ", head).split()
        if words and not any(
            difflib.SequenceMatcher(None, words[0], w[:5]).ratio() >= 0.75 for w in track_words
        ):
            return False
    if (
        cat
        and row.get("movements") == "1"
        and not re.search(r"\bno\.?\s*\d", match.norm(row["title_en"] + " " + row["catalogue"]))
    ):
        # 악장으로 나눈 낱개 작품(클레멘티 「Sonata in C major, op. 20」)에 「Op. 20 No. 1」 트랙은 다른 묶음의 한 곡이다
        # (작곡가가 여럿인 연습곡 음반의 쿨라우 소나티네 Op. 20 No. 1)
        found = re.search(cat, head)
        if found and re.match(
            r"^[\s,.]*(?:no|nr)\.?\s*\d+[^:]*:\s*[ivx]+\.", match.norm(name)[found.end() :]
        ):
            return False
    if not row["catalogue"]:
        # 작품번호가 없는 작품(쇤베르크 「String Quartet in D major」, 1897)에 작품번호·번호가 붙은 트랙
        # (「String Quartet No. 1, Op. 7」)은 다른 작품이다
        if match.CATALOGUE_TOKEN.search(head):
            return False
        theirs_no = re.search(r"\bno\.?\s*(\d+)", head)
        mine_no = re.search(r"\bno\.?\s*(\d+)", match.norm(row["title_en"]))
        if theirs_no and (not mine_no or mine_no.group(1) != theirs_no.group(1)):
            return False
    # 이 제목을 품은 더 긴 같은 작곡가 제목(「Aventures」 ↔ 「Nouvelles aventures」)의 트랙은 그 작품이다
    longer = row.get("longer", "")
    return not (longer and any(p and p in match.norm(name) for p in longer.split("|")))


def several_composers(album_name: str, row: dict[str, str]) -> bool:
    """앨범 이름이 「A: … - B: …」꼴로 작곡가 여럿을 나열하고 그중 이 작곡가가 아닌 것이 있다."""
    sur = album_pick.surname_of(row["composer_en"])
    heads = [
        plain(seg.split(":", 1)[0]).lower()
        for seg in re.split(r"\s+[-\u2013/]\s+|;|\s*&\s*(?=[A-Z][a-z]+:)", album_name)
        if ":" in seg
    ]
    return len(heads) >= 2 and any(sur not in h for h in heads)


GERMAN_TITLE = [
    (r"\b(?:wald)?hornkonzert\b", "Horn Concerto"),
    (r"\bkonzert für horn und orchester\b", "Horn Concerto"),
    (r"\bviolinkonzert\b", "Violin Concerto"),
    (r"\bklavierkonzert\b", "Piano Concerto"),
    (r"\bkonzert für violine und streichorchester\b", "Violin Concerto"),
    (r"\bkonzert\b", "Concerto"),
]


def pick_row(row: dict[str, str]) -> dict[str, str]:
    """album_pick.pick 에 넘길 행: 제목에서 작품번호를 뗀다(조성은 둔다). 안 곡이 없으면 곡 수 1."""
    title = row["title_en"]
    m = re.search(r"<([^<>]+)>", title)
    if m:
        title = m.group(1)
    title = re.sub(r"\([^)]*\)", " ", title)
    # 독일어 제목(「Waldhornkonzert Es-Dur nr. 1」)은 트랙 이름(「Horn Concerto No. 1」)과 낱말이 안 맞아 갈래 말만 영어로 바꾼다
    for german, english in GERMAN_TITLE:
        title = re.sub(german, english, title, flags=re.I)
    title = re.sub(
        r",?\s*\b(?:op|opus|sv|z|twv|kais|wols|wolf|av|trv|kk|k|l|woo|hob)\.?\s*[\w.:/–-]*\d[\w.:/–-]*",
        " ",
        title,
        flags=re.I,
    )
    # 따옴표 부제는 서비스마다 적는 꼴이 달라(쉼표·작은따옴표) 본제목만으로 작품을 가릴 수 있으면 뗀다
    bare = re.sub(r"[\"“”«»„][^\"“”«»„]*[\"“”«»„]", " ", title)
    rest = re.sub(r"[^a-z ]", " ", match.GENERIC.sub(" ", match.norm(bare)))
    if len("".join(rest.split())) >= 5 and not row["catalogue"]:
        title = bare
    title = re.sub(r"[\"“”«»„]", " ", title)
    title = re.sub(r"\s*,\s*(?=[,:]|$)", "", " ".join(title.split())).strip(" ,:")
    return {
        "piece_id": row["piece_id"],
        "composer_en": row["composer_en"],
        "title_en": title,
        "catalogue": row["catalogue"],
        # 곡 안 곡이 있는 묶음(소나타 셋 → 악장 아홉)은 트랙 수를 맨 끝 곡 수로 센다.
        # 맨 위 곡 수로 세면 소나타 하나(세 악장)만 든 앨범이 「소나타 3곡」 묶음과 같다고 나온다
        "nparts": str(max(int(row.get("leaves") or row["nparts"] or 0), 1)),
    }


def search_tracks(work: str, service: str, piece_id: str) -> list[dict[str, Any]]:
    out: list[dict[str, Any]] = []
    for n in (1, 2, 3):
        path = os.path.join(work, f"{service}_search", f"{piece_id}_{n}.json")
        if not os.path.exists(path):
            continue
        data = load_json(path)
        if service == "apple":
            out += [r for r in data.get("results", []) if r.get("wrapperType") == "track"]
        else:
            out += spotify_pick.from_search(data)
    seen: set[str] = set()
    unique = []
    for track in out:
        key = str(track.get("trackId"))
        if key not in seen:
            seen.add(key)
            unique.append(track)
    return unique


def full_tracks(work: str, service: str, album_id: str) -> list[dict[str, Any]] | None:
    path = os.path.join(work, f"{service}_albums", f"{album_id}.json")
    if not os.path.exists(path):
        return None
    results = load_json(path).get("results", [])
    tracks = [r for r in results if r.get("wrapperType") == "track" and r.get("trackViewUrl")]
    return sorted(tracks, key=lambda r: (r.get("discNumber") or 0, r.get("trackNumber") or 0))


def album_of(url: str, service: str) -> str | None:
    if service == "apple":
        if "?i=" in url:
            return None
        m = re.search(r"/album/(?:[^/?]*/)?(\d{6,})", url)
    else:
        m = re.search(r"open\.spotify\.com/album/([A-Za-z0-9]{22})", url)
    return m.group(1) if m else None


def evaluate(
    row: dict[str, str], tracks: list[dict[str, Any]]
) -> tuple[dict[str, Any] | None, list[dict[str, Any]]]:
    """한 앨범의 트랙으로 album_pick.pick 을 돌린다. (판정, 작품 트랙들)."""
    prow = pick_row(row)
    good = [t for t in tracks if usable(row, t)]
    if RANGE.search(match.norm(row["catalogue"])):
        return evaluate_range(row, good)
    found = album_pick.pick(prow, good) if good else None
    if not found and not row["catalogue"]:
        return evaluate_words(row, good)
    if not found:
        return None, []
    names = set(found["tracks"])
    sur = album_pick.surname_of(row["composer_en"])
    # pick 은 작품 트랙 이름을 앞 넷만 돌려주므로, 같은 판정을 트랙 하나씩 돌려 작품 트랙을 모두 찾는다.
    # 이때 앨범 이름은 작곡가 성만 남긴다(트랙 하나만 주면 「악장 이름뿐인 앨범」 규칙이 아무 트랙에나 걸린다)
    work_tracks = []
    for track in good:
        album_name = str(track.get("collectionName", ""))
        alone_track = dict(
            track, collectionName=sur if sur and sur in plain(album_name).lower() else ""
        )
        alone = album_pick.pick(dict(prow, nparts="1"), [alone_track])
        if alone or str(track.get("trackName")) in names:
            work_tracks.append(track)
    return found, work_tracks


WORD_STOP = {
    "for",
    "and",
    "the",
    "with",
    "from",
    "orchestra",
    "orchester",
    "small",
    "large",
    "grosses",
    "kleines",
    "und",
    "fur",
    "pour",
    "avec",
    "des",
    "der",
    "die",
    "das",
    "von",
    "per",
    "solo",
    "major",
    "minor",
}
SYNONYM = {"violoncello": "cello", "konzert": "concerto", "violine": "violin", "klavier": "piano"}


def word_set(text: str) -> set[str]:
    words = re.sub(r"[^a-z ]", " ", match.norm(text)).split()
    return {SYNONYM.get(w, w) for w in words if len(w) >= 4 and w not in WORD_STOP}


ROMAN_NUM = {
    "i": 1,
    "ii": 2,
    "iii": 3,
    "iv": 4,
    "v": 5,
    "vi": 6,
    "vii": 7,
    "viii": 8,
    "ix": 9,
    "x": 10,
}


def numbered(text: str, want: dict[str, int] | None = None) -> dict[str, int]:
    """「Book 3」「No. 1」「Part II」 같은 번호(아라비아·로마 숫자). want 를 주면, 「Chamber Symphony I」처럼
    「No.」 없이 끝에 붙은 로마 숫자도 want 의 no 로 읽는다."""
    norm = match.norm(text)
    out: dict[str, int] = {}
    for kind, num in re.findall(r"\b(book|no|nr|part|vol|heft)\.?\s*(\d+|[ivx]+)\b", norm):
        kind = "no" if kind == "nr" else kind
        out[kind] = int(num) if num.isdigit() else ROMAN_NUM.get(num, 0)
    if want and "no" in want and "no" not in out:
        tail = re.search(r"\b([ivx]+|\d+)\s*$", norm.strip())
        if tail:
            num = tail.group(1)
            out["no"] = int(num) if num.isdigit() else ROMAN_NUM.get(num, 0)
    return out


def track_head(name: str) -> str:
    """트랙 이름의 작품 부분: 첫 「:」「(」「 - 」 앞."""
    return re.split(r":|\(|\[|\s-\s", name, maxsplit=1)[0]


def evaluate_words(
    row: dict[str, str], tracks: list[dict[str, Any]]
) -> tuple[dict[str, Any] | None, list[dict[str, Any]]]:
    """작품번호가 없고 제목 구절이 트랙 이름과 꼴이 달라 album_pick.pick 이 못 찾은 작품.
    - 짧은 제목(윤이상 「Bara」「Namo」「Muak」, 다섯 글자 미만이라 제목 구절로 안 본다): 트랙 작품 부분의 첫 낱말들이 제목과 같다.
    - 그 밖: 제목의 뜻 있는 낱말(편성 말 Orchestra 등은 빼고, Violoncello=Cello)이 트랙 작품 부분에 다 있다
      (리게티 「Trio for Violin, Horn, and Piano」 ↔ 「Trio for Violin, Horn and Piano (1982)」,
      「Concerto for Violoncello and Orchestra」 ↔ 「Cello Concerto (1966)」).
    앨범 이름이나 아티스트에 작곡가 성이 있어야 한다."""
    if not tracks:
        return None, []
    title = re.sub(r"\([^)]*\)", " ", pick_row(row)["title_en"])
    title = match.KEY_EN.sub(" ", match.norm(title))
    mine = word_set(title)
    short = " ".join(re.sub(r"[^a-z ]", " ", title).split())
    if not mine and not short:
        return None, []
    sur = album_pick.surname_of(row["composer_en"])
    given = plain(row["composer_en"]).lower().split()[0]
    numbers = numbered(title)
    work_tracks = []
    for track in tracks:
        # 여러 작곡가 모음 음반(「Works for Violin Solo - Isang Yun / Schnittke / …」)의 같은 갈래 곡을 세지 않게,
        # 앨범 이름이 이 작곡가로 시작하거나 트랙 아티스트·이름에 작곡가가 있어야 한다
        album = plain(str(track.get("collectionName", ""))).lower()
        own = plain(f"{track.get('artistName', '')} {track.get('trackName', '')}").lower()
        if not (
            re.match(rf"^(?:{re.escape(given)}\s+)?{re.escape(sur)}\b", album)
            or re.search(rf"\b{re.escape(sur)}\b", own)
        ):
            continue
        head = match.norm(track_head(str(track.get("trackName", ""))))
        head_plain = " ".join(re.sub(r"[^a-z ]", " ", head).split())
        if numbered(head, numbers) != numbers:
            continue
        if len(mine) <= 1:
            if head_plain == short or head_plain.startswith(short + " "):
                work_tracks.append(track)
        elif mine <= word_set(head) and len(word_set(head) - mine) <= 1:
            work_tracks.append(track)
    if not work_tracks:
        return None, []
    want_n = max(int(row.get("leaves") or row["nparts"] or 0), 1)
    n = len(work_tracks)
    found = {
        "pieceId": int(row["piece_id"]),
        "albumId": str(work_tracks[0].get("collectionId")),
        "albumUrl": album_pick.album_url(work_tracks[0]),
        "albumName": str(work_tracks[0].get("collectionName", "")),
        "workTracks": n,
        "parts": want_n,
        "status": "exact" if n == want_n else ("more" if n > want_n else "partial"),
        "tracks": [str(t.get("trackName", "")) for t in work_tracks[:4]],
    }
    return found, work_tracks


RANGE = re.compile(r"^([a-z]+)\.?\s*(\d+)\s*-\s*(\d+)$")


def evaluate_range(
    row: dict[str, str], tracks: list[dict[str, Any]]
) -> tuple[dict[str, Any] | None, list[dict[str, Any]]]:
    """작품번호가 범위(「SV 23–39」「Z 802–811」)인 묶음: 범위 안 번호가 적힌 트랙을 작품 트랙으로 센다.
    album_pick.pick 은 범위를 못 읽는다. 앨범 이름이나 아티스트에 작곡가 성이 있어야 한다."""
    m = RANGE.search(match.norm(row["catalogue"]))
    if not m or not tracks:
        return None, []
    system, low, high = m.group(1), int(m.group(2)), int(m.group(3))
    token = re.compile(rf"\b{system}\.?\s*(\d+)(?![\d])")
    sur = album_pick.surname_of(row["composer_en"])
    by_album: dict[str, list[dict[str, Any]]] = defaultdict(list)
    for track in tracks:
        if (
            sur
            not in plain(f"{track.get('collectionName', '')} {track.get('artistName', '')}").lower()
        ):
            continue
        numbers = [int(x) for x in token.findall(match.norm(str(track.get("trackName", ""))))]
        if numbers and all(low <= x <= high for x in numbers):
            by_album[str(track.get("collectionId"))].append(track)
    if not by_album:
        return None, []
    album, work_tracks = max(
        by_album.items(),
        key=lambda kv: len({match.norm(str(t.get("trackName", ""))) for t in kv[1]}),
    )
    want_n = max(int(row["nparts"] or 0), 1)
    distinct = len(
        {
            int(x)
            for t in work_tracks
            for x in token.findall(match.norm(str(t.get("trackName", ""))))
        }
    )
    status = "exact" if distinct == want_n else ("more" if distinct > want_n else "partial")
    found = {
        "pieceId": int(row["piece_id"]),
        "albumId": album,
        "albumUrl": album_pick.album_url(work_tracks[0]),
        "albumName": str(work_tracks[0].get("collectionName", "")),
        "workTracks": len(work_tracks),
        "parts": want_n,
        "status": status,
        "tracks": [str(t.get("trackName", "")) for t in work_tracks[:4]],
    }
    return found, work_tracks


def rank_albums(
    row: dict[str, str], tracks: list[dict[str, Any]]
) -> list[tuple[tuple[int, int, int, int], str]]:
    """검색 결과를 앨범별로 나눠 pick 판정이 난 앨범을 점수순으로."""
    order: dict[str, int] = {}
    by_album: dict[str, list[dict[str, Any]]] = defaultdict(list)
    for index, track in enumerate(tracks):
        album = str(track.get("collectionId"))
        order.setdefault(album, index)
        by_album[album].append(track)
    ranked = []
    for album, items in by_album.items():
        found, _ = evaluate(row, items)
        if not found:
            continue
        ranked.append((score(row, found), album))
    ranked.sort(key=lambda x: (x[0], -order[x[1]]), reverse=True)
    return ranked


def score(row: dict[str, str], found: dict[str, Any]) -> tuple[int, int, int, int]:
    dedicated = int(names_work(row, str(found["albumName"])))
    if not int(row["nparts"] or 0):
        if big_work(row):
            # 큰 작품은 이름이 그 작품인 앨범, 작품 트랙이 많은 앨범(전곡)부터
            return (dedicated, int(found["workTracks"] >= 2), min(int(found["workTracks"]), 99), 0)
        # 낱곡은 이름이 그 작품인 앨범을 먼저 보고, 나머지는 검색 순서대로
        return (dedicated, 0, 0, 0)
    return (
        int(found["status"] == "exact"),
        int(found["status"] in ("exact", "more")),
        dedicated,
        int(found["workTracks"]),
    )


def names_work(row: dict[str, str], album_name: str) -> bool:
    """앨범 이름이 이 작품을 가리키나: album_pick.names_work(성 + 작품번호, 없으면 제목 구절)이거나,
    작품번호가 있어도 성과 본제목(쉼표 앞) 구절이 앨범 이름에 있다(「Telemann: Flavius Bertaridus」)."""
    prow = pick_row(row)
    if album_pick.names_work(prow, album_name):
        return True
    if not row["catalogue"]:
        return False
    phrase = album_pick.title_phrase(prow["title_en"].split(",", 1)[0])
    name = match.norm(album_name)
    sur = album_pick.surname_of(row["composer_en"])
    return bool(
        phrase
        and sur in plain(album_name).lower()
        and re.search(re.escape(phrase) + r"(?![0-9a-z])", name)
    )


def big_work(row: dict[str, str]) -> bool:
    return row["genre"] == "stage" or bool(BIG.search(row["title_en"]))


def track_url(track: dict[str, Any]) -> str:
    return re.sub(r"&uo=\d+$", "", str(track["trackViewUrl"]))


def album_url(track: dict[str, Any]) -> str:
    url = re.sub(r"\?.*$", "", str(track.get("collectionViewUrl", "")))
    if "music.apple.com" in url:
        return str(album_pick.album_url(track))
    return url


def load_rows(work: str) -> list[dict[str, str]]:
    """top.tsv 의 작품(한국 가곡 빼고)에 맨 끝 곡 수(leaves)를 붙인다."""
    parts = read_tsv(os.path.join(work, "parts.tsv"))
    parents = {p["parent_part_id"] for p in parts if p["parent_part_id"]}
    by_piece: dict[str, list[dict[str, str]]] = defaultdict(list)
    for part in parts:
        by_piece[part["piece_id"]].append(part)
    leaves: dict[str, int] = defaultdict(int)
    for part in parts:
        if part["part_id"] not in parents:
            leaves[part["piece_id"]] += 1
    rows = [r for r in read_tsv(os.path.join(work, "top.tsv")) if r["composer_id"] not in KOREAN]
    phrases = {r["piece_id"]: album_pick.title_phrase(pick_row(r)["title_en"]) or "" for r in rows}
    out = []
    for r in rows:
        mine = phrases[r["piece_id"]]
        longer = sorted(
            phrases[o["piece_id"]]
            for o in rows
            if o["composer_id"] == r["composer_id"]
            and o["piece_id"] != r["piece_id"]
            and mine
            and mine in phrases[o["piece_id"]]
            and mine != phrases[o["piece_id"]]
        )
        tops = [p for p in by_piece.get(r["piece_id"], []) if not p["parent_part_id"]]
        movements = bool(tops) and all(
            p["movement"].strip() or re.match(r"^\s*[IVXL]+\.\s", p["name_en"].rsplit(": ", 1)[-1])
            for p in tops
        )
        out.append(
            dict(
                r,
                leaves=str(leaves.get(r["piece_id"], 0)),
                longer="|".join(longer),
                movements="1" if movements else "",
            )
        )
    return out


def want(work: str, services: list[str]) -> None:
    """후보 앨범(검색 점수 앞 넷 + 지금 앨범 링크)을 서비스별로 적는다 → want_<service>.txt."""
    rows = load_rows(work)
    for service, col in (("apple", "apple_music_url"), ("spotify", "spotify_url")):
        if service not in services:
            continue
        ids: list[str] = []
        for row in rows:
            current = album_of(row[col], service) if row[col] else None
            if current:
                ids.append(current)
                continue
            if service == "apple" and row["composer_id"] in POSITIVE and not row["spotify_url"]:
                # Spotify 에서 작곡가를 확인한 앨범 이름을 Apple 에서도 믿는다(decide 와 같게)
                picked, _ = choose(work, "spotify", row)
                if picked and picked.get("albumName"):
                    row = dict(row, trusted=match.norm(str(picked["albumName"])))
            ranked = rank_albums(row, search_tracks(work, service, row["piece_id"]))
            ids += [album for _, album in ranked[:4]]
        ids = list(dict.fromkeys(ids))
        with open(os.path.join(work, f"want_{service}.txt"), "w", encoding="utf-8") as handle:
            handle.write("\n".join(ids) + "\n")
        print(service, len(ids))


def excerpt_track(row: dict[str, str], track: dict[str, Any]) -> bool:
    """안 곡이 없는 작품의 트랙 하나가 작품 전체가 아니라 한 대목인가.
    작품번호(없으면 제목 구절) 뒤 「:」 다음에 빠르기말이 아닌 이름(「Z. 333: "So When the Glittering…"」「: I. …」)이 있으면 대목이다.
    스카를라티 「K. 3: Presto」처럼 빠르기말뿐이면 작품 전체다."""
    name = match.norm(str(track.get("trackName", "")))
    prow = pick_row(row)
    cat = (
        catalogue_regex(row["catalogue"])
        if row["catalogue"] and not RANGE.search(match.norm(row["catalogue"]))
        else None
    )
    m = re.search(cat, name) if cat else None
    if not m:
        phrase = album_pick.title_phrase(prow["title_en"])
        m = re.search(re.escape(phrase), name) if phrase else None
    rest = name[m.end() :] if m else name
    # 「Don Quixote, Part III, Z. 578」처럼 막·부 하나만 든 트랙
    section = re.compile(r"\b(part|act|akt|acte|book|teil)\.?\s+([ivx]+|\d+)\b")
    if section.search(name) and not section.search(match.norm(row["title_en"])):
        return True
    # 「Militärmarsch, Op. 57 No. 1」처럼 묶음의 한 곡(제목에는 번호가 없다)
    if re.match(r"^[\s,.]*(no|nr)\.?\s*\d", rest) and not re.search(
        r"\bno\.?\s*\d", match.norm(row["title_en"])
    ):
        return True
    if ":" not in rest:
        return False
    tail = rest.split(":", 1)[1]
    tail = re.sub(r"\b(live|remaster\w*|version|edit)\b", " ", tail).strip(" -.,")
    # 악장 번호(「: II. Allegro」「: 3. …」)로 시작하면 한 대목이다
    if re.match(r"^(?:[ivxl]+|\d+)[.)]\s", tail):
        return True
    # 안 곡이 있는 작품은 「:」 뒤에 무엇이든(「: Prelude」) 있으면 한 대목이다
    if int(row["nparts"] or 0) and re.search(r"[a-z]", tail):
        return True
    if not match.distinctive(tail):
        return False
    # 제목에 든 부제가 꼬리에 온 것이면 대목이 아니다
    title_words = set(match.words(row["title_en"]))
    tail_words = match.words(tail)
    return not tail_words or not set(tail_words) <= title_words


def complete(work_tracks: list[dict[str, Any]]) -> bool:
    """여러 트랙 작품이 앨범에 다 들었나: 트랙마다 대목 번호(I.·No. 3·3.)가 있으면 1부터 빠짐없이 있어야 한다."""
    numbers = [match.index_of(str(t.get("trackName", ""))) for t in work_tracks]
    if any(n is None for n in numbers) or len(set(numbers)) != len(numbers):
        return True
    found = {int(n) for n in numbers if n is not None}
    return found == set(range(1, max(found) + 1))


VERSION = re.compile(
    r"\s*[\(\[][^)\]]*\b(live|remaster\w*|version|mono|stereo|recorded|\d{4})\b[^)\]]*[\)\]]"
    r"|\s+-\s+(live|remaster\w*|\d{4})\b.*$",
    re.I,
)


def core_name(track: dict[str, Any]) -> str:
    """트랙 이름에서 판 표시(「(Remastered 2022, Moscow Live 1957)」「- Live」)를 뗀 것. 같은 곡의 다른 판을 한 곡으로 센다."""
    return str(match.norm(VERSION.sub("", str(track.get("trackName", "")))))


def judge(
    row: dict[str, str],
    found: dict[str, Any],
    work_tracks: list[dict[str, Any]],
    tracks: list[dict[str, Any]],
) -> dict[str, Any]:
    """고른 앨범을 맨 위 작품 링크로 쓸지. link 가 album·track 이면 쓰고, 그 밖은 까닭."""
    nparts = int(row["nparts"] or 0)
    dedicated = names_work(row, str(found["albumName"]))
    excerpt = any(
        match.EXCERPT.search(plain(str(t.get("trackName", ""))).lower()) for t in work_tracks
    ) or bool(match.EXCERPT.search(plain(str(found["albumName"])).lower()))
    first = work_tracks[0] if work_tracks else None
    base = {
        "albumId": str(found["albumId"]),
        "albumName": str(found["albumName"]),
        "workTracks": len(work_tracks),
        "status": found["status"],
        "dedicated": dedicated,
        "tracks": [str(t.get("trackName", ""))[:100] for t in work_tracks[:2]],
    }
    if nparts:
        if found["status"] in ("exact", "more"):
            return dict(base, link="album", url=album_url(tracks[0] if tracks else first or {}))
        # 대목으로 나눈 작품(교향시 「Tod und Verklärung」)을 한 트랙에 통째로 담은 녹음은 그 트랙 링크
        if first and len(work_tracks) == 1 and not excerpt and not excerpt_track(row, first):
            return dict(base, link="track", url=track_url(first))
        return dict(base, link="parts-only", url="")
    if not first:
        return dict(base, link="none", url="")
    # 같은 곡을 여러 번 담은 앨범(리마스터·실황 판을 함께 실은 길렐스 스카를라티)은 첫 트랙이 작품 전체다
    cores = {core_name(t) for t in work_tracks}
    if len(work_tracks) > 1 and len(cores) == 1 and not big_work(row):
        work_tracks = work_tracks[:1]
    if len(work_tracks) == 1:
        if big_work(row):
            return dict(base, link="rejected-big", url="")
        if excerpt_track(row, first):
            return dict(base, link="rejected-excerpt-track", url="")
        return dict(base, link="track", url=track_url(first))
    if excerpt or not complete(work_tracks):
        return dict(base, link="rejected-excerpt", url="")
    if big_work(row) and not (dedicated or len(work_tracks) >= 4):
        return dict(base, link="rejected-big", url="")
    # 오페라는 앨범 이름이 그 작품인 전곡 음반만(아리아 모음 음반의 넷을 전곡으로 보지 않는다)
    if row["genre"] == "stage" and not dedicated:
        return dict(base, link="rejected-big", url="")
    return dict(base, link="album", url=album_url(first))


def choose(
    work: str, service: str, row: dict[str, str]
) -> tuple[dict[str, Any] | None, list[dict[str, Any]]]:
    """맨 위 작품에 쓸 앨범(또는 트랙)과 그 앨범 전체 트랙. 판정은 전체 트랙으로 다시 하고,
    점수순으로 보다가 쓸 수 있는 첫 앨범을 고른다. 쓸 앨범이 없으면 첫 앨범과 못 쓴 까닭을 돌려준다."""
    results = search_tracks(work, service, row["piece_id"])
    options: list[
        tuple[
            tuple[int, int, int, int],
            int,
            dict[str, Any],
            list[dict[str, Any]],
            list[dict[str, Any]],
        ]
    ] = []
    for position, (_, album) in enumerate(rank_albums(row, results)[:4]):
        tracks = full_tracks(work, service, album) or [
            t for t in results if str(t.get("collectionId")) == album
        ]
        found, work_tracks = evaluate(row, tracks)
        if found and str(found["albumId"]) == album:
            options.append((score(row, found), position, found, work_tracks, tracks))
    options.sort(key=lambda o: (o[0], -o[1]), reverse=True)

    # 어느 후보 앨범에서든 작품이 서로 다른 트랙 셋 이상으로 나뉘어 있으면 여러 대목짜리 작품이다.
    # 그러면 트랙 하나만 든 앨범은 발췌다(「Don Quixote, Part III」「Celebrate This Festival: Crown the Altar」)
    def distinct(work_tracks: list[dict[str, Any]]) -> int:
        return len({core_name(t) for t in work_tracks})

    most = max((distinct(o[3]) for o in options), default=0)
    multi = most >= 3
    first: tuple[dict[str, Any], list[dict[str, Any]]] | None = None
    for _, _, found, work_tracks, tracks in options:
        verdict = judge(row, found, work_tracks, tracks)
        if verdict["link"] == "track" and multi:
            verdict = dict(verdict, link="rejected-multi", url="")
        # 안 곡이 없는 여러 트랙 작품: 다른 후보 앨범에 든 트랙의 절반도 안 되면 발췌다
        # (「Bonduca」 두 곡만 든 가곡 음반, 「Complete Service」에서 Te Deum·Jubilate 만 든 음반)
        if (
            verdict["link"] == "album"
            and not int(row["nparts"] or 0)
            and distinct(work_tracks) * 2 < most
        ):
            verdict = dict(verdict, link="rejected-partial", url="")
        skip = REVIEW_SKIP.get((row["piece_id"], service, str(found["albumId"])))
        if verdict["url"] and skip:
            verdict = dict(verdict, link="rejected-review", url="", why=skip)
        if verdict["url"]:
            return verdict, tracks
        if first is None:
            first = (verdict, tracks)
    return first if first else (None, [])


def part_rows(parts: list[dict[str, str]], catalogue: str) -> list[dict[str, str]]:
    return [dict(p, catalogue=catalogue) for p in parts]


def match_parts(
    service: str, parts: list[dict[str, str]], tracks: list[dict[str, Any]], catalogue: str
) -> dict[int, tuple[str, str, str]]:
    existing = "part_apple" if service == "apple" else "part_spotify"
    rows = part_rows(parts, catalogue)
    top = sorted((r for r in rows if not r["parent_part_id"]), key=lambda r: int(r["seq"]))
    children_of: dict[str, list[dict[str, str]]] = defaultdict(list)
    for r in rows:
        if r["parent_part_id"]:
            children_of[r["parent_part_id"]].append(r)
    found: dict[int, tuple[str, str, str]] = {}
    if top and tracks:
        found.update(match.match_set(top, tracks))
        if children_of:
            found.update(match.match_children(top, children_of, tracks, catalogue, existing))
    by_id = {int(r["part_id"]): r for r in rows}
    return {
        pid: hit
        for pid, hit in found.items()
        if not by_id[pid][existing].strip()
        and not later_section(by_id[pid], hit)
        and not names_disagree(by_id[pid], hit)
    }


# 곡 이름 견주기에서 뺄 빠르기·나타냄 말(형식 이름 「Ouverture」「Gavotte」는 곡을 가려 주므로 둔다)
TEMPO_WORDS = re.compile(
    r"^(allegro|allegretto|andante|andantino|adagio|adagietto|largo|larghetto|lento|presto|prestissimo|vivace|"
    r"vivo|moderato|maestoso|grave|molto|assai|sostenuto|cantabile|espressivo|poco|troppo|tempo|giusto|"
    r"etwas|sehr|nicht|langsam|rasch|ruhig|bewegt|lebhaft|massig|maessig|schnell|zart|leicht|"
    r"vivement|lentement|vite|doucement|gravement|gaiement|gayement|gracieusement|tendrement|"
    r"live|remastered|remaster|version|stereo|recorded)$"
)
KEY_WORDS = re.compile(r"^(major|minor|flat|sharp|moll)$")
MARK = re.compile(r"(?:\b[ivxl]+\.\s|\b(?:no|nr)\.?\s*\d+[a-z]?[.,:]?\s*|(?:^|\s)\d+\.\s)")


def name_words(text: str) -> list[str]:
    """곡 이름에서 마지막 번호(「III. 」「No. 2,」「3. 」) 뒤의 낱말(넷 글자 이상, 빠르기말 제외).
    번호가 없으면 마지막 「:」 뒤. 둘 다 없으면 견주지 않는다(빈 목록)."""
    norm = match.norm(text.replace("ß", "ss"))
    marks = list(MARK.finditer(norm))
    segs = []
    if marks:
        segs.append(norm[marks[-1].end() :])
    if ":" in norm:
        # 「Variation IV. Walzertempo」처럼 이름이 번호 앞에 오는 꼴도 보게 마지막 「:」 뒤 전체도 본다
        segs.append(norm.rsplit(":", 1)[1])
    words = re.sub(r"[^a-z ]", " ", " ".join(segs)).split()
    return [w for w in words if len(w) >= 4 and not TEMPO_WORDS.match(w) and not KEY_WORDS.match(w)]


def similar(a: str, b: str) -> bool:
    return a.startswith(b) or b.startswith(a) or difflib.SequenceMatcher(None, a, b).ratio() >= 0.75


def names_disagree(part: dict[str, str], hit: tuple[str, str, str]) -> bool:
    """번호·악장·순서로 붙인 트랙의 곡 이름이 우리 곡 이름과 낱말 하나도 비슷하지 않다.
    텔레만 「La Bouffonne」 III. Rigaudon 이 앨범의 III. Les Boiteux 에, 슈트라우스 Op. 29 의 1·2번이 서로 바뀐 앨범에
    붙던 일을 막는다. 한쪽이라도 번호 뒤가 빠르기말뿐이거나 비어 있으면 보지 않는다(번역 차이로 맞는 짝을 버릴 수 있다)."""
    _, track, rule = hit
    if rule not in {"movement", "order", "number", "range", "album"}:
        return False
    mine = name_words(part["name_en"]) or name_words(match.original_name(part))
    theirs = name_words(track)
    if not mine or not theirs:
        return False
    return not any(similar(a, b) for a in mine for b in theirs)


def later_section(part: dict[str, str], hit: tuple[str, str, str]) -> bool:
    """작품번호 범위로 붙인 트랙이 한 곡의 뒷부분(「SV 98b」「SV 98c」)인데 곡 이름이 트랙 이름과 다르다.
    몬테베르디 「Ch'io t'ami, SV 98」가 「Deh bella e cara, SV 98b」(둘째 부분)에 붙던 일을 막는다."""
    _, track, rule = hit
    if rule != "range":
        return False
    suffix = re.search(r"\b[a-z]+\.?\s*\d+([b-z])\b", match.norm(track))
    return bool(suffix) and not match.same_lead(match.original_name(part), track)


def decide(work: str) -> None:
    rows = load_rows(work)
    parts_of: dict[str, list[dict[str, str]]] = defaultdict(list)
    for part in read_tsv(os.path.join(work, "parts.tsv")):
        parts_of[part["piece_id"]].append(part)
    out: list[dict[str, Any]] = []
    for row in rows:
        row = dict(row)
        for service, col in (("spotify", "spotify_url"), ("apple", "apple_music_url")):
            base = {
                "pieceId": int(row["piece_id"]),
                "composerId": int(row["composer_id"]),
                "composer": row["composer_en"],
                "title": row["title_en"],
                "service": service,
            }
            tracks: list[dict[str, Any]] = []
            if row[col]:
                current = album_of(row[col], service)
                tracks = (full_tracks(work, service, current) or []) if current else []
                source = "existing"
            else:
                picked, tracks = choose(work, service, row)
                source = "picked"
                if service == "spotify" and picked and picked.get("albumName"):
                    row["trusted"] = match.norm(str(picked["albumName"]))
                if picked and picked["url"]:
                    out.append(
                        dict(
                            base,
                            kind="piece",
                            decision="fill",
                            new=picked["url"],
                            **{k: v for k, v in picked.items() if k != "url"},
                        )
                    )
                else:
                    out.append(
                        dict(
                            base,
                            kind="piece",
                            decision="not-found",
                            new=None,
                            **({k: v for k, v in picked.items() if k != "url"} if picked else {}),
                        )
                    )
            parts = parts_of.get(row["piece_id"], [])
            if not parts or not tracks:
                continue
            for part_id, (url, name, rule) in sorted(
                match_parts(service, parts, tracks, row["catalogue"]).items()
            ):
                part = next(p for p in parts if int(p["part_id"]) == part_id)
                out.append(
                    {
                        "kind": "part",
                        "pieceId": int(row["piece_id"]),
                        "partId": part_id,
                        "parentPartId": int(part["parent_part_id"])
                        if part["parent_part_id"]
                        else None,
                        "name": (part["name_en"] or part["name_ko"])[-80:],
                        "service": service,
                        "decision": "fill",
                        "new": url,
                        "track": name[-100:],
                        "rule": rule,
                        "albumSource": source,
                    }
                )
    with open(os.path.join(work, "decisions.jsonl"), "w", encoding="utf-8") as handle:
        for item in out:
            handle.write(json.dumps(item, ensure_ascii=False) + "\n")
    counts: dict[str, int] = defaultdict(int)
    for item in out:
        counts[
            f"{item['kind']} {item['service']} {item['decision']} {item.get('link', '')}".strip()
        ] += 1
    for key in sorted(counts):
        print(key, counts[key])


def main() -> None:
    work, step = sys.argv[1], sys.argv[2]
    if step == "want":
        want(work, sys.argv[3:] or ["apple", "spotify"])
    else:
        decide(work)


if __name__ == "__main__":
    main()
