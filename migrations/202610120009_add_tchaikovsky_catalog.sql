-- 차이콥스키 작품을 출판 단위로 채운다. 작품 138개(묶음 30, 다악장 25, 낱곡 83), part 308, 그 아래 6.
-- 새 작품 129개, 기존 9개.
--
-- 정한 것
--   작품번호 작품(Op. 1–80, 37a·67b·71a)과 작품번호 없는 완성 작품(TH 번호, 러시아어 위키백과 표 기준)을 넣는다.
--   <대장장이 바쿨라> Op. 14 는 <체레비치키> TH 8 의 옛 판이라 뺀다.
--   <사계>·<어린이를 위한 앨범>·가곡 세트는 묶음이고, 정교회 합창 대작(Op. 41·52)과 칸타타 <모스크바> 는 part 없이 둔다.
--   159 피아노 협주곡 1번의 기존 MBID 는 1874/75년 원판 work 라, 늘 연주되는 1888년 판 work 를 식별자로 더한다.
--   가곡 제목은 라틴 문자 원제이고, 널리 쓰는 우리말이 있는 다섯 곡만 우리말을 붙인다.
--
-- 공통: 자료는 seed_pipeline/curation/catalog-wave1-2026-10-11/<작곡가>/catalog.json 이고, 본문은 그 폴더의
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

-- Op. 1 2개의 소품 Op. 1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 소품 Op. 1', '2 Pieces, Op. 1', 'album', NULL, 'Op.', '1', 1867, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 소품 Op. 1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58914837-142f-4754-b3ea-ccefd964d28a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '58914837-142f-4754-b3ea-ccefd964d28a'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '2개의 소품 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58914837-142f-4754-b3ea-ccefd964d28a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71d49fb1-d61f-487c-b509-4e9a0f6a7b04', 1, NULL, '러시아풍 스케르초 B♭장조', 'Scherzo à la russe in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '2개의 소품 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71d49fb1-d61f-487c-b509-4e9a0f6a7b04'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7bad6323-e7b0-47c7-8369-89661b0f0a5a', 2, NULL, '즉흥곡 E♭단조', 'Impromptu in E♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '2개의 소품 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bad6323-e7b0-47c7-8369-89661b0f0a5a'
);


-- Op. 2 피아노 모음곡 <합살의 추억>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <합살의 추억>', 'Souvenir de Hapsal, Op. 2', 'album', 'Op. 2', NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <합살의 추억>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5dc366bf-d767-4530-a4fe-76f959922b02'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5dc366bf-d767-4530-a4fe-76f959922b02'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <합살의 추억>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5dc366bf-d767-4530-a4fe-76f959922b02'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef4b1e7d-c482-47b2-a77c-c196badc8377', 1, NULL, '성의 폐허 E단조', 'Ruines d''un château in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <합살의 추억>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef4b1e7d-c482-47b2-a77c-c196badc8377'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39706676-648d-4227-a370-8f57b99e8d04', 2, NULL, '스케르초 F장조', 'Scherzo in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <합살의 추억>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39706676-648d-4227-a370-8f57b99e8d04'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1739becc-94d4-4d42-b39a-ec4bcafc8734', 3, NULL, '무언가 F장조', 'Chant sans paroles in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <합살의 추억>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1739becc-94d4-4d42-b39a-ec4bcafc8734'
);


-- Op. 3 오페라 <보예보다>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <보예보다>', 'The Voyevoda', 'song', 'Op. 3', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <보예보다>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e3dc220-08a2-418b-85f1-d83afd131c42'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9e3dc220-08a2-418b-85f1-d83afd131c42'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '오페라 <보예보다>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e3dc220-08a2-418b-85f1-d83afd131c42'
);


-- Op. 4 왈츠-카프리스 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠-카프리스 D장조', 'Valse-caprice in D major', 'song', 'Op. 4', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠-카프리스 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17ccf450-81a6-4c8d-8f22-f35476db18a2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '17ccf450-81a6-4c8d-8f22-f35476db18a2'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '왈츠-카프리스 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17ccf450-81a6-4c8d-8f22-f35476db18a2'
);


-- Op. 5 로망스 F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스 F단조', 'Romance in F minor', 'song', 'Op. 5', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스 F단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '60507d3c-2d04-454d-ac73-f07705c02e12'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '60507d3c-2d04-454d-ac73-f07705c02e12'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '로망스 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '60507d3c-2d04-454d-ac73-f07705c02e12'
);


-- Op. 6 6개의 로망스 Op. 6

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 로망스 Op. 6', '6 Romances, Op. 6', 'album', NULL, 'Op.', '6', 1869, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 로망스 Op. 6'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b90d06df-c853-40f8-9613-f1267e139997'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b90d06df-c853-40f8-9613-f1267e139997'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b90d06df-c853-40f8-9613-f1267e139997'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73fdf0e1-0efb-494c-924b-8b14bbcdd28f', 1, NULL, 'Ne ver'', moy drug', 'Ne ver'', moy drug', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73fdf0e1-0efb-494c-924b-8b14bbcdd28f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38b0afba-2409-335b-a03a-827d31c640a6', 2, NULL, 'Ni slova, o drug moy', 'Ni slova, o drug moy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38b0afba-2409-335b-a03a-827d31c640a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b031363f-a7c4-4b12-9b5b-ab45e44eba26', 3, NULL, 'I bol''no, i sladko', 'I bol''no, i sladko', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b031363f-a7c4-4b12-9b5b-ab45e44eba26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d51cee9-79ba-4ac4-b7d1-f6d99a8ae9b6', 4, NULL, 'Sleza drozhit', 'Sleza drozhit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d51cee9-79ba-4ac4-b7d1-f6d99a8ae9b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c091e7ae-c690-304b-9d53-11934a5fa260', 5, NULL, 'Otchego?', 'Otchego?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c091e7ae-c690-304b-9d53-11934a5fa260'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9798921-8527-3cff-9148-4716fd473a95', 6, NULL, '오직 그리움을 아는 이만이 (Net, tol''ko tot, kto znal)', 'Net, tol''ko tot, kto znal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9798921-8527-3cff-9148-4716fd473a95'
);


-- Op. 7 왈츠-스케르초 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠-스케르초 A장조', 'Valse-scherzo in A major', 'song', 'Op. 7', NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠-스케르초 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5de4e67-04f9-467d-a1c0-45b6e766ed41'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd5de4e67-04f9-467d-a1c0-45b6e766ed41'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '왈츠-스케르초 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5de4e67-04f9-467d-a1c0-45b6e766ed41'
);


-- Op. 8 카프리치오 G♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카프리치오 G♭장조', 'Capriccio in G♭ major', 'song', 'Op. 8', NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카프리치오 G♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '265acc43-b7be-456a-9c92-2e326468fddc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '265acc43-b7be-456a-9c92-2e326468fddc'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '카프리치오 G♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '265acc43-b7be-456a-9c92-2e326468fddc'
);


-- Op. 9 3개의 소품 Op. 9

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 소품 Op. 9', '3 Pieces, Op. 9', 'album', NULL, 'Op.', '9', 1870, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 소품 Op. 9'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '232d17a5-81ec-4013-83f2-18d895c8e87a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '232d17a5-81ec-4013-83f2-18d895c8e87a'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '3개의 소품 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '232d17a5-81ec-4013-83f2-18d895c8e87a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1bc8162-5dde-41d5-9f41-9cefc45b12df', 1, NULL, '몽상 D장조', 'Rêverie in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '3개의 소품 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1bc8162-5dde-41d5-9f41-9cefc45b12df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c02b930-f606-425c-854d-530e8619920a', 2, NULL, '살롱 폴카 B♭장조', 'Polka de salon in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '3개의 소품 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c02b930-f606-425c-854d-530e8619920a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5efb6fb9-e1b0-4f85-be24-43852b2a3050', 3, NULL, '살롱 마주르카 D단조', 'Mazurka de salon in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '3개의 소품 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5efb6fb9-e1b0-4f85-be24-43852b2a3050'
);


-- Op. 10 2개의 소품 Op. 10

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 소품 Op. 10', '2 Pieces, Op. 10', 'album', NULL, 'Op.', '10', 1872, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 소품 Op. 10'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '37ca2168-3e46-45e6-b355-3cf44d0c1cd2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '37ca2168-3e46-45e6-b355-3cf44d0c1cd2'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '2개의 소품 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '37ca2168-3e46-45e6-b355-3cf44d0c1cd2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d141ed0-ef8f-4e09-9de6-8e7dcf61405c', 1, NULL, '녹턴 F장조', 'Nocturne in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '2개의 소품 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d141ed0-ef8f-4e09-9de6-8e7dcf61405c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72505921-7dd0-4838-9ccf-1c52a375421c', 2, NULL, '유머레스크 G장조', 'Humoresque in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '2개의 소품 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72505921-7dd0-4838-9ccf-1c52a375421c'
);


-- Op. 11 현악 4중주 1번 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 1번 D장조', 'String Quartet No. 1 in D major', 'album', 'Op. 11', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 1번 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd82aa643-dfd6-4445-9902-38c77ae097f1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd82aa643-dfd6-4445-9902-38c77ae097f1'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '현악 4중주 1번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd82aa643-dfd6-4445-9902-38c77ae097f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:868b7860-c371-37aa-b365-a1c41400d374', 1, 'I', 'Moderato e semplice', 'I. Moderato e semplice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '현악 4중주 1번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:868b7860-c371-37aa-b365-a1c41400d374'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88fea0aa-d715-3f95-b8b1-9faed741ab94', 2, 'II', 'Andante cantabile', 'II. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '현악 4중주 1번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88fea0aa-d715-3f95-b8b1-9faed741ab94'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f10a211-8c5d-3f71-8351-a36ea1bd0364', 3, 'III', '스케르초. Allegro non tanto e con fuoco', 'III. Scherzo. Allegro non tanto e con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '현악 4중주 1번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f10a211-8c5d-3f71-8351-a36ea1bd0364'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbf2ca10-849e-3834-92a4-140a6f49998b', 4, 'IV', '피날레. Allegro giusto', 'IV. Finale. Allegro giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '현악 4중주 1번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbf2ca10-849e-3834-92a4-140a6f49998b'
);


-- Op. 12 부수음악 <눈 아가씨>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <눈 아가씨>', 'The Snow Maiden, incidental music', 'song', 'Op. 12', NULL, NULL, 1873, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <눈 아가씨>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ee7d1b91-30cc-45dd-89aa-25f454a557b7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ee7d1b91-30cc-45dd-89aa-25f454a557b7'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '부수음악 <눈 아가씨>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ee7d1b91-30cc-45dd-89aa-25f454a557b7'
);


-- Op. 13 교향곡 1번 G단조 "겨울날의 환상"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 1번 G단조 "겨울날의 환상"', 'Symphony No. 1 in G minor "Winter Daydreams"', 'album', 'Op. 13', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 1번 G단조 "겨울날의 환상"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e590ef34-65ac-30dc-8f50-c57f5757c26b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e590ef34-65ac-30dc-8f50-c57f5757c26b'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향곡 1번 G단조 "겨울날의 환상"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e590ef34-65ac-30dc-8f50-c57f5757c26b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0ac6cfa-987c-3b49-a530-1483a41a3ea4', 1, 'I', 'Allegro tranquillo "겨울 여행의 꿈"', 'I. Allegro tranquillo "Dreams of a Winter Journey"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향곡 1번 G단조 "겨울날의 환상"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0ac6cfa-987c-3b49-a530-1483a41a3ea4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c337d341-dc5d-3c3f-a862-2826bddba8be', 2, 'II', 'Adagio cantabile ma non tanto "음울한 땅, 안개의 땅"', 'II. Adagio cantabile ma non tanto "Land of Desolation, Land of Mists"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향곡 1번 G단조 "겨울날의 환상"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c337d341-dc5d-3c3f-a862-2826bddba8be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a14fe9ed-ec6d-3ae0-b615-5ba96ee8fc6c', 3, 'III', '스케르초. Allegro scherzando giocoso', 'III. Scherzo. Allegro scherzando giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향곡 1번 G단조 "겨울날의 환상"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a14fe9ed-ec6d-3ae0-b615-5ba96ee8fc6c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fa259ce-69c3-3232-b52a-f46133791ccd', 4, 'IV', '피날레. Andante lugubre – Allegro maestoso', 'IV. Finale. Andante lugubre – Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향곡 1번 G단조 "겨울날의 환상"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fa259ce-69c3-3232-b52a-f46133791ccd'
);


-- Op. 15 덴마크 국가에 의한 축전 서곡 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '덴마크 국가에 의한 축전 서곡 D장조', 'Festival Overture on the Danish National Anthem in D major', 'song', 'Op. 15', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '덴마크 국가에 의한 축전 서곡 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b50999f-a44a-4c6c-8c44-5c32211012e9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8b50999f-a44a-4c6c-8c44-5c32211012e9'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '덴마크 국가에 의한 축전 서곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b50999f-a44a-4c6c-8c44-5c32211012e9'
);


-- Op. 16 6개의 로망스 Op. 16

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 로망스 Op. 16', '6 Romances, Op. 16', 'album', NULL, 'Op.', '16', 1873, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 로망스 Op. 16'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '020c1dd1-4615-4179-8d24-fb6264ecc03b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '020c1dd1-4615-4179-8d24-fb6264ecc03b'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '020c1dd1-4615-4179-8d24-fb6264ecc03b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d960edce-9614-4d23-8c1d-5b2a37229c67', 1, NULL, '자장가 (Kolybel''naya pesnya)', 'Kolybel''naya pesnya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d960edce-9614-4d23-8c1d-5b2a37229c67'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ae36bca-ecc2-413a-8371-b6dda7a02da8', 2, NULL, 'Pogodi!', 'Pogodi!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ae36bca-ecc2-413a-8371-b6dda7a02da8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3eec1f51-cdcd-4428-898e-473a08513632', 3, NULL, 'Poymi khot'' raz', 'Poymi khot'' raz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3eec1f51-cdcd-4428-898e-473a08513632'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb419426-e770-428c-bc8d-af0ef6d679ad', 4, NULL, 'O, spoy zhe tu pesnyu', 'O, spoy zhe tu pesnyu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb419426-e770-428c-bc8d-af0ef6d679ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:090a4b97-48ac-4999-9d24-58c847a24f7a', 5, NULL, 'Tak chto zhe', 'Tak chto zhe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:090a4b97-48ac-4999-9d24-58c847a24f7a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41c51487-37cc-4774-8c68-ea84aa12a5f8', 6, NULL, 'Novogrecheskaya pesnya', 'Novogrecheskaya pesnya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41c51487-37cc-4774-8c68-ea84aa12a5f8'
);


-- Op. 17 교향곡 2번 C단조 "소러시아"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 2번 C단조 "소러시아"', 'Symphony No. 2 in C minor "Little Russian"', 'album', 'Op. 17', NULL, NULL, 1872, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 2번 C단조 "소러시아"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9127971c-4f4b-3c15-bf6e-a846e33ebb3f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9127971c-4f4b-3c15-bf6e-a846e33ebb3f'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향곡 2번 C단조 "소러시아"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9127971c-4f4b-3c15-bf6e-a846e33ebb3f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7539cf83-31ef-3110-a474-6ca25abe2778', 1, 'I', 'Andante sostenuto – Allegro vivo', 'I. Andante sostenuto – Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향곡 2번 C단조 "소러시아"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7539cf83-31ef-3110-a474-6ca25abe2778'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c76f5fa-19f9-3f1f-b7c2-aab61f3f97de', 2, 'II', 'Andantino marziale, quasi moderato', 'II. Andantino marziale, quasi moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향곡 2번 C단조 "소러시아"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c76f5fa-19f9-3f1f-b7c2-aab61f3f97de'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fb3df8d-eae4-3015-ba8f-2287ebc8c278', 3, 'III', '스케르초. Allegro molto vivace', 'III. Scherzo. Allegro molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향곡 2번 C단조 "소러시아"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fb3df8d-eae4-3015-ba8f-2287ebc8c278'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6704635d-d9d7-35d8-ba8c-5c78f6e00c3a', 4, 'IV', '피날레. Moderato assai – Allegro vivo', 'IV. Finale. Moderato assai – Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향곡 2번 C단조 "소러시아"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6704635d-d9d7-35d8-ba8c-5c78f6e00c3a'
);


