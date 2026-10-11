"""쇼팽 catalog.json -> 데이터 마이그레이션 SQL 본문.

사용(seed_pipeline 에서):
    uv run python curation/chopin-catalog-2026-10-11/gen_sql.py <catalog.json> <out.sql>
"""

import json
import re
import sys
from typing import Any

Work = dict[str, Any]
Part = dict[str, Any]

COMPOSER_ID = 28
STATUS = "EDITOR_REVIEWED"

# 넣지 않는 것: 위작 의심, 민요를 받아 적은 묶음,
# 위키백과가 독립 창작곡이 아니라고 적은 라르고(B. 109).
EXCLUDE_AUTHENTICITY = {"doubtful", "folk_arrangement"}
EXCLUDE_CATALOGUE = {"B. 109"}
# 부분(section)으로 나뉜 변주곡·환상곡·론도는 낱곡으로 둔다.
# Op. 22 는 두 곡을 따로 연주하기도 해서 남긴다.
SECTION_TO_SINGLE = {"Op. 2", "Op. 13", "Op. 14"}

# Op. 74 가곡 제목. 번역에 출처가 없어 폴란드어 원제를 괄호로 함께 둔다.
# 세 곡은 원제 뜻에 맞게 고친다.
SONG_KO_FIX = {5: "좋아하는 곳", 11: "두 가지 결말", 13: "필요한 것이 없네"}

EXISTING_TITLES = {
    '연습곡 Op. 10, No. 12 "혁명"',
    "즉흥 환상곡",
    "발라드 1번 G단조",
    '폴로네즈 6번 A♭장조 "영웅"',
    "녹턴 E♭장조",
    "피아노 협주곡 1번 E단조",
    '왈츠 6번 D♭장조 "강아지 왈츠"',
    "녹턴 20번 C#단조 (유작)",
    '전주곡 15번 D♭장조 "빗방울"',
    '연습곡 Op. 10, No. 3 "이별의 곡"',
    "연습곡 Op. 25",
    "24개의 전주곡 Op. 28",
    "안단테 스피아나토와 화려한 대폴로네즈",
    "뱃노래 F#장조",
    "연습곡 Op. 10, No. 1 C장조",
    '피아노 소나타 2번 B♭단조 "장송"',
    "피아노 소나타 3번 B단조",
}

PIECE_COLUMNS = (
    "composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, "
    "composition_year, origin, editor_locked"
)
PART_COLUMNS = (
    "piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, "
    "name_ko, name_en, editorial_status, origin, editor_locked"
)


def q(value: str | int | None) -> str:
    if value is None:
        return "NULL"
    if isinstance(value, int):
        return str(value)
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def split_catalogue(catalogue: str) -> tuple[str, str]:
    match = re.match(r"^(Op\.|B\.)\s+(\S+)$", catalogue)
    if not match:
        raise ValueError(catalogue)
    return match.group(1), match.group(2)


def part_key(work: Work, seq: int, mbid: str | None, parent_seq: int | None = None) -> str:
    if mbid:
        return "musicbrainz:" + mbid
    slug = re.sub(r"[^a-z0-9]+", "-", (work["catalogue"] or work["key"]).lower()).strip("-")
    tail = f"{parent_seq}-{seq}" if parent_seq else str(seq)
    return f"classicmap:chopin:{slug}:{tail}"


def clean_name(work: Work, part: Part, movement: bool) -> tuple[str, str]:
    name_ko: str = part["nameKo"]
    name_en: str = part["nameEn"]
    if movement:
        return re.sub(r"^\d+악장 ", "", name_ko), name_en
    name_ko = re.sub(r"^\d+번 ", "", name_ko)
    if work["catalogue"] == "Op. 74":
        quoted = re.fullmatch(r'"(.+)"', name_ko)
        polish = re.search(r'"(.+?)"', name_en)
        if not quoted or not polish:
            raise ValueError(name_ko)
        ko = SONG_KO_FIX.get(part["seq"]) or quoted.group(1)
        name_ko = f"{ko} ({polish.group(1)})"
    return name_ko, name_en


def piece_selector(work: Work) -> str:
    if work["existingPieceId"]:
        return f"p.id = {work['existingPieceId']} AND p.composer_id = {COMPOSER_ID}"
    return (
        f"p.composer_id = {COMPOSER_ID} AND p.title = {q(work['titleKo'])} AND p.origin = 'manual'"
    )


def linked_expr(piece_id: int | None) -> str:
    if not piece_id:
        return "NULL"
    return (
        f"(SELECT linked.id FROM (SELECT id, composer_id FROM pieces) linked "
        f"WHERE linked.id = {piece_id} AND linked.composer_id = {COMPOSER_ID})"
    )


def identifier_free(mbid: str) -> str:
    return f"""NOT EXISTS (
    SELECT 1 FROM (SELECT namespace, external_id FROM piece_identifiers) taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = {q(mbid)}
)"""


