# ruff: noqa: E501, RUF001, RUF002 — 한국어 머리 설명과 원어 제목의 따옴표·대시를 그대로 둔다.
"""작곡가 화면 「처음 듣는다면」 자동 초안을 만든다(S·A tier 작곡가마다 5~10곡).

고르는 순서
- 후보는 작곡가 화면 작품 목록에 한 줄로 보이는 작품(숨김 아님, 다른 세트의 곡으로 들어가 있지 않음)이다.
  세트 안 곡으로 들어간 작품(녹턴 Op. 9 의 2번 같은)은 세트 한 항목으로 치고 대표 곡 번호를 단다.
- 신호 단계: 비교 구간 있음(4) → 대표곡(3) → 설명 있음(2) → 음원 링크 있음(1) → 없음(0).
  세트는 안 곡(이어진 작품)의 신호도 함께 본다.
- 점수 = 신호 단계 × 100 + 위키데이터 언어판 수(fame_score, 60까지). 하나씩 고르며 같은 갈래가 이미 있으면
  35점, 같은 형식이 이미 있으면 70점을 깎는다(갈래·형식이 겹치지 않게. 쇼팽처럼 피아노곡이 대부분인 작곡가는
  형식으로 섞인다). 작곡 연도가 있으면 작곡가 작품 연도 범위를 셋(초기·중기·후기)으로 나눠 아직 없는 시기에
  15점을 더한다.
- 고를 수: 비교·대표곡·설명이 있는 후보 수를 5~10 사이로 맞춘다(후보가 모자라면 있는 만큼).
- 편곡(제목에 「편곡」)과 exclude.json 의 작품은 고르지 않는다.

세트 대표 곡
- 비교할 수 있는 작품으로 이어진 곡 → 대표 곡(piece_parts.notable) → 없음. 여럿이면 MusicBrainz 녹음 수가 많은 곡.
- 악장으로 나뉜 작품은 비교할 수 있는 작품으로 이어진 악장만 단다.

이유(사실 한 줄, 비유·권유·감상 없이. 근거가 없으면 비운다)
1. reason_facts.json: 작품 설명(운영 DB description)에 적힌 사실을 사람이 짧게 옮긴 것. 근거 문장을 같이 둔다.
2. 번호 자리: 「교향곡 9번」처럼 번호 붙은 같은 형식 작품이 1번부터 빠짐없이 있고 모두 작곡 연도가 있을 때,
   번호도 연도도 맨 끝이면 「마지막 교향곡」, 맨 앞이면 「첫 교향곡」.
3. 세트 안 녹음 수: 세트 곡을 모두 MusicBrainz 녹음 수로 쟀고 대표 곡이 둘째보다 1.3배 이상 많으면
   「3곡 가운데 가장 많이 녹음된 곡」.
4. 영화·드라마: 공개한 장면 음악(screen_music_cues)에 이어진 작품이면 「영화 <쇼생크 탈출>(1994)에 쓰인 곡」.

사용: ./export.sh <작업 폴더> 뒤 python3 build_drafts.py --work <작업 폴더> --out <이 폴더>
    --recordings ../piece-forms-2026-11-07/signals/part_recordings.json(세트 안 곡 MusicBrainz 녹음 수)
그다음 build_migration.py 로 마이그레이션을 만든다.
"""

from __future__ import annotations

import argparse
import csv
import json
import re
from collections import Counter, defaultdict
from collections.abc import Iterable
from dataclasses import dataclass, field
from pathlib import Path

csv.field_size_limit(10_000_000)

MAX_PICKS = 10
MIN_PICKS = 5
GENRE_PENALTY = 35
FORM_PENALTY = 70
FAMILY_PENALTY = 250
ERA_BONUS = 15
LINK_BONUS = 25
DESCRIPTION_BONUS = 50
SHARE_FLOOR = 0.3
FAME_CAP = 60
RECORDING_LEAD = 1.3

