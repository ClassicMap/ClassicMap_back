# ruff: noqa: E501 — SQL 머리 주석과 값 줄은 한 줄로 둔다.
"""decisions.json 대로 「처음 듣는다면」 초안을 고치고 공개하는 마이그레이션을 만든다.

- 뺄 곡(exclude)은 DRAFT 로 남긴다(화면에 안 보인다).
- 이유(reasons)와 순서(order)는 자동 초안 줄(source auto, status DRAFT)만 고친다. 사람이 고친 줄은 건드리지 않는다.
- 나머지 곡은 (작곡가, 작품) 목록을 그대로 적어 PUBLISHED 로 올린다.

사용: python3 build_publish.py --drafts drafts.jsonl --decisions decisions.json --out <마이그레이션 파일>
"""

import argparse
import json
from collections import defaultdict
from pathlib import Path
from typing import TypedDict


class Draft(TypedDict):
    composer_id: int
    composer_name: str
    piece_id: int
    sort_order: int
    reason: str | None
    reason_en: str | None


class Decisions(TypedDict):
    exclude: dict[str, str]
    order: dict[str, list[int]]
    reasons: dict[str, list[str | None]]


def sql_text(value: str | None) -> str:
    if value is None or value == "":
        return "NULL"
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--drafts", type=Path, required=True)
    parser.add_argument("--decisions", type=Path, required=True)
    parser.add_argument("--out", type=Path, required=True)
    args = parser.parse_args()

    drafts: list[Draft] = [
        json.loads(line)
        for line in args.drafts.read_text(encoding="utf-8").splitlines()
        if line.strip()
    ]
    decisions: Decisions = json.loads(args.decisions.read_text(encoding="utf-8"))

    by_piece: dict[int, Draft] = {}
    for draft in drafts:
        if draft["piece_id"] in by_piece:
            raise ValueError(f"작품이 두 번 나와요: {draft['piece_id']}")
        by_piece[draft["piece_id"]] = draft

    excluded = {int(piece) for piece in decisions["exclude"]}
    for piece in excluded | {int(piece) for piece in decisions["reasons"]}:
        if piece not in by_piece:
            raise ValueError(f"초안에 없는 작품이에요: {piece}")

    kept_by_composer: dict[int, list[Draft]] = defaultdict(list)
    for draft in drafts:
        if draft["piece_id"] not in excluded:
            kept_by_composer[draft["composer_id"]].append(draft)

    statements: list[str] = []
    for piece_key, (reason, reason_en) in decisions["reasons"].items():
        draft = by_piece[int(piece_key)]
        statements.append(
            f"UPDATE composer_highlights SET reason = {sql_text(reason)}, reason_en = {sql_text(reason_en)} "
            f"WHERE composer_id = {draft['composer_id']} AND piece_id = {draft['piece_id']} AND source = 'auto' AND status = 'DRAFT';"
        )

    reordered = 0
    for name, pieces in decisions["order"].items():
        composers = {by_piece[piece]["composer_id"] for piece in pieces}
        if len(composers) != 1:
            raise ValueError(f"{name}: 작곡가가 섞였어요 {composers}")
        composer_id = composers.pop()
        kept = {draft["piece_id"] for draft in kept_by_composer[composer_id]}
        if set(pieces) != kept or len(pieces) != len(kept):
            raise ValueError(f"{name}: 순서 목록이 남는 곡과 달라요 {sorted(set(pieces) ^ kept)}")
        for position, piece in enumerate(pieces, start=1):
            if by_piece[piece]["sort_order"] != position:
                reordered += 1
                statements.append(
                    f"UPDATE composer_highlights SET sort_order = {position} "
                    f"WHERE composer_id = {composer_id} AND piece_id = {piece} AND source = 'auto' AND status = 'DRAFT';"
                )

    published = [
        (draft["composer_id"], draft["piece_id"])
        for draft in drafts
        if draft["piece_id"] not in excluded
    ]
    pairs = ",\n".join(f"    ({composer}, {piece})" for composer, piece in published)
    with_reason = 0
    for draft in drafts:
        if draft["piece_id"] in excluded:
            continue
        override = decisions["reasons"].get(str(draft["piece_id"]))
        reason = override[0] if override is not None else draft["reason"]
        if reason:
            with_reason += 1

    lines = [
        "-- 작곡가 화면 「처음 듣는다면」 공개(202611110402 자동 초안을 고쳐서 PUBLISHED 로).",
        "-- 결정과 이유는 seed_pipeline/curation/composer-highlights-2026-11-11/decisions.json, 만든 스크립트는 build_publish.py.",
        f"-- 작곡가 {len(kept_by_composer)}명, 공개 {len(published)}곡(이유 있음 {with_reason}), DRAFT 로 남기는 곡 {len(excluded)}.",
        "-- 이유·순서는 자동 초안 줄(source auto, status DRAFT)만 고친다. 사람이 고친 줄은 건드리지 않는다.",
        "",
        *statements,
        "",
        "UPDATE composer_highlights",
        "SET status = 'PUBLISHED'",
        "WHERE source = 'auto'",
        "  AND status = 'DRAFT'",
        "  AND (composer_id, piece_id) IN (",
        pairs,
        "  );",
        "",
    ]
    args.out.write_text("\n".join(lines), encoding="utf-8")
    print(
        json.dumps(
            {
                "composers": len(kept_by_composer),
                "published": len(published),
                "withReason": with_reason,
                "excluded": len(excluded),
                "reasonEdits": len(decisions["reasons"]),
                "reorderedRows": reordered,
            },
            ensure_ascii=False,
        )
    )


if __name__ == "__main__":
    main()
