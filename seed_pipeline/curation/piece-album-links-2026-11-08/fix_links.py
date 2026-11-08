"""이미 넣은 링크(앞 결과)를 규칙을 고친 뒤의 결과(새 결과)로 바로잡는 마이그레이션을 만든다.

작품 링크는 build_links.py 의 `{service}_pieces.jsonl`, 곡 링크는 match.py 의 matches jsonl 을
앞뒤로 견준다. 작품마다 「앞 결과를 넣은 뒤의 값」과 「새 결과를 넣었을 때의 값」이 다르면 바꾼다.
새 결과에 없으면 원래 값(작품 tsv 의 current_url, 곡은 빈칸)으로 돌린다.
바꿀 때는 지금 값이 앞 결과의 값과 같을 때만 쓴다(그사이 사람이 고쳤으면 그대로).

사용: uv run python fix_links.py apple|spotify <작품 tsv> <앞 pieces> <새 pieces> \
      <앞 matches> <새 matches> <바뀐 것 jsonl> <마이그레이션.sql> <원본 폴더>
"""

from __future__ import annotations

import csv
import json
import sys
from typing import Any

COLUMN = {"apple": "apple_music_url", "spotify": "spotify_url"}
SERVICE = {"apple": "Apple Music", "spotify": "Spotify"}


def read_jsonl(path: str) -> list[dict[str, Any]]:
    with open(path, encoding="utf-8") as handle:
        return [json.loads(line) for line in handle if line.strip()]


def sql_text(value: str | None) -> str:
    if not value:
        return "NULL"
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def main() -> None:
    service, sets_path, old_pieces, new_pieces, old_parts, new_parts = sys.argv[1:7]
    out_path, migration, source = sys.argv[7:10]
    column = COLUMN[service]
    original: dict[int, str] = {}
    with open(sets_path, encoding="utf-8") as handle:
        for row in csv.DictReader(handle, delimiter="\t"):
            original[int(row["piece_id"])] = (row.get("current_url") or "").strip()
    before = {int(p["pieceId"]): str(p["url"]) for p in read_jsonl(old_pieces)}
    after = {int(p["pieceId"]): str(p["url"]) for p in read_jsonl(new_pieces)}
    piece_fixes: list[dict[str, Any]] = []
    for piece_id in sorted(set(before) | set(after)):
        old = before.get(piece_id, original.get(piece_id, ""))
        new = after.get(piece_id, original.get(piece_id, ""))
        if old != new:
            piece_fixes.append({"kind": "piece", "id": piece_id, "old": old or None,
                                "url": new or None})

    old_match = {int(m["partId"]): m for m in read_jsonl(old_parts)}
    new_match = {int(m["partId"]): m for m in read_jsonl(new_parts)}
    part_fixes: list[dict[str, Any]] = []
    for part_id in sorted(set(old_match) | set(new_match)):
        was, now = old_match.get(part_id), new_match.get(part_id)
        old_url = str(was["url"]) if was else None
        new_url = str(now["url"]) if now else None
        if old_url != new_url:
            base = was or now or {}
            part_fixes.append({
                "kind": "part", "id": part_id, "pieceId": int(base["pieceId"]),
                "seq": int(base["seq"]), "part": base.get("part"), "old": old_url, "url": new_url,
                "oldTrack": was["track"] if was else None, "track": now["track"] if now else None,
            })

    with open(out_path, "w", encoding="utf-8") as handle:
        for fix in piece_fixes + part_fixes:
            handle.write(json.dumps(fix, ensure_ascii=False) + "\n")

    def values(fixes: list[dict[str, Any]]) -> str:
        return ",\n".join(
            f"({fix['id']}, {sql_text(fix['old'])}, {sql_text(fix['url'])})" for fix in fixes
        )

    part_values = ",\n".join(
        f"({fix['id']}, {fix['pieceId']}, {fix['seq']}, {sql_text(fix['old'])}, "
        f"{sql_text(fix['url'])})"
        for fix in part_fixes
    )

    cleared = sum(1 for fix in piece_fixes if fix["url"] is None)
    removed = sum(1 for fix in part_fixes if fix["url"] is None)
    added = sum(1 for fix in part_fixes if fix["old"] is None)
    sql = [
        f"-- 앞서 넣은 {SERVICE[service]} 작품·곡 링크를 고친 규칙으로 다시 고른 결과에 맞춘다.",
        f"-- 자료: seed_pipeline/curation/{source}/. 고친 규칙: 발췌·하이라이트 음반,",
        "-- 재즈 편곡·태교·수면용 음반, 다른 작곡가 작품번호(HWV·BWV·RV 등)가 붙은 트랙,",
        "-- 연주자 이름에 걸린 작곡가 성, 두 작품 앨범에서 다른 작품 트랙만 받은 경우를 거른다.",
        f"-- 작품 {len(piece_fixes)}곳(그중 비움 {cleared}곳), "
        f"곡 {len(part_fixes)}곡(새로 붙임 {added}곡, 뺌 {removed}곡).",
        "-- 지금 값이 앞서 넣은 값과 같을 때만 쓴다. 두 번 넣어도 같다.",
        "",
        f"CREATE TEMPORARY TABLE tmp_fix_piece_{service} (",
        "    piece_id INT NOT NULL PRIMARY KEY,",
        "    old_url VARCHAR(500) NULL,",
        "    url VARCHAR(500) NULL",
        ");",
    ]
    if piece_fixes:
        sql.append(f"INSERT INTO tmp_fix_piece_{service} (piece_id, old_url, url) VALUES\n"
                   f"{values(piece_fixes)};")
    sql += [
        "",
        "UPDATE pieces piece",
        f"JOIN tmp_fix_piece_{service} link ON link.piece_id = piece.id",
        f"SET piece.{column} = link.url",
        f"WHERE (link.old_url IS NULL AND (piece.{column} IS NULL OR piece.{column} = ''))",
        f"    OR piece.{column} = link.old_url;",
        "",
        f"DROP TEMPORARY TABLE tmp_fix_piece_{service};",
        "",
        f"CREATE TEMPORARY TABLE tmp_fix_part_{service} (",
        "    part_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,",
        "    piece_id INT NOT NULL,",
        "    sequence_number INT NOT NULL,",
        "    old_url VARCHAR(500) NULL,",
        "    url VARCHAR(500) NULL",
        ");",
    ]
    if part_fixes:
        sql.append(
            f"INSERT INTO tmp_fix_part_{service} "
            f"(part_id, piece_id, sequence_number, old_url, url) VALUES\n{part_values};"
        )
    sql += [
        "",
        "UPDATE piece_parts part",
        f"JOIN tmp_fix_part_{service} link",
        "    ON link.part_id = part.id",
        "    AND link.piece_id = part.piece_id",
        "    AND link.sequence_number = part.sequence_number",
        f"SET part.{column} = link.url",
        "WHERE part.parent_part_id IS NULL",
        f"    AND ((link.old_url IS NULL AND (part.{column} IS NULL OR part.{column} = ''))",
        f"        OR part.{column} = link.old_url);",
        "",
        f"DROP TEMPORARY TABLE tmp_fix_part_{service};",
        "",
    ]
    with open(migration, "w", encoding="utf-8") as handle:
        handle.write("\n".join(sql))
    print(json.dumps({"pieces": len(piece_fixes), "cleared": cleared, "parts": len(part_fixes),
                      "added": added, "removed": removed}))


if __name__ == "__main__":
    main()