TIER_LABEL = {4: "comparable", 3: "notable", 2: "description", 1: "link", 0: "none"}
FILM_KIND_KO = {"MOVIE": "영화", "SERIES": "드라마", "ANIME": "애니메이션"}
FILM_KIND_EN = {"MOVIE": "the film", "SERIES": "the series", "ANIME": "the animation"}
# 같은 작품을 원어·우리말 두 줄로 가진 경우(시드와 손으로 넣은 줄) 한 묶음으로 본다
FAMILY_ALIASES = {
    "carmen": "카르멘",
    "l’arlésienne": "아를의 여인",
    "les pêcheurs de perles": "진주조개잡이",
    "gayaneh": "가야네",
    "오르페와 외리디스": "오르페오와 에우리디체",
    "알세스트": "알체스테",
}
KOREAN_COUNT = {
    2: "두",
    3: "세",
    4: "네",
    5: "다섯",
    6: "여섯",
    7: "일곱",
    8: "여덟",
    9: "아홉",
    10: "열",
}


def read_tsv(path: Path) -> list[dict[str, str]]:
    with path.open(encoding="utf-8") as handle:
        return list(csv.DictReader(handle, delimiter="\t", quoting=csv.QUOTE_NONE))


def opt(value: str) -> str | None:
    return None if value in ("NULL", "") else value


def opt_int(value: str) -> int | None:
    text = opt(value)
    return int(text) if text is not None else None


@dataclass
class Composer:
    id: int
    name: str
    english_name: str
    tier: str
    death_year: int | None


@dataclass
class Piece:
    id: int
    composer_id: int
    title: str
    title_en: str | None
    genre: str | None
    form_key: str | None
    year: int | None
    notable: bool
    fame: int
    description: str
    has_link: bool
    cmp_sectors: int
    cmp_artists: int
    part_count: int
    part_kind: str | None
    in_bundle: int | None
    hidden: bool

    @property
    def comparable(self) -> bool:
        return self.cmp_sectors > 0


@dataclass
class Part:
    id: int
    piece_id: int
    top_level: bool
    sequence: int
    name_ko: str | None
    name_en: str | None
    notable: bool
    linked: int | None
    mbid: str | None


@dataclass
class Film:
    kind: str
    title_ko: str
    title_en: str | None
    title_original: str | None
    year: int | None
    arranged: bool


@dataclass
class Candidate:
    piece: Piece
    parts: list[Part]
    linked: list[Piece]
    rep: Part | None = None
    rep_basis: str | None = None
    tier: int = 0
    fame: int = 0
    signals: dict[str, object] = field(default_factory=dict)

    @property
    def genre_key(self) -> str:
        return self.piece.genre or "other"


def load(
    work: Path,
) -> tuple[dict[int, Composer], dict[int, Piece], list[Part], dict[int, list[Film]]]:
    composers = {
        int(r["id"]): Composer(
            id=int(r["id"]),
            name=r["name"],
            english_name=r["english_name"],
            tier=r["tier"],
            death_year=opt_int(r["death_year"]),
        )
        for r in read_tsv(work / "db" / "composers.tsv")
    }
    pieces: dict[int, Piece] = {}
    for r in read_tsv(work / "db" / "pieces.tsv"):
        pieces[int(r["id"])] = Piece(
            id=int(r["id"]),
            composer_id=int(r["composer_id"]),
            title=r["title"],
            title_en=opt(r["title_en"]),
            genre=opt(r["genre"]),
            form_key=opt(r["form_key"]),
            year=opt_int(r["composition_year"]),
            notable=r["notable"] == "1",
            fame=opt_int(r["fame_score"]) or 0,
            description=r["description"] if r["has_desc"] == "1" else "",
            has_link=r["has_apple"] == "1" or r["has_spotify"] == "1",
            cmp_sectors=int(r["cmp_sectors"]),
            cmp_artists=int(r["cmp_artists"]),
            part_count=int(r["part_count"]),
            part_kind=opt(r["part_kind"]),
            in_bundle=opt_int(r["in_bundle"]),
            hidden=opt(r["hidden_reason"]) is not None,
        )
    parts = []
    for r in read_tsv(work / "db" / "parts.tsv"):
        key = r["part_key"]
        parts.append(
            Part(
                id=int(r["id"]),
                piece_id=int(r["piece_id"]),
                top_level=r["parent"] == "0",
                sequence=int(r["sequence_number"]),
                name_ko=opt(r["name_ko"]),
                name_en=opt(r["name_en"]),
                notable=r["notable"] == "1",
                linked=opt_int(r["linked_piece_id"]) or None,
                mbid=key.split(":", 1)[1] if key.startswith("musicbrainz:") else None,
            )
        )
    films: dict[int, list[Film]] = defaultdict(list)
    for r in read_tsv(work / "db" / "films.tsv"):
        films[int(r["piece_id"])].append(
            Film(
                kind=r["kind"],
                title_ko=r["title_ko"],
                title_en=opt(r["title_en"]),
                title_original=opt(r["title_original"]),
                year=opt_int(r["release_year"]),
                arranged=r["arranged"] == "1",
            )
        )
    return composers, pieces, parts, films


