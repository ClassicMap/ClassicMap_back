# ruff: noqa: E501 — 규칙 표(정규식·대응표)는 한 줄로 두어야 읽기 쉽다.
"""작곡가 화면에서 '기타'(갈래 없음)로 보이는 작품의 빈 갈래·형식만 채운다.

이미 값이 있는 genre·form_key 는 건드리지 않는다. 틀린 갈래는 '기타'보다 나쁘므로 출처끼리 갈래가
어긋나거나, MusicBrainz 가 가사 유무로 반대하면 비워 두고 건수만 센다.

출처(앞에 있는 것이 형식을 정한다)
  catalog   1~3차 손 카탈로그(catalog.json)의 갈래 표시 — 편성을 말하는 표시만 옮긴다
  words     제목 낱말(무대 막 발췌·영화·종교·노래)
  mb        MusicBrainz work(유형, disambiguation 의 편성, 부모 작품, 가사 언어·작사가)
  composer  한 가지 매체만 쓴 작곡가(손 목록 COMPOSER_DEFAULTS)

범위 밖(사용자 결정 전, 건수만 셈): 글래스·나이먼·멀리·킬라르(낱개 영화 큐), 피아졸라, 전자·테이프 작품,
멜로드라마. 번역 대본 대목 118줄은 opera_excerpts.py 가 따로 다룬다.

사용(seed_pipeline 에서):
    uv run python curation/piece-genre-fill-2026-11-17/fill.py --db <덤프 폴더> \\
        --mb curation/piece-genre-fill-2026-11-17/mb_works.jsonl.gz \\
        --excerpts curation/piece-genre-fill-2026-11-17/opera_excerpts.json \\
        --out curation/piece-genre-fill-2026-11-17/fills.jsonl --migrations ../migrations
덤프 폴더는 ../piece-genre-fixes-2026-11-11/tools/dump.sh 가 만드는 classify_input.tsv·composers.tsv·piece_forms.tsv.
"""

import argparse
import csv
import glob
import gzip
import json
import re
import sys
from collections import Counter, defaultdict
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

HERE = Path(__file__).resolve().parent
CURATION = HERE.parent
sys.path.insert(0, str(CURATION / "piece-forms-2026-11-07"))

from classify import (  # type: ignore[import-not-found,unused-ignore]  # noqa: E402
    FORM_GENRE,
    KEYBOARD,
    UNDECIDED,
    WORDLESS,
    concerto_form,
    scored_form,
    scored_instruments,
    scoring,
)

csv.field_size_limit(10_000_000)

# 범위 밖 작곡가: 낱개 영화 큐(음반 묶음 여부 미정)와 피아졸라(탱고 갈래 정책 미정)
OUT_OF_SCOPE_COMPOSERS: dict[int, str] = {
    93: "글래스 영화 큐",
    280: "나이먼 영화 큐",
    293: "멀리 영화 큐",
    290: "킬라르 영화 큐",
    99: "피아졸라 탱고",
}
ELECTRONIC = re.compile(
    r"\b(tape|electronics?|electronic sounds?|elektronisch\w*|bande magnétique|magnetic tape|musique concrète|computer|synthesi[sz]er|sintetizzatore|nastro magnetico)\b|전자 음악|전자음악|테이프",
    re.I,
)
# 울만 「기수 크리스토프 릴케의 사랑과 죽음의 노래」는 낭독과 피아노의 멜로드라마(MB 에는 작사가만 있음)
MELODRAMA = re.compile(
    r"멜로드라마|\bmelodrama\b|\bmélodrame\b|\bmelodram\b|Weise von Liebe und Tod des Cornets", re.I
)

