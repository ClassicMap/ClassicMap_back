"""작품 링크(Apple Music·Spotify)가 그 작품을 담은 앨범·트랙인지 판정한다.

작품 트랙은 album_pick.pick 과 같은 규칙으로 센다(트랙 이름에 작품번호와 본제목 낱말, 작품번호가
없으면 조성을 뺀 제목 구절, 앨범·아티스트 이름에 작곡가). 거기에 두 경우를 더 본다.

- 작품번호가 범위인 세트(「BWV 1046-1051」): 트랙에 범위 안의 번호가 있으면 작품 트랙이다.
- 어긋남:
  - 세트 안 곡 번호(「Op. 13, No. 5」)의 조성이 우리 곡 조성과 다르다. 앨범이 다른 작품을 그 번호로
    적었다(보케리니 Op. 11-5 를 「Op. 13 No. 5」로).
  - 제목의 다른 번호(「G. 277-282」「RV 269」)와 같은 체계 번호가 트랙에 있는데 하나도 맞지 않는다.

판정:
- ok: 작품 트랙이 곡 수 이상(exact·more)
- partial: 작품 트랙이 있지만 곡 수보다 적다
- named: 작품 트랙은 못 셌지만 앨범 이름이 이 작곡가의 이 작품을 가리킨다(트랙이 악장 이름뿐)
- loose: 위 규칙에는 안 맞지만 트랙·앨범 이름에 제목의 뜻 있는 낱말이 반 넘게 있고,
  작품번호·「No.」·조성이 어긋나지 않는다. 「O mio babbino caro from Gianni Schicchi」,
  「Candide: Overture」처럼 제목 꼴이 다르거나 아티스트에 작곡가 이름이 다르게 적힌 트랙이다
- conflict: 어긋남이 맞음보다 많다
- doubt: 위에 다 안 맞지만 틀렸다는 증거(어긋난 트랙·다른 작곡가·원곡 아님)도 없다
- box: 위에 다 안 맞는데 받은 트랙이 받을 수 있는 끝(Apple 200·Spotify 100)까지 찼다. 전집 상자라
  뒤쪽에 작품이 있을 수 있다
- wrong: 이 작품 트랙이 없고, 같은 제목인데 번호·조성이 어긋난 트랙이 있거나, 작곡가가 어디에도
  없거나, 원곡 연주가 아니다(why 에 까닭)
- gone: 앨범·트랙이 없어졌다(받은 트랙이 0개)

운영 DB 에 쓰지 않는다. 결과는 audit.jsonl 로만 낸다.
사용: uv run python audit.py <links.tsv> <parts.tsv> <작업 폴더> <out.jsonl>
"""

from __future__ import annotations

import csv
import importlib.util
import json
import os
import re
import sys
from collections import Counter, defaultdict
from pathlib import Path
from types import ModuleType
from typing import Any

PICK_PATH = (
    Path(__file__).resolve().parent.parent / "piece-album-links-2026-11-08" / "album_pick.py"
)


def _load(path: Path, name: str) -> ModuleType:
    spec = importlib.util.spec_from_file_location(name, path)
    if spec is None or spec.loader is None:
        raise ImportError(str(path))
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


album_pick = _load(PICK_PATH, "album_pick")
match = album_pick._match
norm = album_pick.norm
key_of = album_pick.key_of


def surname_of(name: str) -> str:
    """작곡가 성. 「Johann Strauss II」의 「II」처럼 뒤에 붙는 말은 뗀다."""
    words = re.sub(r"[^a-z ]", " ", album_pick.plain(name)).split()
    words = [w for w in words if w not in {"ii", "iii", "jr", "sr"}]
    return words[-1] if words else ""


plain = album_pick.plain

# 제목에 붙은 다른 번호 체계(「G. 277-282」「RV 269」「Hob. III:75」)
OTHER_TOKEN = re.compile(
    r"\b(rv|hwv|bwv|hob|kv?|d|g|wq|h|sz|bb|fwv|trv|kk|ms|fp|twv|lwv|zwv|wab|jw|b|m|l|s)\.?\s*"
    r"((?:[ivx]+\s*:\s*)?\d+)(?:\s*[-\u2013]\s*(\d+))?(?![\d])"
)