def build_candidate(
    piece: Piece,
    parts: list[Part],
    pieces: dict[int, Piece],
    recordings: dict[str, int],
    fame_floor: int,
    duplicates: list[Piece],
) -> Candidate:
    top_parts = sorted((p for p in parts if p.top_level), key=lambda p: (p.sequence, p.id))
    linked = [pieces[p.linked] for p in top_parts if p.linked in pieces]
    candidate = Candidate(piece=piece, parts=top_parts, linked=linked)

    def rec(part: Part) -> int:
        return recordings.get(part.mbid or "", -1)

    comparable_parts = [p for p in top_parts if p.linked in pieces and pieces[p.linked].comparable]
    if comparable_parts:
        candidate.rep = max(
            comparable_parts, key=lambda p: (pieces[p.linked or 0].cmp_artists, rec(p), -p.sequence)
        )
        candidate.rep_basis = "linked_comparable"
    elif piece.part_kind == "work":
        notable_parts = [p for p in top_parts if p.notable]
        if notable_parts:
            candidate.rep = max(notable_parts, key=lambda p: (rec(p), -p.sequence))
            candidate.rep_basis = "notable_part"

    members = [piece, *linked, *duplicates]
    comparable = any(m.comparable for m in [piece, *linked])
    flagged = any(m.notable for m in members) or any(p.notable for p in top_parts)
    # 대표곡 규칙(11/7)은 형식마다 3곡까지라 「라 보엠」처럼 언어판이 많은 곡이 빠진다.
    # 같은 규칙의 앞 조건(작곡가 작품 언어판 상위 10%, 10 이상)에 들면 대표곡과 같은 단계로 본다
    by_fame = max(m.fame for m in members) >= fame_floor
    notable = flagged or by_fame
    described = any(m.description for m in members)
    linked_audio = any(m.has_link for m in members)
    candidate.tier = (
        4 if comparable else 3 if notable else 2 if described else 1 if linked_audio else 0
    )
    candidate.fame = max(m.fame for m in members)
    candidate.signals = {
        "tier": TIER_LABEL[candidate.tier],
        "comparable": comparable,
        "comparableSectors": sum(m.cmp_sectors for m in members),
        "notable": notable,
        "notableBy": "flag" if flagged else "fame" if by_fame else None,
        "description": described,
        "link": linked_audio,
        "fameScore": candidate.fame,
        "genre": piece.genre,
        "formKey": piece.form_key,
        "year": piece.year,
        "partCount": piece.part_count,
        "partKind": piece.part_kind,
    }
    return candidate


def era_of(year: int | None, bounds: tuple[int, int] | None) -> int | None:
    if year is None or bounds is None:
        return None
    low, high = bounds
    if high <= low:
        return 0
    position = (year - low) / (high - low)
    return 0 if position < 1 / 3 else 1 if position < 2 / 3 else 2


def year_bounds(candidates: Iterable[Candidate]) -> tuple[int, int] | None:
    years = sorted(c.piece.year for c in candidates if c.piece.year is not None)
    if len(years) < 3:
        return None
    return years[int(0.05 * (len(years) - 1))], years[int(0.95 * (len(years) - 1))]


def family_of(title: str) -> str:
    """같은 무대 작품·세트에서 나온 줄(오페라와 그 서곡·아리아, 발레와 모음곡)을 한 묶음으로 본다."""
    match = re.search(r"<([^<>]+)>", title)
    if not match:
        return title
    key = re.sub(r"\s*[,(].*$", "", match.group(1)).strip().lower()
    return FAMILY_ALIASES.get(key, key)