# ---------------------------------------------------------------- catalog.json 표시
# 편성을 말하는 표시 → 형식. 형식만 말하는 표시(왈츠·소나타·모음곡·로망스 …)와 정책이 필요한 표시는 POLICY_MARKS.
MARK_FORM: dict[str, str] = {
    "piano": "piano_other",
    "piano_piece": "character",
    "piano_pieces": "character",
    "piano_cycle": "character",
    "album_leaf": "character",
    "pedal_piano": "character",
    "keyboard": "piano_other",
    "piano_sonata": "sonata",
    "piano_suite": "keyboard_suite",
    "keyboard_suite": "keyboard_suite",
    "two_pianos": "four_hands",
    "piano_four_hands": "four_hands",
    "piano_duet": "four_hands",
    "piano_duo": "four_hands",
    "piano_six_hands": "four_hands",
    "organ": "organ",
    "organ_sonata": "organ",
    "chorale_prelude": "organ",
    "song": "song",
    "songs": "song",
    "song_cycle": "song",
    "part_song": "choral",
    "part_songs": "choral",
    "choral": "choral",
    "choral_orchestral": "choral",
    "choral_ballad": "choral",
    "vocal_quartets": "vocal_other",
    "vocal_ensemble": "vocal_other",
    "vocal_duet": "vocal_other",
    "duets": "vocal_other",
    "aria": "concert_aria",
    "sacred": "sacred",
    "sacred_choral": "sacred",
    "sacred_vocal": "sacred",
    "psalm": "sacred",
    "motet": "sacred",
    "anthem": "sacred",
    "canticle": "sacred",
    "litany": "sacred",
    "hymn": "sacred",
    "vespers": "sacred",
    "mass": "mass_requiem",
    "requiem": "mass_requiem",
    "oratorio": "oratorio_passion",
    "cantata": "cantata",
    "sacred_cantata": "cantata",
    "serenata": "cantata",
    "ode": "cantata",
    "orchestral": "orchestral_other",
    "orchestral_suite": "orch_suite",
    "incidental_music": "incidental",
    "incidental": "incidental",
    "overture": "overture",
    "symphonic_poem": "symphonic_poem",
    "band": "orchestral_other",
    "chamber": "chamber_other",
    "string_quartet": "string_quartet",
    "string_trio": "string_ensemble",
    "string_quintet": "string_ensemble",
    "string_sextet": "string_ensemble",
    "string_ensemble": "string_ensemble",
    "piano_trio": "piano_chamber",
    "piano_quartet": "piano_chamber",
    "piano_quintet": "piano_chamber",
    "piano_sextet": "piano_chamber",
    "violin_piano": "chamber_other",
    "cello_piano": "chamber_other",
    "violin_guitar": "chamber_other",
    "mandolin_guitar": "chamber_other",
    "violin_duo": "chamber_other",
    "guitar_quartet": "chamber_other",
    "clarinet_trio": "chamber_other",
    "clarinet_quintet": "chamber_other",
    "horn_trio": "chamber_other",
    "violin_sonata": "duo_sonata",
    "cello_sonata": "duo_sonata",
    "viola_sonata": "duo_sonata",
    "clarinet_sonata": "duo_sonata",
    "flute_sonata": "duo_sonata",
    "trio_sonata": "chamber_other",
    "church_sonata": "chamber_other",
    "wind_ensemble": "wind_chamber",
    "wind": "wind_chamber",
    "violin_solo": "solo",
    "cello_solo": "solo",
    "guitar": "solo",
    "mandolin": "solo",
    "harp": "solo",
    "concertante": "concertante",
    "violin_orchestra": "concertante",
    "cello_orchestra": "concertante",
    "viola_orchestra": "concertante",
    "piano_orchestra": "concertante",
    "concert_piece": "concertante",
    "piano_concerto": "piano_concerto",
    "violin_concerto": "violin_concerto",
    "cello_concerto": "cello_concerto",
    "string_concerto": "other_concerto",
    "bassoon_concerto": "wind_concerto",
    "oboe_concerto": "wind_concerto",
    "flute_concerto": "wind_concerto",
    "horn_concerto": "wind_concerto",
    "concerto_grosso": "concerto_grosso",
    "opera": "opera",
    "operetta": "operetta",
    "ballet": "ballet",
    "stage": "stage_other",
    "masque": "stage_other",
    "symphony": "symphony",
    "sinfonia": "sinfonia",
    "film_music": "soundtrack",
}
# 정책이 필요하거나 형식만 있고 편성이 없는 표시: 옮기지 않고 건수만 센다
POLICY_MARKS = {"canon", "melodrama", "declamation", "variations", "dance"}

