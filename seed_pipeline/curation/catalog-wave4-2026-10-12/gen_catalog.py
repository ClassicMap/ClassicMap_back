"""작곡가 catalog.json -> 데이터 마이그레이션 SQL 본문.

사용(seed_pipeline 에서):
    uv run python <이 파일> --composer-id 15 --slug beethoven \
        --catalog catalog.json --pieces db/pieces.tsv --taken db/all_mbids_taken.tsv --out out.sql \
        [--seed-map seed_map.json]
    uv run python <이 파일> --hide-only --composer-id 4 --pieces db/pieces.tsv \
        --seed-map a/seed_map.json --seed-map b/seed_map.json --out hide.sql

catalog.json 형식은 SPEC.md 를 따른다. 이름은 이미 화면에 쓸 꼴이어야 한다
("1번"·"1악장" 같은 번호 없이). 검사에 걸리면 SQL 을 쓰지 않고 멈춘다.

3차(시드가 많은 작곡가)에서 더한 것:
- existingPieceId 가 손대지 않은 seed 작품(origin=seed, editor_locked=0)이면
  제목·작품번호·연도를 catalog 값으로 바꾸고 잠근다.
  part 에 이어지는 seed 작품은 제목을 「<작품> 중 "<곡>"」 꼴로 바꾼다.
- 기존 작품의 part 는 같은 part_key 를 가진 국제 시드 part 나 예전 FACTS_VERIFIED part 를
  먼저 고쳐 쓰고, 없으면 넣는다.
- --seed-map 을 주면 seed_map.json 의 work/part 와 catalog.json 의 existingPieceId 가
  맞는지 본다.
- --hide-only 는 seed_map 들 어디에도 work/part 로 잡히지 않은 그 작곡가의 seed 작품을
  목록에서 숨긴다(비교 구간이 있거나 part 가 가리키는 작품은 숨기지 않는다).
- seed_map 에서 reason 이 excerpt_keep 인 대목(단독 연주되는 서곡·아리아 등)은 숨기지 않고
  titleKo·titleEn 으로 제목만 바꾼다.
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
# 고쳐 써도 되는 기존 part: 국제 시드 part(잠기지 않음)와, 예전에 MusicBrainz 원제 그대로
# 손으로 넣어 둔 FACTS_VERIFIED part(이름이 원제라 화면에 숨겨져 있음).
REWRITABLE_PART = (
    "(part.editor_locked = 0"
    " OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'))"
)
# 숨기지 않는 unmatched 까닭: 단독 연주 대목, 4차 자동 대응에서 판단이 서지 않은 seed
KEEP_REASONS = ("excerpt_keep", "unreviewed")
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
    existing_titles: dict[str, set[int]]
    taken: dict[str, int]
    claimed: dict[int, str] = field(default_factory=dict)
    errors: list[str] = field(default_factory=list)
    counts: dict[str, int] = field(
        default_factory=lambda: {
            "pieces": 0,
            "parts": 0,
            "children": 0,
            "linked": 0,
            "updated_parts": 0,
            "existing_pieces": 0,
            "retitled_seed": 0,
            "renamed_hidden": 0,
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


def is_raw_seed(ctx: Context, piece_id: int | None) -> bool:
    """손대지 않은 국제 시드 작품인가(제목이 원어 그대로라 바꿔도 되는가)."""
    row = ctx.existing.get(piece_id or 0)
    if row is None:
        return False
    return row["origin"] == "seed" and row["editor_locked"] == "0"


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
    if is_raw_seed(ctx, pid):
        sql += retitle_seed_piece(ctx, work, pid)
    elif catalogue and row["opus_number"] == "NULL" and row["catalogue_number"] == "NULL":
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


def retitle_seed_piece(ctx: Context, work: Work, pid: int) -> str:
    """seed 작품이 catalog 작품 자체면 제목·작품번호·연도를 catalog 값으로 바꾸고 잠근다."""
    catalogue: str | None = work.get("catalogue")
    system = number = None
    opus = catalogue
    if catalogue and catalogue_in_title(work):
        system, number = split_catalogue(catalogue)
        opus = None
    piece_type = "song" if work["kind"] == "single" else "album"
    ctx.counts["retitled_seed"] += 1
    return f"""UPDATE pieces piece