-- Op. 18 교향적 환상곡 <템페스트>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향적 환상곡 <템페스트>', 'The Tempest, Symphonic Fantasia in F minor', 'song', 'Op. 18', NULL, NULL, 1873, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향적 환상곡 <템페스트>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0dcb4dec-2451-37fd-9afc-3301166ef5ef'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0dcb4dec-2451-37fd-9afc-3301166ef5ef'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향적 환상곡 <템페스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0dcb4dec-2451-37fd-9afc-3301166ef5ef'
);


-- Op. 19 6개의 소품 Op. 19

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 소품 Op. 19', '6 Pieces, Op. 19', 'album', NULL, 'Op.', '19', 1873, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 소품 Op. 19'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '020706a6-60ff-4d5d-a625-95304d3e322f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '020706a6-60ff-4d5d-a625-95304d3e322f'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 소품 Op. 19' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '020706a6-60ff-4d5d-a625-95304d3e322f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ace599c6-bb15-4b64-bd6a-bf235ca185e8', 1, NULL, '저녁의 몽상 G단조', 'Rêverie du soir in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 소품 Op. 19' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ace599c6-bb15-4b64-bd6a-bf235ca185e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1db4815-5a08-4278-b008-63c042a8ac77', 2, NULL, '유머러스한 스케르초 D장조', 'Scherzo humoristique in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 소품 Op. 19' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1db4815-5a08-4278-b008-63c042a8ac77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2403752-b0f9-432b-9168-48bce0d890fb', 3, NULL, '앨범의 한 장 D장조', 'Feuillet d''album in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 소품 Op. 19' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2403752-b0f9-432b-9168-48bce0d890fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8da96e56-0c34-30f7-af6e-75a56cc2f122', 4, NULL, '녹턴 C#단조', 'Nocturne in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 소품 Op. 19' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8da96e56-0c34-30f7-af6e-75a56cc2f122'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8521772c-349d-4d7b-b27b-2309758c83e9', 5, NULL, '카프리치오소 B♭장조', 'Capriccioso in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 소품 Op. 19' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8521772c-349d-4d7b-b27b-2309758c83e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9de6fcec-d935-4484-bfdf-42824ac3fbcf', 6, NULL, '독창적 주제와 변주 F장조', 'Thème original et variations in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 소품 Op. 19' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9de6fcec-d935-4484-bfdf-42824ac3fbcf'
);


-- Op. 21 하나의 주제에 의한 6개의 소품 Op. 21

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하나의 주제에 의한 6개의 소품 Op. 21', '6 Pieces on a Single Theme, Op. 21', 'album', NULL, 'Op.', '21', 1873, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하나의 주제에 의한 6개의 소품 Op. 21'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf7eafb7-eae5-4dec-9980-a1aa34d01674'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bf7eafb7-eae5-4dec-9980-a1aa34d01674'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '하나의 주제에 의한 6개의 소품 Op. 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf7eafb7-eae5-4dec-9980-a1aa34d01674'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42be9171-7fe5-4bb4-93ca-f83dabb5d674', 1, NULL, '전주곡 B장조', 'Prélude in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '하나의 주제에 의한 6개의 소품 Op. 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42be9171-7fe5-4bb4-93ca-f83dabb5d674'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7222c71-7809-4a61-8649-6ab84baf18bb', 2, NULL, '4성 푸가 G#단조', 'Fugue à 4 voix in G# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '하나의 주제에 의한 6개의 소품 Op. 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7222c71-7809-4a61-8649-6ab84baf18bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d706f69-f3f6-4253-88a5-ca124362ecc7', 3, NULL, '즉흥곡 C#단조', 'Impromptu in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '하나의 주제에 의한 6개의 소품 Op. 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d706f69-f3f6-4253-88a5-ca124362ecc7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:364edad6-2fb5-41fa-9414-e4141cf5351d', 4, NULL, '장송 행진곡 A♭단조', 'Marche funèbre in A♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '하나의 주제에 의한 6개의 소품 Op. 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:364edad6-2fb5-41fa-9414-e4141cf5351d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae5a0c3b-0e40-47b5-9769-ea3d08b57170', 5, NULL, '마주르카 A♭단조', 'Mazurka in A♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '하나의 주제에 의한 6개의 소품 Op. 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae5a0c3b-0e40-47b5-9769-ea3d08b57170'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f31360a4-7d53-44b8-8464-ed4d93cef55b', 6, NULL, '스케르초 A♭장조', 'Scherzo in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '하나의 주제에 의한 6개의 소품 Op. 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f31360a4-7d53-44b8-8464-ed4d93cef55b'
);


-- Op. 22 현악 4중주 2번 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 2번 F장조', 'String Quartet No. 2 in F major', 'album', 'Op. 22', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 2번 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f935861-5b75-3c5a-83fb-a0ee6bdc5410'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3f935861-5b75-3c5a-83fb-a0ee6bdc5410'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '현악 4중주 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f935861-5b75-3c5a-83fb-a0ee6bdc5410'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b105097d-a1e2-3cbc-b3ee-36a47889b05e', 1, 'I', 'Adagio – Moderato assai', 'I. Adagio – Moderato assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '현악 4중주 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b105097d-a1e2-3cbc-b3ee-36a47889b05e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0abef7f6-f89c-32cd-8fa7-ada372638dc6', 2, 'II', '스케르초. Allegro giusto', 'II. Scherzo. Allegro giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '현악 4중주 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0abef7f6-f89c-32cd-8fa7-ada372638dc6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26b161e8-4f6b-3150-ae4d-9a34e705a123', 3, 'III', 'Andante ma non tanto', 'III. Andante ma non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '현악 4중주 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26b161e8-4f6b-3150-ae4d-9a34e705a123'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df6ca4e8-b7bd-3944-b1f2-4af5c3ce6142', 4, 'IV', '피날레. Allegro con moto', 'IV. Finale. Allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '현악 4중주 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df6ca4e8-b7bd-3944-b1f2-4af5c3ce6142'
);


-- Op. 23 피아노 협주곡 1번 B♭단조

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '03c670e9-d1fb-4874-bb51-022c689328cd'
FROM pieces p
WHERE p.id = 159 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '03c670e9-d1fb-4874-bb51-022c689328cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08b27018-d462-38a4-a070-1f4af8167b3e', 1, 'I', 'Allegro non troppo e molto maestoso – Allegro con spirito', 'I. Allegro non troppo e molto maestoso – Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 159 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08b27018-d462-38a4-a070-1f4af8167b3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a72eacf-ea9a-34e5-bb4f-7e4b8133e8f8', 2, 'II', 'Andantino semplice', 'II. Andantino semplice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 159 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a72eacf-ea9a-34e5-bb4f-7e4b8133e8f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e046f64-34e4-378f-be9b-fd298902cddb', 3, 'III', 'Allegro con fuoco', 'III. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 159 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e046f64-34e4-378f-be9b-fd298902cddb'
);


-- Op. 24 오페라 <예브게니 오네긴>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <예브게니 오네긴>', 'Eugene Onegin', 'song', 'Op. 24', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <예브게니 오네긴>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '279613e8-cb1f-4556-8a96-2c69f8b854b4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '279613e8-cb1f-4556-8a96-2c69f8b854b4'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '오페라 <예브게니 오네긴>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '279613e8-cb1f-4556-8a96-2c69f8b854b4'
);


-- Op. 25 6개의 로망스 Op. 25

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 로망스 Op. 25', '6 Romances, Op. 25', 'album', NULL, 'Op.', '25', 1875, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 로망스 Op. 25'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac1fa542-f656-4581-b72c-1255cf2c1012'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ac1fa542-f656-4581-b72c-1255cf2c1012'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac1fa542-f656-4581-b72c-1255cf2c1012'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4882d24c-fe2d-3613-b226-fabf283e573a', 1, NULL, 'Primirenie', 'Primirenie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4882d24c-fe2d-3613-b226-fabf283e573a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b62a5c3-c584-4fc3-a22f-2030a81082f8', 2, NULL, 'Kak nad goryacheyu zoloy', 'Kak nad goryacheyu zoloy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b62a5c3-c584-4fc3-a22f-2030a81082f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9f17a4a-bc6a-4c09-8e27-70304b5e36c9', 3, NULL, '미뇽의 노래 (Pesn'' Min''ony)', 'Pesn'' Min''ony', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9f17a4a-bc6a-4c09-8e27-70304b5e36c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0be19b3-35e2-45bc-8ed9-54b006bd0141', 4, NULL, 'Kanareyka', 'Kanareyka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0be19b3-35e2-45bc-8ed9-54b006bd0141'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6ae0cec-da95-482c-bd65-665ec1e83f01', 5, NULL, 'Ya s neyu nikogda ne govoril', 'Ya s neyu nikogda ne govoril', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6ae0cec-da95-482c-bd65-665ec1e83f01'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:510e6430-82b0-439e-b2e4-e075852aca72', 6, NULL, 'Kak naladili: "Durak"', 'Kak naladili: "Durak"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:510e6430-82b0-439e-b2e4-e075852aca72'
);


-- Op. 26 우울한 세레나데 B♭단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '우울한 세레나데 B♭단조', 'Sérénade mélancolique in B♭ minor', 'song', 'Op. 26', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '우울한 세레나데 B♭단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3912d1e-4bde-3400-962d-11d2027d65f7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c3912d1e-4bde-3400-962d-11d2027d65f7'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '우울한 세레나데 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3912d1e-4bde-3400-962d-11d2027d65f7'
);


-- Op. 27 6개의 로망스 Op. 27

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 로망스 Op. 27', '6 Romances, Op. 27', 'album', NULL, 'Op.', '27', 1875, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 로망스 Op. 27'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad7da006-fe52-4b39-9998-c6f8ec1e92c0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ad7da006-fe52-4b39-9998-c6f8ec1e92c0'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad7da006-fe52-4b39-9998-c6f8ec1e92c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84bbdf74-fb44-41b7-8d1e-01934d2af095', 1, NULL, 'Na son gryadushchiy', 'Na son gryadushchiy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84bbdf74-fb44-41b7-8d1e-01934d2af095'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:101cb275-0a24-40cc-8b2b-86321e178adb', 2, NULL, 'Smotri: von oblako!', 'Smotri: von oblako!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:101cb275-0a24-40cc-8b2b-86321e178adb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58bf8e18-bd0c-4504-b7f1-45fcf7535163', 3, NULL, 'Ne otkhodi ot menya!', 'Ne otkhodi ot menya!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58bf8e18-bd0c-4504-b7f1-45fcf7535163'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85af912c-59a1-4d42-91d3-639f3ed5e633', 4, NULL, 'Vecher', 'Vecher', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85af912c-59a1-4d42-91d3-639f3ed5e633'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:263aaf24-bf7a-49bc-8494-0e3696b9691c', 5, NULL, 'Ali mat'' menya rozhala', 'Ali mat'' menya rozhala', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:263aaf24-bf7a-49bc-8494-0e3696b9691c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40890691-dd89-45ff-89da-50877f71d300', 6, NULL, 'Moya balovnitsa', 'Moya balovnitsa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40890691-dd89-45ff-89da-50877f71d300'
);


-- Op. 28 6개의 로망스 Op. 28

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 로망스 Op. 28', '6 Romances, Op. 28', 'album', NULL, 'Op.', '28', 1875, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 로망스 Op. 28'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd78ec190-0ec2-42e4-a8a9-cea83809305d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd78ec190-0ec2-42e4-a8a9-cea83809305d'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 28' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd78ec190-0ec2-42e4-a8a9-cea83809305d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25d2c3b4-a39d-4c20-9480-6de83a9bdfdb', 1, NULL, 'Net, nikogda ne nazovu', 'Net, nikogda ne nazovu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 28' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25d2c3b4-a39d-4c20-9480-6de83a9bdfdb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a74a772-50fc-4488-8c4d-65a6de94c0e5', 2, NULL, 'Korol''ki', 'Korol''ki', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 28' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a74a772-50fc-4488-8c4d-65a6de94c0e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57b5705b-92f7-48df-b0b5-19f69f75d276', 3, NULL, 'Zachem?', 'Zachem?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 28' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57b5705b-92f7-48df-b0b5-19f69f75d276'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91ea728d-bedc-4787-89fd-ccd576b40340', 4, NULL, 'On tak menya lyubil', 'On tak menya lyubil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 28' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91ea728d-bedc-4787-89fd-ccd576b40340'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c70e5e07-4898-4bc8-b946-76bbd62cf920', 5, NULL, 'Ni otzyva, ni slova, ni priveta', 'Ni otzyva, ni slova, ni priveta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 28' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c70e5e07-4898-4bc8-b946-76bbd62cf920'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54a2627d-fdfc-32e2-ad60-be90e7d0a0ae', 6, NULL, 'Strashnaya minuta', 'Strashnaya minuta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 28' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54a2627d-fdfc-32e2-ad60-be90e7d0a0ae'
);


-- Op. 29 교향곡 3번 D장조 "폴란드"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 3번 D장조 "폴란드"', 'Symphony No. 3 in D major "Polish"', 'album', 'Op. 29', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 3번 D장조 "폴란드"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e920883e-6f16-3341-85ce-b2a4d3342ad4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e920883e-6f16-3341-85ce-b2a4d3342ad4'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향곡 3번 D장조 "폴란드"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e920883e-6f16-3341-85ce-b2a4d3342ad4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f5993be-366c-3a57-936b-619b3df5fb9e', 1, 'I', '서주와 알레그로. Moderato assai – Allegro brillante', 'I. Introduzione e Allegro. Moderato assai – Allegro brillante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향곡 3번 D장조 "폴란드"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f5993be-366c-3a57-936b-619b3df5fb9e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e2e5253-a991-3bcc-865a-683e5630fea1', 2, 'II', 'Alla tedesca. Allegro moderato e semplice', 'II. Alla tedesca. Allegro moderato e semplice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향곡 3번 D장조 "폴란드"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e2e5253-a991-3bcc-865a-683e5630fea1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4798a053-303b-34b6-929d-68a87054beef', 3, 'III', 'Andante elegiaco', 'III. Andante elegiaco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향곡 3번 D장조 "폴란드"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4798a053-303b-34b6-929d-68a87054beef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a274663-06a7-3912-8bb1-cbaf512f989d', 4, 'IV', '스케르초. Allegro vivo', 'IV. Scherzo. Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향곡 3번 D장조 "폴란드"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a274663-06a7-3912-8bb1-cbaf512f989d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f916d2d5-7a8a-3df7-93ae-f4d61637ab29', 5, 'V', '피날레. Allegro con fuoco (Tempo di polacca)', 'V. Finale. Allegro con fuoco (Tempo di polacca)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향곡 3번 D장조 "폴란드"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f916d2d5-7a8a-3df7-93ae-f4d61637ab29'
);


-- Op. 30 현악 4중주 3번 E♭단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 3번 E♭단조', 'String Quartet No. 3 in E♭ minor', 'album', 'Op. 30', NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 3번 E♭단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d04b490-c719-4d31-b582-c8656b59b4da'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9d04b490-c719-4d31-b582-c8656b59b4da'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '현악 4중주 3번 E♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d04b490-c719-4d31-b582-c8656b59b4da'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a49cb95-cf7b-32ab-a43c-d965aa340fbf', 1, 'I', 'Andante sostenuto – Allegro moderato', 'I. Andante sostenuto – Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '현악 4중주 3번 E♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a49cb95-cf7b-32ab-a43c-d965aa340fbf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02bc2e82-d828-32c1-9ae7-966692865ef2', 2, 'II', 'Allegretto vivo e scherzando', 'II. Allegretto vivo e scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '현악 4중주 3번 E♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02bc2e82-d828-32c1-9ae7-966692865ef2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b6f9165-7973-3971-a8e9-fabc50ebf3bc', 3, 'III', 'Andante funebre e doloroso, ma con moto', 'III. Andante funebre e doloroso, ma con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '현악 4중주 3번 E♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b6f9165-7973-3971-a8e9-fabc50ebf3bc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3cbd547-0623-3db7-bbf1-65699d5af1b3', 4, 'IV', '피날레. Allegro non troppo e risoluto', 'IV. Finale. Allegro non troppo e risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '현악 4중주 3번 E♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3cbd547-0623-3db7-bbf1-65699d5af1b3'
);


-- Op. 31 슬라브 행진곡 B♭단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '슬라브 행진곡 B♭단조', 'Marche slave in B♭ minor', 'song', 'Op. 31', NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '슬라브 행진곡 B♭단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ce528d4-7f4a-39a6-a653-f6b95b0ac464'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6ce528d4-7f4a-39a6-a653-f6b95b0ac464'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '슬라브 행진곡 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ce528d4-7f4a-39a6-a653-f6b95b0ac464'
);