# ---------------------------------------------------------------- 제목 낱말
STAGE_ACT = re.compile(r"^[^:|]{2,80}?\s?: ?(Act|Akt|Acte|Atto|Aufzug)\s+([IVX]+|\d+)\b")
STAGE_KO_EXCERPT = re.compile(
    r"^(오페라|오페레타|뮤지컬|징슈필|사르수엘라) <[^>]+> 중\b|\b(zur|der) Oper\b|, opera: "
)
STAGE_WHOLE: list[tuple[re.Pattern[str], str]] = [
    (re.compile(r"^뮤지컬 <"), "stage_other"),
    (re.compile(r"^발레 음악 <|^\d막의 [^<]*발레 <|: Ballet Music\b"), "ballet"),
]
FILM = re.compile(
    r"\bmusic (to|for) the (\w+[- ])*(film|motion picture|movie)\b|\bmusic (to|for) the film\b|\bfilm (scores?|music)\b|\bunused score\b|\blove theme\b|\bsoundtrack\b|사운드트랙|^영화 <",
    re.I,
)
# 낱말만으로 성악으로 보는 종교 전례문(첫 구절)·장르
SACRED_STRONG = re.compile(
    r"\b(tantum ergo|o salutaris|ave verum|ave maria|ave maris stella|ave regina|regina caeli|salve regina|pange lingua|veni creator|veni sancte|laudate pueri|laudate dominum|dixit dominus|nisi dominus|beatus vir|magnificat|nunc dimittis|jubilate deo|exultate deo|exsultate|pater noster|stabat mater|miserere|te deum|kyrie|agnus dei|missa|messe|requiem|pie jesu|panis angelicus|o sacrum convivium|sub tuum|libera me|ecce sacerdos|haec dies|motets?|motetten?|mottetti|psalms?|psalmen|antiphons?|responsori\w*)\b|모테트|시편|미사|성가|탄툼 에르고|라우다테|딕시트 도미누스|니시 도미누스|아베 베룸|안티폰|미세레레|파테르 노스테르|응답송|입당 교창",
    re.I,
)
# 성악일 수도 기악일 수도 있는 종교 낱말: MusicBrainz 가 가사(언어·작사가)를 확인할 때만
SACRED_WEAK = re.compile(
    r"\b(hymn|hymne|hymnus|hymns|hymnes|carol|carols|cantique|canticle|canticles|litany|litanies|litanei|lux aeterna|credo|gloria|sanctus|benedictus|alleluia|jesu|jesus|maria|ave|domine|dominus|deus|christe|noël|vespers|vespro)\b|찬가|캐럴|크레도|글로리아|칸티클",
    re.I,
)
# 종교 낱말이 붙어도 오르간·기악 곡인 낱말
SACRED_INSTRUMENTAL = re.compile(
    r"\b(offertoire|offertorium|élévation|elevation|communion|sortie|entrée|voluntary|versets?|versos?|verso|paraphrases?|intabulation|glosad[oa]|glosas?|fabordon\w*|tiento|toccata|prélude|prelude|fugue|fuga|choral|chorale|variations?|fantaisie|fantasia|fantasy|improvisation|sonata|sonate|march|marche|dance|danse|tango|caprice)\b|봉헌송|입당곡|코랄|변주|환상곡|소나타|전주곡|푸가",
    re.I,
)
# 낱말만으로 성악으로 보는 노래 묶음·성악 편성
SONG_STRONG = re.compile(
    r"\b(lieder|gesänge|chansons|mélodies|folksongs|volkslieder|part-?songs|madrigals|madrigali|madrigales|canzonettas|canzonette)\b|[2-8]중창|합창|가곡|민요(?! 선율)",
    re.I,
)
SONG_WEAK = re.compile(
    r"\b(song|songs|lied|chanson|mélodie|melodie|canción|canciones|canzone|canzonetta|cançó|cançons|romanza|gesang|chant|chants|aria|arias|arie|ariette|arietta|duet|duetto|voice|voices|voix|lullaby|wiegenlied|ode|odes|cantata|kantate|cantate|madrigal|chorus|choir|chœur|chœurs|choeur|chor|chöre)\b|노래|아리아|송가|칸초네타|칸타타",
    re.I,
)
CHORAL = re.compile(
    r"합창|(남성|혼성|여성) [2-8]중창|\b(choir|chorus|chœurs?|choeurs?|chor|chöre|madrigal\w*|part-?songs?|quartets? for (male |mixed )?voices)\b",
    re.I,
)
MASS = re.compile(r"미사|레퀴엠|\b(missa|messe|mass|requiem)\b", re.I)
SONG_FORM = re.compile(
    r"가곡|노래|\b(lieder|lied|songs?|chansons?|mélodies?|canciones|canción|canzon\w*|cançons?)\b",
    re.I,
)
CANTATA = re.compile(r"칸타타|송가|\b(cantata|kantate|cantate|ode|odes)\b", re.I)
ARIA = re.compile(r"아리아|\b(aria|arias|arie|ariette|arietta)\b", re.I)

# 종교 전례 제목이 대개 오르간·건반 곡인 작곡가(제목 낱말로 성악을 붙이지 않음)
KEYBOARD_LITURGY_COMPOSERS = {298, 296, 201}  # 카베손, 하킴, 바티스트

# ---------------------------------------------------------------- 한 가지 매체만 쓴 작곡가
# 근거: 작품 목록 전체가 그 매체(작곡가 사전·작품 목록). 데이터 쏠림만 보고 넣지 않는다.
COMPOSER_DEFAULTS: dict[int, tuple[str, str]] = {
    75: ("solo", "타레가: 독창 작품이 기타 독주곡뿐(피아노 습작 몇 곡 빼고)"),
    449: ("solo", "요베트: 기타 독주곡과 카탈루냐 민요의 기타 편곡"),
    298: (
        "piano_other",
        "카베손: 건반(tecla) 음악가, 남은 작품은 티엔토·글로사·디페렌시아스·찬가 버셋",
    ),
    201: ("organ", "바티스트: 생퇴스타슈 오르가니스트, 남은 작품은 미사 전례용 오르간 소품"),
    331: ("piano_other", "고도프스키: 피아니스트, 남은 작품이 피아노 곡집·편곡"),
    467: ("choral", "공베르: 르네상스 다성 성악(미사·모테트·샹송)만 남김"),
    395: ("choral", "세르통: 르네상스 다성 성악(미사·모테트·샹송)만 남김"),
    389: ("sacred", "체스노코프: 러시아 정교회 무반주 합창 작곡가"),
}

