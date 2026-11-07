"""banners.jsonl 로 migrations/202611082001_fill_more_entity_banners.sql 을 만든다.

스포티파이 머리 그림이 없는 작곡가·연주자에게 다른 곳의 배너를 넣는다. 한 줄 = 한 사람.
  kind: 'artist' | 'composer', id: 그 표의 id, name: 확인용 이름,
  source: 'apple_music' | 'youtube_music' | 'wikimedia',
  url: 그림 주소, width/height: 그림 크기, focal: CSS object-position('x% y%'),
  sourceUrl: 출처 페이지(애플 뮤직·유튜브 뮤직 아티스트 페이지, 위키미디어 파일 설명 페이지),
  author/license/licenseUrl: 위키미디어만. 저작자 표시 조건이라 화면에 그대로 보인다.
대상은 공개 배너가 아직 없는 사람만이다. 작곡가이면서 연주자인 사람은 같은 그림을 한 번만 넣는다.
"""
import json
import os
import re

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, '..', '..', '..', 'migrations', '202611082001_fill_more_entity_banners.sql')
TABLES = {'artist': 'artists', 'composer': 'composers'}
FOCAL = re.compile(r'^\d{1,3}% \d{1,3}%$')
SOURCES = {
    'apple_music': (
        re.compile(r'^https://is\d-ssl\.mzstatic\.com/image/thumb/[A-Za-z0-9/._-]+/\d{3,4}x\d{3,4}(sr|cc)\.webp$'),
        re.compile(r'^https://music\.apple\.com/us/artist/[^\s\']+/\d+$'),
        'Apple Music',
    ),
    'youtube_music': (
        re.compile(r'^https://(yt3|lh3)\.(googleusercontent|ggpht)\.com/[A-Za-z0-9_/-]+=w\d{3,4}-h\d{3,4}-p-l90-rj$'),
        re.compile(r'^https://music\.youtube\.com/channel/UC[A-Za-z0-9_-]{22}$'),
        'YouTube Music',
    ),
    'wikimedia': (
        re.compile(r'^https://upload\.wikimedia\.org/wikipedia/commons/[0-9a-f]/[0-9a-f]{2}/[^\s\']+$|^https://upload\.wikimedia\.org/wikipedia/commons/thumb/[0-9a-f]/[0-9a-f]{2}/[^\s\']+/(lossy-page1-)?\d+px-[^\s\']+\.(jpg|jpeg|png)$'),
        re.compile(r'^https://commons\.wikimedia\.org/wiki/File:[^\s]+$'),
        None,
    ),
}
FREE_LICENSE = re.compile(r'^(Public domain|CC0|CC BY(-SA)? \d\.\d( [a-z]{2})?|CC BY(-SA)?|Attribution)$')


def sql(value):
    if value is None:
        return 'NULL'
    return "'" + str(value).replace("\\", "\\\\").replace("'", "''") + "'"


rows = [json.loads(line) for line in open(os.path.join(HERE, 'banners.jsonl'), encoding='utf-8') if line.strip()]
seen = set()
out = [
    '-- 스포티파이 머리 그림이 없는 작곡가·연주자의 화면 머리 배너(애플 뮤직·유튜브 뮤직 아티스트 머리 그림, 위키미디어 공용).',
    '-- 원본: seed_pipeline/curation/entity-banners-more-2026-11-08/ (gen_sql.py 로 만든다).',
    '-- 출처 페이지를 함께 밝히고, 권리자가 요청하면 그 줄을 RETIRED 로 내린다.',
]
for row in rows:
    kind, entity_id = row['kind'], int(row['id'])
    table = TABLES[kind]
    assert (kind, entity_id) not in seen, row
    seen.add((kind, entity_id))
    image_re, source_re, credit = SOURCES[row['source']]
    assert image_re.match(row['url']), row
    assert source_re.match(row['sourceUrl']), row
    assert FOCAL.match(row['focal']), row
    author = license_name = license_url = None
    if row['source'] == 'wikimedia':
        assert FREE_LICENSE.match(row['license']), row
        author = (row.get('author') or '').strip()[:250] or None
        license_name = row['license']
        license_url = row.get('licenseUrl') or None
        # 지은이를 모르는 공유 저작물은 출처 이름이라도 보이게 한다
        credit = None if author else 'Wikimedia Commons'
    out.append(f"-- {kind} {entity_id} {row['name']} ({row['source']})")
    out.append(
        f"UPDATE entity_images image JOIN {table} entity ON image.authority_entity_id = entity.authority_entity_id "
        f"SET image.is_primary = FALSE WHERE entity.id = {entity_id} AND image.image_kind = 'banner' AND image.file_url <> {sql(row['url'])};"
    )
    out.append(
        "INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)\n"
        f"SELECT entity.authority_entity_id, 'banner', {sql(row['sourceUrl'])}, {sql(row['url'])}, {sql(credit)}, {sql(author)}, {sql(license_name)}, {sql(license_url)}, {sql(row['focal'])}, TRUE, 'PUBLISHED'\n"
        f"FROM {table} entity WHERE entity.id = {entity_id} AND entity.authority_entity_id IS NOT NULL\n"
        f"  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = {sql(row['url'])});"
    )
open(OUT, 'w', encoding='utf-8').write('\n'.join(out) + '\n')
print('rows', len(rows), '->', os.path.relpath(OUT))