-- Op. 32 교향적 환상곡 <프란체스카 다 리미니>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향적 환상곡 <프란체스카 다 리미니>', 'Francesca da Rimini, Symphonic Fantasia in E minor', 'song', 'Op. 32', NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향적 환상곡 <프란체스카 다 리미니>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fa8bc8fc-c113-363e-b91a-8613a62cf8b2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fa8bc8fc-c113-363e-b91a-8613a62cf8b2'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향적 환상곡 <프란체스카 다 리미니>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fa8bc8fc-c113-363e-b91a-8613a62cf8b2'
);


-- Op. 33 로코코 주제에 의한 변주곡 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로코코 주제에 의한 변주곡 A장조', 'Variations on a Rococo Theme in A major', 'song', 'Op. 33', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로코코 주제에 의한 변주곡 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '942499a7-49de-377e-82f7-3c9e4ef82fbb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '942499a7-49de-377e-82f7-3c9e4ef82fbb'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '로코코 주제에 의한 변주곡 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '942499a7-49de-377e-82f7-3c9e4ef82fbb'
);


-- Op. 34 바이올린과 관현악을 위한 왈츠-스케르초 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 관현악을 위한 왈츠-스케르초 C장조', 'Valse-scherzo in C major for violin and orchestra', 'song', 'Op. 34', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 관현악을 위한 왈츠-스케르초 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b42716e2-eb57-3607-8d78-867b3861d329'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b42716e2-eb57-3607-8d78-867b3861d329'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '바이올린과 관현악을 위한 왈츠-스케르초 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b42716e2-eb57-3607-8d78-867b3861d329'
);


-- Op. 35 바이올린 협주곡 D장조

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de172280-45e0-359d-9221-2189643b664f', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 160 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de172280-45e0-359d-9221-2189643b664f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e270e79d-160f-356c-9c17-ba027d972521', 2, 'II', '칸초네타. Andante', 'II. Canzonetta. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 160 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e270e79d-160f-356c-9c17-ba027d972521'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6cefd27-a6c3-3fad-b8d7-a0c37d96569e', 3, 'III', '피날레. Allegro vivacissimo', 'III. Finale. Allegro vivacissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 160 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6cefd27-a6c3-3fad-b8d7-a0c37d96569e'
);


-- Op. 36 교향곡 4번 F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 4번 F단조', 'Symphony No. 4 in F minor', 'album', 'Op. 36', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 4번 F단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b9655de0-e548-4749-84e8-1e8bda13a4a4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b9655de0-e548-4749-84e8-1e8bda13a4a4'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향곡 4번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b9655de0-e548-4749-84e8-1e8bda13a4a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f7c1943-f8af-3029-b7f1-385166a1b0fa', 1, 'I', 'Andante sostenuto – Moderato con anima', 'I. Andante sostenuto – Moderato con anima', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향곡 4번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f7c1943-f8af-3029-b7f1-385166a1b0fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6298d2c-9d67-375b-a588-bb32adb4cbfd', 2, 'II', 'Andantino in modo di canzona', 'II. Andantino in modo di canzona', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향곡 4번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6298d2c-9d67-375b-a588-bb32adb4cbfd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85e2616b-6dfe-30d1-9a6d-9c07bc3a6a89', 3, 'III', '스케르초. Pizzicato ostinato. Allegro', 'III. Scherzo. Pizzicato ostinato. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향곡 4번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85e2616b-6dfe-30d1-9a6d-9c07bc3a6a89'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:623e6cd8-3859-3e52-903c-0ceb4305b9cd', 4, 'IV', '피날레. Allegro con fuoco', 'IV. Finale. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향곡 4번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:623e6cd8-3859-3e52-903c-0ceb4305b9cd'
);


-- Op. 37 그랜드 소나타 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '그랜드 소나타 G장조', 'Grand Sonata in G major', 'album', 'Op. 37', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '그랜드 소나타 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7fb7599-b95b-4bcf-ad77-8174cc61e30c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a7fb7599-b95b-4bcf-ad77-8174cc61e30c'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '그랜드 소나타 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7fb7599-b95b-4bcf-ad77-8174cc61e30c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8ebdd7b-cb3f-3cc9-9911-b9aa5e133522', 1, 'I', 'Moderato e risoluto', 'I. Moderato e risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '그랜드 소나타 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8ebdd7b-cb3f-3cc9-9911-b9aa5e133522'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c37aa18-686d-32ad-ba6c-0f2af6321226', 2, 'II', 'Andante non troppo quasi moderato', 'II. Andante non troppo quasi moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '그랜드 소나타 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c37aa18-686d-32ad-ba6c-0f2af6321226'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9f81933-377f-3e90-9343-24d6636468a4', 3, 'III', '스케르초. Allegro giocoso', 'III. Scherzo. Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '그랜드 소나타 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9f81933-377f-3e90-9343-24d6636468a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4190d23-4a98-3d85-983b-2b5114d5f610', 4, 'IV', '피날레. Allegro vivace', 'IV. Finale. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '그랜드 소나타 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4190d23-4a98-3d85-983b-2b5114d5f610'
);


-- Op. 37a 피아노 모음곡 <사계>

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6460a645-9844-3042-960a-e0eb34339470', 1, NULL, '1월: 난롯가에서', 'January: At the Fireside', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26034 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6460a645-9844-3042-960a-e0eb34339470'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9eb26bd-2d34-3903-afcd-c85010be76d3', 2, NULL, '2월: 사육제', 'February: Carnival', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26034 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9eb26bd-2d34-3903-afcd-c85010be76d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1adc59b-c23d-3015-9daf-1716e374ed64', 3, NULL, '3월: 종달새의 노래', 'March: Song of the Lark', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26034 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1adc59b-c23d-3015-9daf-1716e374ed64'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d364de99-f08f-3229-88e2-2d1e5e457130', 4, NULL, '4월: 설강화', 'April: Snowdrop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26034 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d364de99-f08f-3229-88e2-2d1e5e457130'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0fcf2bc-9344-37e6-a377-1a143f6776d5', 5, NULL, '5월: 백야', 'May: Starlit Nights', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26034 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0fcf2bc-9344-37e6-a377-1a143f6776d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97abe0e5-11f8-3080-b327-9210760a3376', 6, NULL, '6월: 뱃노래', 'June: Barcarolle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26034 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97abe0e5-11f8-3080-b327-9210760a3376'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43198a46-81be-3ce3-8bc0-4bdea2db80da', 7, NULL, '7월: 풀 베는 이의 노래', 'July: Song of the Reaper', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26034 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43198a46-81be-3ce3-8bc0-4bdea2db80da'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76f98337-460c-3998-9e0b-2c389b0df345', 8, NULL, '8월: 추수', 'August: Harvest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26034 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76f98337-460c-3998-9e0b-2c389b0df345'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58e2eb4f-6cee-358f-baea-c54e368979c8', 9, NULL, '9월: 사냥', 'September: The Hunt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26034 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58e2eb4f-6cee-358f-baea-c54e368979c8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b03dde30-6ae2-32e8-a067-58d8932bb701', 10, NULL, '10월: 가을의 노래', 'October: Autumn Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26034 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b03dde30-6ae2-32e8-a067-58d8932bb701'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:432dd63f-4645-34ad-942d-1dd616bfaa08', 11, NULL, '11월: 트로이카', 'November: Troika', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26034 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:432dd63f-4645-34ad-942d-1dd616bfaa08'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a023af1-58db-3ceb-910a-b7268b349900', 12, NULL, '12월: 크리스마스', 'December: Christmas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26034 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a023af1-58db-3ceb-910a-b7268b349900'
);


-- Op. 38 6개의 로망스 Op. 38

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 로망스 Op. 38', '6 Romances, Op. 38', 'album', NULL, 'Op.', '38', 1878, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 로망스 Op. 38'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7dfc9379-2d4d-432e-a086-41b6b2e0d33c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7dfc9379-2d4d-432e-a086-41b6b2e0d33c'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7dfc9379-2d4d-432e-a086-41b6b2e0d33c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b60c8e43-6e20-4255-b207-2cb546b0dc6b', 1, NULL, '돈 후안의 세레나데 (Serenada Don-Zhuana)', 'Serenada Don-Zhuana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b60c8e43-6e20-4255-b207-2cb546b0dc6b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55e723bb-efb2-4818-998c-0372520b06af', 2, NULL, 'To bylo ranneyu vesnoy', 'To bylo ranneyu vesnoy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55e723bb-efb2-4818-998c-0372520b06af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c29e6f3-c674-48bd-91ec-e5a0fdb037de', 3, NULL, 'Sred'' shumnogo bala', 'Sred'' shumnogo bala', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c29e6f3-c674-48bd-91ec-e5a0fdb037de'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b8f4943-2650-414b-ae4b-5a5aef711b8b', 4, NULL, 'O, yesli b ty mogla', 'O, yesli b ty mogla', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b8f4943-2650-414b-ae4b-5a5aef711b8b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c0c6294-8bd2-421e-a06a-a831d557bca1', 5, NULL, 'Lyubov'' mertvetsa', 'Lyubov'' mertvetsa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c0c6294-8bd2-421e-a06a-a831d557bca1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb7b1470-453e-4661-8e23-83b44c42bee1', 6, NULL, 'Pimpinella', 'Pimpinella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb7b1470-453e-4661-8e23-83b44c42bee1'
);


-- Op. 39 피아노 모음곡 <어린이를 위한 앨범>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <어린이를 위한 앨범>', 'Album for the Young, Op. 39', 'album', 'Op. 39', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <어린이를 위한 앨범>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1642ebe0-91f2-4c89-bdab-0a162b18b2b8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1642ebe0-91f2-4c89-bdab-0a162b18b2b8'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1642ebe0-91f2-4c89-bdab-0a162b18b2b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:858e5b29-1219-4613-b1a5-21cbdf405bc1', 1, NULL, '아침 기도', 'Morning Prayer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:858e5b29-1219-4613-b1a5-21cbdf405bc1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aae905a6-1dba-4f2e-9ff7-8973cfe67afb', 2, NULL, '겨울 아침', 'Winter Morning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aae905a6-1dba-4f2e-9ff7-8973cfe67afb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1846d2ff-571b-446c-952a-3f85c3672bd2', 3, NULL, '목마 놀이', 'Playing Hobby-Horses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1846d2ff-571b-446c-952a-3f85c3672bd2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f70d126-46cf-426c-be6e-caa96ac9ef13', 4, NULL, '엄마', 'Mama', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f70d126-46cf-426c-be6e-caa96ac9ef13'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd263bd9-2807-41a0-b579-cce326238b68', 5, NULL, '나무 병정의 행진', 'March of the Wooden Soldiers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd263bd9-2807-41a0-b579-cce326238b68'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3f81b84-6ac8-4cdb-89d6-b8afc4c7135d', 6, NULL, '아픈 인형', 'The Sick Doll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3f81b84-6ac8-4cdb-89d6-b8afc4c7135d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d96d9f6-2c5b-40ea-9b0c-03edadd58660', 7, NULL, '인형의 장례식', 'The Doll''s Funeral', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d96d9f6-2c5b-40ea-9b0c-03edadd58660'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28a1a26c-76aa-45d0-bc69-6f59ed7b30bc', 8, NULL, '왈츠', 'Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28a1a26c-76aa-45d0-bc69-6f59ed7b30bc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:341727f4-9e19-439b-aacb-c8e167356926', 9, NULL, '새 인형', 'The New Doll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:341727f4-9e19-439b-aacb-c8e167356926'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68328a7f-7a7b-485f-adb2-d0b1b7de77bb', 10, NULL, '마주르카', 'Mazurka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68328a7f-7a7b-485f-adb2-d0b1b7de77bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b05eab9d-177a-4372-a008-b0e94940a949', 11, NULL, '러시아 노래', 'Russian Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b05eab9d-177a-4372-a008-b0e94940a949'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f3bbfa2-25de-4c3e-9b92-8d9e5af6344d', 12, NULL, '아코디언 켜는 농부', 'The Peasant Plays the Accordion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f3bbfa2-25de-4c3e-9b92-8d9e5af6344d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a511e062-3405-4f22-bf94-ea8f719d04c6', 13, NULL, '카마린스카야', 'Kamarinskaya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a511e062-3405-4f22-bf94-ea8f719d04c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e02c246-91f8-47ec-9845-c20f41d36535', 14, NULL, '폴카', 'Polka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e02c246-91f8-47ec-9845-c20f41d36535'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9210757b-fa6c-400e-8381-7d287399ab84', 15, NULL, '이탈리아 노래', 'Italian Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9210757b-fa6c-400e-8381-7d287399ab84'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7de46d2a-bed9-4c78-bac5-c27b369ea9f4', 16, NULL, '옛 프랑스 노래', 'Old French Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7de46d2a-bed9-4c78-bac5-c27b369ea9f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0567648f-fb56-4b25-ac15-6382a42b8a25', 17, NULL, '독일 노래', 'German Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0567648f-fb56-4b25-ac15-6382a42b8a25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eed5c53c-78b7-40cf-90d9-63dd0b51fe6e', 18, NULL, '나폴리 노래', 'Neapolitan Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eed5c53c-78b7-40cf-90d9-63dd0b51fe6e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee02a69f-9351-423d-9c20-0207e674f855', 19, NULL, '유모의 옛이야기', 'Nanny''s Story', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee02a69f-9351-423d-9c20-0207e674f855'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb97f8e1-c610-4866-a5ce-868e5eec1daa', 20, NULL, '바바야가', 'Baba Yaga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb97f8e1-c610-4866-a5ce-868e5eec1daa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06b14193-9786-491b-a607-08b4948a0b80', 21, NULL, '달콤한 꿈', 'Sweet Dreams', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06b14193-9786-491b-a607-08b4948a0b80'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:675d5c48-f8d0-46c8-9b4d-d061aea53fdc', 22, NULL, '종달새의 노래', 'Lark Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:675d5c48-f8d0-46c8-9b4d-d061aea53fdc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1d9323c-ca14-4971-a0f1-b55e16bc28d7', 23, NULL, '손풍금 장수의 노래', 'The Organ-Grinder Sings', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1d9323c-ca14-4971-a0f1-b55e16bc28d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f984d443-0d3b-48c2-b83f-d36ad2ffa9bc', 24, NULL, '교회에서', 'In Church', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 모음곡 <어린이를 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f984d443-0d3b-48c2-b83f-d36ad2ffa9bc'
);


-- Op. 40 12개의 소품 Op. 40

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '12개의 소품 Op. 40', '12 Pieces, Op. 40', 'album', NULL, 'Op.', '40', 1878, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '12개의 소품 Op. 40'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '63bce950-3251-42e2-9f0e-06c31d294679'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '63bce950-3251-42e2-9f0e-06c31d294679'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 소품 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '63bce950-3251-42e2-9f0e-06c31d294679'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a58df3e-117c-4fa5-a6d3-2c7d909f3b69', 1, NULL, '연습곡 G장조', 'Étude in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 소품 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a58df3e-117c-4fa5-a6d3-2c7d909f3b69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78ac2bfd-b931-4d4c-bc2d-989c016ec786', 2, NULL, '슬픈 노래 G단조', 'Chanson triste in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 소품 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78ac2bfd-b931-4d4c-bc2d-989c016ec786'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e57f5e6b-00ff-4f01-b83a-b3578f57659c', 3, NULL, '장송 행진곡 C단조', 'Marche funèbre in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 소품 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e57f5e6b-00ff-4f01-b83a-b3578f57659c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:020663b5-3910-4c11-8b41-024630eddd91', 4, NULL, '마주르카 C장조', 'Mazurka in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 소품 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:020663b5-3910-4c11-8b41-024630eddd91'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c673f0e-ae7f-429f-92f6-7fe34cdd7d8f', 5, NULL, '마주르카 D장조', 'Mazurka in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 소품 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c673f0e-ae7f-429f-92f6-7fe34cdd7d8f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af7ee7e0-b25c-4502-8d81-a52587e54ee4', 6, NULL, '무언가 A단조', 'Chant sans paroles in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 소품 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af7ee7e0-b25c-4502-8d81-a52587e54ee4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5068e5a1-4ece-4c30-83b4-f2d119841a1b', 7, NULL, '시골에서 A단조', 'Au village in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 소품 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5068e5a1-4ece-4c30-83b4-f2d119841a1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:549cd5d1-4a53-4b3a-9365-010d084019e8', 8, NULL, '왈츠 A♭장조', 'Valse in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 소품 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:549cd5d1-4a53-4b3a-9365-010d084019e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b871f7d5-4e1b-46e7-9e34-bae91e4fa506', 9, NULL, '왈츠 F#단조', 'Valse in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 소품 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b871f7d5-4e1b-46e7-9e34-bae91e4fa506'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46701368-639d-4e48-9df5-35bd9d60ee39', 10, NULL, '러시아 춤 A단조', 'Danse russe in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 소품 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46701368-639d-4e48-9df5-35bd9d60ee39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7aef2642-fd70-4d9b-be71-2ebb29b36bf7', 11, NULL, '스케르초 D단조', 'Scherzo in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 소품 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7aef2642-fd70-4d9b-be71-2ebb29b36bf7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86a93825-d92e-4f66-9908-ba97af75fac1', 12, NULL, '중단된 몽상 A♭장조', 'Rêverie interrompue in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 소품 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86a93825-d92e-4f66-9908-ba97af75fac1'
);


