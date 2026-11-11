# ruff: noqa: E501 — SQL 머리 주석과 값 줄은 한 줄로 둔다.
"""decisions.json 대로 같은 작곡가 안 중복 작품을 하나로 합치는 마이그레이션을 만든다.

묶음마다 남길 작품(keep) 하나와 숨길 작품(hide)이 있다. 숨길 작품마다 이 순서로 쓴다.

1. 숨긴다: hidden_reason='duplicate'. 제목이 그대로이고, 아직 보이고, 비교 구간이 없고, 다른 작품의 part 가
   가리키지 않고, 남길 작품이 보일 때만. 지우지 않으므로 상세(/pieces/<id>)는 계속 열린다.
2. 옮긴다: 1이 된 경우(숨긴 까닭이 'duplicate' 이고 남길 작품이 보임)에만. 작품을 가리키는 표의 행을 남길
   작품으로 옮긴다. 유일 키가 있는 표는 UPDATE IGNORE 라 남길 작품에 같은 행이 이미 있으면 그 행은 숨긴 작품에
   그대로 남는다(숨긴 작품 상세는 열리니 끊기지 않는다).
3. 채운다: 남길 작품이 비어 있는 칸(설명·링크·연도)만 숨긴 작품 값으로, 대표곡 표시·fame_score 는 큰 쪽으로.
4. part: move_parts 인 묶음만, 남길 작품에 part 가 하나도 없고 숨긴 작품 part 에 겹 part·음원 연결이 없을 때 통째로 옮긴다.
5. 고침(set): 묶음에 적은 칸을 when 조건이 맞을 때만 바꾼다.

두 번 넣어도 같다. 숨긴 뒤에는 2~4 가 옮길 행이 없고, 3·5 는 조건이 맞지 않는다.

사용: python3 gen_sql.py --decisions decisions.json --out <마이그레이션 파일>
"""

import argparse
import json
from pathlib import Path
from typing import NotRequired, TypedDict


class Ref(TypedDict):
    id: int
    title: str


class Group(TypedDict):
    composer_id: int
    composer: str
    keep: Ref
    hide: list[Ref]
    move_parts: bool
    evidence: str
    set: NotRequired[dict[str, object]]


# (표, 칸, 유일 키가 있어 IGNORE 가 필요한지)
REFERENCE_TABLES: list[tuple[str, str, bool]] = [
    ("piece_identifiers", "piece_id", False),
    ("piece_aliases", "piece_id", True),
    ("piece_instrumentation", "piece_id", True),
    ("piece_reco_features", "piece_id", True),
    ("composer_major_pieces", "piece_id", True),
    ("popular_comparisons", "piece_id", False),
    ("screen_music_cues", "piece_id", False),
    ("performances", "piece_id", True),
    ("user_favorite_pieces", "piece_id", True),
    ("user_taste_seed_pieces", "piece_id", True),
    ("user_listening_events", "piece_id", False),
]

# 남길 작품이 비어 있을 때 숨긴 작품 값으로 채우는 칸
FILL_COLUMNS = ["spotify_url", "apple_music_url", "youtube_music_url"]


def q(value: str) -> str:
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def merged(group: Group, hide: Ref) -> str:
    """숨김이 끝났고 남길 작품이 보이는지(2~4단계 조건)."""
    keep = group["keep"]
    cid = group["composer_id"]
    return (
        f"EXISTS (SELECT 1 FROM pieces hidden_piece JOIN pieces kept_piece ON kept_piece.id = {keep['id']}\n"
        f"    WHERE hidden_piece.id = {hide['id']} AND hidden_piece.composer_id = {cid}\n"
        f"      AND hidden_piece.title = {q(hide['title'])} AND hidden_piece.hidden_reason = 'duplicate'\n"
        f"      AND kept_piece.composer_id = {cid} AND kept_piece.hidden_reason IS NULL)"
    )


def pair_join(group: Group, hide: Ref) -> str:
    """pieces 끼리 묶는 다중 표 UPDATE 의 머리(kept ← hidden)."""
    return (
        f"UPDATE pieces kept JOIN pieces hidden ON hidden.id = {hide['id']} AND hidden.composer_id = {group['composer_id']}\n"
        f"    AND hidden.title = {q(hide['title'])} AND hidden.hidden_reason = 'duplicate'"
    )


def pair_where(group: Group) -> str:
    return (
        f"WHERE kept.id = {group['keep']['id']} AND kept.composer_id = {group['composer_id']}"
        " AND kept.hidden_reason IS NULL"
    )


def hide_statement(group: Group, hide: Ref) -> str:
    keep = group["keep"]
    cid = group["composer_id"]
    return (
        f"UPDATE pieces hidden JOIN pieces kept ON kept.id = {keep['id']} AND kept.composer_id = {cid}\n"
        f"    AND kept.title = {q(keep['title'])} AND kept.hidden_reason IS NULL\n"
        "SET hidden.hidden_reason = 'duplicate'\n"
        f"WHERE hidden.id = {hide['id']} AND hidden.composer_id = {cid} AND hidden.title = {q(hide['title'])}\n"
        "  AND hidden.hidden_reason IS NULL\n"
        "  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = hidden.id)\n"
        "  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = hidden.id);"
    )


