"""앨범 고르기 결과(picks)로 작품 링크 마이그레이션과 match.py 입력(parts tsv)을 만든다.

작품 링크:
- 작품 트랙이 곡 수 이상 든 앨범(exact·more)만 쓴다. 'kept'(지금 링크가 맞음)는 건드리지 않는다.
- 지금 빈칸이면 빈칸일 때만 채우고, 지금 링크가 있으면 그 값과 같을 때만 바꾼다
  (그사이 사람이 고쳤으면 그대로).
곡 링크(parts tsv):
- 위 앨범과 'kept' 앨범, 그리고 일부만 든 앨범(partial) 중 앨범 이름이 「작곡가: …」 꼴인 것.
  편집 음반(여러 작곡가 모음)에 한두 곡만 든 경우는 뺀다.
- --existing 을 주면 작품 tsv 에 없는(이번에 손대지 않는) 작품의 지금 앨범 링크도 넣는다.
사용: uv run python build_links.py apple|spotify picks.jsonl all_parts.tsv out_dir \
      마이그레이션.sql 원본폴더 <작품 tsv...>
"""

from __future__ import annotations

import csv
import json
import os
import re
import sys
import unicodedata
from typing import Any

COLUMN = {"apple": "apple_music_url", "spotify": "spotify_url"}
SERVICE = {"apple": "Apple Music", "spotify": "Spotify"}


def plain(text: str) -> str:
    text = unicodedata.normalize("NFKD", text)
    return "".join(c for c in text if not unicodedata.combining(c)).lower()


def surname_of(name: str) -> str:
    parts = re.sub(r"[^a-z ]", " ", plain(name)).split()
    return parts[-1] if parts else ""


def album_id(url: str) -> str | None:
    m = re.search(r"/album/(?:[^/?]+/)?([A-Za-z0-9]+)(?:\?.*)?$", url)
    return m.group(1) if m else None


def sql_text(value: str) -> str:
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def main() -> None:
    service, picks_path, parts_path, out_dir, migration, source_dir, *piece_tsvs = sys.argv[1:]
    existing = "--existing" in piece_tsvs
    piece_tsvs = [path for path in piece_tsvs if path != "--existing"]
    column = COLUMN[service]
    composer_of: dict[int, str] = {}
    for path in piece_tsvs:
        with open(path, encoding="utf-8") as handle:
            for row in csv.DictReader(handle, delimiter="\t"):
                composer_of.setdefault(int(row["piece_id"]), row["composer_en"])
    with open(picks_path, encoding="utf-8") as handle:
        picks = [json.loads(line) for line in handle if line.strip()]

    pieces: list[dict[str, Any]] = []
    part_album: dict[int, str] = {}
    counts: dict[str, int] = {}
    for item in picks:
        piece_id = int(item["pieceId"])
        status = item["status"]
        current = str(item.get("current") or "").strip()
        new = str(item["albumUrl"]).strip()
        if status in ("exact", "more"):
            part_album[piece_id] = new
            if current == new or ("?" not in current and album_id(current) == album_id(new)):
                action = "same"
            else:
                action = "fill" if not current else "replace"
                pieces.append(
                    {
                        "pieceId": piece_id,
                        "old": current or None,
                        "url": new,
                        "status": status,
                        "album": item.get("albumName", ""),
                        "action": action,
                    }
                )
        elif status == "kept":
            part_album[piece_id] = current
            action = "kept"
        else:
            surname = surname_of(composer_of.get(piece_id, ""))
            name = plain(str(item.get("albumName", "")))
            head = name.split(":", 1)[0] if ":" in name else ""
            if surname and surname in head and len(head) <= 40:
                part_album[piece_id] = new
                action = "parts_only"
            else:
                action = "dropped"
        counts[action] = counts.get(action, 0) + 1

    with open(os.path.join(out_dir, f"{service}_pieces.jsonl"), "w", encoding="utf-8") as handle:
        for piece in pieces:
            handle.write(json.dumps(piece, ensure_ascii=False) + "\n")

    with open(parts_path, encoding="utf-8") as handle:
        reader = csv.DictReader(handle, delimiter="\t")
        fields = list(reader.fieldnames or [])
        every = list(reader)
    if existing:
        # 이번 목록(빈칸·틀린 링크)에 없는 작품의 지금 앨범 링크도 다시 맞춰 본다(새 규칙 몫)
        for row in every:
            piece_id = int(row["piece_id"])
            url = row[column].strip()
            known = piece_id in composer_of or piece_id in part_album
            if not known and album_id(url) and "?" not in url:
                part_album[piece_id] = url
                counts["existing"] = counts.get("existing", 0) + 1
    rows = [r for r in every if int(r["piece_id"]) in part_album]
    for row in rows:
        row[column] = part_album[int(row["piece_id"])]
    with open(
        os.path.join(out_dir, f"{service}_parts.tsv"), "w", encoding="utf-8", newline=""
    ) as handle:
        writer = csv.DictWriter(handle, fieldnames=fields, delimiter="\t", lineterminator="\n")
        writer.writeheader()
        writer.writerows(rows)

    fills = sum(1 for p in pieces if p["action"] == "fill")
    replaces = len(pieces) - fills
    temp = f"tmp_piece_{service}"
    values = ",\n".join(
        f"({p['pieceId']}, {sql_text(p['old']) if p['old'] else 'NULL'}, {sql_text(p['url'])})"
        for p in pieces
    )
    sql = [
        f"-- 작품에 {SERVICE[service]} 앨범 링크를 채우고, 틀린 링크를 바꾼다. 자료와 규칙은",
        f"-- seed_pipeline/curation/{source_dir}/.",
        "-- 앨범 고르는 법: 트랙 이름에 작품번호(없으면 제목 구절)와 제목 낱말이 있고,",
        "-- 앨범·아티스트에 작곡가 성이 있으며, 그런 트랙이 작품의 곡 수 이상인 앨범.",
        "-- 검색 1위 앨범을 그냥 쓰지 않는다.",
        f"-- 빈칸을 채운 작품 {fills}개, 바꾼 작품 {replaces}개",
        "-- (바꾼 것: 지금 링크의 앨범에 작품 트랙이 곡 수만큼 없거나, 링크가 트랙 하나인 것).",
        "-- 빈칸은 빈칸일 때만, 바꿈은 지금 값이 그때 본 값과 같을 때만 쓴다. 두 번 넣어도 같다.",
        "",
        f"CREATE TEMPORARY TABLE {temp} (",
        "    piece_id INT NOT NULL PRIMARY KEY,",
        "    old_url VARCHAR(500) NULL,",
        "    url VARCHAR(500) NOT NULL",
        ");",
    ]
    if pieces:
        sql.append(f"INSERT INTO {temp} (piece_id, old_url, url) VALUES\n{values};")
    sql += [
        "",
        "UPDATE pieces piece",
        f"JOIN {temp} link ON link.piece_id = piece.id",
        f"SET piece.{column} = link.url",
        f"WHERE (link.old_url IS NULL AND (piece.{column} IS NULL OR piece.{column} = ''))",
        f"    OR piece.{column} = link.old_url;",
        "",
        f"DROP TEMPORARY TABLE {temp};",
        "",
    ]
    with open(migration, "w", encoding="utf-8") as handle:
        handle.write("\n".join(sql))
    print(
        json.dumps(
            {
                "actions": counts,
                "pieceUpdates": len(pieces),
                "fill": fills,
                "replace": replaces,
                "partSets": len(part_album),
                "partRows": len(rows),
            },
            ensure_ascii=False,
        )
    )


if __name__ == "__main__":
    main()