def pick(candidates: list[Candidate]) -> list[Candidate]:
    # 고를 수는 비교·대표곡 표시·설명이 있는 후보 수로 정한다(언어판 수로만 대표곡이 된 후보는 세지 않는다)
    strong_pool = [c for c in candidates if c.tier >= 2 and c.signals["notableBy"] != "fame"]
    target = min(MAX_PICKS, max(MIN_PICKS, len(strong_pool)), len(candidates))
    bounds = year_bounds(candidates)
    # 작품 대부분이 한 갈래·형식인 작곡가(쇼팽 피아노, 푸치니 오페라)는 그 갈래·형식을 덜 깎는다
    genre_share = Counter(c.genre_key for c in strong_pool)
    form_share = Counter(c.piece.form_key for c in strong_pool if c.piece.form_key)
    pool_size = max(len(strong_pool), 1)
    picked: list[Candidate] = []
    genres: Counter[str] = Counter()
    forms: Counter[str] = Counter()
    families: set[str] = set()
    eras: set[int] = set()
    remaining = list(candidates)

    def value(c: Candidate) -> tuple[float, int, int]:
        score: float = c.tier * 100 + min(c.fame, FAME_CAP)
        if 2 <= c.tier <= 3 and c.signals["link"]:
            score += LINK_BONUS
        if c.signals["description"]:
            score += DESCRIPTION_BONUS
        repeat = genres[c.genre_key]
        spread = max(SHARE_FLOOR, 1 - genre_share[c.genre_key] / pool_size)
        score -= GENRE_PENALTY * spread * min(repeat, 3)
        if c.piece.form_key:
            repeat = forms[c.piece.form_key]
            spread = max(SHARE_FLOOR, 1 - form_share[c.piece.form_key] / pool_size)
            score -= FORM_PENALTY * spread * min(repeat, 2)
        if family_of(c.piece.title) in families:
            score -= FAMILY_PENALTY
        era = era_of(c.piece.year, bounds)
        if era is not None and era not in eras:
            score += ERA_BONUS
        return score, c.piece.cmp_artists, -c.piece.id

    while remaining and len(picked) < target:
        best = max(remaining, key=value)
        if len(picked) >= MIN_PICKS and best.tier < 2:
            break
        remaining.remove(best)
        picked.append(best)
        genres[best.genre_key] += 1
        if best.piece.form_key:
            forms[best.piece.form_key] += 1
        families.add(family_of(best.piece.title))
        era = era_of(best.piece.year, bounds)
        if era is not None:
            eras.add(era)
        best.signals["era"] = ["early", "middle", "late"][era] if era is not None else None
    return picked


SERIES_KO = re.compile(r"^(?P<series>[^<>\"(]+?) (?P<num>\d+)번(?: |$)")
SERIES_EN = re.compile(r"^(?P<series>[A-Za-z][A-Za-z \-]+?) No\. ?(?P<num>\d+)\b")


def series_of(piece: Piece) -> tuple[str, int] | None:
    match = SERIES_KO.match(piece.title)
    if not match:
        return None
    return match.group("series"), int(match.group("num"))


def series_fact(
    piece: Piece, composer_pieces: list[Piece]
) -> tuple[str, str, dict[str, object]] | None:
    """번호 붙은 같은 형식 작품이 1번부터 빠짐없고 모두 연도가 있을 때만 첫·마지막을 말한다."""
    own = series_of(piece)
    if own is None or piece.year is None or piece.form_key is None:
        return None
    series, number = own
    members = [
        p
        for p in composer_pieces
        if not p.hidden and p.form_key == piece.form_key and p.title.startswith(series + " ")
    ]
    numbered: dict[int, list[Piece]] = defaultdict(list)
    for member in members:
        found = series_of(member)
        if found and found[0] == series:
            numbered[found[1]].append(member)
    if len(numbered) < 2 or sorted(numbered) != list(range(1, max(numbered) + 1)):
        return None
    if any(len(group) > 1 for group in numbered.values()):
        return None
    if any(m.year is None for m in members):
        return None
    years = [m.year for m in members if m.id != piece.id and m.year is not None]
    english = SERIES_EN.match(piece.title_en or "")
    series_en = english.group("series").strip().lower() if english else None
    basis: dict[str, object] = {
        "rule": "series",
        "series": series,
        "numbers": f"1–{max(numbered)}",
        "members": len(members),
    }
    if number == max(numbered) and all(piece.year > y for y in years):
        return f"마지막 {series}", f"Last {series_en}" if series_en else "", basis
    if number == 1 and all(piece.year < y for y in years):
        return f"첫 {series}", f"First {series_en}" if series_en else "", basis
    return None


