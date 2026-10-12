"""4차: MusicBrainz 작품 구조만으로 작곡가 catalog.json·seed_map.json 을 만든다.

사람·에이전트 판단 없이 규칙으로 돈다. 그래서 확실한 것만 넣고 확실한 것만 숨긴다.
- 작품: 그 작곡가가 composer 로 걸린 MB work 중 다른 work 의 part 가 아니고, 편곡·다른 판·발췌·
  단편·의심 표시가 없는 것. part 는 MB parts 관계 순서대로 두 겹까지.
- 제목: 갈래·번호·조성 꼴(Symphony no. 5 in C minor)은 우리말로 옮기고
  (「교향곡 5번 C단조」),
  아니면 원제를 둔다(가곡·오페라 등 MB 갈래가 있으면 「가곡 <원제>」 꼴).
- seed 작품: MBID 가 작품이면 work, part 면 part,
  편곡·다른 판이면 unmatched(arrangement·duplicate)로
  숨긴다. 그 밖(MB 에 없음, 남의 작품, 판단이 서지 않음)은 unreviewed 로 두어 숨기지 않는다.
- manual 작품은 MBID 가 같은 작품·part 에 잇고, 제목은 바꾸지 않는다.

사용: python3 auto_catalog.py --composer-id 100 --slug satie --db <db 폴더> --out <폴더>
"""

import argparse
import csv
import json
import os
import re
import sys
from collections import Counter, defaultdict
from typing import Any

sys.path.insert(
    0, os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "tools")
)
from fetch import mb  # type: ignore[import-not-found,unused-ignore]

csv.field_size_limit(10_000_000)

DERIVED_WORK_RELS = {"arrangement", "orchestration", "other version", "based on"}
KANA = re.compile(r"[\u3040-\u30ff\uff66-\uff9f]")
DERIVED_ARTIST_RELS = {
    "arranger",
    "orchestrator",
    "instrument arranger",
    "vocal arranger",
    "transcriber",
}
SKIP_DISAMBIGUATION = re.compile(
    r"arr\.|arrang|orchestrat|transcri|catch.all|reduction|vocal score|excerpt|extrait|auszug|"
    r"fragment|sketch|unfinished|incomplete|draft|spurious|doubtful|attributed|lost|"
    r"early version|first version|original version|version for|reconstruct|completed by|"
    r"cadenza|realization|realisation",
    re.IGNORECASE,
)
SKIP_TITLE = re.compile(r"\(arr\.|\barranged\b|\btranscription\b|catch.all", re.IGNORECASE)
POPULAR = re.compile(
    r"\b(re-?work|remix|rmx|re-?edit|re-?imagin\w*|bootleg|mash-?up|cover version|lo-?fi)\b",
    re.IGNORECASE,
)
CATALOGUE_SYSTEMS = (
    "BuxWV|SWV|ZWV|WWV|MWV|WAB|HWV|BWV|TWV|RV|KV|K|Hob|WoO|Wq|Sz|BB|JW|FS|CNW|TN|MS|TrV|AV|Anh|"
    "D|H|G|W|S|L|M|B|R|P|Z"
)