SET piece.title = {q(work["titleKo"])}, piece.title_en = {q(work.get("titleEn"))},
    piece.type = '{piece_type}', piece.opus_number = {q(opus)},
    piece.catalogue_system = {q(system)}, piece.catalogue_number = {q(number)},
    piece.composition_year = COALESCE({q(work.get("year"))}, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = {pid} AND piece.composer_id = {ctx.composer_id}
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
"""


def retitle_linked_seed(ctx: Context, work: Work, part: Part, parent: Part | None) -> str:
    """part 에 이어지는 seed 작품의 원어 제목을 「<작품> 중 "<곡>"」 꼴로 바꾼다."""
    pid = part["existingPieceId"]
    head = str(work["titleKo"])
    head_en = str(work.get("titleEn") or work["titleKo"])
    if parent is not None:
        head = f"{head} {parent['nameKo']}"
        head_en = f"{head_en}, {parent.get('nameEn') or parent['nameKo']}"
    title = f'{head} 중 "{part["nameKo"]}"'
    title_en = f"{head_en}: {part.get('nameEn') or part['nameKo']}"
    ctx.counts["retitled_seed"] += 1
    return f"""UPDATE pieces piece
SET piece.title = {q(title[:300])}, piece.title_en = {q(title_en[:300])}, piece.editor_locked = 1
WHERE piece.id = {pid} AND piece.composer_id = {ctx.composer_id}
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
"""


def update_seed_part(
    ctx: Context, work: Work, part: Part, path: list[int], parent: Part | None
) -> str:
    """같은 part_key 의 잠기지 않은 part(국제 시드 part)가 있으면 catalog 값으로 고쳐 쓴다."""
    key = part_key(ctx, work, path, part.get("mbid"))
    if parent is not None:
        parent_key = part_key(ctx, work, path[:-1], parent.get("mbid"))
        source = f"""JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = {q(parent_key)}"""
        parent_expr = "parent.id"
    else:
        source = ""
        parent_expr = "NULL"
    return f"""UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
{source}
SET part.parent_part_id = {parent_expr},
    part.linked_piece_id = {linked_expr(ctx, part.get("existingPieceId"))},
    part.sequence_number = {part["seq"]}, part.movement_number = {q(part.get("movementNumber"))},
    part.name_ko = {q(part["nameKo"])}, part.name_en = {q(part.get("nameEn"))},
    part.editorial_status = '{STATUS}', part.editor_locked = 1
WHERE {piece_selector(ctx, work)} AND part.part_key = {q(key)} AND {REWRITABLE_PART};
"""


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
        out.append(update_seed_part(ctx, work, part, path, parent))
        ctx.counts["updated_parts"] += 1
    else:
        if work.get("existingPieceId"):
            out.append(update_seed_part(ctx, work, part, path, parent))
        out.append(insert_part(ctx, work, part, path, parent))
        ctx.counts["children" if parent else "parts"] += 1
    linked_id = part.get("existingPieceId")
    if linked_id:
        ctx.counts["linked"] += 1
        if linked_id not in ctx.existing:
            ctx.errors.append(f"운영에 없는 part existingPieceId {linked_id}: {label}")
        elif is_raw_seed(ctx, linked_id):
            out.append(retitle_linked_seed(ctx, work, part, parent))
        claim(ctx, linked_id, f"part {label}")
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
        claim(ctx, existing_id, f"work {label}")
        if is_raw_seed(ctx, existing_id):
            others = ctx.existing_titles.get(work["titleKo"], set()) - {existing_id}
            if others or work["titleKo"] in titles:
                ctx.errors.append("seed 작품의 새 제목 겹침: " + label)
            titles.add(work["titleKo"])
        if mbid and ctx.taken.get(mbid, existing_id) != existing_id:
            ctx.errors.append(f"다른 작품({ctx.taken[mbid]})이 쓰는 MBID: {label} {mbid}")
    else:
        if ctx.existing_titles.get(work["titleKo"]) or work["titleKo"] in titles:
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


def claim(ctx: Context, piece_id: int, where: str) -> None:
    if piece_id in ctx.claimed:
        ctx.errors.append(f"운영 작품 {piece_id} 를 두 곳에 씀: {ctx.claimed[piece_id]} / {where}")
    ctx.claimed[piece_id] = where


def load_seed_maps(paths: list[str]) -> dict[int, dict[str, Any]]:
    entries: dict[int, dict[str, Any]] = {}
    for path in paths:
        with open(path, encoding="utf-8") as handle:
            for entry in json.load(handle):
                pid = int(entry["pieceId"])
                previous = entries.get(pid)
                if (
                    previous
                    and previous["mapping"] != "unmatched"
                    and entry["mapping"] != "unmatched"
                ):
                    raise SystemExit(f"seed {pid} 가 두 seed_map 에서 work/part 로 잡힘")
                if not previous or entry["mapping"] != "unmatched":
                    entries[pid] = entry
    return entries


def check_seed_map(ctx: Context, entries: dict[int, dict[str, Any]]) -> None:
    claimed_seed = {pid for pid in ctx.claimed if ctx.existing[pid]["origin"] == "seed"}
    mapped = {pid for pid, entry in entries.items() if entry["mapping"] in ("work", "part")}
    for pid in sorted(mapped - claimed_seed):
        ctx.errors.append(f"seed_map 에는 work/part 인데 catalog 에 없음: {pid}")
    for pid in sorted(claimed_seed - mapped):
        ctx.errors.append(f"catalog 에는 이어졌는데 seed_map 에 work/part 가 아님: {pid}")


def keep_excerpt_sql(
    ctx: Context, rows: dict[int, dict[str, str]], entries: dict[int, dict[str, Any]]
) -> str:
    """단독으로 널리 연주되는 대목(excerpt_keep)은 숨기지 않고 우리말 제목만 붙인다."""
    out: list[str] = []
    for pid, entry in sorted(entries.items()):
        if entry.get("reason") != "excerpt_keep":
            continue
        title = str(entry.get("titleKo") or "").strip()
        if not title:
            ctx.errors.append(f"excerpt_keep 인데 titleKo 없음: {pid}")
            continue
        row = rows.get(pid)
        if row is None or row["origin"] != "seed":
            ctx.errors.append(f"excerpt_keep 이 seed 작품이 아님: {pid}")
            continue
        if row["editor_locked"] != "0":
            continue
        ctx.counts["retitled_seed"] += 1
        out.append(f"""UPDATE pieces piece
SET piece.title = {q(title)}, piece.title_en = {q(entry.get("titleEn"))}, piece.editor_locked = 1
WHERE piece.id = {pid} AND piece.composer_id = {ctx.composer_id}
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
""")
    return "\n".join(out)


RENAME_LABEL = {"arrangement": "편곡", "duplicate": "중복", "popular": "대중음악"}


def rename_clashing_sql(ctx: Context, entries: dict[int, dict[str, Any]], works: list[Work]) -> str:
    """숨길 seed 가 카탈로그 제목을 쥐고 있으면 제목 뒤에 까닭을 붙여 자리를 비운다.

    편곡판을 가리키는 seed 「Gymnopédies」 때문에 원곡 「Gymnopédies」를 못 넣는 일을 막는다.
    바꾼 seed 는 같은 마이그레이션에서 숨기므로 목록에는 나오지 않는다.
    """
    wanted = {str(work["titleKo"]) for work in works}
    out: list[str] = []
    for pid, entry in sorted(entries.items()):
        if entry["mapping"] != "unmatched" or entry.get("reason") in KEEP_REASONS:
            continue
        row = ctx.existing.get(pid)
        if row is None or row["title"] not in wanted or not is_raw_seed(ctx, pid):
            continue
        if row["sectors"] != "0":
            continue
        label = RENAME_LABEL.get(str(entry.get("reason")), "정리")
        new = f"{row['title']} ({label} {pid})"[:300]
        ctx.existing_titles.get(row["title"], set()).discard(pid)
        ctx.existing_titles.setdefault(new, set()).add(pid)
        ctx.counts["renamed_hidden"] += 1
        out.append(f"""UPDATE pieces piece
SET piece.title = {q(new)}
WHERE piece.id = {pid} AND piece.composer_id = {ctx.composer_id} AND piece.title = {q(row["title"])}
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
""")
    return "\n".join(out)


def hide_sql(
    composer_id: int, rows: list[dict[str, str]], entries: dict[int, dict[str, Any]]
) -> str:
    claimed = {
        pid
        for pid, entry in entries.items()
        if entry["mapping"] in ("work", "part") or entry.get("reason") in KEEP_REASONS
    }
    hide = sorted(
        int(row["id"])
        for row in rows
        if row["origin"] == "seed" and int(row["id"]) not in claimed and row["sectors"] == "0"
    )
    if not hide:
        return "-- 숨길 seed 작품 없음\n"
    ids = ",\n    ".join(
        ", ".join(str(pid) for pid in hide[i : i + 20]) for i in range(0, len(hide), 20)
    )
    return f"""-- 카탈로그에 대응이 없는 seed 작품 {len(hide)}개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = {composer_id} AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    {ids}
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
"""


def titles_by_piece(rows: list[dict[str, str]]) -> dict[str, set[int]]:
    titles: dict[str, set[int]] = {}
    for row in rows:
        titles.setdefault(row["title"], set()).add(int(row["id"]))
    return titles


def read_tsv(path: str) -> list[dict[str, str]]:
    with open(path, encoding="utf-8") as handle:
        return list(csv.DictReader(handle, delimiter="\t", quoting=csv.QUOTE_NONE))


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--composer-id", type=int, required=True)
    parser.add_argument("--slug")
    parser.add_argument("--catalog")
    parser.add_argument("--pieces", required=True)
    parser.add_argument("--taken")
    parser.add_argument("--out", required=True)
    parser.add_argument("--seed-map", action="append", default=[])
    parser.add_argument("--hide-only", action="store_true")
    args = parser.parse_args()

    rows = [row for row in read_tsv(args.pieces) if int(row["composer_id"]) == args.composer_id]
    entries = load_seed_maps(args.seed_map)
    if args.hide_only:
        missing = sorted(
            int(row["id"])
            for row in rows
            if row["origin"] == "seed" and int(row["id"]) not in entries
        )
        if missing:
            sys.exit(
                f"seed_map 에 없는 seed 작품 {len(missing)}개가 있어 숨기지 않는다: {missing[:20]}"
            )
        with open(args.out, "w", encoding="utf-8") as handle:
            handle.write(hide_sql(args.composer_id, rows, entries))
        seeds = sum(1 for row in rows if row["origin"] == "seed")
        print(json.dumps({"seed_pieces": seeds, "seed_map_entries": len(entries)}))
        return
    if not (args.slug and args.catalog and args.taken):
        parser.error("--slug, --catalog, --taken 이 필요하다")
    existing = {int(row["id"]): row for row in rows}
    taken = {row["external_id"]: int(row["piece_id"]) for row in read_tsv(args.taken)}
    ctx = Context(
        composer_id=args.composer_id,
        slug=args.slug,
        existing=existing,
        existing_titles=titles_by_piece(rows),
        taken=taken,
    )
    with open(args.catalog, encoding="utf-8") as handle:
        works: list[Work] = json.load(handle)

    titles: set[str] = set()
    out: list[str] = []
    renamed = rename_clashing_sql(ctx, entries, works) if entries else ""
    if renamed:
        out.append("-- 숨길 seed 가 쥔 카탈로그 제목을 비운다\n" + renamed)
    for work in works:
        block = work_block(ctx, work, titles)
        if block:
            out.append("\n".join(block))
    if entries:
        check_seed_map(ctx, entries)
        kept = keep_excerpt_sql(ctx, existing, entries)
        if kept:
            out.append("-- 단독으로 연주되는 대목은 남기고 제목만 우리말로\n" + kept)
    if ctx.errors:
        print("\n".join(ctx.errors), file=sys.stderr)
        sys.exit(1)
    with open(args.out, "w", encoding="utf-8") as handle:
        handle.write("\n\n".join(out) + "\n")
    print(json.dumps(ctx.counts, ensure_ascii=False))


if __name__ == "__main__":
    main()
