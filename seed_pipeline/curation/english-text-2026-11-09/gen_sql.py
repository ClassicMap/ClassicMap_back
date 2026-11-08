"""번역 결과(out/*.jsonl)와 한국어 원문(in/*.jsonl)으로 영어 칸 채우기 마이그레이션을 만든다.

영어는 한국어 원문이 그때와 같을 때만 넣는다(원문 SHA-256 을 견준다).
그사이 원문을 고쳤으면 그 칸은 비워 둔다.
사용: python3 -I gen_sql.py <작업 폴더(in/, out/ 이 있는 곳)> <마이그레이션.sql>
"""

from __future__ import annotations

import glob
import hashlib
import json
import os
import sys
from typing import Any

# 입력 파일 → (표, [(한국어 칸, 영어 칸, 비교할 DB 칸 식)])
TARGETS: dict[str, tuple[str, list[tuple[str, str, str]]]] = {
    "composers": (
        "composers",
        [
            ("bio", "bio_en", "t.bio"),
            ("style", "style_en", "t.style"),
            ("influence", "influence_en", "t.influence"),
        ],
    ),
    "artists": ("artists", [("bio", "bio_en", "t.bio"), ("style", "style_en", "t.style")]),
    "awards": ("artist_awards", [("award_name", "award_name_en", "t.award_name")]),
    "pieces": ("pieces", [("description", "description_en", "t.description")]),
    "sectors": (
        "performance_sectors",
        [
            ("description", "description_en", "t.description"),
            ("name_ko", "name_en", "COALESCE(t.name_ko, t.sector_name)"),
        ],
    ),
    "notes": (
        "performance_listening_notes",
        [
            ("headline", "headline_en", "t.headline"),
            ("note", "note_en", "t.note"),
            ("facts", "facts_en", "t.note"),
        ],
    ),
    "pairs": (
        "sector_featured_pairs",
        [("title", "title_en", "t.title"), ("note", "note_en", "t.note")],
    ),
    "screen_titles": ("screen_titles", [("title_ko", "title_en", "t.title_ko")]),
    "screen_cues": (
        "screen_music_cues",
        [
            ("part_label", "part_label_en", "t.part_label"),
            ("scene_note", "scene_note_en", "t.scene_note"),
        ],
    ),
}
# 표의 기본 키 칸
KEY = {
    "performance_listening_notes": "performance_id",
    "sector_featured_pairs": "sector_id",
}


def sql_text(value: str) -> str:
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def sha(value: str) -> str:
    return hashlib.sha256(value.encode("utf-8")).hexdigest()


def load(path: str) -> list[dict[str, Any]]:
    with open(path, encoding="utf-8") as handle:
        return [json.loads(line) for line in handle if line.strip()]


def kind_of(name: str) -> str:
    """out 파일 이름(A_composers, D_pieces, C_screen_cues …)에서 입력 종류를 뗀다."""
    return name.split("_", 1)[1]


def main() -> None:
    work, migration = sys.argv[1], sys.argv[2]
    source = {
        kind: {str(r["id"]): r for r in load(os.path.join(work, "in", f"{kind}.jsonl"))}
        for kind in TARGETS
    }
    rows: list[tuple[str, str, str, str, str]] = []  # (표, id, 영어 칸, 원문 해시, 영어)
    counts: dict[str, int] = {}
    for path in sorted(glob.glob(os.path.join(work, "out", "*.jsonl"))):
        kind = kind_of(os.path.basename(path)[: -len(".jsonl")])
        table, fields = TARGETS[kind]
        for record in load(path):
            original = source[kind][str(record["id"])]
            for ko, en, _ in fields:
                value = record.get(f"{ko}_en") if ko != "facts" else record.get("facts_en")
                if ko == "name_ko":
                    value = record.get("name_en")
                    if original.get("name_en"):
                        continue
                if value in (None, "", []):
                    continue
                if ko == "facts":
                    text = json.dumps(value, ensure_ascii=False)
                    guard = original.get("note") or ""
                else:
                    text = str(value)
                    guard = original.get(ko) or ""
                if not guard:
                    continue
                rows.append((table, str(record["id"]), en, sha(guard), text))
                counts[f"{table}.{en}"] = counts.get(f"{table}.{en}", 0) + 1

    values = ",\n".join(
        f"({sql_text(t)}, {int(i)}, {sql_text(f)}, '{h}', {sql_text(v)})" for t, i, f, h, v in rows
    )
    updates = []
    for table, fields in TARGETS.values():
        key = KEY.get(table, "id")
        for _ko, en, compare in fields:
            value = "CAST(x.en AS JSON)" if en == "facts_en" else "x.en"
            extra = " AND (t.name_en IS NULL OR t.name_en = '')" if en == "name_en" else ""
            updates.append(
                f"UPDATE {table} t\n"
                f"JOIN tmp_english_text x\n"
                f"  ON x.tbl = '{table}' AND x.field = '{en}' AND x.id = t.{key}\n"
                f"SET t.{en} = {value}\n"
                f"WHERE SHA2({compare}, 256) = x.ko_hash{extra};"
            )
    summary = "\n".join(f"--   {name}: {count}" for name, count in sorted(counts.items()))
    sql = f"""-- 영어판 글: 작곡가·연주자 소개, 수상명, 작품 설명, 비교 구간 설명·이름,
-- 듣기 노트, 추천 비교, 영화 제목·장면.
-- 자료: seed_pipeline/curation/english-text-2026-11-09/(AI 번역, SPEC.md 기준).
-- 한국어 원문이 번역할 때와 같을 때만 넣는다(원문 SHA-256). 두 번 넣어도 같다.
{summary}

CREATE TEMPORARY TABLE tmp_english_text (
    tbl VARCHAR(64) NOT NULL,
    id BIGINT NOT NULL,
    field VARCHAR(64) NOT NULL,
    ko_hash CHAR(64) NOT NULL,
    en MEDIUMTEXT NOT NULL,
    PRIMARY KEY (tbl, field, id)
);
INSERT INTO tmp_english_text (tbl, id, field, ko_hash, en) VALUES
{values};

{chr(10).join(updates)}

DROP TEMPORARY TABLE tmp_english_text;
"""
    with open(migration, "w", encoding="utf-8") as handle:
        handle.write(sql)
    print(json.dumps(counts, ensure_ascii=False))


if __name__ == "__main__":
    main()