-- Op. 41 성 요한 크리소스톰의 전례

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성 요한 크리소스톰의 전례', 'Liturgy of St John Chrysostom', 'song', 'Op. 41', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성 요한 크리소스톰의 전례'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '010ca6c1-96a5-4a5e-8aab-e1de58c3fce5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '010ca6c1-96a5-4a5e-8aab-e1de58c3fce5'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '성 요한 크리소스톰의 전례' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '010ca6c1-96a5-4a5e-8aab-e1de58c3fce5'
);


-- Op. 42 바이올린 소품집 <소중한 곳의 추억>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소품집 <소중한 곳의 추억>', 'Souvenir d''un lieu cher, Op. 42', 'album', 'Op. 42', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소품집 <소중한 곳의 추억>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b1cfed5-4ca3-4ff0-b879-ed57c1d13bfb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8b1cfed5-4ca3-4ff0-b879-ed57c1d13bfb'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '바이올린 소품집 <소중한 곳의 추억>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b1cfed5-4ca3-4ff0-b879-ed57c1d13bfb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15efd8a1-0dda-3fb1-b108-6e35834bd48c', 1, NULL, '명상 D단조', 'Méditation in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '바이올린 소품집 <소중한 곳의 추억>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15efd8a1-0dda-3fb1-b108-6e35834bd48c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16acf3e4-7549-3213-9f97-e49ed2b6a190', 2, NULL, '스케르초 C단조', 'Scherzo in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '바이올린 소품집 <소중한 곳의 추억>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16acf3e4-7549-3213-9f97-e49ed2b6a190'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d982bfce-1198-3155-a683-c1769218c1ef', 3, NULL, '멜로디 E♭장조', 'Mélodie in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '바이올린 소품집 <소중한 곳의 추억>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d982bfce-1198-3155-a683-c1769218c1ef'
);


-- Op. 43 관현악 모음곡 1번 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 모음곡 1번 D단조', 'Orchestral Suite No. 1 in D minor', 'album', 'Op. 43', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 모음곡 1번 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d3709d0-a791-4241-be2c-63578e4ae5cb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4d3709d0-a791-4241-be2c-63578e4ae5cb'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '관현악 모음곡 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d3709d0-a791-4241-be2c-63578e4ae5cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07f68ac3-816f-46a8-9afd-4892b0339927', 1, 'I', '서주와 푸가. Andante sostenuto – Moderato e con anima', 'I. Introduzione e fuga. Andante sostenuto – Moderato e con anima', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '관현악 모음곡 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07f68ac3-816f-46a8-9afd-4892b0339927'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1a28232-7d5f-4096-bd61-6349c5124e20', 2, 'II', '디베르티멘토. Allegro moderato', 'II. Divertimento. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '관현악 모음곡 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1a28232-7d5f-4096-bd61-6349c5124e20'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a172d05-065d-4b25-b927-407d31b37575', 3, 'III', '인테르메초. Andantino semplice', 'III. Intermezzo. Andantino semplice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '관현악 모음곡 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a172d05-065d-4b25-b927-407d31b37575'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:beda3938-6a0a-3eb0-9007-8982e5f9ff6a', 4, 'IV', 'Marche miniature. Moderato con moto', 'IV. Marche miniature. Moderato con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '관현악 모음곡 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:beda3938-6a0a-3eb0-9007-8982e5f9ff6a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84fdd1bd-5fbc-4bbd-bcd7-cdf6ab3c9b24', 5, 'V', '스케르초. Allegro con moto', 'V. Scherzo. Allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '관현악 모음곡 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84fdd1bd-5fbc-4bbd-bcd7-cdf6ab3c9b24'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe0c6899-79f8-42d8-8fba-f48244079a07', 6, 'VI', '가보트. Allegro', 'VI. Gavotte. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '관현악 모음곡 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe0c6899-79f8-42d8-8fba-f48244079a07'
);


-- Op. 44 피아노 협주곡 2번 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 2번 G장조', 'Piano Concerto No. 2 in G major', 'album', 'Op. 44', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 2번 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '843460cd-0fee-4d12-bd1c-60a45e204939'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '843460cd-0fee-4d12-bd1c-60a45e204939'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 협주곡 2번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '843460cd-0fee-4d12-bd1c-60a45e204939'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a078158-c1cf-3105-ac80-ca1dc6b46e3f', 1, 'I', 'Allegro brillante e molto vivace', 'I. Allegro brillante e molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 협주곡 2번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a078158-c1cf-3105-ac80-ca1dc6b46e3f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ec164c4-dd09-34fe-a876-cb8a9e5ace43', 2, 'II', 'Andante non troppo', 'II. Andante non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 협주곡 2번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ec164c4-dd09-34fe-a876-cb8a9e5ace43'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:424ea713-eea4-317d-965b-09eef633116a', 3, 'III', 'Allegro con fuoco', 'III. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 협주곡 2번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:424ea713-eea4-317d-965b-09eef633116a'
);


-- Op. 45 이탈리아 기상곡 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '이탈리아 기상곡 A장조', 'Capriccio italien in A major', 'song', 'Op. 45', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '이탈리아 기상곡 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '854f7f28-f202-3d7a-a424-abc659e7f70e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '854f7f28-f202-3d7a-a424-abc659e7f70e'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '이탈리아 기상곡 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '854f7f28-f202-3d7a-a424-abc659e7f70e'
);


-- Op. 46 6개의 이중창 Op. 46

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 이중창 Op. 46', '6 Duets, Op. 46', 'album', NULL, 'Op.', '46', 1880, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 이중창 Op. 46'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb279a48-cdcf-40c4-832f-e6aea8b80746'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bb279a48-cdcf-40c4-832f-e6aea8b80746'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 이중창 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb279a48-cdcf-40c4-832f-e6aea8b80746'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61cef1dd-dfc4-440d-aa41-eb0d69880ba9', 1, NULL, 'Vecher', 'Vecher', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 이중창 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61cef1dd-dfc4-440d-aa41-eb0d69880ba9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87cc457a-c35f-4edb-8aac-8504e32d1348', 2, NULL, 'Shotlandskaya ballada', 'Shotlandskaya ballada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 이중창 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87cc457a-c35f-4edb-8aac-8504e32d1348'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b983be4-7de2-427d-8eab-61d2a9e5ad1c', 3, NULL, 'Slyozy', 'Slyozy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 이중창 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b983be4-7de2-427d-8eab-61d2a9e5ad1c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dad79601-d8b4-46af-b998-afbcd614ee34', 4, NULL, 'V ogorode, vozle brodu', 'V ogorode, vozle brodu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 이중창 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dad79601-d8b4-46af-b998-afbcd614ee34'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:377f1121-4ff5-4ebc-899b-c2ac0813b46b', 5, NULL, 'Minula strast''', 'Minula strast''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 이중창 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:377f1121-4ff5-4ebc-899b-c2ac0813b46b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99c1f4a8-7d42-49de-a5aa-b219078e4d5c', 6, NULL, 'Rassvet', 'Rassvet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 이중창 Op. 46' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99c1f4a8-7d42-49de-a5aa-b219078e4d5c'
);


-- Op. 47 7개의 로망스 Op. 47

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '7개의 로망스 Op. 47', '7 Romances, Op. 47', 'album', NULL, 'Op.', '47', 1880, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '7개의 로망스 Op. 47'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c47d83f9-7fd5-422c-9342-108fb58645a7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c47d83f9-7fd5-422c-9342-108fb58645a7'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '7개의 로망스 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c47d83f9-7fd5-422c-9342-108fb58645a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:209b6dfa-aff3-4a70-867e-9b3dd0e54a38', 1, NULL, 'Kaby znala ya', 'Kaby znala ya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '7개의 로망스 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:209b6dfa-aff3-4a70-867e-9b3dd0e54a38'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03f82968-2083-44ae-9f30-dcdf36becd74', 2, NULL, 'Gornimi tikho letela dusha nebesami', 'Gornimi tikho letela dusha nebesami', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '7개의 로망스 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03f82968-2083-44ae-9f30-dcdf36becd74'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0904201-c44f-42af-b873-933dddb157b7', 3, NULL, 'Na zemlyu sumrak pal', 'Na zemlyu sumrak pal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '7개의 로망스 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0904201-c44f-42af-b873-933dddb157b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ac91564-9ba6-496f-8bbc-528c58701dd1', 4, NULL, 'Usni, pechal''nyy drug', 'Usni, pechal''nyy drug', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '7개의 로망스 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ac91564-9ba6-496f-8bbc-528c58701dd1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7e6a8bc-46f4-4bd5-9923-bdde8178c046', 5, NULL, 'Blagoslovlyayu vas, lesa', 'Blagoslovlyayu vas, lesa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '7개의 로망스 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7e6a8bc-46f4-4bd5-9923-bdde8178c046'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16a1f569-b7aa-3756-b46c-277580ea9b7c', 6, NULL, 'Den'' li tsarit', 'Den'' li tsarit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '7개의 로망스 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16a1f569-b7aa-3756-b46c-277580ea9b7c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04090fc8-4a01-46d4-b90c-807e2215b26a', 7, NULL, 'Ya li v pole da ne travushka byla', 'Ya li v pole da ne travushka byla', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '7개의 로망스 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04090fc8-4a01-46d4-b90c-807e2215b26a'
);


-- Op. 48 현을 위한 세레나데 C장조

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9993dfb3-8b1f-36a6-84be-f47896697211', 1, 'I', 'Pezzo in forma di sonatina. Andante non troppo – Allegro moderato', 'I. Pezzo in forma di sonatina. Andante non troppo – Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 454 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9993dfb3-8b1f-36a6-84be-f47896697211'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb3e8fca-62b8-339a-9fad-cd0e56878822', 2, 'II', '왈츠. Moderato – Tempo di valse', 'II. Valse. Moderato – Tempo di valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 454 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb3e8fca-62b8-339a-9fad-cd0e56878822'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f775eda-abb5-3bf2-bbd1-577770e36149', 3, 'III', '엘레지. Larghetto elegiaco', 'III. Élégie. Larghetto elegiaco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 454 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f775eda-abb5-3bf2-bbd1-577770e36149'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:711f0fc9-2b3a-3084-8757-40afa0d9bf9b', 4, 'IV', '피날레 (러시아 주제). Andante – Allegro con spirito', 'IV. Finale (Tema russo). Andante – Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 454 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:711f0fc9-2b3a-3084-8757-40afa0d9bf9b'
);


-- Op. 50 피아노 3중주 A단조 "위대한 예술가를 추모하며"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 A단조 "위대한 예술가를 추모하며"', 'Piano Trio in A minor "In Memory of a Great Artist"', 'album', 'Op. 50', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 A단조 "위대한 예술가를 추모하며"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd16c2444-b4ec-43d2-815f-175e9da97543'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd16c2444-b4ec-43d2-815f-175e9da97543'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 3중주 A단조 "위대한 예술가를 추모하며"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd16c2444-b4ec-43d2-815f-175e9da97543'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:239389e0-305f-34fc-9147-d5c40332d112', 1, 'I', 'Pezzo elegiaco. Moderato assai – Allegro giusto', 'I. Pezzo elegiaco. Moderato assai – Allegro giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 3중주 A단조 "위대한 예술가를 추모하며"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:239389e0-305f-34fc-9147-d5c40332d112'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a736003-ed89-34e8-b548-6b761ca71426', 2, 'II', '주제와 변주. Andante con moto – Variazione finale e coda', 'II. Tema con variazioni. Andante con moto – Variazione finale e coda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 3중주 A단조 "위대한 예술가를 추모하며"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a736003-ed89-34e8-b548-6b761ca71426'
);


-- Op. 51 6개의 소품 Op. 51

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 소품 Op. 51', '6 Pieces, Op. 51', 'album', NULL, 'Op.', '51', 1882, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 소품 Op. 51'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '60941d9e-6537-401b-8f96-3ae2620a5ba8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '60941d9e-6537-401b-8f96-3ae2620a5ba8'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 소품 Op. 51' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '60941d9e-6537-401b-8f96-3ae2620a5ba8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcf34872-67f5-4434-aa4e-9455d86e496d', 1, NULL, '살롱 왈츠 A♭장조', 'Valse de salon in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 소품 Op. 51' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcf34872-67f5-4434-aa4e-9455d86e496d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73438ac6-2fd5-37bf-818f-3cf52cb3e960', 2, NULL, '폴카 B단조', 'Polka peu dansante in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 소품 Op. 51' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73438ac6-2fd5-37bf-818f-3cf52cb3e960'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a98a7d83-44da-4351-afc8-43fb9942b67c', 3, NULL, '스케르초풍 미뉴에트 E♭장조', 'Menuetto scherzoso in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 소품 Op. 51' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a98a7d83-44da-4351-afc8-43fb9942b67c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:744f9185-fa54-4ab2-be61-0cbfaf6fa1d6', 4, NULL, '나타 왈츠 A장조', 'Natha-Valse in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 소품 Op. 51' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:744f9185-fa54-4ab2-be61-0cbfaf6fa1d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7a7ffa0-5618-4037-a140-d5449316c160', 5, NULL, '로망스 F장조', 'Romance in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 소품 Op. 51' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7a7ffa0-5618-4037-a140-d5449316c160'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:430e6cdb-d505-33d6-a713-335627b4fb18', 6, NULL, '감상적인 왈츠 F단조', 'Valse sentimentale in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 소품 Op. 51' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:430e6cdb-d505-33d6-a713-335627b4fb18'
);


-- Op. 52 철야 기도

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '철야 기도', 'All-Night Vigil', 'song', 'Op. 52', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '철야 기도'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a380a5bc-415b-44ba-bce1-3837e4a75bb1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a380a5bc-415b-44ba-bce1-3837e4a75bb1'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '철야 기도' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a380a5bc-415b-44ba-bce1-3837e4a75bb1'
);


-- Op. 53 관현악 모음곡 2번 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 모음곡 2번 C장조', 'Orchestral Suite No. 2 in C major "Suite caractéristique"', 'album', 'Op. 53', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 모음곡 2번 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a36fa8d-34ae-4dfe-8ea3-f2361ceb04cb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1a36fa8d-34ae-4dfe-8ea3-f2361ceb04cb'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '관현악 모음곡 2번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a36fa8d-34ae-4dfe-8ea3-f2361ceb04cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:311f8a92-dd65-4eff-a650-904ff4344183', 1, 'I', 'Jeu de sons. Andantino un poco rubato – Allegro molto vivace', 'I. Jeu de sons. Andantino un poco rubato – Allegro molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '관현악 모음곡 2번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:311f8a92-dd65-4eff-a650-904ff4344183'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a15f50bd-2fc5-4a14-b0f0-2015bebdc962', 2, 'II', '왈츠. Moderato. Tempo di valse', 'II. Valse. Moderato. Tempo di valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '관현악 모음곡 2번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a15f50bd-2fc5-4a14-b0f0-2015bebdc962'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:833a6bd9-50b6-4134-8ccf-f94072e05f1e', 3, 'III', 'Scherzo burlesque. Vivace con spirito', 'III. Scherzo burlesque. Vivace con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '관현악 모음곡 2번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:833a6bd9-50b6-4134-8ccf-f94072e05f1e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:108c7b62-3413-4261-b481-31aa222370c6', 4, 'IV', 'Rêves d''enfant. Andante molto sostenuto', 'IV. Rêves d''enfant. Andante molto sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '관현악 모음곡 2번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:108c7b62-3413-4261-b481-31aa222370c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4c09375-5dac-4e0a-82fc-40f7f9fccdc9', 5, 'V', 'Danse baroque. Vivacissimo', 'V. Danse baroque. Vivacissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '관현악 모음곡 2번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4c09375-5dac-4e0a-82fc-40f7f9fccdc9'
);


-- Op. 54 16개의 어린이 노래 Op. 54

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '16개의 어린이 노래 Op. 54', '16 Songs for Children, Op. 54', 'album', NULL, 'Op.', '54', 1883, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '16개의 어린이 노래 Op. 54'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '44078727-0dfd-4597-b00d-b5c3f05b920e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '44078727-0dfd-4597-b00d-b5c3f05b920e'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '16개의 어린이 노래 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '44078727-0dfd-4597-b00d-b5c3f05b920e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfd03127-6f08-4555-907b-beb4cec92319', 1, NULL, 'Babushka i vnuchek', 'Babushka i vnuchek', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '16개의 어린이 노래 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfd03127-6f08-4555-907b-beb4cec92319'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca763736-5f1b-4c4d-91e3-4965ef164b64', 2, NULL, 'Ptichka', 'Ptichka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '16개의 어린이 노래 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca763736-5f1b-4c4d-91e3-4965ef164b64'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33d38fd0-ef68-4bae-a080-9bd53ac756b6', 3, NULL, 'Vesna (Travka zeleneet)', 'Vesna (Travka zeleneet)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '16개의 어린이 노래 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33d38fd0-ef68-4bae-a080-9bd53ac756b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b160442-5c4c-488d-aeae-ea819d66fa83', 4, NULL, 'Moy sadik', 'Moy sadik', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '16개의 어린이 노래 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b160442-5c4c-488d-aeae-ea819d66fa83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbfd4ae0-c4a6-4a00-995f-1cdd930e4952', 5, NULL, '전설 (Legenda)', 'Legenda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '16개의 어린이 노래 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbfd4ae0-c4a6-4a00-995f-1cdd930e4952'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4b3c9c3-4413-4ee6-b6b8-3da571e259c8', 6, NULL, 'Na beregu', 'Na beregu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '16개의 어린이 노래 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4b3c9c3-4413-4ee6-b6b8-3da571e259c8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22921324-68ad-4403-95a4-8bc528a968af', 7, NULL, 'Zimniy vecher', 'Zimniy vecher', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '16개의 어린이 노래 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22921324-68ad-4403-95a4-8bc528a968af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc94fb36-57c1-478a-b86c-5ddb804fb41d', 8, NULL, 'Kukushka', 'Kukushka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '16개의 어린이 노래 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc94fb36-57c1-478a-b86c-5ddb804fb41d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc24eb31-b454-4445-9199-c5ed5a17878f', 9, NULL, 'Vesna (Uzh taet sneg)', 'Vesna (Uzh taet sneg)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '16개의 어린이 노래 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc24eb31-b454-4445-9199-c5ed5a17878f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:891117a5-5905-466b-a4a2-ab508d14c487', 10, NULL, 'Kolybel''naya pesn'' v buryu', 'Kolybel''naya pesn'' v buryu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '16개의 어린이 노래 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:891117a5-5905-466b-a4a2-ab508d14c487'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6120ce05-d240-43cf-9697-207748f0510c', 11, NULL, 'Tsvetok', 'Tsvetok', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '16개의 어린이 노래 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6120ce05-d240-43cf-9697-207748f0510c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30321a5b-2462-490b-ab76-4f4a64cc4811', 12, NULL, 'Zima', 'Zima', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '16개의 어린이 노래 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30321a5b-2462-490b-ab76-4f4a64cc4811'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7aa4b3d-04e1-40d3-8673-64a138b691df', 13, NULL, 'Vesennyaya pesnya', 'Vesennyaya pesnya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '16개의 어린이 노래 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7aa4b3d-04e1-40d3-8673-64a138b691df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:692a7dfc-2c72-4719-982d-99bd0300bc9d', 14, NULL, 'Osen''', 'Osen''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '16개의 어린이 노래 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:692a7dfc-2c72-4719-982d-99bd0300bc9d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36182418-36eb-4fdd-bd1b-ae37f98751cf', 15, NULL, 'Lastochka', 'Lastochka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '16개의 어린이 노래 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36182418-36eb-4fdd-bd1b-ae37f98751cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28772880-a215-4ed0-8278-4e91241621b9', 16, NULL, 'Detskaya pesenka (Moy Lizochek)', 'Detskaya pesenka (Moy Lizochek)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '16개의 어린이 노래 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28772880-a215-4ed0-8278-4e91241621b9'
);


