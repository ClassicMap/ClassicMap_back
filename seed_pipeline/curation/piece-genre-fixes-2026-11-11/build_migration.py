# ruff: noqa: E501 — SQL 머리 주석과 이유 표는 한 줄로 둔다.
"""고친 분류(classify.py)와 운영 값의 차이로 갈래·형식 바로잡기 마이그레이션을 만든다.

운영 읽기 덤프(tools/dump.sh)의 지금 갈래·형식과 ../piece-forms-2026-11-07/classify.py 를 다시 돌린 결과를
비교해 다른 작품만 고친다. 아래 작품은 손대지 않는다.
- 비교 작품(손으로 정한 장르, ../piece-genres-2026-11-07/genres.jsonl)
- 숨긴 작곡가의 작품
- 남은 원어 seed(origin='seed', editor_locked=0): 같은 날 seed 정리 마이그레이션(0601~)이 다룬다
- 영화·TV·게임 작곡가 11명의 작품과 영화음악 규칙에 걸린 작품: 영화음악 갈래는 따로 다룬다
- 중복 정리 마이그레이션(0501)이 이미 고치는 작품

사용(seed_pipeline 에서):
    uv run python curation/piece-genre-fixes-2026-11-11/build_migration.py --db <덤프 폴더> \\
        --classes <classes.jsonl> --out ../migrations/202611110801_fix_piece_genres.sql \\
        --changes curation/piece-genre-fixes-2026-11-11/changes.jsonl
"""

import argparse
import csv
import json
import re
from collections import Counter
from pathlib import Path

csv.field_size_limit(10_000_000)

HERE = Path(__file__).resolve().parent
CLASSIFY = HERE.parent / "piece-forms-2026-11-07" / "classify.py"
CURATED = HERE.parent / "piece-genres-2026-11-07" / "genres.jsonl"

# 영화·TV·게임·애니 작곡가(작품 카탈로그 6차의 영화 규칙 11명)
FILM_COMPOSERS = {421, 111, 112, 419, 206, 220, 399, 154, 310, 203, 255}
# 중복 정리 마이그레이션 202611110501 이 갈래를 고치는 작품
HANDLED_BY_DUPLICATES = {32874, 12256}

RULE_REASONS: dict[str, str] = {
    "scoring-solo": "제목에 건반 아닌 독주 악기만 적혀 있음(무반주 독주)",
    "scoring-unsure": "제목에 현·관악기 하나만 적혀 있고 반주는 없음(실내악)",
    "scoring-with_keyboard": "제목에 건반과 다른 악기가 함께 적혀 있음(실내악)",
    "scoring-ensemble": "제목에 건반 아닌 악기 여럿이 적혀 있음(실내악)",
    "scoring-orchestra": "제목에 관현악·현악 합주·관악단 편성이 적혀 있음",
    "scoring-solo_orchestra": "제목에 독주 악기와 관현악이 적혀 있음(독주와 관현악)",
    "scoring-voice": "제목에 목소리·합창이 적혀 있음(성악)",
    "concertante": "독주 악기와 관현악을 위한 곡(협주곡 아님)",
    "concerto": "협주곡의 독주 악기로 형식을 고름",
    "guitar-composer": "기타 작곡가의 곡이 피아노 형식으로 읽혔음(기타 독주)",
    "violin-composer": "바이올린 작곡가의 곡이 피아노 갈래로 읽혔음(바이올린과 피아노)",
    "mixed-composer": "피아노 갈래가 틀렸지만 편성(기타·바이올린·관현악)을 제목으로 못 가려 비움",
    "piano-dance-composer": "피아노 곡이 대부분인 작곡가의 세레나데·민속 무곡",
    "character": "무언가(가사 없는 노래)는 기악 소품",
}


def read_tsv(path: Path) -> list[dict[str, str]]:
    with open(path, encoding="utf-8") as handle:
        return list(csv.DictReader(handle, delimiter="\t", quoting=csv.QUOTE_NONE))


def nullable(value: str) -> str | None:
    return None if value in ("NULL", "") else value


