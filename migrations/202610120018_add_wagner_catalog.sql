-- 바그너 작품을 출판 단위로 채운다(카탈로그: WWV). 작품 61개(묶음 4, 다악장 3, 낱곡 54),
-- 새 작품 57개, 기존 작품 4개, part 30개, 그 아래 0개, 기존 낱곡 연결 0개.
--
-- 정한 것
--   오페라는 part 없이 둔다. <니벨룽의 반지>는 4부작을 part 로 둔 묶음이다.
--   대목 작품 144·146·147 은 그대로 둔다.
--
-- 공통: 자료는 seed_pipeline/curation/catalog-wave2-2026-10-12/<작곡가>/catalog.json 이고, 본문은 그 폴더의
-- gen_catalog.py 가 만든다. 위키백과 영어판 작품 목록을 기준으로 MusicBrainz work 와 맞췄다.
--   단위: 한 작품번호 아래 함께 출판된 곡은 묶음(작품 하나 + part), 악장으로 나뉜 작품은 악장을 part 로,
--     묶음 안 곡이 다시 악장으로 나뉘면 그 아래 part(parent_part_id)로 둔다. 오페라·발레·오라토리오 같은
--     무대·대형 성악 작품은 이번에는 part 없이 둔다.
--   이름: 묶음 제목은 갈래만으로 구별이 안 되면 끝에 카탈로그를 넣고("현악 4중주 Op. 18") opus_number 를
--     비운 채 catalogue_system·catalogue_number 를 채운다. 낱곡·다악장은 opus_number 에 카탈로그를 둔다.
--     part 이름에는 "1번"·"1악장" 을 넣지 않는다(번호는 sequence_number). 악장만 movement_number 를 채운다.
--     가곡 제목은 널리 쓰는 우리말이 확실할 때만 "우리말 (원제)", 아니면 원제다.
--   빼는 것: 위작(의심만 붙은 곡은 작곡가별로 아래에 적었다), 소실, 단편·스케치, 남의 작품 편곡, 민요 편곡, 같은 곡의 옛 판.
--   기존 작품: MBID 로 먼저, 없으면 카탈로그 번호로 맞춘다. 기존 작품의 제목·설명·링크는 바꾸지 않고, 비어 있는
--     작품번호·연도만 채운다. 기존 작품에 없는 다른 판 MBID(원곡 work 등)는 식별자로 더하고 기존 식별자는 그대로 둔다.
--     따로 있던 낱곡이 새 묶음 안 곡이면 part.linked_piece_id 로 잇는다.
--   part 는 EDITOR_REVIEWED 로 넣는다. 같은 MBID 가 이미 다른 작품에 있으면 작품도 식별자도 넣지 않는다.
--   방금 넣은 작품은 (작곡가, 제목, origin='manual') 로 찾는다. 두 번 돌려도 같다.

-- WWV 15 가곡집 <괴테의 '파우스트'에 의한 7개의 곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <괴테의 ''파우스트''에 의한 7개의 곡>', 'Sieben Kompositionen zu Goethes Faust', 'album', 'WWV 15', NULL, NULL, 1831, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <괴테의 ''파우스트''에 의한 7개의 곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3cec02f3-c486-4484-a325-81c645e1dddb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3cec02f3-c486-4484-a325-81c645e1dddb'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '가곡집 <괴테의 ''파우스트''에 의한 7개의 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3cec02f3-c486-4484-a325-81c645e1dddb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d1538aa-c157-4c1d-aa9a-873daed09c93', 1, NULL, 'Lied der Soldaten', 'Lied der Soldaten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '가곡집 <괴테의 ''파우스트''에 의한 7개의 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d1538aa-c157-4c1d-aa9a-873daed09c93'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a26128c5-5a03-4c4a-aca3-f74e323aeb08', 2, NULL, 'Bauer unter der Linde', 'Bauer unter der Linde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '가곡집 <괴테의 ''파우스트''에 의한 7개의 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a26128c5-5a03-4c4a-aca3-f74e323aeb08'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81fefe6a-b69d-468d-beee-d8db1ad5dfad', 3, NULL, 'Branders Lied', 'Branders Lied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '가곡집 <괴테의 ''파우스트''에 의한 7개의 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81fefe6a-b69d-468d-beee-d8db1ad5dfad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d347422-ba06-47d5-81c8-1573035c6729', 4, NULL, 'Lied des Mephistopheles I', 'Lied des Mephistopheles I "Es war einmal ein König"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '가곡집 <괴테의 ''파우스트''에 의한 7개의 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d347422-ba06-47d5-81c8-1573035c6729'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72f7b190-081b-4007-bb7e-033c1a8f1299', 5, NULL, 'Lied des Mephistopheles II', 'Lied des Mephistopheles II "Was machst du mir vor Liebchens Tür"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '가곡집 <괴테의 ''파우스트''에 의한 7개의 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72f7b190-081b-4007-bb7e-033c1a8f1299'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93442776-9b60-4fb5-b9da-d4a72cc41b58', 6, NULL, '물레 잣는 그레트헨 (Gretchen am Spinnrade)', 'Gretchen am Spinnrade "Meine Ruh ist hin"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '가곡집 <괴테의 ''파우스트''에 의한 7개의 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93442776-9b60-4fb5-b9da-d4a72cc41b58'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffeba52c-64fe-4cc5-87c2-aea2acaaeb26', 7, NULL, 'Melodram Gretchens', 'Melodram Gretchens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '가곡집 <괴테의 ''파우스트''에 의한 7개의 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffeba52c-64fe-4cc5-87c2-aea2acaaeb26'
);