def recording_fact(
    candidate: Candidate, recordings: dict[str, int]
) -> tuple[str, str, dict[str, object]] | None:
    rep = candidate.rep
    if rep is None or candidate.piece.part_kind != "work":
        return None
    counts = [recordings.get(p.mbid or "") for p in candidate.parts]
    if len(counts) < 3 or any(c is None for c in counts):
        return None
    measured = [c for c in counts if c is not None]
    own = recordings.get(rep.mbid or "")
    others = [c for p, c in zip(candidate.parts, measured, strict=True) if p.id != rep.id]
    if own is None or not others or own < RECORDING_LEAD * max(others) or own < 15:
        return None
    n = len(candidate.parts)
    basis: dict[str, object] = {
        "rule": "recordings",
        "source": "MusicBrainz recording count",
        "rep": own,
        "next": max(others),
        "parts": n,
    }
    return (
        f"{KOREAN_COUNT[n]} 곡 가운데 가장 많이 녹음된 곡"
        if n in KOREAN_COUNT
        else f"{n}곡 가운데 가장 많이 녹음된 곡",
        f"Most recorded of the {n} pieces",
        basis,
    )


def film_fact(
    candidate: Candidate, films: dict[int, list[Film]]
) -> tuple[str, str, dict[str, object]] | None:
    ids = [candidate.piece.id]
    if candidate.rep and candidate.rep.linked:
        ids.append(candidate.rep.linked)
    options = [film for piece_id in ids for film in films.get(piece_id, [])]
    if not options:
        return None
    order = {"MOVIE": 0, "SERIES": 1, "ANIME": 2}
    film = min(
        options, key=lambda f: (f.arranged, order.get(f.kind, 9), f.year or 9999, f.title_ko)
    )
    kind_ko = FILM_KIND_KO.get(film.kind, "영화")
    year = f"({film.year})" if film.year else ""
    arranged_ko = "편곡해 " if film.arranged else ""
    title_en = film.title_en or film.title_original or film.title_ko
    arranged_en = " in an arrangement" if film.arranged else ""
    basis: dict[str, object] = {
        "rule": "film",
        "title": film.title_ko,
        "kind": film.kind,
        "year": film.year,
        "films": len({(f.title_ko, f.year) for f in options}),
    }
    return (
        f"{kind_ko} <{film.title_ko}>{year}에 {arranged_ko}쓰인 곡",
        f"Used{arranged_en} in {FILM_KIND_EN.get(film.kind, 'the film')} {title_en}"
        + (f" ({film.year})" if film.year else ""),
        basis,
    )


