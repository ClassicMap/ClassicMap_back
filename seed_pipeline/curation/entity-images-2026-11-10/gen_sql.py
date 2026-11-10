"""고른 그림 목록(jsonl)으로 마이그레이션 SQL 을 만든다.

- composer-portraits.jsonl → 202611100101_fill_composer_portraits.sql
  위키미디어 공용 초상. composers.avatar_url·cover_image_url 이 둘 다 비었을 때만 채우고,
  지은이·라이선스는 entity_images('profile', PUBLISHED)에 남긴다.
- composer-portraits-services.jsonl → 202611100102_fill_composer_portraits_from_services.sql
  공용에 쓸 초상이 없던 작곡가의 애플 뮤직·스포티파이 아티스트 그림. 같은 빈칸 조건으로 채운다.
- artist-banners.jsonl → 202611100103_fill_artist_banners.sql
  S·A 연주자 화면 머리 배너(스포티파이·애플 뮤직). 공개 배너가 하나도 없을 때만 넣는다.

같은 사람(작곡가이면서 연주자)이 두 표에 있으면 같은 인물 기록을 쓰므로
같은 그림은 한 번만 들어간다.
사용: uv run python curation/entity-images-2026-11-10/gen_sql.py
"""

from __future__ import annotations

import json
import re
from pathlib import Path
from typing import Any

HERE = Path(__file__).resolve().parent
MIGRATIONS = HERE.parents[2] / "migrations"
FOCAL = re.compile(r"^\d{1,3}% \d{1,3}%$")
WIKIMEDIA_FILE = re.compile(
    r"^https://upload\.wikimedia\.org/wikipedia/commons/[0-9a-f]/[0-9a-f]{2}/[^\s']+$"
    r"|^https://upload\.wikimedia\.org/wikipedia/commons/thumb/[0-9a-f]/[0-9a-f]{2}/[^\s']+"
    r"/(lossy-page1-)?\d+px-[^\s']+\.(jpg|jpeg|png)$"
)
WIKIMEDIA_PAGE = re.compile(r"^https://commons\.wikimedia\.org/wiki/File:[^\s]+$")
APPLE_IMAGE = re.compile(
    r"^https://is\d-ssl\.mzstatic\.com/image/thumb/[A-Za-z0-9/._-]+/\d{3,4}x\d{3,4}(bb|cc|sr)\.(jpg|webp)$"
)
APPLE_PAGE = re.compile(r"^https://music\.apple\.com/us/artist/([^\s'/]+/)?\d+$")
SPOTIFY_IMAGE = re.compile(
    r"^https://(i\d?o?\.scdn\.co|image-cdn-[a-z]{2}\.spotifycdn\.com)/image/[0-9a-f]{40}$"
)
SPOTIFY_PAGE = re.compile(r"^https://open\.spotify\.com/artist/[0-9A-Za-z]{22}$")
FREE_LICENSE = re.compile(
    r"^(Public domain|CC0|No restrictions|Attribution|CC BY(-SA)? \d\.\d( [a-z]{2})?)$"
)
# composers.avatar_url·cover_image_url 이 VARCHAR(500) 이다
AVATAR_MAX = 500


def sql(value: object) -> str:
    if value is None:
        return "NULL"
    text = str(value).replace("\\", "\\\\").replace("'", "''")
    return f"'{text}'"


def load(name: str) -> list[dict[str, Any]]:
    path = HERE / name
    if not path.exists():
        return []
    with path.open(encoding="utf-8") as handle:
        return [json.loads(line) for line in handle if line.strip()]


def blank(column: str) -> str:
    return f"({column} IS NULL OR {column} = '')"


def portrait_update(row: dict[str, Any]) -> str:
    url = row["url"]
    assert len(url) <= AVATAR_MAX, row
    return (
        f"UPDATE composers SET avatar_url = {sql(url)}, cover_image_url = {sql(url)}\n"
        f"WHERE id = {int(row['id'])} AND english_name = {sql(row['englishName'])}\n"
        f"  AND {blank('avatar_url')} AND {blank('cover_image_url')};"
    )


def wikimedia_portraits(rows: list[dict[str, Any]]) -> list[str]:
    out = [
        "-- 얼굴 그림이 없던 숨기지 않은 작곡가의 초상(위키미디어 공용, 자유 라이선스).",
        "-- 원본: seed_pipeline/curation/entity-images-2026-11-10/ (gen_sql.py 로 만든다).",
        "-- 초상·커버가 둘 다 비었을 때만 채우고, "
        "지은이·라이선스는 entity_images 'profile' 에 남긴다.",
        "-- 시드가 남긴 Special:FilePath 행(REVIEW_REQUIRED)은 그대로 둔다.",
    ]
    for row in rows:
        url = row["url"]
        assert row["source"] == "wikimedia", row
        assert WIKIMEDIA_FILE.match(url), row
        assert WIKIMEDIA_PAGE.match(row["sourceUrl"]), row
        assert FREE_LICENSE.match(row["license"]), row
        author = (row.get("author") or "").strip()[:250] or None
        # 지은이를 모르는 공유 저작물은 출처 이름이라도 보이게 한다
        credit = None if author else "Wikimedia Commons"
        out.append(f"-- composer {row['id']} {row['name']} ({row['via']})")
        out.append(portrait_update(row))
        out.append(
            "INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, "
            "author, license, license_url, credit_line, is_primary, editorial_status)\n"
            f"SELECT composer.authority_entity_id, 'profile', {sql(row['sourceUrl'])}, {sql(url)}, "
            f"{sql(author)}, {sql(row['license'])}, {sql(row.get('licenseUrl'))}, {sql(credit)}, "
            "TRUE, 'PUBLISHED'\n"
            f"FROM composers composer WHERE composer.id = {int(row['id'])} "
            f"AND composer.authority_entity_id IS NOT NULL AND composer.avatar_url = {sql(url)}\n"
            "  AND NOT EXISTS (SELECT 1 FROM entity_images existing "
            "WHERE existing.authority_entity_id = composer.authority_entity_id "
            f"AND existing.file_url = {sql(url)});"
        )
    return out