def tracks_of(raw: str, album: str) -> list[dict[str, Any]]:
    path = f"{raw}/{album}.json"
    if not os.path.exists(path):
        return []
    with open(path, encoding="utf-8") as handle:
        results = json.load(handle).get("results", [])
    tracks = [r for r in results if r.get("wrapperType") == "track" and r.get("trackViewUrl")]
    return sorted(tracks, key=lambda r: (r.get("discNumber") or 0, r.get("trackNumber") or 0))


def by_composer(row: dict[str, str], track: dict[str, Any]) -> bool:
    surname = surname_of(row["composer_en"])
    if surname and surname in plain(str(track.get("collectionName", ""))):
        return True
    artist = re.sub(r"[^a-z ]", " ", plain(str(track.get("artistName", "")))).split()
    given = re.sub(r"[^a-z ]", " ", plain(row["composer_en"])).split()[:1]
    return bool(surname) and surname in artist and all(word in artist for word in given)


def work_indexes(row: dict[str, str], tracks: list[dict[str, Any]]) -> list[int]:
    """이 작품 트랙의 자리. 트랙 하나씩 album_pick.pick 에 넣어 본다(작품번호 범위는 따로)."""
    # 트랙 하나씩 넣으면 album_pick 의 「악장 이름뿐인 앨범」 규칙(앨범 이름에 작품번호,
    # 트랙 수 = 곡 수)이 아무 트랙에나 걸린다. 곡 수를 2 로 두어 그 규칙을 끈다
    # (트랙 하나는 partial 로 돌아온다)
    single = {**row, "nparts": "2"}
    found = [i for i, track in enumerate(tracks) if album_pick.pick(single, [track])]
    span = match.catalogue_range(row["catalogue"]) if row["catalogue"] else None
    if span:
        system, start, end = span
        pattern = re.compile(rf"\b{system}\.?\s*(\d+)(?![\d])")
        for i, track in enumerate(tracks):
            numbers = [int(n) for n in pattern.findall(norm(str(track.get("trackName", ""))))]
            if (
                i not in found
                and any(start <= n <= end for n in numbers)
                and by_composer(row, track)
            ):
                found.append(i)
    return sorted(found)


LOOSE_SKIP = {
    "from", "with", "the", "and", "for", "opera", "major", "minor", "flat", "sharp", "version",
    "pour", "und", "des", "les", "del", "della", "der", "die", "das", "von", "aus", "une",
}  # fmt: skip
# 갈래 이름(「Sonata」「Concerto」): 이것만 맞아서는 같은 작품이라 할 수 없다
WEAK = {
    "sonat", "conce", "symph", "suite", "quart", "trio", "quint", "piano", "violi", "cello",
    "flute", "strin", "organ", "songs", "song", "dance", "dances", "waltz", "varia", "etude",
    "prelu", "fugue", "overt", "march", "rhaps", "fanta", "scher", "noctu", "mazur",
    "polon", "sere", "seren", "folk", "pieces", "piece", "works", "music", "theme", "sextet",
    "octet", "duet", "mass", "orche", "guita", "harp", "clari", "oboe", "horn", "lied", "lieder",
    "caprice", "capri", "studi", "study", "minue", "rondo", "intro", "class",
}  # fmt: skip
# 악기·편성 이름. 갈래 이름뿐인 제목에서 트랙 이름에 없어도 된다
# (「Piano Etude No. 6」 ↔ 「Etude No. 6」)
INSTRUMENT = {
    "piano", "violi", "cello", "flute", "organ", "guita", "harp", "clari", "oboe", "horn",
    "strin", "orche",
}  # fmt: skip
# 작곡가 성을 다르게 적는 법
SURNAME_ALIAS = {
    "rachmaninoff": "rachmaninov", "tchaikovsky": "tchaikovski tschaikowsky chaikovsky",
    "stravinsky": "strawinsky stravinski", "prokofiev": "prokofieff prokofjew",
    "mussorgsky": "moussorgsky musorgsky", "handel": "haendel", "scriabin": "skryabin scriabine",
    "shostakovich": "shostakovitch schostakowitsch", "glazunov": "glazounov",
}  # fmt: skip
NUMBER = re.compile(r"\b(?:no|nr|n)\.?\s*(\d+)\b")
# 「Variations V」「Sequenza XII」처럼 낱말 바로 뒤 번호
WORD_NUMERAL = re.compile(r"\b([a-z]{4,})\s+([ivx]+|\d+)\b(?![.:]\d)")
# 받을 수 있는 트랙 수 끝(Lookup 200, Spotify 임베드 100)
TRACK_CAPS = {200, 100}
# 작곡가마다 따로 매기는 번호 체계
GENERIC_SYSTEMS = {"op", "woo", "b", "m", "s", "l", "h", "g", "d", "w", "z"}
# 원곡 연주가 아닌 음반(album_pick.NOT_ORIGINAL 에 오르골 편곡·운동·명상 모음을 더한다)
NOT_ORIGINAL = re.compile(
    album_pick.NOT_ORIGINAL.pattern
    + r"|music(?:al)? ?box|karaoke|orgel|spinning|workout|fitness|yoga|meditat|massage"
    + r"|for (?:study|studying|focus|sleep|relax)"
)
# 제목에 붙은 작품번호 꼴(체계 이름 + 숫자). OTHER_TOKEN 보다 넓게 본다
TITLE_TOKEN = re.compile(
    r"\b(op|opus|bwv|kv?|hob|hwv|rv|wab|sz|bb|fwv|woo|trv|wq|twv|lwv|zwv|ms|fp|kk|wd|gb|cnw|rct|jw"
    r"|wwv|z|w|d|h|g|l|m|s|b)\.?\s*((?:[ivx]+\s*[:/]\s*)?\d+[a-z]?)(?![\d])"
)


