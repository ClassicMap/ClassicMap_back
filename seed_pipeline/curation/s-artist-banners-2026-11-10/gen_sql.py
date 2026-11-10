"""s-artist-banners.jsonl 로 migrations/202611100104_fill_s_artist_banners.sql 을 만든다.

한 줄 = 배너가 없던 S 연주자 한 명의 화면 머리 배너. 공식 사이트·음반사·대행사·공연장 페이지의
보도용 사진이라 자유 라이선스가 아니다. credit_line 에 출처 이름, source_url 에 그 페이지를 남겨
권리자가 요청하면 그 줄을 RETIRED 로 내린다. 공개 배너가 하나도 없을 때만 넣는다.

사용: uv run python curation/s-artist-banners-2026-11-10/gen_sql.py
"""

from __future__ import annotations

import json
import re
from pathlib import Path
from typing import Any

HERE = Path(__file__).resolve().parent
OUT = HERE.parents[2] / "migrations" / "202611100104_fill_s_artist_banners.sql"
FOCAL = re.compile(r"^\d{1,3}% \d{1,3}%$")
HTTPS = re.compile(r"^https://[^\s']+$")


def sql(value: object) -> str:
    if value is None:
        return "NULL"
    text = str(value).replace("\\", "\\\\").replace("'", "''")
    return f"'{text}'"


def main() -> None:
    with (HERE / "s-artist-banners.jsonl").open(encoding="utf-8") as handle:
        rows: list[dict[str, Any]] = [json.loads(line) for line in handle if line.strip()]
    out = [
        "-- 배너가 없던 S 연주자의 화면 머리 배너"
        "(공식 사이트·음반사·대행사·공연장 페이지의 보도용 사진).",
        "-- 원본: seed_pipeline/curation/s-artist-banners-2026-11-10/ (gen_sql.py 로 만든다).",
        "-- 자유 라이선스가 아니다. credit_line 에 출처 이름, source_url 에 출처 페이지를 남기고,",
        "-- 권리자가 요청하면 그 줄을 RETIRED 로 내린다. 공개 배너가 하나도 없을 때만 넣는다.",
    ]
    seen: set[int] = set()
    for row in rows:
        artist_id = int(row["id"])
        assert artist_id not in seen, row
        seen.add(artist_id)
        url = row["url"]
        assert HTTPS.match(url) and HTTPS.match(row["sourceUrl"]), row
        assert FOCAL.match(row["focal"]), row
        assert row["creditLine"].strip(), row
        out.append(f"-- artist {artist_id} {row['name']} ({row['creditLine']})")
        out.append(
            "INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, "
            "credit_line, focal_point, is_primary, editorial_status)\n"
            f"SELECT artist.authority_entity_id, 'banner', {sql(row['sourceUrl'])}, {sql(url)}, "
            f"{sql(row['creditLine'])}, {sql(row['focal'])}, TRUE, 'PUBLISHED'\n"
            f"FROM artists artist WHERE artist.id = {artist_id} "
            f"AND artist.english_name = {sql(row['englishName'])} "
            "AND artist.authority_entity_id IS NOT NULL\n"
            "  AND NOT EXISTS (SELECT 1 FROM entity_images existing "
            "WHERE existing.authority_entity_id = artist.authority_entity_id "
            "AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')\n"
            "  AND NOT EXISTS (SELECT 1 FROM entity_images existing "
            "WHERE existing.authority_entity_id = artist.authority_entity_id "
            f"AND existing.file_url = {sql(url)});"
        )
    OUT.write_text("\n".join(out) + "\n", encoding="utf-8")
    print("rows", len(rows), "->", OUT.name)


if __name__ == "__main__":
    main()