# ---------------------------------------------------------------- MusicBrainz
MB_TYPE_FORM: dict[str, str] = {
    "Symphony": "symphony",
    "Opera": "opera",
    "Operetta": "operetta",
    "Zarzuela": "operetta",
    "Ballet": "ballet",
    "Musical": "stage_other",
    "Song": "song",
    "Song-cycle": "song",
    "Chanson": "song",
    "Aria": "concert_aria",
    "Cantata": "cantata",
    "Mass": "mass_requiem",
    "Requiem": "mass_requiem",
    "Motet": "sacred",
    "Oratorio": "oratorio_passion",
    "Passion": "oratorio_passion",
    "Madrigal": "choral",
    "Partsong": "choral",
    "Symphonic poem": "symphonic_poem",
    "Incidental music": "incidental",
    "Soundtrack": "soundtrack",
    "Concerto": "concerto",
}
VOCAL_LINKS = {"lyricist", "librettist", "writer", "translator"}
KEYBOARD_SOLO = re.compile(
    r"^\s*(for|pour|für|para|per)\s+(solo\s+)?(piano|pianoforte|klavier|harpsichord|clavecin|cembalo|keyboard|organ|orgue|orgel|harmonium|piano solo|piano four hands|piano 4 hands|two pianos|2 pianos)(\s+solo)?\s*$",
    re.I,
)

VOICE_AND_ACCOMPANIMENT = re.compile(
    r"\b(voice|soprano|mezzo-soprano|tenor|baritone|bass|singstimme|voix|chant)\s+(and|&|und|et)\s+(piano|guitar|lute|klavier|orchestra)\b",
    re.I,
)
INSTRUMENTAL_GENRES = {"piano", "chamber", "orchestral", "concerto", "symphony"}
SUNG_TYPES = {
    "Song",
    "Song-cycle",
    "Aria",
    "Cantata",
    "Mass",
    "Motet",
    "Oratorio",
    "Madrigal",
    "Partsong",
}
VOICE_WORDS = re.compile(
    r"\b(voices?|soprano|mezzo|alto|contralto|tenor|baritone|bass voice|choir|chorus|chœur|coro|chor)\b",
    re.I,
)


@dataclass
class Piece:
    piece_id: int
    composer_id: int
    composer: str
    tier: str
    title: str
    title_en: str
    genre: str | None
    form_key: str | None
    linked_from: int
    composer_hidden: bool
    mbids: list[str]

    @property
    def text(self) -> str:
        return f"{self.title} | {self.title_en}"


@dataclass
class Signal:
    source: str
    rule: str
    genre: str
    form: str
    evidence: str


@dataclass
class MbFacts:
    types: set[str] = field(default_factory=set)
    languages: set[str] = field(default_factory=set)
    vocal_links: set[str] = field(default_factory=set)
    disambiguations: list[str] = field(default_factory=list)
    parents: list[str] = field(default_factory=list)

    @property
    def lyrics(self) -> bool:
        """가사가 있다(언어가 적혀 있고 zxx 가 아니거나, 작사·대본 작가 관계가 있다)."""
        return bool(self.languages - {"zxx"}) or bool(
            self.vocal_links & {"lyricist", "librettist", "writer"}
        )

    @property
    def wordless(self) -> bool:
        return self.languages == {"zxx"} and not self.vocal_links


def null(value: str | None) -> str:
    return "" if value in (None, "NULL") else str(value)


def read_tsv(path: Path) -> list[dict[str, str]]:
    with path.open(encoding="utf-8", newline="") as handle:
        return list(csv.DictReader(handle, delimiter="\t", quoting=csv.QUOTE_NONE))


def load_pieces(db: Path) -> list[Piece]:
    hidden = {int(r["id"]): null(r["hidden_reason"]) != "" for r in read_tsv(db / "composers.tsv")}
    out: list[Piece] = []
    for r in read_tsv(db / "classify_input.tsv"):
        cid = int(r["composer_id"])
        out.append(
            Piece(
                piece_id=int(r["id"]),
                composer_id=cid,
                composer=null(r["cname"]),
                tier=null(r["tier"]),
                title=null(r["title"]),
                title_en=null(r["title_en"]),
                genre=null(r["genre"]) or None,
                form_key=null(r["form_key"]) or None,
                linked_from=int(r["linked_from"]),
                composer_hidden=hidden.get(cid, False),
                mbids=[m for m in null(r["mbids"]).split(",") if m],
            )
        )
    return out


def load_marks() -> dict[str, set[tuple[str, str]]]:
    """1~3차 손 카탈로그의 (existingPieceId 또는 MBID) → {(표시, 파일)}. 4~6차 자동 카탈로그는 뺀다."""
    marks: dict[str, set[tuple[str, str]]] = defaultdict(set)
    for path in sorted(
        glob.glob(str(CURATION / "*catalog*" / "**" / "catalog.json"), recursive=True)
    ):
        if any(f"wave{n}" in path for n in (4, 5, 6)):
            continue
        data = json.loads(Path(path).read_text(encoding="utf-8"))
        items = data if isinstance(data, list) else data.get("works") or []
        rel = str(Path(path).relative_to(CURATION))
        for work in items:
            if not isinstance(work, dict) or not work.get("genre"):
                continue
            if work.get("existingPieceId"):
                marks[f"id:{int(work['existingPieceId'])}"].add((str(work["genre"]), rel))
            if work.get("mbid"):
                marks[f"mb:{work['mbid']}"].add((str(work["genre"]), rel))
    return marks


def load_mb(path: Path) -> dict[str, dict[str, Any]]:
    works: dict[str, dict[str, Any]] = {}
    with gzip.open(path, "rt", encoding="utf-8") as handle:
        for line in handle:
            row = json.loads(line)
            if row["work"]:
                works[row["mbid"]] = row["work"]
    return works