def numerals(text: str) -> dict[str, set[str]]:
    found: dict[str, set[str]] = defaultdict(set)
    for word, numeral in WORD_NUMERAL.findall(text):
        found[word[:5]].add(numeral)
    return found


def tokens(text: str) -> set[tuple[str, str]]:
    """작품번호 꼴 번호(체계, 번호). 「Hob. II:15」는 ('hob', 'ii:15')."""
    out = set()
    for m in TITLE_TOKEN.finditer(norm(text)):
        system = {"kv": "k", "opus": "op"}.get(m.group(1), m.group(1))
        # 끝 글자(「M. 57c」「Op. 66b」)는 같은 작품의 판이라 번호만 본다
        out.add((system, re.sub(r"[a-z]$", "", re.sub(r"\s+", "", m.group(2)))))
    return out


def word_set(text: str) -> set[str]:
    return {w[:5] for w in re.sub(r"[^a-z ]", " ", norm(text)).split() if len(w) >= 3}


def has_composer(surname: str, text: str) -> bool:
    if not surname or surname in text:
        return True
    return any(alias in text for alias in SURNAME_ALIAS.get(surname, "").split())


def loose_words(title: str) -> list[str]:
    words = re.sub(r"[^a-z ]", " ", norm(title)).split()
    found = [w[:5] for w in words if len(w) >= 4 and w not in LOOSE_SKIP]
    if not found:
        found = [w[:5] for w in words if len(w) >= 3 and w not in LOOSE_SKIP]
    return list(dict.fromkeys(found))


def track_conflict(row: dict[str, str], name: str) -> bool:
    """트랙이 이 작품과 어긋난다.

    같은 체계 다른 번호, 다른 「No.」, 다른 조성, 다른 「Variations V」.
    """
    mine_tokens = tokens(f"{row['catalogue']} {row['title_en']}")
    systems = {system for system, _ in mine_tokens}
    theirs_tokens = {t for t in tokens(name) if t[0] in systems}
    if theirs_tokens and not theirs_tokens & mine_tokens:
        return True
    numbers = set(NUMBER.findall(norm(f"{row['title_en']} {row['catalogue']}")))
    theirs = set(NUMBER.findall(name.split(":")[0] if ":" in name else name))
    if numbers and theirs and not numbers & theirs and not theirs_tokens & mine_tokens:
        return True
    # 작품번호에 「No.」가 있으면(「Op. 10, No. 12」) 콜론 뒤 번호도 본다(「Op. 10: No. 1」)
    in_catalogue = set(NUMBER.findall(norm(row["catalogue"])))
    anywhere = set(NUMBER.findall(name))
    if in_catalogue and anywhere and not in_catalogue & anywhere:
        return True
    key = key_of(row["title_en"])
    their_key = key_of(name)
    if key and their_key and key != their_key:
        return True
    mine_numerals = numerals(norm(row["title_en"]))
    theirs_numerals = numerals(name)
    return any(
        theirs_numerals.get(word) and not values & theirs_numerals[word]
        for word, values in mine_numerals.items()
    )