GENRES: list[tuple[str, str]] = [
    ("symphonic poem", "교향시"),
    ("tone poem", "교향시"),
    ("symphonie concertante", "협주 교향곡"),
    ("sinfonia concertante", "협주 교향곡"),
    ("sinfonietta", "신포니에타"),
    ("symphony", "교향곡"),
    ("symphonie", "교향곡"),
    ("sinfonie", "교향곡"),
    ("sinfonia", "신포니아"),
    ("piano concerto", "피아노 협주곡"),
    ("violin concerto", "바이올린 협주곡"),
    ("cello concerto", "첼로 협주곡"),
    ("violoncello concerto", "첼로 협주곡"),
    ("viola concerto", "비올라 협주곡"),
    ("flute concerto", "플루트 협주곡"),
    ("oboe concerto", "오보에 협주곡"),
    ("clarinet concerto", "클라리넷 협주곡"),
    ("horn concerto", "호른 협주곡"),
    ("trumpet concerto", "트럼펫 협주곡"),
    ("guitar concerto", "기타 협주곡"),
    ("harpsichord concerto", "하프시코드 협주곡"),
    ("keyboard concerto", "건반 협주곡"),
    ("organ concerto", "오르간 협주곡"),
    ("konzert", "협주곡"),
    ("harp concerto", "하프 협주곡"),
    ("double concerto", "2중 협주곡"),
    ("concerto grosso", "합주 협주곡"),
    ("concertino", "콘체르티노"),
    ("concerto", "협주곡"),
    ("string quartet", "현악 4중주"),
    ("string quintet", "현악 5중주"),
    ("string trio", "현악 3중주"),
    ("string sextet", "현악 6중주"),
    ("piano quartet", "피아노 4중주"),
    ("piano quintet", "피아노 5중주"),
    ("piano trio", "피아노 3중주"),
    ("wind quintet", "목관 5중주"),
    ("flute quartet", "플루트 4중주"),
    ("flute quintet", "플루트 5중주"),
    ("guitar quintet", "기타 5중주"),
    ("clarinet quintet", "클라리넷 5중주"),
    ("trio sonata", "트리오 소나타"),
    ("quartet", "4중주"),
    ("quintet", "5중주"),
    ("sextet", "6중주"),
    ("septet", "7중주"),
    ("octet", "8중주"),
    ("nonet", "9중주"),
    ("piano sonata", "피아노 소나타"),
    ("keyboard sonata", "건반 소나타"),
    ("harpsichord sonata", "하프시코드 소나타"),
    ("violin sonata", "바이올린 소나타"),
    ("cello sonata", "첼로 소나타"),
    ("flute sonata", "플루트 소나타"),
    ("viola sonata", "비올라 소나타"),
    ("clarinet sonata", "클라리넷 소나타"),
    ("organ sonata", "오르간 소나타"),
    ("guitar sonata", "기타 소나타"),
    ("sonatina", "소나티네"),
    ("sonatine", "소나티네"),
    ("sonata", "소나타"),
    ("sonate", "소나타"),
    ("prelude and fugue", "전주곡과 푸가"),
    ("prélude et fugue", "전주곡과 푸가"),
    ("chorale prelude", "코랄 전주곡"),
    ("prelude", "전주곡"),
    ("prélude", "전주곡"),
    ("preludio", "전주곡"),
    ("fugue", "푸가"),
    ("fuga", "푸가"),
    ("toccata", "토카타"),
    ("fantasia", "환상곡"),
    ("fantasy", "환상곡"),
    ("fantaisie", "환상곡"),
    ("fantasie", "환상곡"),
    ("étude", "연습곡"),
    ("etude", "연습곡"),
    ("study", "연습곡"),
    ("nocturne", "녹턴"),
    ("waltz", "왈츠"),
    ("valse", "왈츠"),
    ("walzer", "왈츠"),
    ("vals", "왈츠"),
    ("mazurka", "마주르카"),
    ("polonaise", "폴로네즈"),
    ("ballade", "발라드"),
    ("scherzo", "스케르초"),
    ("impromptu", "즉흥곡"),
    ("rhapsody", "랩소디"),
    ("rhapsodie", "랩소디"),
    ("romance", "로망스"),
    ("romanze", "로망스"),
    ("serenade", "세레나데"),
    ("sérénade", "세레나데"),
    ("serenata", "세레나데"),
    ("divertimento", "디베르티멘토"),
    ("suite", "모음곡"),
    ("overture", "서곡"),
    ("ouverture", "서곡"),
    ("march", "행진곡"),
    ("marche", "행진곡"),
    ("marsch", "행진곡"),
    ("theme and variations", "주제와 변주"),
    ("variations", "변주곡"),
    ("missa", "미사"),
    ("mass", "미사"),
    ("messe", "미사"),
    ("requiem", "레퀴엠"),
    ("magnificat", "마니피카트"),
    ("stabat mater", "스타바트 마테르"),
    ("te deum", "테 데움"),
    ("minuet", "미뉴에트"),
    ("menuet", "미뉴에트"),
    ("menuetto", "미뉴에트"),
    ("gavotte", "가보트"),
    ("sarabande", "사라반드"),
    ("gigue", "지그"),
    ("tango", "탱고"),
    ("milonga", "밀롱가"),
    ("habanera", "하바네라"),
    ("bolero", "볼레로"),
    ("elegy", "엘레지"),
    ("élégie", "엘레지"),
    ("berceuse", "자장가"),
    ("lullaby", "자장가"),
    ("barcarolle", "뱃노래"),
    ("capriccio", "카프리치오"),
    ("caprice", "카프리스"),
    ("intermezzo", "인테르메초"),
    ("humoresque", "유머레스크"),
    ("invention", "인벤션"),
    ("chaconne", "샤콘"),
    ("ciaccona", "샤콘"),
    ("passacaglia", "파사칼리아"),
    ("partita", "파르티타"),
    ("canzona", "칸초나"),
    ("canzonetta", "칸초네타"),
    ("pavane", "파반느"),
    ("allemande", "알망드"),
    ("courante", "쿠랑트"),
    ("bourrée", "부레"),
    ("polka", "폴카"),
    ("galop", "갤럽"),
    ("tarantella", "타란텔라"),
    ("tarantelle", "타란텔라"),
    ("bagatelle", "바가텔"),
    ("moment musical", "악흥의 순간"),
    ("novelette", "노벨레테"),
    ("pastorale", "파스토랄"),
    ("cantata", "칸타타"),
    ("kantate", "칸타타"),
    ("cantate", "칸타타"),
    ("oratorio", "오라토리오"),
    ("motet", "모테트"),
    ("anthem", "앤섬"),
    ("hymn", "찬가"),
    ("madrigal", "마드리갈"),
    ("choral song", "합창곡"),
    ("part-song", "합창곡"),
    ("partsong", "합창곡"),
    ("song", "가곡"),
    ("lied", "가곡"),
    ("piece", "소품"),
    ("stück", "소품"),
    ("morceau", "소품"),
    ("duet", "2중창"),
]
_INSTRUMENT_WORDS = {
    "piano": "피아노",
    "violin": "바이올린",
    "viola": "비올라",
    "cello": "첼로",
    "flute": "플루트",
    "oboe": "오보에",
    "clarinet": "클라리넷",
    "bassoon": "바순",
    "horn": "호른",
    "trumpet": "트럼펫",
    "guitar": "기타",
    "harp": "하프",
    "harpsichord": "하프시코드",
    "organ": "오르간",
    "keyboard": "건반",
    "mandolin": "만돌린",
    "string": "현악",
    "wind": "목관",
}
_ENSEMBLE_WORDS = {
    "sonata": "소나타",
    "sonatas": "소나타",
    "concerto": "협주곡",
    "concerti": "협주곡",
    "concertos": "협주곡",
    "trio": "3중주",
    "trios": "3중주",
    "quartet": "4중주",
    "quartets": "4중주",
    "quintet": "5중주",
    "quintets": "5중주",
    "sextet": "6중주",
    "sextets": "6중주",
    "sonatina": "소나티네",
    "suite": "모음곡",
    "fantasia": "환상곡",
    "variations": "변주곡",
    "duo": "2중주",
    "duet": "2중주",
    "duets": "2중주",
}
_known = {name for name, _ in GENRES}
for _inst, _inst_ko in _INSTRUMENT_WORDS.items():
    for _word, _word_ko in _ENSEMBLE_WORDS.items():
        if f"{_inst} {_word}" not in _known:
            GENRES.append((f"{_inst} {_word}", f"{_inst_ko} {_word_ko}"))