-- Op. 55 관현악 모음곡 3번 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 모음곡 3번 G장조', 'Orchestral Suite No. 3 in G major', 'album', 'Op. 55', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 모음곡 3번 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '222d3ac7-ff2e-45f6-b13e-3c2a877c1742'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '222d3ac7-ff2e-45f6-b13e-3c2a877c1742'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '관현악 모음곡 3번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '222d3ac7-ff2e-45f6-b13e-3c2a877c1742'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94297838-a771-4c4e-866c-4b87e0f77489', 1, 'I', '엘레지. Andantino molto cantabile', 'I. Élégie. Andantino molto cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '관현악 모음곡 3번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94297838-a771-4c4e-866c-4b87e0f77489'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b822f313-c0ea-4d3e-ae25-35c3d50a5d37', 2, 'II', 'Valse mélancolique. Allegro moderato', 'II. Valse mélancolique. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '관현악 모음곡 3번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b822f313-c0ea-4d3e-ae25-35c3d50a5d37'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d26ab7a8-27ce-4272-84e2-468b007531fc', 3, 'III', '스케르초. Presto', 'III. Scherzo. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '관현악 모음곡 3번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d26ab7a8-27ce-4272-84e2-468b007531fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8b34618-98e0-4155-a12b-dcb25ea9350e', 4, 'IV', '주제와 변주. Andante con moto', 'IV. Tema con variazioni. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '관현악 모음곡 3번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8b34618-98e0-4155-a12b-dcb25ea9350e'
);


-- Op. 56 협주적 환상곡 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '협주적 환상곡 G장조', 'Concert Fantasia in G major', 'album', 'Op. 56', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '협주적 환상곡 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b908a5cf-5909-4aa6-9f47-d3024b917d08'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b908a5cf-5909-4aa6-9f47-d3024b917d08'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '협주적 환상곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b908a5cf-5909-4aa6-9f47-d3024b917d08'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:308167a4-b259-3857-9957-4c72b87430ab', 1, 'I', 'Quasi rondo. Andante mosso', 'I. Quasi rondo. Andante mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '협주적 환상곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:308167a4-b259-3857-9957-4c72b87430ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c8794d6-837f-3d94-8a63-67b280e2bf1a', 2, 'II', 'Contrastes. Andante cantabile – Molto vivace', 'II. Contrastes. Andante cantabile – Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '협주적 환상곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c8794d6-837f-3d94-8a63-67b280e2bf1a'
);


-- Op. 57 6개의 로망스 Op. 57

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 로망스 Op. 57', '6 Romances, Op. 57', 'album', NULL, 'Op.', '57', 1884, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 로망스 Op. 57'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9635dba-ada5-4394-8dd2-a90e3364524e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c9635dba-ada5-4394-8dd2-a90e3364524e'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 57' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9635dba-ada5-4394-8dd2-a90e3364524e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d42c6a8-cda6-4cb4-a2c0-ad75a3b89da8', 1, NULL, 'Skazhi, o chyom v teni vetvey', 'Skazhi, o chyom v teni vetvey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 57' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d42c6a8-cda6-4cb4-a2c0-ad75a3b89da8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e1aa924-0a0f-4122-bed7-5afb066cd021', 2, NULL, 'Na nivy zheltye', 'Na nivy zheltye', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 57' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e1aa924-0a0f-4122-bed7-5afb066cd021'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:989ceb44-2671-4f40-9794-caa1ff75e112', 3, NULL, 'Ne sprashivay', 'Ne sprashivay', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 57' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:989ceb44-2671-4f40-9794-caa1ff75e112'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f024252-7646-48a7-bcf3-f23d369cf519', 4, NULL, 'Usni!', 'Usni!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 57' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f024252-7646-48a7-bcf3-f23d369cf519'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3049bd86-16e9-4cd1-a272-b3f7a8c1401c', 5, NULL, 'Smert''', 'Smert''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 57' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3049bd86-16e9-4cd1-a272-b3f7a8c1401c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59acc9a6-b9aa-4762-a982-ad2854867d02', 6, NULL, 'Lish'' ty odin', 'Lish'' ty odin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 57' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59acc9a6-b9aa-4762-a982-ad2854867d02'
);


-- Op. 58 <만프레드> 교향곡 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<만프레드> 교향곡 B단조', 'Manfred Symphony in B minor', 'album', 'Op. 58', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<만프레드> 교향곡 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ea0c6a0-b96c-3d87-ad8f-ec8e50b9ec87'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1ea0c6a0-b96c-3d87-ad8f-ec8e50b9ec87'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '<만프레드> 교향곡 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ea0c6a0-b96c-3d87-ad8f-ec8e50b9ec87'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0290284f-09aa-3756-9417-4e8057eca93b', 1, 'I', 'Lento lugubre – Moderato con moto – Andante', 'I. Lento lugubre – Moderato con moto – Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '<만프레드> 교향곡 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0290284f-09aa-3756-9417-4e8057eca93b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c10f47d-c12b-3d7a-8dc1-0d2d90cd7217', 2, 'II', 'Vivace con spirito', 'II. Vivace con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '<만프레드> 교향곡 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c10f47d-c12b-3d7a-8dc1-0d2d90cd7217'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f71b29c5-2b04-36e0-81fc-754612568ffc', 3, 'III', '파스토랄. Andante con moto', 'III. Pastorale. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '<만프레드> 교향곡 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f71b29c5-2b04-36e0-81fc-754612568ffc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65e1328b-0672-3a40-98a0-89b2a607e921', 4, 'IV', 'Allegro con fuoco', 'IV. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '<만프레드> 교향곡 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65e1328b-0672-3a40-98a0-89b2a607e921'
);


-- Op. 59 둠카 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '둠카 C단조', 'Dumka in C minor', 'song', 'Op. 59', NULL, NULL, 1886, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '둠카 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5758d31-84c5-378c-980b-e26845874f43'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c5758d31-84c5-378c-980b-e26845874f43'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '둠카 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5758d31-84c5-378c-980b-e26845874f43'
);


-- Op. 60 12개의 로망스 Op. 60

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '12개의 로망스 Op. 60', '12 Romances, Op. 60', 'album', NULL, 'Op.', '60', 1886, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '12개의 로망스 Op. 60'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5763cec5-79cf-4783-9cd0-005e2ad2c817'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5763cec5-79cf-4783-9cd0-005e2ad2c817'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 로망스 Op. 60' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5763cec5-79cf-4783-9cd0-005e2ad2c817'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9746b94c-205c-49bc-80b5-d048198c466b', 1, NULL, 'Vcherashnyaya noch''', 'Vcherashnyaya noch''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 로망스 Op. 60' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9746b94c-205c-49bc-80b5-d048198c466b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d17cebb-0949-495e-9eba-e7865c40ee31', 2, NULL, 'Ya tebe nichego ne skazhu', 'Ya tebe nichego ne skazhu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 로망스 Op. 60' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d17cebb-0949-495e-9eba-e7865c40ee31'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bae33aad-3508-4f85-83c0-3cae0397af6c', 3, NULL, 'O, yesli b znali vy', 'O, yesli b znali vy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 로망스 Op. 60' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bae33aad-3508-4f85-83c0-3cae0397af6c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b75192f6-e8e9-4611-858d-f44cc056521c', 4, NULL, 'Solovey', 'Solovey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 로망스 Op. 60' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b75192f6-e8e9-4611-858d-f44cc056521c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:867ad0dc-398a-4abf-8701-043c862b8add', 5, NULL, 'Prostye slova', 'Prostye slova', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 로망스 Op. 60' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:867ad0dc-398a-4abf-8701-043c862b8add'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0800ebf-ee1e-329f-be24-dced9f49c3d4', 6, NULL, 'Nochi bezumnye', 'Nochi bezumnye', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 로망스 Op. 60' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0800ebf-ee1e-329f-be24-dced9f49c3d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88004d56-b421-3083-a67d-5e1b743ec55e', 7, NULL, 'Pesn'' tsyganki', 'Pesn'' tsyganki', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 로망스 Op. 60' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88004d56-b421-3083-a67d-5e1b743ec55e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae58c0a5-f4d0-416f-847b-16f9482494db', 8, NULL, 'Prosti!', 'Prosti!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 로망스 Op. 60' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae58c0a5-f4d0-416f-847b-16f9482494db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e090814c-6374-43ab-b972-2296119ed2d2', 9, NULL, 'Noch''', 'Noch''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 로망스 Op. 60' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e090814c-6374-43ab-b972-2296119ed2d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ca23344-e65a-47f9-a810-61457aac213b', 10, NULL, 'Za oknom v teni mel''kaet', 'Za oknom v teni mel''kaet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 로망스 Op. 60' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ca23344-e65a-47f9-a810-61457aac213b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:506437a2-fc35-4ebc-b49b-b16bc775aaca', 11, NULL, 'Podvig', 'Podvig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 로망스 Op. 60' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:506437a2-fc35-4ebc-b49b-b16bc775aaca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87b8d914-8b8a-470d-b752-4ef2db1fc779', 12, NULL, 'Nam zvezdy krotkie siyali', 'Nam zvezdy krotkie siyali', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '12개의 로망스 Op. 60' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87b8d914-8b8a-470d-b752-4ef2db1fc779'
);


-- Op. 61 관현악 모음곡 4번 G장조 "모차르티아나"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 모음곡 4번 G장조 "모차르티아나"', 'Orchestral Suite No. 4 in G major "Mozartiana"', 'album', 'Op. 61', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 모음곡 4번 G장조 "모차르티아나"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e455396-b807-4517-95ba-5dc4a97c05d3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1e455396-b807-4517-95ba-5dc4a97c05d3'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '관현악 모음곡 4번 G장조 "모차르티아나"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e455396-b807-4517-95ba-5dc4a97c05d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4f718f8-7e52-4cef-97b0-5d9a24768f26', 1, 'I', '지그. Allegro', 'I. Gigue. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '관현악 모음곡 4번 G장조 "모차르티아나"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4f718f8-7e52-4cef-97b0-5d9a24768f26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c1b6e05-ca79-45be-b0a9-9cd0c5c47c71', 2, 'II', '미뉴에트. Moderato', 'II. Menuet. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '관현악 모음곡 4번 G장조 "모차르티아나"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c1b6e05-ca79-45be-b0a9-9cd0c5c47c71'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c36c5246-99c4-48d4-8a14-41df2ee04df5', 3, 'III', 'Preghiera. Andante non tanto', 'III. Preghiera. Andante non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '관현악 모음곡 4번 G장조 "모차르티아나"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c36c5246-99c4-48d4-8a14-41df2ee04df5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d9b7f68-4a0f-4ce6-a862-213c5ccda450', 4, 'IV', '주제와 변주. Allegro giusto', 'IV. Thème et variations. Allegro giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '관현악 모음곡 4번 G장조 "모차르티아나"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d9b7f68-4a0f-4ce6-a862-213c5ccda450'
);


-- Op. 62 페초 카프리치오소 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '페초 카프리치오소 B단조', 'Pezzo capriccioso in B minor', 'song', 'Op. 62', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '페초 카프리치오소 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4cd28af0-67d5-4d7d-ba06-6e33319b8fd5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4cd28af0-67d5-4d7d-ba06-6e33319b8fd5'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '페초 카프리치오소 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4cd28af0-67d5-4d7d-ba06-6e33319b8fd5'
);