def loose_indexes(row: dict[str, str], tracks: list[dict[str, Any]]) -> tuple[list[int], int]:
    """(맞는 트랙, 어긋난 트랙 수).

    맞는 트랙: 어긋남이 없고, 작품번호가 같거나, 갈래 이름이 아닌 제목 낱말(앞 5글자, 낱말 단위)이
    반 넘게 있고 그중 하나는 트랙 이름에 있다. 갈래 이름뿐인 제목(「Fantasia for Piano and
    Orchestra」)은 작품번호나 조성이 맞아야 한다. 낱말 하나만 맞으면 작곡가가 트랙·아티스트에
    있어야 한다.
    """
    words = loose_words(row["title_en"])
    strong = [w for w in words if w not in WEAK]
    mine_tokens = tokens(f"{row['catalogue']} {row['title_en']}")
    key = key_of(row["title_en"])
    surname = surname_of(row["composer_en"])
    found: list[int] = []
    bad = 0
    if not words:
        # 「4'33"」처럼 낱말이 없는 제목은 글자·숫자만 이어 붙여 견준다
        compact = re.sub(r"[^a-z0-9]", "", norm(row["title_en"]))
        hits = [
            i
            for i, t in enumerate(tracks)
            if compact and compact in re.sub(r"[^a-z0-9]", "", norm(str(t.get("trackName", ""))))
        ]
        return hits, 0
    for i, track in enumerate(tracks):
        name = norm(str(track.get("trackName", "")))
        album = norm(str(track.get("collectionName", "")))
        if NOT_ORIGINAL.search(album):
            continue
        name_words = word_set(name)
        shares = bool(set(words) & name_words) or bool(tokens(name) & mine_tokens)
        if track_conflict(row, name):
            # 같은 체계 다른 작품번호는 낱말이 안 겹쳐도 다른 작품이라는 증거다(Op. 23 ↔ Op. 28)
            systems = {system for system, _ in mine_tokens}
            other = {t for t in tokens(name) if t[0] in systems}
            bad += int(shares or bool(other and not other & mine_tokens))
            continue
        # Op. 번호는 작곡가마다 따로 매겨서, Op. 만 같으면 제목 낱말이나 작곡가가 겹쳐야 한다
        # (엘가 「Serenade for Strings, Op. 20」 ↔ 「Piano Sonatina in C Major, Op. 20 No. 1」).
        # BWV·K·Hob 처럼 작곡가 고유 번호가 같으면 그대로 같은 작품이다
        same = tokens(name) & mine_tokens
        if same and (
            any(system not in GENERIC_SYSTEMS for system, _ in same)
            or set(words) & name_words
            or has_composer(surname, plain(f"{name} {track.get('artistName', '')} {album}"))
        ):
            found.append(i)
            continue
        # 번호가 맞고 갈래 이름이 다 있으면 같은 작품이다(제목 부분 철자가 달라도:
        # 「String Quartet no. 8 "per Elizabetta"」 ↔ 「String Quartet No. 8 "Per Elisabetta"」)
        numbers = set(NUMBER.findall(norm(row["title_en"])))
        weak = [w for w in words if w in WEAK and w not in INSTRUMENT]
        if (
            numbers
            and numbers <= set(NUMBER.findall(name))
            and weak
            and set(weak) <= name_words
            and has_composer(surname, plain(f"{name} {track.get('artistName', '')} {album}"))
        ):
            found.append(i)
            continue
        if strong:
            # 트랙 이름에만 있는 낱말로 센다. 앨범 이름의 낱말은 같은 앨범의 다른 곡에도 걸린다
            # (「Fauré: Messe Basse - Franck: Panis Angelicus」의 「Messe Basse: I. Kyrie」)
            hit = sum(w in name_words for w in strong)
            if hit * 2 < len(strong):
                continue
        else:
            # 갈래 이름뿐인 제목: 악기 이름 말고는 트랙 이름에 다 있고,
            # 번호·조성 중 하나가 맞아야 한다
            their_key = key_of(name)
            numbers = set(NUMBER.findall(norm(row["title_en"])))
            theirs = set(NUMBER.findall(name))
            needed = [w for w in words if w not in INSTRUMENT] or words
            matched = (numbers and numbers <= theirs) or (key and their_key == key)
            if not (set(needed) <= name_words and matched):
                continue
            hit = 1
        who = plain(f"{name} {track.get('artistName', '')} {album}")
        if hit < 2 and not has_composer(surname, who):
            continue
        found.append(i)
    return found, bad