GENRES += [
    ("concerti", "협주곡"),
    ("quartetti", "4중주"),
    ("quintetti", "5중주"),
    ("sinfonias", "신포니아"),
]
GENRE_PATTERN = re.compile(
    r"^(?:(?:\d+|two|three|four|five|six|seven|eight|nine|ten|twelve)\s+)?("
    + "|".join(re.escape(name) for name, _ in sorted(GENRES, key=lambda g: -len(g[0])))
    + r")s?\b",
    re.IGNORECASE,
)
GENRE_KO = {name.lower(): ko for name, ko in GENRES}
MB_TYPE_KO = {
    "Song": "가곡",
    "Opera": "오페라",
    "Operetta": "오페레타",
    "Ballet": "발레",
    "Zarzuela": "사르수엘라",
    "Soundtrack": "영화음악",
    "Incidental music": "부수음악",
    "Cantata": "칸타타",
    "Oratorio": "오라토리오",
    "Madrigal": "마드리갈",
    "Motet": "모테트",
    "Song-cycle": "연가곡집",
    "Musical": "뮤지컬",
    "Aria": "아리아",
}
NUMBERS = {
    "two": 2,
    "three": 3,
    "four": 4,
    "five": 5,
    "six": 6,
    "seven": 7,
    "eight": 8,
    "nine": 9,
    "ten": 10,
    "twelve": 12,
}
KEY_PATTERN = re.compile(
    r"\b(?:in\s+)?([A-G])(?:[\s-]?(sharp|flat|♯|♭|#|b(?=[\s-]))|is|es|s)?[\s-]+"
    r"(major|minor|dur|moll)\b",
    re.IGNORECASE,
)
NUMBER_PATTERN = re.compile(r"\b(?:no\.?|nr\.?|n[°º]\.?|number)\s*(\d+[a-z]?)\b", re.IGNORECASE)
CATALOGUE_TAIL = re.compile(
    r"(?:[,(]\s*|\s+(?=(?i:op)\.?\s?\d))((?:(?i:op(?:us)?)\.?|(?:"
    + CATALOGUE_SYSTEMS
    + r")\.?)\s?\d[\w./\u2013-]*"
    r"(?:[,\s]+(?i:no|nr)\.?\s*\d+[a-z]?)?)\)?\s*$"
)
_QUOTES = "\"\u201c\u201d\u00ab\u00bb\u2018\u2019'"
QUOTED = re.compile(f"[{_QUOTES}]([^{_QUOTES}]{{2,60}})[{_QUOTES}]")
ROMAN = re.compile(r"^((?:X{0,3})(?:IX|IV|V?I{0,3}))\.\s+(.+)$")
LEAD_NUMBER = re.compile(
    r"^(?:no\.?|nr\.?|n[°º]\.?)\s*\d+[a-z]?[.:,]?\s*|^\d+[a-z]?[.)]\s+", re.IGNORECASE
)


INSTRUMENTS = {
    "piano": "피아노",
    "pianoforte": "피아노",
    "fortepiano": "포르테피아노",
    "violin": "바이올린",
    "viola": "비올라",
    "cello": "첼로",
    "violoncello": "첼로",
    "double bass": "더블베이스",
    "flute": "플루트",
    "oboe": "오보에",
    "clarinet": "클라리넷",
    "bassoon": "바순",
    "horn": "호른",
    "trumpet": "트럼펫",
    "trombone": "트롬본",
    "guitar": "기타",
    "harp": "하프",
    "harpsichord": "하프시코드",
    "organ": "오르간",
    "keyboard": "건반",
    "mandolin": "만돌린",
    "strings": "현악",
    "string orchestra": "현악 합주",
    "orchestra": "관현악",
}
BARE_GENRES = {
    "소나타",
    "소나티네",
    "협주곡",
    "콘체르티노",
    "3중주",
    "4중주",
    "5중주",
    "6중주",
    "환상곡",
    "변주곡",
    "모음곡",
    "세레나데",
    "디베르티멘토",
    "로망스",
    "녹턴",
    "카프리스",
    "소품",
}


def has_batchim(word: str) -> bool:
    last = word[-1]
    return "가" <= last <= "힣" and (ord(last) - 0xAC00) % 28 != 0


