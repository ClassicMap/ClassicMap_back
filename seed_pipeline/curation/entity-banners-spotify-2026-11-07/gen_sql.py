"""banners.jsonl 로 migrations/202611072005_fill_spotify_banners.sql 을 만든다.

한 줄 = 작곡가나 연주자 하나의 스포티파이 아티스트 머리 그림.
  kind: 'artist' | 'composer', id: 그 표의 id, name: 확인용 이름, spotifyId: 스포티파이 아티스트 id,
  url: i.scdn.co 그림 주소, width/height: 그림 크기, focal: CSS object-position('x% y%')
같은 사람에게 이미 배너(위키미디어)가 있으면 그건 대표에서 내리고 이 그림을 대표로 둔다.
작곡가이면서 연주자인 사람은 두 표가 같은 인물 기록을 쓰므로 같은 그림은 한 번만 들어간다.
"""
import json
import os
import re

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, '..', '..', '..', 'migrations', '202611072005_fill_spotify_banners.sql')
TABLES = {'artist': 'artists', 'composer': 'composers'}
FOCAL = re.compile(r'^\d{1,3}% \d{1,3}%$')
SPOTIFY_ID = re.compile(r'^[0-9A-Za-z]{22}$')
IMAGE = re.compile(r'^https://i\d?o?\.scdn\.co/image/[0-9a-f]{40}$|^https://image-cdn-[a-z]{2}\.spotifycdn\.com/image/[0-9a-f]{40}$')


def sql(value):
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


rows = [json.loads(line) for line in open(os.path.join(HERE, 'banners.jsonl'), encoding='utf-8') if line.strip()]
seen = set()
out = [
    '-- 작곡가·연주자 화면 머리 배너(스포티파이 아티스트 머리 그림). 원본: seed_pipeline/curation/entity-banners-spotify-2026-11-07/',
    '-- gen_sql.py 로 만든다. 출처는 스포티파이 아티스트 페이지로 밝히고, 권리자가 요청하면 RETIRED 로 내린다.',
]
for row in rows:
    kind, entity_id = row['kind'], int(row['id'])
    table = TABLES[kind]
    assert (kind, entity_id) not in seen, row
    seen.add((kind, entity_id))
    assert SPOTIFY_ID.match(row['spotifyId']), row
    assert IMAGE.match(row['url']), row
    assert FOCAL.match(row['focal']), row
    source = f"https://open.spotify.com/artist/{row['spotifyId']}"
    out.append(f"-- {kind} {entity_id} {row['name']}")
    out.append(
        f"UPDATE entity_images image JOIN {table} entity ON image.authority_entity_id = entity.authority_entity_id "
        f"SET image.is_primary = FALSE WHERE entity.id = {entity_id} AND image.image_kind = 'banner' AND image.file_url <> {sql(row['url'])};"
    )
    out.append(
        "INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)\n"
        f"SELECT entity.authority_entity_id, 'banner', {sql(source)}, {sql(row['url'])}, 'Spotify', {sql(row['focal'])}, TRUE, 'PUBLISHED'\n"
        f"FROM {table} entity WHERE entity.id = {entity_id} AND entity.authority_entity_id IS NOT NULL\n"
        # 작곡가이면서 연주자인 사람은 두 표가 같은 인물 기록을 쓴다. 같은 그림은 한 번만 넣는다
        f"  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = {sql(row['url'])});"
    )
open(OUT, 'w', encoding='utf-8').write('\n'.join(out) + '\n')
print('rows', len(rows), '->', os.path.relpath(OUT))