def move_statements(group: Group, hide: Ref) -> list[str]:
    keep_id = group["keep"]["id"]
    hide_id = hide["id"]
    guard = merged(group, hide)
    out: list[str] = []
    for table, column, ignore in REFERENCE_TABLES:
        verb = "UPDATE IGNORE" if ignore else "UPDATE"
        out.append(
            f"{verb} {table} SET {column} = {keep_id}\nWHERE {column} = {hide_id} AND {guard};"
        )
    for column, other in (("from_piece_id", "to_piece_id"), ("to_piece_id", "from_piece_id")):
        out.append(
            f"UPDATE IGNORE piece_relations SET {column} = {keep_id}\n"
            f"WHERE {column} = {hide_id} AND {other} <> {keep_id} AND {guard};"
        )
    part = "part_id" if group["move_parts"] else "NULL"
    out.append(
        f"UPDATE IGNORE composer_highlights SET piece_id = {keep_id}, part_id = {part}\n"
        f"WHERE piece_id = {hide_id} AND composer_id = {group['composer_id']} AND {guard};"
    )
    out.append(
        f"UPDATE IGNORE track_piece_links SET piece_id = {keep_id}\n"
        f"WHERE piece_id = {hide_id} AND piece_part_id IS NULL AND {guard};"
    )
    return out


def fill_statements(group: Group, hide: Ref) -> list[str]:
    head = pair_join(group, hide)
    where = pair_where(group)
    out = [
        f"{head}\nSET kept.description = hidden.description, kept.description_en = hidden.description_en\n"
        f"{where}\n  AND (kept.description IS NULL OR kept.description = '')\n"
        "  AND hidden.description IS NOT NULL AND hidden.description <> '';"
    ]
    for column in FILL_COLUMNS:
        out.append(
            f"{head}\nSET kept.{column} = hidden.{column}\n{where}\n"
            f"  AND (kept.{column} IS NULL OR kept.{column} = '') AND hidden.{column} IS NOT NULL AND hidden.{column} <> '';"
        )
    out.append(
        f"{head}\nSET kept.composition_year = hidden.composition_year\n{where}\n"
        "  AND kept.composition_year IS NULL AND hidden.composition_year IS NOT NULL;"
    )
    out.append(
        f"{head}\nSET kept.notable = 1\n{where}\n"
        "  AND kept.notable = 0 AND kept.notable_locked = 0 AND hidden.notable = 1;"
    )
    out.append(
        f"{head}\nSET kept.fame_score = hidden.fame_score\n{where}\n"
        "  AND hidden.fame_score IS NOT NULL AND (kept.fame_score IS NULL OR kept.fame_score < hidden.fame_score);"
    )
    return out


def parts_statement(group: Group, hide: Ref) -> str:
    keep_id = group["keep"]["id"]
    hide_id = hide["id"]
    # piece_parts 를 고치면서 같은 표를 보면 MySQL 이 막으므로(1093) LIMIT 을 단 파생 표로 먼저 굳힌다.
    return (
        f"UPDATE piece_parts SET piece_id = {keep_id}\n"
        f"WHERE piece_id = {hide_id} AND {merged(group, hide)}\n"
        f"  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = {keep_id} LIMIT 1) AS kept_parts) = 0\n"
        f"  AND (SELECT COUNT(*) FROM (SELECT id FROM piece_parts WHERE piece_id = {hide_id} AND parent_part_id IS NOT NULL LIMIT 1) AS nested_parts) = 0\n"
        f"  AND NOT EXISTS (SELECT 1 FROM track_piece_links link WHERE link.piece_id = {hide_id} AND link.piece_part_id IS NOT NULL);"
    )


def set_statement(group: Group) -> str:
    fixes = dict(group["set"])
    when = fixes.pop("when")
    assert isinstance(when, dict)
    assignments = ", ".join(f"piece.{column} = {q(str(value))}" for column, value in fixes.items())
    conditions = " AND ".join(f"piece.{column} = {q(str(value))}" for column, value in when.items())
    return (
        f"UPDATE pieces piece SET {assignments}\n"
        f"WHERE piece.id = {group['keep']['id']} AND piece.composer_id = {group['composer_id']}"
        f" AND piece.hidden_reason IS NULL AND {conditions};"
    )


HEADER = """-- 같은 작곡가 안에서 한 작품이 두 줄 이상으로 보이던 것을 하나로 합친다(묶음 {groups}개, 숨긴 작품 {hides}개).
-- 근거와 고르지 않은 후보: seed_pipeline/curation/duplicate-pieces-2026-11-11/(README.md, decisions.json). 본문은 gen_sql.py 가 만든다.
--   숨길 작품은 hidden_reason='duplicate'(지우지 않음, 상세는 열림). 비교 구간이 있거나 part 가 가리키는 작품은 숨기지 않는다.
--   숨긴 뒤 그 작품을 가리키던 행(식별자·별칭·관계·카드·사용자 즐겨찾기 등)을 남길 작품으로 옮기고,
--   남길 작품의 빈 칸(설명·링크·연도)과 대표곡 표시를 채운다. part 는 남길 작품에 part 가 없을 때만 통째로 옮긴다.
--   두 번 넣어도 같다.
"""


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--decisions", type=Path, required=True)
    parser.add_argument("--out", type=Path, required=True)
    args = parser.parse_args()
    groups: list[Group] = json.loads(args.decisions.read_text(encoding="utf-8"))

    lines = [HEADER.format(groups=len(groups), hides=sum(len(group["hide"]) for group in groups))]
    for group in groups:
        keep = group["keep"]
        hidden = ", ".join(f"{hide['id']} 「{hide['title']}」" for hide in group["hide"])
        lines.append(
            f"\n-- {group['composer']}: {keep['id']} 「{keep['title']}」 ← {hidden}\n-- {group['evidence']}"
        )
        for hide in group["hide"]:
            lines.append(hide_statement(group, hide))
            lines.extend(move_statements(group, hide))
            lines.extend(fill_statements(group, hide))
            if group["move_parts"]:
                lines.append(parts_statement(group, hide))
        if "set" in group:
            lines.append(set_statement(group))
    args.out.write_text("\n".join(lines) + "\n", encoding="utf-8")


if __name__ == "__main__":
    main()