-- Op. 63 6개의 로망스 Op. 63

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 로망스 Op. 63', '6 Romances, Op. 63', 'album', NULL, 'Op.', '63', 1887, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 로망스 Op. 63'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4efa7efb-30a4-4286-8367-ea054964ebc3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4efa7efb-30a4-4286-8367-ea054964ebc3'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 63' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4efa7efb-30a4-4286-8367-ea054964ebc3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6812f059-69d5-4e41-a2a3-15dc960a144b', 1, NULL, 'Ya snachala tebya ne lyubila', 'Ya snachala tebya ne lyubila', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 63' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6812f059-69d5-4e41-a2a3-15dc960a144b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:375d86af-bac3-4016-a389-b1b17459d7e5', 2, NULL, 'Rastvoril ya okno', 'Rastvoril ya okno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 63' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:375d86af-bac3-4016-a389-b1b17459d7e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:788a9946-ab0c-43a6-bdd1-289e0b25c68f', 3, NULL, 'Ya vam ne nravlyus''', 'Ya vam ne nravlyus''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 63' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:788a9946-ab0c-43a6-bdd1-289e0b25c68f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea072699-b0ac-31b5-815d-c7b38551146c', 4, NULL, 'Pervoe svidanie', 'Pervoe svidanie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 63' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea072699-b0ac-31b5-815d-c7b38551146c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:794cee8a-8324-3745-ac46-89962bf0606d', 5, NULL, 'Uzh gasli v komnatakh ogni', 'Uzh gasli v komnatakh ogni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 63' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:794cee8a-8324-3745-ac46-89962bf0606d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4952a7c6-9486-427b-9ce3-a36fbb7ccb61', 6, NULL, 'Serenada (O, ditya! pod okoshkom tvoim)', 'Serenada (O, ditya! pod okoshkom tvoim)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 63' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4952a7c6-9486-427b-9ce3-a36fbb7ccb61'
);


-- Op. 64 교향곡 5번 E단조

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b967089-d0b3-3117-ae48-828e7a498077', 1, 'I', 'Andante – Allegro con anima', 'I. Andante – Allegro con anima', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 453 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b967089-d0b3-3117-ae48-828e7a498077'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f52416f1-6139-3212-b98d-e65db819497a', 2, 'II', 'Andante cantabile, con alcuna licenza', 'II. Andante cantabile, con alcuna licenza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 453 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f52416f1-6139-3212-b98d-e65db819497a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:acddd74a-1e04-3de7-bcc7-e0531a336c41', 3, 'III', '왈츠. Allegro moderato', 'III. Valse. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 453 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acddd74a-1e04-3de7-bcc7-e0531a336c41'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07e59582-8ec7-3a31-b68a-880e6ded0ead', 4, 'IV', '피날레. Andante maestoso – Allegro vivace', 'IV. Finale. Andante maestoso – Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 453 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07e59582-8ec7-3a31-b68a-880e6ded0ead'
);


-- Op. 65 6개의 로망스 Op. 65

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 로망스 Op. 65', '6 French Songs, Op. 65', 'album', NULL, 'Op.', '65', 1888, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 로망스 Op. 65'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc80730c-6a40-490e-9976-0c2e1b2ddc94'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dc80730c-6a40-490e-9976-0c2e1b2ddc94'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc80730c-6a40-490e-9976-0c2e1b2ddc94'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70582132-772e-3f58-aa04-d8ae9380063f', 1, NULL, 'Sérénade (Où vas-tu, souffle d''aurore)', 'Sérénade (Où vas-tu, souffle d''aurore)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70582132-772e-3f58-aa04-d8ae9380063f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:188a72cb-92e7-45bb-8f9d-e7b43860c3d9', 2, NULL, 'Déception', 'Déception', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:188a72cb-92e7-45bb-8f9d-e7b43860c3d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22dea177-d5c8-475f-ac2b-26bdda4c6898', 3, NULL, 'Sérénade (J''aime dans le rayon)', 'Sérénade (J''aime dans le rayon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22dea177-d5c8-475f-ac2b-26bdda4c6898'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7e46504-b74e-43db-88f2-f1f54be86fbc', 4, NULL, 'Qu''importe que l''hiver', 'Qu''importe que l''hiver', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7e46504-b74e-43db-88f2-f1f54be86fbc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49c2e92f-2173-486e-8ff6-2cb8c081ce0c', 5, NULL, 'Les larmes', 'Les larmes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49c2e92f-2173-486e-8ff6-2cb8c081ce0c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e64d97ba-befa-3a71-92ba-67e5ad1a77b7', 6, NULL, 'Rondel', 'Rondel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e64d97ba-befa-3a71-92ba-67e5ad1a77b7'
);


-- Op. 66 발레 <잠자는 숲속의 미녀>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <잠자는 숲속의 미녀>', 'The Sleeping Beauty', 'song', 'Op. 66', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <잠자는 숲속의 미녀>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17f624e2-97da-45c3-ab54-c3b2daf2ba68'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '17f624e2-97da-45c3-ab54-c3b2daf2ba68'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '발레 <잠자는 숲속의 미녀>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17f624e2-97da-45c3-ab54-c3b2daf2ba68'
);


-- Op. 67a 환상 서곡 <햄릿>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '환상 서곡 <햄릿>', 'Hamlet, Fantasy Overture in F minor', 'song', 'Op. 67a', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '환상 서곡 <햄릿>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '297052e7-6a48-3e0d-ad25-affa92b2f63c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '297052e7-6a48-3e0d-ad25-affa92b2f63c'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '환상 서곡 <햄릿>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '297052e7-6a48-3e0d-ad25-affa92b2f63c'
);


-- Op. 67b 부수음악 <햄릿>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <햄릿>', 'Hamlet, incidental music', 'song', 'Op. 67b', NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <햄릿>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cf505621-044f-41ef-beb8-584be08e6a10'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cf505621-044f-41ef-beb8-584be08e6a10'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '부수음악 <햄릿>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cf505621-044f-41ef-beb8-584be08e6a10'
);


-- Op. 68 오페라 <스페이드의 여왕>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <스페이드의 여왕>', 'The Queen of Spades', 'song', 'Op. 68', NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <스페이드의 여왕>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a857e907-38f5-481d-bc78-b643e1459298'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a857e907-38f5-481d-bc78-b643e1459298'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '오페라 <스페이드의 여왕>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a857e907-38f5-481d-bc78-b643e1459298'
);


-- Op. 69 오페라 <이올란타>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <이올란타>', 'Iolanta', 'song', 'Op. 69', NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <이올란타>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c307e364-7e0e-4dc2-8c53-f4a26b292190'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c307e364-7e0e-4dc2-8c53-f4a26b292190'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '오페라 <이올란타>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c307e364-7e0e-4dc2-8c53-f4a26b292190'
);


-- Op. 70 현악 6중주 D단조 "피렌체의 추억"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 6중주 D단조 "피렌체의 추억"', 'String Sextet in D minor "Souvenir de Florence"', 'album', 'Op. 70', NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 6중주 D단조 "피렌체의 추억"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8251f675-8ee2-3ec7-9d82-ae96d2515563'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8251f675-8ee2-3ec7-9d82-ae96d2515563'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '현악 6중주 D단조 "피렌체의 추억"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8251f675-8ee2-3ec7-9d82-ae96d2515563'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bdd1edd-61c7-3c16-9b93-53d6a1fc659e', 1, 'I', 'Allegro con spirito', 'I. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '현악 6중주 D단조 "피렌체의 추억"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bdd1edd-61c7-3c16-9b93-53d6a1fc659e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f08b235-513b-3804-b369-333a05da10db', 2, 'II', 'Adagio cantabile e con moto', 'II. Adagio cantabile e con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '현악 6중주 D단조 "피렌체의 추억"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f08b235-513b-3804-b369-333a05da10db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f209dfc0-fb81-38a0-a2a5-73923de87d3d', 3, 'III', 'Allegretto moderato', 'III. Allegretto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '현악 6중주 D단조 "피렌체의 추억"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f209dfc0-fb81-38a0-a2a5-73923de87d3d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b1d6d0e-128f-37c1-8a41-4bfe791874ce', 4, 'IV', 'Allegro vivace', 'IV. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '현악 6중주 D단조 "피렌체의 추억"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b1d6d0e-128f-37c1-8a41-4bfe791874ce'
);


-- Op. 71a 발레 모음곡 <호두까기 인형>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 모음곡 <호두까기 인형>', 'The Nutcracker Suite', 'album', 'Op. 71a', NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 모음곡 <호두까기 인형>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fd337fdc-a511-4830-8ee7-09d4ada32a54'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fd337fdc-a511-4830-8ee7-09d4ada32a54'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '발레 모음곡 <호두까기 인형>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fd337fdc-a511-4830-8ee7-09d4ada32a54'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fce0c96b-42a9-4c41-a455-d5dc017bcb44', 1, 'I', '작은 서곡', 'I. Ouverture miniature. Allegro giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '발레 모음곡 <호두까기 인형>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fce0c96b-42a9-4c41-a455-d5dc017bcb44'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54c7b031-7dcc-4c2b-86bb-c0e63117d64f', 2, 'II', '성격적 춤곡', 'II. Danses caractéristiques', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '발레 모음곡 <호두까기 인형>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54c7b031-7dcc-4c2b-86bb-c0e63117d64f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:55a1addc-4e9f-47ac-9bac-f3d089dbce76', 1, NULL, '행진곡', 'a) Marche. Tempo di marcia viva', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:54c7b031-7dcc-4c2b-86bb-c0e63117d64f'
WHERE p.composer_id = 34 AND p.title = '발레 모음곡 <호두까기 인형>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55a1addc-4e9f-47ac-9bac-f3d089dbce76'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:17e5e26c-445c-4dc5-b469-6ce3795309c4', 2, NULL, '사탕 요정의 춤', 'b) Danse de la Fée-Dragée. Andante ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:54c7b031-7dcc-4c2b-86bb-c0e63117d64f'
WHERE p.composer_id = 34 AND p.title = '발레 모음곡 <호두까기 인형>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17e5e26c-445c-4dc5-b469-6ce3795309c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0847c13a-1430-42fc-9408-95070648ad5d', 3, NULL, '러시아 춤 (트레팍)', 'c) Danse russe Trépak. Tempo di trepak, molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:54c7b031-7dcc-4c2b-86bb-c0e63117d64f'
WHERE p.composer_id = 34 AND p.title = '발레 모음곡 <호두까기 인형>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0847c13a-1430-42fc-9408-95070648ad5d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:680c80a7-404f-4fbd-85bb-61e2a6653c84', 4, NULL, '아라비아 춤', 'd) Danse arabe. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:54c7b031-7dcc-4c2b-86bb-c0e63117d64f'
WHERE p.composer_id = 34 AND p.title = '발레 모음곡 <호두까기 인형>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:680c80a7-404f-4fbd-85bb-61e2a6653c84'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f7d7e581-ada6-44fa-998c-5d7979ea37c3', 5, NULL, '중국 춤', 'e) Danse chinoise. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:54c7b031-7dcc-4c2b-86bb-c0e63117d64f'
WHERE p.composer_id = 34 AND p.title = '발레 모음곡 <호두까기 인형>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7d7e581-ada6-44fa-998c-5d7979ea37c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7ba874d9-020b-4823-8477-3e27224bece8', 6, NULL, '갈대 피리의 춤', 'f) Danse des mirlitons. Moderato assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:54c7b031-7dcc-4c2b-86bb-c0e63117d64f'
WHERE p.composer_id = 34 AND p.title = '발레 모음곡 <호두까기 인형>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ba874d9-020b-4823-8477-3e27224bece8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b351e63-4904-4fb0-8903-7593dfbc7598', 3, 'III', '꽃의 왈츠', 'III. Valse des fleurs. Tempo di valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '발레 모음곡 <호두까기 인형>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b351e63-4904-4fb0-8903-7593dfbc7598'
);


-- Op. 72 18개의 소품 Op. 72

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '18개의 소품 Op. 72', '18 Pieces, Op. 72', 'album', NULL, 'Op.', '72', 1893, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '18개의 소품 Op. 72'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80edd680-fcbb-4bdf-ab4b-f83144c7b146'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '80edd680-fcbb-4bdf-ab4b-f83144c7b146'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '18개의 소품 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80edd680-fcbb-4bdf-ab4b-f83144c7b146'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:761a5bf2-40bc-4d3c-8c87-c938281cb7c9', 1, NULL, '즉흥곡 F단조', 'Impromptu in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '18개의 소품 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:761a5bf2-40bc-4d3c-8c87-c938281cb7c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35aa88ac-cdd9-4d34-af88-6de9afd3fe02', 2, NULL, '자장가 A♭장조', 'Berceuse in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '18개의 소품 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35aa88ac-cdd9-4d34-af88-6de9afd3fe02'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed282211-c5a6-47fb-abd3-e6cee9650df4', 3, NULL, '다정한 꾸지람 C#단조', 'Tendres reproches in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '18개의 소품 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed282211-c5a6-47fb-abd3-e6cee9650df4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f21867cd-b9b4-405e-bea0-3c2969c1fc45', 4, NULL, '성격적 춤곡 D장조', 'Danse caractéristique in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '18개의 소품 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f21867cd-b9b4-405e-bea0-3c2969c1fc45'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2be6d49-40b7-4449-99ef-5e6f2af35d77', 5, NULL, '명상 D장조', 'Méditation in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '18개의 소품 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2be6d49-40b7-4449-99ef-5e6f2af35d77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e83b9e5-7f97-452f-83f1-7a9525f5e63d', 6, NULL, '춤을 위한 마주르카 B♭장조', 'Mazurque pour danser in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '18개의 소품 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e83b9e5-7f97-452f-83f1-7a9525f5e63d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8164eb0c-0f83-48ed-9310-42b62437849b', 7, NULL, '연주회용 폴로네즈 E♭장조', 'Polacca de concert in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '18개의 소품 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8164eb0c-0f83-48ed-9310-42b62437849b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:801646a4-d22a-44b9-90f2-06c684ca3359', 8, NULL, '대화 B장조', 'Dialogue in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '18개의 소품 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:801646a4-d22a-44b9-90f2-06c684ca3359'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:300b8e70-d2a8-44cf-b244-8c2e86935e9d', 9, NULL, '슈만풍으로 D♭장조', 'Un poco di Schumann in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '18개의 소품 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:300b8e70-d2a8-44cf-b244-8c2e86935e9d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99a77a9e-1548-46b4-9092-a3c95ac36d02', 10, NULL, '스케르초-환상곡 E♭단조', 'Scherzo-fantaisie in E♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '18개의 소품 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99a77a9e-1548-46b4-9092-a3c95ac36d02'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f39d112b-eecd-462d-863c-1dd2b7d5f029', 11, NULL, '왈츠-블루에트 E♭장조', 'Valse-bluette in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '18개의 소품 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f39d112b-eecd-462d-863c-1dd2b7d5f029'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35574a1c-a667-4cb0-b65e-a7029023720f', 12, NULL, '장난꾸러기 E장조', 'L''espiègle in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '18개의 소품 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35574a1c-a667-4cb0-b65e-a7029023720f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:186d7766-8553-4aab-a349-18f4fe54f61b', 13, NULL, '시골의 메아리 E♭장조', 'Écho rustique in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '18개의 소품 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:186d7766-8553-4aab-a349-18f4fe54f61b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c59fd25e-c3b5-49e9-bca8-443e6bf66784', 14, NULL, '엘레지풍 노래 D♭장조', 'Chant élégiaque in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '18개의 소품 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c59fd25e-c3b5-49e9-bca8-443e6bf66784'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c943de9d-5b35-43df-830a-7787b1046553', 15, NULL, '쇼팽풍으로 C#단조', 'Un poco di Chopin in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '18개의 소품 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c943de9d-5b35-43df-830a-7787b1046553'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:070222d9-2e0b-4651-b9de-f9d751d09974', 16, NULL, '5박자 왈츠 D장조', 'Valse à cinq temps in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '18개의 소품 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:070222d9-2e0b-4651-b9de-f9d751d09974'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4dbf638a-c28f-4ac6-a7e8-3029338c1000', 17, NULL, '아득한 옛날 E♭장조', 'Passé lointain in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '18개의 소품 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dbf638a-c28f-4ac6-a7e8-3029338c1000'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ac966e7-3b4b-4721-b179-f9ed69768c79', 18, NULL, '춤 장면 "트레팍으로의 초대" C장조', 'Scène dansante "Invitation au trépak" in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '18개의 소품 Op. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ac966e7-3b4b-4721-b179-f9ed69768c79'
);