-- WWV 19A 푸가 "Dein ist das Reich"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '푸가 "Dein ist das Reich"', 'Study Fugue "Dein ist das Reich"', 'song', 'WWV 19A', NULL, NULL, 1832, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '푸가 "Dein ist das Reich"'
);


-- WWV 20 연주회용 서곡 1번 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연주회용 서곡 1번 D단조', 'Concert Overture No. 1 in D minor', 'song', 'WWV 20', NULL, NULL, 1831, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연주회용 서곡 1번 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72473352-d6e2-4ab2-9c0e-f8850da67cce'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '72473352-d6e2-4ab2-9c0e-f8850da67cce'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '연주회용 서곡 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72473352-d6e2-4ab2-9c0e-f8850da67cce'
);


-- WWV 21 피아노 소나타 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 B♭장조', 'Piano Sonata in B♭ major', 'album', 'WWV 21', NULL, NULL, 1831, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed7dab35-28a3-45c3-93cf-b747e96521ce'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ed7dab35-28a3-45c3-93cf-b747e96521ce'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '피아노 소나타 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed7dab35-28a3-45c3-93cf-b747e96521ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23aed95f-7c6d-4a64-9d70-82d5205cdbc5', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '피아노 소나타 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23aed95f-7c6d-4a64-9d70-82d5205cdbc5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9903ac9-b798-4844-b3e6-4a1ddca2a8c9', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '피아노 소나타 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9903ac9-b798-4844-b3e6-4a1ddca2a8c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1adcb3fc-e00e-41e5-8297-81d9ea7b2baa', 3, 'III', '미뉴에트. Allegro', 'III. Menuetto. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '피아노 소나타 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1adcb3fc-e00e-41e5-8297-81d9ea7b2baa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:531b091e-e866-41ea-927c-c9a9c80a380f', 4, 'IV', 'Allegro vivace', 'IV. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '피아노 소나타 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:531b091e-e866-41ea-927c-c9a9c80a380f'
);


-- WWV 22 환상곡 F#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '환상곡 F#단조', 'Fantasia in F# minor', 'song', 'WWV 22', NULL, NULL, 1831, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '환상곡 F#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a5f24007-9302-4544-9eb1-6c100b205700'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a5f24007-9302-4544-9eb1-6c100b205700'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '환상곡 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a5f24007-9302-4544-9eb1-6c100b205700'
);


-- WWV 23B 네 손을 위한 폴로네즈 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '네 손을 위한 폴로네즈 D장조', 'Polonaise for Piano Four Hands in D major', 'song', 'WWV 23B', NULL, NULL, 1832, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '네 손을 위한 폴로네즈 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a13af19-f0c9-4405-a19f-fac4ddcffb7f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1a13af19-f0c9-4405-a19f-fac4ddcffb7f'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '네 손을 위한 폴로네즈 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a13af19-f0c9-4405-a19f-fac4ddcffb7f'
);


-- WWV 24 <엔치오 왕> 서곡 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<엔치오 왕> 서곡 E단조', 'Overture to König Enzio in E minor', 'song', 'WWV 24', NULL, NULL, 1832, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<엔치오 왕> 서곡 E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7bf88fdd-a1c3-476d-b5ec-7f98af9e90b0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7bf88fdd-a1c3-476d-b5ec-7f98af9e90b0'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '<엔치오 왕> 서곡 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7bf88fdd-a1c3-476d-b5ec-7f98af9e90b0'
);