def part_number(cat: str | None, part: dict[str, str]) -> int:
    """우리 곡의 세트 안 번호. 이름에 「Op. 2 No. 4」「No. 4:」가 있으면 그 번호, 없으면 순서."""
    name = norm(part["name_en"])
    if cat:
        number = sub_number(cat, name)
        if number:
            return number
    lead = re.match(r"\s*(?:no|nr)\.?\s*(\d+)\b", name)
    return int(lead.group(1)) if lead else int(part["seq"])


def sub_number(cat: str, name: str) -> int | None:
    """트랙 이름에서 세트 작품번호 뒤(또는 앞)의 「No. 5」「/5」."""
    for pattern in (
        rf"{cat}[\s,.:;]*(?:(?:no|nr|n|#)\.?\s*|/\s*)(\d+)(?![\d])",
        rf"^[^:]*\b(?:no|nr)\.?\s*(\d+)(?![\d])[^:]*{cat}",
    ):
        m = re.search(pattern, name)
        if m:
            return int(m.group(1))
    return None


def conflicts(
    row: dict[str, str], parts: list[dict[str, str]], tracks: list[dict[str, Any]], work: list[int]
) -> tuple[int, int, list[str]]:
    """(어긋남 수, 맞음 수, 어긋난 예)."""
    bad = good = 0
    examples: list[str] = []
    cat = match.catalogue_regex(row["catalogue"]) if row["catalogue"] else None
    keys = {part_number(cat, p): key_of(p["name_en"]) or key_of(p["name_ko"]) for p in parts}
    if cat and len(parts) > 1:
        for i in work:
            name = norm(str(tracks[i].get("trackName", "")))
            number = sub_number(cat, name)
            mine = keys.get(number) if number else None
            theirs = key_of(name)
            if mine and theirs:
                if mine == theirs:
                    good += 1
                else:
                    bad += 1
                    examples.append(f"No. {number} {mine}≠{theirs}: {tracks[i].get('trackName')}")
    own = {m.group(1) for m in match.CATALOGUE_TOKEN.finditer(norm(row["catalogue"]))}
    for m in OTHER_TOKEN.finditer(norm(row["title_en"])):
        system = {"kv": "k"}.get(m.group(1), m.group(1))
        if system in own or {system, "kv"} & own:
            continue
        if ":" in m.group(2):
            continue
        start = int(m.group(2))
        end = int(m.group(3)) if m.group(3) else start
        pattern = re.compile(rf"\b{'kv?' if system == 'k' else system}\.?\s*(\d+)(?![\d])")
        seen = [
            int(n) for i in work for n in pattern.findall(norm(str(tracks[i].get("trackName", ""))))
        ]
        if seen:
            inside = sum(start <= n <= end for n in seen)
            if inside:
                good += inside
            else:
                bad += len(seen)
                examples.append(f"{system} {start}-{end} 아님: {sorted(set(seen))[:5]}")
    return bad, good, examples