-- Op. 73 6개의 로망스 Op. 73

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 로망스 Op. 73', '6 Romances, Op. 73', 'album', NULL, 'Op.', '73', 1893, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 로망스 Op. 73'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ecd3ccf2-ff1b-4627-a3a7-f5ca4557155a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ecd3ccf2-ff1b-4627-a3a7-f5ca4557155a'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 73' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ecd3ccf2-ff1b-4627-a3a7-f5ca4557155a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79a0a4ed-07c9-4c38-a008-848e4023d602', 1, NULL, 'My sideli s toboy', 'My sideli s toboy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 73' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79a0a4ed-07c9-4c38-a008-848e4023d602'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b71bc82a-8b3d-3b14-b848-f86f0ef35324', 2, NULL, 'Noch''', 'Noch''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 73' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b71bc82a-8b3d-3b14-b848-f86f0ef35324'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd43b908-6c99-4cc4-87d5-9b6577210e29', 3, NULL, 'V etu lunnuyu noch''', 'V etu lunnuyu noch''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 73' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd43b908-6c99-4cc4-87d5-9b6577210e29'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13c03824-1d4f-3fd2-92b7-da09eddcdc33', 4, NULL, 'Zakatilos'' solntse', 'Zakatilos'' solntse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 73' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13c03824-1d4f-3fd2-92b7-da09eddcdc33'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edea2ced-cfe8-3f1c-8b1a-661707dd13e9', 5, NULL, 'Sred'' mrachnykh dney', 'Sred'' mrachnykh dney', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 73' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edea2ced-cfe8-3f1c-8b1a-661707dd13e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfe4b81f-5930-44ba-8968-853e0ec7334b', 6, NULL, 'Snova, kak prezhde, odin', 'Snova, kak prezhde, odin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '6개의 로망스 Op. 73' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfe4b81f-5930-44ba-8968-853e0ec7334b'
);


-- Op. 74 교향곡 6번 B단조 "비창"

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2cb4d52-1ea9-31b3-997b-68c0316b0f68', 1, 'I', 'Adagio – Allegro non troppo', 'I. Adagio – Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 158 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2cb4d52-1ea9-31b3-997b-68c0316b0f68'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73afaff9-529b-3a85-8707-158cc0af54bb', 2, 'II', 'Allegro con grazia', 'II. Allegro con grazia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 158 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73afaff9-529b-3a85-8707-158cc0af54bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86e6b83a-726b-39e9-850e-d7f7c9a1c44c', 3, 'III', 'Allegro molto vivace', 'III. Allegro molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 158 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86e6b83a-726b-39e9-850e-d7f7c9a1c44c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3caf3331-e9a3-3d3c-8522-0d3f6cc50886', 4, 'IV', '피날레. Adagio lamentoso', 'IV. Finale. Adagio lamentoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 158 AND p.composer_id = 34
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3caf3331-e9a3-3d3c-8522-0d3f6cc50886'
);


-- Op. 75 피아노 협주곡 3번 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 3번 E♭장조', 'Piano Concerto No. 3 in E♭ major', 'song', 'Op. 75', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 3번 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7fdbcd24-f943-4687-8062-8fd15896cf43'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7fdbcd24-f943-4687-8062-8fd15896cf43'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 협주곡 3번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7fdbcd24-f943-4687-8062-8fd15896cf43'
);


-- Op. 76 서곡 <뇌우>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 <뇌우>', 'The Storm, Overture in E minor', 'song', 'Op. 76', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 <뇌우>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f18bf02-f54d-37e6-8471-b7ef162c376f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3f18bf02-f54d-37e6-8471-b7ef162c376f'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '서곡 <뇌우>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f18bf02-f54d-37e6-8471-b7ef162c376f'
);


-- Op. 77 교향시 <운명>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <운명>', 'Fatum, Symphonic Poem in C minor', 'song', 'Op. 77', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <운명>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b1f4137-4a77-3e96-932b-ff2ab12d8d30'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5b1f4137-4a77-3e96-932b-ff2ab12d8d30'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향시 <운명>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b1f4137-4a77-3e96-932b-ff2ab12d8d30'
);


-- Op. 78 교향적 발라드 <보예보다>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향적 발라드 <보예보다>', 'The Voyevoda, Symphonic Ballad in A minor', 'song', 'Op. 78', NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향적 발라드 <보예보다>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '45768b41-83b8-3f5c-a97f-4d1f7e937614'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '45768b41-83b8-3f5c-a97f-4d1f7e937614'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '교향적 발라드 <보예보다>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '45768b41-83b8-3f5c-a97f-4d1f7e937614'
);


-- Op. 79 안단테와 피날레

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단테와 피날레', 'Andante and Finale', 'album', 'Op. 79', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단테와 피날레'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4b7ea83e-5395-421e-a71d-25cadb44bac8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4b7ea83e-5395-421e-a71d-25cadb44bac8'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '안단테와 피날레' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4b7ea83e-5395-421e-a71d-25cadb44bac8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7798e45d-3627-39dc-b203-40069cd0667a', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '안단테와 피날레' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7798e45d-3627-39dc-b203-40069cd0667a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1431d732-584f-349a-9257-0ada776fdd47', 2, 'II', '피날레. Allegro maestoso', 'II. Finale. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '안단테와 피날레' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1431d732-584f-349a-9257-0ada776fdd47'
);


-- Op. 80 피아노 소나타 C#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 C#단조', 'Piano Sonata in C# minor', 'album', 'Op. 80', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 C#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd99ee4b5-387b-4f41-bf8c-66fd43873c83'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd99ee4b5-387b-4f41-bf8c-66fd43873c83'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 소나타 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd99ee4b5-387b-4f41-bf8c-66fd43873c83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e84ad682-8257-3fc1-97c8-b65196273f8e', 1, 'I', 'Allegro con fuoco', 'I. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 소나타 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e84ad682-8257-3fc1-97c8-b65196273f8e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95395d5d-8602-3a1a-badc-e676b4248456', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 소나타 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95395d5d-8602-3a1a-badc-e676b4248456'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c47ff53-4573-34c5-aaaa-10c31a971d97', 3, 'III', '스케르초. Allegro vivo', 'III. Scherzo. Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 소나타 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c47ff53-4573-34c5-aaaa-10c31a971d97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15ea34da-257d-3652-832d-1a5bba3c916f', 4, 'IV', '피날레. Allegro vivo', 'IV. Finale. Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '피아노 소나타 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15ea34da-257d-3652-832d-1a5bba3c916f'
);


-- TH 3 오페라 <오프리치니크>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <오프리치니크>', 'The Oprichnik', 'song', 'TH 3', NULL, NULL, 1872, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <오프리치니크>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '03c026a2-25cc-4ed0-9b2a-5fd0d5c90f68'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '03c026a2-25cc-4ed0-9b2a-5fd0d5c90f68'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '오페라 <오프리치니크>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '03c026a2-25cc-4ed0-9b2a-5fd0d5c90f68'
);


-- TH 6 오페라 <오를레앙의 처녀>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <오를레앙의 처녀>', 'The Maid of Orleans', 'song', 'TH 6', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <오를레앙의 처녀>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '989fbe24-ce7e-4f0d-ac7d-3986c9695a35'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '989fbe24-ce7e-4f0d-ac7d-3986c9695a35'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '오페라 <오를레앙의 처녀>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '989fbe24-ce7e-4f0d-ac7d-3986c9695a35'
);


-- TH 7 오페라 <마제파>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <마제파>', 'Mazeppa', 'song', 'TH 7', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <마제파>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f997af5-cfef-441c-aac3-b747cd030497'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8f997af5-cfef-441c-aac3-b747cd030497'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '오페라 <마제파>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f997af5-cfef-441c-aac3-b747cd030497'
);


-- TH 8 오페라 <체레비치키>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <체레비치키>', 'Cherevichki', 'song', 'TH 8', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <체레비치키>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bde1e727-704c-42ab-859d-917049ee7af0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bde1e727-704c-42ab-859d-917049ee7af0'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '오페라 <체레비치키>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bde1e727-704c-42ab-859d-917049ee7af0'
);


-- TH 9 오페라 <마녀>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <마녀>', 'The Enchantress', 'song', 'TH 9', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <마녀>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3bafb77b-adda-46d6-b272-86b3b91400c1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3bafb77b-adda-46d6-b272-86b3b91400c1'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '오페라 <마녀>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3bafb77b-adda-46d6-b272-86b3b91400c1'
);


-- TH 16 부수음악 <가짜 드미트리와 바실리 슈이스키>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <가짜 드미트리와 바실리 슈이스키>', 'Dmitri the Pretender and Vassily Shuisky, incidental music', 'song', 'TH 16', NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <가짜 드미트리와 바실리 슈이스키>'
);


-- TH 22 부수음악 <보예보다>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <보예보다>', 'The Voyevoda, melodrama for Ostrovsky''s play', 'song', 'TH 22', NULL, NULL, 1886, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <보예보다>'
);


-- TH 38 서곡 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 C단조', 'Overture in C minor', 'song', 'TH 38', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 C단조'
);


-- TH 39 서곡 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 F장조', 'Overture in F major', 'song', 'TH 39', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '396f852b-1dcf-4cb2-9438-7fa76df57729'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '396f852b-1dcf-4cb2-9438-7fa76df57729'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '서곡 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '396f852b-1dcf-4cb2-9438-7fa76df57729'
);


-- TH 42 환상 서곡 <로미오와 줄리엣>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '환상 서곡 <로미오와 줄리엣>', 'Romeo and Juliet, Fantasy Overture', 'song', 'TH 42', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '환상 서곡 <로미오와 줄리엣>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd33ffabe-159f-3ab0-ba87-e497d7dd4b32'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd33ffabe-159f-3ab0-ba87-e497d7dd4b32'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '환상 서곡 <로미오와 줄리엣>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd33ffabe-159f-3ab0-ba87-e497d7dd4b32'
);


-- TH 43 니콜라이 루빈시테인의 명명일을 위한 세레나데

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '니콜라이 루빈시테인의 명명일을 위한 세레나데', 'Serenade for Nikolai Rubinstein''s Name Day', 'song', 'TH 43', NULL, NULL, 1872, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '니콜라이 루빈시테인의 명명일을 위한 세레나데'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '912970bf-df72-4258-a02c-2a85fe5a2e33'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '912970bf-df72-4258-a02c-2a85fe5a2e33'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '니콜라이 루빈시테인의 명명일을 위한 세레나데' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '912970bf-df72-4258-a02c-2a85fe5a2e33'
);


-- TH 50 대관식 행진곡 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '대관식 행진곡 D장조', 'Coronation March in D major', 'song', 'TH 50', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '대관식 행진곡 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4e5af4ea-7cab-3726-9578-a5a78c9e3521'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4e5af4ea-7cab-3726-9578-a5a78c9e3521'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '대관식 행진곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4e5af4ea-7cab-3726-9578-a5a78c9e3521'
);


-- TH 51 엘레지 G장조 "사마린을 기리며"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '엘레지 G장조 "사마린을 기리며"', 'Elegy in G major "In Memory of I. V. Samarin"', 'song', 'TH 51', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '엘레지 G장조 "사마린을 기리며"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07417a8c-2dcf-422a-8d28-119952369694'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '07417a8c-2dcf-422a-8d28-119952369694'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '엘레지 G장조 "사마린을 기리며"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07417a8c-2dcf-422a-8d28-119952369694'
);


-- TH 52 법률학교 행진곡 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '법률학교 행진곡 D장조', 'Jurisprudence March in D major', 'song', 'TH 52', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '법률학교 행진곡 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '633df3f2-3ea2-4875-be32-18bb6f1ad4b3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '633df3f2-3ea2-4875-be32-18bb6f1ad4b3'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '법률학교 행진곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '633df3f2-3ea2-4875-be32-18bb6f1ad4b3'
);


-- TH 63 첼로와 현악 합주를 위한 안단테 칸타빌레

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로와 현악 합주를 위한 안단테 칸타빌레', 'Andante cantabile for cello and string orchestra', 'song', 'TH 63', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로와 현악 합주를 위한 안단테 칸타빌레'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f9f838d-ca96-3f45-836c-73ea41e13d3d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3f9f838d-ca96-3f45-836c-73ea41e13d3d'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '첼로와 현악 합주를 위한 안단테 칸타빌레' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f9f838d-ca96-3f45-836c-73ea41e13d3d'
);


-- TH 64 첼로와 관현악을 위한 녹턴 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로와 관현악을 위한 녹턴 D단조', 'Nocturne in D minor for cello and orchestra', 'song', 'TH 64', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로와 관현악을 위한 녹턴 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8a6f5b55-e5f8-4d67-8d06-ff859612b48d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8a6f5b55-e5f8-4d67-8d06-ff859612b48d'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '첼로와 관현악을 위한 녹턴 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8a6f5b55-e5f8-4d67-8d06-ff859612b48d'
);


-- TH 66 칸타타 <환희의 송가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <환희의 송가>', 'Ode to Joy, Cantata', 'song', 'TH 66', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <환희의 송가>'
);


-- TH 67 표트르 대제 탄생 200주년 칸타타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '표트르 대제 탄생 200주년 칸타타', 'Cantata for the Bicentenary of Peter the Great', 'song', 'TH 67', NULL, NULL, 1872, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '표트르 대제 탄생 200주년 칸타타'
);


-- TH 68 오시프 페트로프 무대 50주년 칸타타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오시프 페트로프 무대 50주년 칸타타', 'Cantata for the Golden Jubilee of Osip Petrov', 'song', 'TH 68', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오시프 페트로프 무대 50주년 칸타타'
);


-- TH 69 칸타타 <모스크바>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <모스크바>', 'Moscow, Coronation Cantata', 'song', 'TH 69', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <모스크바>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '05cdfbf6-f450-4029-bef4-af2929053f4e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '05cdfbf6-f450-4029-bef4-af2929053f4e'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '칸타타 <모스크바>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '05cdfbf6-f450-4029-bef4-af2929053f4e'
);


-- TH 70 합창곡 <Na son gryadushchiy>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Na son gryadushchiy>', 'Na son gryadushchiy (At Bedtime)', 'song', 'TH 70', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Na son gryadushchiy>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9245a36e-06e3-4f16-82dd-94ac53b7499a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9245a36e-06e3-4f16-82dd-94ac53b7499a'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '합창곡 <Na son gryadushchiy>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9245a36e-06e3-4f16-82dd-94ac53b7499a'
);


-- TH 71 꽃과 곤충의 합창

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '꽃과 곤충의 합창', 'Chorus of Flowers and Insects', 'song', 'TH 71', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '꽃과 곤충의 합창'
);


-- TH 72 삼중창 <Priroda i lyubov'>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '삼중창 <Priroda i lyubov''>', 'Priroda i lyubov'' (Nature and Love)', 'song', 'TH 72', NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '삼중창 <Priroda i lyubov''>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '74796241-b9b3-42ab-9d60-be0ccd7391cb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '74796241-b9b3-42ab-9d60-be0ccd7391cb'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '삼중창 <Priroda i lyubov''>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '74796241-b9b3-42ab-9d60-be0ccd7391cb'
);


-- TH 73 합창곡 <Vesna>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Vesna>', 'Vesna (Spring)', 'song', 'TH 73', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Vesna>'
);


-- TH 74 합창곡 <Vecher>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Vecher>', 'Vecher (Evening)', 'song', 'TH 74', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Vecher>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '59ea9b99-cdf1-4b2a-998f-3eeb688c3e81'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '59ea9b99-cdf1-4b2a-998f-3eeb688c3e81'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '합창곡 <Vecher>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '59ea9b99-cdf1-4b2a-998f-3eeb688c3e81'
);


-- TH 78 9개의 성가 TH 78

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '9개의 성가 TH 78', '9 Sacred Pieces', 'album', NULL, 'TH', '78', 1885, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '9개의 성가 TH 78'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '48db5e7c-554e-4601-bd8a-104fbc01a798'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '48db5e7c-554e-4601-bd8a-104fbc01a798'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '9개의 성가 TH 78' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '48db5e7c-554e-4601-bd8a-104fbc01a798'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b460dbf5-8819-41e5-82fe-082cd6a256fa', 1, NULL, 'Kheruvimskaya pesn'' F장조', 'Kheruvimskaya pesn'' in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '9개의 성가 TH 78' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b460dbf5-8819-41e5-82fe-082cd6a256fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19058a6d-60b5-460e-8f23-5ab98b16c74d', 2, NULL, 'Kheruvimskaya pesn'' D장조', 'Kheruvimskaya pesn'' in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '9개의 성가 TH 78' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19058a6d-60b5-460e-8f23-5ab98b16c74d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1716da1d-b3b4-4082-8a06-36860818d9e7', 3, NULL, 'Kheruvimskaya pesn'' C장조', 'Kheruvimskaya pesn'' in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '9개의 성가 TH 78' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1716da1d-b3b4-4082-8a06-36860818d9e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61465363-1db0-40d5-86f6-5892b1748719', 4, NULL, 'Tebe poem C장조', 'Tebe poem in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '9개의 성가 TH 78' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61465363-1db0-40d5-86f6-5892b1748719'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e5706fa-711d-45f1-a237-413b11ce4c5f', 5, NULL, 'Dostoyno yest'' D단조', 'Dostoyno yest'' in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '9개의 성가 TH 78' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e5706fa-711d-45f1-a237-413b11ce4c5f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:822a0df7-282b-4482-a9e0-6f8be4f9e100', 6, NULL, 'Otche nash F장조', 'Otche nash in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '9개의 성가 TH 78' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:822a0df7-282b-4482-a9e0-6f8be4f9e100'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c817b11d-7fd6-45fd-bc00-6543f707b893', 7, NULL, 'Blazheni, yazhe izbral E♭장조', 'Blazheni, yazhe izbral in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '9개의 성가 TH 78' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c817b11d-7fd6-45fd-bc00-6543f707b893'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0f56bec-2d42-4030-a1e5-d8b45a2da525', 8, NULL, 'Da ispravitsya D단조', 'Da ispravitsya in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '9개의 성가 TH 78' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0f56bec-2d42-4030-a1e5-d8b45a2da525'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7765d352-844e-4697-af60-8612bbbf52ce', 9, NULL, 'Nyne sily nebesnyya G장조', 'Nyne sily nebesnyya in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '9개의 성가 TH 78' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7765d352-844e-4697-af60-8612bbbf52ce'
);