-- WWV 25 비극적 간주곡 WWV 25

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '비극적 간주곡 WWV 25', '2 Entreactes tragiques, WWV 25', 'album', NULL, 'WWV', '25', 1832, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '비극적 간주곡 WWV 25'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e3d404e1-f628-4c90-8152-cbe111bf1ff2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e3d404e1-f628-4c90-8152-cbe111bf1ff2'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '비극적 간주곡 WWV 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e3d404e1-f628-4c90-8152-cbe111bf1ff2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0574ceb6-24a0-4ff1-a7c6-a7f44c305d4e', 1, NULL, 'D장조', 'No. 1 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '비극적 간주곡 WWV 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0574ceb6-24a0-4ff1-a7c6-a7f44c305d4e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e197a2de-57a1-4af4-9bd2-5e72f384e667', 2, NULL, 'C단조', 'No. 2 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '비극적 간주곡 WWV 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e197a2de-57a1-4af4-9bd2-5e72f384e667'
);


-- WWV 26 피아노 소나타 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 A장조', 'Grand Sonata in A major', 'album', 'WWV 26', NULL, NULL, 1832, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e6c93989-9436-4a9e-8a19-f06a852a2c2c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e6c93989-9436-4a9e-8a19-f06a852a2c2c'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '피아노 소나타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e6c93989-9436-4a9e-8a19-f06a852a2c2c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8e206e7-a525-43fb-b71a-a0e4c019f1f5', 1, 'I', 'Allegro con moto', 'I. Allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '피아노 소나타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8e206e7-a525-43fb-b71a-a0e4c019f1f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:002f088e-a9fa-46b7-8604-02ad6767af70', 2, 'II', 'Adagio molto, e assai espressivo', 'II. Adagio molto, e assai espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '피아노 소나타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:002f088e-a9fa-46b7-8604-02ad6767af70'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2acfba0e-c5cb-48fb-bd01-476f448c4553', 3, 'III', 'Maestoso', 'III. Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '피아노 소나타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2acfba0e-c5cb-48fb-bd01-476f448c4553'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e92d3762-6c0c-432c-99dc-85697e4e43ed', 4, 'IV', 'Allegro molto', 'IV. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '피아노 소나타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e92d3762-6c0c-432c-99dc-85697e4e43ed'
);


-- WWV 27 연주회용 서곡 2번 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연주회용 서곡 2번 C장조', 'Concert Overture No. 2 in C major', 'song', 'WWV 27', NULL, NULL, 1832, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연주회용 서곡 2번 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aa50eaf5-707a-4d41-ab45-a792dfe95117'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aa50eaf5-707a-4d41-ab45-a792dfe95117'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '연주회용 서곡 2번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aa50eaf5-707a-4d41-ab45-a792dfe95117'
);


-- WWV 29 교향곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 C장조', 'Symphony in C major', 'album', 'WWV 29', NULL, NULL, 1832, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7795343-bea4-4fbc-8a1f-fa1a458acac0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c7795343-bea4-4fbc-8a1f-fa1a458acac0'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '교향곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7795343-bea4-4fbc-8a1f-fa1a458acac0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:127ed684-b675-4ab7-a4b8-69124b76d957', 1, 'I', 'Sostenuto e maestoso – Allegro con brio', 'I. Sostenuto e maestoso – Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '교향곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:127ed684-b675-4ab7-a4b8-69124b76d957'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b6633ca-d4f1-4b5e-b1e5-b87ae4921f39', 2, 'II', 'Andante ma non troppo, un poco maestoso', 'II. Andante ma non troppo, un poco maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '교향곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b6633ca-d4f1-4b5e-b1e5-b87ae4921f39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c14c31f-4fbc-4450-9c81-77cec4096a27', 3, 'III', 'Allegro assai – Un poco meno allegro – Tempo I – Meno allegro – Presto', 'III. Allegro assai – Un poco meno allegro – Tempo I – Meno allegro – Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '교향곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c14c31f-4fbc-4450-9c81-77cec4096a27'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6dc37276-4df7-4076-b39f-b87dbc8ea2c8', 4, 'IV', 'Allegro molto e vivace – Più allegro', 'IV. Allegro molto e vivace – Più allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '교향곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dc37276-4df7-4076-b39f-b87dbc8ea2c8'
);


-- WWV 32 오페라 <요정>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <요정>', 'Die Feen', 'song', 'WWV 32', NULL, NULL, 1834, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <요정>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d843a03-945e-4583-baa7-1be8bf3bb4d0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8d843a03-945e-4583-baa7-1be8bf3bb4d0'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '오페라 <요정>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d843a03-945e-4583-baa7-1be8bf3bb4d0'
);


