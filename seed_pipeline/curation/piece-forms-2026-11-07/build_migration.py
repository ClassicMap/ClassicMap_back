# ruff: noqa: E501 — SQL 머리 주석과 값 줄은 한 줄로 둔다.
"""갈래·형식 분류(classes.jsonl)와 대표곡 신호로 데이터 마이그레이션을 만든다.

대표곡(작품):
- 위키데이터 언어판 수(작품 MBID 중 가장 큰 값)가 10 이상이면서
  (가) 그 작곡가 최상위 작품 전체에서 상위 10%(P90 이상) 이거나
  (나) 같은 갈래·형식 안에서 가운데값의 1.5배 이상(형식 작품의 20%까지).
  형식마다 최대 3곡이다.
- 비교 구간이 있는 작품은 늘 대표곡이다.
대표 곡(세트 안 곡, 최상위 part):
- MusicBrainz 녹음 수가 세트 가운데값의 1.8배 이상(녹음 수를 잰 곡이 3곡 이상인 세트)이거나
  위키데이터 언어판 15 이상. 세트마다 최대 2곡이다.
- 비교할 수 있는 작품을 가리키는 곡은 늘 대표 곡이다.
사람이 고친 값(notable_locked = 1)은 바꾸지 않는다. 두 번 넣어도 같다.

사용: python3 build_migration.py --work <자료 폴더> --out <마이그레이션 파일> --signals <신호 저장 폴더>
"""

import argparse
import csv
import json
import os
import statistics
from collections import defaultdict

csv.field_size_limit(10_000_000)

PIECE_SITELINKS_MIN = 10
PIECE_GROUP_LIMIT = 3
PART_SITELINKS_MIN = 15
PART_RECORDING_RATIO = 1.8
PART_LIMIT = 2


def read_tsv(path: str) -> list[dict[str, str]]:
    with open(path, encoding="utf-8") as handle:
        return list(csv.DictReader(handle, delimiter="\t", quoting=csv.QUOTE_NONE))


