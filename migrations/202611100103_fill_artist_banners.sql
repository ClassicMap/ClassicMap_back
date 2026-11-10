-- 공개 배너가 없던 S·A 연주자의 화면 머리 배너(스포티파이·애플 뮤직 아티스트 머리 그림, 위키미디어 공용).
-- 원본: seed_pipeline/curation/entity-images-2026-11-10/ (gen_sql.py 로 만든다).
-- 공개 배너가 하나도 없을 때만 넣는다. 출처 페이지를 함께 밝히고, 권리자가 요청하면 그 줄을 RETIRED 로 내린다.
-- artist 214 막심 벤게로프 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2AL02x65Azh5v7Drur4KNp', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab191f3fbb07d1d09d135bf1cfa', 'Spotify', NULL, NULL, NULL, '48% 50%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 214 AND artist.english_name = 'Maxim Vengerov' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab191f3fbb07d1d09d135bf1cfa');
-- artist 294 디아나 담라우 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4gbrnZzPDYl2SBjzAL4KIE', 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab1106cb78117bbc18098d97112', 'Spotify', NULL, NULL, NULL, '47% 50%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 294 AND artist.english_name = 'Diana Damrau' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab1106cb78117bbc18098d97112');
-- artist 318 베를린 필하모닉 오케스트라 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6uRJnvQ3f8whVnmeoecv5Z', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1ef818c8c591acc65a25449a5', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 318 AND artist.english_name = 'Berlin Philharmonic Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1ef818c8c591acc65a25449a5');
-- artist 319 빈 필하모닉 오케스트라 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/003f4bk13c6Q3gAUXv7dGJ', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1afd31e03d443e5536ed9ee4b', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 319 AND artist.english_name = 'Vienna Philharmonic Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1afd31e03d443e5536ed9ee4b');
-- artist 321 로열 콘세르트허바우 오케스트라 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2HqNckz4bPVT37fWkhugTZ', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1370a1688cf1705537521ef4a', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 321 AND artist.english_name = 'Royal Concertgebouw Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1370a1688cf1705537521ef4a');
-- artist 322 뉴욕 필하모닉 (apple_music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://music.apple.com/us/artist/2409938', 'https://is1-ssl.mzstatic.com/image/thumb/Features113/v4/05/20/93/052093ed-f22e-202d-5179-cd37f4a00c7b/4ce8e357-2c8d-45b5-a103-e559143c111f.png/2880x1440sr.webp', 'Apple Music', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 322 AND artist.english_name = 'New York Philharmonic' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features113/v4/05/20/93/052093ed-f22e-202d-5179-cd37f4a00c7b/4ce8e357-2c8d-45b5-a103-e559143c111f.png/2880x1440sr.webp');
-- artist 323 시카고 심포니 오케스트라 (apple_music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://music.apple.com/us/artist/239598', 'https://is1-ssl.mzstatic.com/image/thumb/Features221/v4/6a/ce/73/6ace73ca-9127-89bb-f301-3aef3f55e73b/33122fed-821c-41ab-8634-5cbd5060d172.png/2880x1440sr.webp', 'Apple Music', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 323 AND artist.english_name = 'Chicago Symphony Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features221/v4/6a/ce/73/6ace73ca-9127-89bb-f301-3aef3f55e73b/33122fed-821c-41ab-8634-5cbd5060d172.png/2880x1440sr.webp');
-- artist 324 보스턴 심포니 오케스트라 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0K23lQ2hSQAlxSEeZ05bjI', 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab1c2088c271dc87e2313a6efc8', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 324 AND artist.english_name = 'Boston Symphony Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab1c2088c271dc87e2313a6efc8');
-- artist 325 바이에른 방송 교향악단 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/74gWOpgM97HU3Mn8A8d0Vm', 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab13a502d2e3eb8b4a82f9c2217', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 325 AND artist.english_name = 'Bavarian Radio Symphony Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab13a502d2e3eb8b4a82f9c2217');
-- artist 326 드레스덴 슈타츠카펠레 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3Vfvyx6OouTxYU3emXonW7', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab174749ce44860f09654337fb4', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 326 AND artist.english_name = 'Dresden Staatskapelle' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab174749ce44860f09654337fb4');
-- artist 327 라이프치히 게반트하우스 오케스트라 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0SlNRZ8zBLAgyB1lsoYxAa', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1cf859e25183d0189346c2d20', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 327 AND artist.english_name = 'Leipzig Gewandhaus Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1cf859e25183d0189346c2d20');
-- artist 340 뮌헨 필하모닉 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5jSyEHI4tPkBgp84luyqpO', 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab11f6ab50e84aa6a920e441bbe', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 340 AND artist.english_name = 'Munich Philharmonic' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab11f6ab50e84aa6a920e441bbe');
-- artist 345 상트페테르부르크 필하모닉 (wikimedia)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:San_Petesburgo%2BPerianes_24.jpg', 'https://upload.wikimedia.org/wikipedia/commons/b/be/San_Petesburgo%2BPerianes_24.jpg', NULL, 'Quincena Musical', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 345 AND artist.english_name = 'St. Petersburg Philharmonic' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/b/be/San_Petesburgo%2BPerianes_24.jpg');
-- artist 357 필라델피아 오케스트라 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6tdexW8bZTG8NgOFUCYQn1', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1512f3615872493cb3a27275b', 'Spotify', NULL, NULL, NULL, '19% 0%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 357 AND artist.english_name = 'Philadelphia Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1512f3615872493cb3a27275b');
-- artist 358 클리블랜드 오케스트라 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0jJszR81GjA87jeRq0Jgwz', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab10ca4d745055db3c2096fce04', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 358 AND artist.english_name = 'Cleveland Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab10ca4d745055db3c2096fce04');
-- artist 360 로스앤젤레스 필하모닉 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6yeL5iw4hXNZtd8T7FOoFU', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1491e1c5ed6faf01f65e92be9', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 360 AND artist.english_name = 'Los Angeles Philharmonic' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1491e1c5ed6faf01f65e92be9');
-- artist 641 타카치 4중주단 (apple_music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://music.apple.com/us/artist/5412817', 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/2b/cb/7a/2bcb7a25-0ed5-6741-8b36-7889559a1573/mzl.vogtmmgg.png/2880x1440sr.webp', 'Apple Music', NULL, NULL, NULL, '62% 0%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 641 AND artist.english_name = 'Takács Quartet' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/2b/cb/7a/2bcb7a25-0ed5-6741-8b36-7889559a1573/mzl.vogtmmgg.png/2880x1440sr.webp');
-- artist 644 린 하렐 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1pl7nw0L88oUuQP5WQoePL', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1996f688bed33ece5de3f7d3d', 'Spotify', NULL, NULL, NULL, '38% 50%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 644 AND artist.english_name = 'Lynn Harrell' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1996f688bed33ece5de3f7d3d');
-- artist 645 빅토리아 물로바 (apple_music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://music.apple.com/us/artist/341097', 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/f6/18/c4/f618c432-c006-f2c9-6b65-229cacbf5b81/mzl.kwhcczhx.jpg/2880x1440sr.webp', 'Apple Music', NULL, NULL, NULL, '44% 0%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 645 AND artist.english_name = 'Viktoria Mullova' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/f6/18/c4/f618c432-c006-f2c9-6b65-229cacbf5b81/mzl.kwhcczhx.jpg/2880x1440sr.webp');
-- artist 658 라 스칼라 극장 관현악단 (wikimedia)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:La_Scala_orchestra_LCCN2014711809.jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/cd/La_Scala_orchestra_LCCN2014711809.jpg', NULL, 'Bain News Service, publisher', 'Public domain', NULL, '50% 52%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 658 AND artist.english_name = 'Orchestra del Teatro alla Scala' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/c/cd/La_Scala_orchestra_LCCN2014711809.jpg');
-- artist 672 바이에른 국립관현악단 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3ZXZN86zspTIIkwbzlkDwf', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1ab869f6bc5a9163937c590a3', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 672 AND artist.english_name = 'Bayerisches Staatsorchester' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1ab869f6bc5a9163937c590a3');
-- artist 686 셰릴 스튜더 (wikimedia)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Cheryl_Studer_1988_Prinzregententheater-19880109-RM-040233.jpg', 'https://upload.wikimedia.org/wikipedia/commons/2/26/Cheryl_Studer_1988_Prinzregententheater-19880109-RM-040233.jpg', NULL, 'Ermell', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '42% 20%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 686 AND artist.english_name = 'Cheryl Studer' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/2/26/Cheryl_Studer_1988_Prinzregententheater-19880109-RM-040233.jpg');
-- artist 188 김선욱 (wikimedia)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Pianist_Sunwook_Kim.jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/39/Pianist_Sunwook_Kim.jpg', NULL, 'Martin Jehnichen', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '41% 60%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 188 AND artist.english_name = 'Sunwook Kim' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/39/Pianist_Sunwook_Kim.jpg');
-- artist 196 임동혁 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3Iu4Pq63V1WcBWrNNthgPP', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab13a09973f5ad365e85ff05ebd', 'Spotify', NULL, NULL, NULL, '100% 58%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 196 AND artist.english_name = 'Dong-Hyek Lim' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab13a09973f5ad365e85ff05ebd');
-- artist 213 레이 첸 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5Cy6BjgpzVTTP4FURizqmQ', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1a28ba06425fc783cdb1c565f', 'Spotify', NULL, NULL, NULL, '34% 15%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 213 AND artist.english_name = 'Ray Chen' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1a28ba06425fc783cdb1c565f');
-- artist 224 파벨 콜레스니코프 (apple_music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://music.apple.com/us/artist/605494761', 'https://is1-ssl.mzstatic.com/image/thumb/Features4/v4/0e/d0/87/0ed0879e-bd54-d9d9-39fe-c3af88390f75/mzl.voihpsdp.png/2880x1440sr.webp', 'Apple Music', NULL, NULL, NULL, '74% 33%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 224 AND artist.english_name = 'Pavel Kolesnikov' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features4/v4/0e/d0/87/0ed0879e-bd54-d9d9-39fe-c3af88390f75/mzl.voihpsdp.png/2880x1440sr.webp');
-- artist 226 루카스 드바르그 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3gGFrz3hjzLPTKFwjzfm3n', 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab123b43501b0c20a75cb32d705', 'Spotify', NULL, NULL, NULL, '48% 16%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 226 AND artist.english_name = 'Lucas Debargue' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab123b43501b0c20a75cb32d705');
-- artist 251 표트르 안데르셰프스키 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0ndw1tUehEV3tnnYUnqFw9', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab17053ddf747a3b87c69f610c2', 'Spotify', NULL, NULL, NULL, '84% 59%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 251 AND artist.english_name = 'Piotr Anderszewski' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab17053ddf747a3b87c69f610c2');
-- artist 254 벤자민 그로스브너 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4imd50KIbHcyrStbIuZswj', 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab1ad813582f088d25c04e8866e', 'Spotify', NULL, NULL, NULL, '50% 0%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 254 AND artist.english_name = 'Benjamin Grosvenor' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab1ad813582f088d25c04e8866e');
-- artist 258 킷 암스트롱 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1FfN1mD94wKl0ozsfpOD43', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1545987a38395e1aa8026f595', 'Spotify', NULL, NULL, NULL, '44% 63%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 258 AND artist.english_name = 'Kit Armstrong' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1545987a38395e1aa8026f595');
-- artist 259 프란체스코 피에몬테시 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1snFy8CL2AGHTrQiWcvQR2', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1d2e99539df5760b034a08137', 'Spotify', NULL, NULL, NULL, '8% 63%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 259 AND artist.english_name = 'Francesco Piemontesi' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1d2e99539df5760b034a08137');
-- artist 260 폴 루이스 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4LYCuV8d6rylb6zjv2k03l', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1a3347760fdefe1e13942e073', 'Spotify', NULL, NULL, NULL, '31% 46%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 260 AND artist.english_name = 'Paul Lewis' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1a3347760fdefe1e13942e073');
-- artist 268 제임스 에인스 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0b7df8SeNFCgnJj5Wjg5c8', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab171df732fe6f7066562152f3a', 'Spotify', NULL, NULL, NULL, '89% 58%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 268 AND artist.english_name = 'James Ehnes' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab171df732fe6f7066562152f3a');
-- artist 269 제니퍼 코 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5oz3ukvCydQ9fAfvAHwe3z', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1be6d40c40ced1182a09401c2', 'Spotify', NULL, NULL, NULL, '23% 50%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 269 AND artist.english_name = 'Jennifer Koh' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1be6d40c40ced1182a09401c2');
-- artist 270 다니엘 호프 (apple_music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://music.apple.com/us/artist/73671116', 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/ab/61/44/ab614446-52fd-d774-f862-42ec0f67c922/f56782ba-9fb9-45bd-be54-158cfbec7058.png/2880x1440sr.webp', 'Apple Music', NULL, NULL, NULL, '52% 10%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 270 AND artist.english_name = 'Daniel Hope' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/ab/61/44/ab614446-52fd-d774-f862-42ec0f67c922/f56782ba-9fb9-45bd-be54-158cfbec7058.png/2880x1440sr.webp');
-- artist 271 닝 펑 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/48lQaQwwW8t2wNeqyFT3Um', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab11c454760e8fc4224eccf9e19', 'Spotify', NULL, NULL, NULL, '4% 72%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 271 AND artist.english_name = 'Ning Feng' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab11c454760e8fc4224eccf9e19');
-- artist 273 아우구스틴 하델리히 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0rXFlqrjeUnpRIj3z7IRBk', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab145132df0f6a8080a05aa080d', 'Spotify', NULL, NULL, NULL, '88% 70%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 273 AND artist.english_name = 'Augustin Hadelich' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab145132df0f6a8080a05aa080d');
-- artist 274 알리나 이브라기모바 (apple_music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://music.apple.com/us/artist/162134715', 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/db/eb/bc/dbebbc3b-9b1a-d5e1-cbf7-80f1b67e79ef/mzl.kicprzae.png/2880x1440sr.webp', 'Apple Music', NULL, NULL, NULL, '57% 20%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 274 AND artist.english_name = 'Alina Ibragimova' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/db/eb/bc/dbebbc3b-9b1a-d5e1-cbf7-80f1b67e79ef/mzl.kicprzae.png/2880x1440sr.webp');
-- artist 275 빌데 프랑 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/74s1TEUNSvw1oDuHbx8bNT', 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab11b75c00561d09cfa535902fc', 'Spotify', NULL, NULL, NULL, '79% 69%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 275 AND artist.english_name = 'Vilde Frang' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab11b75c00561d09cfa535902fc');
-- artist 276 솔 가베타 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4XvLzjMwnILZ9YnMHOVMIN', 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab12227c225b7693df9dd40e4e1', 'Spotify', NULL, NULL, NULL, '50% 13%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 276 AND artist.english_name = 'Sol Gabetta' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab12227c225b7693df9dd40e4e1');
-- artist 280 장 기앙 케라스 (apple_music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://music.apple.com/us/artist/207657533', 'https://is1-ssl.mzstatic.com/image/thumb/Features211/v4/af/d6/45/afd6456d-5395-fc4b-897c-c51657de5108/mzl.clfnfdfz.jpeg/2880x1440sr.webp', 'Apple Music', NULL, NULL, NULL, '74% 0%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 280 AND artist.english_name = 'Jean-Guihen Queyras' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features211/v4/af/d6/45/afd6456d-5395-fc4b-897c-c51657de5108/mzl.clfnfdfz.jpeg/2880x1440sr.webp');
-- artist 281 요하네스 모저 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0kPxHt8yRxIlDOdkofstQV', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab123a7d582791b2155cc203d70', 'Spotify', NULL, NULL, NULL, '68% 8%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 281 AND artist.english_name = 'Johannes Moser' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab123a7d582791b2155cc203d70');
-- artist 292 프랑수아 자비에 로트 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/01MlLLNqc0Dp9jS04Rm6gp', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab13c7c8fff315646ee9fafbb23', 'Spotify', NULL, NULL, NULL, '58% 53%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 292 AND artist.english_name = 'François-Xavier Roth' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab13c7c8fff315646ee9fafbb23');
-- artist 296 프리티 옌데 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2s7dm9RxxQaLtAXbWjQeco', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab16ae6de6864a85095e46a348d', 'Spotify', NULL, NULL, NULL, '11% 19%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 296 AND artist.english_name = 'Pretty Yende' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab16ae6de6864a85095e46a348d');
-- artist 306 샤론 베잘리 (apple_music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://music.apple.com/us/artist/72588796', 'https://is1-ssl.mzstatic.com/image/thumb/Features122/v4/44/6a/9f/446a9f93-13ef-ac10-c69c-26dfc7930c27/mzl.rdkbthqp.png/2880x1440sr.webp', 'Apple Music', NULL, NULL, NULL, '72% 0%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 306 AND artist.english_name = 'Sharon Bezaly' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features122/v4/44/6a/9f/446a9f93-13ef-ac10-c69c-26dfc7930c27/mzl.rdkbthqp.png/2880x1440sr.webp');
-- artist 307 알브레히트 마이어 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1Mbvbes7vW2Pg3bWD9aDgW', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1127b582e263a7c8100543ac1', 'Spotify', NULL, NULL, NULL, '52% 45%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 307 AND artist.english_name = 'Albrecht Mayer' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1127b582e263a7c8100543ac1');
-- artist 310 바딤 홀로덴코 (apple_music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://music.apple.com/us/artist/1449450053', 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/9b/e3/18/9be31808-7a61-262b-acf7-049d34fcf3f5/mzl.fbvqelob.jpg/2880x1440sr.webp', 'Apple Music', NULL, NULL, NULL, '49% 0%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 310 AND artist.english_name = 'Vadym Kholodenko' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/9b/e3/18/9be31808-7a61-262b-acf7-049d34fcf3f5/mzl.fbvqelob.jpg/2880x1440sr.webp');
-- artist 314 조지 리 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/7MmY9EnBs2QvDwLnJUV332', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab12465881c606f555bda4da0e8', 'Spotify', NULL, NULL, NULL, '47% 69%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 314 AND artist.english_name = 'George Li' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab12465881c606f555bda4da0e8');
-- artist 317 티안와 양 (apple_music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://music.apple.com/us/artist/175121461', 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/21/4a/c5/214ac54d-07ae-58c2-1eba-b032606d2bfc/mzl.qpifdsnr.jpg/2880x1440sr.webp', 'Apple Music', NULL, NULL, NULL, '60% 0%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 317 AND artist.english_name = 'Tianwa Yang' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/21/4a/c5/214ac54d-07ae-58c2-1eba-b032606d2bfc/mzl.qpifdsnr.jpg/2880x1440sr.webp');
-- artist 320 런던 심포니 오케스트라 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5yxyJsFanEAuwSM5kOuZKc', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1359dcaf70e845ea09b0249d1', 'Spotify', NULL, NULL, NULL, '50% 100%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 320 AND artist.english_name = 'London Symphony Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1359dcaf70e845ea09b0249d1');
-- artist 328 서울시향 (apple_music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://music.apple.com/us/artist/328045241', 'https://is1-ssl.mzstatic.com/image/thumb/Features221/v4/23/ab/4c/23ab4c26-5f0a-436d-041a-c3354559c1cb/mzl.eedbcidj.jpg/2880x1440sr.webp', 'Apple Music', NULL, NULL, NULL, '50% 100%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 328 AND artist.english_name = 'Seoul Philharmonic Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features221/v4/23/ab/4c/23ab4c26-5f0a-436d-041a-c3354559c1cb/mzl.eedbcidj.jpg/2880x1440sr.webp');
-- artist 329 KBS 교향악단 (wikimedia)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:KBS_Rudolfinum.jpg', 'https://upload.wikimedia.org/wikipedia/commons/7/79/KBS_Rudolfinum.jpg', NULL, 'Valley~cswiki', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '50% 75%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 329 AND artist.english_name = 'KBS Symphony Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/7/79/KBS_Rudolfinum.jpg');
-- artist 330 코리안 심포니 오케스트라 (apple_music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://music.apple.com/us/artist/1216714788', 'https://is1-ssl.mzstatic.com/image/thumb/AMCArtistImages221/v4/7a/f3/2f/7af32f71-456f-9ea4-2149-bd0efda4e9fa/ami_U003aidentity_U003a23735943964f3a28fec32976edc299a7-2026-10-26T01-32-30.791Z_cropped.png/2880x1440sr.webp', 'Apple Music', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 330 AND artist.english_name = 'Korean Symphony Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/AMCArtistImages221/v4/7a/f3/2f/7af32f71-456f-9ea4-2149-bd0efda4e9fa/ami_U003aidentity_U003a23735943964f3a28fec32976edc299a7-2026-10-26T01-32-30.791Z_cropped.png/2880x1440sr.webp');
-- artist 337 로열 필하모닉 오케스트라 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0MvSBMGRQJY3mRwIbJsqF1', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1b9ac45e786b21b892d5b34f5', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 337 AND artist.english_name = 'Royal Philharmonic Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1b9ac45e786b21b892d5b34f5');
-- artist 338 필하모니아 오케스트라 (apple_music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://music.apple.com/us/artist/499413', 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/ea/b1/d7/eab1d7d3-80cc-cb33-cd59-11eac98557ff/a74aa76a-4e27-4238-b4c3-100aae53e5be.png/2880x1440sr.webp', 'Apple Music', NULL, NULL, NULL, '34% 52%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 338 AND artist.english_name = 'Philharmonia Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/ea/b1/d7/eab1d7d3-80cc-cb33-cd59-11eac98557ff/a74aa76a-4e27-4238-b4c3-100aae53e5be.png/2880x1440sr.webp');
-- artist 339 BBC 심포니 오케스트라 (wikimedia)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:BBCSO_rehearsing_for_the_last_night_of_the_Proms.jpg', 'https://upload.wikimedia.org/wikipedia/commons/b/b7/BBCSO_rehearsing_for_the_last_night_of_the_Proms.jpg', NULL, 'Steve Bowbrick', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', '50% 42%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 339 AND artist.english_name = 'BBC Symphony Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b7/BBCSO_rehearsing_for_the_last_night_of_the_Proms.jpg');
-- artist 341 WDR 교향악단 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1K91XZsljzXqn1oYcPIsfL', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab16802b36854bca5c906ecdd9d', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 341 AND artist.english_name = 'WDR Symphony Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab16802b36854bca5c906ecdd9d');
-- artist 342 NDR 엘프필하모닉 오케스트라 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5d7YSf7KV1gzNju6Z5JZt6', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1ba3aab56f89e994cb9d065b8', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 342 AND artist.english_name = 'NDR Elbphilharmonie Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1ba3aab56f89e994cb9d065b8');
-- artist 343 파리 오케스트라 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0iERWmMl3nIvcDxnJsKZBd', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1332831da9f4793dfb5b693a0', 'Spotify', NULL, NULL, NULL, '35% 52%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 343 AND artist.english_name = 'Orchestre de Paris' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1332831da9f4793dfb5b693a0');
-- artist 344 프랑스 국립 오케스트라 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5UFYrc7bnGpaojNag3Bv8M', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab142d3f28054107f02adf4944a', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 344 AND artist.english_name = 'Orchestra National de France' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab142d3f28054107f02adf4944a');
-- artist 348 체코 필하모닉 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/35NnUEPKGspM23lTZvK3cb', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1ecb007c9a9d0c4a3a7a21244', 'Spotify', NULL, NULL, NULL, '52% 95%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 348 AND artist.english_name = 'Czech Philharmonic' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1ecb007c9a9d0c4a3a7a21244');
-- artist 349 오슬로 필하모닉 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5cp6B8bMNsXdQKgE6exdzx', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1f34cbf24b98b7d392edf846f', 'Spotify', NULL, NULL, NULL, '50% 40%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 349 AND artist.english_name = 'Oslo Philharmonic' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1f34cbf24b98b7d392edf846f');
-- artist 350 NHK 교향악단 (wikimedia)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Kornilios_Michailidis_with_NHK_Symphony_Orchestra_(2025-07-12)_(02).jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Kornilios_Michailidis_with_NHK_Symphony_Orchestra_%282025-07-12%29_%2802%29.jpg', NULL, 'StrangeTraveler', 'CC BY 4.0', 'https://creativecommons.org/licenses/by/4.0', '50% 20%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 350 AND artist.english_name = 'NHK Symphony Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Kornilios_Michailidis_with_NHK_Symphony_Orchestra_%282025-07-12%29_%2802%29.jpg');
-- artist 352 요미우리 일본 교향악단 (apple_music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://music.apple.com/us/artist/277843369', 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/b9/c0/0b/b9c00b90-53ea-39a9-e69b-f91f5d29f37f/a0daf3c4-d2ce-4f7e-9bb4-d3797a505817.png/2880x1440sr.webp', 'Apple Music', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 352 AND artist.english_name = 'Yomiuri Nippon Symphony Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/b9/c0/0b/b9c00b90-53ea-39a9-e69b-f91f5d29f37f/a0daf3c4-d2ce-4f7e-9bb4-d3797a505817.png/2880x1440sr.webp');
-- artist 353 싱가포르 교향악단 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/32sSC58wBNlSthfdC2t8Av', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1c91ee1c15146e445032bcbd8', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 353 AND artist.english_name = 'Singapore Symphony Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1c91ee1c15146e445032bcbd8');
-- artist 356 상하이 교향악단 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5axjIS5grj9EJYzXJW10IY', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1dc3ee67966af7a029611dfc8', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 356 AND artist.english_name = 'Shanghai Symphony Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1dc3ee67966af7a029611dfc8');
-- artist 359 샌프란시스코 심포니 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1qHStDLIc8uV7hvTG6FGRJ', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1360ba1f7149f84da7f6ae0a7', 'Spotify', NULL, NULL, NULL, '71% 0%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 359 AND artist.english_name = 'San Francisco Symphony' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1360ba1f7149f84da7f6ae0a7');
-- artist 362 피츠버그 심포니 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/7oOCHAPJjD7IARb5hrzvw9', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab17101e12b4deb60e6b9320778', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 362 AND artist.english_name = 'Pittsburgh Symphony Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab17101e12b4deb60e6b9320778');
-- artist 363 토론토 심포니 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4gTJ4MkZcCantFX5zlRRI8', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab177c0407d35c2fdc1bb50be42', 'Spotify', NULL, NULL, NULL, '50% 4%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 363 AND artist.english_name = 'Toronto Symphony Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab177c0407d35c2fdc1bb50be42');
-- artist 364 몬트리올 심포니 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4AcXapei4U7xnWecv9AEBd', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1c016545eb8456295532f55d2', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 364 AND artist.english_name = 'Montreal Symphony Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1c016545eb8456295532f55d2');
-- artist 578 아카데미 오브 세인트 마틴 인 더 필즈 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/77CaCn32H4mOMQA7UElzfF', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1f70d9a91f6ef0cb9105e4e52', 'Spotify', NULL, NULL, NULL, '50% 10%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 578 AND artist.english_name = 'Academy of St Martin in the Fields' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1f70d9a91f6ef0cb9105e4e52');
-- artist 585 마린 올솝 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0lluGWFB8hZ6HFktcH6kkr', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1328f8e136af8ff4dca48cefc', 'Spotify', NULL, NULL, NULL, '55% 50%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 585 AND artist.english_name = 'Marin Alsop' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1328f8e136af8ff4dca48cefc');
-- artist 604 이스라엘 필하모닉 오케스트라 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4RkU7dxppCNi2078hPMUI4', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab19c686d5b3ba26e94fbbeb974', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 604 AND artist.english_name = 'Israel Philharmonic Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab19c686d5b3ba26e94fbbeb974');
-- artist 615 테오도르 쿠렌치스 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2MMdTWWDamS8wyZJ6Hosch', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1cb54360c88125ea6b5f24728', 'Spotify', NULL, NULL, NULL, '37% 13%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 615 AND artist.english_name = 'Teodor Currentzis' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1cb54360c88125ea6b5f24728');
-- artist 617 말러 체임버 오케스트라 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5g44FyRrB0AUEdQbqW4jAo', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1befaa170403d3deb5510e010', 'Spotify', NULL, NULL, NULL, '52% 36%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 617 AND artist.english_name = 'Mahler Chamber Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1befaa170403d3deb5510e010');
-- artist 619 다니엘 하딩 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3sjupE75AphhTX12fgkQv6', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab19ca0db0cd9be7a2fc3a9a6ad', 'Spotify', NULL, NULL, NULL, '58% 50%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 619 AND artist.english_name = 'Daniel Harding' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab19ca0db0cd9be7a2fc3a9a6ad');
-- artist 621 유럽 체임버 오케스트라 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1VfDXOsmvKAtebAZ9KxQhC', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab17ced9eb9a122109100f51bdd', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 621 AND artist.english_name = 'Chamber Orchestra of Europe' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab17ced9eb9a122109100f51bdd');
-- artist 633 잉글리시 체임버 오케스트라 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2DO4p3CPDnInsJfg0jFfaF', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab11a69d10514f44eb3a0524488', 'Spotify', NULL, NULL, NULL, '50% 50%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 633 AND artist.english_name = 'English Chamber Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab11a69d10514f44eb3a0524488');
-- artist 637 볼티모어 심포니 오케스트라 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1w77QW6t2p7zrCEbgwk256', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab146e138d92a15321f1f80fc3a', 'Spotify', NULL, NULL, NULL, '36% 100%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 637 AND artist.english_name = 'Baltimore Symphony Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab146e138d92a15321f1f80fc3a');
-- artist 643 미하엘 바렌보임 (apple_music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://music.apple.com/us/artist/308824837', 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/d1/97/65/d19765cf-952b-5c4b-be37-bac42d167910/mzl.fxfgerqr.jpg/2880x1440sr.webp', 'Apple Music', NULL, NULL, NULL, '35% 3%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 643 AND artist.english_name = 'Michael Barenboim' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/d1/97/65/d19765cf-952b-5c4b-be37-bac42d167910/mzl.fxfgerqr.jpg/2880x1440sr.webp');
-- artist 654 안드레아스 헤플리거 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/1LuRCnmVYvICtWy3lDkiVB', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1980ce048bb0233271a7dee0b', 'Spotify', NULL, NULL, NULL, '73% 50%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 654 AND artist.english_name = 'Andreas Haefliger' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1980ce048bb0233271a7dee0b');
-- artist 662 에리카 미클로샤 (wikimedia)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Mikl%C3%B3sa_Erika_2011_(1).jpg', 'https://upload.wikimedia.org/wikipedia/commons/4/4c/Mikl%C3%B3sa_Erika_2011_%281%29.jpg', NULL, 'Derzsi Elekes Andor', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', '45% 40%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 662 AND artist.english_name = 'Erika Miklósa' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/4/4c/Mikl%C3%B3sa_Erika_2011_%281%29.jpg');
-- artist 670 카를로 리치 (wikimedia)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Carlo_Rizzi_(2013).jpg', 'https://upload.wikimedia.org/wikipedia/commons/f/f0/Carlo_Rizzi_%282013%29.jpg', NULL, 'Quincena Musical de San Sebastián', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', '65% 6%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 670 AND artist.english_name = 'Carlo Rizzi' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f0/Carlo_Rizzi_%282013%29.jpg');
-- artist 671 밀라노 주세페 베르디 교향악단 (wikimedia)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Orchestra_Sinfonica_di_Milano_nella_Nona_Sinfonia_di_Gustav_Mahler_,_2023,_%C2%A9_Orchestra_Sinfonica_di_Milano.jpg', 'https://upload.wikimedia.org/wikipedia/commons/0/0f/Orchestra_Sinfonica_di_Milano_nella_Nona_Sinfonia_di_Gustav_Mahler_%2C_2023%2C_%C2%A9_Orchestra_Sinfonica_di_Milano.jpg', NULL, 'Angelica Concari © Orchestra Sinfonica di Milano', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '50% 80%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 671 AND artist.english_name = 'Orchestra Sinfonica di Milano Giuseppe Verdi' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/0/0f/Orchestra_Sinfonica_di_Milano_nella_Nona_Sinfonia_di_Gustav_Mahler_%2C_2023%2C_%C2%A9_Orchestra_Sinfonica_di_Milano.jpg');
-- artist 697 베를린 고음악 아카데미 (apple_music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://music.apple.com/us/artist/75663243', 'https://is1-ssl.mzstatic.com/image/thumb/Features112/v4/c3/6d/41/c36d41f6-5c07-ee28-4d17-db1b7ed08741/mzl.oxlwwvyc.jpg/2880x1440sr.webp', 'Apple Music', NULL, NULL, NULL, '50% 60%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 697 AND artist.english_name = 'Akademie für Alte Musik Berlin' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features112/v4/c3/6d/41/c36d41f6-5c07-ee28-4d17-db1b7ed08741/mzl.oxlwwvyc.jpg/2880x1440sr.webp');
-- artist 701 슈투트가르트 체임버 오케스트라 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/51RiZjPgKKJ1uDsZVmntmF', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab136f9397f381a2e6b6b7a54ab', 'Spotify', NULL, NULL, NULL, '50% 80%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 701 AND artist.english_name = 'Stuttgart Chamber Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab136f9397f381a2e6b6b7a54ab');
-- artist 704 아카데미 오브 에인션트 뮤직 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/60adCptqwRkANTtVja0bvf', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1b5429fcb722225ada0aa2208', 'Spotify', NULL, NULL, NULL, '68% 43%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 704 AND artist.english_name = 'Academy of Ancient Music' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1b5429fcb722225ada0aa2208');
-- artist 705 RIAS 실내합창단 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/2UVXU77knJMYOM6Avvw6Yx', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1ec01a580e21fc4cb8c04c347', 'Spotify', NULL, NULL, NULL, '50% 40%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 705 AND artist.english_name = 'RIAS Kammerchor' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1ec01a580e21fc4cb8c04c347');
-- artist 706 드레스덴 실내합창단 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4yDjrNfw6inxy2NjexHpV1', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab17c8626bd7d54f99151cbca04', 'Spotify', NULL, NULL, NULL, '50% 50%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 706 AND artist.english_name = 'Dresdner Kammerchor' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab17c8626bd7d54f99151cbca04');
-- artist 713 포츠담 실내악 아카데미 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3Xyr46anTBdukjErlpKfXH', 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab168d96d340c18886cb0490b44', 'Spotify', NULL, NULL, NULL, '50% 40%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 713 AND artist.english_name = 'Kammerakademie Potsdam' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab168d96d340c18886cb0490b44');
-- artist 714 뷔르템베르크 실내관현악단 하일브론 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/7AUztDRea3gAzwq6FKVfV4', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab19470805b7e2545029304e6ff', 'Spotify', NULL, NULL, NULL, '75% 26%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 714 AND artist.english_name = 'Württembergisches Kammerorchester Heilbronn' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab19470805b7e2545029304e6ff');
-- artist 720 베셀리나 카사로바 (wikimedia)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Vessi_OffenbachKonzert07_5.JPG', 'https://upload.wikimedia.org/wikipedia/commons/d/da/Vessi_OffenbachKonzert07_5.JPG', NULL, 'The original uploader was Epinions Smorg at English Wikipedia. (Original text: SP)', 'Attribution', NULL, '56% 6%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 720 AND artist.english_name = 'Vesselina Kasarova' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/d/da/Vessi_OffenbachKonzert07_5.JPG');
-- artist 722 유타 심포니 오케스트라 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0nUgGmqaWapTF9BiRDBmJp', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1daec0689255f850bced5474f', 'Spotify', NULL, NULL, NULL, '50% 50%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 722 AND artist.english_name = 'Utah Symphony' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1daec0689255f850bced5474f');
-- artist 730 프라하 실내관현악단 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/7hrleJxjf4KJbeiQirb6BL', 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab1a606c3fdfbdb34ba2603d566', 'Spotify', NULL, NULL, NULL, '50% 50%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 730 AND artist.english_name = 'Prague Chamber Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab1a606c3fdfbdb34ba2603d566');
-- artist 747 베를린 방송합창단 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4DqlvoyKHnvnT4lvFmTSkG', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1c1d79cc3ec2285c684c75a63', 'Spotify', NULL, NULL, NULL, '53% 100%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 747 AND artist.english_name = 'Rundfunkchor Berlin' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1c1d79cc3ec2285c684c75a63');
-- artist 748 로스앤젤레스 마스터 코랄 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/66HwS8U1RybE701IOdJT1x', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1a14565849a6f4685fa6fd1dd', 'Spotify', NULL, NULL, NULL, '54% 44%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 748 AND artist.english_name = 'Los Angeles Master Chorale' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1a14565849a6f4685fa6fd1dd');
-- artist 755 미셸 달베르토 (apple_music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://music.apple.com/us/artist/278436', 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/48/ff/e8/48ffe837-29f1-d85e-a64f-5c26113325e5/mzl.guyghtun.jpg/2880x1440sr.webp', 'Apple Music', NULL, NULL, NULL, '50% 0%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 755 AND artist.english_name = 'Michel Dalberto' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/48/ff/e8/48ffe837-29f1-d85e-a64f-5c26113325e5/mzl.guyghtun.jpg/2880x1440sr.webp');
-- artist 757 캐스린 스톳 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/7JmDqds7Y1LRSWZVM8e0Og', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1efd08795febd8577bbdd627e', 'Spotify', NULL, NULL, NULL, '59% 50%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 757 AND artist.english_name = 'Kathryn Stott' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1efd08795febd8577bbdd627e');
-- artist 762 로열 리버풀 필하모닉 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6I6fmQU7HGrUsCm4B5Nlk3', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab134775edbc266f2787e2abc75', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 762 AND artist.english_name = 'Royal Liverpool Philharmonic Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab134775edbc266f2787e2abc75');
-- artist 764 태즈메이니아 심포니 오케스트라 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3WEe5Cpg29CUvsWWv4vRTT', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1c79767dd57922de7114d7b8b', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 764 AND artist.english_name = 'Tasmanian Symphony Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1c79767dd57922de7114d7b8b');
-- artist 767 보자르 삼중주단 (wikimedia)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Beaux_Arts_Trio,_Concertgebouw,_1978_-_35.jpg', 'https://upload.wikimedia.org/wikipedia/commons/e/ef/Beaux_Arts_Trio%2C_Concertgebouw%2C_1978_-_35.jpg', NULL, 'Fotopersbureau De Boer', 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', '22% 11%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 767 AND artist.english_name = 'Beaux Arts Trio' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/e/ef/Beaux_Arts_Trio%2C_Concertgebouw%2C_1978_-_35.jpg');
-- artist 769 파블로 페란데스 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0W2xAxxZVRbIhzn5lLMowt', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1988ae7cc59b72fe9def870dc', 'Spotify', NULL, NULL, NULL, '21% 17%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 769 AND artist.english_name = 'Pablo Ferrández' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1988ae7cc59b72fe9def870dc');
-- artist 776 오우에 에이지 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0HWPIGRL1eXG4wSwTNlvQN', 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab142383f6b6c84ab0e0316a8b8', 'Spotify', NULL, NULL, NULL, '52% 50%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 776 AND artist.english_name = 'Eiji Oue' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab142383f6b6c84ab0e0316a8b8');
-- artist 777 로런스 포스터 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/0k8Ugg3yjlhOAEikLmXyUx', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1e669de18772fffe1e5c4524f', 'Spotify', NULL, NULL, NULL, '51% 50%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 777 AND artist.english_name = 'Lawrence Foster' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1e669de18772fffe1e5c4524f');
-- artist 778 빈 교향악단 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6XZxFuZaBnZBngpxbut80O', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab10cd1f7da92c50063b80e9711', 'Spotify', NULL, NULL, NULL, '50% 60%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 778 AND artist.english_name = 'Vienna Symphony' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab10cd1f7da92c50063b80e9711');
-- artist 779 NDR 방송교향악단 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6i9KFEJuHq78nMsQxeB1vR', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab17203fc0c6f0f7ff40dbb2177', 'Spotify', NULL, NULL, NULL, '50% 55%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 779 AND artist.english_name = 'NDR Radiophilharmonie' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab17203fc0c6f0f7ff40dbb2177');
-- artist 780 런던 필하모닉 오케스트라 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3PfJE6ebCbCHeuqO4BfNeA', 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab1668f06543df5d60adc79165d', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 780 AND artist.english_name = 'London Philharmonic Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-fa.spotifycdn.com/image/ab6761860000eab1668f06543df5d60adc79165d');
-- artist 787 SWR 바덴바덴·프라이부르크 교향악단 (wikimedia)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:SWR_Sinfonieorchester_Baden-Baden_und_Freiburg,_Chefdirigent_Fran%C3%A7ois-Xavier_Roth.jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/31/SWR_Sinfonieorchester_Baden-Baden_und_Freiburg%2C_Chefdirigent_Fran%C3%A7ois-Xavier_Roth.jpg', NULL, 'SWR Kommunikation', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '50% 80%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 787 AND artist.english_name = 'SWR Sinfonieorchester Baden-Baden und Freiburg' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/3/31/SWR_Sinfonieorchester_Baden-Baden_und_Freiburg%2C_Chefdirigent_Fran%C3%A7ois-Xavier_Roth.jpg');
-- artist 788 댈러스 심포니 오케스트라 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/30ywQdA4ElkX92wuEe9YdP', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1f466185c895925287602825f', 'Spotify', NULL, NULL, NULL, '50% 40%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 788 AND artist.english_name = 'Dallas Symphony Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1f466185c895925287602825f');
-- artist 789 댈러스 심포니 합창단 (wikimedia)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Dallas_Symphony_Chorus_20180612_%C3%96rebro.jpg', 'https://upload.wikimedia.org/wikipedia/commons/e/e4/Dallas_Symphony_Chorus_20180612_%C3%96rebro.jpg', NULL, 'LA2', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '50% 60%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 789 AND artist.english_name = 'Dallas Symphony Chorus' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e4/Dallas_Symphony_Chorus_20180612_%C3%96rebro.jpg');
-- artist 792 런던 심포니 합창단 (apple_music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://music.apple.com/us/artist/4319813', 'https://is1-ssl.mzstatic.com/image/thumb/Features115/v4/9c/03/10/9c0310f5-c982-42f5-fa6c-400ca93200e0/mzl.xpzxiwse.png/2880x1440sr.webp', 'Apple Music', NULL, NULL, NULL, '50% 100%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 792 AND artist.english_name = 'London Symphony Chorus' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features115/v4/9c/03/10/9c0310f5-c982-42f5-fa6c-400ca93200e0/mzl.xpzxiwse.png/2880x1440sr.webp');
-- artist 794 바이에른 방송합창단 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/536pGG9V0mbcKOSgw37g4m', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab10b72da4456f0fe83f40efbcf', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 794 AND artist.english_name = 'Bavarian Radio Chorus' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab10b72da4456f0fe83f40efbcf');
-- artist 795 버밍엄 시립교향악단 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6wuudWq7XpVutoFp4bsVDo', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1de64e2a7800dc4a41518fa44', 'Spotify', NULL, NULL, NULL, '50% 50%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 795 AND artist.english_name = 'City of Birmingham Symphony Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1de64e2a7800dc4a41518fa44');
-- artist 796 세인트루이스 교향악단 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/4DBdvdTZBJd45Izgjt9Xlg', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab173a619a51f611f4a4f60c804', 'Spotify', NULL, NULL, NULL, '50% 54%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 796 AND artist.english_name = 'Saint Louis Symphony Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab173a619a51f611f4a4f60c804');
-- artist 800 한스 로스바우트 (wikimedia)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Donaueschingen-_Donaueschinger_Musiktage;_Hans_Rosbaud_dirigiert,_von_oben_-_LABW_-_Staatsarchiv_Freiburg_W_134_Nr._039525b.jpeg', 'https://upload.wikimedia.org/wikipedia/commons/1/17/Donaueschingen-_Donaueschinger_Musiktage%3B_Hans_Rosbaud_dirigiert%2C_von_oben_-_LABW_-_Staatsarchiv_Freiburg_W_134_Nr._039525b.jpeg', NULL, 'Willy Pragher', 'CC BY 4.0', 'https://creativecommons.org/licenses/by/4.0', '0% 12%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 800 AND artist.english_name = 'Hans Rosbaud' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/1/17/Donaueschingen-_Donaueschinger_Musiktage%3B_Hans_Rosbaud_dirigiert%2C_von_oben_-_LABW_-_Staatsarchiv_Freiburg_W_134_Nr._039525b.jpeg');
-- artist 802 줄리아드 현악 4중주단 (apple_music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://music.apple.com/us/artist/15409749', 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/55/e5/d6/55e5d6b7-6308-425e-7cc1-b16075b5f867/mzl.tyirevlj.jpg/2880x1440sr.webp', 'Apple Music', NULL, NULL, NULL, '42% 0%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 802 AND artist.english_name = 'Juilliard String Quartet' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/55/e5/d6/55e5d6b7-6308-425e-7cc1-b16075b5f867/mzl.tyirevlj.jpg/2880x1440sr.webp');
-- artist 806 이본 로리오 (wikimedia)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Loriod_Caen.jpg', 'https://upload.wikimedia.org/wikipedia/commons/e/ec/Loriod_Caen.jpg', NULL, 'Agence26', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '21% 51%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 806 AND artist.english_name = 'Yvonne Loriod' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/e/ec/Loriod_Caen.jpg');
-- artist 808 파리 국립오페라 관현악단 (wikimedia)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Orchestree_de_L%C2%B4op%C3%A9ra_National_de_Paris001_(54749885169).jpg', 'https://upload.wikimedia.org/wikipedia/commons/f/f6/Orchestree_de_L%C2%B4op%C3%A9ra_National_de_Paris001_%2854749885169%29.jpg', NULL, 'Quincena Musical', 'CC BY 4.0', 'https://creativecommons.org/licenses/by/4.0', '50% 60%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 808 AND artist.english_name = 'Orchestre de l''Opéra national de Paris' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f6/Orchestree_de_L%C2%B4op%C3%A9ra_National_de_Paris001_%2854749885169%29.jpg');
-- artist 811 아르메니아 필하모닉 오케스트라 (wikimedia)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:Eduard-Topchyan.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/8d/Eduard-Topchyan.jpg', NULL, '23artashes', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', '50% 50%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 811 AND artist.english_name = 'Armenian Philharmonic Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/8/8d/Eduard-Topchyan.jpg');
-- artist 814 왕립 스코틀랜드 국립 관현악단 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5xBSsPfZtPItmn72C2EHVf', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab128ab45ab2a32a5807467f1e8', 'Spotify', NULL, NULL, NULL, '50% 65%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 814 AND artist.english_name = 'Royal Scottish National Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab128ab45ab2a32a5807467f1e8');
-- artist 829 콘세르트헤바우 실내관현악단 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/254914edb11tMrw8vCDjut', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1a88d7195cc9cb88d8d6edb6b', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 829 AND artist.english_name = 'Concertgebouw Chamber Orchestra' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1a88d7195cc9cb88d8d6edb6b');
-- artist 830 네덜란드 실내합창단 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/6PFYKE0BqNEYlRhwyjkE6m', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1b5de2e3642aae56f9b901b75', 'Spotify', NULL, NULL, NULL, '0% 60%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 830 AND artist.english_name = 'Nederlands Kamerkoor' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1b5de2e3642aae56f9b901b75');
-- artist 831 로저 비뇰스 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/5XVtByLJ0QFGXg7MwG0YKZ', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1254ceb2a6e8ccfcda074896f', 'Spotify', NULL, NULL, NULL, '74% 50%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 831 AND artist.english_name = 'Roger Vignoles' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1254ceb2a6e8ccfcda074896f');
-- artist 834 빈 악우협회 합창단 (wikimedia)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:NJ-Konzert_2017.jpg', 'https://upload.wikimedia.org/wikipedia/commons/c/c2/NJ-Konzert_2017.jpg', NULL, 'Wladimir1932', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', '50% 35%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 834 AND artist.english_name = 'Wiener Singverein' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/c/c2/NJ-Konzert_2017.jpg');
-- artist 835 잉글리시 바로크 솔로이스츠 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3OtZV9aCZ6G004vjOQcf59', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1f76d4d780a58b9037770f1f8', 'Spotify', NULL, NULL, NULL, '50% 40%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 835 AND artist.english_name = 'English Baroque Soloists' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1f76d4d780a58b9037770f1f8');
-- artist 838 콜레기움 보칼레 겐트 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/17BdLN9q8RRQQqyklLwac1', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1abe9ce9b3cd46dfb996c140d', 'Spotify', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 838 AND artist.english_name = 'Collegium Vocale Gent' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1abe9ce9b3cd46dfb996c140d');
-- artist 849 에사페카 살로넨 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/3ilNZUdmNZ2nUcuAOIpsQl', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1a8dcb833ba9834eca7c7c71d', 'Spotify', NULL, NULL, NULL, '52% 50%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 849 AND artist.english_name = 'Esa-Pekka Salonen' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab1a8dcb833ba9834eca7c7c71d');
-- artist 858 베를린 슈타츠카펠레 (apple_music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://music.apple.com/us/artist/5172744', 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/1c/fd/2b/1cfd2b9c-46c8-c238-3fdb-da41f87b2cdc/f10d0ca6-3040-48a7-aeea-91873e94d245.png/2880x1440sr.webp', 'Apple Music', NULL, NULL, NULL, '50% 30%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 858 AND artist.english_name = 'Berlin Staatskapelle' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/1c/fd/2b/1cfd2b9c-46c8-c238-3fdb-da41f87b2cdc/f10d0ca6-3040-48a7-aeea-91873e94d245.png/2880x1440sr.webp');
-- artist 860 크리스타 루트비히 (apple_music)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://music.apple.com/us/artist/340824', 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/b9/0a/13/b90a13c5-5f81-9ac7-2c1a-87a09f8c0d4f/mzl.pjcdwheg.jpg/2880x1440sr.webp', 'Apple Music', NULL, NULL, NULL, '51% 52%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 860 AND artist.english_name = 'Christa Ludwig' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/b9/0a/13/b90a13c5-5f81-9ac7-2c1a-87a09f8c0d4f/mzl.pjcdwheg.jpg/2880x1440sr.webp');
-- artist 871 카를로 마리아 줄리니 (spotify)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://open.spotify.com/artist/7LeEa79J3ePCT5pXKQ7Mkv', 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab129dc9c34a1d9a6da5e731aa2', 'Spotify', NULL, NULL, NULL, '40% 81%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 871 AND artist.english_name = 'Carlo Maria Giulini' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://image-cdn-ak.spotifycdn.com/image/ab6761860000eab129dc9c34a1d9a6da5e731aa2');
-- artist 895 페테르 외트뵈시 (wikimedia)
INSERT INTO entity_images (authority_entity_id, image_kind, source_url, file_url, credit_line, author, license, license_url, focal_point, is_primary, editorial_status)
SELECT artist.authority_entity_id, 'banner', 'https://commons.wikimedia.org/wiki/File:P%C3%A9ter_E%C3%B6tv%C3%B6s_by_Istvan_Huszti.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/89/P%C3%A9ter_E%C3%B6tv%C3%B6s_by_Istvan_Huszti.jpg', NULL, 'The original uploader was Riceklang at English Wikipedia.', 'Attribution', NULL, '38% 45%', TRUE, 'PUBLISHED'
FROM artists artist WHERE artist.id = 895 AND artist.english_name = 'Péter Eötvös' AND artist.authority_entity_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.image_kind = 'banner' AND existing.editorial_status = 'PUBLISHED')
  AND NOT EXISTS (SELECT 1 FROM entity_images existing WHERE existing.authority_entity_id = artist.authority_entity_id AND existing.file_url = 'https://upload.wikimedia.org/wikipedia/commons/8/89/P%C3%A9ter_E%C3%B6tv%C3%B6s_by_Istvan_Huszti.jpg');
