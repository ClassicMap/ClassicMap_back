# ruff: noqa: E501 — SQL 머리 주석과 값 줄은 한 줄로 둔다.
"""drafts.jsonl 로 「처음 듣는다면」 자동 초안 마이그레이션(status DRAFT)을 만든다.

- 작품은 그 작곡가의 작품이고 숨기지 않았을 때만 넣는다.
- 세트 대표 곡은 part id 가 아니라 (작품, 최상위 곡 번호)로 찾는다. 확인 전(보이지 않는) 곡이면 비운다.
- 이미 같은 (작곡가, 작품) 줄이 있으면 건드리지 않는다(사람이 고친 줄을 덮지 않는다). 두 번 넣어도 같다.

사용: python3 build_migration.py --drafts drafts.jsonl --out <마이그레이션 파일>
"""

import argparse
import json
from pathlib import Path


def sql_text(value: object) -> str:
    if value is None or value == "":
        return "NULL"
    text = str(value)
    return "'" + text.replace("\\", "\\\\").replace("'", "''") + "'"


def sql_int(value: object) -> str:
    if value is None:
        return "NULL"
    if not isinstance(value, int):
        raise TypeError(f"정수가 아니에요: {value!r}")
    return str(value)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--drafts", type=Path, required=True)
    parser.add_argument("--out", type=Path, required=True)
    args = parser.parse_args()

    rows: list[dict[str, object]] = [
        json.loads(line)
        for line in args.drafts.read_text(encoding="utf-8").splitlines()
        if line.strip()
    ]
    composers = {row["composer_id"] for row in rows}
    with_reason = sum(1 for row in rows if row["reason"])
    with_part = sum(1 for row in rows if row["part_number"] is not None)

    values = ",\n".join(
        "({composer}, {piece}, {part}, {order}, {reason}, {reason_en})".format(
            composer=sql_int(row["composer_id"]),
            piece=sql_int(row["piece_id"]),
            part=sql_int(row["part_number"]),
            order=sql_int(row["sort_order"]),
            reason=sql_text(row["reason"]),
            reason_en=sql_text(row["reason_en"]),
        )
        for row in rows
    )
    lines = [
        "-- 작곡가 화면 「처음 듣는다면」 자동 초안(status DRAFT, 화면에는 안 보인다).",
        "-- 자료와 규칙은 seed_pipeline/curation/composer-highlights-2026-11-11/(build_drafts.py, drafts.jsonl, review.csv).",
        f"-- S·A tier 작곡가 {len(composers)}명, {len(rows)}곡(이유 있음 {with_reason}, 세트 대표 곡 {with_part}).",
        "-- 사람이 확인표에서 고른 뒤 PUBLISHED 로 올리는 마이그레이션을 따로 만든다.",
        "CREATE TEMPORARY TABLE tmp_composer_highlight (",
        "    composer_id INT NOT NULL,",
        "    piece_id INT NOT NULL,",
        "    part_number INT NULL,",
        "    sort_order SMALLINT UNSIGNED NOT NULL,",
        "    reason VARCHAR(255) NULL,",
        "    reason_en VARCHAR(255) NULL,",
        "    PRIMARY KEY (composer_id, piece_id)",
        ") DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;",
        "",
        "INSERT INTO tmp_composer_highlight (composer_id, piece_id, part_number, sort_order, reason, reason_en) VALUES",
        values + ";",
        "",
        "INSERT INTO composer_highlights (composer_id, piece_id, part_id, sort_order, reason, reason_en, source, status)",
        "SELECT draft.composer_id,",
        "       draft.piece_id,",
        "       (SELECT MIN(part.id)",
        "        FROM piece_parts part",
        "        WHERE part.piece_id = draft.piece_id",
        "          AND part.parent_part_id IS NULL",
        "          AND part.sequence_number = draft.part_number",
        "          AND part.editorial_status IN ('EDITOR_REVIEWED', 'PUBLISHED')),",
        "       draft.sort_order,",
        "       draft.reason,",
        "       draft.reason_en,",
        "       'auto',",
        "       'DRAFT'",
        "FROM tmp_composer_highlight draft",
        "JOIN pieces piece ON piece.id = draft.piece_id AND piece.composer_id = draft.composer_id",
        "WHERE piece.hidden_reason IS NULL",
        "  AND NOT EXISTS (",
        "      SELECT 1 FROM composer_highlights existing",
        "      WHERE existing.composer_id = draft.composer_id AND existing.piece_id = draft.piece_id",
        "  );",
        "",
        "DROP TEMPORARY TABLE tmp_composer_highlight;",
        "",
    ]
    args.out.write_text("\n".join(lines), encoding="utf-8")
    print(
        json.dumps(
            {
                "composers": len(composers),
                "items": len(rows),
                "withReason": with_reason,
                "withPart": with_part,
            }
        )
    )


if __name__ == "__main__":
    main()