-- WWV 36 부수음악 <1835년 새해를 맞으며>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <1835년 새해를 맞으며>', 'Incidental music to Beim Antritt des neuen Jahres 1835', 'song', 'WWV 36', NULL, NULL, 1834, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <1835년 새해를 맞으며>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad472d8d-4b9b-4a63-9a47-1e2bdd92313a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ad472d8d-4b9b-4a63-9a47-1e2bdd92313a'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '부수음악 <1835년 새해를 맞으며>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad472d8d-4b9b-4a63-9a47-1e2bdd92313a'
);


-- WWV 37 <콜럼버스> 서곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<콜럼버스> 서곡', 'Overture to Columbus', 'song', 'WWV 37', NULL, NULL, 1835, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<콜럼버스> 서곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '511c0f86-75bc-4c6a-8ea1-1f19d479dd4e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '511c0f86-75bc-4c6a-8ea1-1f19d479dd4e'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '<콜럼버스> 서곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '511c0f86-75bc-4c6a-8ea1-1f19d479dd4e'
);


-- WWV 38 오페라 <연애 금지>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <연애 금지>', 'Das Liebesverbot', 'song', 'WWV 38', NULL, NULL, 1836, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <연애 금지>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '49959bb9-8b4f-4587-9aa5-5b9710473e91'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '49959bb9-8b4f-4587-9aa5-5b9710473e91'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '오페라 <연애 금지>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '49959bb9-8b4f-4587-9aa5-5b9710473e91'
);


-- WWV 39 <폴로니아> 서곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<폴로니아> 서곡 C장조', 'Polonia Overture in C major', 'song', 'WWV 39', NULL, NULL, 1836, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<폴로니아> 서곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dce35fd3-7feb-49e9-a0fe-8f6e184b964d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dce35fd3-7feb-49e9-a0fe-8f6e184b964d'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '<폴로니아> 서곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dce35fd3-7feb-49e9-a0fe-8f6e184b964d'
);


-- WWV 42 <룰 브리태니아> 서곡 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<룰 브리태니아> 서곡 D장조', 'Rule Britannia Overture in D major', 'song', 'WWV 42', NULL, NULL, 1837, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<룰 브리태니아> 서곡 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b75176f-67e2-48d1-ae71-5d5fa489e794'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8b75176f-67e2-48d1-ae71-5d5fa489e794'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '<룰 브리태니아> 서곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b75176f-67e2-48d1-ae71-5d5fa489e794'
);


-- WWV 43 아리아 <Sanfte Wehmut will sich regen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 <Sanfte Wehmut will sich regen>', 'Aria "Sanfte Wehmut will sich regen"', 'song', 'WWV 43', NULL, NULL, 1837, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 <Sanfte Wehmut will sich regen>'
);


-- WWV 44 민중 찬가 <니콜라이>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '민중 찬가 <니콜라이>', 'Volkshymne "Nicolay"', 'song', 'WWV 44', NULL, NULL, 1837, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '민중 찬가 <니콜라이>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ee0bc972-fe3b-4e1c-9ea6-3a1e8e72c8eb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ee0bc972-fe3b-4e1c-9ea6-3a1e8e72c8eb'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '민중 찬가 <니콜라이>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ee0bc972-fe3b-4e1c-9ea6-3a1e8e72c8eb'
);


-- WWV 50 가곡 <Der Tannenbaum>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Der Tannenbaum>', '"Der Tannenbaum"', 'song', 'WWV 50', NULL, NULL, 1838, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Der Tannenbaum>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7a3ee5d6-3f89-4077-918c-62f9f422e10b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7a3ee5d6-3f89-4077-918c-62f9f422e10b'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '가곡 <Der Tannenbaum>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7a3ee5d6-3f89-4077-918c-62f9f422e10b'
);


-- WWV 52 아리아 <Norma il predisse, o Druidi>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 <Norma il predisse, o Druidi>', 'Aria "Norma il predisse, o Druidi"', 'song', 'WWV 52', NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 <Norma il predisse, o Druidi>'
);


-- WWV 53 가곡 <Dors, mon enfant>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Dors, mon enfant>', '"Dors, mon enfant"', 'song', 'WWV 53', NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Dors, mon enfant>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '75ac550e-d4b2-421b-8804-9673b253099f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '75ac550e-d4b2-421b-8804-9673b253099f'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '가곡 <Dors, mon enfant>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '75ac550e-d4b2-421b-8804-9673b253099f'
);


