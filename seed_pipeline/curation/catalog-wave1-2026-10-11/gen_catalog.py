"""작곡가 catalog.json -> 데이터 마이그레이션 SQL 본문.

사용(seed_pipeline 에서):
    uv run python <이 파일> --composer-id 15 --slug beethoven \
        --catalog catalog.json --pieces db/pieces.tsv --taken db/all_mbids_taken.tsv --out out.sql

catalog.json 형식은 wave1/SPEC.md 를 따른다. 이름은 이미 화면에 쓸 꼴이어야 한다
("1번"·"1악장" 같은 번호 없이). 검사에 걸리면 SQL 을 쓰지 않고 멈춘다.
"""

import argparse
import csv
import json
import re
import sys
from dataclasses import dataclass, field
from typing import Any

Work = dict[str, Any]
Part = dict[str, Any]

STATUS = "EDITOR_REVIEWED"
NUMBER_PREFIX = re.compile(r"^\d+(번|악장)\s")

PIECE_COLUMNS = (
    "composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, "
    "composition_year, origin, editor_locked"
)
PART_COLUMNS = (
    "piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, "
    "name_ko, name_en, editorial_status, origin, editor_locked"
)


@dataclass
class Context:
    composer_id: int
    slug: str
    existing: dict[int, dict[str, str]]
    existing_titles: set[str]
    taken: dict[str, int]
    errors: list[str] = field(default_factory=list)
    counts: dict[str, int] = field(
        default_factory=lambda: {
            "pieces": 0,
            "parts": 0,
            "children": 0,
            "linked": 0,
            "updated_parts": 0,
            "existing_pieces": 0,
        }
    )


def q(value: str | int | None) -> str:
    if value is None:
        return "NULL"
    if isinstance(value, int):
        return str(value)
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def split_catalogue(catalogue: str) -> tuple[str, str]:
    match = re.match(r"^([A-Za-z]+\.?)\s+(.+)$", catalogue)
    if not match:
        raise ValueError(catalogue)
    return match.group(1), match.group(2)


def catalogue_in_title(work: Work) -> bool:
    catalogue = work.get("catalogue")
    return bool(catalogue) and str(work["titleKo"]).endswith(f" {catalogue}")


def part_key(ctx: Context, work: Work, path: list[int], mbid: str | None) -> str:
    if mbid:
        return "musicbrainz:" + mbid
    slug = re.sub(r"[^a-z0-9]+", "-", str(work["key"]).lower()).strip("-")
    return f"classicmap:{ctx.slug}:{slug}:" + "-".join(str(seq) for seq in path)


def piece_selector(ctx: Context, work: Work) -> str:
    if work.get("existingPieceId"):
        return f"p.id = {work['existingPieceId']} AND p.composer_id = {ctx.composer_id}"
    return (
        f"p.composer_id = {ctx.composer_id} AND p.title = {q(work['titleKo'])} "
        "AND p.origin = 'manual'"
    )


def linked_expr(ctx: Context, piece_id: int | None) -> str:
    if not piece_id:
        return "NULL"
    return (
        "(SELECT linked.id FROM pieces linked "
        f"WHERE linked.id = {piece_id} AND linked.composer_id = {ctx.composer_id})"
    )


def identifier_free(mbid: str) -> str:
    return f"""NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = {q(mbid)}
)"""


def insert_piece(ctx: Context, work: Work) -> str:
    catalogue: str | None = work.get("catalogue")
    system = number = None
    opus = catalogue
    if catalogue and catalogue_in_title(work):
        system, number = split_catalogue(catalogue)
        opus = None
    piece_type = "song" if work["kind"] == "single" else "album"
    mbid: str | None = work.get("mbid")
    taken_guard = f"\nAND {identifier_free(mbid)}" if mbid else ""
    values = ", ".join(
        [
            "c.id",
            q(work["titleKo"]),
            q(work.get("titleEn")),
            f"'{piece_type}'",
            q(opus),
            q(system),
            q(number),
            q(work.get("year")),
            "'manual'",
            "1",
        ]
    )
    sql = f"""INSERT INTO pieces
    ({PIECE_COLUMNS})
SELECT {values}
FROM composers c
WHERE c.id = {ctx.composer_id}
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = {q(work["titleKo"])}
){taken_guard};
"""
    if mbid:
        sql += f"""
INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', {q(mbid)}
FROM pieces p
WHERE {piece_selector(ctx, work)}
AND {identifier_free(mbid)};
"""
    return sql