def insert_piece(work: Work, kind: str) -> str:
    catalogue: str = work["catalogue"]
    system: str | None = None
    number: str | None = None
    opus: str | None = catalogue
    piece_type = "album" if kind == "multi_movement" else "song"
    if kind == "collection":
        system, number = split_catalogue(catalogue)
        opus, piece_type = None, "album"
    mbid: str | None = work["mbid"]
    taken_guard = f"\nAND {identifier_free(mbid)}" if mbid else ""
    values = ", ".join(
        [
            "c.id",
            q(work["titleKo"]),
            q(work["titleEn"]),
            f"'{piece_type}'",
            q(opus),
            q(system),
            q(number),
            q(work["year"]),
            "'manual'",
            "1",
        ]
    )
    sql = f"""INSERT INTO pieces
    ({PIECE_COLUMNS})
SELECT {values}
FROM composers c
WHERE c.id = {COMPOSER_ID}
AND NOT EXISTS (
    SELECT 1 FROM (SELECT composer_id, title FROM pieces) existing
    WHERE existing.composer_id = c.id AND existing.title = {q(work["titleKo"])}
){taken_guard};
"""
    if mbid:
        sql += f"""
INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', {q(mbid)}
FROM pieces p
WHERE {piece_selector(work)}
AND {identifier_free(mbid)};
"""
    return sql


def insert_part(work: Work, part: Part, movement: bool, parent: Part | None = None) -> str:
    key = part_key(work, part["seq"], part.get("mbid"), parent["seq"] if parent else None)
    name_ko, name_en = clean_name(work, part, movement)
    movement_number = part.get("movementNumber") if movement else None
    if parent:
        parent_key = part_key(work, parent["seq"], parent.get("mbid"))
        source = f"""FROM pieces p
JOIN (SELECT id, piece_id, part_key FROM piece_parts) parent
    ON parent.piece_id = p.id AND parent.part_key = {q(parent_key)}"""
        parent_expr = "parent.id"
    else:
        source = "FROM pieces p"
        parent_expr = "NULL"
    values = ", ".join(
        [
            "p.id",
            parent_expr,
            linked_expr(part.get("existingPieceId")),
            q(key),
            str(part["seq"]),
            q(movement_number),
            q(name_ko),
            q(name_en),
            f"'{STATUS}'",
            "'manual'",
            "1",
        ]
    )
    return f"""INSERT INTO piece_parts
    ({PART_COLUMNS})
SELECT {values}
{source}
WHERE {piece_selector(work)}
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, part_key FROM piece_parts) existing
    WHERE existing.piece_id = p.id AND existing.part_key = {q(key)}
);
"""


def update_existing_part(work: Work, part: Part, movement: bool) -> str:
    key = part_key(work, part["seq"], part.get("mbid"))
    name_ko, name_en = clean_name(work, part, movement)
    return f"""UPDATE piece_parts part
SET part.name_ko = {q(name_ko)}, part.name_en = {q(name_en)}, \
part.editorial_status = '{STATUS}', part.editor_locked = 1
WHERE part.id = {part["existingPartId"]} AND part.piece_id = {work["existingPieceId"]}
  AND part.part_key = {q(key)} AND part.sequence_number = {part["seq"]} \
AND part.editor_locked = 0;
"""


def update_existing_collection(work: Work) -> str:
    system, number = split_catalogue(work["catalogue"])
    pid = work["existingPieceId"]
    return f"""UPDATE pieces piece
SET piece.catalogue_system = {q(system)}, piece.catalogue_number = {q(number)}
WHERE piece.id = {pid} AND piece.composer_id = {COMPOSER_ID}
  AND piece.catalogue_number IS NULL AND piece.opus_number IS NULL;

UPDATE pieces piece
SET piece.composition_year = {q(work["year"])}
WHERE piece.id = {pid} AND piece.composer_id = {COMPOSER_ID} AND piece.composition_year IS NULL;
"""


def work_block(work: Work, titles: set[str], counts: dict[str, int]) -> list[str]:
    kind: str = work["kind"]
    parts: list[Part] = work["parts"]
    if work["catalogue"] in SECTION_TO_SINGLE:
        kind, parts = "single", []
    movement = work.get("partKind") == "movement"
    label = f"{work['catalogue']} {work['titleKo']}"
    if kind != "single" and not parts:
        raise ValueError(label)
    if not work["existingPieceId"]:
        if work["titleKo"] in EXISTING_TITLES or work["titleKo"] in titles:
            raise ValueError("제목 겹침: " + label)
        titles.add(work["titleKo"])
    block = [f"-- {label}\n"]
    if work["existingPieceId"]:
        if kind == "collection":
            block.append(update_existing_collection(work))
    else:
        block.append(insert_piece(work, kind))
        counts["pieces"] += 1
    for part in parts:
        if part.get("existingPartId"):
            block.append(update_existing_part(work, part, movement))
            counts["updated_parts"] += 1
        else:
            block.append(insert_part(work, part, movement))
            counts["parts"] += 1
        if part.get("existingPieceId"):
            counts["linked"] += 1
        for child in part.get("children") or []:
            block.append(insert_part(work, child, False, parent=part))
            counts["parts"] += 1
    return block


def main() -> None:
    with open(sys.argv[1]) as handle:
        works: list[Work] = json.load(handle)
    out: list[str] = []
    counts = {"pieces": 0, "parts": 0, "linked": 0, "updated_parts": 0}
    skipped: list[str] = []
    titles: set[str] = set()
    for work in works:
        excluded = (
            work["authenticity"] in EXCLUDE_AUTHENTICITY or work["catalogue"] in EXCLUDE_CATALOGUE
        )
        if excluded:
            skipped.append(f"{work['catalogue']} {work['titleKo']}")
            continue
        block = work_block(work, titles, counts)
        if len(block) > 1:
            out.append("\n".join(block))
    with open(sys.argv[2], "w") as handle:
        handle.write("\n\n".join(out))
    print(json.dumps({**counts, "skipped": skipped}, ensure_ascii=False, indent=1))


if __name__ == "__main__":
    main()