def mb_facts(piece: Piece, works: dict[str, dict[str, Any]]) -> MbFacts | None:
    facts = MbFacts()
    found = False
    for mbid in piece.mbids:
        work = works.get(mbid)
        if not work:
            continue
        found = True
        if work.get("type"):
            facts.types.add(str(work["type"]))
        facts.languages |= {str(lang) for lang in work.get("languages") or []}
        if work.get("disambiguation"):
            facts.disambiguations.append(str(work["disambiguation"]))
        for rel in work.get("relations") or []:
            if rel.get("target-type") == "artist" and rel.get("type") in VOCAL_LINKS:
                facts.vocal_links.add(str(rel["type"]))
            if (
                rel.get("target-type") == "work"
                and rel.get("type") == "parts"
                and rel.get("direction") == "backward"
            ):
                facts.parents.append(str(rel["work"]["id"]))
    return facts if found else None


def catalog_signal(
    piece: Piece, marks: dict[str, set[tuple[str, str]]], stats: Counter[str]
) -> Signal | None:
    found: set[tuple[str, str]] = set(marks.get(f"id:{piece.piece_id}", set()))
    for mbid in piece.mbids:
        found |= marks.get(f"mb:{mbid}", set())
    labels = {mark for mark, _ in found}
    if not labels:
        return None
    if len(labels) > 1:
        stats["catalog: 표시 둘 이상(뺌)"] += 1
        return None
    (label,) = labels
    files = ", ".join(sorted({f for _, f in found}))
    if label in POLICY_MARKS:
        stats[f"catalog: 정책 필요 표시 {label}(뺌)"] += 1
        return None
    form = MARK_FORM.get(label)
    if form is None:
        stats[f"catalog: 형식만 있는 표시 {label}(뺌)"] += 1
        return None
    if form == "concerto":
        form = concerto_form(piece.text)
    return Signal(
        "catalog",
        f"catalog:{label}",
        FORM_GENRE.get(form, "screen"),
        form,
        f"{files} genre={label}",
    )


def vocal_form(piece: Piece, default: str) -> str:
    x = piece.text
    if MASS.search(x):
        return "mass_requiem"
    if CHORAL.search(x):
        return "choral"
    if SACRED_STRONG.search(x):
        return "sacred"
    if CANTATA.search(x):
        return "cantata"
    if ARIA.search(x):
        return "concert_aria"
    if SONG_FORM.search(x):
        return "song"
    return default


def instrument_named(piece: Piece) -> bool:
    """제목이 악기 편성을 적었거나 기악곡임을 밝힌다(성악 낱말 규칙을 막음)."""
    x = piece.text
    return bool(
        KEYBOARD.search(x)
        or scored_instruments(piece.title, piece.title_en)
        or WORDLESS.search(x)
        or re.search(r"관현악|오케스트라|\borchest", x, re.I)
    )


def word_signals(piece: Piece, facts: MbFacts | None) -> list[Signal]:
    x = piece.text
    out: list[Signal] = []
    if (
        STAGE_ACT.search(piece.title)
        or STAGE_ACT.search(piece.title_en)
        or STAGE_KO_EXCERPT.search(x)
    ):
        out.append(Signal("words", "words:stage-excerpt", "stage", "stage_excerpt", "막·발췌 제목"))
    else:
        for pattern, form in STAGE_WHOLE:
            if pattern.search(x):
                out.append(Signal("words", "words:stage-work", "stage", form, "무대 작품 제목"))
                break
    if FILM.search(x):
        out.append(Signal("words", "words:film", "screen", "soundtrack", "영화음악 낱말"))
    vocal_ok = not instrument_named(piece)
    lyrics = facts is not None and facts.lyrics
    if (
        vocal_ok
        and not SACRED_INSTRUMENTAL.search(x)
        and piece.composer_id not in KEYBOARD_LITURGY_COMPOSERS
    ):
        if SACRED_STRONG.search(x):
            out.append(
                Signal(
                    "words",
                    "words:sacred",
                    "vocal",
                    vocal_form(piece, "sacred"),
                    "전례문·종교 성악 낱말",
                )
            )
        elif SACRED_WEAK.search(x) and lyrics:
            weak_form = (
                "sacred"
                if re.search(r"\b(carols?|canticles?|cantique)\b|캐럴|칸티클", x, re.I)
                else "vocal_other"
            )
            out.append(
                Signal(
                    "words",
                    "words:sacred+mb-lyrics",
                    "vocal",
                    vocal_form(piece, weak_form),
                    "종교 낱말 + MB 가사",
                )
            )
    if vocal_ok:
        if SONG_STRONG.search(x):
            out.append(
                Signal(
                    "words",
                    "words:song",
                    "vocal",
                    vocal_form(piece, "song"),
                    "노래 묶음·성악 편성 낱말",
                )
            )
        elif SONG_WEAK.search(x) and lyrics:
            out.append(
                Signal(
                    "words",
                    "words:song+mb-lyrics",
                    "vocal",
                    vocal_form(piece, "song"),
                    "노래 낱말 + MB 가사",
                )
            )
    return out