-- WWV 55 가곡 <Attente>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Attente>', '"Attente"', 'song', 'WWV 55', NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Attente>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9b67146f-64c0-4f0b-9da8-65f943e0970c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9b67146f-64c0-4f0b-9da8-65f943e0970c'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '가곡 <Attente>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9b67146f-64c0-4f0b-9da8-65f943e0970c'
);


-- WWV 57 가곡 <Mignonne>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Mignonne>', '"Mignonne"', 'song', 'WWV 57', NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Mignonne>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '57089cc8-1e76-4b56-8181-5f547004f523'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '57089cc8-1e76-4b56-8181-5f547004f523'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '가곡 <Mignonne>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '57089cc8-1e76-4b56-8181-5f547004f523'
);


-- WWV 58 가곡 <Tout n'est qu'images fugitives>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Tout n''est qu''images fugitives>', '"Tout n''est qu''images fugitives" (Soupir)', 'song', 'WWV 58', NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Tout n''est qu''images fugitives>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b08f963-724a-41dd-bccf-3d2892370a3e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0b08f963-724a-41dd-bccf-3d2892370a3e'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '가곡 <Tout n''est qu''images fugitives>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b08f963-724a-41dd-bccf-3d2892370a3e'
);


-- WWV 59 <파우스트> 서곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<파우스트> 서곡', 'A Faust Overture', 'song', 'WWV 59', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<파우스트> 서곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '15947da1-b5e7-30b2-8c5d-e6d5d978dbcf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '15947da1-b5e7-30b2-8c5d-e6d5d978dbcf'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '<파우스트> 서곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '15947da1-b5e7-30b2-8c5d-e6d5d978dbcf'
);


-- WWV 60 가곡 <두 척탄병>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <두 척탄병>', '"Les deux grenadiers"', 'song', 'WWV 60', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <두 척탄병>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31354aaf-9a36-4311-8c14-9f7236964cce'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '31354aaf-9a36-4311-8c14-9f7236964cce'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '가곡 <두 척탄병>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31354aaf-9a36-4311-8c14-9f7236964cce'
);


-- WWV 61 가곡 <Adieux de Marie Stuart>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Adieux de Marie Stuart>', '"Adieux de Marie Stuart"', 'song', 'WWV 61', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Adieux de Marie Stuart>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc399865-d0e8-471e-ba67-deda6a837a8b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fc399865-d0e8-471e-ba67-deda6a837a8b'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '가곡 <Adieux de Marie Stuart>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc399865-d0e8-471e-ba67-deda6a837a8b'
);


-- WWV 64 앨범의 한 페이지 "무언가"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 "무언가"', 'Albumblatt für Ernst Benedikt Kietz "Lied ohne Worte"', 'song', 'WWV 64', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 "무언가"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec1339bc-1f0c-4aec-96ba-f62e5ded4c9c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ec1339bc-1f0c-4aec-96ba-f62e5ded4c9c'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '앨범의 한 페이지 "무언가"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec1339bc-1f0c-4aec-96ba-f62e5ded4c9c'
);


-- WWV 65 합창곡 <Descendons gaiement la courtille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Descendons gaiement la courtille>', '"Descendons gaiement la courtille"', 'song', 'WWV 65', NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Descendons gaiement la courtille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '20eba493-7a54-48a3-bbaf-ff010f9581fd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '20eba493-7a54-48a3-bbaf-ff010f9581fd'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '합창곡 <Descendons gaiement la courtille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '20eba493-7a54-48a3-bbaf-ff010f9581fd'
);


-- WWV 68 축전가 <Der Tag erscheint>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '축전가 <Der Tag erscheint>', 'Festgesang "Der Tag erscheint"', 'song', 'WWV 68', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '축전가 <Der Tag erscheint>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a6ead63e-8f52-46e0-a7c6-1a9b96d23f47'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a6ead63e-8f52-46e0-a7c6-1a9b96d23f47'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '축전가 <Der Tag erscheint>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a6ead63e-8f52-46e0-a7c6-1a9b96d23f47'
);


-- WWV 69 성서 장면 <사도들의 애찬>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성서 장면 <사도들의 애찬>', 'Das Liebesmahl der Apostel', 'song', 'WWV 69', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성서 장면 <사도들의 애찬>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae0c15b9-37e0-443f-b06b-de06ebcc268d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ae0c15b9-37e0-443f-b06b-de06ebcc268d'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '성서 장면 <사도들의 애찬>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae0c15b9-37e0-443f-b06b-de06ebcc268d'
);


