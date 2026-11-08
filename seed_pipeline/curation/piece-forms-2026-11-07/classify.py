# ruff: noqa: E501 — 규칙 표(정규식)는 한 줄로 두어야 읽기 쉽다.
"""작품마다 갈래(장르 7종)와 형식(form_key)을 규칙으로 붙인다.

사람·에이전트 판단 없이 제목(우리말·원어)과 작품번호, MusicBrainz 작품 유형만 본다.
장르 기준은 `../piece-genres-2026-11-07/README.md`(원곡 편성 기준)와 같고, 거기서 손으로 붙인
비교 작품 257곡의 장르는 그대로 두고 형식만 그 장르 안에서 고른다. 못 정한 작품은 갈래·형식이
모두 없고 화면에서 '기타'로 보인다.

사용(seed_pipeline 에서):
    uv run python <이 파일> --input classify_input.tsv \\
        --genres ../piece-genres-2026-11-07/genres.jsonl --out classes.jsonl
"""

import argparse
import csv
import json
import re
from collections import Counter
from dataclasses import dataclass

csv.field_size_limit(10_000_000)

# 형식 → 갈래. 마이그레이션 202611072101 의 piece_forms 와 같아야 한다.
FORM_GENRE: dict[str, str] = {
    "symphony": "symphony",
    "sinfonia": "symphony",
    "symphony_other": "symphony",
    "piano_concerto": "concerto",
    "violin_concerto": "concerto",
    "cello_concerto": "concerto",
    "wind_concerto": "concerto",
    "other_concerto": "concerto",
    "concerto_grosso": "concerto",
    "concertante": "concerto",
    "concerto_other": "concerto",
    "sonata": "piano",
    "etude": "piano",
    "prelude_fugue": "piano",
    "ballade": "piano",
    "scherzo": "piano",
    "nocturne": "piano",
    "impromptu": "piano",
    "fantasia": "piano",
    "character": "piano",
    "mazurka": "piano",
    "polonaise": "piano",
    "waltz": "piano",
    "dance": "piano",
    "variations": "piano",
    "rondo": "piano",
    "keyboard_suite": "piano",
    "four_hands": "piano",
    "organ": "piano",
    "piano_other": "piano",
    "string_quartet": "chamber",
    "string_ensemble": "chamber",
    "piano_chamber": "chamber",
    "duo_sonata": "chamber",
    "wind_chamber": "chamber",
    "solo": "chamber",
    "chamber_other": "chamber",
    "overture": "orchestral",
    "symphonic_poem": "orchestral",
    "orch_suite": "orchestral",
    "serenade": "orchestral",
    "dance_march": "orchestral",
    "incidental": "orchestral",
    "orchestral_other": "orchestral",
    "opera": "stage",
    "operetta": "stage",
    "ballet": "stage",
    "stage_excerpt": "stage",
    "stage_other": "stage",
    "song": "vocal",
    "concert_aria": "vocal",
    "mass_requiem": "vocal",
    "oratorio_passion": "vocal",
    "cantata": "vocal",
    "sacred": "vocal",
    "choral": "vocal",
    "folk": "vocal",
    "vocal_other": "vocal",
}
OTHER_FORM = {genre: f"{genre}_other" for genre in set(FORM_GENRE.values())}
OTHER_FORM["concerto"] = "concerto_other"

# 무곡을 관현악으로 쓴 작곡가: 요한 슈트라우스 1·2세, 모차르트·하이든의 무곡 묶음
ORCHESTRAL_DANCE_COMPOSERS = {42, 54, 14, 16}
STRAUSS = {42, 54}
BACH = 4
# 작품 대부분이 피아노곡인 작곡가: 못 나눈 곡과 무곡은 피아노로 본다(쇼팽)
PIANO_COMPOSERS = {28}

# 제목만으로 못 가리는 작품(편성이 제목에 없음). 작품 id → 형식
OVERRIDES: dict[int, str] = {
    26061: "concertante",  # 쇼팽 「라 치 다렘 라 마노」 변주곡 Op. 2 (피아노와 관현악)
    26071: "concertante",  # 쇼팽 폴란드 민요에 의한 환상곡 Op. 13
    26072: "concertante",  # 쇼팽 크라코비아크풍 론도 Op. 14
    26036: "concertante",  # 쇼팽 안단테 스피아나토와 화려한 대폴로네즈 Op. 22
    26062: "chamber_other",  # 쇼팽 서주와 화려한 폴로네즈 Op. 3 (첼로와 피아노)
    26141: "chamber_other",  # 쇼팽 「악마 로베르」 주제에 의한 협주풍 대이중주 (첼로와 피아노)
}