def mb_signals(piece: Piece, facts: MbFacts | None, by_mbid: dict[str, Piece]) -> list[Signal]:
    if facts is None:
        return []
    out: list[Signal] = []
    parent_genres: set[tuple[str, str]] = set()
    for parent in facts.parents:
        owner = by_mbid.get(parent)
        if (
            owner is not None
            and owner.genre
            and owner.form_key
            and owner.piece_id != piece.piece_id
        ):
            parent_genres.add((owner.genre, owner.form_key))
    if len({g for g, _ in parent_genres}) == 1:
        genre, form = sorted(parent_genres)[0]
        if genre == "stage":
            form = "stage_excerpt"
        out.append(Signal("mb", "mb:parent", genre, form, "MB 부모 작품의 갈래"))
    for kind in sorted(facts.types):
        mapped = MB_TYPE_FORM.get(kind)
        if mapped is None:
            continue
        if mapped == "concerto":
            mapped = concerto_form(piece.text)
        if mapped == "concert_aria" and any(g == "stage" for g, _ in parent_genres):
            mapped = "stage_excerpt"
        out.append(
            Signal(
                "mb", f"mb:type:{kind}", FORM_GENRE.get(mapped, "screen"), mapped, f"MB type {kind}"
            )
        )
    for text in facts.disambiguations:
        if KEYBOARD_SOLO.search(text):
            form = (
                "organ"
                if re.search(r"organ|orgue|orgel|harmonium", text, re.I)
                else "four_hands"
                if re.search(r"four hands|4 hands|two pianos|2 pianos", text, re.I)
                else "piano_other"
            )
            out.append(Signal("mb", "mb:disambiguation", "piano", form, f"MB '{text}'"))
            continue
        if not re.match(r"^\s*(for|pour|für|para|per)\b", text, re.I) or ELECTRONIC.search(text):
            continue
        scored = scoring(text, "")
        if scored is None:
            continue
        kind, count = scored
        if kind in ("unsure", "solo_orchestra"):
            continue
        form = scored_form(kind, count, f"{piece.text} | {text}")
        if form == "vocal_other" and VOICE_AND_ACCOMPANIMENT.search(text):
            form = "song"
        if form == "solo" and re.search(
            r"\b([2-9]|two|three|four|five|six)\b|duo|trio|quartet|quintet|ensemble|orchestra|players|percussionists",
            text,
            re.I,
        ):
            form = "chamber_other"
        out.append(Signal("mb", "mb:disambiguation", FORM_GENRE[form], form, f"MB '{text}'"))
    if (
        not out
        and facts.vocal_links & {"lyricist", "writer"}
        and "librettist" not in facts.vocal_links
        and not instrument_named(piece)
    ):
        out.append(
            Signal("mb", "mb:lyricist", "vocal", vocal_form(piece, "vocal_other"), "MB 작사가 관계")
        )
    return out


def composer_signal(piece: Piece) -> Signal | None:
    if piece.composer_id not in COMPOSER_DEFAULTS:
        return None
    form, why = COMPOSER_DEFAULTS[piece.composer_id]
    scored = scoring(piece.title, piece.title_en)
    if scored is not None or (KEYBOARD.search(piece.text) and FORM_GENRE[form] != "piano"):
        return None
    if FORM_GENRE[form] == "piano" and re.search(
        r"órgano|organo|organ|orgue|오르간", piece.text, re.I
    ):
        form = "organ"
    if FORM_GENRE[form] == "vocal":
        form = vocal_form(piece, form)
    return Signal("composer", "composer:default", FORM_GENRE[form], form, why)


def decide(
    piece: Piece, signals: list[Signal], facts: MbFacts | None, stats: Counter[str]
) -> Signal | None:
    if not signals:
        return None
    genres = {s.genre for s in signals}
    if len(genres) > 1:
        stats["출처끼리 갈래가 어긋남(비움)"] += 1
        return None
    order = {"catalog": 0, "words": 1, "mb": 2, "composer": 3}
    best = sorted(signals, key=lambda s: order[s.source])[0]
    if facts is not None:
        # 무대 작품은 서곡·발레처럼 가사 없는 것도 있어 막지 않는다. 보칼리즈처럼 목소리가 적힌 것도 막지 않는다
        sung = facts.types & SUNG_TYPES or any(VOICE_WORDS.search(d) for d in facts.disambiguations)
        if best.genre == "vocal" and facts.wordless and not sung:
            stats[f"MB 가사 없음(zxx)이 {best.source} 성악을 막음"] += 1
            return None
        if best.genre in INSTRUMENTAL_GENRES and facts.lyrics:
            stats[f"MB 가사 있음이 {best.source} 기악을 막음"] += 1
            return None
    return best


def q(value: str) -> str:
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