-- WWV 71 합창곡 <Gruß seiner Treuen an Friedrich August, den Geliebten>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Gruß seiner Treuen an Friedrich August, den Geliebten>', '"Gruß seiner Treuen an Friedrich August, den Geliebten"', 'song', 'WWV 71', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Gruß seiner Treuen an Friedrich August, den Geliebten>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ccedb98-ced8-4e1e-8185-8a2bb81073cc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6ccedb98-ced8-4e1e-8185-8a2bb81073cc'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '합창곡 <Gruß seiner Treuen an Friedrich August, den Geliebten>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ccedb98-ced8-4e1e-8185-8a2bb81073cc'
);


-- WWV 72 합창곡 <An Webers Grabe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <An Webers Grabe>', '"An Webers Grabe"', 'song', 'WWV 72', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <An Webers Grabe>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '57c3f752-22a7-4b18-9b63-00a06ab355d6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '57c3f752-22a7-4b18-9b63-00a06ab355d6'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '합창곡 <An Webers Grabe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '57c3f752-22a7-4b18-9b63-00a06ab355d6'
);


-- WWV 73 베버의 <오이리안테> 주제에 의한 장송 음악

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '베버의 <오이리안테> 주제에 의한 장송 음악', 'Trauermusik on Motifs from Weber''s Euryanthe', 'song', 'WWV 73', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '베버의 <오이리안테> 주제에 의한 장송 음악'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6bd179d9-9688-4b50-baec-da6881c6d137'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6bd179d9-9688-4b50-baec-da6881c6d137'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '베버의 <오이리안테> 주제에 의한 장송 음악' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6bd179d9-9688-4b50-baec-da6881c6d137'
);


-- WWV 75 오페라 <로엔그린>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <로엔그린>', 'Lohengrin', 'song', 'WWV 75', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <로엔그린>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1d774427-c5f5-4bc9-9fd6-040f8ff4381c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1d774427-c5f5-4bc9-9fd6-040f8ff4381c'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '오페라 <로엔그린>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1d774427-c5f5-4bc9-9fd6-040f8ff4381c'
);


-- WWV 84 폴카

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카', 'Polka', 'song', 'WWV 84', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b5312e59-ee0d-4bd6-bf42-8c0cf96fc803'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b5312e59-ee0d-4bd6-bf42-8c0cf96fc803'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '폴카' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b5312e59-ee0d-4bd6-bf42-8c0cf96fc803'
);


-- WWV 85 베젠동크 부인의 앨범을 위한 소나타 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '베젠동크 부인의 앨범을 위한 소나타 A♭장조', 'Eine Sonate für das Album von Frau M. W. in A♭ major', 'song', 'WWV 85', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '베젠동크 부인의 앨범을 위한 소나타 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '91ef5337-50df-4c32-833b-2b034ef3913b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '91ef5337-50df-4c32-833b-2b034ef3913b'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '베젠동크 부인의 앨범을 위한 소나타 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '91ef5337-50df-4c32-833b-2b034ef3913b'
);


-- WWV 86 오페라 <니벨룽의 반지>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <니벨룽의 반지>', 'Der Ring des Nibelungen', 'album', 'WWV 86', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <니벨룽의 반지>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '597e017a-2c97-40c0-9eeb-430a0461e4ad'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '597e017a-2c97-40c0-9eeb-430a0461e4ad'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '오페라 <니벨룽의 반지>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '597e017a-2c97-40c0-9eeb-430a0461e4ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45798fca-2c83-41a6-8ca8-031e208c63cc', 1, NULL, '라인의 황금 (Das Rheingold)', 'Das Rheingold', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '오페라 <니벨룽의 반지>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45798fca-2c83-41a6-8ca8-031e208c63cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a87e8996-da9e-49a8-80f2-c5d8342b67e6', 2, NULL, '발퀴레 (Die Walküre)', 'Die Walküre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '오페라 <니벨룽의 반지>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a87e8996-da9e-49a8-80f2-c5d8342b67e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcf065d9-40b2-4054-8e71-d471b4f77222', 3, NULL, '지크프리트 (Siegfried)', 'Siegfried', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '오페라 <니벨룽의 반지>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcf065d9-40b2-4054-8e71-d471b4f77222'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c906f057-e479-418d-a96a-ffa639c8f8c8', 4, NULL, '신들의 황혼 (Götterdämmerung)', 'Götterdämmerung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '오페라 <니벨룽의 반지>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c906f057-e479-418d-a96a-ffa639c8f8c8'
);