STAGE_PREFIX = re.compile(
    r"^(오페라|오페레타|징슈필|뮤지컬|사르수엘라|발레|부수음악|극음악)\s*<([^>]+)>"
)
BRACKET_NAME = re.compile(r"<([^>]+)>")


@dataclass(frozen=True)
class Row:
    piece_id: int
    composer_id: int
    title: str
    title_en: str
    work_type: str
    catalogue: str
    parts: int


def norm(value: str) -> str:
    return "" if value == "NULL" else value


def bwv_form(number: int, title: str) -> str | None:
    """바흐 BWV 번호대(장르순 목록)로 형식을 정한다."""
    if 1 <= number <= 224:
        return "cantata"
    if 225 <= number <= 231:
        return "sacred"
    if 232 <= number <= 243:
        return "mass_requiem" if number <= 236 or number == 242 else "sacred"
    if 244 <= number <= 249:
        return "oratorio_passion"
    if 250 <= number <= 524:
        return "song" if number >= 439 else "sacred"
    if 525 <= number <= 771:
        return "organ"
    if 772 <= number <= 994:
        if 846 <= number <= 893 or "푸가" in title or "전주곡" in title or "토카타" in title:
            return "prelude_fugue"
        if re.search(r"모음곡|파르티타|서곡", title) or 806 <= number <= 831:
            return "keyboard_suite"
        if number == 988 or "변주" in title:
            return "variations"
        return "piano_other"
    if 995 <= number <= 1013:
        return "solo"
    if 1014 <= number <= 1040:
        return "duo_sonata" if "소나타" in title or "sonata" in title.lower() else "chamber_other"
    if 1046 <= number <= 1051:
        return "concerto_grosso"
    if 1041 <= number <= 1065:
        if "바이올린" in title:
            return "violin_concerto"
        if re.search(r"하프시코드|쳄발로|클라비어|건반", title):
            return "piano_concerto"
        return "other_concerto"
    if 1066 <= number <= 1071:
        return "orch_suite"
    if number == 1079:
        return "chamber_other"
    if number == 1080:
        return "prelude_fugue"
    return None


def concerto_form(text: str) -> str:
    if re.search(r"합주 협주곡|concerto grosso", text, re.I):
        return "concerto_grosso"
    if re.search(
        r"(피아노|건반|하프시코드|쳄발로|클라비어) 협주곡|piano concerto|klavierkonzert|keyboard concerto|harpsichord concerto",
        text,
        re.I,
    ):
        return "piano_concerto"
    if re.search(r"바이올린 협주곡|violin concerto|violinkonzert", text, re.I):
        return "violin_concerto"
    if re.search(r"첼로 협주곡|cello concerto|violoncello concerto|cellokonzert", text, re.I):
        return "cello_concerto"
    if re.search(
        r"(플루트|오보에|클라리넷|바순|호른|트럼펫|트롬본|색소폰|리코더|관악) 협주곡|(flute|oboe|clarinet|bassoon|horn|trumpet|trombone|saxophone|recorder) concerto",
        text,
        re.I,
    ):
        return "wind_concerto"
    return "other_concerto"