def fill_existing_piece(ctx: Context, work: Work) -> str:
    """기존 작품은 비어 있는 작품번호·연도만 채운다. 제목·링크·설명은 그대로 둔다."""
    pid = work["existingPieceId"]
    row = ctx.existing[pid]
    catalogue: str | None = work.get("catalogue")
    sql = ""
    if catalogue and row["opus_number"] == "NULL" and row["catalogue_number"] == "NULL":
        if row["title"].endswith(" " + catalogue):
            system, number = split_catalogue(catalogue)
            sql += f"""UPDATE pieces piece
SET piece.catalogue_system = {q(system)}, piece.catalogue_number = {q(number)}
WHERE piece.id = {pid} AND piece.composer_id = {ctx.composer_id}
  AND piece.catalogue_number IS NULL AND piece.opus_number IS NULL;
"""
        else:
            sql += f"""UPDATE pieces piece
SET piece.opus_number = {q(catalogue)}
WHERE piece.id = {pid} AND piece.composer_id = {ctx.composer_id}
  AND piece.catalogue_number IS NULL AND piece.opus_number IS NULL;
"""
    if work.get("year") and row["composition_year"] == "NULL":
        sql += f"""UPDATE pieces piece
SET piece.composition_year = {q(work["year"])}
WHERE piece.id = {pid} AND piece.composer_id = {ctx.composer_id} AND piece.composition_year IS NULL;
"""
    # 기존 작품에 아직 없는 MBID(다른 판 work 등)는 식별자를 더한다. 기존 식별자는 지우지 않는다.
    mbid: str | None = work.get("mbid")
    if mbid and mbid not in ctx.taken:
        sql += f"""INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', {q(mbid)}
FROM pieces p
WHERE p.id = {pid} AND p.composer_id = {ctx.composer_id}
AND {identifier_free(mbid)};
"""
    return sql


def insert_part(ctx: Context, work: Work, part: Part, path: list[int], parent: Part | None) -> str:
    key = part_key(ctx, work, path, part.get("mbid"))
    if parent is not None:
        parent_key = part_key(ctx, work, path[:-1], parent.get("mbid"))
        source = f"""FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = {q(parent_key)}"""
        parent_expr = "parent.id"
    else:
        source = "FROM pieces p"
        parent_expr = "NULL"
    values = ", ".join(
        [
            "p.id",
            parent_expr,
            linked_expr(ctx, part.get("existingPieceId")),
            q(key),
            str(part["seq"]),
            q(part.get("movementNumber")),
            q(part["nameKo"]),
            q(part.get("nameEn")),
            f"'{STATUS}'",
            "'manual'",
            "1",
        ]
    )
    return f"""INSERT INTO piece_parts
    ({PART_COLUMNS})
SELECT {values}
{source}
WHERE {piece_selector(ctx, work)}
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = {q(key)}
);
"""


def update_existing_part(ctx: Context, work: Work, part: Part, path: list[int]) -> str:
    key = part_key(ctx, work, path, part.get("mbid"))
    return f"""UPDATE piece_parts part
SET part.name_ko = {q(part["nameKo"])}, part.name_en = {q(part.get("nameEn"))},
    part.movement_number = {q(part.get("movementNumber"))},
    part.editorial_status = '{STATUS}', part.editor_locked = 1
WHERE part.id = {part["existingPartId"]} AND part.piece_id = {work["existingPieceId"]}
  AND part.part_key = {q(key)} AND part.editor_locked = 0;
"""


def check_names(ctx: Context, label: str, part: Part) -> None:
    name = str(part.get("nameKo") or "").strip()
    if not name:
        ctx.errors.append(f"빈 nameKo: {label} seq {part.get('seq')}")
    elif NUMBER_PREFIX.match(name):
        ctx.errors.append(f"번호로 시작하는 nameKo: {label} {name}")


