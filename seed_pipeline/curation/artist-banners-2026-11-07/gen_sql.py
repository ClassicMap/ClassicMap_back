"""banners.jsonl → 배너 데이터 마이그레이션 SQL.

    python3 gen_sql.py > ../../../migrations/202611072004_fill_artist_banners.sql

- 얼굴이 거의 안 보여 검토에서 뺀 연주자(EXCLUDED)는 넣지 않는다.
- 원본이 TIFF 처럼 브라우저가 못 그리는 파일은 위키미디어가 만든 JPG 미리보기(upload.wikimedia.org 쪽)를 쓴다.
  이미지 프록시는 upload.wikimedia.org 만 허용한다.
"""
import json
import pathlib

HERE = pathlib.Path(__file__).parent
# 2026-11-07 검토에서 뺀 연주자: 아르헤리치(머리카락이 얼굴을 가림), 프레빈(뒷모습), 레비트(고개 숙임),
# 아믈랭(어색한 옆얼굴·나무), 마이스키(지휘자가 더 크게 나옴)
EXCLUDED = {204, 634, 249, 253, 216}
WEB_SAFE = ('.jpg', '.jpeg', '.png', '.webp', '.gif')


def sql(value):
    if value is None or value == '':
        return 'NULL'
    return "'" + str(value).replace('\\', '\\\\').replace("'", "''") + "'"


def file_url(row):
    if row['fileUrl'].lower().endswith(WEB_SAFE):
        return row['fileUrl']
    return row['displayUrl'].replace('https://thumb.wikimedia.org/', 'https://upload.wikimedia.org/', 1)


rows = [json.loads(line) for line in (HERE / 'banners.jsonl').read_text(encoding='utf-8').splitlines() if line.strip()]
print('-- 아티스트 화면 머리 배너(위키미디어 공용, 자유 라이선스). 원본: seed_pipeline/curation/artist-banners-2026-11-07/')
print('-- gen_sql.py 로 만든다. 연주자당 하나, 대표·공개로 넣는다.')
for row in rows:
    if row['artistId'] in EXCLUDED:
        continue
    print(
        'INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, '
        'focal_point, is_primary, editorial_status)\n'
        f"SELECT artist.authority_entity_id, 'banner', {sql(row['sourceUrl'])}, {sql(file_url(row))}, {sql(row.get('author'))}, "
        f"{sql(row.get('license'))}, {sql(row.get('licenseUrl'))}, {sql(row.get('focalPoint'))}, TRUE, 'PUBLISHED'\n"
        f"FROM artists artist WHERE artist.id = {int(row['artistId'])} AND artist.authority_entity_id IS NOT NULL;"
    )
