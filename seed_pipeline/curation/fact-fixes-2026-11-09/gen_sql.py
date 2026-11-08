"""result.json(사실 확인 결과)으로 한국어 원문과 영어를 함께 고치는 마이그레이션을 만든다.

fix·soften 만 쓴다(keep 은 그대로). 지금 한국어 값이 확인할 때 본 값과 같을 때만 바꾼다.
new_ko 가 null 이면 그 행을 지운다(수상 기록만 해당).
'에튀드' 를 '연습곡' 으로 맞추는 손 고침(EXTRA)도 같이 넣는다.
사용: python3 -I gen_sql.py result.json 마이그레이션.sql
"""

from __future__ import annotations

import json
import sys
from typing import Any

TABLE = {
    "pieces": "pieces",
    "sectors": "performance_sectors",
    "awards": "artist_awards",
    "artists": "artists",
    "composers": "composers",
}
EN = {"name_ko": "name_en"}

# 한국어 표기 맞추기(연습곡). (표, id, 칸, 지금 값, 새 값)
EXTRA: list[tuple[str, int, str, str, str]] = [
    (
        "composers",
        28,
        "style",
        "피아노 독주곡(녹턴, 발라드, 에튀드, 왈츠 등)",
        "피아노 독주곡(녹턴, 발라드, 연습곡, 왈츠 등)",
    ),
    ("piece_parts", 21847, "name_ko", "에튀드", "연습곡"),
    ("piece_parts", 23243, "name_ko", "에튀드. Allegro", "연습곡. Allegro"),
]


def sql_text(value: str) -> str:
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def main() -> None:
    source, out = sys.argv[1], sys.argv[2]
    with open(source, encoding="utf-8") as handle:
        results: list[dict[str, Any]] = json.load(handle)
    lines: list[str] = []
    counts = {"update": 0, "delete": 0}
    for item in results:
        if item["decision"] == "keep":
            continue
        table = TABLE[item["kind"]]
        field = item["field"]
        field_en = EN.get(field, f"{field}_en")
        key = int(item["id"])
        old_ko = item["old_ko"]
        if item["new_ko"] is None:
            lines.append(f"DELETE FROM {table} WHERE id = {key} AND {field} = {sql_text(old_ko)};")
            counts["delete"] += 1
            continue
        sets = [f"{field} = {sql_text(item['new_ko'])}"]
        if item.get("new_en"):
            sets.append(f"{field_en} = {sql_text(item['new_en'])}")
        lines.append(
            f"UPDATE {table} SET {', '.join(sets)}\n"
            f"WHERE id = {key} AND {field} = {sql_text(old_ko)};"
        )
        counts["update"] += 1
    for table, key, field, old, new in EXTRA:
        # 쇼팽 스타일은 문장 가운데 일부만 바꾼다
        lines.append(
            f"UPDATE {table} SET {field} = REPLACE({field}, {sql_text(old)}, {sql_text(new)})\n"
            f"WHERE id = {key} AND {field} LIKE {sql_text('%' + old + '%')};"
        )
    header = (
        "-- 큐레이션 글의 사실 오류를 고친다(번역할 때 걸린 곳을 웹 자료로 확인). 자료·근거:\n"
        "-- seed_pipeline/curation/fact-fixes-2026-11-09/(result.json 의 evidence).\n"
        f"-- 한국어·영어 함께 고침 {counts['update']}칸,"
        f" 근거 없는 수상 기록 {counts['delete']}행 삭제\n"
        "--   (아믈랭 「음반 다수」 2100년, 브론프만 「콜롬비아 국제 콩쿠르」 1975년).\n"
        "-- 한국어 표기 맞추기: 쇼팽 스타일·세트 안 곡 2곳의 「에튀드」→「연습곡」.\n"
        "-- 지금 값이 확인할 때 본 값과 같을 때만 바꾼다. 두 번 넣어도 같다.\n"
    )
    with open(out, "w", encoding="utf-8") as handle:
        handle.write(header + "\n" + "\n\n".join(lines) + "\n")
    print(json.dumps(counts))


if __name__ == "__main__":
    main()