def instrumented(genre: str, rest: str) -> str:
    """「for guitar and strings」 같은 편성을 갈래 앞에 붙인다. 못 읽으면 갈래 그대로."""
    if genre not in BARE_GENRES:
        return genre
    rest = re.sub(r"^\s*(?:no\.?|nr\.?|n°)\s*\d+\w*", "", rest, flags=re.IGNORECASE)
    match = re.match(
        r"^\s*(?:for|pour|für|per)\s+(?:solo\s+)?([a-z ,]+?)"
        r"(?=\s+(?:in|no\.?|nr\.?|op\.?)\b|,|\(|$)",
        rest,
        re.IGNORECASE,
    )
    if not match:
        return genre
    names = [n.strip().lower() for n in re.split(r",|\band\b|&", match.group(1)) if n.strip()]
    names = [re.sub(r"^(?:a|an|the|solo)\s+", "", n) for n in names]
    if not names or any(n not in INSTRUMENTS for n in names):
        return genre
    ko = [INSTRUMENTS[n] for n in names]
    if len(ko) == 1:
        return f"{ko[0]} {genre}"
    if len(ko) == 2 and ko[1] in ("현악", "관현악", "현악 합주"):
        return f"{ko[0]} {genre}"
    if len(ko) == 2:
        first = ko[0] + ("과" if has_batchim(ko[0]) else "와")
        second = ko[1] + ("을" if has_batchim(ko[1]) else "를")
        return f"{first} {second} 위한 {genre}"
    return genre


def key_ko(text: str) -> str | None:
    match = KEY_PATTERN.search(text)
    if not match:
        return None
    letter, accidental, mode = (
        match.group(1).upper(),
        (match.group(2) or ""),
        match.group(3).lower(),
    )
    whole = match.group(0).lower()
    sign = ""
    if accidental.lower() in ("sharp", "♯", "#") or re.search(r"[a-g]is\b", whole):
        sign = "♯"
    elif accidental.lower() in ("flat", "♭", "b") or re.search(r"[a-g](es|s)\b", whole):
        sign = "♭"
    return f"{letter}{sign}{'장조' if mode in ('major', 'dur') else '단조'}"


def normalise_catalogue(text: str) -> str:
    text = re.sub(r"^op(?:us)?\.?\s*", "Op. ", text.strip(), flags=re.IGNORECASE)
    text = re.sub(r"[,\s]+(?:no|nr)\.?\s*(\d+[a-z]?)$", r" No. \1", text, flags=re.IGNORECASE)
    return re.sub(r"\s+", " ", text)


def split_title(title: str) -> tuple[str, str | None]:
    """제목 끝의 작품번호(여럿이면 모두)를 떼고, Op. 가 있으면 Op., 없으면 맨 앞 번호를 쓴다."""
    head = title.strip()
    found: list[str] = []
    while True:
        match = CATALOGUE_TAIL.search(head)
        if not match:
            break
        catalogue = normalise_catalogue(match.group(1))
        if not re.match(r"^[A-Za-z]+\.?\s+\S", catalogue):
            catalogue = re.sub(r"^([A-Za-z]+\.?)(\d)", r"\1 \2", catalogue)
        found.insert(0, catalogue)
        head = head[: match.start()].strip().rstrip(",:;")
    if not found:
        return head, None
    preferred = next((c for c in found if c.startswith("Op. ")), found[0])
    return head, preferred


def translate(title: str, mb_type: str | None) -> tuple[str, bool]:
    """MB 원제를 화면 제목으로. (제목, 갈래를 옮겼는가)"""
    match = GENRE_PATTERN.match(title)
    if match:
        genre = GENRE_KO[match.group(1).lower()]
        rest = title[match.end() :]
        if re.match(r"^\s*(for|pour|für|per|para|in|no|nr|n°|op|,|$|\(|:|\")", rest, re.IGNORECASE):
            count = re.match(
                r"^(\d+|two|three|four|five|six|seven|eight|nine|ten|twelve)\s",
                title,
                re.IGNORECASE,
            )
            parts = []
            if count:
                n = count.group(1).lower()
                parts.append(f"{NUMBERS.get(n, n)}개의")
            parts.append(instrumented(genre, rest))
            number = NUMBER_PATTERN.search(rest)
            if number and not count:
                parts.append(f"{number.group(1)}번")
            key = key_ko(rest)
            if key:
                parts.append(key)
            else:
                bare = re.search(
                    r"\bin\s+([A-G])(?:[\s-]?(flat|sharp))?\b(?!\s*(?:major|minor))",
                    rest,
                    re.IGNORECASE,
                )
                if bare:
                    sign = {"flat": "♭", "sharp": "♯"}.get((bare.group(2) or "").lower(), "")
                    parts.append(bare.group(1).upper() + sign)
            nick = QUOTED.search(rest)
            if nick:
                parts.append(f'"{nick.group(1).strip()}"')
            if len(parts) == 1 and parts[0] == genre and rest.strip(" ,"):
                # 「Suite pour flûte et piano」처럼 갈래 말고 아무것도 못 읽으면 원제가 낫다
                return title, False
            return " ".join(parts), True
    label = MB_TYPE_KO.get(mb_type or "")
    if label:
        return f"{label} <{title}>", False
    return title, False


def part_name(child_title: str, parent_title: str, multi: bool) -> tuple[str, str | None]:
    """part 제목에서 부모 제목·번호를 떼고 화면 이름과 악장 번호를 만든다."""
    name = child_title
    for sep in (":", ","):
        if name.startswith(parent_title + sep):
            name = name[len(parent_title) + 1 :].strip()
            break
    else:
        if ": " in name:
            name = name.split(": ", 1)[1].strip()
    movement = None
    roman = ROMAN.match(name)
    if roman and roman.group(1):
        movement = roman.group(1) if multi else None
        name = roman.group(2).strip()
    name = LEAD_NUMBER.sub("", name).strip() or name
    head, _ = split_title(name)
    genre = GENRE_PATTERN.match(head)
    rest = head[genre.end() :] if genre else head
    key = KEY_PATTERN.search(rest)
    if key and not re.sub(
        r"[\s,.:]", "", NUMBER_PATTERN.sub("", rest[: key.start()] + rest[key.end() :])
    ):
        name = key_ko(rest) or name
        nick = QUOTED.search(head)
        if nick:
            name = f'{name} "{nick.group(1).strip()}"'
    return name.strip(" .:,") or child_title, movement


