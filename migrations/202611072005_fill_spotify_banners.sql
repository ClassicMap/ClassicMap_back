-- 작곡가·연주자 화면 머리 배너(스포티파이 아티스트 머리 그림). 원본: seed_pipeline/curation/entity-banners-spotify-2026-11-07/
-- gen_sql.py 로 만든다. 출처는 스포티파이 아티스트 페이지로 밝히고, 권리자가 요청하면 RETIRED 로 내린다.
-- artist 186 조성진
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 186 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab14a2861b54fdcc741ffc86cff';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1p0J5PXJQMVqk5uVV4T1ja', 'https://i.scdn.co/image/ab6761860000eab14a2861b54fdcc741ffc86cff', 'Spotify', '0% 25%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 186 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab14a2861b54fdcc741ffc86cff');
-- artist 187 임윤찬
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 187 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab11b88ee86f67724d08fce5a5f';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2bISdi2DpR6ApPu2Tkxlyz', 'https://i.scdn.co/image/ab6761860000eab11b88ee86f67724d08fce5a5f', 'Spotify', '50% 55%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 187 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab11b88ee86f67724d08fce5a5f');
-- artist 189 손열음
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 189 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab190f12eb1f470848f5fd2b8ac';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2QBjNinkTc5i8PLOYYlHsl', 'https://i.scdn.co/image/ab6761860000eab190f12eb1f470848f5fd2b8ac', 'Spotify', '0% 33%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 189 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab190f12eb1f470848f5fd2b8ac');
-- artist 190 김봄소리
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 190 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1f45a15dec81d7d55e6ba55bb';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6eg0Lhwxk31hrFEAXfpCd1', 'https://i.scdn.co/image/ab6761860000eab1f45a15dec81d7d55e6ba55bb', 'Spotify', '50% 45%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 190 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1f45a15dec81d7d55e6ba55bb');
-- artist 200 랑랑
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 200 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1630cc3870aacc34139c6b187';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1YZhNFBxkEB5UKTgMDvot4', 'https://i.scdn.co/image/ab6761860000eab1630cc3870aacc34139c6b187', 'Spotify', '70% 1%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 200 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1630cc3870aacc34139c6b187');
-- artist 201 유자 왕
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 201 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1aa07043de00f5a299f0bc8ab';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/7HUNjWo242UAVHZvj9zk4w', 'https://i.scdn.co/image/ab6761860000eab1aa07043de00f5a299f0bc8ab', 'Spotify', '49% 77%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 201 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1aa07043de00f5a299f0bc8ab');
-- artist 202 다닐 트리포노프
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 202 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1f647a9e003def353f7924065';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1fUhTALoWXPL6PZSkKImY9', 'https://i.scdn.co/image/ab6761860000eab1f647a9e003def353f7924065', 'Spotify', '81% 20%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 202 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1f647a9e003def353f7924065');
-- artist 203 예핌 브론프만
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 203 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab163d053082c65e9ed719965b0';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1LMUcg4F3Uv0qeeJXw56uT', 'https://i.scdn.co/image/ab6761860000eab163d053082c65e9ed719965b0', 'Spotify', '53% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 203 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab163d053082c65e9ed719965b0');
-- artist 204 마르타 아르헤리치
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 204 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab11fbac105e408d406b05eeab3';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/66MvLAvLznk5UOvASVGjk4', 'https://i.scdn.co/image/ab6761860000eab11fbac105e408d406b05eeab3', 'Spotify', '47% 0%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 204 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab11fbac105e408d406b05eeab3');
-- artist 205 그리고리 소콜로프
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 205 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab172350f0ad0d6f6ddd885bbac';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6ChLWj2mIxKtKa2pNifotH', 'https://i.scdn.co/image/ab6761860000eab172350f0ad0d6f6ddd885bbac', 'Spotify', '32% 69%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 205 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab172350f0ad0d6f6ddd885bbac');
-- artist 206 예브게니 키신
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 206 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab15e96cb1450dfa44744e64fb5';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/71kYWgqr6eHLOZj6u3JTuJ', 'https://i.scdn.co/image/ab6761860000eab15e96cb1450dfa44744e64fb5', 'Spotify', '18% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 206 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab15e96cb1450dfa44744e64fb5');
-- artist 207 마우리치오 폴리니
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 207 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab173f2281d121e1997d341b83e';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2VIdKQmRHnWofsR4odfFOh', 'https://i.scdn.co/image/ab6761860000eab173f2281d121e1997d341b83e', 'Spotify', '58% 82%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 207 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab173f2281d121e1997d341b83e');
-- artist 208 안드라시 쉬프
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 208 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1d58858fe6aea63f4c6a7be2b';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/24K6LTZFqBAvKsorwK0iXd', 'https://i.scdn.co/image/ab6761860000eab1d58858fe6aea63f4c6a7be2b', 'Spotify', '20% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 208 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1d58858fe6aea63f4c6a7be2b');
-- artist 210 조슈아 벨
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 210 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1fb7bd02f43d287bd766533a4';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3Ka1nDpDzxDveEqUPzIeom', 'https://i.scdn.co/image/ab6761860000eab1fb7bd02f43d287bd766533a4', 'Spotify', '11% 34%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 210 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1fb7bd02f43d287bd766533a4');
-- artist 211 안네 소피 무터
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 211 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab18d68d367f4ada87e08bb98fb';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6pzfUmBsQAKxOhy0NSi8zn', 'https://i.scdn.co/image/ab6761860000eab18d68d367f4ada87e08bb98fb', 'Spotify', '62% 0%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 211 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab18d68d367f4ada87e08bb98fb');
-- artist 212 야닌 얀센
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 212 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1c946731956bb972a3c0e3c30';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/00hfOKuZEhvKKNXmVdb1We', 'https://i.scdn.co/image/ab6761860000eab1c946731956bb972a3c0e3c30', 'Spotify', '14% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 212 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1c946731956bb972a3c0e3c30');
-- artist 215 요요 마
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 215 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1795e60b4a0f64ee5ea0fd7f9';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5Dl3HXZjG6ZOWT5cV375lk', 'https://i.scdn.co/image/ab6761860000eab1795e60b4a0f64ee5ea0fd7f9', 'Spotify', '52% 2%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 215 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1795e60b4a0f64ee5ea0fd7f9');
-- artist 216 미샤 마이스키
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 216 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1f5b5ac2cd1e98e28703cc7b5';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6rlVhQqS15yJMO4DZqrq6I', 'https://i.scdn.co/image/ab6761860000eab1f5b5ac2cd1e98e28703cc7b5', 'Spotify', '53% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 216 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1f5b5ac2cd1e98e28703cc7b5');
-- artist 218 구스타보 두다멜
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 218 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab188134430cfcda9e0b6fa03b9';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0cxXnDhpgxcMMkKddhORHY', 'https://i.scdn.co/image/ab6761860000eab188134430cfcda9e0b6fa03b9', 'Spotify', '24% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 218 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab188134430cfcda9e0b6fa03b9');
-- artist 219 야닉 네제 세갱
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 219 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab18690443e6f92902e99308191';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5ZGyCOrODWwaVtLSDjayl5', 'https://i.scdn.co/image/ab6761860000eab18690443e6f92902e99308191', 'Spotify', '58% 43%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 219 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab18690443e6f92902e99308191');
-- artist 220 사이먼 래틀
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 220 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1ffbd364a10af574c9ea88e87';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4GQwgdcDQwqtcHICjUNndp', 'https://i.scdn.co/image/ab6761860000eab1ffbd364a10af574c9ea88e87', 'Spotify', '43% 93%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 220 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1ffbd364a10af574c9ea88e87');
-- artist 223 보리스 길트부르그
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 223 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1d65fe2c8edfd0a61fdcb9c98';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6DJ974Gf11OtDblQklBHPX', 'https://i.scdn.co/image/ab6761860000eab1d65fe2c8edfd0a61fdcb9c98', 'Spotify', '1% 52%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 223 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1d65fe2c8edfd0a61fdcb9c98');
-- artist 227 츠지이 노부유키
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 227 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1f83352231f581bad72177408';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5JvADyrajwcXaAeqxyDg5j', 'https://i.scdn.co/image/ab6761860000eab1f83352231f581bad72177408', 'Spotify', '74% 100%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 227 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1f83352231f581bad72177408');
-- artist 228 브루스 리우
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 228 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab14101459a6bf0efc5c37129ed';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3GMPZX0AZo90KkPjFpgPT9', 'https://i.scdn.co/image/ab6761860000eab14101459a6bf0efc5c37129ed', 'Spotify', '73% 34%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 228 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab14101459a6bf0efc5c37129ed');
-- artist 234 정경화
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 234 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1aea4c542f2ffc02584b7884f';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0LtGkeRp03UAHQZNKrQ4XC', 'https://i.scdn.co/image/ab6761860000eab1aea4c542f2ffc02584b7884f', 'Spotify', '50% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 234 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1aea4c542f2ffc02584b7884f');
-- artist 235 정명훈
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 235 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab18da7a295faa33243cecbdcd1';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4hdiwtmc6OEFFxpSlwwmby', 'https://i.scdn.co/image/ab6761860000eab18da7a295faa33243cecbdcd1', 'Spotify', '44% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 235 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab18da7a295faa33243cecbdcd1');
-- artist 249 이고르 레비트
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 249 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1ef31ad9e32364e0e9a9110b6';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0japPUWMmW3gxqjSB1VEVL', 'https://i.scdn.co/image/ab6761860000eab1ef31ad9e32364e0e9a9110b6', 'Spotify', '48% 9%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 249 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1ef31ad9e32364e0e9a9110b6');
-- artist 250 머레이 페라이아
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 250 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1d1ba0c06ffc1ed5a3af20483';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4EEQIAJoeN1V30MqFFtXxB', 'https://i.scdn.co/image/ab6761860000eab1d1ba0c06ffc1ed5a3af20483', 'Spotify', '49% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 250 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1d1ba0c06ffc1ed5a3af20483');
-- artist 252 라두 루푸
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 252 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1e0de5793cf6c2bc04b7af053';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2BoWH2w47EUxEiOuvl4mxF', 'https://i.scdn.co/image/ab6761860000eab1e0de5793cf6c2bc04b7af053', 'Spotify', '23% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 252 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1e0de5793cf6c2bc04b7af053');
-- artist 253 마르크 앙드레 아멜린
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 253 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1b311fc3b72a8580de0839321';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0pm0LWiklLtNXUP2GVwdqY', 'https://i.scdn.co/image/ab6761860000eab1b311fc3b72a8580de0839321', 'Spotify', '48% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 253 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1b311fc3b72a8580de0839321');
-- artist 255 알렉산드르 멜니코프
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 255 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab165d4748f9adea30f48b0ba50';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/7vk7vgVoYDiZ4Kngc3Jgta', 'https://i.scdn.co/image/ab6761860000eab165d4748f9adea30f48b0ba50', 'Spotify', '65% 100%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 255 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab165d4748f9adea30f48b0ba50');
-- artist 256 비킹구르 올라프손
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 256 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab18161a4eac9c30f7f2b8e4d45';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0iqgjl0OG3z53PZVIB7ZyD', 'https://i.scdn.co/image/ab6761860000eab18161a4eac9c30f7f2b8e4d45', 'Spotify', '36% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 256 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab18161a4eac9c30f7f2b8e4d45');
-- artist 257 얀 리시에츠키
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 257 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1a8d0ee7e2a69fd3f228ff9a6';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0iZW6hAah0wPk6gOZCGcmy', 'https://i.scdn.co/image/ab6761860000eab1a8d0ee7e2a69fd3f228ff9a6', 'Spotify', '47% 37%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 257 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1a8d0ee7e2a69fd3f228ff9a6');
-- artist 261 스티븐 허프
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 261 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1f3ea4ae79fa1d7d7364465b3';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3G5zQYaRH9y6ruE4QnoITP', 'https://i.scdn.co/image/ab6761860000eab1f3ea4ae79fa1d7d7364465b3', 'Spotify', '73% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 261 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1f3ea4ae79fa1d7d7364465b3');
-- artist 266 미도리
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 266 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab181015bf805af41f4fe84fda8';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2xPfYsn4P2vH7eI6ADyFB7', 'https://i.scdn.co/image/ab6761860000eab181015bf805af41f4fe84fda8', 'Spotify', '51% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 266 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab181015bf805af41f4fe84fda8');
-- artist 267 이츠하크 펄만
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 267 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab16ec6de474cc4b141ab1680c2';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0hIG9FXgjQxT8fKaYceFbA', 'https://i.scdn.co/image/ab6761860000eab16ec6de474cc4b141ab1680c2', 'Spotify', '7% 75%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 267 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab16ec6de474cc4b141ab1680c2');
-- artist 277 고티에 카푸송
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 277 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab199c603fcb19d283240eb3d5c';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/57ziOSBD3x0PhVbl7MXTgI', 'https://i.scdn.co/image/ab6761860000eab199c603fcb19d283240eb3d5c', 'Spotify', '60% 30%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 277 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab199c603fcb19d283240eb3d5c');
-- artist 278 알반 게르하르트
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 278 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1f0ce6f65d49595fd81e22217';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2vKos77CK7cddxsAKLo8uS', 'https://i.scdn.co/image/ab6761860000eab1f0ce6f65d49595fd81e22217', 'Spotify', '49% 47%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 278 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1f0ce6f65d49595fd81e22217');
-- artist 279 셰쿠 카네 메이슨
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 279 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1f04cb1333d3c5b78b674c3c0';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6OTr0YwLwGdv7mlmX27hRX', 'https://i.scdn.co/image/ab6761860000eab1f04cb1333d3c5b78b674c3c0', 'Spotify', '55% 5%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 279 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1f04cb1333d3c5b78b674c3c0');
-- artist 282 트룰스 뫼르크
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 282 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab192e43cf18783894f346e43a3';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2ookZjNsAvPdiaGWn86ub1', 'https://i.scdn.co/image/ab6761860000eab192e43cf18783894f346e43a3', 'Spotify', '26% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 282 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab192e43cf18783894f346e43a3');
-- artist 285 크리스티안 틸레만
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 285 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1c95217beb7d1cf145c113fe9';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5c2dloAaXR2qRbIVh2C0jD', 'https://i.scdn.co/image/ab6761860000eab1c95217beb7d1cf145c113fe9', 'Spotify', '56% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 285 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1c95217beb7d1cf145c113fe9');
-- artist 286 안토니오 파파노
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 286 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1ab4c5d2e997cb93729ca30fa';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0xHw5qPRSEc8sUmSmXf5sw', 'https://i.scdn.co/image/ab6761860000eab1ab4c5d2e997cb93729ca30fa', 'Spotify', '19% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 286 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1ab4c5d2e997cb93729ca30fa');
-- artist 287 이반 피셔
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 287 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab15d2105c2865d1dee53201764';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4fwcEh4tMsyFvKvO8w7DKO', 'https://i.scdn.co/image/ab6761860000eab15d2105c2865d1dee53201764', 'Spotify', '46% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 287 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab15d2105c2865d1dee53201764');
-- artist 288 마리스 얀손스
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 288 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab15d85d010525ce1d8b2d61071';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0IuqAyi5CMgpuyhckrcqNs', 'https://i.scdn.co/image/ab6761860000eab15d85d010525ce1d8b2d61071', 'Spotify', '64% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 288 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab15d85d010525ce1d8b2d61071');
-- artist 290 리카르도 샤이
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 290 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1a54606bb45489a17d274772a';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4Kjr1MPMUfuH3QKXtAljNy', 'https://i.scdn.co/image/ab6761860000eab1a54606bb45489a17d274772a', 'Spotify', '54% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 290 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1a54606bb45489a17d274772a');
-- artist 293 안드리스 넬손스
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 293 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1c269b995f3df99e7549a1f81';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6fkV4LaygxybcMjo4cJLrI', 'https://i.scdn.co/image/ab6761860000eab1c269b995f3df99e7549a1f81', 'Spotify', '52% 80%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 293 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1c269b995f3df99e7549a1f81');
-- artist 297 사비네 드비엘헤
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 297 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1d1456aab0208945ba531b567';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4f0pCOjszoLjd2Tr4SmUjH', 'https://i.scdn.co/image/ab6761860000eab1d1456aab0208945ba531b567', 'Spotify', '80% 60%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 297 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1d1456aab0208945ba531b567');
-- artist 300 요나스 카우프만
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 300 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1fa6cc4fbc7b600514ff14dcd';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2OHnFY58Dg8c2SC2PtootB', 'https://i.scdn.co/image/ab6761860000eab1fa6cc4fbc7b600514ff14dcd', 'Spotify', '64% 10%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 300 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1fa6cc4fbc7b600514ff14dcd');
-- artist 301 후안 디에고 플로레스
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 301 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab12c881c6709970571053d9754';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6Yxfl63ymAk7MkN8TP10iT', 'https://i.scdn.co/image/ab6761860000eab12c881c6709970571053d9754', 'Spotify', '32% 83%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 301 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab12c881c6709970571053d9754');
-- artist 302 피오트르 베차와
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 302 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1123a51beaa68656e581bf5fe';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2TMEwrUmFfQ5KUOXEDa3Jz', 'https://i.scdn.co/image/ab6761860000eab1123a51beaa68656e581bf5fe', 'Spotify', '57% 53%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 302 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1123a51beaa68656e581bf5fe');
-- artist 304 하비에르 카마레나
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 304 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1d8df69f5760f4126cb11b316';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/13rDolPZ1xlUWBQWxl8cED', 'https://i.scdn.co/image/ab6761860000eab1d8df69f5760f4126cb11b316', 'Spotify', '54% 64%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 304 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1d8df69f5760f4126cb11b316');
-- artist 305 엠마누엘 파위
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 305 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1117b9d4917e8f96193db5fa6';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6duaKoFWgzQNgHlfmn3dHq', 'https://i.scdn.co/image/ab6761860000eab1117b9d4917e8f96193db5fa6', 'Spotify', '81% 4%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 305 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1117b9d4917e8f96193db5fa6');
-- artist 308 마르틴 프뢰스트
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 308 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1d35a4563a992908182b5f21a';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3HmzM7c3S5iM1jBG3gl0FF', 'https://i.scdn.co/image/ab6761860000eab1d35a4563a992908182b5f21a', 'Spotify', '70% 34%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 308 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1d35a4563a992908182b5f21a');
-- artist 309 자비네 마이어
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 309 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1c032d9e62bfe2aab5ac501cb';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6kuAjH8jM4yaKQhZekTUgL', 'https://i.scdn.co/image/ab6761860000eab1c032d9e62bfe2aab5ac501cb', 'Spotify', '38% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 309 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1c032d9e62bfe2aab5ac501cb');
-- artist 311 베아트리체 라나
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 311 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1c36aef8338dffcf705e50475';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0dy2MCCdtamIXLSncTg9SP', 'https://i.scdn.co/image/ab6761860000eab1c36aef8338dffcf705e50475', 'Spotify', '49% 44%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 311 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1c36aef8338dffcf705e50475');
-- artist 312 하오첸 장
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 312 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1665575128810c0f7027ebb06';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0b3ZSapWLLxfYoLNM2uqs4', 'https://i.scdn.co/image/ab6761860000eab1665575128810c0f7027ebb06', 'Spotify', '52% 29%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 312 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1665575128810c0f7027ebb06');
-- artist 316 에릭 루
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 316 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1c08333428e09d30feac3cc1c';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2v2GiBMOpS1N1HfAhSZOVC', 'https://i.scdn.co/image/ab6761860000eab1c08333428e09d30feac3cc1c', 'Spotify', '52% 67%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 316 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1c08333428e09d30feac3cc1c');
-- artist 366 크리스티안 짐머만
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 366 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1bb22c130818b3e796bf47af6';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/43wuPaPcZVMJQWLRaPR4Yz', 'https://i.scdn.co/image/ab6761860000eab1bb22c130818b3e796bf47af6', 'Spotify', '47% 73%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 366 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1bb22c130818b3e796bf47af6');
-- artist 367 블라디미르 호로비츠
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 367 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1c1cba081eb8727fe284f2076';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4Ws5hSoABAwvGJ4LhHwHgq', 'https://i.scdn.co/image/ab6761860000eab1c1cba081eb8727fe284f2076', 'Spotify', '62% 72%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 367 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1c1cba081eb8727fe284f2076');
-- artist 370 블라디미르 아슈케나지
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 370 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1cf80795683466c37c8568d45';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/20iZXzMb8LoWXOeca32i82', 'https://i.scdn.co/image/ab6761860000eab1cf80795683466c37c8568d45', 'Spotify', '47% 100%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 370 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1cf80795683466c37c8568d45');
-- artist 371 레이프 오베 안스네스
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 371 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab11629a7dfe999ae0e440e3e5c';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/7J9Fo9dMjGNYY8usNMietL', 'https://i.scdn.co/image/ab6761860000eab11629a7dfe999ae0e440e3e5c', 'Spotify', '60% 59%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 371 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab11629a7dfe999ae0e440e3e5c');
-- artist 399 마리아 조앙 피레스
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 399 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1c29022362450be5107daf6a5';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1hRLlo7ZGxEmc0ztMOKurs', 'https://i.scdn.co/image/ab6761860000eab1c29022362450be5107daf6a5', 'Spotify', '60% 78%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 399 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1c29022362450be5107daf6a5');
-- artist 422 헤르베르트 폰 카라얀
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 422 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1ce9cf67f69c0b9908df8ed18';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5zCaQxjl110XTrm4LQ1CxY', 'https://i.scdn.co/image/ab6761860000eab1ce9cf67f69c0b9908df8ed18', 'Spotify', '44% 40%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 422 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1ce9cf67f69c0b9908df8ed18');
-- artist 427 리카르도 무티
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 427 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab16c84588a90fdf38a559ac89a';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/7silW8RiEOoLBgAg5JBCL1', 'https://i.scdn.co/image/ab6761860000eab16c84588a90fdf38a559ac89a', 'Spotify', '100% 15%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 427 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab16c84588a90fdf38a559ac89a');
-- artist 503 Tim Mead
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 503 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab133ca4966be9772c20f5c641a';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6JiH3j5nKt1zqHgGpeZ94P', 'https://i.scdn.co/image/ab6761860000eab133ca4966be9772c20f5c641a', 'Spotify', '75% 78%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 503 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab133ca4966be9772c20f5c641a');
-- artist 541 안젤라 휴이트
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 541 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1bbe2b42f1cfdce4ac645e54e';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3KtQFp8FUbQMx3bLNKCw3R', 'https://i.scdn.co/image/ab6761860000eab1bbe2b42f1cfdce4ac645e54e', 'Spotify', '32% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 541 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1bbe2b42f1cfdce4ac645e54e');
-- artist 546 비토리오 그리골로
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 546 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab14a71f0943f2528a8386fc2a1';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4g5uYNR1bRD4Tju6fIuBRC', 'https://i.scdn.co/image/ab6761860000eab14a71f0943f2528a8386fc2a1', 'Spotify', '97% 75%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 546 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab14a71f0943f2528a8386fc2a1');
-- artist 563 파스칼 로제
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 563 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab123066d075c23e5eb89827136';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5X5cGjYEmKnuihYXEePQcs', 'https://i.scdn.co/image/ab6761860000eab123066d075c23e5eb89827136', 'Spotify', '58% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 563 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab123066d075c23e5eb89827136');
-- artist 564 카티아 부니아티슈빌리
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 564 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab16887989c86401af909427d5c';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0bouHpX4JiuPnIfP2jFxRi', 'https://i.scdn.co/image/ab6761860000eab16887989c86401af909427d5c', 'Spotify', '54% 56%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 564 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab16887989c86401af909427d5c');
-- artist 565 니콜라이 루간스키
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 565 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1d17b321caf64c5c9cfdfb4b2';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2bMfnyPOgNaeK8WNnXNXud', 'https://i.scdn.co/image/ab6761860000eab1d17b321caf64c5c9cfdfb4b2', 'Spotify', '53% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 565 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1d17b321caf64c5c9cfdfb4b2');
-- artist 566 다비드 프레
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 566 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab18b58829ea451598e0f2ad910';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6ngR3n1aQ7GLB5w46hqSWR', 'https://i.scdn.co/image/ab6761860000eab18b58829ea451598e0f2ad910', 'Spotify', '89% 71%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 566 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab18b58829ea451598e0f2ad910');
-- artist 567 발렌티나 리시차
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 567 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab11ef39aae0980866a9910fc36';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0gOrXuu1vCBXe3pwTyb5Ca', 'https://i.scdn.co/image/ab6761860000eab11ef39aae0980866a9910fc36', 'Spotify', '60% 54%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 567 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab11ef39aae0980866a9910fc36');
-- artist 568 윤디 리
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 568 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1f42b7b68ec04ecc4520e11d2';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1T6BHJnhY5xIVvZKzV5f2u', 'https://i.scdn.co/image/ab6761860000eab1f42b7b68ec04ecc4520e11d2', 'Spotify', '51% 84%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 568 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1f42b7b68ec04ecc4520e11d2');
-- artist 569 알리스 사라 오트
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 569 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab119a092bc9df1125ef46a049e';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0d6alfZHUx3xoRnPjkTL7Q', 'https://i.scdn.co/image/ab6761860000eab119a092bc9df1125ef46a049e', 'Spotify', '67% 63%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 569 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab119a092bc9df1125ef46a049e');
-- artist 570 알도 치콜리니
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 570 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab116154188224c6ac97b7553ec';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/7bFDJIIDPq0Gn5vI7Ce34f', 'https://i.scdn.co/image/ab6761860000eab116154188224c6ac97b7553ec', 'Spotify', '85% 91%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 570 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab116154188224c6ac97b7553ec');
-- artist 571 메나헴 프레슬러
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 571 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1f299859c7c02bf233786f085';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2TMN4gxer8gkLcA7zLwBr0', 'https://i.scdn.co/image/ab6761860000eab1f299859c7c02bf233786f085', 'Spotify', '53% 87%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 571 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1f299859c7c02bf233786f085');
-- artist 572 올가 셰프스
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 572 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1936c9952acf1254fe598f3e9';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/07Nqz7k5QdR10iuTJkd6Mp', 'https://i.scdn.co/image/ab6761860000eab1936c9952acf1254fe598f3e9', 'Spotify', '52% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 572 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1936c9952acf1254fe598f3e9');
-- artist 573 장이브 티보데
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 573 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1b4b9acfa0c6f1d92a4c43f98';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1Dot4uMsJMx8n1Xi7gAdV6', 'https://i.scdn.co/image/ab6761860000eab1b4b9acfa0c6f1d92a4c43f98', 'Spotify', '12% 0%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 573 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1b4b9acfa0c6f1d92a4c43f98');
-- artist 575 오자와 세이지
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 575 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1813d62183b65a6eadbbe1f70';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0atCvjK2GL6ezQFGOQOYQo', 'https://i.scdn.co/image/ab6761860000eab1813d62183b65a6eadbbe1f70', 'Spotify', '64% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 575 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1813d62183b65a6eadbbe1f70');
-- artist 576 백건우
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 576 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab11a75ba07960e5a72170cd87d';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/22B1T23YzVRPPQkvN6AjSX', 'https://i.scdn.co/image/ab6761860000eab11a75ba07960e5a72170cd87d', 'Spotify', '81% 2%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 576 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab11a75ba07960e5a72170cd87d');
-- artist 577 네빌 마리너
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 577 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1c914eb11004f37fb3775819f';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6NUhQz7eAEsZvjEHTKHux9', 'https://i.scdn.co/image/ab6761860000eab1c914eb11004f37fb3775819f', 'Spotify', '27% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 577 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1c914eb11004f37fb3775819f');
-- artist 583 파보 예르비
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 583 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab15a668be948ec3ac94dde702e';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3V9McxlPI0G2RmkU0DhYGO', 'https://i.scdn.co/image/ab6761860000eab15a668be948ec3ac94dde702e', 'Spotify', '34% 22%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 583 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab15a668be948ec3ac94dde702e');
-- artist 584 스미노 하야토
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 584 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1f04092d3f60e1290b729c1ea';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1jVpYW7JYxh4mWzrFVjipz', 'https://i.scdn.co/image/ab6761860000eab1f04092d3f60e1290b729c1ea', 'Spotify', '100% 82%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 584 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1f04092d3f60e1290b729c1ea');
-- artist 590 윈턴 마샐리스
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 590 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab14b04d8f49733fff23c6e4b7c';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/375zxMmh2cSgUzFFnva0O7', 'https://i.scdn.co/image/ab6761860000eab14b04d8f49733fff23c6e4b7c', 'Spotify', '8% 57%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 590 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab14b04d8f49733fff23c6e4b7c');
-- artist 594 클라우디오 아바도
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 594 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1dc90c7950bad250b1aa5ce15';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6HclTVD03WSY6GUpN16BkP', 'https://i.scdn.co/image/ab6761860000eab1dc90c7950bad250b1aa5ce15', 'Spotify', '50% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 594 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1dc90c7950bad250b1aa5ce15');
-- artist 600 벤 골드샤이더
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 600 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1c69c3819bc3231569fa6344c';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/7c3QzID3RgkdaHgcEO0YNY', 'https://i.scdn.co/image/ab6761860000eab1c69c3819bc3231569fa6344c', 'Spotify', '72% 6%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 600 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1c69c3819bc3231569fa6344c');
-- artist 603 존 엘리엇 가디너
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 603 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab154adc937818286d089e02449';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1qIRoGEKXINqrCx5N1engi', 'https://i.scdn.co/image/ab6761860000eab154adc937818286d089e02449', 'Spotify', '51% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 603 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab154adc937818286d089e02449');
-- artist 605 레너드 번스타인
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 605 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1b2049520c4b995df4245ce4a';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2LmyJyCF5V1eQyvHgJNbTn', 'https://i.scdn.co/image/ab6761860000eab1b2049520c4b995df4245ce4a', 'Spotify', '41% 20%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 605 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1b2049520c4b995df4245ce4a');
-- artist 607 에머슨 현악 4중주단
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 607 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab14e28d81d62dc958a02ff9dee';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4IBl8k6ZsBagsI5zRjyXH7', 'https://i.scdn.co/image/ab6761860000eab14e28d81d62dc958a02ff9dee', 'Spotify', '30% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 607 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab14e28d81d62dc958a02ff9dee');
-- artist 608 세인트로렌스 현악 4중주단
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 608 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab12ab524e936091496c74cd843';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/58YsnduEdytXyJYLELXpJk', 'https://i.scdn.co/image/ab6761860000eab12ab524e936091496c74cd843', 'Spotify', '62% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 608 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab12ab524e936091496c74cd843');
-- artist 614 엘리자베트 레온스카야
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 614 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1de2c89226ec7805e8e9e7b65';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3i67VvAwUlOKZa3fc75zs8', 'https://i.scdn.co/image/ab6761860000eab1de2c89226ec7805e8e9e7b65', 'Spotify', '48% 100%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 614 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1de2c89226ec7805e8e9e7b65');
-- artist 622 앤드루 리턴
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 622 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1fd5ef269c534b600654284f7';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6YVQX2N8puDVWKE1StJVqn', 'https://i.scdn.co/image/ab6761860000eab1fd5ef269c534b600654284f7', 'Spotify', '57% 47%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 622 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1fd5ef269c534b600654284f7');
-- artist 627 잔안드레아 노세다
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 627 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1861c601e326271e92040e8a6';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4ZfhELUmrY86zwcJHY2q19', 'https://i.scdn.co/image/ab6761860000eab1861c601e326271e92040e8a6', 'Spotify', '45% 0%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 627 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1861c601e326271e92040e8a6');
-- artist 628 제임스 콘론
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 628 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1d215bbc0636dc59c93ff4f30';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5dCokwmhQtMw1dxLg3ka2x', 'https://i.scdn.co/image/ab6761860000eab1d215bbc0636dc59c93ff4f30', 'Spotify', '61% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 628 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1d215bbc0636dc59c93ff4f30');
-- artist 629 콜린 데이비스
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 629 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab13e103338683b9f8343dc0d63';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0TrG2LSot4KhaXqdf5K2zE', 'https://i.scdn.co/image/ab6761860000eab13e103338683b9f8343dc0d63', 'Spotify', '63% 68%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 629 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab13e103338683b9f8343dc0d63');
-- artist 630 마이클 틸슨 토머스
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 630 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1218412b374a77716361af57b';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2v1lHgfpG4joXW7kDdDI78', 'https://i.scdn.co/image/ab6761860000eab1218412b374a77716361af57b', 'Spotify', '50% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 630 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1218412b374a77716361af57b');
-- artist 632 다니엘 바렌보임
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 632 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab18fada6a7e9af73dc60ab8fd9';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/78sEozQOEJxzXegUuqRSgH', 'https://i.scdn.co/image/ab6761860000eab18fada6a7e9af73dc60ab8fd9', 'Spotify', '52% 46%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 632 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab18fada6a7e9af73dc60ab8fd9');
-- artist 634 앙드레 프레빈
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 634 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1f9c4aa08cf0b3f5f842c6af7';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2tfWguHr2nj4e8KXLKciVq', 'https://i.scdn.co/image/ab6761860000eab1f9c4aa08cf0b3f5f842c6af7', 'Spotify', '27% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 634 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1f9c4aa08cf0b3f5f842c6af7');
-- artist 636 데이비드 진먼
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 636 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab16f3ed523ce876832f4913517';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2J7jiJ5cdLieortTaN6yMT', 'https://i.scdn.co/image/ab6761860000eab16f3ed523ce876832f4913517', 'Spotify', '58% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 636 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab16f3ed523ce876832f4913517');
-- artist 642 알반 베르크 4중주단
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 642 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab14debd08982c5497c542d0484';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/39bcPlnQijRpADa2yk6SGS', 'https://i.scdn.co/image/ab6761860000eab14debd08982c5497c542d0484', 'Spotify', '7% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 642 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab14debd08982c5497c542d0484');
-- artist 647 제러미 뎅크
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 647 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1e9766684e22958c297a0cb24';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6aMKh0D0j5K7z1ECYRHvJP', 'https://i.scdn.co/image/ab6761860000eab1e9766684e22958c297a0cb24', 'Spotify', '59% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 647 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1e9766684e22958c297a0cb24');
-- artist 648 르노 카퓌송
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 648 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab19cb02d0b8a99af0ff4b9652e';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6ttz1LgWFVgRiNDOjtDb2L', 'https://i.scdn.co/image/ab6761860000eab19cb02d0b8a99af0ff4b9652e', 'Spotify', '55% 80%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 648 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab19cb02d0b8a99af0ff4b9652e');
-- artist 649 디트리히 피셔디스카우
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 649 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab18445aa64994e9c1a8a0bd06d';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/10CN8N2O3FlGlPVJWBiu5D', 'https://i.scdn.co/image/ab6761860000eab18445aa64994e9c1a8a0bd06d', 'Spotify', '50% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 649 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab18445aa64994e9c1a8a0bd06d');
-- artist 651 브린 터펠
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 651 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1b595337ca3bfd2bed8f20a38';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6ILd69yy67k6OU7cwpGNSl', 'https://i.scdn.co/image/ab6761860000eab1b595337ca3bfd2bed8f20a38', 'Spotify', '60% 85%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 651 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1b595337ca3bfd2bed8f20a38');
-- artist 653 마티아스 괴르네
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 653 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1bf4f123a0990ea84f24e799e';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1F3yfrc1DyiWsM0YG7kpsN', 'https://i.scdn.co/image/ab6761860000eab1bf4f123a0990ea84f24e799e', 'Spotify', '57% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 653 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1bf4f123a0990ea84f24e799e');
-- artist 661 칼 데이비스
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 661 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1ef818bd1c1e9fce075629f05';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6CcHGSgeYoXO72rMwBeZ2V', 'https://i.scdn.co/image/ab6761860000eab1ef818bd1c1e9fce075629f05', 'Spotify', '57% 73%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 661 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1ef818bd1c1e9fce075629f05');
-- artist 664 게오르그 솔티
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 664 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1e8b01e12f3eb3a3db3620646';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0dicUFoK5LIbqu6OoHu8VH', 'https://i.scdn.co/image/ab6761860000eab1e8b01e12f3eb3a3db3620646', 'Spotify', '84% 0%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 664 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1e8b01e12f3eb3a3db3620646');
-- artist 665 니콜라우스 아르농쿠르
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 665 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab13dca04a8cb002072672b9070';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0AeOzXbHJu8q2xqILEOLEO', 'https://i.scdn.co/image/ab6761860000eab13dca04a8cb002072672b9070', 'Spotify', '16% 68%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 665 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab13dca04a8cb002072672b9070');
-- artist 674 플라시도 도밍고
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 674 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1cb21572f24cc66bef934afb3';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4pU3BpenOZFEBzORx2YBJW', 'https://i.scdn.co/image/ab6761860000eab1cb21572f24cc66bef934afb3', 'Spotify', '68% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 674 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1cb21572f24cc66bef934afb3');
-- artist 676 로베르토 알라냐
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 676 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1ee40a878dea2aa773c9cdb47';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2AyySZZK01JT6ZSYZ2CWgf', 'https://i.scdn.co/image/ab6761860000eab1ee40a878dea2aa773c9cdb47', 'Spotify', '45% 65%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 676 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1ee40a878dea2aa773c9cdb47');
-- artist 678 안젤라 게오르기우
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 678 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab156591ac6e34888615ea35206';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5pLMWE1tVs9C7F9Qqauo44', 'https://i.scdn.co/image/ab6761860000eab156591ac6e34888615ea35206', 'Spotify', '53% 11%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 678 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab156591ac6e34888615ea35206');
-- artist 681 크리스티안 게르하허
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 681 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1e28e1677d65442fdcfc52b55';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0reEj3pa0lTG2gOkj9BoPb', 'https://i.scdn.co/image/ab6761860000eab1e28e1677d65442fdcfc52b55', 'Spotify', '50% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 681 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1e28e1677d65442fdcfc52b55');
-- artist 684 크리스토프 에셴바흐
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 684 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab10d0c70381e49960a8178ee42';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0xfOM47aJ8EcFX7T6Ugr9W', 'https://i.scdn.co/image/ab6761860000eab10d0c70381e49960a8178ee42', 'Spotify', '52% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 684 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab10d0c70381e49960a8178ee42');
-- artist 689 한스크리스토프 라데만
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 689 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1bd310d556f090462d71fd109';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3nWpkLjuh0r3wniO2gzL8m', 'https://i.scdn.co/image/ab6761860000eab1bd310d556f090462d71fd109', 'Spotify', '65% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 689 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1bd310d556f090462d71fd109');
-- artist 696 사이먼 스탠디지
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 696 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab15814fa90f8262c1e8de35463';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2jIBkRzVUboTbp05rJnKeT', 'https://i.scdn.co/image/ab6761860000eab15814fa90f8262c1e8de35463', 'Spotify', '55% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 696 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab15814fa90f8262c1e8de35463');
-- artist 707 시프리앵 카차리스
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 707 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab147cd63fd4968dd387c5e249d';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6mWZj1Lhb9V1ZbYL5UaZ4v', 'https://i.scdn.co/image/ab6761860000eab147cd63fd4968dd387c5e249d', 'Spotify', '0% 53%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 707 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab147cd63fd4968dd387c5e249d');
-- artist 708 제임스 골웨이
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 708 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab12d642b7f364f4800f4d6cffa';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/774mHr909NkDVeyyXQBQfZ', 'https://i.scdn.co/image/ab6761860000eab12d642b7f364f4800f4d6cffa', 'Spotify', '52% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 708 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab12d642b7f364f4800f4d6cffa');
-- artist 719 테레사 베르간사
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 719 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab175b87fb7f053d1b02ac33ab4';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6myXAUJ8cAp5oSXId946SJ', 'https://i.scdn.co/image/ab6761860000eab175b87fb7f053d1b02ac33ab4', 'Spotify', '52% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 719 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab175b87fb7f053d1b02ac33ab4');
-- artist 724 네마냐 라둘로비치
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 724 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1d56da4f855b33866caad8cfe';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1KicbGCOVNG7FkghcRVcQs', 'https://i.scdn.co/image/ab6761860000eab1d56da4f855b33866caad8cfe', 'Spotify', '59% 43%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 724 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1d56da4f855b33866caad8cfe');
-- artist 726 안드레아스 오텐잠머
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 726 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1852fe858dace6c402bbb032e';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2ArlRtVzTxoRTY58C8kA0T', 'https://i.scdn.co/image/ab6761860000eab1852fe858dace6c402bbb032e', 'Spotify', '85% 100%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 726 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1852fe858dace6c402bbb032e');
-- artist 736 로린 마젤
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 736 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab11743415397a5a42378ec189c';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3EQvBmWlfyaRLGDuVfKmve', 'https://i.scdn.co/image/ab6761860000eab11743415397a5a42378ec189c', 'Spotify', '92% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 736 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab11743415397a5a42378ec189c');
-- artist 741 몬테베르디 합창단
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 741 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab18033babf3fbabcdb6100f277';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0Cqfz92flAzrp94pgN1jEW', 'https://i.scdn.co/image/ab6761860000eab18033babf3fbabcdb6100f277', 'Spotify', '55% 22%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 741 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab18033babf3fbabcdb6100f277');
-- artist 742 폴리포니
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 742 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab17d50c646f5cca539b9645434';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/06TUYAXTcDtfcSuqnB35na', 'https://i.scdn.co/image/ab6761860000eab17d50c646f5cca539b9645434', 'Spotify', '0% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 742 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab17d50c646f5cca539b9645434');
-- artist 743 라트비아 방송합창단
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 743 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1ad3883f18e23b85ee2f5a8be';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1FPk3Fo5EyBYOxEiT2V0jP', 'https://i.scdn.co/image/ab6761860000eab1ad3883f18e23b85ee2f5a8be', 'Spotify', '38% 100%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 743 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1ad3883f18e23b85ee2f5a8be');
-- artist 749 키리 테 카나와
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 749 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab13c6f18df1f849ffd4a729b01';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3fcsflK8xu26XH4OYTcm5T', 'https://i.scdn.co/image/ab6761860000eab13c6f18df1f849ffd4a729b01', 'Spotify', '59% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 749 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab13c6f18df1f849ffd4a729b01');
-- artist 754 알렉상드르 타로
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 754 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab14bff94a7b3293fc4245f234a';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5HG9Eg7Ik8ZuNtMyGYTxLG', 'https://i.scdn.co/image/ab6761860000eab14bff94a7b3293fc4245f234a', 'Spotify', '45% 28%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 754 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab14bff94a7b3293fc4245f234a');
-- artist 758 라그나 시르머
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 758 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab13e40b9524c7e671ff5c2b599';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0hQHlePPaluKFDomtu7GWn', 'https://i.scdn.co/image/ab6761860000eab13e40b9524c7e671ff5c2b599', 'Spotify', '37% 20%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 758 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab13e40b9524c7e671ff5c2b599');
-- artist 759 이사타 카네메이슨
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 759 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab12a9c2ff36b00a88904573a96';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/7FEzSfCBSOo0wAmdk9pQ6M', 'https://i.scdn.co/image/ab6761860000eab12a9c2ff36b00a88904573a96', 'Spotify', '74% 0%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 759 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab12a9c2ff36b00a88904573a96');
-- artist 772 크리스토프 바라티
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 772 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1bb8ecaba39df03a7883eb80c';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5ACglJ478RTAqEKOio66VZ', 'https://i.scdn.co/image/ab6761860000eab1bb8ecaba39df03a7883eb80c', 'Spotify', '58% 100%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 772 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1bb8ecaba39df03a7883eb80c');
-- artist 773 리사 바티아슈빌리
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 773 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1b6231da387b466a58e3b6412';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/7nstqHP5wRNlaUeSByC86I', 'https://i.scdn.co/image/ab6761860000eab1b6231da387b466a58e3b6412', 'Spotify', '48% 27%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 773 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1b6231da387b466a58e3b6412');
-- artist 775 레너드 슬래트킨
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 775 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1805b94d613df101cb31f2c58';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0xcogVKoT8y5OBIg3L0fua', 'https://i.scdn.co/image/ab6761860000eab1805b94d613df101cb31f2c58', 'Spotify', '54% 30%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 775 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1805b94d613df101cb31f2c58');
-- artist 782 제임스 러바인
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 782 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab17e7e8e4b7514d50447b67cc9';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4qFQgEF1rg6a9WvJM0MQIa', 'https://i.scdn.co/image/ab6761860000eab17e7e8e4b7514d50447b67cc9', 'Spotify', '59% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 782 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab17e7e8e4b7514d50447b67cc9');
-- artist 786 피에르로랑 에마르
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 786 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab19f82cdc5e163392a4c2abbf3';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0wy0KtAlsZ59mEgtmEjuUk', 'https://i.scdn.co/image/ab6761860000eab19f82cdc5e163392a4c2abbf3', 'Spotify', '42% 92%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 786 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab19f82cdc5e163392a4c2abbf3');
-- artist 799 피에르 불레즈
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 799 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab141d91044410964b92dbbef54';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2prZJWfQMnIgwUKxKcBxH7', 'https://i.scdn.co/image/ab6761860000eab141d91044410964b92dbbef54', 'Spotify', '53% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 799 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab141d91044410964b92dbbef54');
-- artist 804 길 샤함
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 804 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1d50f5a8f7d8f4888a9a29e97';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6ALhP2ILfgcSmpTefE4C3Q', 'https://i.scdn.co/image/ab6761860000eab1d50f5a8f7d8f4888a9a29e97', 'Spotify', '35% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 804 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1d50f5a8f7d8f4888a9a29e97');
-- artist 807 샐리 휘트웰
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 807 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab17ec2a84a67e7dfd6fbce8446';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/29Q7tqChX3g6RsCQpt7s2l', 'https://i.scdn.co/image/ab6761860000eab17ec2a84a67e7dfd6fbce8446', 'Spotify', '48% 100%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 807 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab17ec2a84a67e7dfd6fbce8446');
-- artist 809 겐나디 로즈데스트벤스키
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 809 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1ce68484def4d76c8e89089dd';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/7sjMk07ASNAAPVXoag7sGO', 'https://i.scdn.co/image/ab6761860000eab1ce68484def4d76c8e89089dd', 'Spotify', '31% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 809 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1ce68484def4d76c8e89089dd');
-- artist 810 로리스 체크나보리안
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 810 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab11ba51ea247f48e6c85e42947';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/34d9NkGrQZfP36SEA0ZoZf', 'https://i.scdn.co/image/ab6761860000eab11ba51ea247f48e6c85e42947', 'Spotify', '50% 84%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 810 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab11ba51ea247f48e6c85e42947');
-- artist 819 앨리슨 발솜
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 819 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1968138d9f4ac9d2054c204bd';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/44Z5ZP2F1omniNpGEdNDdt', 'https://i.scdn.co/image/ab6761860000eab1968138d9f4ac9d2054c204bd', 'Spotify', '59% 59%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 819 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1968138d9f4ac9d2054c204bd');
-- artist 820 에벤 4중주단
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 820 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab12b7cab9ee4e6f7d763d18f0f';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2fFxNneQmtCTdIwEpfXnqe', 'https://i.scdn.co/image/ab6761860000eab12b7cab9ee4e6f7d763d18f0f', 'Spotify', '55% 27%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 820 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab12b7cab9ee4e6f7d763d18f0f');
-- artist 821 줄리언 로이드 웨버
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 821 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1b962844e62c01586a240005f';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1U4pv151m4SgVMg8fXROYp', 'https://i.scdn.co/image/ab6761860000eab1b962844e62c01586a240005f', 'Spotify', '100% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 821 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1b962844e62c01586a240005f');
-- artist 823 쿠아르테토 라티노아메리카노
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 823 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1d2f21a34fd8509672915d495';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3zZfi0cvqvHHJZILFiYZdv', 'https://i.scdn.co/image/ab6761860000eab1d2f21a34fd8509672915d495', 'Spotify', '55% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 823 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1d2f21a34fd8509672915d495');
-- artist 824 기돈 크레메르
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 824 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1430c1f6db0b0e54fde7164ea';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/24ibCRKLtfIZcfrixiBAsm', 'https://i.scdn.co/image/ab6761860000eab1430c1f6db0b0e54fde7164ea', 'Spotify', '21% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 824 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1430c1f6db0b0e54fde7164ea');
-- artist 825 호세 카레라스
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 825 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1ec4717faf4083326e4b17c69';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1ahGKezyX9Rl7GuEF2tc15', 'https://i.scdn.co/image/ab6761860000eab1ec4717faf4083326e4b17c69', 'Spotify', '36% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 825 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1ec4717faf4083326e4b17c69');
-- artist 828 아라벨라 슈타인바허
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 828 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1fccd85348383bd7584e43cd1';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/7zKFwhYAGA2KuM0cgEo7Rs', 'https://i.scdn.co/image/ab6761860000eab1fccd85348383bd7584e43cd1', 'Spotify', '45% 35%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 828 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1fccd85348383bd7584e43cd1');
-- artist 844 구스타프 레온하르트
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 844 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1f6b43876348e8847832ef3d5';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0KmvC3SVTF02l4ueknQCsW', 'https://i.scdn.co/image/ab6761860000eab1f6b43876348e8847832ef3d5', 'Spotify', '47% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 844 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1f6b43876348e8847832ef3d5');
-- artist 863 체칠리아 바르톨리
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 863 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1ccbff59301ef385a154f6162';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3uw6GzeL10NfFrcikMo9Na', 'https://i.scdn.co/image/ab6761860000eab1ccbff59301ef385a154f6162', 'Spotify', '48% 61%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 863 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1ccbff59301ef385a154f6162');
-- artist 866 세바스티앵 도세
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 866 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab13d1f65fa2109a9e36d656039';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6sW6AHOc6B6ozIQdTl6agW', 'https://i.scdn.co/image/ab6761860000eab13d1f65fa2109a9e36d656039', 'Spotify', '89% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 866 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab13d1f65fa2109a9e36d656039');
-- artist 897 시모네 케르메스
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 897 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab133466c85e1bb51cf8bda1de1';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5YB96PPFR0dEMazdUzMJDb', 'https://i.scdn.co/image/ab6761860000eab133466c85e1bb51cf8bda1de1', 'Spotify', '55% 13%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 897 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab133466c85e1bb51cf8bda1de1');
-- artist 903 다니엘 로이스
UPDATE entity_images image JOIN artists entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 903 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1310ddc60caef95ea08d22add';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/7pXrinMxBCkgrmVWMqRsAH', 'https://i.scdn.co/image/ab6761860000eab1310ddc60caef95ea08d22add', 'Spotify', '53% 50%', TRUE, 'PUBLISHED'
FROM artists entity WHERE entity.id = 903 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1310ddc60caef95ea08d22add');
-- composer 5 몬테베르디
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 5 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1fdf79fd739d85eeb59da5de3';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5iAhVgz6P8Nylxijb0C65v', 'https://i.scdn.co/image/ab6761860000eab1fdf79fd739d85eeb59da5de3', 'Spotify', '50% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 5 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1fdf79fd739d85eeb59da5de3');
-- composer 6 헨델
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 6 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1299396e4cf5945a8d3ebdc01';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1QL7yTHrdahRMpvNtn6rI2', 'https://i.scdn.co/image/ab6761860000eab1299396e4cf5945a8d3ebdc01', 'Spotify', '51% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 6 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1299396e4cf5945a8d3ebdc01');
-- composer 7 비발디
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 7 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1c72087722afd36794e3f0f26';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2QOIawHpSlOwXDvSqQ9YJR', 'https://i.scdn.co/image/ab6761860000eab1c72087722afd36794e3f0f26', 'Spotify', '42% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 7 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1c72087722afd36794e3f0f26');
-- composer 8 헨리 퍼셀
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 8 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1d7250335aca1e40a27992eb6';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3tMLo1k3iUo82coMLWXzxq', 'https://i.scdn.co/image/ab6761860000eab1d7250335aca1e40a27992eb6', 'Spotify', '44% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 8 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1d7250335aca1e40a27992eb6');
-- composer 9 도메니코 스카를라티
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 9 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1f65cba963bc074acad10396a';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0mFblCBw0GcoY7zY1P8tzE', 'https://i.scdn.co/image/ab6761860000eab1f65cba963bc074acad10396a', 'Spotify', '49% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 9 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1f65cba963bc074acad10396a');
-- composer 11 텔레만
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 11 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab13be64188fbc06a86076877f7';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2fg5h5pzleqI4RjFopWroj', 'https://i.scdn.co/image/ab6761860000eab13be64188fbc06a86076877f7', 'Spotify', '60% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 11 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab13be64188fbc06a86076877f7');
-- composer 14 모차르트
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 14 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1c7ab5faa5e24f4289cfc8e48';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4NJhFmfw43RLBLjQvxDuRS', 'https://i.scdn.co/image/ab6761860000eab1c7ab5faa5e24f4289cfc8e48', 'Spotify', '58% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 14 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1c7ab5faa5e24f4289cfc8e48');
-- composer 15 베토벤
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 15 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab14ecdd04bb4650b3989e13d5d';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2wOqMjp9TyABvtHdOSOTUS', 'https://i.scdn.co/image/ab6761860000eab14ecdd04bb4650b3989e13d5d', 'Spotify', '47% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 15 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab14ecdd04bb4650b3989e13d5d');
-- composer 16 하이든
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 16 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab18de847750b135ddb5e31e93a';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/656RXuyw7CE0dtjdPgjJV6', 'https://i.scdn.co/image/ab6761860000eab18de847750b135ddb5e31e93a', 'Spotify', '50% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 16 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab18de847750b135ddb5e31e93a');
-- composer 17 살리에리
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 17 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1d01cb38f339878ea8e6acb31';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4zAMiCvE5KTXuTHxi56cPE', 'https://i.scdn.co/image/ab6761860000eab1d01cb38f339878ea8e6acb31', 'Spotify', '55% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 17 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1d01cb38f339878ea8e6acb31');
-- composer 22 C.P.E. 바흐
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 22 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab13b4d01b60dcee750a11a456d';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3meioy7GWDwpwmjv2LPyAb', 'https://i.scdn.co/image/ab6761860000eab13b4d01b60dcee750a11a456d', 'Spotify', '68% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 22 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab13b4d01b60dcee750a11a456d');
-- composer 23 J.C. 바흐
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 23 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1e53bedf1a4d5e63683061f25';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0ebni9QrrWMvEgH40nOWZQ', 'https://i.scdn.co/image/ab6761860000eab1e53bedf1a4d5e63683061f25', 'Spotify', '56% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 23 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1e53bedf1a4d5e63683061f25');
-- composer 26 슈베르트
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 26 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1ab3fd81cb5f83fea72456799';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2p0UyoPfYfI76PCStuXfOP', 'https://i.scdn.co/image/ab6761860000eab1ab3fd81cb5f83fea72456799', 'Spotify', '63% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 26 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1ab3fd81cb5f83fea72456799');
-- composer 27 멘델스존
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 27 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1a0a776e221d669b153d49d44';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6MF58APd3YV72Ln2eVg710', 'https://i.scdn.co/image/ab6761860000eab1a0a776e221d669b153d49d44', 'Spotify', '47% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 27 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1a0a776e221d669b153d49d44');
-- composer 28 쇼팽
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 28 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab126279a9bd38d4d319d128d34';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/7y97mc3bZRFXzT2szRM4L4', 'https://i.scdn.co/image/ab6761860000eab126279a9bd38d4d319d128d34', 'Spotify', '49% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 28 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab126279a9bd38d4d319d128d34');
-- composer 29 슈만
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 29 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1989cc78016d7ee0a6d7cb598';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2UqjDAXnDxejEyE0CzfUrZ', 'https://i.scdn.co/image/ab6761860000eab1989cc78016d7ee0a6d7cb598', 'Spotify', '38% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 29 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1989cc78016d7ee0a6d7cb598');
-- composer 30 리스트
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 30 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1647d481cede096bd28c367cd';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1385hLNbrnbCJGokfH2ac2', 'https://i.scdn.co/image/ab6761860000eab1647d481cede096bd28c367cd', 'Spotify', '36% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 30 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1647d481cede096bd28c367cd');
-- composer 31 바그너
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 31 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1df587892e5d89624a5fb016e';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1C1x4MVkql8AiABuTw6DgE', 'https://i.scdn.co/image/ab6761860000eab1df587892e5d89624a5fb016e', 'Spotify', '61% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 31 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1df587892e5d89624a5fb016e');
-- composer 32 베르디
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 32 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab16eb484a5acbe7b9c50e91ec4';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1JOQXgYdQV2yfrhewqx96o', 'https://i.scdn.co/image/ab6761860000eab16eb484a5acbe7b9c50e91ec4', 'Spotify', '54% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 32 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab16eb484a5acbe7b9c50e91ec4');
-- composer 33 브람스
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 33 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab10c3d6e5eab47ba2d53423e79';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5wTAi7QkpP6kp8a54lmTOq', 'https://i.scdn.co/image/ab6761860000eab10c3d6e5eab47ba2d53423e79', 'Spotify', '50% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 33 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab10c3d6e5eab47ba2d53423e79');
-- composer 34 차이콥스키
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 34 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab11f052014c1c732513978bf45';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3MKCzCnpzw3TjUYs2v7vDA', 'https://i.scdn.co/image/ab6761860000eab11f052014c1c732513978bf45', 'Spotify', '50% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 34 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab11f052014c1c732513978bf45');
-- composer 35 파가니니
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 35 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab10f8d792c602798e27559e2f9';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/39FC9x5PaTNYHp5hwlaY4q', 'https://i.scdn.co/image/ab6761860000eab10f8d792c602798e27559e2f9', 'Spotify', '60% 30%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 35 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab10f8d792c602798e27559e2f9');
-- composer 36 로시니
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 36 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1d80126085587b7011ba07e23';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0roWUeP7Ac4yK4VN6L2gF4', 'https://i.scdn.co/image/ab6761860000eab1d80126085587b7011ba07e23', 'Spotify', '48% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 36 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1d80126085587b7011ba07e23');
-- composer 37 베를리오즈
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 37 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab14b43aaa3a54db79de6b6c82b';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/11T8SOX82xraocZzUXzkvM', 'https://i.scdn.co/image/ab6761860000eab14b43aaa3a54db79de6b6c82b', 'Spotify', '42% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 37 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab14b43aaa3a54db79de6b6c82b');
-- composer 39 클라라 슈만
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 39 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab12f017a51dc51642826d788e2';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2yzaWNFV3cxmcRZtwtr5WC', 'https://i.scdn.co/image/ab6761860000eab12f017a51dc51642826d788e2', 'Spotify', '53% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 39 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab12f017a51dc51642826d788e2');
-- composer 41 브루크너
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 41 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1533010a79be9b23cf280f04f';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2bM3j1JQWBkmzuoZKu4zj2', 'https://i.scdn.co/image/ab6761860000eab1533010a79be9b23cf280f04f', 'Spotify', '60% 30%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 41 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1533010a79be9b23cf280f04f');
-- composer 42 요한 슈트라우스 2세
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 42 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1e1ce23a943d346199b6e61e2';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5goS0v24Fc1ydjCKQRwtjM', 'https://i.scdn.co/image/ab6761860000eab1e1ce23a943d346199b6e61e2', 'Spotify', '54% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 42 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1e1ce23a943d346199b6e61e2');
-- composer 43 무소르크스키
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 43 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1d6763b36858b4937a02c048a';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/284mnx33IWcymQEpMxyfHl', 'https://i.scdn.co/image/ab6761860000eab1d6763b36858b4937a02c048a', 'Spotify', '51% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 43 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1d6763b36858b4937a02c048a');
-- composer 44 비제
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 44 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1c4565050cbe4e286b46c7131';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2D7RkvtKKb6E5UmbjQM1Jd', 'https://i.scdn.co/image/ab6761860000eab1c4565050cbe4e286b46c7131', 'Spotify', '38% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 44 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1c4565050cbe4e286b46c7131');
-- composer 45 드보르자크
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 45 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1863f27f7a21335dbf7364d4e';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6n7nd5iceYpXVwcx8VPpxF', 'https://i.scdn.co/image/ab6761860000eab1863f27f7a21335dbf7364d4e', 'Spotify', '41% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 45 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1863f27f7a21335dbf7364d4e');
-- composer 46 림스키코르사코프
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 46 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1727cd03a5eb9ebb0a2dfd520';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2kXJ68O899XvWOBdpzlXgs', 'https://i.scdn.co/image/ab6761860000eab1727cd03a5eb9ebb0a2dfd520', 'Spotify', '37% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 46 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1727cd03a5eb9ebb0a2dfd520');
-- composer 47 포레
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 47 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1e6f3aaae99ba28ed95a1efde';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2gClsBep1tt1rv1CN210SO', 'https://i.scdn.co/image/ab6761860000eab1e6f3aaae99ba28ed95a1efde', 'Spotify', '65% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 47 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1e6f3aaae99ba28ed95a1efde');
-- composer 48 푸치니
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 48 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1c4ab8e4c48c2d86b9d4a3d09';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0OzxPXyowUEQ532c9AmHUR', 'https://i.scdn.co/image/ab6761860000eab1c4ab8e4c48c2d86b9d4a3d09', 'Spotify', '38% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 48 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1c4ab8e4c48c2d86b9d4a3d09');
-- composer 49 말러
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 49 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1cf23e5254f74550e11b7c4c0';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2ANtgfhQkKpsW6EYSDqldz', 'https://i.scdn.co/image/ab6761860000eab1cf23e5254f74550e11b7c4c0', 'Spotify', '56% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 49 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1cf23e5254f74550e11b7c4c0');
-- composer 50 드뷔시
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 50 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab17d9a5f6f5f2b5908610fd83a';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1Uff91EOsvd99rtAupatMP', 'https://i.scdn.co/image/ab6761860000eab17d9a5f6f5f2b5908610fd83a', 'Spotify', '42% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 50 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab17d9a5f6f5f2b5908610fd83a');
-- composer 51 라흐마니노프
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 51 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab12f4af37893c787a027ab0f32';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0Kekt6CKSo0m5mivKcoH51', 'https://i.scdn.co/image/ab6761860000eab12f4af37893c787a027ab0f32', 'Spotify', '36% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 51 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab12f4af37893c787a027ab0f32');
-- composer 52 라벨
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 52 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1323e924c00f074420962c1a0';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/17hR0sYHpx7VYTMRfFUOmY', 'https://i.scdn.co/image/ab6761860000eab1323e924c00f074420962c1a0', 'Spotify', '28% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 52 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1323e924c00f074420962c1a0');
-- composer 53 베버
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 53 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1ea634cc241cc79d784d729af';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1p6wR69pnH9LBWZvwliuz2', 'https://i.scdn.co/image/ab6761860000eab1ea634cc241cc79d784d729af', 'Spotify', '51% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 53 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1ea634cc241cc79d784d729af');
-- composer 57 오펜바흐
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 57 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1b0df4e314103d5664ec482c8';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4OihBPCQzR4GfbzqOY69Xm', 'https://i.scdn.co/image/ab6761860000eab1b0df4e314103d5664ec482c8', 'Spotify', '47% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 57 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1b0df4e314103d5664ec482c8');
-- composer 58 스메타나
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 58 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab120a356de8d50e6c3f26a5571';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/25Eab1kIY1gh0Yo1oV04G4', 'https://i.scdn.co/image/ab6761860000eab120a356de8d50e6c3f26a5571', 'Spotify', '92% 37%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 58 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab120a356de8d50e6c3f26a5571');
-- composer 66 알베니스
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 66 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab113947bf4bc7d2b1e743a6020';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4sbcjbyksdT4dJ5Lh0SvZp', 'https://i.scdn.co/image/ab6761860000eab113947bf4bc7d2b1e743a6020', 'Spotify', '45% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 66 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab113947bf4bc7d2b1e743a6020');
-- composer 68 시벨리우스
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 68 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab163622c6002300db6045b2ebb';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/7jzR5qj8vFnSu5JHaXgFEr', 'https://i.scdn.co/image/ab6761860000eab163622c6002300db6045b2ebb', 'Spotify', '60% 30%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 68 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab163622c6002300db6045b2ebb');
-- composer 69 본 윌리엄스
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 69 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab14e7653c35f42f83e6d71743a';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/7wNkISK49lKeXuRaZcQVFe', 'https://i.scdn.co/image/ab6761860000eab14e7653c35f42f83e6d71743a', 'Spotify', '64% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 69 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab14e7653c35f42f83e6d71743a');
-- composer 78 글라주노프
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 78 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab11017be897476bfe2de5ff325';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/78t7WfwhjZLkDHN5QKwS5u', 'https://i.scdn.co/image/ab6761860000eab11017be897476bfe2de5ff325', 'Spotify', '49% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 78 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab11017be897476bfe2de5ff325');
-- composer 80 파야
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 80 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab176dc0c89f78300eb797b8cef';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5BcbyYRgvvhfVGmCJSjHlT', 'https://i.scdn.co/image/ab6761860000eab176dc0c89f78300eb797b8cef', 'Spotify', '49% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 80 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab176dc0c89f78300eb797b8cef');
-- composer 81 스트라빈스키
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 81 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1d6eecae5a997277f7c5cee2f';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/7ie36YytMoKtPiL7tUvmoE', 'https://i.scdn.co/image/ab6761860000eab1d6eecae5a997277f7c5cee2f', 'Spotify', '47% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 81 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1d6eecae5a997277f7c5cee2f');
-- composer 82 쇤베르크
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 82 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1f0d36106516a1a15a582b65b';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5U827e4jbYz6EjtN0fIDt9', 'https://i.scdn.co/image/ab6761860000eab1f0d36106516a1a15a582b65b', 'Spotify', '65% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 82 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1f0d36106516a1a15a582b65b');
-- composer 83 쇼스타코비치
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 83 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab113b7bfc79b0f1af81caf0a09';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6s1pCNXcbdtQJlsnM1hRIA', 'https://i.scdn.co/image/ab6761860000eab113b7bfc79b0f1af81caf0a09', 'Spotify', '77% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 83 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab113b7bfc79b0f1af81caf0a09');
-- composer 84 프로코피예프
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 84 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1feb07179a0564bd5c5fda005';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4kHtgiRnpmFIV5Tm4BIs8l', 'https://i.scdn.co/image/ab6761860000eab1feb07179a0564bd5c5fda005', 'Spotify', '37% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 84 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1feb07179a0564bd5c5fda005');
-- composer 85 버르토크
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 85 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1e157429696e3e818a180b57a';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5zyNXVd952fWOjkdGHCvPd', 'https://i.scdn.co/image/ab6761860000eab1e157429696e3e818a180b57a', 'Spotify', '5% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 85 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1e157429696e3e818a180b57a');
-- composer 86 거슈윈
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 86 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1f6713f177992fbf398974458';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1YuknfkSYTTbolRpwZBOv4', 'https://i.scdn.co/image/ab6761860000eab1f6713f177992fbf398974458', 'Spotify', '56% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 86 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1f6713f177992fbf398974458');
-- composer 87 번스타인
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 87 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1b2049520c4b995df4245ce4a';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2LmyJyCF5V1eQyvHgJNbTn', 'https://i.scdn.co/image/ab6761860000eab1b2049520c4b995df4245ce4a', 'Spotify', '41% 20%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 87 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1b2049520c4b995df4245ce4a');
-- composer 92 케이지
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 92 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1cd662c1c7acc2636c1e1dcff';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1Z3fF5lZdCM0ZHugkGoH8s', 'https://i.scdn.co/image/ab6761860000eab1cd662c1c7acc2636c1e1dcff', 'Spotify', '52% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 92 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1cd662c1c7acc2636c1e1dcff');
-- composer 93 필립 글래스
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 93 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab19d00fe673550be61f60f94c4';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/69lxxQvsfAIoQbB20bEPFC', 'https://i.scdn.co/image/ab6761860000eab19d00fe673550be61f60f94c4', 'Spotify', '82% 57%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 93 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab19d00fe673550be61f60f94c4');
-- composer 94 브리튼
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 94 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1d2304f94c6eb23c1a7d4560d';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/7MJ1pB5d6Vjmzep2zQlorn', 'https://i.scdn.co/image/ab6761860000eab1d2304f94c6eb23c1a7d4560d', 'Spotify', '58% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 94 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1d2304f94c6eb23c1a7d4560d');
-- composer 99 피아졸라
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 99 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab174ac939032789f49174172ff';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/7dsugSamBB7enWE2IrlbFg', 'https://i.scdn.co/image/ab6761860000eab174ac939032789f49174172ff', 'Spotify', '4% 0%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 99 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab174ac939032789f49174172ff');
-- composer 100 사티
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 100 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab11f0c66c7308412ff62b9e9e1';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/459INk8vcC0ebEef82WjIK', 'https://i.scdn.co/image/ab6761860000eab11f0c66c7308412ff62b9e9e1', 'Spotify', '56% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 100 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab11f0c66c7308412ff62b9e9e1');
-- composer 117 에드바르 그리그
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 117 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab18be590eb10a455f7c50a452a';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5ihY290YPGc3aY2xTyx7Gy', 'https://i.scdn.co/image/ab6761860000eab18be590eb10a455f7c50a452a', 'Spotify', '28% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 117 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab18be590eb10a455f7c50a452a');
-- composer 154 Mina Kubota
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 154 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1645e20095338f0d293ecece4';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4z1dMCmOJ6VHm8P7EP5qWf', 'https://i.scdn.co/image/ab6761860000eab1645e20095338f0d293ecece4', 'Spotify', '0% 30%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 154 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1645e20095338f0d293ecece4');
-- composer 204 Leo Brouwer
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 204 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab15589d72aefc8db8cff2e697c';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4PdumqEAuo2EQzukVWnxa0', 'https://i.scdn.co/image/ab6761860000eab15589d72aefc8db8cff2e697c', 'Spotify', '53% 86%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 204 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab15589d72aefc8db8cff2e697c');
-- composer 206 요한 요한손
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 206 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab15e01e8be641b5801641c076e';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3IpQziA6YwD53PQ5xbwgLF', 'https://i.scdn.co/image/ab6761860000eab15e01e8be641b5801641c076e', 'Spotify', '85% 100%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 206 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab15e01e8be641b5801641c076e');
-- composer 280 마이클 나이먼
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 280 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1d3692f6fa8e0208e6eba969d';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2LvhyFvUCDJ7gFuEBOcrM8', 'https://i.scdn.co/image/ab6761860000eab1d3692f6fa8e0208e6eba969d', 'Spotify', '37% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 280 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1d3692f6fa8e0208e6eba969d');
-- composer 287 니콜라 렌스
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 287 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab18325c7f9343f00b3940ef280';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2l8SZiYLlSP1XAZz5nN0Hs', 'https://i.scdn.co/image/ab6761860000eab18325c7f9343f00b3940ef280', 'Spotify', '83% 49%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 287 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab18325c7f9343f00b3940ef280');
-- composer 293 니코 멀리
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 293 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1119f956d1087b228050aff28';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2vObsQCPsbVfkqHlQOu2zc', 'https://i.scdn.co/image/ab6761860000eab1119f956d1087b228050aff28', 'Spotify', '57% 48%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 293 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1119f956d1087b228050aff28');
-- composer 297 Jennifer Higdon
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 297 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab10ee3d3b6f878c082c6bb6cb7';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/74DKkK5qRjAcHfifGufH4b', 'https://i.scdn.co/image/ab6761860000eab10ee3d3b6f878c082c6bb6cb7', 'Spotify', '50% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 297 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab10ee3d3b6f878c082c6bb6cb7');
-- composer 341 호아킨 로드리고
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 341 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab19c5f4fe6448a7feec9a6fb86';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3eqv9LW7ZXlYWXVFjHS4Mr', 'https://i.scdn.co/image/ab6761860000eab19c5f4fe6448a7feec9a6fb86', 'Spotify', '100% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 341 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab19c5f4fe6448a7feec9a6fb86');
-- composer 366 Marco Frisina
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 366 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1f4583f4d3a98207ef5a49988';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0tEWpk8Do6YAmD78I60CR0', 'https://i.scdn.co/image/ab6761860000eab1f4583f4d3a98207ef5a49988', 'Spotify', '79% 34%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 366 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1f4583f4d3a98207ef5a49988');
-- composer 399 해럴드 버드
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 399 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab1904c85a0f94f89d4d8061955';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3uOCouLFR4bVx0XeiQJSbl', 'https://i.scdn.co/image/ab6761860000eab1904c85a0f94f89d4d8061955', 'Spotify', '47% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 399 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab1904c85a0f94f89d4d8061955');
-- composer 431 프랑수아 쿠프랭
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 431 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab142813d10ce88acc598e6b807';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4kVLtXuKJTE7SgYd2sQtaL', 'https://i.scdn.co/image/ab6761860000eab142813d10ce88acc598e6b807', 'Spotify', '47% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 431 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab142813d10ce88acc598e6b807');
-- composer 441 존 애덤스
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 441 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab18ad49e5e2f65c363159d2cf9';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/35OhI7DSls022v9Bz9r0VZ', 'https://i.scdn.co/image/ab6761860000eab18ad49e5e2f65c363159d2cf9', 'Spotify', '34% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 441 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab18ad49e5e2f65c363159d2cf9');
-- composer 498 리하르트 슈트라우스
UPDATE entity_images image JOIN composers entity ON image.authority_entity_id = entity.authority_entity_id SET image.is_primary = FALSE WHERE entity.id = 498 AND image.image_kind = 'banner' AND image.file_url <> 'https://i.scdn.co/image/ab6761860000eab14b6d1ea24cf3d52d10b8d5ac';
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, focal_point, is_primary, editorial_status)
SELECT entity.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6pAwHPeExeUbMd5w7Iny6D', 'https://i.scdn.co/image/ab6761860000eab14b6d1ea24cf3d52d10b8d5ac', 'Spotify', '57% 50%', TRUE, 'PUBLISHED'
FROM composers entity WHERE entity.id = 498 AND entity.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = entity.authority_entity_id AND existing.file_url = 'https://i.scdn.co/image/ab6761860000eab14b6d1ea24cf3d52d10b8d5ac');