MIGRATIONS: dict[str, tuple[str, str]] = {
    "catalog": (
        "202611170002_fill_genre_from_catalog_marks.sql",
        "1~3차 손 카탈로그(catalog.json)의 갈래 표시",
    ),
    "words": (
        "202611170003_fill_genre_from_title_words.sql",
        "제목 낱말(무대 막 발췌·영화·종교·노래)",
    ),
    "mb": (
        "202611170004_fill_genre_from_musicbrainz.sql",
        "MusicBrainz work(유형·편성 설명·부모 작품)",
    ),
    "composer": (
        "202611170005_fill_genre_by_single_medium_composer.sql",
        "한 가지 매체만 쓴 작곡가(손 목록)",
    ),
    # 작사가 관계만 보고 성악으로 붙인 곡: 무대·낭독 작품이 섞일 수 있어 따로 빼 볼 수 있게 파일을 나눈다
    "mb-lyricist": (
        "202611170006_fill_genre_from_musicbrainz_lyricist.sql",
        "MusicBrainz 작사가 관계(대본 작가 없음)",
    ),
}


def write_migration(path: Path, what: str, rows: list[tuple[Piece, Signal]]) -> None:
    by_rule = Counter(s.rule for _, s in rows)
    by_move = Counter(f"{s.genre}/{s.form}" for _, s in rows)
    lines = [
        f"-- 작곡가 화면 '기타'(갈래 없음) 줄이기 2026-11-17: {what}로 빈 갈래·형식을 채운다.",
        "-- 근거와 생성기: seed_pipeline/curation/piece-genre-fill-2026-11-17/(README.md, fill.py, fills.jsonl).",
        "-- 갈래·형식이 둘 다 비어 있고 제목이 덤프 때와 같을 때만 바꾼다(이미 있는 값은 그대로, 두 번 넣어도 같다).",
        f"-- 작품 {len(rows)}곡. 규칙별: "
        + ", ".join(f"{k} {v}" for k, v in by_rule.most_common()),
        "-- 갈래/형식별: " + ", ".join(f"{k} {v}" for k, v in by_move.most_common()),
        "",
    ]
    for piece, signal in sorted(rows, key=lambda r: r[0].piece_id):
        lines.append(
            f"UPDATE pieces SET genre = {q(signal.genre)}, form_key = {q(signal.form)}\n"
            f"WHERE id = {piece.piece_id} AND composer_id = {piece.composer_id} AND title = {q(piece.title)}\n"
            "  AND genre IS NULL AND form_key IS NULL;"
        )
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--db", type=Path, required=True)
    parser.add_argument("--mb", type=Path, required=True)
    parser.add_argument("--excerpts", type=Path, required=True)
    parser.add_argument("--out", type=Path, required=True)
    parser.add_argument("--migrations", type=Path)
    args = parser.parse_args()

    pieces = load_pieces(args.db)
    by_mbid: dict[str, Piece] = {}
    for piece in pieces:
        for mbid in piece.mbids:
            by_mbid.setdefault(mbid, piece)
    marks = load_marks()
    works = load_mb(args.mb)
    excerpts = {int(e["pieceId"]) for e in json.loads(args.excerpts.read_text(encoding="utf-8"))}

    stats: Counter[str] = Counter()
    chosen: dict[str, list[tuple[Piece, Signal]]] = defaultdict(list)
    with args.out.open("w", encoding="utf-8") as out:
        for piece in pieces:
            # 작곡가 화면에 보이는 최상위 '기타' 작품만
            if piece.genre or piece.form_key or piece.composer_hidden or piece.linked_from:
                continue
            stats["대상(보이는 최상위 기타)"] += 1
            if piece.piece_id in excerpts:
                stats["범위 밖: 번역 대본 대목(opera_excerpts.py)"] += 1
                continue
            if piece.composer_id in OUT_OF_SCOPE_COMPOSERS:
                stats[f"범위 밖: {OUT_OF_SCOPE_COMPOSERS[piece.composer_id]}"] += 1
                continue
            facts = mb_facts(piece, works)
            own_marks = {m for m, _ in marks.get(f"id:{piece.piece_id}", set())}
            for mbid in piece.mbids:
                own_marks |= {m for m, _ in marks.get(f"mb:{mbid}", set())}
            if MELODRAMA.search(piece.text) or own_marks & {"melodrama", "declamation"}:
                stats["범위 밖: 멜로드라마"] += 1
                continue
            mark = catalog_signal(piece, marks, stats)
            disamb = " ".join(facts.disambiguations) if facts else ""
            if ELECTRONIC.search(piece.text) or ELECTRONIC.search(disamb):
                stats["범위 밖: 전자·테이프"] += 1
                continue
            if piece.piece_id in UNDECIDED:
                stats["classify.py UNDECIDED(편성 확인 못 함, 그대로)"] += 1
                continue
            if piece.piece_id in REJECT:
                stats["손 확인에서 뺌(REJECT)"] += 1
                continue
            signals = [
                s
                for s in (
                    mark,
                    *word_signals(piece, facts),
                    *mb_signals(piece, facts, by_mbid),
                    composer_signal(piece),
                )
                if s
            ]
            best = decide(piece, signals, facts, stats)
            if best is None:
                stats["못 채움"] += 1
                continue
            if (
                piece.piece_id in FORM_OVERRIDES
                and FORM_GENRE[FORM_OVERRIDES[piece.piece_id]] == best.genre
            ):
                best.form = FORM_OVERRIDES[piece.piece_id]
            stats[f"채움:{best.source}"] += 1
            stats[f"규칙:{best.rule.split(':')[0]}:{best.rule.split(':')[1]}"] += 1
            chosen["mb-lyricist" if best.rule == "mb:lyricist" else best.source].append(
                (piece, best)
            )
            out.write(
                json.dumps(
                    {
                        "pieceId": piece.piece_id,
                        "composerId": piece.composer_id,
                        "composer": piece.composer,
                        "tier": piece.tier,
                        "title": piece.title,
                        "titleEn": piece.title_en,
                        "genre": best.genre,
                        "formKey": best.form,
                        "source": best.source,
                        "rule": best.rule,
                        "evidence": best.evidence,
                        "agreeing": sorted({s.rule for s in signals if s is not best}),
                    },
                    ensure_ascii=False,
                )
                + "\n"
            )
    if args.migrations:
        for source, (name, what) in MIGRATIONS.items():
            if chosen[source]:
                write_migration(args.migrations / name, what, chosen[source])
    print(json.dumps(dict(sorted(stats.items())), ensure_ascii=False, indent=1))