def sql_text(value: str | None) -> str:
    if value is None:
        return "NULL"
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--work", required=True)
    parser.add_argument("--out", required=True)
    parser.add_argument("--signals", required=True)
    args = parser.parse_args()
    w = args.work

    with open(f"{w}/classes.jsonl", encoding="utf-8") as handle:
        classes = {
            int(e["pieceId"]): e for e in (json.loads(line) for line in handle if line.strip())
        }
    with open(f"{w}/fame/sitelinks.json", encoding="utf-8") as handle:
        sitelinks: dict[str, int] = json.load(handle)["sitelinks"]
    recordings: dict[str, int] = {}
    if os.path.exists(f"{w}/fame/recordings.json"):
        with open(f"{w}/fame/recordings.json", encoding="utf-8") as handle:
            recordings = json.load(handle)
    with open(f"{w}/db/cmp_pieces.txt", encoding="utf-8") as handle:
        comparable = {int(line) for line in handle if line.strip()}

    info = {int(r["id"]): r for r in read_tsv(f"{w}/db/classify_input.tsv")}
    mbids: dict[int, list[str]] = {}
    for r in read_tsv(f"{w}/db/pieces.tsv"):
        mbids[int(r["id"])] = [
            m for m in (r["mbids"] if r["mbids"] != "NULL" else "").split(",") if m
        ]

    def piece_sl(piece_id: int) -> int:
        return max((sitelinks.get(m, 0) for m in mbids.get(piece_id, [])), default=0)

    # 작품 대표곡
    top = [pid for pid, r in info.items() if r["linked_from"] == "0"]
    by_composer: dict[int, list[int]] = defaultdict(list)
    for pid in top:
        by_composer[int(info[pid]["composer_id"])].append(pid)
    notable: set[int] = set()
    for pids in by_composer.values():
        scores = sorted(piece_sl(pid) for pid in pids)
        p90 = scores[int(0.9 * (len(scores) - 1))] if scores else 0
        groups: dict[tuple[str, str], list[int]] = defaultdict(list)
        for pid in pids:
            c = classes.get(pid, {})
            groups[(c.get("genre") or "other", c.get("formKey") or "")].append(pid)
        for members in groups.values():
            median = statistics.median(piece_sl(pid) for pid in members)
            relative_limit = max(1, round(0.2 * len(members)))
            picked, relative = 0, 0
            for pid in sorted(members, key=lambda x: (-piece_sl(x), x)):
                score = piece_sl(pid)
                if picked >= PIECE_GROUP_LIMIT or score < PIECE_SITELINKS_MIN:
                    break
                if score >= p90:
                    notable.add(pid)
                    picked += 1
                elif score >= 1.5 * median and relative < relative_limit:
                    notable.add(pid)
                    picked += 1
                    relative += 1
    notable |= {pid for pid in top if pid in comparable}

    # 세트 안 대표 곡(최상위 part)
    parts_by_set: dict[int, list[dict[str, str]]] = defaultdict(list)
    for r in read_tsv(f"{w}/db/parts_detail.tsv"):
        if r["parent"] == "0":
            parts_by_set[int(r["piece_id"])].append(r)
    notable_parts: set[int] = set()
    for parts in parts_by_set.values():

        def mbid(part: dict[str, str]) -> str:
            key = part["part_key"]
            return key.split(":", 1)[1] if key.startswith("musicbrainz:") else ""

        measured = [recordings[mbid(p)] for p in parts if mbid(p) in recordings]
        set_median = statistics.median(measured) if len(measured) >= 3 else None
        scored = []
        for part in parts:
            rec = recordings.get(mbid(part))
            sl = sitelinks.get(mbid(part), 0)
            by_recordings = (
                set_median is not None
                and set_median > 0
                and rec is not None
                and rec >= PART_RECORDING_RATIO * set_median
            )
            if by_recordings or sl >= PART_SITELINKS_MIN:
                scored.append(((rec or 0) / (set_median or 1) + sl / 10, int(part["id"])))
        for _, part_id in sorted(scored, reverse=True)[:PART_LIMIT]:
            notable_parts.add(part_id)
        notable_parts |= {int(p["id"]) for p in parts if p["linked_cmp"] == "1"}

    # SQL
    rows = sorted(classes.values(), key=lambda e: int(e["pieceId"]))
    lines = [
        "-- 작품 갈래·형식(규칙 분류)과 대표곡 표시를 채운다. 자료와 규칙은",
        "-- seed_pipeline/curation/piece-forms-2026-11-07/(classify.py, build_migration.py, signals/).",
        "-- 손으로 붙인 장르(비교 작품 257곡)는 그대로 두고, 사람이 고친 대표곡(notable_locked)도 그대로 둔다.",
        f"-- 작품 {len(rows)}곡 중 갈래 {sum(1 for e in rows if e['genre'])}곡, 대표곡 {len(notable)}곡,"
        f" 세트 안 대표 곡 {len(notable_parts)}곡. 두 번 넣어도 같다.",
        "",
        "CREATE TEMPORARY TABLE tmp_piece_class (",
        "    piece_id INT NOT NULL PRIMARY KEY,",
        "    genre VARCHAR(16) NULL,",
        "    form_key VARCHAR(32) NULL,",
        "    notable TINYINT(1) NOT NULL,",
        "    fame_score INT NULL",
        ");",
    ]
    for i in range(0, len(rows), 1000):
        values = ",\n".join(
            f"({e['pieceId']}, {sql_text(e['genre'])}, {sql_text(e['formKey'])}, {1 if int(e['pieceId']) in notable else 0}, {piece_sl(int(e['pieceId'])) or 'NULL'})"
            for e in rows[i : i + 1000]
        )
        lines.append(
            f"INSERT INTO tmp_piece_class (piece_id, genre, form_key, notable, fame_score) VALUES\n{values};"
        )
    lines += [
        "",
        "UPDATE pieces piece",
        "JOIN tmp_piece_class class ON class.piece_id = piece.id",
        "SET piece.genre = COALESCE(piece.genre, class.genre),",
        "    piece.form_key = class.form_key,",
        "    piece.notable = IF(piece.notable_locked = 1, piece.notable, class.notable),",
        "    piece.fame_score = class.fame_score;",
        "",
        "DROP TEMPORARY TABLE tmp_piece_class;",
        "",
        "CREATE TEMPORARY TABLE tmp_part_notable (part_id BIGINT UNSIGNED NOT NULL PRIMARY KEY);",
    ]
    part_ids = sorted(notable_parts)
    for i in range(0, len(part_ids), 1000):
        values = ", ".join(f"({pid})" for pid in part_ids[i : i + 1000])
        lines.append(f"INSERT INTO tmp_part_notable (part_id) VALUES {values};")
    lines += [
        "",
        "UPDATE piece_parts part",
        "LEFT JOIN tmp_part_notable picked ON picked.part_id = part.id",
        "SET part.notable = IF(picked.part_id IS NULL, 0, 1)",
        "WHERE part.notable_locked = 0",
        "  AND part.notable <> IF(picked.part_id IS NULL, 0, 1);",
        "",
        "DROP TEMPORARY TABLE tmp_part_notable;",
        "",
    ]
    with open(args.out, "w", encoding="utf-8") as handle:
        handle.write("\n".join(lines))

    os.makedirs(args.signals, exist_ok=True)
    with open(f"{args.signals}/piece_sitelinks.json", "w", encoding="utf-8") as handle:
        json.dump(
            {str(pid): piece_sl(pid) for pid in sorted(info) if piece_sl(pid) > 0}, handle, indent=0
        )
    with open(f"{args.signals}/part_recordings.json", "w", encoding="utf-8") as handle:
        json.dump(dict(sorted(recordings.items())), handle, indent=0)
    print(
        json.dumps(
            {
                "pieces": len(rows),
                "notable": len(notable),
                "notableParts": len(notable_parts),
                "recordingsMeasured": len(recordings),
            }
        )
    )


if __name__ == "__main__":
    main()