def sql_text(value: str | None) -> str:
    if value is None:
        return "NULL"
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def override_notes() -> dict[int, str]:
    """classify.py 의 OVERRIDES·UNDECIDED 줄 주석(작품마다 확인한 편성)."""
    notes: dict[int, str] = {}
    for line in CLASSIFY.read_text(encoding="utf-8").splitlines():
        match = re.match(r"\s*(\d+):\s*\"\w+\",\s*#\s*(.+)$", line) or re.match(
            r"\s*(\d+),\s*#\s*(.+)$", line
        )
        if match:
            notes[int(match.group(1))] = match.group(2).strip()
    return notes


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--db", required=True, type=Path)
    parser.add_argument("--classes", required=True, type=Path)
    parser.add_argument("--out", required=True, type=Path)
    parser.add_argument("--changes", required=True, type=Path)
    args = parser.parse_args()

    rows = {int(r["id"]): r for r in read_tsv(args.db / "classify_input.tsv")}
    hidden_composers = {
        int(r["id"]) for r in read_tsv(args.db / "composers.tsv") if r["hidden_reason"] != "NULL"
    }
    form_genre = {r["form_key"]: r["genre"] for r in read_tsv(args.db / "piece_forms.tsv")}
    with open(CURATED, encoding="utf-8") as handle:
        curated = {int(json.loads(line)["pieceId"]) for line in handle if line.strip()}
    with open(args.classes, encoding="utf-8") as handle:
        classes = {
            int(e["pieceId"]): e for e in (json.loads(line) for line in handle if line.strip())
        }
    notes = override_notes()

    skipped: Counter[str] = Counter()
    changes: list[dict[str, object]] = []
    for piece_id, row in sorted(rows.items()):
        entry = classes[piece_id]
        old = (nullable(row["genre"]), nullable(row["form_key"]))
        new = (entry["genre"], entry["formKey"])
        if old == new:
            continue
        composer_id = int(row["composer_id"])
        if piece_id in curated:
            skipped["비교 작품(손으로 정한 장르)"] += 1
            continue
        if composer_id in hidden_composers:
            skipped["숨긴 작곡가"] += 1
            continue
        if row["origin"] == "seed" and row["editor_locked"] == "0":
            skipped["남은 원어 seed(0601 이 다룸)"] += 1
            continue
        if composer_id in FILM_COMPOSERS or entry["rule"] == "film":
            skipped["영화·게임 음악"] += 1
            continue
        if piece_id in HANDLED_BY_DUPLICATES:
            skipped["중복 정리(0501)가 고침"] += 1
            continue
        if new[1] is not None and form_genre.get(new[1]) != new[0]:
            raise SystemExit(f"{piece_id}: 형식 {new[1]} 은 갈래 {new[0]} 에 속하지 않음")
        rule = str(entry["rule"])
        if rule in ("override", "undecided"):
            reason = notes.get(piece_id, "작품마다 편성 확인")
        else:
            reason = RULE_REASONS.get(rule, f"제목 규칙 '{rule}'")
            if old[0] is None:
                reason = f"갈래 없던 작품을 규칙으로 채움: {reason}"
        changes.append(
            {
                "pieceId": piece_id,
                "composer": row["cname"],
                "title": row["title"],
                "from": {"genre": old[0], "formKey": old[1]},
                "to": {"genre": new[0], "formKey": new[1]},
                "rule": rule,
                "reason": reason,
                "card": row["hl"] != "0",
                "notable": row["notable"] == "1",
            }
        )

    with open(args.changes, "w", encoding="utf-8") as out:
        for change in changes:
            out.write(json.dumps(change, ensure_ascii=False) + "\n")

    moves = Counter(
        (str(c["from"]["genre"]), str(c["to"]["genre"]))  # type: ignore[index]
        for c in changes
    )
    lines = [
        "-- 작품 갈래·형식 바로잡기(2026-11-11). 자료와 규칙은 seed_pipeline/curation/piece-genre-fixes-2026-11-11/",
        "-- (build_migration.py, changes.jsonl — 작품마다 옛값·새값·이유)와 ../piece-forms-2026-11-07/classify.py.",
        "-- 11/7 제목 규칙이 편성을 보지 않고 피아노 형식(전주곡·연습곡·소품·변주곡·모음곡)을 붙였거나",
        "-- 「무언가(Songs without words)」를 가곡으로 읽은 곳, 11/7 뒤 제목이 우리말로 바뀌어 옛 분류가 남은 곳,",
        "-- 공개 카드·대표곡 전수 확인에서 틀리거나 비어 있던 곳을 고친다. 형식은 갈래에 속한 것으로 같이 바꾼다.",
        "-- 비교 작품 257곡, 남은 원어 seed, 영화·게임 음악, 숨긴 작곡가는 건드리지 않는다.",
        f"-- 작품 {len(changes)}곡. 지금 값이 덤프 때와 같을 때만 바꾸므로 두 번 넣어도 같다.",
        "--   " + ", ".join(f"{a}→{b} {n}" for (a, b), n in moves.most_common()),
        "",
    ]
    for change in changes:
        old_genre = change["from"]["genre"]  # type: ignore[index]
        old_form = change["from"]["formKey"]  # type: ignore[index]
        new_genre = change["to"]["genre"]  # type: ignore[index]
        new_form = change["to"]["formKey"]  # type: ignore[index]
        lines.append(
            f"UPDATE pieces SET genre = {sql_text(new_genre)}, form_key = {sql_text(new_form)}"
            f" WHERE id = {change['pieceId']} AND genre <=> {sql_text(old_genre)}"
            f" AND form_key <=> {sql_text(old_form)};"
        )
    args.out.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(json.dumps({"changes": len(changes), "skipped": dict(skipped)}, ensure_ascii=False))


if __name__ == "__main__":
    main()