-- WWV 88 왈츠 <Züricher Vielliebchen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Züricher Vielliebchen>', 'Züricher Vielliebchen-Walzer', 'song', 'WWV 88', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Züricher Vielliebchen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3acc49f2-d0c7-4582-8bc5-62346775ef90'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3acc49f2-d0c7-4582-8bc5-62346775ef90'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '왈츠 <Züricher Vielliebchen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3acc49f2-d0c7-4582-8bc5-62346775ef90'
);


-- WWV 91 가곡집 <베젠동크 가곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <베젠동크 가곡>', 'Wesendonck Lieder', 'album', 'WWV 91', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <베젠동크 가곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd015d335-311a-442b-b6be-67df75ae030c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd015d335-311a-442b-b6be-67df75ae030c'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '가곡집 <베젠동크 가곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd015d335-311a-442b-b6be-67df75ae030c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:933f31cd-d314-3cc7-b1e9-52061f3c7ae4', 1, NULL, '천사 (Der Engel)', 'Der Engel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '가곡집 <베젠동크 가곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:933f31cd-d314-3cc7-b1e9-52061f3c7ae4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ac91964-85b4-3560-8ad8-ae57201e797f', 2, NULL, '멈추어라! (Stehe still!)', 'Stehe still!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '가곡집 <베젠동크 가곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ac91964-85b4-3560-8ad8-ae57201e797f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51c9e0c0-461c-3c0f-b014-7130d6cedff4', 3, NULL, '온실에서 (Im Treibhaus)', 'Im Treibhaus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '가곡집 <베젠동크 가곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51c9e0c0-461c-3c0f-b014-7130d6cedff4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5baf505-b1bd-39f4-b469-aaa95a0223fc', 4, NULL, '고통 (Schmerzen)', 'Schmerzen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '가곡집 <베젠동크 가곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5baf505-b1bd-39f4-b469-aaa95a0223fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b56d9900-8941-3f53-ba16-d01d1365da1e', 5, NULL, '꿈 (Träume)', 'Träume', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '가곡집 <베젠동크 가곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b56d9900-8941-3f53-ba16-d01d1365da1e'
);


-- WWV 91B 바이올린과 소관현악을 위한 <꿈>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 소관현악을 위한 <꿈>', 'Träume, for violin and chamber orchestra', 'song', 'WWV 91B', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 소관현악을 위한 <꿈>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3033ec74-90d0-4fe7-b5ce-6100dee5ec92'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3033ec74-90d0-4fe7-b5ce-6100dee5ec92'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '바이올린과 소관현악을 위한 <꿈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3033ec74-90d0-4fe7-b5ce-6100dee5ec92'
);


-- WWV 93 엘레지 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '엘레지 A♭장조', 'Elegy in A♭ major', 'song', 'WWV 93', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '엘레지 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1998556b-f369-45c6-8341-1c200be67d00'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1998556b-f369-45c6-8341-1c200be67d00'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '엘레지 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1998556b-f369-45c6-8341-1c200be67d00'
);


-- WWV 94 앨범의 한 페이지 C장조 (메테르니히 공작 부인에게)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 C장조 (메테르니히 공작 부인에게)', 'Albumblatt in C major (In das Album der Fürstin M.)', 'song', 'WWV 94', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 C장조 (메테르니히 공작 부인에게)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ece6082-78cb-4931-bc65-4e7d24cc1700'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4ece6082-78cb-4931-bc65-4e7d24cc1700'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '앨범의 한 페이지 C장조 (메테르니히 공작 부인에게)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ece6082-78cb-4931-bc65-4e7d24cc1700'
);


-- WWV 95 피아노곡 <Ankunft bei den schwarzen Schwänen> A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노곡 <Ankunft bei den schwarzen Schwänen> A♭장조', 'Ankunft bei den schwarzen Schwänen in A♭ major', 'song', 'WWV 95', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노곡 <Ankunft bei den schwarzen Schwänen> A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '637aa640-ec67-48a6-8946-6be191f0e6ec'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '637aa640-ec67-48a6-8946-6be191f0e6ec'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '피아노곡 <Ankunft bei den schwarzen Schwänen> A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '637aa640-ec67-48a6-8946-6be191f0e6ec'
);


-- WWV 96 오페라 <뉘른베르크의 마이스터징어>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <뉘른베르크의 마이스터징어>', 'Die Meistersinger von Nürnberg', 'song', 'WWV 96', NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <뉘른베르크의 마이스터징어>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d644732-9876-4b0d-9c2c-b6a738d6530e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4d644732-9876-4b0d-9c2c-b6a738d6530e'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '오페라 <뉘른베르크의 마이스터징어>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d644732-9876-4b0d-9c2c-b6a738d6530e'
);