# 제목 규칙이 걸리지만 손으로 확인해 기악·다른 갈래로 본 작품(작품 id → 까닭). 비워 둔다.
REJECT: dict[int, str] = {
    33690: "허먼 「Vertigo Suite」: MB 는 첼로·피아노 편곡판 work 라 실내악으로 붙지만 영화음악 모음곡(편성 설명만 보고 붙이면 틀림)",
    18673: "카베손 「Epistola」: 서간 낭독 음조인지 건반 곡인지 확인 못 함",
    1005: "슈토크하우젠 「Mixtur」: 관현악과 사인파 발진기·링 모듈레이터(전자, 범위 밖)",
    19674: "마데르나 「Venetian Journal」: 테너·앙상블·테이프(전자, 범위 밖)",
    2821: "거슈윈 「La La Lucille」: 뮤지컬(작사가만 보고 성악으로 붙이면 틀림)",
    1127: "브리튼 「This Way to the Tomb」: 연극 부수음악(가면극)",
    8305: "본 윌리엄스 「The Shepherds of the Delectable Mountains」: 단막 오페라(목가적 에피소드)",
    19871: "스틸 「Lenox Avenue」: 해설·합창·관현악 라디오 발레, 갈래 확인 못 함",
    1143: "브리튼 「As It Is, Plenty」: 연극 음악인지 노래인지 확인 못 함",
    10707: "베리오 「Thema (Omaggio a Joyce)」: 테이프 작품(전자, 범위 밖)",
    33169: "풀랑크 「코끼리 바바 이야기」: 낭독과 피아노(멜로드라마, 범위 밖)",
    2382: "거슈윈 「George White's Scandals of 1924」: 레뷔(무대)",
    1647: "브리튼 「The Golden Vanity」: 소년 합창을 위한 보드빌(무대로 올리는 곡), 갈래 확인 못 함",
    2064: "거슈윈 「Tip-Toes」: 뮤지컬",
    8278: "본 윌리엄스 「The Bridal Day」: 무용수·가수·낭독자의 가면극(무대)",
    9323: "풀랑크 「Le Gendarme incompris」: 코메디 부프(무대)",
    10454: "본 윌리엄스 「The Pilgrim's Progress - A Bunyan Sequence」: 라디오극 음악(낭독)",
    18729: "샤리노 「Infinito nero」: 한 막의 음악극(무대)",
    9110: "본 윌리엄스 「An Oxford Elegy」: 낭독자·합창·관현악(낭독이 중심, 멜로드라마 정책)",
    2552: "브리튼 「The Heart of the Matter」: 낭독자·테너·호른·피아노(낭독, 멜로드라마 정책)",
    16989: "마데르나 「Studi per Il processo」: 낭독자·소프라노·관현악(낭독, 멜로드라마 정책)",
    18101: "배빗 「Vision and Prayer」: 소프라노와 합성 테이프(전자, 범위 밖)",
    9897: "베리오 「Altra voce」: 알토 플루트·메조소프라노·라이브 일렉트로닉스(전자, 범위 밖)",
    17505: "맥스웰 데이비스 「Revelation and Fall」: 무대로 올리는 모노드라마(17956 과 같은 부류)",
    33343: "니콜라 렌스: 무대·성악 음반 트랙이라 갈래 확인 못 함(작곡가 기본값에서도 뺌)",
    24027: "망토바니 「Monde évanoui」: 성악인지 무대 발췌인지 확인 못 함",
    18973: "암브로시니 「Tutti parlano」: 성악인지 무대인지 확인 못 함",
    19035: "달바비 「Ligne de fuite」: 편성 확인 못 함",
    17956: "맥스웰 데이비스 「Miss Donnithorne's Maggot」: 음악극(모노드라마), 성악·무대 확인 못 함",
    17366: "딘 「The World's Wife」: MB 는 관현악이라 하지만 메조소프라노와 관현악(성악)",
}
# 갈래는 맞지만 표시 대응표의 형식이 어긋나는 작품(작품 id → 형식)
FORM_OVERRIDES: dict[int, str] = {
    27763: "operetta",  # 멘델스존 리더슈필 「타향에서의 귀향」(징슈필)
}


if __name__ == "__main__":
    main()