COUNT_WORDS = (
    r"(?:\d+|two|three|four|five|six|seven|eight|nine|ten|twelve|deux|trois|quatre|cinq|six|sept|huit|"
    r"zwei|drei|vier|fünf|sechs|tre|quattro|sei|dos|tres|cuatro)"
)


def normal_title(title: str) -> str:
    import unicodedata

    text = unicodedata.normalize("NFKD", title).encode("ascii", "ignore").decode().lower()
    text = re.sub(r"\(.*?\)", " ", text)
    text = re.sub(r"^" + COUNT_WORDS + r"\s+", "", text)
    return re.sub(r"[^a-z0-9]+", "", text)


def catalogue_tokens(title: str) -> set[str]:
    tokens = set()
    for match in re.finditer(
        r"\b((?i:op)|" + CATALOGUE_SYSTEMS + r")\.?\s?(\d+[a-z]?(?:[./]\d+)?)"
        r"(?:,?\s*(?i:no|nr)\.?\s*(\d+))?",
        title,
    ):
        tokens.add(
            match.group(1).lower()
            + match.group(2)
            + ("/" + match.group(3) if match.group(3) else "")
        )
    return tokens


STOP_WORDS = {
    "the",
    "a",
    "an",
    "of",
    "and",
    "in",
    "for",
    "op",
    "no",
    "opus",
    "opera",
    "ballet",
    "musical",
    "operetta",
    "de",
    "la",
    "le",
    "les",
    "du",
    "der",
    "die",
    "das",
    "und",
    "et",
}


def title_tokens(title: str) -> set[str]:
    import unicodedata

    text = unicodedata.normalize("NFKD", title).encode("ascii", "ignore").decode().lower()
    return {t for t in re.split(r"[^a-z0-9]+", text) if t and t not in STOP_WORDS}


def similar(a: str, b: str, threshold: float = 0.5) -> bool:
    left, right = title_tokens(a), title_tokens(b)
    if not left or not right:
        return False
    return len(left & right) / min(len(left), len(right)) >= threshold


def related(a: str, b: str) -> bool:
    """언어가 달라도 같은 곡이면 낱말 앞 네 글자가 하나는 겹친다.

    예: Carnival/Carnaval, Violin/Violinkonzert.
    """
    left = {t[:4] for t in title_tokens(a) if not t.isdigit()}
    right = {t[:4] for t in title_tokens(b) if not t.isdigit()}
    return bool(left & right)


def fetch_works(artist: str) -> dict[str, dict[str, Any]]:
    works: dict[str, dict[str, Any]] = {}
    offset = 0
    while True:
        page = mb(
            "work",
            {
                "artist": artist,
                "limit": 100,
                "offset": offset,
                "inc": "aliases+work-rels+artist-rels",
            },
        )
        if not page:
            break
        for work in page["works"]:
            works[work["id"]] = work
        offset += 100
        if offset >= page["work-count"]:
            break
    return works


def is_composer(work: dict[str, Any], artist: str) -> bool:
    return any(
        rel.get("target-type") == "artist"
        and rel["type"] == "composer"
        and rel["artist"]["id"] == artist
        for rel in work.get("relations", [])
    )


def derived_reason(work: dict[str, Any], artist: str) -> str | None:
    disamb = work.get("disambiguation") or ""
    if POPULAR.search(work["title"]) or POPULAR.search(disamb) or KANA.search(work["title"]):
        return "popular"
    if any(
        r.get("target-type") == "work" and r["type"] == "medley" and r["direction"] == "forward"
        for r in work.get("relations", [])
    ):
        return "arrangement"
    composers = [
        r
        for r in work.get("relations", [])
        if r.get("target-type") == "artist" and r["type"] == "composer"
    ]
    if len(composers) > 1:
        return "arrangement"
    if SKIP_DISAMBIGUATION.search(disamb) or SKIP_TITLE.search(work["title"]):
        return (
            "arrangement"
            if re.search(r"arr|orch|transcri|catch|reduc|version", disamb + work["title"], re.I)
            else "excluded_scope"
        )
    for rel in work.get("relations", []):
        if (
            rel.get("target-type") == "work"
            and rel["type"] in DERIVED_WORK_RELS
            and rel["direction"] == "backward"
        ):
            return "duplicate" if rel["type"] == "other version" else "arrangement"
        if (
            rel.get("target-type") == "work"
            and rel["type"] == "revision of"
            and rel["direction"] == "backward"
        ):
            return "duplicate"
        if (
            rel.get("target-type") == "artist"
            and rel["type"] in DERIVED_ARTIST_RELS
            and rel["artist"]["id"] != artist
        ):
            return "arrangement"
    return None


