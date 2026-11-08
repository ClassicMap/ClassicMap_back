"""titles.tsv(작품마다 원제·판정·한국어 제목) → 한국어 제목 마이그레이션.

translate·label 만 쓴다(keep 은 원제 그대로). 지금 제목이 그때 본 원제와 같을 때만 바꾼다.
사용: python3 -I gen_sql.py titles.tsv 마이그레이션.sql
"""

from __future__ import annotations

import csv
import sys


def sql_text(value: str) -> str:
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def main() -> None:
    source, out = sys.argv[1], sys.argv[2]
    with open(source, encoding="utf-8") as handle:
        rows = [
            r
            for r in csv.DictReader(handle, delimiter="\t", quoting=csv.QUOTE_NONE, escapechar="\\")
            if r["action"] in ("translate", "label") and r["title_ko"] != r["title"]
        ]
    values = ",\n".join(
        f"({int(r['id'])}, {sql_text(r['title'])}, {sql_text(r['title_ko'])})" for r in rows
    )
    translated = sum(1 for r in rows if r["action"] == "translate")
    sql = f"""-- 작품 한국어 제목 칸에 원어 제목이 그대로 있던 작품을 한국어 화면 제목으로 바꾼다.
-- 자료: seed_pipeline/curation/piece-titles-ko-2026-11-09/(SPEC.md 기준, titles.tsv).
-- 갈래 제목 {translated}곡은 우리말로
--   (「Étude」→「연습곡」, 「Symphony no. 2 in F major」→「교향곡 2번 F장조」),
-- 고유 제목 {len(rows) - translated}곡은 「갈래 <원제>」로.
-- 영화·드라마 큐 같은 고유 제목은 그대로 둔다. 영어 제목 칸(title_en)은 건드리지 않는다.
-- 지금 제목이 그때 본 원제와 같을 때만 바꾼다. 두 번 넣어도 같다.

CREATE TEMPORARY TABLE tmp_piece_title_ko (
    piece_id INT NOT NULL PRIMARY KEY,
    old_title VARCHAR(300) NOT NULL,
    title VARCHAR(300) NOT NULL
);
INSERT INTO tmp_piece_title_ko (piece_id, old_title, title) VALUES
{values};

UPDATE pieces piece
JOIN tmp_piece_title_ko fix ON fix.piece_id = piece.id
SET piece.title = fix.title
WHERE piece.title = fix.old_title;

DROP TEMPORARY TABLE tmp_piece_title_ko;
"""
    with open(out, "w", encoding="utf-8") as handle:
        handle.write(sql)
    print(f"{len(rows)} rows ({translated} translate)")


if __name__ == "__main__":
    main()