def classify_text(row: Row, stage_names: set[str]) -> tuple[str | None, str]:
    """(형식, 규칙 이름). 형식이 없으면 None."""
    t = row.title.strip()
    x = f"{t} | {row.title_en}"
    low = x.lower()

    if row.piece_id in OVERRIDES:
        return OVERRIDES[row.piece_id], "override"
    match = re.match(r"^BWV\s*(\d+)", row.catalogue)
    if row.composer_id == BACH and match and (form := bwv_form(int(match.group(1)), t)):
        return form, "bwv"

    # 무대 작품과 그 발췌(서곡·아리아·합창·무곡·모음곡)
    if re.match(r"^(부수음악|극음악)", t) or re.search(r"<[^>]+>\s*(부수음악|극음악)", t):
        return "incidental", "incidental"
    if not re.search(r"주제에 의한|변주|회상|패러프레이즈|환상곡|편곡", t):
        if re.match(
            r"^(오페라|오페레타|징슈필|뮤지컬|사르수엘라|발레)\s*<[^>]+>\s*(중|서곡|전주곡|모음곡|에서)",
            t,
        ):
            return "stage_excerpt", "stage-excerpt"
        excerpt = re.match(r"^(서곡\s*)?<([^>]+)>\s*(중|의|서곡|전주곡|모음곡|에서|$)", t)
        if excerpt and excerpt.group(2) in stage_names:
            return "stage_excerpt", "stage-excerpt-known"
    if re.match(r"^(오페라|오페라 부파|오페라 세리아)\b|^오페라 ?<", t):
        return "opera", "opera"
    if re.match(r"^(오페레타|징슈필|뮤지컬|사르수엘라)", t):
        return "operetta", "operetta"
    if re.match(r"^발레", t):
        return ("stage_excerpt" if "모음곡" in t else "ballet"), "ballet"
    if re.match(r"^영화음악|^영화 음악", t):
        return None, "film"

    # 관현악·교향곡
    if re.match(r"^교향시", t) or "목신의 오후" in t:
        return "symphonic_poem", "symphonic-poem"
    if re.search(r"협주 교향곡|신포니아 콘체르탄테|sinfonia concertante", x, re.I):
        return "other_concerto", "sinfonia-concertante"
    if (
        re.match(r"^교향곡", t)
        or (re.search(r"\bsymphon(y|ie)\b|\bsinfonie\b", low)
        and "concert" not in low)
    ):
        return "symphony", "symphony"
    if re.match(r"^(신포니에타|신포니아)", t) and row.composer_id != BACH:
        return "sinfonia", "sinfonia"

    # 협주곡과 독주·관현악
    if re.search(
        r"파가니니 주제에 의한 광시곡|랩소디 인 블루|(와|과) 관현악을 위한|for (piano|violin|cello) and orchestra",
        x,
        re.I,
    ):
        return "concertante", "concertante"
    if "이탈리아 협주곡" in t:
        return "piano_other", "italian-concerto"
    if re.search(r"협주곡|콘체르티노|\bconcerto\b|\bkonzert\b|concertino", x, re.I):
        return concerto_form(x), "concerto"

    # 성악
    if re.match(r"^(미사|장엄 미사|레퀴엠|진혼곡)", t) or re.search(
        r"\b(missa|messe|mass|requiem)\b", low
    ):
        return "mass_requiem", "mass"
    if re.search(r"^오라토리오|수난곡|\boratori|\bpassion\b|matthäus|johannes-passion", x, re.I):
        return "oratorio_passion", "oratorio"
    if re.search(r"^칸타타|칸타타|\bcantata\b|\bkantate\b", x, re.I):
        return "cantata", "cantata"
    if re.search(r"코랄 전주곡|오르간|\borgan\b|\borgel\b", x, re.I):
        return "organ", "organ"
    if re.match(
        r"^(모테트|마니피카트|스타바트 마테르|테 데움|시편|찬가|성가|아베 마리아|글로리아|미제레레|살베 레지나|레지나 첼리|봉헌송|키리에|리타니아|베스페레|저녁 기도|철야 기도|전례)",
        t,
    ) or re.search(
        r"코랄|전례|철야 기도|\b(motet|magnificat|stabat mater|te deum|psalm|ave maria|hymn|anthem|vespers|liturgy|offertorium|litaniae|regina coeli)\b",
        x,
        re.I,
    ):
        return "sacred", "sacred"
    if re.search(
        r"^(가곡|연가곡|리트|샹송)|연가곡|가곡|개의 로망스|^로망스 <|이중창|2중창|3중창|아리에타|\b(lied|lieder|song|songs|chanson|mélodie|melodie|romances)\b",
        x,
        re.I,
    ):
        return "song", "song"
    if re.match(r"^(연주회용 아리아|아리아)", t) or re.search(
        r"레치타티보와 아리아|장면과 아리아|(소프라노|테너|베이스|알토) 아리아|\bconcert aria\b",
        x,
        re.I,
    ):
        return "concert_aria", "aria"
    if re.search(
        r"저녁기도|\b(sancte|sancta|domine|agnus dei|exsultate|alleluia|salve)\b", x, re.I
    ):
        return "sacred", "sacred-latin"
    if re.match(r"^(합창곡|무반주 합창|마드리갈|파트송|카논 <)", t) or re.search(
        r"(남성|여성|혼성) 합창|^합창|\b(madrigal|partsong|chorus)\b", x, re.I
    ):
        return "choral", "choral"
    if re.search(r"민요 편곡|folk ?song arrangement", x, re.I):
        return "folk", "folk"

    # 실내악
    if re.search(
        r"무반주|\bunaccompanied\b|solo (violin|cello)|for solo (violin|cello|flute)", x, re.I
    ) or re.match(r"^(첼로|바이올린|기타|류트|플루트) (모음곡|파르티타)", t):
        return "solo", "solo"
    if re.search(r"현악 4중주|string quartet|streichquartett|quatuor à cordes", x, re.I):
        return "string_quartet", "string-quartet"
    if re.search(
        r"현악 [3-8]중주|string (trio|quintet|sextet|octet)|streich(trio|quintett|sextett)", x, re.I
    ):
        return "string_ensemble", "string-ensemble"
    if re.search(
        r"피아노 [3-5]중주|piano (trio|quartet|quintet)|klavier(trio|quartett|quintett)", x, re.I
    ):
        return "piano_chamber", "piano-chamber"
    if re.match(
        r"^(바이올린|첼로|비올라|플루트|클라리넷|오보에|호른|바순|트럼펫|기타|하프|콘트라베이스|리코더|비올라 다 감바) 소나타",
        t,
    ) or re.search(
        r"(violin|cello|viola|flute|clarinet|oboe|horn|bassoon) sonata|sonata for (violin|cello|viola|flute|clarinet|oboe)",
        low,
    ):
        return "duo_sonata", "duo-sonata"
    if re.search(
        r"(바이올린|첼로|비올라|플루트|클라리넷|만돌린|호른|오보에|바순|기타)(와|과) 피아노를 위한",
        t,
    ):
        return "chamber_other", "duo-with-piano"
    if re.search(
        r"(목관|관악|플루트|오보에|클라리넷|바순|호른) ?[2-9]중주|wind (quintet|octet)|bläser",
        x,
        re.I,
    ):
        return "wind_chamber", "wind-chamber"
    if re.search(
        r"[2-9]중주|이중주|트리오 소나타|\b(duo|trio|quartet|quintet|sextet|septet|octet|nonet)\b|trio sonata",
        x,
        re.I,
    ):
        return "chamber_other", "chamber"

    # 건반 독주
    if re.search(
        r"네 손|두 대의 피아노|연탄|four hands|4 hands|two pianos|zu vier händen", x, re.I
    ):
        return "four_hands", "four-hands"
    if re.match(
        r"^(피아노 소나타|건반 소나타|하프시코드 소나타|클라비어 소나타|소나티네|소나티나|소나타)",
        t,
    ) or re.search(r"piano sonata|klaviersonate|keyboard sonata|harpsichord sonata|sonatin", low):
        return "sonata", "sonata"
    if re.search(r"연습곡|에튀드|초절기교|\b(étude|etude|études|etudes|study|studies)\b", x, re.I):
        return "etude", "etude"
    if re.search(
        r"^(피아노 모음곡|클라브생 모음곡|하프시코드 모음곡|건반 모음곡|프랑스 모음곡|영국 모음곡|파르티타)|^클라브생 모음곡",
        t,
    ):
        return "keyboard_suite", "keyboard-suite"
    if (
        "전주곡집" in t
        or (re.search(
            r"전주곡|푸가|평균율|토카타|인벤션|\b(prelude|prélude|fugue|fuga|toccata)\b", x, re.I
        )
        and not re.search(r"<", t))
    ):
        return "prelude_fugue", "prelude"
    if re.search(r"^발라드|\bballade\b", x, re.I):
        return "ballade", "ballade"
    if re.match(r"^스케르초", t) or (re.search(r"\bscherzo\b", low) and "교향적" not in t):
        return "scherzo", "scherzo"
    if re.search(r"^(녹턴|야상곡)|녹턴|\bnocturne\b", x, re.I):
        return "nocturne", "nocturne"
    if re.search(r"즉흥곡|즉흥 환상곡|\bimpromptu", x, re.I):
        return "impromptu", "impromptu"
    if re.match(r"^마주르카(?!풍)", t) or re.search(r"\bmazurk", low):
        return "mazurka", "mazurka"
    if re.search(r"폴로네즈|폴로네이즈|\bpolonaise", x, re.I):
        return "polonaise", "polonaise"
    if re.match(r"^(왈츠|발스)", t) or re.search(r"\b(waltz|valse|walzer)\b", low):
        if row.composer_id in STRAUSS or BRACKET_NAME.search(t):
            return "dance_march", "strauss-waltz"
        return "waltz", "waltz"
    if re.search(r"^(서곡|연주회용 서곡)|서곡|\bouvert", x, re.I):
        return "overture", "overture"
    if re.match(r"^(폴카|갤럽|행진곡|카드리유|마주르카 <)", t) or re.search(
        r"행진곡|\b(march|marsch|polka|galop)\b", x, re.I
    ):
        return "dance_march", "march"
    if re.match(
        r"^(\d+개의 )?(미뉴에트|독일 무곡|렌틀러|에코세즈|콩트르당스|무곡|춤곡|가보트|부레|지그|사라방드|쿠랑트|알망드|타란텔라|볼레로|갤럽)",
        t,
    ) or re.search(r"\b(minuet|menuett|german dance|ländler|écossaise|contredanse)\b", low):
        if row.composer_id in ORCHESTRAL_DANCE_COMPOSERS and (
            row.parts > 1 or re.match(r"^\d+개의", t)
        ):
            return "dance_march", "dance-set"
        return "dance", "dance"
    if re.search(r"헝가리 무곡|슬라브 무곡|노르웨이 무곡|스페인 무곡", t):
        return "dance_march", "national-dance"
    if re.search(r"변주곡|주제에 의한|\bvariation", x, re.I):
        return "variations", "variations"
    if re.search(r"^론도|론도|\brondo\b", x, re.I):
        return "rondo", "rondo"
    if re.search(r"환상곡|판타지|랩소디|광시곡|\b(fantasia|fantasie|fantaisie|rhapsod)", x, re.I):
        return "fantasia", "fantasia"
    if re.search(
        r"바가텔|간주곡|무언가|서정 소품|악흥의 순간|앨범|아라베스크|노벨레테|자장가|뱃노래|소품|둠카|\b(bagatelle|intermezzo|song without words|lyric piece|moment musical|albumblatt|arabesque|berceuse|barcarolle)\b",
        x,
        re.I,
    ):
        return "character", "character"
    if (
        row.composer_id in ORCHESTRAL_DANCE_COMPOSERS | {15, 26}
        and row.parts == 0
        and re.match(
            r"^(아다지오|알레그로|안단테|안단티노|알레그레토|라르고|모데라토|프레스토|칸타빌레)( [A-G][♭#]?(장조|단조))",
            t,
        )
    ):
        return "piano_other", "tempo-title"
    if re.match(r"^교회 소나타", t):
        return "chamber_other", "church-sonata"
    if re.search(
        r"세레나데|디베르티멘토|카사시옹|노투르노|\b(serenade|divertimento|cassation)\b", x, re.I
    ):
        return "serenade", "serenade"
    if re.search(r"모음곡|\bsuite\b", x, re.I):
        if re.search(r"피아노|하프시코드|클라브생|건반", t):
            return "keyboard_suite", "keyboard-suite"
        return "orch_suite", "suite"
    if re.search(r"관현악|오케스트라|교향적|\borchestra", x, re.I):
        return "orchestral_other", "orchestral"
    if re.search(
        r"피아노|하프시코드|클라비어|건반|쳄발로|클라브생|\b(piano|klavier|harpsichord|clavier|cembalo)\b",
        x,
        re.I,
    ):
        return "piano_other", "keyboard"

    by_type = {
        "Symphony": "symphony",
        "Concerto": "other_concerto",
        "Opera": "opera",
        "Ballet": "ballet",
        "Song": "song",
        "Song-cycle": "song",
        "Aria": "concert_aria",
        "Cantata": "cantata",
        "Mass": "mass_requiem",
        "Motet": "sacred",
        "Oratorio": "oratorio_passion",
        "Requiem": "mass_requiem",
        "Quartet": "chamber_other",
        "Quintet": "chamber_other",
        "Trio": "chamber_other",
        "Sonata": "sonata",
        "Étude": "etude",
        "Overture": "overture",
        "Suite": "orch_suite",
        "Symphonic poem": "symphonic_poem",
        "Madrigal": "choral",
        "Partita": "keyboard_suite",
        "Operetta": "operetta",
        "Zarzuela": "operetta",
        "Incidental music": "incidental",
        "Prelude": "prelude_fugue",
        "Nocturne": "nocturne",
        "Waltz": "waltz",
        "Variations": "variations",
        "Serenade": "serenade",
        "Chanson": "song",
    }
    if row.work_type in by_type:
        return by_type[row.work_type], "mb-type"
    return None, "none"


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", required=True)
    parser.add_argument("--genres", required=True)
    parser.add_argument("--out", required=True)
    args = parser.parse_args()

    with open(args.input, encoding="utf-8") as handle:
        raw = list(csv.DictReader(handle, delimiter="\t", quoting=csv.QUOTE_NONE))
    rows = [
        Row(
            piece_id=int(r["id"]),
            composer_id=int(r["composer_id"]),
            title=norm(r["title"]),
            title_en=norm(r["title_en"]),
            work_type=norm(r["work_type"]),
            catalogue=" ".join(
                x for x in (norm(r["catalogue_system"]), norm(r["catalogue_number"])) if x
            )
            or norm(r["opus_number"]),
            parts=int(r["parts"]),
        )
        for r in raw
    ]
    with open(args.genres, encoding="utf-8") as handle:
        entries = [json.loads(line) for line in handle if line.strip()]
    curated = {int(e["pieceId"]): str(e["genre"]) for e in entries}

    # 작곡가별 무대 작품 이름(<…>): 「서곡 <윌리엄 텔>」 같은 발췌를 무대 작품으로 보기 위해
    stage_names: dict[int, set[str]] = {}
    for row in rows:
        match = STAGE_PREFIX.match(row.title)
        if match and match.group(1) not in ("부수음악", "극음악"):
            stage_names.setdefault(row.composer_id, set()).add(match.group(2))

    first: dict[int, tuple[str | None, str]] = {
        row.piece_id: classify_text(row, stage_names.get(row.composer_id, set())) for row in rows
    }
    for row in rows:
        form, rule = first[row.piece_id]
        if row.composer_id in PIANO_COMPOSERS and form in (None, "dance_march"):
            first[row.piece_id] = (
                "dance" if form == "dance_march" else "piano_other",
                "piano-composer",
            )
    # 「<전주곡집> 1권 중 "돛"」처럼 못 나눈 발췌는 같은 작곡가의 원 작품(제목에 그 이름이 든 작품)을 따른다
    by_composer: dict[int, list[Row]] = {}
    for row in rows:
        by_composer.setdefault(row.composer_id, []).append(row)
    for row in rows:
        if first[row.piece_id][0] is not None:
            continue
        match = re.match(r"^<([^>]+)>", row.title)
        if not match:
            continue
        name = match.group(1)
        for other in by_composer[row.composer_id]:
            form = first[other.piece_id][0]
            if (
                other.piece_id != row.piece_id
                and form
                and name in other.title
                and first[other.piece_id][1] != "parent"
            ):
                first[row.piece_id] = (form, "parent")
                break

    stats: Counter[str] = Counter()
    with open(args.out, "w", encoding="utf-8") as out:
        for row in rows:
            form, rule = first[row.piece_id]
            genre = FORM_GENRE.get(form) if form else None
            if row.piece_id in curated:
                fixed = curated[row.piece_id]
                if genre != fixed:
                    form, rule = OTHER_FORM[fixed], f"curated-genre({rule})"
                genre = fixed
            stats["classified" if genre else "none"] += 1
            stats[f"rule:{rule.split('(')[0]}"] += 1
            out.write(
                json.dumps(
                    {
                        "pieceId": row.piece_id,
                        "genre": genre,
                        "formKey": form if genre else None,
                        "rule": rule,
                    },
                    ensure_ascii=False,
                )
                + "\n"
            )
    print(json.dumps(dict(stats.most_common()), ensure_ascii=False))


if __name__ == "__main__":
    main()