-- WWV 97 <경의의 행진곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<경의의 행진곡>', 'Huldigungsmarsch', 'song', 'WWV 97', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<경의의 행진곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52c74dfc-b9a2-480a-9b69-857ab2fb5244'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '52c74dfc-b9a2-480a-9b69-857ab2fb5244'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '<경의의 행진곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52c74dfc-b9a2-480a-9b69-857ab2fb5244'
);


-- WWV 101 합창곡 <Wahlspruch für die Deutsche Feuerwehr>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Wahlspruch für die Deutsche Feuerwehr>', '"Wahlspruch für die Deutsche Feuerwehr"', 'song', 'WWV 101', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Wahlspruch für die Deutsche Feuerwehr>'
);


-- WWV 103 지크프리트 목가

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '지크프리트 목가', 'Siegfried Idyll', 'song', 'WWV 103', NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '지크프리트 목가'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b7db99d4-0ee1-3383-8ace-5900a0864d80'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b7db99d4-0ee1-3383-8ace-5900a0864d80'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '지크프리트 목가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b7db99d4-0ee1-3383-8ace-5900a0864d80'
);


-- WWV 104 황제 행진곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '황제 행진곡', 'Kaisermarsch', 'song', 'WWV 104', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '황제 행진곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3b6eadda-0289-4aee-8cc1-c9074958482d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3b6eadda-0289-4aee-8cc1-c9074958482d'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '황제 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3b6eadda-0289-4aee-8cc1-c9074958482d'
);


-- WWV 105 가곡 <Der Worte viele sind gemacht>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Der Worte viele sind gemacht>', '"Der Worte viele sind gemacht"', 'song', 'WWV 105', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Der Worte viele sind gemacht>'
);


-- WWV 106 합창곡 <Kinderkatechismus zu Kosels Geburtstag>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Kinderkatechismus zu Kosels Geburtstag>', '"Kinderkatechismus zu Kosels Geburtstag"', 'song', 'WWV 106', NULL, NULL, 1873, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Kinderkatechismus zu Kosels Geburtstag>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '848c0c0b-491c-4156-97c9-284ededf7041'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '848c0c0b-491c-4156-97c9-284ededf7041'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '합창곡 <Kinderkatechismus zu Kosels Geburtstag>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '848c0c0b-491c-4156-97c9-284ededf7041'
);


-- WWV 108 앨범의 한 페이지 E♭장조 (베티 쇼트 부인에게)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 E♭장조 (베티 쇼트 부인에게)', 'Albumblatt in E♭ major (für Frau Betty Schott)', 'song', 'WWV 108', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 E♭장조 (베티 쇼트 부인에게)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24e9a754-5229-431e-83ba-3b86a183cec2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '24e9a754-5229-431e-83ba-3b86a183cec2'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '앨범의 한 페이지 E♭장조 (베티 쇼트 부인에게)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24e9a754-5229-431e-83ba-3b86a183cec2'
);


-- WWV 110 미국 독립 100주년 기념 행진곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미국 독립 100주년 기념 행진곡', 'Grand Festival March (Centennial March)', 'song', 'WWV 110', NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미국 독립 100주년 기념 행진곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58a476f9-5c85-4b30-b12e-1aef0fd179ec'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '58a476f9-5c85-4b30-b12e-1aef0fd179ec'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '미국 독립 100주년 기념 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58a476f9-5c85-4b30-b12e-1aef0fd179ec'
);


-- WWV 111 오페라 <파르지팔>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <파르지팔>', 'Parsifal', 'song', 'WWV 111', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <파르지팔>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98434ad8-13d9-49dc-ab9b-b1821a7eb407'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '98434ad8-13d9-49dc-ab9b-b1821a7eb407'
FROM pieces p
WHERE p.composer_id = 31 AND p.title = '오페라 <파르지팔>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98434ad8-13d9-49dc-ab9b-b1821a7eb407'
);


-- WWV 112 합창곡 <Willkommen in Wahnfried, du heil'ger Christ>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Willkommen in Wahnfried, du heil''ger Christ>', '"Willkommen in Wahnfried, du heil''ger Christ"', 'song', 'WWV 112', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Willkommen in Wahnfried, du heil''ger Christ>'
);


-- WWV 113 합창곡 <Ihr Kinder, geschwinde, geschwinde>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Ihr Kinder, geschwinde, geschwinde>', '"Ihr Kinder, geschwinde, geschwinde"', 'song', 'WWV 113', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 31
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Ihr Kinder, geschwinde, geschwinde>'
);