def build(
    composer_id: int, slug: str, artist: str, rows: list[dict[str, str]], taken: dict[str, int]
) -> tuple[list[dict[str, Any]], list[dict[str, Any]], dict[str, Any]]:
    works = fetch_works(artist)
    children: dict[str, list[tuple[float, str, str, bool]]] = defaultdict(list)
    parent_of: dict[str, str] = {}
    for wid, work in works.items():
        for rel in work.get("relations", []):
            if rel.get("target-type") != "work" or rel["type"] != "parts":
                continue
            other = rel["work"]
            movement = "movement" in (rel.get("attributes") or [])
            key = rel.get("ordering-key")
            order = float(key) if key is not None else 9999.0
            if rel["direction"] == "forward":
                if all(c[1] != other["id"] for c in children[wid]):
                    children[wid].append((order, other["id"], other["title"], movement))
                parent_of.setdefault(other["id"], wid)
            else:
                parent_of.setdefault(wid, other["id"])
                if all(c[1] != wid for c in children[other["id"]]):
                    children[other["id"]].append((order, wid, work["title"], movement))

    mine = {wid for wid, work in works.items() if is_composer(work, artist)}
    derived = {wid: reason for wid in mine if (reason := derived_reason(works[wid], artist))}
    top = [
        wid
        for wid in mine
        if wid not in derived and not (parent_of.get(wid) in works and parent_of.get(wid) in mine)
    ]
    # 「Where Silence Has Lease: First Gymnopédie」처럼 앞부분이 이 작곡가 작품이 아닌 콜론 제목은
    # 남의 음반 곡일 수 있어 넣지 않는다(그 seed 는 숨기지 않고 둔다)
    own_titles = {normal_title(works[w]["title"]) for w in mine}
    odd = {
        wid
        for wid in top
        if ":" in works[wid]["title"]
        and not children.get(wid)
        and normal_title(works[wid]["title"].split(":")[0]) not in own_titles
    }
    top = [wid for wid in top if wid not in odd]
    seed_mbids = {m for r in rows for m in (r["mbids"] or "").split(",") if m}
    groups: dict[str, list[str]] = defaultdict(list)
    for wid in top:
        groups[normal_title(works[wid]["title"])].append(wid)
    same_as: dict[str, str] = {}
    for members in groups.values():
        if len(members) < 2:
            continue
        members.sort(
            key=lambda w: (
                -len(children.get(w, [])),
                w not in seed_mbids,
                len(works[w]["title"]),
                w,
            )
        )
        for other in members[1:]:
            same_as[other] = members[0]
    top = [wid for wid in top if wid not in same_as]

    stats: Counter[str] = Counter()
    catalog: list[dict[str, Any]] = []
    where: dict[str, tuple[str, list[int]]] = {}
    seen_titles: dict[str, str] = {}
    duplicate_of: dict[str, str] = {}
    for wid in sorted(top, key=lambda w: (works[w]["title"], w)):
        work = works[wid]
        head, catalogue = split_title(work["title"])
        title, translated = translate(head, work.get("type"))
        if translated and not re.search(r"[A-G][♯♭]?(장조|단조)", title):
            key_attr = next(
                (a["value"] for a in work.get("attributes", []) if a["type"] == "Key"), None
            )
            if key_attr and (k := key_ko(key_attr)):
                title = f"{title} {k}"
        stats["translated" if translated else "original_title"] += 1
        kids = sorted(children.get(wid, []))
        kids = [k for k in kids if k[1] not in derived]
        multi = bool(kids) and (
            all(k[3] for k in kids)
            or all(
                ROMAN.match(part_name(k[2], work["title"], True)[0] or "")
                or ROMAN.match(k[2].split(": ", 1)[-1])
                for k in kids
            )
        )
        kind = "single" if not kids else ("multi_movement" if multi else "collection")
        if kind == "collection" and catalogue:
            title = f"{title} {catalogue}"
        norm = title.lower()
        if norm in seen_titles:
            if catalogue and not title.endswith(catalogue):
                title = f"{title} {catalogue}"
            elif work.get("disambiguation"):
                title = f"{title} ({work['disambiguation']})"
            norm = title.lower()
            if norm in seen_titles:
                duplicate_of[wid] = seen_titles[norm]
                stats["dropped_duplicate_title"] += 1
                continue
        seen_titles[norm] = wid
        parts = []
        for seq, (_order, cid, ctitle, _moved) in enumerate(kids, start=1):
            name, move_no = part_name(ctitle, work["title"], multi)
            grand = [g for g in sorted(children.get(cid, [])) if g[1] not in derived]
            sub = []
            for gseq, (_gorder, gid, gtitle, _gmoved) in enumerate(grand, start=1):
                gname, _ = part_name(gtitle, ctitle, False)
                sub.append(
                    {
                        "seq": gseq,
                        "mbid": gid,
                        "mbTitle": gtitle,
                        "nameKo": gname,
                        "nameEn": gtitle,
                        "movementNumber": None,
                        "catalogueAlt": None,
                        "existingPieceId": None,
                        "existingPartId": None,
                        "children": [],
                    }
                )
                where[gid] = (wid, [seq, gseq])
            parts.append(
                {
                    "seq": seq,
                    "mbid": cid,
                    "mbTitle": ctitle,
                    "nameKo": name,
                    "nameEn": ctitle,
                    "movementNumber": move_no,
                    "catalogueAlt": None,
                    "existingPieceId": None,
                    "existingPartId": None,
                    "children": sub,
                }
            )
            where[cid] = (wid, [seq])
        where[wid] = (wid, [])
        catalog.append(
            {
                "key": f"{slug}-{wid[:8]}",
                "kind": kind,
                "catalogue": catalogue,
                "catalogueAlt": None,
                "titleKo": title[:250],
                "titleEn": work["title"][:250],
                "year": None,
                "yearText": None,
                "genre": (work.get("type") or "").lower() or None,
                "authenticity": "authentic",
                "mbid": wid,
                "mbTitle": work["title"],
                "existingPieceId": None,
                "parts": parts,
            }
        )
        stats[kind] += 1

    for other, kept_wid in same_as.items():
        if kept_wid in where:
            where.setdefault(other, where[kept_wid])
    for wid, kept_wid in duplicate_of.items():
        if kept_wid in where:
            where.setdefault(wid, where[kept_wid])
    by_key = {w["mbid"]: w for w in catalog}
    # 악장 seed(「… G. 338: II. Adagio」)는 MB 에서 따로 떨어진 work 라 MBID 로는 못 잇는다.
    # 콜론 앞의 작품번호(또는 제목)가 카탈로그 작품 하나와만 맞고
    # 뒤의 로마 숫자 악장이 있으면 그 part 로 잇는다.
    token_index: dict[str, set[str]] = defaultdict(set)
    title_index: dict[str, set[str]] = defaultdict(set)
    for w in catalog:
        for token in catalogue_tokens(w["mbTitle"]):
            token_index[token].add(w["mbid"])
        title_index[normal_title(w["mbTitle"])].add(w["mbid"])

    def movement_target(title: str) -> str | None:
        if ":" not in title:
            return None
        prefix, suffix = title.rsplit(":", 1)
        roman = ROMAN.match(suffix.strip())
        if not roman or not roman.group(1):
            return None
        candidates = set.union(
            set(), *(token_index.get(t, set()) for t in catalogue_tokens(prefix))
        ) or title_index.get(normal_title(prefix), set())
        if len(candidates) != 1:
            return None
        wid = next(iter(candidates))
        for part in by_key[wid]["parts"]:
            if part["movementNumber"] == roman.group(1) and part["mbid"]:
                return str(part["mbid"])
        return None

    seed_map: list[dict[str, Any]] = []
    rows_sorted = sorted(
        rows,
        key=lambda r: (
            r["origin"] != "manual",
            r["sectors"] == "0",
            r["has_link"] == "0",
            int(r["id"]),
        ),
    )
    used: set[tuple[str, tuple[int, ...]]] = set()
    conflict: set[str] = set()
    title_matched: set[str] = set()

    def node_title(target: str) -> str:
        wid, path = where[target]
        node: dict[str, Any] = by_key[wid]
        for step in path:
            node = (
                node["parts"][step - 1]
                if "parts" in node and node is by_key[wid]
                else node["children"][step - 1]
            )
        return str(node["mbTitle"])

    for row in rows_sorted:
        pid = int(row["id"])
        mbids = [m for m in (row["mbids"] or "").split(",") if m and m != "NULL"]
        target = next((m for m in mbids if m in where), None)
        if target and where[target][0] in conflict:
            target = None
        guessed = False
        if row["origin"] == "manual":
            label = row["title_en"] if row["title_en"] not in ("", "NULL") else row["title"]
            if target and not related(label, node_title(target)):
                # 손으로 넣은 MBID 가 엉뚱한 work 를 가리킴
                # (예: 피아노 협주곡 F장조 → 뮤지컬 <Crazy for You>)
                if not where[target][1]:
                    conflict.add(where[target][0])
                stats["manual_mbid_mismatch"] += 1
                target = None
            if not target:
                found = [
                    w["mbid"]
                    for w in catalog
                    if w["mbid"] not in conflict
                    and title_tokens(label) == title_tokens(split_title(w["mbTitle"])[0])
                ]
                if len(found) == 1 and (found[0], ()) not in used:
                    target = found[0]
                    title_matched.add(found[0])
                    stats["manual_by_title"] += 1
        if not target and row["origin"] == "seed" and not any(m in derived for m in mbids):
            target = movement_target(row["title"])
            guessed = bool(target)
        entry: dict[str, Any] = {
            "pieceId": pid,
            "title": row["title"],
            "mbids": mbids,
            "mapping": "unmatched",
            "key": None,
            "path": None,
            "reason": None,
            "note": None,
        }
        node_id = (where[target][0], tuple(where[target][1])) if target else None
        if target and node_id not in used:
            wid, path = where[target]
            work = by_key[wid]
            node: dict[str, Any] = work
            for step in path:
                node = node["parts"][step - 1] if node is work else node["children"][step - 1]
            used.add(node_id)  # type: ignore[arg-type]
            if not path:
                work["existingPieceId"] = pid
                entry.update(mapping="work", key=work["key"])
            else:
                node["existingPieceId"] = pid
                entry.update(mapping="part", key=work["key"], path=path)
            if guessed:
                entry["note"] = "제목의 작품번호·악장 번호로 맞춤(MB 관계 없음)"
                stats["seed_part_by_title"] += 1
            if row["origin"] == "manual":
                stats["manual_linked"] += 1
                continue
        elif row["origin"] == "manual":
            continue
        elif target:
            entry.update(reason="duplicate", note="같은 MB work 를 먼저 쓴 작품이 있음")
        else:
            reason = next((derived[m] for m in mbids if m in derived), None)
            dup = next((m for m in mbids if m in duplicate_of), None)
            if reason:
                entry.update(reason=reason, note="MB 에서 편곡·다른 판·발췌로 표시된 work")
            elif dup:
                entry.update(reason="duplicate", note="같은 제목의 MB work 가 이미 들어감")
            else:
                entry.update(
                    reason="unreviewed", note="MB 작곡가 작품 구조에서 찾지 못함, 숨기지 않음"
                )
        if row["origin"] == "seed":
            seed_map.append(entry)
            stats[
                "seed_" + (entry["mapping"] if entry["mapping"] != "unmatched" else entry["reason"])
            ] += 1
    for work in catalog:
        if work["mbid"] in title_matched:
            # 제목으로만 맞춘 manual 작품에는 MB 식별자를 더하지 않는다
            work["mbid"] = None
    if conflict:
        catalog = [w for w in catalog if w["mbid"] not in conflict]
        stats["dropped_conflict"] += len(conflict)
    catalog = resolve_titles(catalog, rows, seed_map, works, stats)
    for work in catalog:
        if work["mbid"] in taken and taken[work["mbid"]] != work["existingPieceId"]:
            work["mbid"] = None
            stats["mbid_taken_elsewhere"] += 1
    return catalog, seed_map, dict(stats)