def part_label(candidate: Candidate) -> tuple[str | None, str | None]:
    rep = candidate.rep
    if rep is None:
        return None, None
    return rep.name_ko or rep.name_en, rep.name_en


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--work", type=Path, required=True)
    parser.add_argument("--recordings", type=Path, required=True)
    parser.add_argument("--out", type=Path, required=True)
    args = parser.parse_args()

    composers, pieces, parts, films = load(args.work)
    recordings: dict[str, int] = json.loads(args.recordings.read_text(encoding="utf-8"))
    facts: dict[str, dict[str, str]] = json.loads(
        (args.out / "reason_facts.json").read_text(encoding="utf-8")
    )
    excluded: dict[str, dict[str, int | str]] = json.loads(
        (args.out / "exclude.json").read_text(encoding="utf-8")
    )

    parts_by_piece: dict[int, list[Part]] = defaultdict(list)
    for part in parts:
        parts_by_piece[part.piece_id].append(part)
    by_composer: dict[int, list[Piece]] = defaultdict(list)
    for piece in pieces.values():
        by_composer[piece.composer_id].append(piece)

    drafts: list[dict[str, object]] = []
    summary: dict[str, dict[str, object]] = {}
    rules: Counter[str] = Counter()
    for composer in sorted(composers.values(), key=lambda c: c.id):
        own = by_composer.get(composer.id, [])
        tops = [p for p in own if not p.hidden and p.in_bundle is None]
        fames = sorted(p.fame for p in tops)
        fame_floor = max(10, fames[int(0.9 * (len(fames) - 1))]) if fames else 10
        duplicates: dict[int, list[Piece]] = defaultdict(list)
        for key, entry in excluded.items():
            keep = entry.get("duplicateOf")
            if keep is not None and int(key) in pieces:
                duplicates[int(keep)].append(pieces[int(key)])
        candidates = [
            build_candidate(
                p, parts_by_piece.get(p.id, []), pieces, recordings, fame_floor, duplicates[p.id]
            )
            for p in sorted(tops, key=lambda p: p.id)
            if "편곡" not in p.title and "위작" not in p.title and str(p.id) not in excluded
        ]
        picked = pick(candidates)
        summary[str(composer.id)] = {
            "name": composer.name,
            "candidates": len(candidates),
            "picked": len(picked),
        }
        for order, candidate in enumerate(picked, start=1):
            piece = candidate.piece
            reason_ko, reason_en = "", ""
            basis: dict[str, object] = {}
            fact = facts.get(str(piece.id))
            if fact:
                reason_ko, reason_en = fact["ko"], fact["en"]
                basis = {"rule": "description", "quote": fact["basis"]}
            else:
                found = (
                    series_fact(piece, own)
                    or recording_fact(candidate, recordings)
                    or film_fact(candidate, films)
                )
                if found:
                    reason_ko, reason_en, basis = found
            name_ko, name_en = part_label(candidate)
            signals = dict(candidate.signals)
            signals["reasonBasis"] = basis or None
            rules[str(basis.get("rule", "none"))] += 1
            if candidate.rep is not None:
                signals["partBasis"] = candidate.rep_basis
                signals["partRecordings"] = recordings.get(candidate.rep.mbid or "")
            drafts.append(
                {
                    "composer_id": composer.id,
                    "composer_name": composer.name,
                    "composer_tier": composer.tier,
                    "piece_id": piece.id,
                    "title": piece.title,
                    "title_en": piece.title_en,
                    "part_id": candidate.rep.id if candidate.rep else None,
                    "part_number": candidate.rep.sequence if candidate.rep else None,
                    "part_name": name_ko,
                    "part_name_en": name_en,
                    "compare_piece_id": (
                        piece.id
                        if piece.comparable
                        else candidate.rep.linked
                        if candidate.rep
                        and candidate.rep.linked
                        and pieces[candidate.rep.linked].comparable
                        else None
                    ),
                    "sort_order": order,
                    "reason": reason_ko,
                    "reason_en": reason_en,
                    "signals": signals,
                }
            )

    out: Path = args.out
    with (out / "drafts.jsonl").open("w", encoding="utf-8") as handle:
        for row in drafts:
            handle.write(json.dumps(row, ensure_ascii=False) + "\n")
    with (out / "review.csv").open("w", encoding="utf-8-sig", newline="") as handle:
        writer = csv.writer(handle)
        writer.writerow(
            [
                "작곡가",
                "순서",
                "작품 id",
                "작품",
                "대표 곡",
                "이유",
                "이유(영어)",
                "근거",
                "신호",
                "갈래",
                "연도",
                "넣을까(O/X)",
                "고칠 점",
            ]
        )
        for row in drafts:
            row_signals = row["signals"]
            assert isinstance(row_signals, dict)
            row_basis = row_signals.get("reasonBasis")
            part_cell = (
                f"{row['part_number']}. {row['part_name']}"
                if row["part_number"] is not None
                else ""
            )
            writer.writerow(
                [
                    f"{row['composer_name']} ({row['composer_tier']})",
                    row["sort_order"],
                    row["piece_id"],
                    row["title"],
                    part_cell,
                    row["reason"],
                    row["reason_en"],
                    json.dumps(row_basis, ensure_ascii=False) if row_basis else "",
                    row_signals.get("tier"),
                    row_signals.get("genre") or "기타",
                    row_signals.get("year") or "",
                    "",
                    "",
                ]
            )
    print(
        json.dumps(
            {
                "composers": len(composers),
                "withDrafts": sum(1 for v in summary.values() if v["picked"]),
                "items": len(drafts),
                "emptyReason": sum(1 for row in drafts if not row["reason"]),
                "rules": dict(rules),
            },
            ensure_ascii=False,
        )
    )
    (out / "summary.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=1), encoding="utf-8"
    )


if __name__ == "__main__":
    main()