def part_block(
    ctx: Context, work: Work, part: Part, path: list[int], parent: Part | None, keys: set[str]
) -> list[str]:
    label = f"{work.get('catalogue')} {work['titleKo']}"
    check_names(ctx, label, part)
    key = part_key(ctx, work, path, part.get("mbid"))
    if key in keys:
        ctx.errors.append(f"한 작품 안 part_key 겹침: {label} {key}")
    keys.add(key)
    out: list[str] = []
    if part.get("existingPartId"):
        if not work.get("existingPieceId"):
            ctx.errors.append(f"existingPartId 인데 기존 작품이 아님: {label}")
        out.append(update_existing_part(ctx, work, part, path))
        ctx.counts["updated_parts"] += 1
    else:
        out.append(insert_part(ctx, work, part, path, parent))
        ctx.counts["children" if parent else "parts"] += 1
    if part.get("existingPieceId"):
        ctx.counts["linked"] += 1
    for child in part.get("children") or []:
        if child.get("children"):
            ctx.errors.append(f"세 겹 part: {label}")
        out.extend(part_block(ctx, work, child, [*path, child["seq"]], part, keys))
    return out


def work_block(ctx: Context, work: Work, titles: set[str]) -> list[str]:
    label = f"{work.get('catalogue')} {work['titleKo']}"
    parts: list[Part] = work.get("parts") or []
    if work["kind"] != "single" and not parts:
        ctx.errors.append(f"part 없는 묶음·다악장: {label}")
    if work["kind"] == "single" and parts:
        ctx.errors.append(f"part 있는 낱곡: {label}")
    existing_id = work.get("existingPieceId")
    mbid = work.get("mbid")
    if existing_id:
        if existing_id not in ctx.existing:
            ctx.errors.append(f"운영에 없는 existingPieceId {existing_id}: {label}")
            return []
        if mbid and ctx.taken.get(mbid, existing_id) != existing_id:
            ctx.errors.append(f"다른 작품({ctx.taken[mbid]})이 쓰는 MBID: {label} {mbid}")
    else:
        if work["titleKo"] in ctx.existing_titles or work["titleKo"] in titles:
            ctx.errors.append("제목 겹침: " + label)
        titles.add(work["titleKo"])
        if mbid and mbid in ctx.taken:
            ctx.errors.append(f"다른 작품({ctx.taken[mbid]})이 쓰는 MBID: {label} {mbid}")
    block = [f"-- {label}\n"]
    if existing_id:
        filled = fill_existing_piece(ctx, work)
        if filled:
            block.append(filled)
        ctx.counts["existing_pieces"] += 1
    else:
        block.append(insert_piece(ctx, work))
        ctx.counts["pieces"] += 1
    keys: set[str] = set()
    for part in parts:
        block.extend(part_block(ctx, work, part, [part["seq"]], None, keys))
    return block if len(block) > 1 else []


def read_tsv(path: str) -> list[dict[str, str]]:
    with open(path, encoding="utf-8") as handle:
        return list(csv.DictReader(handle, delimiter="\t", quoting=csv.QUOTE_NONE))


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--composer-id", type=int, required=True)
    parser.add_argument("--slug", required=True)
    parser.add_argument("--catalog", required=True)
    parser.add_argument("--pieces", required=True)
    parser.add_argument("--taken", required=True)
    parser.add_argument("--out", required=True)
    args = parser.parse_args()

    rows = [row for row in read_tsv(args.pieces) if int(row["composer_id"]) == args.composer_id]
    existing = {int(row["id"]): row for row in rows}
    taken = {row["external_id"]: int(row["piece_id"]) for row in read_tsv(args.taken)}
    ctx = Context(
        composer_id=args.composer_id,
        slug=args.slug,
        existing=existing,
        existing_titles={row["title"] for row in rows},
        taken=taken,
    )
    with open(args.catalog, encoding="utf-8") as handle:
        works: list[Work] = json.load(handle)

    titles: set[str] = set()
    out: list[str] = []
    for work in works:
        block = work_block(ctx, work, titles)
        if block:
            out.append("\n".join(block))
    if ctx.errors:
        print("\n".join(ctx.errors), file=sys.stderr)
        sys.exit(1)
    with open(args.out, "w", encoding="utf-8") as handle:
        handle.write("\n\n".join(out) + "\n")
    print(json.dumps(ctx.counts, ensure_ascii=False))


if __name__ == "__main__":
    main()