def check_service(row: dict[str, Any]) -> None:
    if row["source"] == "spotify":
        assert SPOTIFY_IMAGE.match(row["url"]), row
        assert SPOTIFY_PAGE.match(row["sourceUrl"]), row
    else:
        assert row["source"] == "apple_music", row
        assert APPLE_IMAGE.match(row["url"]), row
        assert APPLE_PAGE.match(row["sourceUrl"]), row


def service_portraits(rows: list[dict[str, Any]]) -> list[str]:
    out = [
        "-- 공용에 쓸 초상이 없던 작곡가의 얼굴 그림(애플 뮤직·스포티파이 아티스트 그림).",
        "-- 원본: seed_pipeline/curation/entity-images-2026-11-10/ (gen_sql.py 로 만든다).",
        "-- 초상·커버가 둘 다 비었을 때만 채운다. 그림은 각 서비스 서버를 그대로 가리킨다.",
        "-- 권리자가 요청하면 그 작곡가의 avatar_url·cover_image_url 을 비운다.",
    ]
    for row in rows:
        check_service(row)
        out.append(f"-- composer {row['id']} {row['name']} ({row['sourceUrl']})")
        out.append(portrait_update(row))
    return out


def artist_banners(rows: list[dict[str, Any]]) -> list[str]:
    out = [
        "-- 공개 배너가 없던 S·A 연주자의 화면 머리 배너"
        "(스포티파이·애플 뮤직 아티스트 머리 그림, 위키미디어 공용).",
        "-- 원본: seed_pipeline/curation/entity-images-2026-11-10/ (gen_sql.py 로 만든다).",
        "-- 공개 배너가 하나도 없을 때만 넣는다. 출처 페이지를 함께 밝히고, "
        "권리자가 요청하면 그 줄을 RETIRED 로 내린다.",
    ]
    credits = {"spotify": "Spotify", "apple_music": "Apple Music"}
    for row in rows:
        url = row["url"]
        author = license_name = license_url = None
        if row["source"] == "wikimedia":
            assert WIKIMEDIA_FILE.match(url), row
            assert WIKIMEDIA_PAGE.match(row["sourceUrl"]), row
            assert FREE_LICENSE.match(row["license"]), row
            author = (row.get("author") or "").strip()[:250] or None
            license_name, license_url = row["license"], row.get("licenseUrl")
            # 지은이를 모르는 공유 저작물은 출처 이름이라도 보이게 한다
            credit = None if author else "Wikimedia Commons"
        else:
            check_service(row)
            credit = credits[row["source"]]
        assert FOCAL.match(row["focal"]), row
        artist_id = int(row["id"])
        out.append(f"-- artist {artist_id} {row['name']} ({row['source']})")
        out.append(
            "INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, "
            "credit_line, author, license, license_url, focal_point, is_primary, "
            "editorial_status)\n"
            f"SELECT artist.authority_entity_id, 'banner', {sql(row['sourceUrl'])}, {sql(url)}, "
            f"{sql(credit)}, {sql(author)}, {sql(license_name)}, {sql(license_url)}, "
            f"{sql(row['focal'])}, TRUE, 'PUBLISHED'\n"
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
    return out


def write(name: str, lines: list[str], count: int) -> None:
    if count == 0:
        return
    (MIGRATIONS / name).write_text("\n".join(lines) + "\n", encoding="utf-8")
    print("rows", count, "->", name)


def main() -> None:
    seen: set[tuple[str, int]] = set()
    plans = (
        (
            "composer-portraits.jsonl",
            "202611100101_fill_composer_portraits.sql",
            wikimedia_portraits,
        ),
        (
            "composer-portraits-services.jsonl",
            "202611100102_fill_composer_portraits_from_services.sql",
            service_portraits,
        ),
        ("artist-banners.jsonl", "202611100103_fill_artist_banners.sql", artist_banners),
    )
    for source, migration, build in plans:
        rows = load(source)
        for row in rows:
            key = ("artist" if source.startswith("artist") else "composer", int(row["id"]))
            assert key not in seen, row
            seen.add(key)
        write(migration, build(rows), len(rows))


if __name__ == "__main__":
    main()