def judge(
    row: dict[str, str],
    parts: list[dict[str, str]],
    tracks: list[dict[str, Any]],
    want: int,
    kind: str = "album",
) -> dict[str, Any]:
    if not tracks:
        return {"verdict": "gone", "workTracks": 0}
    work = work_indexes(row, tracks)
    album_name = str(tracks[0].get("collectionName", ""))
    out: dict[str, Any] = {
        "workTracks": len(work),
        "albumName": album_name,
        "tracks": [str(tracks[i].get("trackName", "")) for i in work[:3]]
        or [str(t.get("trackName", "")) for t in tracks[:3]],
    }
    if work:
        bad, good, examples = conflicts(row, parts, tracks, work)
        if bad and bad >= good:
            return {**out, "verdict": "conflict", "conflicts": examples[:4]}
        out["verdict"] = "ok" if len(work) >= want else "partial"
        if bad:
            out["conflicts"] = examples[:4]
        return out
    if album_pick.names_work(row, album_name):
        return {**out, "verdict": "named"}
    loose, bad = loose_indexes(row, tracks)
    if loose:
        return {
            **out,
            "verdict": "loose",
            "workTracks": len(loose),
            "tracks": [str(tracks[i].get("trackName", "")) for i in loose[:3]],
        }
    surname = surname_of(row["composer_en"])
    strong = [w for w in loose_words(row["title_en"]) if w not in WEAK]
    album_words = word_set(album_name)
    who = plain(" ".join(f"{t.get('artistName', '')} {t.get('trackName', '')}" for t in tracks))
    who += " " + plain(album_name)
    if strong and set(strong) <= album_words and has_composer(surname, who):
        return {**out, "verdict": "named"}
    # 뮤지컬·영화 음반은 아티스트에 작곡가가 없다
    # (「Crazy For You (Original London Cast Recording)」)
    if (
        strong
        and set(strong) <= album_words
        and re.search(r"\bcast\b|soundtrack|motion picture", norm(album_name))
    ):
        return {**out, "verdict": "named"}
    if NOT_ORIGINAL.search(norm(album_name)):
        return {**out, "verdict": "wrong", "why": "not-original"}
    # 전집 상자는 뒤쪽(받지 못한 트랙)에 작품이 있을 수 있다
    if len(tracks) in TRACK_CAPS:
        return {**out, "verdict": "box"}
    if bad:
        return {**out, "verdict": "wrong", "why": "conflict-track"}
    titled = [t for t in tracks if strong and set(strong) <= word_set(str(t.get("trackName", "")))]
    if not has_composer(surname, who) and not titled:
        return {**out, "verdict": "wrong", "why": "other-composer"}
    # 트랙 링크는 그 트랙 이름이 증거의 전부다
    if len(tracks) == 1 and kind == "track" and not titled:
        return {**out, "verdict": "wrong", "why": "track-mismatch"}
    return {**out, "verdict": "doubt"}


def main() -> None:
    links_path, parts_path, work_dir, out_path = sys.argv[1:5]
    with open(links_path, encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle, delimiter="\t"))
    parts: dict[str, list[dict[str, str]]] = defaultdict(list)
    with open(parts_path, encoding="utf-8") as handle:
        for part in csv.DictReader(handle, delimiter="\t"):
            parts[part["piece_id"]].append(part)
    results: list[dict[str, Any]] = []
    for row in rows:
        want = max(int(row["nparts"]), 1)
        mine = parts.get(row["piece_id"], [])
        apple = row["apple_music_url"].strip()
        if apple:
            m = re.search(r"/(\d+)(?:\?i=(\d+))?$", apple)
            tracks = tracks_of(f"{work_dir}/apple_raw", m.group(1)) if m else []
            if m and m.group(2):
                hit = [t for t in tracks if str(t.get("trackId")) == m.group(2)]
                verdict = judge(row, mine, hit, 1, "track")
                kind = "track"
            else:
                verdict = judge(row, mine, tracks, want)
                kind = "album"
            results.append(
                {"pieceId": int(row["piece_id"]), "service": "apple", "kind": kind, "url": apple}
                | verdict
            )
        spotify = row["spotify_url"].strip()
        if spotify:
            album = re.search(r"/album/([A-Za-z0-9]+)", spotify)
            track = re.search(r"/track/([A-Za-z0-9]+)", spotify)
            if album:
                verdict = judge(
                    row, mine, tracks_of(f"{work_dir}/spotify_raw", album.group(1)), want
                )
                kind = "album"
            else:
                path = f"{work_dir}/spotify_track_raw/{track.group(1) if track else ''}.json"
                one: list[dict[str, Any]] = []
                if track and os.path.exists(path):
                    with open(path, encoding="utf-8") as handle:
                        data = json.load(handle)
                    one = [
                        {
                            "wrapperType": "track",
                            "trackViewUrl": spotify,
                            "trackName": data["trackName"],
                            "artistName": data["artistName"],
                            "collectionName": "",
                            "collectionId": "track",
                        }
                    ]
                verdict = judge(row, mine, one, 1, "track")
                kind = "track"
            results.append(
                {
                    "pieceId": int(row["piece_id"]),
                    "service": "spotify",
                    "kind": kind,
                    "url": spotify,
                }
                | verdict
            )
    with open(out_path, "w", encoding="utf-8") as handle:
        for item in results:
            handle.write(json.dumps(item, ensure_ascii=False) + "\n")
    summary: Counter[str] = Counter(f"{r['service']}:{r['verdict']}" for r in results)
    print(json.dumps(dict(sorted(summary.items())), ensure_ascii=False))


if __name__ == "__main__":
    main()