def resolve_titles(
    catalog: list[dict[str, Any]],
    rows: list[dict[str, str]],
    seed_map: list[dict[str, Any]],
    works: dict[str, dict[str, Any]],
    stats: Counter[str],
) -> list[dict[str, Any]]:
    """운영 제목·다른 카탈로그 제목과 겹치지 않게 한다. 기존 작품 자기 제목과 같은 것은 괜찮다."""
    entries = {e["pieceId"]: e for e in seed_map}
    # 숨길 seed(편곡·중복·대중음악)는 생성기가 제목 뒤에 까닭을 붙여 자리를 비우므로 겹쳐도 된다
    renamable = {
        pid
        for pid, e in entries.items()
        if e["mapping"] == "unmatched" and e["reason"] not in ("unreviewed",)
    }
    rowmap = {int(r["id"]): r for r in rows}
    renamable = {
        pid
        for pid in renamable
        if rowmap[pid]["sectors"] == "0" and rowmap[pid]["editor_locked"] == "0"
    }
    current = {int(r["id"]): r["title"] for r in rows if int(r["id"]) not in renamable}
    taken_titles: set[str] = set()
    kept: list[dict[str, Any]] = []
    for work in sorted(catalog, key=lambda w: w["existingPieceId"] is None):
        own = work["existingPieceId"]
        reserved = {t for pid, t in current.items() if pid != own} | taken_titles
        disamb = works[work["mbid"]].get("disambiguation") if work["mbid"] in works else None
        options = [work["titleKo"]]
        if work["catalogue"] and not work["titleKo"].endswith(work["catalogue"]):
            options.append(f"{work['titleKo']} {work['catalogue']}")
        if disamb:
            options.append(f"{work['titleKo']} ({disamb})")
        options.append(work["mbTitle"])
        if disamb:
            options.append(f"{work['mbTitle']} ({disamb})")
        free = next((o[:250] for o in options if o[:250] not in reserved), None)
        if free is None:
            stats["dropped_title_clash"] += 1
            if own and own in entries:
                entries[own].update(
                    mapping="unmatched",
                    key=None,
                    path=None,
                    reason="unreviewed",
                    note="카탈로그 제목이 다른 운영 작품과 겹쳐 잇지 않음",
                )
            for part in work["parts"]:
                for node in [part, *part["children"]]:
                    pid = node.get("existingPieceId")
                    if pid and pid in entries:
                        entries[pid].update(
                            mapping="unmatched",
                            key=None,
                            path=None,
                            reason="unreviewed",
                            note="묶음 제목이 다른 운영 작품과 겹쳐 잇지 않음",
                        )
            continue
        if free != work["titleKo"]:
            stats["title_disambiguated"] += 1
        work["titleKo"] = free
        taken_titles.add(free)
        kept.append(work)
    return kept


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--composer-id", type=int, required=True)
    parser.add_argument("--slug", required=True)
    parser.add_argument("--db", required=True)
    parser.add_argument("--out", required=True)
    args = parser.parse_args()
    with open(os.path.join(args.db, "composers.tsv"), encoding="utf-8") as handle:
        composers = {
            int(r["id"]): r for r in csv.DictReader(handle, delimiter="\t", quoting=csv.QUOTE_NONE)
        }
    artist = composers[args.composer_id]["mb_artist"]
    with open(os.path.join(args.db, "pieces.tsv"), encoding="utf-8") as handle:
        rows = [
            r
            for r in csv.DictReader(handle, delimiter="\t", quoting=csv.QUOTE_NONE)
            if int(r["composer_id"]) == args.composer_id
        ]
    with open(os.path.join(args.db, "all_mbids_taken.tsv"), encoding="utf-8") as handle:
        taken = {
            r["external_id"]: int(r["piece_id"]) for r in csv.DictReader(handle, delimiter="\t")
        }
    catalog, seed_map, stats = build(args.composer_id, args.slug, artist, rows, taken)
    os.makedirs(args.out, exist_ok=True)
    with open(os.path.join(args.out, "catalog.json"), "w", encoding="utf-8") as handle:
        json.dump(catalog, handle, ensure_ascii=False, indent=1)
    with open(os.path.join(args.out, "seed_map.json"), "w", encoding="utf-8") as handle:
        json.dump(seed_map, handle, ensure_ascii=False, indent=1)
    with open(os.path.join(args.out, "stats.json"), "w", encoding="utf-8") as handle:
        json.dump(stats, handle, ensure_ascii=False, indent=1)
    print(args.slug, json.dumps(stats, ensure_ascii=False))


if __name__ == "__main__":
    main()