-- TH 80 법률학교 노래

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '법률학교 노래', 'Jurists'' Song', 'song', 'TH 80', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '법률학교 노래'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e728b996-369c-475b-8062-13eb692a7138'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e728b996-369c-475b-8062-13eb692a7138'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '법률학교 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e728b996-369c-475b-8062-13eb692a7138'
);


-- TH 81 합창곡 <Angel vopiyashe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Angel vopiyashe>', 'Angel vopiyashe (The Angel Cried Out)', 'song', 'TH 81', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Angel vopiyashe>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '02635a13-5235-4fdf-b93d-cd07f0ea4a49'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '02635a13-5235-4fdf-b93d-cd07f0ea4a49'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '합창곡 <Angel vopiyashe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '02635a13-5235-4fdf-b93d-cd07f0ea4a49'
);


-- TH 82 합창곡 <Nochevala tuchka zolotaya>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Nochevala tuchka zolotaya>', 'Nochevala tuchka zolotaya (The Golden Cloud Did Sleep)', 'song', 'TH 82', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Nochevala tuchka zolotaya>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '74f4b054-466d-400f-bf54-204662e04de2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '74f4b054-466d-400f-bf54-204662e04de2'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '합창곡 <Nochevala tuchka zolotaya>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '74f4b054-466d-400f-bf54-204662e04de2'
);


-- TH 83 합창곡 <Blazhen, kto ulybaetsya>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Blazhen, kto ulybaetsya>', 'Blazhen, kto ulybaetsya (Blessed Is He Who Smiles)', 'song', 'TH 83', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Blazhen, kto ulybaetsya>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cbe1376d-e90f-4c0a-903f-aa88077434a6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cbe1376d-e90f-4c0a-903f-aa88077434a6'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '합창곡 <Blazhen, kto ulybaetsya>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cbe1376d-e90f-4c0a-903f-aa88077434a6'
);


-- TH 84 합창곡 <Solovushko>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Solovushko>', 'Solovushko (The Nightingale)', 'song', 'TH 84', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Solovushko>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '02b268f7-652c-4fe1-a456-6cf02cdcd481'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '02b268f7-652c-4fe1-a456-6cf02cdcd481'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '합창곡 <Solovushko>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '02b268f7-652c-4fe1-a456-6cf02cdcd481'
);


-- TH 85 합창곡 <전설>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <전설>', 'Legend, for chorus', 'song', 'TH 85', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <전설>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c5f0c44-78e0-4e8a-8ed1-d3786da02293'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6c5f0c44-78e0-4e8a-8ed1-d3786da02293'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '합창곡 <전설>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c5f0c44-78e0-4e8a-8ed1-d3786da02293'
);


-- TH 86 A. G. 루빈시테인에게 보내는 인사

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'A. G. 루빈시테인에게 보내는 인사', 'A Greeting to A. G. Rubinstein', 'song', 'TH 86', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'A. G. 루빈시테인에게 보내는 인사'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b340056-719c-41e7-9f73-928c1e9469a6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6b340056-719c-41e7-9f73-928c1e9469a6'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = 'A. G. 루빈시테인에게 보내는 인사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b340056-719c-41e7-9f73-928c1e9469a6'
);


-- TH 87 3개의 합창곡 TH 87

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 합창곡 TH 87', '3 Choruses, TH 87', 'album', NULL, 'TH', '87', 1891, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 합창곡 TH 87'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ea79201-4970-475a-852a-4ad34b3e6fcc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0ea79201-4970-475a-852a-4ad34b3e6fcc'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '3개의 합창곡 TH 87' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ea79201-4970-475a-852a-4ad34b3e6fcc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:117d4d2f-a510-434a-92ca-034941c18ee4', 1, NULL, 'Ne kukushechka vo syrom boru', 'Ne kukushechka vo syrom boru', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '3개의 합창곡 TH 87' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:117d4d2f-a510-434a-92ca-034941c18ee4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da86285c-de0f-403d-be7b-2f9ce878e810', 2, NULL, 'Chto smolknul veseliya glas?', 'Chto smolknul veseliya glas?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '3개의 합창곡 TH 87' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da86285c-de0f-403d-be7b-2f9ce878e810'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:831eb3ee-8429-4687-8ff7-0e29bdbb5a5f', 3, NULL, 'Bez pory da bez vremeni', 'Bez pory da bez vremeni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '3개의 합창곡 TH 87' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:831eb3ee-8429-4687-8ff7-0e29bdbb5a5f'
);


-- TH 89 가곡 <Moy geniy, moy angel, moy drug>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Moy geniy, moy angel, moy drug>', 'Moy geniy, moy angel, moy drug', 'song', 'TH 89', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Moy geniy, moy angel, moy drug>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5e0673a5-f504-34c4-b3e9-7742001eea19'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5e0673a5-f504-34c4-b3e9-7742001eea19'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '가곡 <Moy geniy, moy angel, moy drug>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5e0673a5-f504-34c4-b3e9-7742001eea19'
);


-- TH 90 가곡 <Pesn' Zemfiry>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Pesn'' Zemfiry>', 'Pesn'' Zemfiry (Zemfira''s Song)', 'song', 'TH 90', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Pesn'' Zemfiry>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '75046ad1-331d-42aa-a00f-8a4bf44f574d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '75046ad1-331d-42aa-a00f-8a4bf44f574d'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '가곡 <Pesn'' Zemfiry>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '75046ad1-331d-42aa-a00f-8a4bf44f574d'
);


-- TH 91 가곡 <Mezza notte>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Mezza notte>', 'Mezza notte', 'song', 'TH 91', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Mezza notte>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '48a17615-cf87-408c-acfe-a47af45f2060'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '48a17615-cf87-408c-acfe-a47af45f2060'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '가곡 <Mezza notte>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '48a17615-cf87-408c-acfe-a47af45f2060'
);


-- TH 94 가곡 <Zabyt' tak skoro>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Zabyt'' tak skoro>', 'Zabyt'' tak skoro', 'song', 'TH 94', NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Zabyt'' tak skoro>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '595c9767-17b7-4cfd-a5d2-8b0eae3434a8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '595c9767-17b7-4cfd-a5d2-8b0eae3434a8'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '가곡 <Zabyt'' tak skoro>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '595c9767-17b7-4cfd-a5d2-8b0eae3434a8'
);


-- TH 96 2개의 로망스 TH 96

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 로망스 TH 96', '2 Romances, TH 96', 'album', NULL, 'TH', '96', 1873, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 로망스 TH 96'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f51c94ff-0f5d-4326-8599-1b1427e2272d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f51c94ff-0f5d-4326-8599-1b1427e2272d'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '2개의 로망스 TH 96' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f51c94ff-0f5d-4326-8599-1b1427e2272d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3af9000d-4174-4ede-a4fb-cebab82717c5', 1, NULL, 'Unosi moyo serdtse v zvenyashchuyu dal''', 'Unosi moyo serdtse v zvenyashchuyu dal''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '2개의 로망스 TH 96' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3af9000d-4174-4ede-a4fb-cebab82717c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ae9bcf1-65b7-4bef-9216-bc261a6497a0', 2, NULL, 'Glazki vesny golubye', 'Glazki vesny golubye', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '2개의 로망스 TH 96' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ae9bcf1-65b7-4bef-9216-bc261a6497a0'
);


-- TH 100 2개의 로망스 TH 100

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 로망스 TH 100', '2 Romances, TH 100', 'album', NULL, 'TH', '100', 1875, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 로망스 TH 100'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ec8aba2-8125-444f-aeed-0b547574f137'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6ec8aba2-8125-444f-aeed-0b547574f137'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '2개의 로망스 TH 100' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ec8aba2-8125-444f-aeed-0b547574f137'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56f71c60-d98c-4019-b93e-e498097de7dd', 1, NULL, 'Khotel by v yedinoe slovo', 'Khotel by v yedinoe slovo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '2개의 로망스 TH 100' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56f71c60-d98c-4019-b93e-e498097de7dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b29b3fa1-7cfe-4c5a-89a6-d6ef725835c6', 2, NULL, 'Ne dolgo nam gulyat''', 'Ne dolgo nam gulyat''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '2개의 로망스 TH 100' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b29b3fa1-7cfe-4c5a-89a6-d6ef725835c6'
);


-- TH 110 현악 4중주 악장 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 악장 B♭장조', 'String Quartet Movement in B♭ major', 'song', 'TH 110', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 악장 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '67939852-80cc-3a4b-b16b-4cd459c0b4b3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '67939852-80cc-3a4b-b16b-4cd459c0b4b3'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '현악 4중주 악장 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '67939852-80cc-3a4b-b16b-4cd459c0b4b3'
);


-- TH 119 아나스타샤 왈츠

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아나스타샤 왈츠', 'Anastasie-Valse', 'song', 'TH 119', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아나스타샤 왈츠'
);


-- TH 121 주제와 변주 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '주제와 변주 A단조', 'Theme and Variations in A minor', 'song', 'TH 121', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '주제와 변주 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a54680db-08e8-49c6-97d9-bb46588718fe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a54680db-08e8-49c6-97d9-bb46588718fe'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '주제와 변주 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a54680db-08e8-49c6-97d9-bb46588718fe'
);


-- TH 140 의용 함대 행진곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '의용 함대 행진곡', 'The Volunteer Fleet March', 'song', 'TH 140', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '의용 함대 행진곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5eacefa9-1d24-4ecc-84ee-bf13c753c8c6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5eacefa9-1d24-4ecc-84ee-bf13c753c8c6'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '의용 함대 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5eacefa9-1d24-4ecc-84ee-bf13c753c8c6'
);


-- TH 144 즉흥 카프리스 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '즉흥 카프리스 G장조', 'Impromptu-caprice in G major', 'song', 'TH 144', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '즉흥 카프리스 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '69745f39-b4be-4ac5-a12e-c28e5298a1c3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '69745f39-b4be-4ac5-a12e-c28e5298a1c3'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '즉흥 카프리스 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '69745f39-b4be-4ac5-a12e-c28e5298a1c3'
);


-- TH 146 왈츠-스케르초 A장조 (1889)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠-스케르초 A장조 (1889)', 'Valse-scherzo in A major (1889)', 'song', 'TH 146', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠-스케르초 A장조 (1889)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ece1efd5-074a-4561-adf5-2a962ee479f7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ece1efd5-074a-4561-adf5-2a962ee479f7'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '왈츠-스케르초 A장조 (1889)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ece1efd5-074a-4561-adf5-2a962ee479f7'
);


-- TH 147 즉흥곡 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '즉흥곡 A♭장조', 'Impromptu in A♭ major', 'song', 'TH 147', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '즉흥곡 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3950df04-1468-48f0-b003-8f7f0e2b3aae'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3950df04-1468-48f0-b003-8f7f0e2b3aae'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '즉흥곡 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3950df04-1468-48f0-b003-8f7f0e2b3aae'
);


-- TH 148 열정적인 고백 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '열정적인 고백 E단조', 'Aveu passionné in E minor', 'song', 'TH 148', NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '열정적인 고백 E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f3f5d23-3f7d-3d10-ba76-9335c43471db'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2f3f5d23-3f7d-3d10-ba76-9335c43471db'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '열정적인 고백 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f3f5d23-3f7d-3d10-ba76-9335c43471db'
);


-- TH 150 군대 행진곡 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '군대 행진곡 B♭장조', 'Military March in B♭ major', 'song', 'TH 150', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '군대 행진곡 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f27ade67-e87d-4ad7-a66c-98d2ed588a3e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f27ade67-e87d-4ad7-a66c-98d2ed588a3e'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '군대 행진곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f27ade67-e87d-4ad7-a66c-98d2ed588a3e'
);


-- TH 152 알레그레토 모데라토 D장조 (현악 3중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그레토 모데라토 D장조 (현악 3중주)', 'Allegretto moderato in D major for string trio', 'song', 'TH 152', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그레토 모데라토 D장조 (현악 3중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80c72aaf-b6be-4c05-85e4-e45306c86c59'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '80c72aaf-b6be-4c05-85e4-e45306c86c59'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '알레그레토 모데라토 D장조 (현악 3중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80c72aaf-b6be-4c05-85e4-e45306c86c59'
);


-- TH 153 알레그레토 E장조 (현악 4중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그레토 E장조 (현악 4중주)', 'Allegretto in E major for string quartet', 'song', 'TH 153', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그레토 E장조 (현악 4중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb7a391c-bf89-4b21-89ad-d75cc554f99c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eb7a391c-bf89-4b21-89ad-d75cc554f99c'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '알레그레토 E장조 (현악 4중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb7a391c-bf89-4b21-89ad-d75cc554f99c'
);


-- TH 154 알레그로 비바체 B♭장조 (현악 4중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그로 비바체 B♭장조 (현악 4중주)', 'Allegro vivace in B♭ major for string quartet', 'song', 'TH 154', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그로 비바체 B♭장조 (현악 4중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd813357f-3a93-4f59-bd47-d9ca5abedc06'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd813357f-3a93-4f59-bd47-d9ca5abedc06'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '알레그로 비바체 B♭장조 (현악 4중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd813357f-3a93-4f59-bd47-d9ca5abedc06'
);


-- TH 155 안단테 몰토 G장조 (현악 4중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단테 몰토 G장조 (현악 4중주)', 'Andante molto in G major for string quartet', 'song', 'TH 155', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단테 몰토 G장조 (현악 4중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e99d766-4292-4cc7-aed7-0e8243e9a4e8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9e99d766-4292-4cc7-aed7-0e8243e9a4e8'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '안단테 몰토 G장조 (현악 4중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e99d766-4292-4cc7-aed7-0e8243e9a4e8'
);


-- TH 158 아다지오 몰토 E♭장조 (현악 4중주와 하프)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아다지오 몰토 E♭장조 (현악 4중주와 하프)', 'Adagio molto in E♭ major for string quartet and harp', 'song', 'TH 158', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아다지오 몰토 E♭장조 (현악 4중주와 하프)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ce3ff249-1058-38bf-a4fd-d485d597bca5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ce3ff249-1058-38bf-a4fd-d485d597bca5'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '아다지오 몰토 E♭장조 (현악 4중주와 하프)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ce3ff249-1058-38bf-a4fd-d485d597bca5'
);


-- TH 159 알레그로 C단조 (피아노 6중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그로 C단조 (피아노 6중주)', 'Allegro in C minor for piano sextet', 'song', 'TH 159', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그로 C단조 (피아노 6중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b6db2388-3e68-49a5-99ac-7d72f46ff7f0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b6db2388-3e68-49a5-99ac-7d72f46ff7f0'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '알레그로 C단조 (피아노 6중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b6db2388-3e68-49a5-99ac-7d72f46ff7f0'
);


-- TH 162 라르고와 알레그로 (플루트 2대와 현악)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '라르고와 알레그로 (플루트 2대와 현악)', 'Largo and Allegro for two flutes and strings', 'song', 'TH 162', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 34
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '라르고와 알레그로 (플루트 2대와 현악)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '23fa1827-31fa-4b70-81bb-c8226c928549'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '23fa1827-31fa-4b70-81bb-c8226c928549'
FROM pieces p
WHERE p.composer_id = 34 AND p.title = '라르고와 알레그로 (플루트 2대와 현악)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '23fa1827-31fa-4b70-81bb-c8226c928549'
);

