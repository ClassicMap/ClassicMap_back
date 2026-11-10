"""고른 그림 목록(jsonl)으로 마이그레이션 SQL 을 만든다.

- composer-faces.jsonl → 202611110101_fill_more_composer_faces.sql
  composers.avatar_url·cover_image_url 이 둘 다 비었을 때만 같은 주소로 채운다.
- artist-faces.jsonl → 202611110102_fill_artist_faces.sql
  artists.image_url 이 비었을 때만 채운다(기존 연주자 얼굴과 같은 칸).
- artist-banners.jsonl → 202611110103_fill_a_artist_banners.sql
  공개 배너가 하나도 없을 때만 entity_images 'banner' 를 넣는다.

얼굴 그림은 출처를 entity_images 'profile'(PUBLISHED) 에 남긴다.
위키미디어 자유 라이선스는 지은이·라이선스를, 그 밖의 그림(애플 뮤직·스포티파이·공식 사이트·
출판사·뉴스 등)은 credit_line 에 출처 이름, source_url 에 출처 페이지를 남긴다.
권리자가 요청하면 얼굴 칸을 비우거나 배너를 RETIRED 로 내린다.

사용: uv run python curation/entity-images-2-2026-11-11/gen_sql.py
"""

from __future__ import annotations

import json
import re
from pathlib import Path
from typing import Any

HERE = Path(__file__).resolve().parent
MIGRATIONS = HERE.parents[2] / "migrations"
FOCAL = re.compile(r"^\d{1,3}% \d{1,3}%$")
HTTPS = re.compile(r"^https://[^\s']+$")
FREE_LICENSE = re.compile(
    r"^(Public domain|CC0|No restrictions|Attribution|CC BY(-SA)? \d\.\d( [a-z]{2})?)$"
)
# composers.avatar_url·cover_image_url, artists.image_url 이 VARCHAR(500) 이다
FACE_MAX = 500


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


def credit_of(row: dict[str, Any]) -> tuple[str | None, str | None, str | None, str | None]:
    """(credit_line, author, license, license_url)"""
    assert HTTPS.match(row["url"]) and HTTPS.match(row["sourceUrl"]), row
    if row["kind"] == "wikimedia":
        assert FREE_LICENSE.match(row["license"]), row
        author = (row.get("author") or "").strip()[:250] or None
        return (
            (None if author else "Wikimedia Commons"),
            author,
            row["license"],
            row.get("licenseUrl"),
        )
    assert row["creditLine"].strip(), row
    return row["creditLine"], None, None, None


def profile_insert(table: str, column: str, row: dict[str, Any]) -> str:
    url = row["url"]
    credit, author, license_name, license_url = credit_of(row)
    return (
        "INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, "
        "author, license, license_url, credit_line, is_primary, editorial_status)\n"
        f"SELECT entity.authority_entity_id, 'profile', {sql(row['sourceUrl'])}, {sql(url)}, "
        f"{sql(author)}, {sql(license_name)}, {sql(license_url)}, {sql(credit)}, "
        "TRUE, 'PUBLISHED'\n"
        f"FROM {table} entity WHERE entity.id = {int(row['id'])} "
        f"AND entity.authority_entity_id IS NOT NULL AND entity.{column} = {sql(url)}\n"
        "  AND NOT EXISTS (SELECT 1 FROM entity_images existing "
        "WHERE existing.authority_entity_id = entity.authority_entity_id "
        f"AND existing.file_url = {sql(url)});"
    )


def composer_faces(rows: list[dict[str, Any]]) -> list[str]:
    out = [
        "-- 얼굴 그림이 없던 숨기지 않은 작곡가의 얼굴 그림"
        "(위키미디어·출판사·공식 사이트·뉴스 등).",
        "-- 원본: seed_pipeline/curation/entity-images-2-2026-11-11/ (gen_sql.py 로 만든다).",
        "-- 초상·커버가 둘 다 비었을 때만 채우고, 출처는 entity_images 'profile' 에 남긴다.",
    ]
    for row in rows:
        url = row["url"]
        assert len(url) <= FACE_MAX, row
        out.append(
            f"-- composer {row['id']} {row['name']} ({row.get('creditLine') or row['kind']})"
        )
        out.append(
            f"UPDATE composers SET avatar_url = {sql(url)}, cover_image_url = {sql(url)}\n"
            f"WHERE id = {int(row['id'])} AND english_name = {sql(row['englishName'])}\n"
            f"  AND {blank('avatar_url')} AND {blank('cover_image_url')};"
        )
        out.append(profile_insert("composers", "avatar_url", row))
    return out


def artist_faces(rows: list[dict[str, Any]]) -> list[str]:
    out = [
        "-- 얼굴 그림이 없던 A·B 연주자의 얼굴 그림"
        "(애플 뮤직·스포티파이·위키미디어·공식 사이트 등).",
        "-- 원본: seed_pipeline/curation/entity-images-2-2026-11-11/ (gen_sql.py 로 만든다).",
        "-- image_url 이 비었을 때만 채우고, 출처는 entity_images 'profile' 에 남긴다.",
    ]
    for row in rows:
        url = row["url"]
        assert len(url) <= FACE_MAX, row
        out.append(f"-- artist {row['id']} {row['name']} ({row.get('creditLine') or row['kind']})")
        out.append(
            f"UPDATE artists SET image_url = {sql(url)}\n"
            f"WHERE id = {int(row['id'])} AND english_name = {sql(row['englishName'])} "
            f"AND {blank('image_url')};"
        )
        out.append(profile_insert("artists", "image_url", row))
    return out


def artist_banners(rows: list[dict[str, Any]]) -> list[str]:
    out = [
        "-- 공개 배너가 없던 A 연주자의 화면 머리 배너(공식 사이트·대행사·공연장·뉴스 등).",
        "-- 원본: seed_pipeline/curation/entity-images-2-2026-11-11/ (gen_sql.py 로 만든다).",
        "-- 공개 배너가 하나도 없을 때만 넣는다. 권리자가 요청하면 그 줄을 RETIRED 로 내린다.",
    ]
    for row in rows:
        url = row["url"]
        credit, author, license_name, license_url = credit_of(row)
        assert FOCAL.match(row["focal"]), row
        artist_id = int(row["id"])
        out.append(f"-- artist {artist_id} {row['name']} ({credit or author})")
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


def main() -> None:
    plans = (
        ("composer-faces.jsonl", "202611110101_fill_more_composer_faces.sql", composer_faces),
        ("artist-faces.jsonl", "202611110102_fill_artist_faces.sql", artist_faces),
        ("artist-banners.jsonl", "202611110103_fill_a_artist_banners.sql", artist_banners),
    )
    for source, migration, build in plans:
        rows = load(source)
        ids = [int(row["id"]) for row in rows]
        assert len(ids) == len(set(ids)), source
        if rows:
            (MIGRATIONS / migration).write_text("\n".join(build(rows)) + "\n", encoding="utf-8")
            print("rows", len(rows), "->", migration)


if __name__ == "__main__":
    main()
