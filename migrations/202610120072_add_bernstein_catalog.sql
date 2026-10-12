-- 번스타인 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 76개(묶음 16, 다악장 19, 낱곡 41),
-- 새 작품 5개, part 280개, 그 아래 0개.
-- seed 134개 중 71개를 작품·part 에 잇고, 50개를 숨기고, 13개는 그대로 둔다.
--
-- 4차는 사람·에이전트 판단 없이 규칙으로 만들었다. 자료와 규칙은
-- seed_pipeline/curation/catalog-wave4-2026-10-12/(auto_catalog.py, <작곡가>/catalog.json·seed_map.json).
--   작품: MusicBrainz 에서 이 작곡가가 composer 인 work 중 다른 work 의 part 가 아니고 편곡·다른 판·
--     발췌·단편·리믹스 표시가 없는 것. part 는 MB parts 순서대로 두 겹까지.
--   제목: 「Symphony no. 5 in C minor」 꼴은 「교향곡 5번 C단조」로 옮기고, 못 읽으면 원제를 둔다
--     (MB 갈래가 가곡·오페라 등이면 「가곡 <원제>」).
--   seed 작품: MBID 가 작품이면 그 자리(제목을 위 꼴로 고치고 잠금), part 면 part 로 잇고,
--     편곡·다른 판·중복·리믹스면 hidden_reason='catalog_unmatched' 로 숨긴다(지우지 않음).
--     판단이 서지 않는 seed 는 손대지 않고 보이게 둔다. 숨길 seed 가 카탈로그 제목을 쥐고 있으면
--     그 seed 제목 뒤에 까닭을 붙여 자리를 비운다(숨긴 작품이라 목록에 안 보임).
--   manual 작품: 제목·설명·링크는 바꾸지 않는다. MBID 가 엉뚱한 work 를 가리키면(제목이 전혀 다름)
--     잇지 않고, MBID 가 없으면 영어 제목이 같은 작품에 잇는다(식별자는 더하지 않음).
--   비교 구간이 있거나 part 가 가리키는 작품은 숨기지 않는다. 두 번 돌려도 같다.

-- 숨길 seed 가 쥔 카탈로그 제목을 비운다
UPDATE pieces piece
SET piece.title = 'Seven Anniversaries (중복 2208)'
WHERE piece.id = 2208 AND piece.composer_id = 87 AND piece.title = 'Seven Anniversaries'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);


-- None 뮤지컬 <1600 Pennsylvania Avenue>

UPDATE pieces piece
SET piece.title = '뮤지컬 <1600 Pennsylvania Avenue>', piece.title_en = '1600 Pennsylvania Avenue',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1037 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The President Jefferson Sunday Luncheon Party March', part.name_en = 'The President Jefferson Sunday Luncheon Party March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1037 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:6e47fd52-db44-4b85-9dca-fe4832264eb1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e47fd52-db44-4b85-9dca-fe4832264eb1', 1, NULL, 'The President Jefferson Sunday Luncheon Party March', 'The President Jefferson Sunday Luncheon Party March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1037 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e47fd52-db44-4b85-9dca-fe4832264eb1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Take Care of This House', part.name_en = 'Take Care of This House',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1037 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:f8c64247-5e96-4262-8be9-71b06a8ec2f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8c64247-5e96-4262-8be9-71b06a8ec2f2', 2, NULL, 'Take Care of This House', 'Take Care of This House', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1037 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8c64247-5e96-4262-8be9-71b06a8ec2f2'
);


-- None A Musical Toast

UPDATE pieces piece
SET piece.title = 'A Musical Toast', piece.title_en = 'A Musical Toast',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2895 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <A Quiet Place>

UPDATE pieces piece
SET piece.title = '오페라 <A Quiet Place>', piece.title_en = 'A Quiet Place',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1928 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A White House Cantata

UPDATE pieces piece
SET piece.title = 'A White House Cantata', piece.title_en = 'A White House Cantata',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1500 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <Arias & Barcarolles>

UPDATE pieces piece
SET piece.title = '연가곡집 <Arias & Barcarolles>', piece.title_en = 'Arias & Barcarolles',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2263 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelude', part.name_en = 'Arias and Barcarolles: Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2263 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:91cd470c-9903-4b70-8e4a-80678797ee87' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91cd470c-9903-4b70-8e4a-80678797ee87', 1, NULL, 'Prelude', 'Arias and Barcarolles: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2263 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91cd470c-9903-4b70-8e4a-80678797ee87'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Love Duet', part.name_en = 'Arias and Barcarolles: Love Duet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2263 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:099af814-0ac6-422d-b2a6-3a126bf44efb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:099af814-0ac6-422d-b2a6-3a126bf44efb', 2, NULL, 'Love Duet', 'Arias and Barcarolles: Love Duet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2263 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:099af814-0ac6-422d-b2a6-3a126bf44efb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Little Smary', part.name_en = 'Arias and Barcarolles: Little Smary',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2263 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:31c7fe2e-29bf-4d17-b73e-94f059d939b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31c7fe2e-29bf-4d17-b73e-94f059d939b0', 3, NULL, 'Little Smary', 'Arias and Barcarolles: Little Smary', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2263 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31c7fe2e-29bf-4d17-b73e-94f059d939b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'The Love of My Life', part.name_en = 'Arias and Barcarolles: The Love of My Life',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2263 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:323d5d0f-7083-45ae-ada9-771213751ef6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:323d5d0f-7083-45ae-ada9-771213751ef6', 4, NULL, 'The Love of My Life', 'Arias and Barcarolles: The Love of My Life', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2263 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:323d5d0f-7083-45ae-ada9-771213751ef6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Greeting', part.name_en = 'Arias and Barcarolles: Greeting',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2263 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:0980fbd5-5810-4c12-bc6c-36af4dc714d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0980fbd5-5810-4c12-bc6c-36af4dc714d4', 5, NULL, 'Greeting', 'Arias and Barcarolles: Greeting', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2263 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0980fbd5-5810-4c12-bc6c-36af4dc714d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Oif mayn khas''neh (At My Wedding)', part.name_en = 'Arias and Barcarolles: Oif mayn khas''neh (At My Wedding)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2263 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:2c4aac90-cb1c-43fc-9f1f-2148759afe2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c4aac90-cb1c-43fc-9f1f-2148759afe2e', 6, NULL, 'Oif mayn khas''neh (At My Wedding)', 'Arias and Barcarolles: Oif mayn khas''neh (At My Wedding)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2263 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c4aac90-cb1c-43fc-9f1f-2148759afe2e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Mr. and Mrs. Webb Say Goodnight', part.name_en = 'Arias and Barcarolles: Mr. and Mrs. Webb Say Goodnight',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2263 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:78ed5588-5e6e-4608-9bee-94155a0d1875' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78ed5588-5e6e-4608-9bee-94155a0d1875', 7, NULL, 'Mr. and Mrs. Webb Say Goodnight', 'Arias and Barcarolles: Mr. and Mrs. Webb Say Goodnight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2263 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78ed5588-5e6e-4608-9bee-94155a0d1875'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Nachspiel (In Memoriam)', part.name_en = 'Arias and Barcarolles: Nachspiel (In Memoriam)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2263 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:535a1987-7cdd-4318-98f5-7e7824610fe4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:535a1987-7cdd-4318-98f5-7e7824610fe4', 8, NULL, 'Nachspiel (In Memoriam)', 'Arias and Barcarolles: Nachspiel (In Memoriam)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2263 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:535a1987-7cdd-4318-98f5-7e7824610fe4'
);


-- None CBS Music

UPDATE pieces piece
SET piece.title = 'CBS Music', piece.title_en = 'CBS Music',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1712 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페레타 <Candide>

UPDATE pieces piece
SET piece.title = '오페레타 <Candide>', piece.title_en = 'Candide',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1150 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 338 AND linked.composer_id = 87),
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'Candide: Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:f27a6729-0610-348e-83b3-d55c5d53ff86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 338 AND linked.composer_id = 87), 'musicbrainz:f27a6729-0610-348e-83b3-d55c5d53ff86', 1, NULL, 'Overture', 'Candide: Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f27a6729-0610-348e-83b3-d55c5d53ff86'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I. Chorale', part.name_en = 'Candide: Act I. Chorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:8a972d4a-9dc4-4acc-a967-b26a15df7a8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a972d4a-9dc4-4acc-a967-b26a15df7a8a', 2, NULL, 'Act I. Chorale', 'Candide: Act I. Chorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a972d4a-9dc4-4acc-a967-b26a15df7a8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act I. Life Is Happiness Indeed', part.name_en = 'Candide: Act I. Life Is Happiness Indeed',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:87e5a917-1ded-4bad-91be-9f52b569eb5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87e5a917-1ded-4bad-91be-9f52b569eb5b', 3, NULL, 'Act I. Life Is Happiness Indeed', 'Candide: Act I. Life Is Happiness Indeed', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87e5a917-1ded-4bad-91be-9f52b569eb5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act I. The Old Lady''s False Entrance', part.name_en = 'Candide: Act I. The Old Lady''s False Entrance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:285fa621-9ef4-44f3-a780-60f2e483b54c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:285fa621-9ef4-44f3-a780-60f2e483b54c', 4, NULL, 'Act I. The Old Lady''s False Entrance', 'Candide: Act I. The Old Lady''s False Entrance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:285fa621-9ef4-44f3-a780-60f2e483b54c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act I. The Best of All Possible Worlds', part.name_en = 'Candide: Act I. The Best of All Possible Worlds',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:8b47851c-ff9b-3394-b307-d0eb277980d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b47851c-ff9b-3394-b307-d0eb277980d6', 5, NULL, 'Act I. The Best of All Possible Worlds', 'Candide: Act I. The Best of All Possible Worlds', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b47851c-ff9b-3394-b307-d0eb277980d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act I. Universal Good', part.name_en = 'Candide: Act I. Universal Good',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:32ed8b11-f749-4359-b480-bfbf9d9fa6c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32ed8b11-f749-4359-b480-bfbf9d9fa6c5', 6, NULL, 'Act I. Universal Good', 'Candide: Act I. Universal Good', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32ed8b11-f749-4359-b480-bfbf9d9fa6c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act I. Oh, Happy We', part.name_en = 'Candide: Act I. Oh, Happy We',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:3860218f-7e45-4e86-8051-fd8efe1e1012' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3860218f-7e45-4e86-8051-fd8efe1e1012', 7, NULL, 'Act I. Oh, Happy We', 'Candide: Act I. Oh, Happy We', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3860218f-7e45-4e86-8051-fd8efe1e1012'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act I. It Must Be So', part.name_en = 'Candide: Act I. It Must Be So',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:5c46497a-282a-4563-9e77-8363cd20eac7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c46497a-282a-4563-9e77-8363cd20eac7', 8, NULL, 'Act I. It Must Be So', 'Candide: Act I. It Must Be So', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c46497a-282a-4563-9e77-8363cd20eac7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act I. Westphalia', part.name_en = 'Candide: Act I. Westphalia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:c367a436-0d70-4221-aaf1-5842d71aab00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c367a436-0d70-4221-aaf1-5842d71aab00', 9, NULL, 'Act I. Westphalia', 'Candide: Act I. Westphalia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c367a436-0d70-4221-aaf1-5842d71aab00'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act I. Battle Music', part.name_en = 'Candide: Act I. Battle Music',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:fc3f0b05-b173-48fb-9e87-df5fc1a83e62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc3f0b05-b173-48fb-9e87-df5fc1a83e62', 10, NULL, 'Act I. Battle Music', 'Candide: Act I. Battle Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc3f0b05-b173-48fb-9e87-df5fc1a83e62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act I. Candide''s Lament', part.name_en = 'Candide: Act I. Candide''s Lament',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:5cc88fa4-c58d-40ea-bdbc-13a53f201f58' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cc88fa4-c58d-40ea-bdbc-13a53f201f58', 11, NULL, 'Act I. Candide''s Lament', 'Candide: Act I. Candide''s Lament', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cc88fa4-c58d-40ea-bdbc-13a53f201f58'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Act I. O Miserere', part.name_en = 'Candide: Act I. O Miserere',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:35a93b5c-42ac-4053-8ea8-a75a1cf9fa6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35a93b5c-42ac-4053-8ea8-a75a1cf9fa6a', 12, NULL, 'Act I. O Miserere', 'Candide: Act I. O Miserere', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35a93b5c-42ac-4053-8ea8-a75a1cf9fa6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Act I. Dear Boy', part.name_en = 'Candide: Act I. Dear Boy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:74842d12-23ed-4a96-8bfa-eb17d46fb32b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74842d12-23ed-4a96-8bfa-eb17d46fb32b', 13, NULL, 'Act I. Dear Boy', 'Candide: Act I. Dear Boy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74842d12-23ed-4a96-8bfa-eb17d46fb32b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Act I. Auto da fé (What a Day)', part.name_en = 'Candide: Act I. Auto da fé (What a Day)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:f0cee433-893a-4b05-996c-9e01ce6c3e79' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0cee433-893a-4b05-996c-9e01ce6c3e79', 14, NULL, 'Act I. Auto da fé (What a Day)', 'Candide: Act I. Auto da fé (What a Day)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0cee433-893a-4b05-996c-9e01ce6c3e79'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Act II. It Must Be Me', part.name_en = 'Candide: Act II. It Must Be Me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:e665e72c-bc0d-4ab5-8059-b6a55f98932d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e665e72c-bc0d-4ab5-8059-b6a55f98932d', 15, NULL, 'Act II. It Must Be Me', 'Candide: Act II. It Must Be Me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e665e72c-bc0d-4ab5-8059-b6a55f98932d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Act I. Paris Waltz', part.name_en = 'Candide: Act I. Paris Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:67f95a13-5b1c-44cf-8f57-2c23e950141e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67f95a13-5b1c-44cf-8f57-2c23e950141e', 16, NULL, 'Act I. Paris Waltz', 'Candide: Act I. Paris Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67f95a13-5b1c-44cf-8f57-2c23e950141e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Act I. Glitter and Be Gay', part.name_en = 'Candide: Act I. Glitter and Be Gay',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:3fde42a1-2b83-3bbf-b2eb-a292159b2830' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fde42a1-2b83-3bbf-b2eb-a292159b2830', 17, NULL, 'Act I. Glitter and Be Gay', 'Candide: Act I. Glitter and Be Gay', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fde42a1-2b83-3bbf-b2eb-a292159b2830'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Act I. The Old Lady''s Second False Entrance', part.name_en = 'Candide: Act I. The Old Lady''s Second False Entrance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:df1d689e-9ac7-4a73-a816-d1503615106c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df1d689e-9ac7-4a73-a816-d1503615106c', 18, NULL, 'Act I. The Old Lady''s Second False Entrance', 'Candide: Act I. The Old Lady''s Second False Entrance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df1d689e-9ac7-4a73-a816-d1503615106c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Act I. You Were Dead, You Know', part.name_en = 'Candide: Act I. You Were Dead, You Know',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:e66d41d8-1735-42a1-a635-777460b6d9aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e66d41d8-1735-42a1-a635-777460b6d9aa', 19, NULL, 'Act I. You Were Dead, You Know', 'Candide: Act I. You Were Dead, You Know', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e66d41d8-1735-42a1-a635-777460b6d9aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Act I. I Am Easily Assimilated (Old Lady’s Tango)', part.name_en = 'Candide: Act I. I Am Easily Assimilated (Old Lady’s Tango)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:f1c7ebd9-c611-369e-9196-a4703178bb3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1c7ebd9-c611-369e-9196-a4703178bb3e', 20, NULL, 'Act I. I Am Easily Assimilated (Old Lady’s Tango)', 'Candide: Act I. I Am Easily Assimilated (Old Lady’s Tango)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1c7ebd9-c611-369e-9196-a4703178bb3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Act I. Quartet Finale', part.name_en = 'Candide: Act I. Quartet Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:5d6067f8-c6ed-4ad8-a2cb-796aba0b4489' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d6067f8-c6ed-4ad8-a2cb-796aba0b4489', 21, NULL, 'Act I. Quartet Finale', 'Candide: Act I. Quartet Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d6067f8-c6ed-4ad8-a2cb-796aba0b4489'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Entr''acte', part.name_en = 'Candide: Entr''acte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:f59d09e0-d448-4418-ba64-eae93c742dd6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f59d09e0-d448-4418-ba64-eae93c742dd6', 22, NULL, 'Entr''acte', 'Candide: Entr''acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f59d09e0-d448-4418-ba64-eae93c742dd6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Act II. Universal Good', part.name_en = 'Candide: Act II. Universal Good',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:88255712-7732-4d79-a565-4895a4ad7f91' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88255712-7732-4d79-a565-4895a4ad7f91', 23, NULL, 'Act II. Universal Good', 'Candide: Act II. Universal Good', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88255712-7732-4d79-a565-4895a4ad7f91'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Act II. Ballad of the New World', part.name_en = 'Candide: Act II. Ballad of the New World',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:2b6bd9bd-d809-490e-b0b1-24f0aa84f9ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b6bd9bd-d809-490e-b0b1-24f0aa84f9ca', 24, NULL, 'Act II. Ballad of the New World', 'Candide: Act II. Ballad of the New World', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b6bd9bd-d809-490e-b0b1-24f0aa84f9ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Act II. The Governor''s Waltz', part.name_en = 'Candide: Act II. The Governor''s Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:1cd7023f-d10b-4016-b726-aff7e3050419' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cd7023f-d10b-4016-b726-aff7e3050419', 25, NULL, 'Act II. The Governor''s Waltz', 'Candide: Act II. The Governor''s Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cd7023f-d10b-4016-b726-aff7e3050419'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'Act II. My Love', part.name_en = 'Candide: Act II. My Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:2be18a38-f7be-42cf-ba20-a767b31930ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2be18a38-f7be-42cf-ba20-a767b31930ab', 26, NULL, 'Act II. My Love', 'Candide: Act II. My Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2be18a38-f7be-42cf-ba20-a767b31930ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'Act II. We Are Women', part.name_en = 'Candide: Act II. We Are Women',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:f6da2f33-9298-428b-b794-7758a13b7e00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6da2f33-9298-428b-b794-7758a13b7e00', 27, NULL, 'Act II. We Are Women', 'Candide: Act II. We Are Women', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6da2f33-9298-428b-b794-7758a13b7e00'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'Act II. Alleluia', part.name_en = 'Candide: Act II. Alleluia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:9fc57835-5da2-4d8d-9f19-1affd0d21b73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fc57835-5da2-4d8d-9f19-1affd0d21b73', 28, NULL, 'Act II. Alleluia', 'Candide: Act II. Alleluia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fc57835-5da2-4d8d-9f19-1affd0d21b73'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'Act II. Quiet', part.name_en = 'Candide: Act II. Quiet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:930ec443-1c30-4c10-a739-c4f6ecfb6f65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:930ec443-1c30-4c10-a739-c4f6ecfb6f65', 29, NULL, 'Act II. Quiet', 'Candide: Act II. Quiet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:930ec443-1c30-4c10-a739-c4f6ecfb6f65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'Act II. Introduction to Eldorado', part.name_en = 'Candide: Act II. Introduction to Eldorado',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:8a8c9a3c-19b1-4c6e-bff4-c3c6806bbc7c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a8c9a3c-19b1-4c6e-bff4-c3c6806bbc7c', 30, NULL, 'Act II. Introduction to Eldorado', 'Candide: Act II. Introduction to Eldorado', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a8c9a3c-19b1-4c6e-bff4-c3c6806bbc7c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'Act II. The Ballad of Eldorado', part.name_en = 'Candide: Act II. The Ballad of Eldorado',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:c99ea70a-2f8a-413e-9597-7c5558667272' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c99ea70a-2f8a-413e-9597-7c5558667272', 31, NULL, 'Act II. The Ballad of Eldorado', 'Candide: Act II. The Ballad of Eldorado', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c99ea70a-2f8a-413e-9597-7c5558667272'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = 'Act II. Sheep Song', part.name_en = 'Candide: Act II. Sheep Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:440cffc4-e033-4891-9dca-3aabe8b3dfa0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:440cffc4-e033-4891-9dca-3aabe8b3dfa0', 32, NULL, 'Act II. Sheep Song', 'Candide: Act II. Sheep Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:440cffc4-e033-4891-9dca-3aabe8b3dfa0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 33, part.movement_number = NULL,
    part.name_ko = 'Act II. Words, Words, Words', part.name_en = 'Candide: Act II. Words, Words, Words',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:84f925f2-4062-47c5-b9ea-3e24ae695a42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84f925f2-4062-47c5-b9ea-3e24ae695a42', 33, NULL, 'Act II. Words, Words, Words', 'Candide: Act II. Words, Words, Words', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84f925f2-4062-47c5-b9ea-3e24ae695a42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 34, part.movement_number = NULL,
    part.name_ko = 'Act II. Bon Voyage', part.name_en = 'Candide: Act II. Bon Voyage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:3ba87a17-d52b-45e2-b0fa-01fd9fc312f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ba87a17-d52b-45e2-b0fa-01fd9fc312f0', 34, NULL, 'Act II. Bon Voyage', 'Candide: Act II. Bon Voyage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ba87a17-d52b-45e2-b0fa-01fd9fc312f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 35, part.movement_number = NULL,
    part.name_ko = 'Act II. The Kings’ Barcarolle', part.name_en = 'Candide: Act II. The Kings’ Barcarolle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:46b95b18-fd83-45e1-a60a-5d0f8c5c6dad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46b95b18-fd83-45e1-a60a-5d0f8c5c6dad', 35, NULL, 'Act II. The Kings’ Barcarolle', 'Candide: Act II. The Kings’ Barcarolle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46b95b18-fd83-45e1-a60a-5d0f8c5c6dad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 36, part.movement_number = NULL,
    part.name_ko = 'Act II. Money, Money, Money', part.name_en = 'Candide: Act II. Money, Money, Money',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:c4521f3a-b962-4740-91e9-9561b825cd3c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4521f3a-b962-4740-91e9-9561b825cd3c', 36, NULL, 'Act II. Money, Money, Money', 'Candide: Act II. Money, Money, Money', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4521f3a-b962-4740-91e9-9561b825cd3c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 37, part.movement_number = NULL,
    part.name_ko = 'Act II. What’s the Use?', part.name_en = 'Candide: Act II. What’s the Use?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:3aea1949-bc89-4288-b3c6-7dfdd1276367' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3aea1949-bc89-4288-b3c6-7dfdd1276367', 37, NULL, 'Act II. What’s the Use?', 'Candide: Act II. What’s the Use?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3aea1949-bc89-4288-b3c6-7dfdd1276367'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 38, part.movement_number = NULL,
    part.name_ko = 'Act II. Venice Gavotte', part.name_en = 'Candide: Act II. Venice Gavotte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:406e72e2-37e0-4a59-bdd2-e52bc6553c95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:406e72e2-37e0-4a59-bdd2-e52bc6553c95', 38, NULL, 'Act II. Venice Gavotte', 'Candide: Act II. Venice Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:406e72e2-37e0-4a59-bdd2-e52bc6553c95'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 39, part.movement_number = NULL,
    part.name_ko = 'Act II. Nothing More Than This', part.name_en = 'Candide: Act II. Nothing More Than This',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:007e7ab2-eefc-4e28-bf43-1473e6c1c4d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:007e7ab2-eefc-4e28-bf43-1473e6c1c4d4', 39, NULL, 'Act II. Nothing More Than This', 'Candide: Act II. Nothing More Than This', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:007e7ab2-eefc-4e28-bf43-1473e6c1c4d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 40, part.movement_number = NULL,
    part.name_ko = 'Act II. Universal Good (Life Is Neither)', part.name_en = 'Candide: Act II. Universal Good (Life Is Neither)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:ef2eeed2-05ed-408e-a011-55211d3cb725' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef2eeed2-05ed-408e-a011-55211d3cb725', 40, NULL, 'Act II. Universal Good (Life Is Neither)', 'Candide: Act II. Universal Good (Life Is Neither)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef2eeed2-05ed-408e-a011-55211d3cb725'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 41, part.movement_number = NULL,
    part.name_ko = 'Act II. Make Our Garden Grow', part.name_en = 'Candide: Act II. Make Our Garden Grow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1150 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:3aea59a8-eb16-3459-883d-4da7fc0394f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3aea59a8-eb16-3459-883d-4da7fc0394f6', 41, NULL, 'Act II. Make Our Garden Grow', 'Candide: Act II. Make Our Garden Grow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1150 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3aea59a8-eb16-3459-883d-4da7fc0394f6'
);


-- None Choruses from 'The Lark'

UPDATE pieces piece
SET piece.title = 'Choruses from ''The Lark''', piece.title_en = 'Choruses from ''The Lark''',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2721 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Spring Song', part.name_en = 'Choruses from ''The Lark'': Spring Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2721 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:60aca147-3301-4736-ae1d-2f995e4b8ad9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60aca147-3301-4736-ae1d-2f995e4b8ad9', 1, NULL, 'Spring Song', 'Choruses from ''The Lark'': Spring Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2721 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60aca147-3301-4736-ae1d-2f995e4b8ad9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Court Song', part.name_en = 'Choruses from ''The Lark'': Court Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2721 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:62ad7983-875f-47e2-bac6-df86efa8d10f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62ad7983-875f-47e2-bac6-df86efa8d10f', 2, NULL, 'Court Song', 'Choruses from ''The Lark'': Court Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2721 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62ad7983-875f-47e2-bac6-df86efa8d10f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Soldier''s Song', part.name_en = 'Choruses from ''The Lark'': Soldier''s Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2721 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:f6da4cfb-7761-4b87-b404-a3415ae7acf7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6da4cfb-7761-4b87-b404-a3415ae7acf7', 3, NULL, 'Soldier''s Song', 'Choruses from ''The Lark'': Soldier''s Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2721 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6da4cfb-7761-4b87-b404-a3415ae7acf7'
);


-- None Choruses from 'The Lark': Benedictus

UPDATE pieces piece
SET piece.title = 'Choruses from ''The Lark'': Benedictus', piece.title_en = 'Choruses from ''The Lark'': Benedictus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1945 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Choruses from 'The Lark': Gloria

UPDATE pieces piece
SET piece.title = 'Choruses from ''The Lark'': Gloria', piece.title_en = 'Choruses from ''The Lark'': Gloria',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 952 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Choruses from 'The Lark': Prelude

UPDATE pieces piece
SET piece.title = 'Choruses from ''The Lark'': Prelude', piece.title_en = 'Choruses from ''The Lark'': Prelude',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2789 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Choruses from 'The Lark': Requiem

UPDATE pieces piece
SET piece.title = 'Choruses from ''The Lark'': Requiem', piece.title_en = 'Choruses from ''The Lark'': Requiem',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2245 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Choruses from 'The Lark': Sanctus

UPDATE pieces piece
SET piece.title = 'Choruses from ''The Lark'': Sanctus', piece.title_en = 'Choruses from ''The Lark'': Sanctus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2659 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 클라리넷 소나타

UPDATE pieces piece
SET piece.title = '클라리넷 소나타', piece.title_en = 'Clarinet Sonata',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2842 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Grazioso', part.name_en = 'Clarinet Sonata: I. Grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2842 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:cbdee93b-1d52-39a7-9b0f-36223dfb4546' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbdee93b-1d52-39a7-9b0f-36223dfb4546', 1, 'I', 'Grazioso', 'Clarinet Sonata: I. Grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2842 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbdee93b-1d52-39a7-9b0f-36223dfb4546'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andantino', part.name_en = 'Clarinet Sonata: II. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2842 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:d2376d0c-4e2c-3cbb-a41a-525941e48fbe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2376d0c-4e2c-3cbb-a41a-525941e48fbe', 2, 'II', 'Andantino', 'Clarinet Sonata: II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2842 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2376d0c-4e2c-3cbb-a41a-525941e48fbe'
);


-- None 협주곡 "Jubilee Games"

UPDATE pieces piece
SET piece.title = '협주곡 "Jubilee Games"', piece.title_en = 'Concerto for Orchestra "Jubilee Games"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2580 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Free-Style Events: Allegro con brio, giocoso', part.name_en = 'Concerto for Orchestra "Jubilee Games": I. Free-Style Events: Allegro con brio, giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2580 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:632efc94-ee7d-4b94-a98e-5031b48996d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:632efc94-ee7d-4b94-a98e-5031b48996d7', 1, 'I', 'Free-Style Events: Allegro con brio, giocoso', 'Concerto for Orchestra "Jubilee Games": I. Free-Style Events: Allegro con brio, giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2580 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:632efc94-ee7d-4b94-a98e-5031b48996d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Mixed Doubles: Theme and Seven Variations', part.name_en = 'Concerto for Orchestra "Jubilee Games": II. Mixed Doubles: Theme and Seven Variations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2580 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:ebc84f77-18a1-4791-995a-47bfcac118af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebc84f77-18a1-4791-995a-47bfcac118af', 2, 'II', 'Mixed Doubles: Theme and Seven Variations', 'Concerto for Orchestra "Jubilee Games": II. Mixed Doubles: Theme and Seven Variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2580 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebc84f77-18a1-4791-995a-47bfcac118af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Diaspora Dances: Vivace', part.name_en = 'Concerto for Orchestra "Jubilee Games": III. Diaspora Dances: Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2580 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:6c804717-8b9c-4a1d-a3e5-c3049a49a989' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c804717-8b9c-4a1d-a3e5-c3049a49a989', 3, 'III', 'Diaspora Dances: Vivace', 'Concerto for Orchestra "Jubilee Games": III. Diaspora Dances: Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2580 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c804717-8b9c-4a1d-a3e5-c3049a49a989'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Benediction: Moderato, invocando', part.name_en = 'Concerto for Orchestra "Jubilee Games": IV. Benediction: Moderato, invocando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2580 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:e5156cea-1d06-4af3-9808-d2ebacf4cb51' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5156cea-1d06-4af3-9808-d2ebacf4cb51', 4, 'IV', 'Benediction: Moderato, invocando', 'Concerto for Orchestra "Jubilee Games": IV. Benediction: Moderato, invocando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2580 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5156cea-1d06-4af3-9808-d2ebacf4cb51'
);


-- None 발레 <Conch Town>

UPDATE pieces piece
SET piece.title = '발레 <Conch Town>', piece.title_en = 'Conch Town',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2773 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dance Suite

UPDATE pieces piece
SET piece.title = 'Dance Suite', piece.title_en = 'Dance Suite',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1327 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Dancisca for Antony', part.name_en = 'Dance Suite: I. Dancisca for Antony',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1327 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:2fa4aef2-f7ef-4e1c-918c-9dc0e4c7f013' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fa4aef2-f7ef-4e1c-918c-9dc0e4c7f013', 1, 'I', 'Dancisca for Antony', 'Dance Suite: I. Dancisca for Antony', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1327 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fa4aef2-f7ef-4e1c-918c-9dc0e4c7f013'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Waltz for Agnes', part.name_en = 'Dance Suite: II. Waltz for Agnes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1327 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:2b2a85c3-ec88-400d-a3bd-6df7c106efe5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b2a85c3-ec88-400d-a3bd-6df7c106efe5', 2, 'II', 'Waltz for Agnes', 'Dance Suite: II. Waltz for Agnes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1327 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b2a85c3-ec88-400d-a3bd-6df7c106efe5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Bi-Tango for Mischa', part.name_en = 'Dance Suite: III. Bi-Tango for Mischa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1327 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:c99478cd-20b0-4d02-bc7e-6e6aac9567f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c99478cd-20b0-4d02-bc7e-6e6aac9567f9', 3, 'III', 'Bi-Tango for Mischa', 'Dance Suite: III. Bi-Tango for Mischa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1327 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c99478cd-20b0-4d02-bc7e-6e6aac9567f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Two Step for Mr. B', part.name_en = 'Dance Suite: IV. Two Step for Mr. B',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1327 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:6d7985d5-5f38-495c-a819-5cd19ada2a21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d7985d5-5f38-495c-a819-5cd19ada2a21', 4, 'IV', 'Two Step for Mr. B', 'Dance Suite: IV. Two Step for Mr. B', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1327 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d7985d5-5f38-495c-a819-5cd19ada2a21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'MTV for Jerry', part.name_en = 'Dance Suite: V. MTV for Jerry',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1327 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:b5ff8134-41ec-4ff5-95ea-5d81cc4b8d6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5ff8134-41ec-4ff5-95ea-5d81cc4b8d6b', 5, 'V', 'MTV for Jerry', 'Dance Suite: V. MTV for Jerry', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1327 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5ff8134-41ec-4ff5-95ea-5d81cc4b8d6b'
);


-- None 관현악 디베르티멘토

UPDATE pieces piece
SET piece.title = '관현악 디베르티멘토', piece.title_en = 'Divertimento for Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1125 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sennets and Tuckets', part.name_en = 'Divertimento for Orchestra: I. Sennets and Tuckets',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1125 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:03f8f9fb-12cf-4535-9ad3-783ffe6c4a49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03f8f9fb-12cf-4535-9ad3-783ffe6c4a49', 1, 'I', 'Sennets and Tuckets', 'Divertimento for Orchestra: I. Sennets and Tuckets', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1125 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03f8f9fb-12cf-4535-9ad3-783ffe6c4a49'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Waltz', part.name_en = 'Divertimento for Orchestra: II. Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1125 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:b4300a2e-b805-40e9-8242-f09dde46375d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4300a2e-b805-40e9-8242-f09dde46375d', 2, 'II', 'Waltz', 'Divertimento for Orchestra: II. Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1125 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4300a2e-b805-40e9-8242-f09dde46375d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Mazurka', part.name_en = 'Divertimento for Orchestra: III. Mazurka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1125 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:e5b3ae98-726c-40ef-8240-16b22bc4a6bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5b3ae98-726c-40ef-8240-16b22bc4a6bd', 3, 'III', 'Mazurka', 'Divertimento for Orchestra: III. Mazurka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1125 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5b3ae98-726c-40ef-8240-16b22bc4a6bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Samba', part.name_en = 'Divertimento for Orchestra: IV. Samba',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1125 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:fad5ede0-23ab-4861-a341-4bc560a21bf2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fad5ede0-23ab-4861-a341-4bc560a21bf2', 4, 'IV', 'Samba', 'Divertimento for Orchestra: IV. Samba', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1125 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fad5ede0-23ab-4861-a341-4bc560a21bf2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Turkey Trot', part.name_en = 'Divertimento for Orchestra: V. Turkey Trot',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1125 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:4e0628c9-dd10-413f-87c4-c364948f65d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e0628c9-dd10-413f-87c4-c364948f65d6', 5, 'V', 'Turkey Trot', 'Divertimento for Orchestra: V. Turkey Trot', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1125 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e0628c9-dd10-413f-87c4-c364948f65d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Sphinxes', part.name_en = 'Divertimento for Orchestra: VI. Sphinxes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1125 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:debcedb1-f1b0-4c93-8652-83ec9179c69a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:debcedb1-f1b0-4c93-8652-83ec9179c69a', 6, 'VI', 'Sphinxes', 'Divertimento for Orchestra: VI. Sphinxes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1125 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:debcedb1-f1b0-4c93-8652-83ec9179c69a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Blues', part.name_en = 'Divertimento for Orchestra: VII. Blues',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1125 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:97e28bca-da27-4e0d-8b63-38045f882497' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97e28bca-da27-4e0d-8b63-38045f882497', 7, 'VII', 'Blues', 'Divertimento for Orchestra: VII. Blues', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1125 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97e28bca-da27-4e0d-8b63-38045f882497'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'March: The BSO Forever', part.name_en = 'Divertimento for Orchestra: VIII. March: The BSO Forever',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1125 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:2dda87b1-7e28-4f68-8e1b-e7f92c057423' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2dda87b1-7e28-4f68-8e1b-e7f92c057423', 8, 'VIII', 'March: The BSO Forever', 'Divertimento for Orchestra: VIII. March: The BSO Forever', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1125 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2dda87b1-7e28-4f68-8e1b-e7f92c057423'
);


-- None Dream With Me

UPDATE pieces piece
SET piece.title = 'Dream With Me', piece.title_en = 'Dream With Me',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1541 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 발레 <Dybbuk>

UPDATE pieces piece
SET piece.title = '발레 <Dybbuk>', piece.title_en = 'Dybbuk',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1720 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Part I: The Community', part.name_en = 'Dybbuk, Part I: The Community',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1720 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:aa9b33a6-6961-3e43-b013-db7dad87121a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa9b33a6-6961-3e43-b013-db7dad87121a', 1, NULL, 'Part I: The Community', 'Dybbuk, Part I: The Community', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1720 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa9b33a6-6961-3e43-b013-db7dad87121a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Part I: The Fathers', part.name_en = 'Dybbuk, Part I: The Fathers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1720 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:425e7d14-6140-3e7c-8634-84a4c4c59283' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:425e7d14-6140-3e7c-8634-84a4c4c59283', 2, NULL, 'Part I: The Fathers', 'Dybbuk, Part I: The Fathers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1720 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:425e7d14-6140-3e7c-8634-84a4c4c59283'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Part I: Witnesses of Birth', part.name_en = 'Dybbuk, Part I: Witnesses of Birth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1720 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:059daf17-5494-381f-ac7b-3494d990fd68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:059daf17-5494-381f-ac7b-3494d990fd68', 3, NULL, 'Part I: Witnesses of Birth', 'Dybbuk, Part I: Witnesses of Birth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1720 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:059daf17-5494-381f-ac7b-3494d990fd68'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Part I: The Children', part.name_en = 'Dybbuk, Part I: The Children',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1720 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:2d76c379-92ed-31f6-89fb-5133dcf4571d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d76c379-92ed-31f6-89fb-5133dcf4571d', 4, NULL, 'Part I: The Children', 'Dybbuk, Part I: The Children', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1720 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d76c379-92ed-31f6-89fb-5133dcf4571d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Part II: Kabbalah: Six Variations', part.name_en = 'Dybbuk, Part II: Kabbalah: Six Variations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1720 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:b31beea4-fa53-35a3-a4da-87aae6a6c590' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b31beea4-fa53-35a3-a4da-87aae6a6c590', 5, NULL, 'Part II: Kabbalah: Six Variations', 'Dybbuk, Part II: Kabbalah: Six Variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1720 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b31beea4-fa53-35a3-a4da-87aae6a6c590'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Part III: Witnesses of Death', part.name_en = 'Dybbuk, Part III: Witnesses of Death',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1720 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:feee0db3-356c-3a68-8f71-144cb458999b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:feee0db3-356c-3a68-8f71-144cb458999b', 6, NULL, 'Part III: Witnesses of Death', 'Dybbuk, Part III: Witnesses of Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1720 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:feee0db3-356c-3a68-8f71-144cb458999b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Part III: Leah', part.name_en = 'Dybbuk, Part III: Leah',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1720 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:fa64f91f-2467-3f6b-abe5-885b3607940a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa64f91f-2467-3f6b-abe5-885b3607940a', 7, NULL, 'Part III: Leah', 'Dybbuk, Part III: Leah', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1720 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa64f91f-2467-3f6b-abe5-885b3607940a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Part III: Possession', part.name_en = 'Dybbuk, Part III: Possession',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1720 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:b4158212-483a-3057-b9d9-101a31b1238d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4158212-483a-3057-b9d9-101a31b1238d', 8, NULL, 'Part III: Possession', 'Dybbuk, Part III: Possession', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1720 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4158212-483a-3057-b9d9-101a31b1238d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Part III: Exorcism', part.name_en = 'Dybbuk, Part III: Exorcism',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1720 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:1aae1635-81d1-38f4-b26a-750280a68ea2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1aae1635-81d1-38f4-b26a-750280a68ea2', 9, NULL, 'Part III: Exorcism', 'Dybbuk, Part III: Exorcism', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1720 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1aae1635-81d1-38f4-b26a-750280a68ea2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Part III: The Community', part.name_en = 'Dybbuk, Part III: The Community',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1720 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:77158d08-f6a8-3e4b-9d55-a61063c3a89f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77158d08-f6a8-3e4b-9d55-a61063c3a89f', 10, NULL, 'Part III: The Community', 'Dybbuk, Part III: The Community', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1720 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77158d08-f6a8-3e4b-9d55-a61063c3a89f'
);


-- None Elegy for Mippy I

UPDATE pieces piece
SET piece.title = 'Elegy for Mippy I', piece.title_en = 'Elegy for Mippy I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2238 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Facsimile: Choreographic Essay for Orchestra

UPDATE pieces piece
SET piece.title = 'Facsimile: Choreographic Essay for Orchestra', piece.title_en = 'Facsimile: Choreographic Essay for Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2583 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Molto adagio - Più andante - Moderate waltz tempo - Sostenuto assai - Accelerando - A tempo', part.name_en = 'Facsimile, Part I: Molto adagio - Più andante - Moderate waltz tempo - Sostenuto assai - Accelerando - A tempo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2583 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:54a53e85-a86c-3438-a515-681ef43727a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54a53e85-a86c-3438-a515-681ef43727a3', 1, NULL, 'Molto adagio - Più andante - Moderate waltz tempo - Sostenuto assai - Accelerando - A tempo', 'Facsimile, Part I: Molto adagio - Più andante - Moderate waltz tempo - Sostenuto assai - Accelerando - A tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2583 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54a53e85-a86c-3438-a515-681ef43727a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegretto - Subito allegro - Più mosso - Andante - Meno mosso - Rallentando - Adagio - Molto rallentando - Adagio, come prima', part.name_en = 'Facsimile, Part II: Allegretto - Subito allegro - Più mosso - Andante - Meno mosso - Rallentando - Adagio - Molto rallentando - Adagio, come prima',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2583 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:12dfa1be-fe50-3a57-80d4-cce55ca878c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12dfa1be-fe50-3a57-80d4-cce55ca878c8', 2, NULL, 'Allegretto - Subito allegro - Più mosso - Andante - Meno mosso - Rallentando - Adagio - Molto rallentando - Adagio, come prima', 'Facsimile, Part II: Allegretto - Subito allegro - Più mosso - Andante - Meno mosso - Rallentando - Adagio - Molto rallentando - Adagio, come prima', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2583 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12dfa1be-fe50-3a57-80d4-cce55ca878c8'
);


-- None 발레 <Fancy Free>

UPDATE pieces piece
SET piece.title = '발레 <Fancy Free>', piece.title_en = 'Fancy Free',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1006 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Big Stuff', part.name_en = 'Fancy Free: Big Stuff',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1006 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:e9350eda-088a-37ac-9415-117cb7716f19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9350eda-088a-37ac-9415-117cb7716f19', 1, NULL, 'Big Stuff', 'Fancy Free: Big Stuff', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1006 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9350eda-088a-37ac-9415-117cb7716f19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Enter Three Sailors', part.name_en = 'Fancy Free: I. Enter Three Sailors',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1006 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:079f5386-9c76-3a4a-a8c9-1cb58fd27813' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:079f5386-9c76-3a4a-a8c9-1cb58fd27813', 2, NULL, 'Enter Three Sailors', 'Fancy Free: I. Enter Three Sailors', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1006 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:079f5386-9c76-3a4a-a8c9-1cb58fd27813'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene at the Bar', part.name_en = 'Fancy Free: II. Scene at the Bar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1006 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:924dcad6-5d01-3a25-9a76-d194a113bdf5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:924dcad6-5d01-3a25-9a76-d194a113bdf5', 3, NULL, 'Scene at the Bar', 'Fancy Free: II. Scene at the Bar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1006 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:924dcad6-5d01-3a25-9a76-d194a113bdf5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Enter Two Girls', part.name_en = 'Fancy Free: III. Enter Two Girls',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1006 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:b0d41de6-9100-3bac-a4d3-ddeaca3bf488' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0d41de6-9100-3bac-a4d3-ddeaca3bf488', 4, NULL, 'Enter Two Girls', 'Fancy Free: III. Enter Two Girls', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1006 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0d41de6-9100-3bac-a4d3-ddeaca3bf488'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Competition Scene', part.name_en = 'Fancy Free: V. Competition Scene',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1006 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:bedb4932-a808-349e-b494-c5373449b42c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bedb4932-a808-349e-b494-c5373449b42c', 5, NULL, 'Competition Scene', 'Fancy Free: V. Competition Scene', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1006 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bedb4932-a808-349e-b494-c5373449b42c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Three Dance Variations: Variation I: Galop', part.name_en = 'Fancy Free: VI. Three Dance Variations: Variation I: Galop',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1006 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:c7277670-e7b8-38a8-955b-ac2bad7c6104' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7277670-e7b8-38a8-955b-ac2bad7c6104', 6, NULL, 'Three Dance Variations: Variation I: Galop', 'Fancy Free: VI. Three Dance Variations: Variation I: Galop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1006 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7277670-e7b8-38a8-955b-ac2bad7c6104'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Three Dance Variations: Variation II: Waltz', part.name_en = 'Fancy Free: VI. Three Dance Variations: Variation II: Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1006 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:1cfc5ac1-6692-3d8f-86bf-9382725d821a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cfc5ac1-6692-3d8f-86bf-9382725d821a', 7, NULL, 'Three Dance Variations: Variation II: Waltz', 'Fancy Free: VI. Three Dance Variations: Variation II: Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1006 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cfc5ac1-6692-3d8f-86bf-9382725d821a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Three Dance Variations: Variation III: Danzon', part.name_en = 'Fancy Free: VI. Three Dance Variations: Variation III: Danzon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1006 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:fa03b0dd-a490-3c93-ae6b-ac655d4b30e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa03b0dd-a490-3c93-ae6b-ac655d4b30e1', 8, NULL, 'Three Dance Variations: Variation III: Danzon', 'Fancy Free: VI. Three Dance Variations: Variation III: Danzon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1006 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa03b0dd-a490-3c93-ae6b-ac655d4b30e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Finale', part.name_en = 'Fancy Free: VII. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1006 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:37522ea0-b267-37cc-a9c7-8d7110372b17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37522ea0-b267-37cc-a9c7-8d7110372b17', 9, NULL, 'Finale', 'Fancy Free: VII. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1006 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37522ea0-b267-37cc-a9c7-8d7110372b17'
);


-- None Four Sabras

UPDATE pieces piece
SET piece.title = 'Four Sabras', piece.title_en = 'Four Sabras',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1747 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'II',
    part.name_ko = 'Idele, the Chassidele', part.name_en = 'Four Sabras: II. Idele, the Chassidele',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1747 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:4b32d985-1b65-4cfc-9078-adba7458622d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b32d985-1b65-4cfc-9078-adba7458622d', 1, 'II', 'Idele, the Chassidele', 'Four Sabras: II. Idele, the Chassidele', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1747 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b32d985-1b65-4cfc-9078-adba7458622d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'IV',
    part.name_ko = 'Dina, the Tomboy Who Weeps Alone', part.name_en = 'Four Sabras: IV. Dina, the Tomboy Who Weeps Alone',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1747 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:8346a664-efb3-4b4d-a99b-1ca2fba24d60' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8346a664-efb3-4b4d-a99b-1ca2fba24d60', 2, 'IV', 'Dina, the Tomboy Who Weeps Alone', 'Four Sabras: IV. Dina, the Tomboy Who Weeps Alone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1747 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8346a664-efb3-4b4d-a99b-1ca2fba24d60'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Yosi, the Jokester', part.name_en = 'Four Sabras: III. Yosi, the Jokester',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1747 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:8b847824-babd-4356-979d-bb64bfd9ede9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b847824-babd-4356-979d-bb64bfd9ede9', 3, 'III', 'Yosi, the Jokester', 'Four Sabras: III. Yosi, the Jokester', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1747 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b847824-babd-4356-979d-bb64bfd9ede9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'I',
    part.name_ko = 'Ilana, the Dreamer', part.name_en = 'Four Sabras: I. Ilana, the Dreamer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1747 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:e6c881f1-4bbc-432b-adf8-7721407c1e41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6c881f1-4bbc-432b-adf8-7721407c1e41', 4, 'I', 'Ilana, the Dreamer', 'Four Sabras: I. Ilana, the Dreamer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1747 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6c881f1-4bbc-432b-adf8-7721407c1e41'
);


-- None Halil

UPDATE pieces piece
SET piece.title = 'Halil', piece.title_en = 'Halil',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 870 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hashkiveinu

UPDATE pieces piece
SET piece.title = 'Hashkiveinu', piece.title_en = 'Hashkiveinu',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1057 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <I Hate Music: Five Kid Songs for Soprano and Piano>

UPDATE pieces piece
SET piece.title = '연가곡집 <I Hate Music: Five Kid Songs for Soprano and Piano>', piece.title_en = 'I Hate Music: Five Kid Songs for Soprano and Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1375 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'My Name Is Barbara', part.name_en = 'I Hate Music: Five Kid Songs for Soprano and Piano: I. My Name Is Barbara',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1375 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:b9a1a040-5c51-3767-b56a-380a96d390ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9a1a040-5c51-3767-b56a-380a96d390ec', 1, NULL, 'My Name Is Barbara', 'I Hate Music: Five Kid Songs for Soprano and Piano: I. My Name Is Barbara', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1375 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9a1a040-5c51-3767-b56a-380a96d390ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Jupiter Has Seven Moons', part.name_en = 'I Hate Music: Five Kid Songs for Soprano and Piano: II. Jupiter Has Seven Moons',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1375 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:17b28161-b39c-3dda-b528-322c7b1783b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17b28161-b39c-3dda-b528-322c7b1783b8', 2, NULL, 'Jupiter Has Seven Moons', 'I Hate Music: Five Kid Songs for Soprano and Piano: II. Jupiter Has Seven Moons', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1375 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17b28161-b39c-3dda-b528-322c7b1783b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'I Hate Music!', part.name_en = 'I Hate Music: Five Kid Songs for Soprano and Piano: III. I Hate Music!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1375 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:873d57ca-e89f-385a-9422-1115fcb94d90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:873d57ca-e89f-385a-9422-1115fcb94d90', 3, NULL, 'I Hate Music!', 'I Hate Music: Five Kid Songs for Soprano and Piano: III. I Hate Music!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1375 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:873d57ca-e89f-385a-9422-1115fcb94d90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'A Big Indian and a Little Indian', part.name_en = 'I Hate Music: Five Kid Songs for Soprano and Piano: IV. A Big Indian and a Little Indian',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1375 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:f785a3f8-3887-3652-90ef-26a1e37560f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f785a3f8-3887-3652-90ef-26a1e37560f0', 4, NULL, 'A Big Indian and a Little Indian', 'I Hate Music: Five Kid Songs for Soprano and Piano: IV. A Big Indian and a Little Indian', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1375 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f785a3f8-3887-3652-90ef-26a1e37560f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'I’m a Person, Too', part.name_en = 'I Hate Music: Five Kid Songs for Soprano and Piano: V. I’m a Person, Too',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1375 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:863c2d91-50ff-3397-aa38-f6ce42ee7c29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:863c2d91-50ff-3397-aa38-f6ce42ee7c29', 5, NULL, 'I’m a Person, Too', 'I Hate Music: Five Kid Songs for Soprano and Piano: V. I’m a Person, Too', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1375 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:863c2d91-50ff-3397-aa38-f6ce42ee7c29'
);


-- None In Our Time

UPDATE pieces piece
SET piece.title = 'In Our Time', piece.title_en = 'In Our Time',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2908 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mass: A Theatre Piece for Singers, Players, and Dancers

UPDATE pieces piece
SET piece.title = 'Mass: A Theatre Piece for Singers, Players, and Dancers', piece.title_en = 'Mass: A Theatre Piece for Singers, Players, and Dancers',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1679 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Devotions before Mass, No. 1. Antiphon: Kyrie eleison', part.name_en = 'Mass: I. Devotions before Mass, No. 1. Antiphon: Kyrie eleison',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:ce2fba20-dac5-3b6e-90ff-bbb0b79c84e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce2fba20-dac5-3b6e-90ff-bbb0b79c84e0', 1, 'I', 'Devotions before Mass, No. 1. Antiphon: Kyrie eleison', 'Mass: I. Devotions before Mass, No. 1. Antiphon: Kyrie eleison', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce2fba20-dac5-3b6e-90ff-bbb0b79c84e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'I',
    part.name_ko = 'Devotions before Mass, No. 2. Hymn and Psalm: “A Simple Song”', part.name_en = 'Mass: I. Devotions before Mass, No. 2. Hymn and Psalm: “A Simple Song”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:671f0b3c-0915-3e19-8a0a-6c520defc99b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:671f0b3c-0915-3e19-8a0a-6c520defc99b', 2, 'I', 'Devotions before Mass, No. 2. Hymn and Psalm: “A Simple Song”', 'Mass: I. Devotions before Mass, No. 2. Hymn and Psalm: “A Simple Song”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:671f0b3c-0915-3e19-8a0a-6c520defc99b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'I',
    part.name_ko = 'Devotions before Mass, No. 3. Responsory: Alleluia', part.name_en = 'Mass: I. Devotions before Mass, No. 3. Responsory: Alleluia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:05301b30-9855-3146-8e94-0191e4493141' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05301b30-9855-3146-8e94-0191e4493141', 3, 'I', 'Devotions before Mass, No. 3. Responsory: Alleluia', 'Mass: I. Devotions before Mass, No. 3. Responsory: Alleluia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05301b30-9855-3146-8e94-0191e4493141'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'II',
    part.name_ko = 'First Introit (Rondo), No. 1. Prefatory Prayers', part.name_en = 'Mass: II. First Introit (Rondo), No. 1. Prefatory Prayers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:bd701208-590d-341e-93ce-57ab572ca429' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd701208-590d-341e-93ce-57ab572ca429', 4, 'II', 'First Introit (Rondo), No. 1. Prefatory Prayers', 'Mass: II. First Introit (Rondo), No. 1. Prefatory Prayers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd701208-590d-341e-93ce-57ab572ca429'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'II',
    part.name_ko = 'First Introit (Rondo), No. 2. Thrice-Triple Canon: Dominus vobiscum', part.name_en = 'Mass: II. First Introit (Rondo), No. 2. Thrice-Triple Canon: Dominus vobiscum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:c7003776-69b4-3f8a-a534-ef6871ce6a34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7003776-69b4-3f8a-a534-ef6871ce6a34', 5, 'II', 'First Introit (Rondo), No. 2. Thrice-Triple Canon: Dominus vobiscum', 'Mass: II. First Introit (Rondo), No. 2. Thrice-Triple Canon: Dominus vobiscum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7003776-69b4-3f8a-a534-ef6871ce6a34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'III',
    part.name_ko = 'Second Introit, No. 1. In nomine Patris', part.name_en = 'Mass: III. Second Introit, No. 1. In nomine Patris',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:e8c24137-8b29-31e4-b6b6-4677d9df5b9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8c24137-8b29-31e4-b6b6-4677d9df5b9b', 6, 'III', 'Second Introit, No. 1. In nomine Patris', 'Mass: III. Second Introit, No. 1. In nomine Patris', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8c24137-8b29-31e4-b6b6-4677d9df5b9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'III',
    part.name_ko = 'Second Introit, No. 2. Prayer for the Congregation (Chorale: "Almighty Father")', part.name_en = 'Mass: III. Second Introit, No. 2. Prayer for the Congregation (Chorale: "Almighty Father")',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:a9734c34-a7ab-3e36-bfca-46aab0d872ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9734c34-a7ab-3e36-bfca-46aab0d872ae', 7, 'III', 'Second Introit, No. 2. Prayer for the Congregation (Chorale: "Almighty Father")', 'Mass: III. Second Introit, No. 2. Prayer for the Congregation (Chorale: "Almighty Father")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9734c34-a7ab-3e36-bfca-46aab0d872ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'III',
    part.name_ko = 'Second Introit, No. 3. Epiphany', part.name_en = 'Mass: III. Second Introit, No. 3. Epiphany',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:05c1f33f-d858-38bb-a6e5-fb4cb2e94ed8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05c1f33f-d858-38bb-a6e5-fb4cb2e94ed8', 8, 'III', 'Second Introit, No. 3. Epiphany', 'Mass: III. Second Introit, No. 3. Epiphany', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05c1f33f-d858-38bb-a6e5-fb4cb2e94ed8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IV',
    part.name_ko = 'Confession, No. 1. Confiteor', part.name_en = 'Mass: IV. Confession, No. 1. Confiteor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:9e5e4659-4722-3e44-8ea4-63909172fc9e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e5e4659-4722-3e44-8ea4-63909172fc9e', 9, 'IV', 'Confession, No. 1. Confiteor', 'Mass: IV. Confession, No. 1. Confiteor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e5e4659-4722-3e44-8ea4-63909172fc9e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'IV',
    part.name_ko = 'Confession, No. 2. Trope: "I Don''t Know"', part.name_en = 'Mass: IV. Confession, No. 2. Trope: "I Don''t Know"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:2129ca2e-7a1f-33f1-89f9-99244724c4a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2129ca2e-7a1f-33f1-89f9-99244724c4a6', 10, 'IV', 'Confession, No. 2. Trope: "I Don''t Know"', 'Mass: IV. Confession, No. 2. Trope: "I Don''t Know"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2129ca2e-7a1f-33f1-89f9-99244724c4a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'IV',
    part.name_ko = 'Confession, No. 3. Trope: "Easy"', part.name_en = 'Mass: IV. Confession, No. 3. Trope: "Easy"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:4d7b0a26-2243-3497-955d-a5df00cd2188' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d7b0a26-2243-3497-955d-a5df00cd2188', 11, 'IV', 'Confession, No. 3. Trope: "Easy"', 'Mass: IV. Confession, No. 3. Trope: "Easy"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d7b0a26-2243-3497-955d-a5df00cd2188'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'V',
    part.name_ko = 'Meditation No. 1', part.name_en = 'Mass: V. Meditation No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:df7cf15c-5775-3737-8fea-2e551b5335de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df7cf15c-5775-3737-8fea-2e551b5335de', 12, 'V', 'Meditation No. 1', 'Mass: V. Meditation No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df7cf15c-5775-3737-8fea-2e551b5335de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'VI',
    part.name_ko = 'Gloria, No. 1. Gloria Tibi', part.name_en = 'Mass: VI. Gloria, No. 1. Gloria Tibi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:303a35be-bcf4-3373-8075-67f330f65454' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:303a35be-bcf4-3373-8075-67f330f65454', 13, 'VI', 'Gloria, No. 1. Gloria Tibi', 'Mass: VI. Gloria, No. 1. Gloria Tibi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:303a35be-bcf4-3373-8075-67f330f65454'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = 'VI',
    part.name_ko = 'Gloria, No. 2. Gloria in excelsis', part.name_en = 'Mass: VI. Gloria, No. 2. Gloria in excelsis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:80714569-a924-3664-a63c-e42a22324268' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80714569-a924-3664-a63c-e42a22324268', 14, 'VI', 'Gloria, No. 2. Gloria in excelsis', 'Mass: VI. Gloria, No. 2. Gloria in excelsis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80714569-a924-3664-a63c-e42a22324268'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = 'VI',
    part.name_ko = 'Gloria, No. 3. Trope: "Half of the People"', part.name_en = 'Mass: VI. Gloria, No. 3. Trope: "Half of the People"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:6a9e2311-0946-328a-b44c-0e1a28830589' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a9e2311-0946-328a-b44c-0e1a28830589', 15, 'VI', 'Gloria, No. 3. Trope: "Half of the People"', 'Mass: VI. Gloria, No. 3. Trope: "Half of the People"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a9e2311-0946-328a-b44c-0e1a28830589'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = 'VI',
    part.name_ko = 'Gloria, No. 4. Trope: "Thank You"', part.name_en = 'Mass: VI. Gloria, No. 4. Trope: "Thank You"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:6568dad9-7e42-3360-a8af-987e7ae3854f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6568dad9-7e42-3360-a8af-987e7ae3854f', 16, 'VI', 'Gloria, No. 4. Trope: "Thank You"', 'Mass: VI. Gloria, No. 4. Trope: "Thank You"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6568dad9-7e42-3360-a8af-987e7ae3854f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = 'VII',
    part.name_ko = 'Meditation No. 2', part.name_en = 'Mass: VII. Meditation No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:160c4059-3557-310e-9da5-4fb7df335945' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:160c4059-3557-310e-9da5-4fb7df335945', 17, 'VII', 'Meditation No. 2', 'Mass: VII. Meditation No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:160c4059-3557-310e-9da5-4fb7df335945'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = 'VIII',
    part.name_ko = 'Epistle: "The Word of the Lord"', part.name_en = 'Mass: VIII. Epistle: "The Word of the Lord"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:056f9bc5-261e-3c8e-9796-7ec8ecb69101' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:056f9bc5-261e-3c8e-9796-7ec8ecb69101', 18, 'VIII', 'Epistle: "The Word of the Lord"', 'Mass: VIII. Epistle: "The Word of the Lord"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:056f9bc5-261e-3c8e-9796-7ec8ecb69101'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = 'IX',
    part.name_ko = 'Gospel-Sermon: "God Said"', part.name_en = 'Mass: IX. Gospel-Sermon: "God Said"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:55a8359a-a6b5-3d53-bf35-3953e8878944' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55a8359a-a6b5-3d53-bf35-3953e8878944', 19, 'IX', 'Gospel-Sermon: "God Said"', 'Mass: IX. Gospel-Sermon: "God Said"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55a8359a-a6b5-3d53-bf35-3953e8878944'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = 'X',
    part.name_ko = 'Credo, No. 1. Credo in unum Deum', part.name_en = 'Mass: X. Credo, No. 1. Credo in unum Deum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:7696c55f-408f-37f1-8465-7036806ad299' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7696c55f-408f-37f1-8465-7036806ad299', 20, 'X', 'Credo, No. 1. Credo in unum Deum', 'Mass: X. Credo, No. 1. Credo in unum Deum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7696c55f-408f-37f1-8465-7036806ad299'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = 'X',
    part.name_ko = 'Credo, No. 2. Trope: Non Credo', part.name_en = 'Mass: X. Credo, No. 2. Trope: Non Credo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:8effd06c-0434-3ce0-a32a-0ec3cf3c52e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8effd06c-0434-3ce0-a32a-0ec3cf3c52e2', 21, 'X', 'Credo, No. 2. Trope: Non Credo', 'Mass: X. Credo, No. 2. Trope: Non Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8effd06c-0434-3ce0-a32a-0ec3cf3c52e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = 'X',
    part.name_ko = 'Credo, No. 3. Trope: "Hurry"', part.name_en = 'Mass: X. Credo, No. 3. Trope: "Hurry"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:898096c3-f578-3fc2-829a-98c3e6fbf836' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:898096c3-f578-3fc2-829a-98c3e6fbf836', 22, 'X', 'Credo, No. 3. Trope: "Hurry"', 'Mass: X. Credo, No. 3. Trope: "Hurry"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:898096c3-f578-3fc2-829a-98c3e6fbf836'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = 'X',
    part.name_ko = 'Credo, No. 4. Trope: "World Without End"', part.name_en = 'Mass: X. Credo, No. 4. Trope: "World Without End"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:56635f96-5b2e-34ab-9dd6-d22e0d67dabc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56635f96-5b2e-34ab-9dd6-d22e0d67dabc', 23, 'X', 'Credo, No. 4. Trope: "World Without End"', 'Mass: X. Credo, No. 4. Trope: "World Without End"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56635f96-5b2e-34ab-9dd6-d22e0d67dabc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = 'X',
    part.name_ko = 'Credo, No. 5. Trope: "I Believe in God"', part.name_en = 'Mass: X. Credo, No. 5. Trope: "I Believe in God"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:e497bd2b-fb9c-3d24-a233-912ba99ed8a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e497bd2b-fb9c-3d24-a233-912ba99ed8a0', 24, 'X', 'Credo, No. 5. Trope: "I Believe in God"', 'Mass: X. Credo, No. 5. Trope: "I Believe in God"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e497bd2b-fb9c-3d24-a233-912ba99ed8a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = 'XI',
    part.name_ko = 'Meditation No. 3 (De profundis, Part 1)', part.name_en = 'Mass: XI. Meditation No. 3 (De profundis, Part 1)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:9781d1c8-be41-380f-b99b-e04f7af57b86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9781d1c8-be41-380f-b99b-e04f7af57b86', 25, 'XI', 'Meditation No. 3 (De profundis, Part 1)', 'Mass: XI. Meditation No. 3 (De profundis, Part 1)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9781d1c8-be41-380f-b99b-e04f7af57b86'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = 'XII',
    part.name_ko = 'Offertory (De profundis, Part 2)', part.name_en = 'Mass: XII. Offertory (De profundis, Part 2)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:a139d86e-ecab-3c74-af9d-ec4bd98827e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a139d86e-ecab-3c74-af9d-ec4bd98827e2', 26, 'XII', 'Offertory (De profundis, Part 2)', 'Mass: XII. Offertory (De profundis, Part 2)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a139d86e-ecab-3c74-af9d-ec4bd98827e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = 'XIII',
    part.name_ko = 'The Lord''s Prayer, No. 1. Our Father', part.name_en = 'Mass: XIII. The Lord''s Prayer, No. 1. Our Father ...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:edb65368-a7eb-3ba6-92e7-90d87deb095f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edb65368-a7eb-3ba6-92e7-90d87deb095f', 27, 'XIII', 'The Lord''s Prayer, No. 1. Our Father', 'Mass: XIII. The Lord''s Prayer, No. 1. Our Father ...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edb65368-a7eb-3ba6-92e7-90d87deb095f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = 'XIII',
    part.name_ko = 'The Lord''s Prayer, No. 2. Trope: "I Go On"', part.name_en = 'Mass: XIII. The Lord''s Prayer, No. 2. Trope: "I Go On"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:7e2a63cb-6676-3b0f-a628-5c34fe84ef7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e2a63cb-6676-3b0f-a628-5c34fe84ef7b', 28, 'XIII', 'The Lord''s Prayer, No. 2. Trope: "I Go On"', 'Mass: XIII. The Lord''s Prayer, No. 2. Trope: "I Go On"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e2a63cb-6676-3b0f-a628-5c34fe84ef7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = 'XIV',
    part.name_ko = 'Sanctus', part.name_en = 'Mass: XIV. Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:600eb1fe-7f7a-3783-9be5-ae62c9230f60' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:600eb1fe-7f7a-3783-9be5-ae62c9230f60', 29, 'XIV', 'Sanctus', 'Mass: XIV. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:600eb1fe-7f7a-3783-9be5-ae62c9230f60'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = 'XV',
    part.name_ko = 'Agnus Dei', part.name_en = 'Mass: XV. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:9c5c194c-f783-31bf-af27-4291fade9554' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c5c194c-f783-31bf-af27-4291fade9554', 30, 'XV', 'Agnus Dei', 'Mass: XV. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c5c194c-f783-31bf-af27-4291fade9554'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = 'XVI',
    part.name_ko = 'Fraction: "Things Get Broken"', part.name_en = 'Mass: XVI. Fraction: "Things Get Broken"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:41343492-eb57-313f-b4a1-1c35f83f27ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41343492-eb57-313f-b4a1-1c35f83f27ab', 31, 'XVI', 'Fraction: "Things Get Broken"', 'Mass: XVI. Fraction: "Things Get Broken"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41343492-eb57-313f-b4a1-1c35f83f27ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = 'XVII',
    part.name_ko = 'Pax: Communion ("Secret Songs")', part.name_en = 'Mass: XVII. Pax: Communion ("Secret Songs")',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1679 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:fa067717-522b-3ff8-a244-a5d0de44b7dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa067717-522b-3ff8-a244-a5d0de44b7dc', 32, 'XVII', 'Pax: Communion ("Secret Songs")', 'Mass: XVII. Pax: Communion ("Secret Songs")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1679 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa067717-522b-3ff8-a244-a5d0de44b7dc'
);


-- None Missa Brevis

UPDATE pieces piece
SET piece.title = 'Missa Brevis', piece.title_en = 'Missa Brevis',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2830 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Kyrie. Adagio', part.name_en = 'Missa Brevis: I. Kyrie. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2830 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:a4df50bc-46e9-4899-9501-3ee1a06c0e35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4df50bc-46e9-4899-9501-3ee1a06c0e35', 1, NULL, 'Kyrie. Adagio', 'Missa Brevis: I. Kyrie. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2830 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4df50bc-46e9-4899-9501-3ee1a06c0e35'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Gloria. Grave', part.name_en = 'Missa Brevis: II. Gloria. Grave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2830 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:5ec60969-f1bf-460d-864f-1ab39608231b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ec60969-f1bf-460d-864f-1ab39608231b', 2, NULL, 'Gloria. Grave', 'Missa Brevis: II. Gloria. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2830 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ec60969-f1bf-460d-864f-1ab39608231b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sanctus. Allegro molto', part.name_en = 'Missa Brevis: III. Sanctus. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2830 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:c42b9486-6034-4546-a2ce-46e671ab9a79' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c42b9486-6034-4546-a2ce-46e671ab9a79', 3, NULL, 'Sanctus. Allegro molto', 'Missa Brevis: III. Sanctus. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2830 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c42b9486-6034-4546-a2ce-46e671ab9a79'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IIIa. Benedictus', part.name_en = 'Missa Brevis: IIIa. Benedictus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2830 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:d892e2c6-6c25-42c7-a385-e0b15e1f2126' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d892e2c6-6c25-42c7-a385-e0b15e1f2126', 4, NULL, 'IIIa. Benedictus', 'Missa Brevis: IIIa. Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2830 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d892e2c6-6c25-42c7-a385-e0b15e1f2126'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Agnus Dei', part.name_en = 'Missa Brevis: IV. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2830 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:739d57ba-29fb-4a7a-98ea-19e2d4e4c33e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:739d57ba-29fb-4a7a-98ea-19e2d4e4c33e', 5, NULL, 'Agnus Dei', 'Missa Brevis: IV. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2830 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:739d57ba-29fb-4a7a-98ea-19e2d4e4c33e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'IVa. Dona nobis pacem', part.name_en = 'Missa Brevis: IVa. Dona nobis pacem',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2830 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:e339e606-b6ee-456f-8c65-cd481759849d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e339e606-b6ee-456f-8c65-cd481759849d', 6, NULL, 'IVa. Dona nobis pacem', 'Missa Brevis: IVa. Dona nobis pacem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2830 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e339e606-b6ee-456f-8c65-cd481759849d'
);


-- None Moby Dyptich

UPDATE pieces piece
SET piece.title = 'Moby Dyptich', piece.title_en = 'Moby Dyptich',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2248 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Mundania>

UPDATE pieces piece
SET piece.title = '가곡 <Mundania>', piece.title_en = 'Mundania',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2322 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music for the Dance no. 2

UPDATE pieces piece
SET piece.title = 'Music for the Dance no. 2', piece.title_en = 'Music for the Dance no. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2545 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'II',
    part.name_ko = 'Waltz Time', part.name_en = 'Music for the Dance No. 2: II. Waltz Time',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2545 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:15733500-d34c-4da4-9421-b54456970bb8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15733500-d34c-4da4-9421-b54456970bb8', 1, 'II', 'Waltz Time', 'Music for the Dance No. 2: II. Waltz Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2545 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15733500-d34c-4da4-9421-b54456970bb8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'Music for the Dance No. 2: I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2545 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:6e021369-e994-4282-bca6-eef541fbe46c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e021369-e994-4282-bca6-eef541fbe46c', 2, 'I', 'Moderato', 'Music for the Dance No. 2: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2545 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e021369-e994-4282-bca6-eef541fbe46c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro non troppo, with Force', part.name_en = 'Music for the Dance No. 2: III. Allegro non troppo, with Force',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2545 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:b6ff1996-ff96-4e35-9ae5-e765d29c9e58' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6ff1996-ff96-4e35-9ae5-e765d29c9e58', 3, 'III', 'Allegro non troppo, with Force', 'Music for the Dance No. 2: III. Allegro non troppo, with Force', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2545 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6ff1996-ff96-4e35-9ae5-e765d29c9e58'
);


-- None 가곡 <My New Friends>

UPDATE pieces piece
SET piece.title = '가곡 <My New Friends>', piece.title_en = 'My New Friends',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1665 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Non troppo presto

UPDATE pieces piece
SET piece.title = 'Non troppo presto', piece.title_en = 'Non troppo presto',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1824 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Olympic Hymn

UPDATE pieces piece
SET piece.title = 'Olympic Hymn', piece.title_en = 'Olympic Hymn',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 817 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 뮤지컬 <On the Town>

UPDATE pieces piece
SET piece.title = '뮤지컬 <On the Town>', piece.title_en = 'On the Town',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2391 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'On the Town: Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:15eaa82a-eb08-342e-aff9-399364c12827' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15eaa82a-eb08-342e-aff9-399364c12827', 1, NULL, 'Overture', 'On the Town: Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15eaa82a-eb08-342e-aff9-399364c12827'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'I Feel Like I''m Not Out of Bed Yet', part.name_en = 'On the Town: I Feel Like I''m Not Out of Bed Yet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:ab55b484-e3f8-4d53-9803-64b42e388252' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab55b484-e3f8-4d53-9803-64b42e388252', 2, NULL, 'I Feel Like I''m Not Out of Bed Yet', 'On the Town: I Feel Like I''m Not Out of Bed Yet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab55b484-e3f8-4d53-9803-64b42e388252'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'New York, New York', part.name_en = 'On the Town: New York, New York',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:e2b5162b-34d5-3be8-b910-a5cc28daeaf1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2b5162b-34d5-3be8-b910-a5cc28daeaf1', 3, NULL, 'New York, New York', 'On the Town: New York, New York', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2b5162b-34d5-3be8-b910-a5cc28daeaf1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Miss Turnstiles'' Variations', part.name_en = 'On the Town: Miss Turnstiles'' Variations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:4010b484-694e-312e-abc6-f22d52a54e48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4010b484-694e-312e-abc6-f22d52a54e48', 4, NULL, 'Miss Turnstiles'' Variations', 'On the Town: Miss Turnstiles'' Variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4010b484-694e-312e-abc6-f22d52a54e48'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Gabey''s Comin'', Pickup Song', part.name_en = 'On the Town: Gabey''s Comin'', Pickup Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:6f8136f2-410a-4304-98c1-f94d72c9f9b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f8136f2-410a-4304-98c1-f94d72c9f9b5', 5, NULL, 'Gabey''s Comin'', Pickup Song', 'On the Town: Gabey''s Comin'', Pickup Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f8136f2-410a-4304-98c1-f94d72c9f9b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Come Up to My Place', part.name_en = 'On the Town: Come Up to My Place',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:32f7d24f-533b-3a57-8302-325fd391080a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32f7d24f-533b-3a57-8302-325fd391080a', 6, NULL, 'Come Up to My Place', 'On the Town: Come Up to My Place', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32f7d24f-533b-3a57-8302-325fd391080a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Carried Away', part.name_en = 'On the Town: Carried Away',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:ea08035a-482e-3165-9654-6ebfe5e31214' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea08035a-482e-3165-9654-6ebfe5e31214', 7, NULL, 'Carried Away', 'On the Town: Carried Away', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea08035a-482e-3165-9654-6ebfe5e31214'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Lonely Town', part.name_en = 'On the Town: Lonely Town',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:6e8b2f16-d20e-3632-841a-8f3a2c575a72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e8b2f16-d20e-3632-841a-8f3a2c575a72', 8, NULL, 'Lonely Town', 'On the Town: Lonely Town', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e8b2f16-d20e-3632-841a-8f3a2c575a72'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'High School Girls', part.name_en = 'On the Town: High School Girls',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:4fa37c1d-11bf-4ece-b0ff-ef128e135382' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fa37c1d-11bf-4ece-b0ff-ef128e135382', 9, NULL, 'High School Girls', 'On the Town: High School Girls', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fa37c1d-11bf-4ece-b0ff-ef128e135382'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Lonely Town: pas de deux (dance)', part.name_en = 'On the Town: Lonely Town: pas de deux (dance)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:31088895-330b-3a0c-b1b4-f5bdd064708a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31088895-330b-3a0c-b1b4-f5bdd064708a', 10, NULL, 'Lonely Town: pas de deux (dance)', 'On the Town: Lonely Town: pas de deux (dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31088895-330b-3a0c-b1b4-f5bdd064708a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Carnegie Hall Pavane (Do-Do-Re-Do)', part.name_en = 'On the Town: Carnegie Hall Pavane (Do-Do-Re-Do)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:014e45eb-1b38-3db1-b630-575716db7d2b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:014e45eb-1b38-3db1-b630-575716db7d2b', 11, NULL, 'Carnegie Hall Pavane (Do-Do-Re-Do)', 'On the Town: Carnegie Hall Pavane (Do-Do-Re-Do)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:014e45eb-1b38-3db1-b630-575716db7d2b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'I Can Cook Too', part.name_en = 'On the Town: I Can Cook Too',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:6d8c427f-9fae-3f5a-a976-c64ced6341bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d8c427f-9fae-3f5a-a976-c64ced6341bc', 12, NULL, 'I Can Cook Too', 'On the Town: I Can Cook Too', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d8c427f-9fae-3f5a-a976-c64ced6341bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Lucky to Be Me', part.name_en = 'On the Town: Lucky to Be Me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:db5d0b0a-f78e-38c5-a86f-0b1dfeb05339' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db5d0b0a-f78e-38c5-a86f-0b1dfeb05339', 13, NULL, 'Lucky to Be Me', 'On the Town: Lucky to Be Me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db5d0b0a-f78e-38c5-a86f-0b1dfeb05339'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Finale, Act I: Times Square Ballet (dance)', part.name_en = 'On the Town: Finale, Act I: Times Square Ballet (dance)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:95e9fd36-83be-36f3-8498-76acc63e6b82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95e9fd36-83be-36f3-8498-76acc63e6b82', 14, NULL, 'Finale, Act I: Times Square Ballet (dance)', 'On the Town: Finale, Act I: Times Square Ballet (dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95e9fd36-83be-36f3-8498-76acc63e6b82'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'So Long Baby', part.name_en = 'On the Town: So Long Baby',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:5c11d72c-9a5a-3c50-bf9d-4ce4aca8b57c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c11d72c-9a5a-3c50-bf9d-4ce4aca8b57c', 15, NULL, 'So Long Baby', 'On the Town: So Long Baby', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c11d72c-9a5a-3c50-bf9d-4ce4aca8b57c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'I Wish I Was Dead', part.name_en = 'On the Town: I Wish I Was Dead',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:f48234b5-5425-4c61-a0a1-2da6ad04a23c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f48234b5-5425-4c61-a0a1-2da6ad04a23c', 16, NULL, 'I Wish I Was Dead', 'On the Town: I Wish I Was Dead', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f48234b5-5425-4c61-a0a1-2da6ad04a23c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Ya Got Me', part.name_en = 'On the Town: Ya Got Me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:1600b6d7-74cd-3013-b983-3d18f09dfa3d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1600b6d7-74cd-3013-b983-3d18f09dfa3d', 17, NULL, 'Ya Got Me', 'On the Town: Ya Got Me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1600b6d7-74cd-3013-b983-3d18f09dfa3d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Ain''t Got No Tears Left', part.name_en = 'On the Town: Ain''t Got No Tears Left',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:983ef843-4baa-3a7b-a736-4d536c354477' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:983ef843-4baa-3a7b-a736-4d536c354477', 18, NULL, 'Ain''t Got No Tears Left', 'On the Town: Ain''t Got No Tears Left', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:983ef843-4baa-3a7b-a736-4d536c354477'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Pitkin''s Song', part.name_en = 'On the Town: Pitkin''s Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:7dd17246-7c1b-49e5-84a9-5de3cb1e9eef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7dd17246-7c1b-49e5-84a9-5de3cb1e9eef', 19, NULL, 'Pitkin''s Song', 'On the Town: Pitkin''s Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dd17246-7c1b-49e5-84a9-5de3cb1e9eef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'I Understand', part.name_en = 'On the Town: I Understand',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:1426480b-32a2-3928-9e77-d7415a3f9595' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1426480b-32a2-3928-9e77-d7415a3f9595', 20, NULL, 'I Understand', 'On the Town: I Understand', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1426480b-32a2-3928-9e77-d7415a3f9595'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Imaginary Coney Island Ballet: Subway Ride / Dance of the Great Lover / Pas de deux', part.name_en = 'On the Town: Imaginary Coney Island Ballet: Subway Ride / Dance of the Great Lover / Pas de deux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:8685d8fe-833f-3aac-874f-37931521d391' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8685d8fe-833f-3aac-874f-37931521d391', 21, NULL, 'Imaginary Coney Island Ballet: Subway Ride / Dance of the Great Lover / Pas de deux', 'On the Town: Imaginary Coney Island Ballet: Subway Ride / Dance of the Great Lover / Pas de deux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8685d8fe-833f-3aac-874f-37931521d391'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Some Other Time', part.name_en = 'On the Town: Some Other Time',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:4c9f2646-ccb3-3518-aa28-5f8f561c04b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c9f2646-ccb3-3518-aa28-5f8f561c04b5', 22, NULL, 'Some Other Time', 'On the Town: Some Other Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c9f2646-ccb3-3518-aa28-5f8f561c04b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Dance: The Real Coney Island', part.name_en = 'On the Town: Dance: The Real Coney Island',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:994c9219-93d0-39ca-971c-dcb17bb37919' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:994c9219-93d0-39ca-971c-dcb17bb37919', 23, NULL, 'Dance: The Real Coney Island', 'On the Town: Dance: The Real Coney Island', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:994c9219-93d0-39ca-971c-dcb17bb37919'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Finale, Act II', part.name_en = 'On the Town: Finale, Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:84467974-52d5-39df-a175-9f90c5478b42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84467974-52d5-39df-a175-9f90c5478b42', 24, NULL, 'Finale, Act II', 'On the Town: Finale, Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84467974-52d5-39df-a175-9f90c5478b42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Appendix: The Intermission''s Great', part.name_en = 'On the Town: Appendix: The Intermission''s Great',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2391 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:4b5117f3-a7a5-4b7c-a70d-7dce0b062f1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b5117f3-a7a5-4b7c-a70d-7dce0b062f1d', 25, NULL, 'Appendix: The Intermission''s Great', 'On the Town: Appendix: The Intermission''s Great', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2391 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b5117f3-a7a5-4b7c-a70d-7dce0b062f1d'
);


-- None 뮤지컬 <Peter Pan>

UPDATE pieces piece
SET piece.title = '뮤지컬 <Peter Pan>', piece.title_en = 'Peter Pan',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2392 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dream With Me', part.name_en = 'Peter Pan: Dream With Me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2392 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:5ff023cc-7773-486c-875f-3542d6cd4221' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ff023cc-7773-486c-875f-3542d6cd4221', 1, NULL, 'Dream With Me', 'Peter Pan: Dream With Me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2392 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ff023cc-7773-486c-875f-3542d6cd4221'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'My House', part.name_en = 'My House',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2392 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:f9ab6147-5a3f-4954-8ce3-e14e5193dc6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9ab6147-5a3f-4954-8ce3-e14e5193dc6b', 2, NULL, 'My House', 'My House', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2392 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9ab6147-5a3f-4954-8ce3-e14e5193dc6b'
);


-- None 피아노 3중주

UPDATE pieces piece
SET piece.title = '피아노 3중주', piece.title_en = 'Piano Trio',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1890 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio non troppo - Più mosso - Allegro vivace', part.name_en = 'Piano Trio: I. Adagio non troppo - Più mosso - Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1890 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:c1a7cde1-b172-4b27-94bf-969355dc10f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1a7cde1-b172-4b27-94bf-969355dc10f4', 1, 'I', 'Adagio non troppo - Più mosso - Allegro vivace', 'Piano Trio: I. Adagio non troppo - Più mosso - Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1890 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1a7cde1-b172-4b27-94bf-969355dc10f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Tempo di marcia', part.name_en = 'Piano Trio: II. Tempo di marcia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1890 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:7db106af-2d8c-452c-b9cc-14aba4b5eb97' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7db106af-2d8c-452c-b9cc-14aba4b5eb97', 2, 'II', 'Tempo di marcia', 'Piano Trio: II. Tempo di marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1890 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7db106af-2d8c-452c-b9cc-14aba4b5eb97'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Largo - Allegro vivo et molto ritmico', part.name_en = 'Piano Trio: III. Largo - Allegro vivo et molto ritmico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1890 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:93e4b489-3da0-41fc-8476-9f4af15f686b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93e4b489-3da0-41fc-8476-9f4af15f686b', 3, 'III', 'Largo - Allegro vivo et molto ritmico', 'Piano Trio: III. Largo - Allegro vivo et molto ritmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1890 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93e4b489-3da0-41fc-8476-9f4af15f686b'
);


-- None 가곡 <Piccola Serenata>

UPDATE pieces piece
SET piece.title = '가곡 <Piccola Serenata>', piece.title_en = 'Piccola Serenata',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2531 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Prelude, Fugue and Riffs

UPDATE pieces piece
SET piece.title = 'Prelude, Fugue and Riffs', piece.title_en = 'Prelude, Fugue and Riffs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2301 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prelude for the Brass', part.name_en = 'Prelude, Fugue and Riffs: I. Prelude for the Brass',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2301 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:31475372-e7c7-30fe-adf4-64b097a65b99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31475372-e7c7-30fe-adf4-64b097a65b99', 1, 'I', 'Prelude for the Brass', 'Prelude, Fugue and Riffs: I. Prelude for the Brass', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2301 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31475372-e7c7-30fe-adf4-64b097a65b99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Fugue for the Saxes', part.name_en = 'Prelude, Fugue and Riffs: II. Fugue for the Saxes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2301 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:49f237b4-9065-3164-8d6d-3405da877bbc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49f237b4-9065-3164-8d6d-3405da877bbc', 2, 'II', 'Fugue for the Saxes', 'Prelude, Fugue and Riffs: II. Fugue for the Saxes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2301 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49f237b4-9065-3164-8d6d-3405da877bbc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Riffs for Everyone', part.name_en = 'Prelude, Fugue and Riffs: III. Riffs for Everyone',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2301 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:fd3c74b5-ace9-33ae-8ff1-52abd3a701ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd3c74b5-ace9-33ae-8ff1-52abd3a701ab', 3, 'III', 'Riffs for Everyone', 'Prelude, Fugue and Riffs: III. Riffs for Everyone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2301 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd3c74b5-ace9-33ae-8ff1-52abd3a701ab'
);


-- None Presto barbaro from "On the Waterfront"

UPDATE pieces piece
SET piece.title = 'Presto barbaro from "On the Waterfront"', piece.title_en = 'Presto barbaro from "On the Waterfront"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2282 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rondo for Lifey

UPDATE pieces piece
SET piece.title = 'Rondo for Lifey', piece.title_en = 'Rondo for Lifey',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2697 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Say When>

UPDATE pieces piece
SET piece.title = '가곡 <Say When>', piece.title_en = 'Say When',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1011 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Serenade after Plato’s “Symposium”

UPDATE pieces piece
SET piece.title = 'Serenade after Plato’s “Symposium”', piece.title_en = 'Serenade after Plato’s “Symposium”',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1147 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Phaedrus: Pausanias. Lento – Allegro', part.name_en = 'Serenade after Plato’s “Symposium”: I. Phaedrus: Pausanias. Lento – Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1147 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:6161f376-3cc8-3b15-94de-e7c9f4842804' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6161f376-3cc8-3b15-94de-e7c9f4842804', 1, 'I', 'Phaedrus: Pausanias. Lento – Allegro', 'Serenade after Plato’s “Symposium”: I. Phaedrus: Pausanias. Lento – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1147 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6161f376-3cc8-3b15-94de-e7c9f4842804'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Aristophanes. Allegretto', part.name_en = 'Serenade after Plato’s “Symposium”: II. Aristophanes. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1147 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:92944c73-5303-3fbe-97de-d81be6560cdd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92944c73-5303-3fbe-97de-d81be6560cdd', 2, 'II', 'Aristophanes. Allegretto', 'Serenade after Plato’s “Symposium”: II. Aristophanes. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1147 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92944c73-5303-3fbe-97de-d81be6560cdd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Eryximachus. Presto', part.name_en = 'Serenade after Plato’s “Symposium”: III. Eryximachus. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1147 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:c6ac17a4-32c7-3c5e-86d6-562ae89018f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6ac17a4-32c7-3c5e-86d6-562ae89018f7', 3, 'III', 'Eryximachus. Presto', 'Serenade after Plato’s “Symposium”: III. Eryximachus. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1147 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6ac17a4-32c7-3c5e-86d6-562ae89018f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Agathon. Adagio', part.name_en = 'Serenade after Plato’s “Symposium”: IV. Agathon. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1147 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:c3754dc4-6792-3985-82e4-2fc56ee78d22' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3754dc4-6792-3985-82e4-2fc56ee78d22', 4, 'IV', 'Agathon. Adagio', 'Serenade after Plato’s “Symposium”: IV. Agathon. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1147 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3754dc4-6792-3985-82e4-2fc56ee78d22'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Socrates: Alcibiades. Molto tenuto – Allegro molto vivace', part.name_en = 'Serenade after Plato’s “Symposium”: V. Socrates: Alcibiades. Molto tenuto – Allegro molto vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1147 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:76550352-a56e-3cbb-b74d-c0addadcae60' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76550352-a56e-3cbb-b74d-c0addadcae60', 5, 'V', 'Socrates: Alcibiades. Molto tenuto – Allegro molto vivace', 'Serenade after Plato’s “Symposium”: V. Socrates: Alcibiades. Molto tenuto – Allegro molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1147 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76550352-a56e-3cbb-b74d-c0addadcae60'
);


-- None Seven Anniversaries

UPDATE pieces piece
SET piece.title = 'Seven Anniversaries', piece.title_en = 'Seven Anniversaries',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1073 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'For Aaron Copland', part.name_en = 'Seven Anniversaries: I. For Aaron Copland',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1073 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:aa76f8e6-9568-4918-bd09-aaa1c75bc165' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa76f8e6-9568-4918-bd09-aaa1c75bc165', 1, 'I', 'For Aaron Copland', 'Seven Anniversaries: I. For Aaron Copland', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1073 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa76f8e6-9568-4918-bd09-aaa1c75bc165'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'For My Sister, Shirley', part.name_en = 'Seven Anniversaries: II. For My Sister, Shirley',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1073 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:ec42dfb7-de08-4004-a7cc-38f2b6b497b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec42dfb7-de08-4004-a7cc-38f2b6b497b6', 2, 'II', 'For My Sister, Shirley', 'Seven Anniversaries: II. For My Sister, Shirley', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1073 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec42dfb7-de08-4004-a7cc-38f2b6b497b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'In Memoriam: Alfred Eisner', part.name_en = 'Seven Anniversaries: III. In Memoriam: Alfred Eisner',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1073 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:5e1e1cc4-f63b-40cd-be9e-23724e2037dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e1e1cc4-f63b-40cd-be9e-23724e2037dc', 3, 'III', 'In Memoriam: Alfred Eisner', 'Seven Anniversaries: III. In Memoriam: Alfred Eisner', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1073 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e1e1cc4-f63b-40cd-be9e-23724e2037dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'For Paul Bowles', part.name_en = 'Seven Anniversaries: IV. For Paul Bowles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1073 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:a62b0830-eaeb-4876-a639-3e265a021dca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a62b0830-eaeb-4876-a639-3e265a021dca', 4, 'IV', 'For Paul Bowles', 'Seven Anniversaries: IV. For Paul Bowles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1073 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a62b0830-eaeb-4876-a639-3e265a021dca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'In Memoriam: Nathalie Koussevitsky', part.name_en = 'Seven Anniversaries: V. In Memoriam: Nathalie Koussevitsky',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1073 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:dfff298a-d9dd-40a1-8e11-e347bfdfd29d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfff298a-d9dd-40a1-8e11-e347bfdfd29d', 5, 'V', 'In Memoriam: Nathalie Koussevitsky', 'Seven Anniversaries: V. In Memoriam: Nathalie Koussevitsky', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1073 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfff298a-d9dd-40a1-8e11-e347bfdfd29d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'For Sergei Koussevitzky', part.name_en = 'Seven Anniversaries: VI. For Sergei Koussevitzky',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1073 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:067c1f84-722f-4c8a-8f5d-b5877cb4c25f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:067c1f84-722f-4c8a-8f5d-b5877cb4c25f', 6, 'VI', 'For Sergei Koussevitzky', 'Seven Anniversaries: VI. For Sergei Koussevitzky', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1073 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:067c1f84-722f-4c8a-8f5d-b5877cb4c25f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'For William Schuman', part.name_en = 'Seven Anniversaries: VII. For William Schuman',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1073 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:f36ae2f2-3494-4e2b-acaf-25905c064b89' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f36ae2f2-3494-4e2b-acaf-25905c064b89', 7, 'VII', 'For William Schuman', 'Seven Anniversaries: VII. For William Schuman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1073 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f36ae2f2-3494-4e2b-acaf-25905c064b89'
);


-- None 가곡 <Silhouette (Galilee)>

UPDATE pieces piece
SET piece.title = '가곡 <Silhouette (Galilee)>', piece.title_en = 'Silhouette (Galilee)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1358 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Simchu Na

UPDATE pieces piece
SET piece.title = 'Simchu Na', piece.title_en = 'Simchu Na',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1433 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <So Pretty>

UPDATE pieces piece
SET piece.title = '가곡 <So Pretty>', piece.title_en = 'So Pretty',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2898 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 바이올린 소나타

UPDATE pieces piece
SET piece.title = '바이올린 소나타', piece.title_en = 'Sonata for Violin',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2671 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato assai', part.name_en = 'Sonata for Violin: I. Moderato assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2671 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:71e290d6-d8e7-4b5c-a2bb-302760bbe257' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71e290d6-d8e7-4b5c-a2bb-302760bbe257', 1, 'I', 'Moderato assai', 'Sonata for Violin: I. Moderato assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2671 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71e290d6-d8e7-4b5c-a2bb-302760bbe257'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Variation 1 - Adagio', part.name_en = 'Sonata for Violin: II. Variation 1 - Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2671 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:9ee2c6e2-b7dc-48bc-8adf-db6efd0e6372' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ee2c6e2-b7dc-48bc-8adf-db6efd0e6372', 2, 'II', 'Variation 1 - Adagio', 'Sonata for Violin: II. Variation 1 - Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2671 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ee2c6e2-b7dc-48bc-8adf-db6efd0e6372'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Variation 2 - Prestissimo', part.name_en = 'Sonata for Violin: III. Variation 2 - Prestissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2671 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:191eca50-9e56-473d-b999-22300b70ba3d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:191eca50-9e56-473d-b999-22300b70ba3d', 3, 'III', 'Variation 2 - Prestissimo', 'Sonata for Violin: III. Variation 2 - Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2671 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:191eca50-9e56-473d-b999-22300b70ba3d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Variation 3 - L''istesso tempo (ma un poco più libre)', part.name_en = 'Sonata for Violin: IV. Variation 3 - L''istesso tempo (ma un poco più libre)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2671 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:0b531576-2d3d-479e-b568-4e31a062adc3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b531576-2d3d-479e-b568-4e31a062adc3', 4, 'IV', 'Variation 3 - L''istesso tempo (ma un poco più libre)', 'Sonata for Violin: IV. Variation 3 - L''istesso tempo (ma un poco più libre)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2671 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b531576-2d3d-479e-b568-4e31a062adc3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Variation 4 - Andante teneremente (sempre con sordino)', part.name_en = 'Sonata for Violin: V. Variation 4 - Andante teneremente (sempre con sordino)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2671 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:15f75b93-f2a8-4dbf-b948-afcac4f30750' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15f75b93-f2a8-4dbf-b948-afcac4f30750', 5, 'V', 'Variation 4 - Andante teneremente (sempre con sordino)', 'Sonata for Violin: V. Variation 4 - Andante teneremente (sempre con sordino)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2671 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15f75b93-f2a8-4dbf-b948-afcac4f30750'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Variation 5 - Allegro agitato (senza sordino)', part.name_en = 'Sonata for Violin: VI. Variation 5 - Allegro agitato (senza sordino)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2671 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:bf633621-1878-45cf-bbfd-5ab67101b555' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf633621-1878-45cf-bbfd-5ab67101b555', 6, 'VI', 'Variation 5 - Allegro agitato (senza sordino)', 'Sonata for Violin: VI. Variation 5 - Allegro agitato (senza sordino)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2671 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf633621-1878-45cf-bbfd-5ab67101b555'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Variation 6 - Finale-sostenuto (broad, open, relaxed)', part.name_en = 'Sonata for Violin: VII. Variation 6 - Finale-sostenuto (broad, open, relaxed)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2671 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:8023d3e8-e8ac-4906-88a5-37b4f2bf2123' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8023d3e8-e8ac-4906-88a5-37b4f2bf2123', 7, 'VII', 'Variation 6 - Finale-sostenuto (broad, open, relaxed)', 'Sonata for Violin: VII. Variation 6 - Finale-sostenuto (broad, open, relaxed)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2671 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8023d3e8-e8ac-4906-88a5-37b4f2bf2123'
);


-- None 피아노 소나타

UPDATE pieces piece
SET piece.title = '피아노 소나타', piece.title_en = 'Sonata for the Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2907 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'III',
    part.name_ko = 'Moderato', part.name_en = 'Sonata for the Piano: III. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2907 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:2d5e1498-fb90-4a09-8e34-308364002bf7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d5e1498-fb90-4a09-8e34-308364002bf7', 1, 'III', 'Moderato', 'Sonata for the Piano: III. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2907 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d5e1498-fb90-4a09-8e34-308364002bf7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Largo', part.name_en = 'Sonata for the Piano: II. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2907 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:df7241ad-019e-4062-869c-8a9df2afbceb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df7241ad-019e-4062-869c-8a9df2afbceb', 2, 'II', 'Largo', 'Sonata for the Piano: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2907 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df7241ad-019e-4062-869c-8a9df2afbceb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'I',
    part.name_ko = 'Presto - molto moderato - presto', part.name_en = 'Sonata for the Piano: I. Presto - molto moderato - presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2907 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:ed364e20-cbbd-454f-a10d-c2b82f5f3023' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed364e20-cbbd-454f-a10d-c2b82f5f3023', 3, 'I', 'Presto - molto moderato - presto', 'Sonata for the Piano: I. Presto - molto moderato - presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2907 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed364e20-cbbd-454f-a10d-c2b82f5f3023'
);


-- None 연가곡집 <Songfest: A Cycle of American Poems for Six Singers and Orchestra>

UPDATE pieces piece
SET piece.title = '연가곡집 <Songfest: A Cycle of American Poems for Six Singers and Orchestra>', piece.title_en = 'Songfest: A Cycle of American Poems for Six Singers and Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2036 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'To the Poem', part.name_en = 'Songfest: I. To the Poem',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2036 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:a2e23d51-81f2-4bc9-a8fc-b5d71d255a71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2e23d51-81f2-4bc9-a8fc-b5d71d255a71', 1, 'I', 'To the Poem', 'Songfest: I. To the Poem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2036 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2e23d51-81f2-4bc9-a8fc-b5d71d255a71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Pennycandystore Beyond the El', part.name_en = 'Songfest: II. The Pennycandystore Beyond the El',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2036 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:a7f3ed6f-840d-4a5b-a72c-5cb1b32163dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7f3ed6f-840d-4a5b-a72c-5cb1b32163dc', 2, 'II', 'The Pennycandystore Beyond the El', 'Songfest: II. The Pennycandystore Beyond the El', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2036 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7f3ed6f-840d-4a5b-a72c-5cb1b32163dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'A Julia de Burgos', part.name_en = 'Songfest: III. A Julia de Burgos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2036 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:fe77739f-3436-4d33-9439-ec71ce71a3b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe77739f-3436-4d33-9439-ec71ce71a3b4', 3, 'III', 'A Julia de Burgos', 'Songfest: III. A Julia de Burgos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2036 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe77739f-3436-4d33-9439-ec71ce71a3b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'To What You Said', part.name_en = 'Songfest: IV. To What You Said',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2036 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:884b940b-a50d-4867-9a99-17b7dfd5a083' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:884b940b-a50d-4867-9a99-17b7dfd5a083', 4, 'IV', 'To What You Said', 'Songfest: IV. To What You Said', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2036 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:884b940b-a50d-4867-9a99-17b7dfd5a083'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'I, Too, Sing America', part.name_en = 'Songfest: V. I, Too, Sing America',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2036 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:c4195ff6-d41c-41cc-857e-d2ce896eafb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4195ff6-d41c-41cc-857e-d2ce896eafb4', 5, 'V', 'I, Too, Sing America', 'Songfest: V. I, Too, Sing America', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2036 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4195ff6-d41c-41cc-857e-d2ce896eafb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'To My Dear and Loving Husband', part.name_en = 'Songfest: VI. To My Dear and Loving Husband',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2036 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:2f6eca19-486a-4f12-a4d0-ce85ba8cf000' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f6eca19-486a-4f12-a4d0-ce85ba8cf000', 6, 'VI', 'To My Dear and Loving Husband', 'Songfest: VI. To My Dear and Loving Husband', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2036 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f6eca19-486a-4f12-a4d0-ce85ba8cf000'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Storyette H. M', part.name_en = 'Songfest: VII. Storyette H. M.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2036 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:35da3954-3355-4ef6-88ca-5f6becf37f63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35da3954-3355-4ef6-88ca-5f6becf37f63', 7, 'VII', 'Storyette H. M', 'Songfest: VII. Storyette H. M.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2036 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35da3954-3355-4ef6-88ca-5f6becf37f63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = '''If You Can''t Eat You Got To''', part.name_en = 'Songfest: VIII. ''If You Can''t Eat You Got To''',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2036 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:91e6d58e-ea12-4873-aa6e-8f95ecbe6867' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91e6d58e-ea12-4873-aa6e-8f95ecbe6867', 8, 'VIII', '''If You Can''t Eat You Got To''', 'Songfest: VIII. ''If You Can''t Eat You Got To''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2036 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91e6d58e-ea12-4873-aa6e-8f95ecbe6867'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Music I Heard With You', part.name_en = 'Songfest: IX. Music I Heard With You',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2036 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:711ee17b-d881-4669-a696-2e9c602664dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:711ee17b-d881-4669-a696-2e9c602664dc', 9, 'IX', 'Music I Heard With You', 'Songfest: IX. Music I Heard With You', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2036 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:711ee17b-d881-4669-a696-2e9c602664dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Zizi''s Lament', part.name_en = 'Songfest: X. Zizi''s Lament',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2036 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:60d67218-c005-4036-b2d8-6e8a28b14119' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60d67218-c005-4036-b2d8-6e8a28b14119', 10, 'X', 'Zizi''s Lament', 'Songfest: X. Zizi''s Lament', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2036 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60d67218-c005-4036-b2d8-6e8a28b14119'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'What Lips My Lips Have Kissed', part.name_en = 'Songfest: XI. What Lips My Lips Have Kissed...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2036 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:abf53e40-1083-4a87-910d-8e0163d486c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:abf53e40-1083-4a87-910d-8e0163d486c8', 11, 'XI', 'What Lips My Lips Have Kissed', 'Songfest: XI. What Lips My Lips Have Kissed...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2036 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abf53e40-1083-4a87-910d-8e0163d486c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Israfel', part.name_en = 'Songfest: XII. Israfel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2036 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:bc789b53-c193-4ce3-b4cf-9a68c3bae159' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc789b53-c193-4ce3-b4cf-9a68c3bae159', 12, 'XII', 'Israfel', 'Songfest: XII. Israfel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2036 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc789b53-c193-4ce3-b4cf-9a68c3bae159'
);


-- None 가곡 <Spring Will Come Again>

UPDATE pieces piece
SET piece.title = '가곡 <Spring Will Come Again>', piece.title_en = 'Spring Will Come Again',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1423 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 교향곡 1번 "Jeremiah"

UPDATE pieces piece
SET piece.title = '교향곡 1번 "Jeremiah"', piece.title_en = 'Symphony no. 1 “Jeremiah”',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 757 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prophecy', part.name_en = 'Symphony no. 1 “Jeremiah”: I. Prophecy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 757 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:f0662308-2d73-4b4a-8628-7f207255106c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0662308-2d73-4b4a-8628-7f207255106c', 1, 'I', 'Prophecy', 'Symphony no. 1 “Jeremiah”: I. Prophecy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 757 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0662308-2d73-4b4a-8628-7f207255106c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Profanation', part.name_en = 'Symphony no. 1 “Jeremiah”: II. Profanation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 757 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:9e2fa3ee-7f8c-4100-878c-e72af1463a99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e2fa3ee-7f8c-4100-878c-e72af1463a99', 2, 'II', 'Profanation', 'Symphony no. 1 “Jeremiah”: II. Profanation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 757 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e2fa3ee-7f8c-4100-878c-e72af1463a99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Lamentation', part.name_en = 'Symphony no. 1 “Jeremiah”: III. Lamentation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 757 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:1fad4154-3023-4021-885f-92f19fbc2a11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fad4154-3023-4021-885f-92f19fbc2a11', 3, 'III', 'Lamentation', 'Symphony no. 1 “Jeremiah”: III. Lamentation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 757 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fad4154-3023-4021-885f-92f19fbc2a11'
);


-- None 교향곡 2번 "The Age of Anxiety"

UPDATE pieces piece
SET piece.title = '교향곡 2번 "The Age of Anxiety"', piece.title_en = 'Symphony no. 2 for Piano and Orchestra “The Age of Anxiety” (after W. H. Auden)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 752 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ia. The Prologue. Lento moderato', part.name_en = 'Symphony no. 2 for Piano and Orchestra “The Age of Anxiety” (after W. H. Auden): Ia. The Prologue. Lento moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 752 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:a5dfc327-c999-479b-88e4-7aafba551e9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5dfc327-c999-479b-88e4-7aafba551e9d', 1, NULL, 'Ia. The Prologue. Lento moderato', 'Symphony no. 2 for Piano and Orchestra “The Age of Anxiety” (after W. H. Auden): Ia. The Prologue. Lento moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 752 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5dfc327-c999-479b-88e4-7aafba551e9d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ib. The Seven Ages (Variations I–VII)', part.name_en = 'Symphony no. 2 for Piano and Orchestra “The Age of Anxiety” (after W. H. Auden): Ib. The Seven Ages (Variations I–VII)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 752 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:d42f1014-ef0b-4967-a024-9c197a3729f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d42f1014-ef0b-4967-a024-9c197a3729f9', 2, NULL, 'Ib. The Seven Ages (Variations I–VII)', 'Symphony no. 2 for Piano and Orchestra “The Age of Anxiety” (after W. H. Auden): Ib. The Seven Ages (Variations I–VII)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 752 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d42f1014-ef0b-4967-a024-9c197a3729f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ic. The Seven Stages (Variations VIII–XIV)', part.name_en = 'Symphony no. 2 for Piano and Orchestra “The Age of Anxiety” (after W. H. Auden): Ic. The Seven Stages (Variations VIII–XIV)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 752 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:b8c85dd3-2dda-47be-bc54-0657b3829d95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8c85dd3-2dda-47be-bc54-0657b3829d95', 3, NULL, 'Ic. The Seven Stages (Variations VIII–XIV)', 'Symphony no. 2 for Piano and Orchestra “The Age of Anxiety” (after W. H. Auden): Ic. The Seven Stages (Variations VIII–XIV)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 752 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8c85dd3-2dda-47be-bc54-0657b3829d95'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IIa. The Dirge. Largo', part.name_en = 'Symphony no. 2 for Piano and Orchestra “The Age of Anxiety” (after W. H. Auden): IIa. The Dirge. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 752 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:c08bc493-1df5-4033-b1c4-b4b1f8452950' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c08bc493-1df5-4033-b1c4-b4b1f8452950', 4, NULL, 'IIa. The Dirge. Largo', 'Symphony no. 2 for Piano and Orchestra “The Age of Anxiety” (after W. H. Auden): IIa. The Dirge. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 752 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c08bc493-1df5-4033-b1c4-b4b1f8452950'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'IIb. The Masque. Extremely Fast', part.name_en = 'Symphony no. 2 for Piano and Orchestra “The Age of Anxiety” (after W. H. Auden): IIb. The Masque. Extremely Fast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 752 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:e238949d-bedb-40d4-9ffb-eaf6ede90f1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e238949d-bedb-40d4-9ffb-eaf6ede90f1a', 5, NULL, 'IIb. The Masque. Extremely Fast', 'Symphony no. 2 for Piano and Orchestra “The Age of Anxiety” (after W. H. Auden): IIb. The Masque. Extremely Fast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 752 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e238949d-bedb-40d4-9ffb-eaf6ede90f1a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'IIc. The Epilogue. Adagio – Andante – Con moto', part.name_en = 'Symphony no. 2 for Piano and Orchestra “The Age of Anxiety” (after W. H. Auden): IIc. The Epilogue. Adagio – Andante – Con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 752 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:97cec2e5-fa46-4467-9c15-6a5b08cd6f4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97cec2e5-fa46-4467-9c15-6a5b08cd6f4e', 6, NULL, 'IIc. The Epilogue. Adagio – Andante – Con moto', 'Symphony no. 2 for Piano and Orchestra “The Age of Anxiety” (after W. H. Auden): IIc. The Epilogue. Adagio – Andante – Con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 752 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97cec2e5-fa46-4467-9c15-6a5b08cd6f4e'
);


-- None 교향곡 3번 "Kaddish"

UPDATE pieces piece
SET piece.title = '교향곡 3번 "Kaddish"', piece.title_en = 'Symphony no. 3 “Kaddish”',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 762 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Invocation – Kaddish 1', part.name_en = 'Symphony no. 3 “Kaddish”: I. Invocation – Kaddish 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 762 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:5f269f92-73ca-423b-a8ec-e64078fe9a11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f269f92-73ca-423b-a8ec-e64078fe9a11', 1, 'I', 'Invocation – Kaddish 1', 'Symphony no. 3 “Kaddish”: I. Invocation – Kaddish 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 762 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f269f92-73ca-423b-a8ec-e64078fe9a11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Din-Torah – Kaddish 2', part.name_en = 'Symphony no. 3 “Kaddish”: II. Din-Torah – Kaddish 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 762 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:003d05b7-d16f-4b04-8e06-bf82d70c02a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:003d05b7-d16f-4b04-8e06-bf82d70c02a0', 2, 'II', 'Din-Torah – Kaddish 2', 'Symphony no. 3 “Kaddish”: II. Din-Torah – Kaddish 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 762 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:003d05b7-d16f-4b04-8e06-bf82d70c02a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo – Kaddish 3 – Finale. Fugue-Tutti', part.name_en = 'Symphony no. 3 “Kaddish”: III. Scherzo – Kaddish 3 – Finale. Fugue-Tutti',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 762 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:3175466a-a809-465b-b443-089867050a5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3175466a-a809-465b-b443-089867050a5e', 3, 'III', 'Scherzo – Kaddish 3 – Finale. Fugue-Tutti', 'Symphony no. 3 “Kaddish”: III. Scherzo – Kaddish 3 – Finale. Fugue-Tutti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 762 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3175466a-a809-465b-b443-089867050a5e'
);


-- None The Lark (French Choruses)

UPDATE pieces piece
SET piece.title = 'The Lark (French Choruses)', piece.title_en = 'The Lark (French Choruses)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1966 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Story of My Life

UPDATE pieces piece
SET piece.title = 'The Story of My Life', piece.title_en = 'The Story of My Life',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1615 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Thirteen Anniversaries

UPDATE pieces piece
SET piece.title = 'Thirteen Anniversaries', piece.title_en = 'Thirteen Anniversaries',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 944 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'IX',
    part.name_ko = 'For Jessica Fleischmann', part.name_en = 'Thirteen Anniversaries: IX. For Jessica Fleischmann',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 944 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:036a0a16-92a5-49db-9e16-60c1eec564c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:036a0a16-92a5-49db-9e16-60c1eec564c8', 1, 'IX', 'For Jessica Fleischmann', 'Thirteen Anniversaries: IX. For Jessica Fleischmann', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 944 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:036a0a16-92a5-49db-9e16-60c1eec564c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'III',
    part.name_ko = 'For Stephen Sondheim', part.name_en = 'Thirteen Anniversaries: III. For Stephen Sondheim',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 944 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:1bf7ed4d-7d46-439d-9411-9596bdc19f43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bf7ed4d-7d46-439d-9411-9596bdc19f43', 2, 'III', 'For Stephen Sondheim', 'Thirteen Anniversaries: III. For Stephen Sondheim', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 944 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bf7ed4d-7d46-439d-9411-9596bdc19f43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'XI',
    part.name_ko = 'For Felicia, on our 28th Birthday (& her 52nd)', part.name_en = 'Thirteen Anniversaries: XI. For Felicia, on our 28th Birthday (& her 52nd)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 944 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:28c56355-6873-4a03-b8c4-72ff68445596' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28c56355-6873-4a03-b8c4-72ff68445596', 3, 'XI', 'For Felicia, on our 28th Birthday (& her 52nd)', 'Thirteen Anniversaries: XI. For Felicia, on our 28th Birthday (& her 52nd)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 944 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28c56355-6873-4a03-b8c4-72ff68445596'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'VII',
    part.name_ko = 'In Memoriam: Helen Coates', part.name_en = 'Thirteen Anniversaries: VII. In Memoriam: Helen Coates',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 944 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:3664ed90-2491-47fe-9110-6cbbd9627728' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3664ed90-2491-47fe-9110-6cbbd9627728', 4, 'VII', 'In Memoriam: Helen Coates', 'Thirteen Anniversaries: VII. In Memoriam: Helen Coates', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 944 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3664ed90-2491-47fe-9110-6cbbd9627728'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'X',
    part.name_ko = 'In Memoriam: Constance Hope', part.name_en = 'Thirteen Anniversaries: X. In Memoriam: Constance Hope',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 944 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:54fa2cd0-5792-4b1d-afea-1f8d34b5faba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54fa2cd0-5792-4b1d-afea-1f8d34b5faba', 5, 'X', 'In Memoriam: Constance Hope', 'Thirteen Anniversaries: X. In Memoriam: Constance Hope', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 944 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54fa2cd0-5792-4b1d-afea-1f8d34b5faba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'For My Daughter, Nina', part.name_en = 'Thirteen Anniversaries: VI. For My Daughter, Nina',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 944 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:5e748b22-6062-410b-8c46-797f5ce3b683' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e748b22-6062-410b-8c46-797f5ce3b683', 6, 'VI', 'For My Daughter, Nina', 'Thirteen Anniversaries: VI. For My Daughter, Nina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 944 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e748b22-6062-410b-8c46-797f5ce3b683'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'IV',
    part.name_ko = 'For Craig Urquhart', part.name_en = 'Thirteen Anniversaries: IV. For Craig Urquhart',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 944 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:6bbe6364-c8f4-4a22-bfad-40d97f32bd9a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bbe6364-c8f4-4a22-bfad-40d97f32bd9a', 7, 'IV', 'For Craig Urquhart', 'Thirteen Anniversaries: IV. For Craig Urquhart', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 944 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bbe6364-c8f4-4a22-bfad-40d97f32bd9a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'In Memoriam: Goddard Lieberson', part.name_en = 'Thirteen Anniversaries: VIII. In Memoriam: Goddard Lieberson',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 944 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:6fbb08b1-6a22-43f6-941c-2a8949fdc1ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fbb08b1-6a22-43f6-941c-2a8949fdc1ae', 8, 'VIII', 'In Memoriam: Goddard Lieberson', 'Thirteen Anniversaries: VIII. In Memoriam: Goddard Lieberson', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 944 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fbb08b1-6a22-43f6-941c-2a8949fdc1ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'V',
    part.name_ko = 'For Leo Smit', part.name_en = 'Thirteen Anniversaries: V. For Leo Smit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 944 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:77369db3-a9f2-4abf-8df6-f77171f91e7c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77369db3-a9f2-4abf-8df6-f77171f91e7c', 9, 'V', 'For Leo Smit', 'Thirteen Anniversaries: V. For Leo Smit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 944 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77369db3-a9f2-4abf-8df6-f77171f91e7c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'I',
    part.name_ko = 'For Shirley Gabis Rhoads Perle', part.name_en = 'Thirteen Anniversaries: I. For Shirley Gabis Rhoads Perle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 944 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:7de047bd-aacb-4a11-bd45-66387d424839' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7de047bd-aacb-4a11-bd45-66387d424839', 10, 'I', 'For Shirley Gabis Rhoads Perle', 'Thirteen Anniversaries: I. For Shirley Gabis Rhoads Perle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 944 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7de047bd-aacb-4a11-bd45-66387d424839'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XII',
    part.name_ko = 'For Aaron Stern', part.name_en = 'Thirteen Anniversaries: XII. For Aaron Stern',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 944 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:835fc415-771a-49e2-85bd-bc1ce5fe35bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:835fc415-771a-49e2-85bd-bc1ce5fe35bf', 11, 'XII', 'For Aaron Stern', 'Thirteen Anniversaries: XII. For Aaron Stern', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 944 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:835fc415-771a-49e2-85bd-bc1ce5fe35bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XIII',
    part.name_ko = 'In Memoriam: Ellen Goetz', part.name_en = 'Thirteen Anniversaries: XIII. In Memoriam: Ellen Goetz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 944 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:b14dca7f-dc0b-4e0c-89c0-22ae68600cd1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b14dca7f-dc0b-4e0c-89c0-22ae68600cd1', 12, 'XIII', 'In Memoriam: Ellen Goetz', 'Thirteen Anniversaries: XIII. In Memoriam: Ellen Goetz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 944 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b14dca7f-dc0b-4e0c-89c0-22ae68600cd1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'II',
    part.name_ko = 'In Memoriam: William Kapell', part.name_en = 'Thirteen Anniversaries: II. In Memoriam: William Kapell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 944 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:c07b791d-7b38-4db0-9cd7-1ed306284ff6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c07b791d-7b38-4db0-9cd7-1ed306284ff6', 13, 'II', 'In Memoriam: William Kapell', 'Thirteen Anniversaries: II. In Memoriam: William Kapell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 944 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c07b791d-7b38-4db0-9cd7-1ed306284ff6'
);


-- None Three Meditations From "Mass" for Cello and Orchestra

UPDATE pieces piece
SET piece.title = 'Three Meditations From "Mass" for Cello and Orchestra', piece.title_en = 'Three Meditations From "Mass" for Cello and Orchestra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1260 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Three Meditations From "Mass" for Cello and Piano

UPDATE pieces piece
SET piece.title = 'Three Meditations From "Mass" for Cello and Piano', piece.title_en = 'Three Meditations From "Mass" for Cello and Piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1134 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Touches

UPDATE pieces piece
SET piece.title = 'Touches', piece.title_en = 'Touches',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2852 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Touches: Chorale, Eight Variations and Coda

UPDATE pieces piece
SET piece.title = 'Touches: Chorale, Eight Variations and Coda', piece.title_en = 'Touches: Chorale, Eight Variations and Coda',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2077 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Trouble in Tahiti>

UPDATE pieces piece
SET piece.title = '오페라 <Trouble in Tahiti>', piece.title_en = 'Trouble in Tahiti',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1648 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene 2. "Yes? Oh, Mister Partridge"', part.name_en = 'Trouble in Tahiti: Scene 2. "Yes? Oh, Mister Partridge"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1648 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:187a3f57-04ce-3fc2-a176-274378f76f1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:187a3f57-04ce-3fc2-a176-274378f76f1d', 1, NULL, 'Scene 2. "Yes? Oh, Mister Partridge"', 'Trouble in Tahiti: Scene 2. "Yes? Oh, Mister Partridge"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1648 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:187a3f57-04ce-3fc2-a176-274378f76f1d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene 1. "How could you say"', part.name_en = 'Trouble in Tahiti: Scene 1. "How could you say"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1648 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:1ab21697-aaf1-38ae-99c9-a71c100ba55d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ab21697-aaf1-38ae-99c9-a71c100ba55d', 2, NULL, 'Scene 1. "How could you say"', 'Trouble in Tahiti: Scene 1. "How could you say"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1648 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ab21697-aaf1-38ae-99c9-a71c100ba55d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene 5. "There''s a law"', part.name_en = 'Trouble in Tahiti: Scene 5. "There''s a law"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1648 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:4a4eabcf-965b-3c6b-b81b-d425dfe22d05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a4eabcf-965b-3c6b-b81b-d425dfe22d05', 3, NULL, 'Scene 5. "There''s a law"', 'Trouble in Tahiti: Scene 5. "There''s a law"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1648 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a4eabcf-965b-3c6b-b81b-d425dfe22d05'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Prelude. "Daa/Doa Day" - "Mornin'' sun"', part.name_en = 'Trouble in Tahiti: Prelude. "Daa/Doa Day" - "Mornin'' sun"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1648 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:5cf00b86-1521-37a5-b080-5e29bb60103a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cf00b86-1521-37a5-b080-5e29bb60103a', 4, NULL, 'Prelude. "Daa/Doa Day" - "Mornin'' sun"', 'Trouble in Tahiti: Prelude. "Daa/Doa Day" - "Mornin'' sun"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1648 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cf00b86-1521-37a5-b080-5e29bb60103a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scene 3a. "Then desire took hold inside me"', part.name_en = 'Trouble in Tahiti: Scene 3a. "Then desire took hold inside me"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1648 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:6fc8fb24-4233-35ed-a8a6-74397fe97399' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fc8fb24-4233-35ed-a8a6-74397fe97399', 5, NULL, 'Scene 3a. "Then desire took hold inside me"', 'Trouble in Tahiti: Scene 3a. "Then desire took hold inside me"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1648 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fc8fb24-4233-35ed-a8a6-74397fe97399'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Scene 4. "I''m on my way"', part.name_en = 'Trouble in Tahiti: Scene 4. "I''m on my way"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1648 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:81f0361d-28ea-3918-9884-7abc28978235' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81f0361d-28ea-3918-9884-7abc28978235', 6, NULL, 'Scene 4. "I''m on my way"', 'Trouble in Tahiti: Scene 4. "I''m on my way"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1648 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81f0361d-28ea-3918-9884-7abc28978235'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Scene 6. "What a movie"', part.name_en = 'Trouble in Tahiti: Scene 6. "What a movie"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1648 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:a724972c-8f1d-3a1f-8933-e0f9576324a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a724972c-8f1d-3a1f-8933-e0f9576324a1', 7, NULL, 'Scene 6. "What a movie"', 'Trouble in Tahiti: Scene 6. "What a movie"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1648 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a724972c-8f1d-3a1f-8933-e0f9576324a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Interlude. "Skid a lit day"', part.name_en = 'Trouble in Tahiti: Interlude. "Skid a lit day"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1648 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:ae16a15c-6e89-3830-84fe-bdbddd9a7dd9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae16a15c-6e89-3830-84fe-bdbddd9a7dd9', 8, NULL, 'Interlude. "Skid a lit day"', 'Trouble in Tahiti: Interlude. "Skid a lit day"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1648 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae16a15c-6e89-3830-84fe-bdbddd9a7dd9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Scene 6a. "There''s a law"', part.name_en = 'Trouble in Tahiti: Scene 6a. "There''s a law"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1648 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:b08587d1-b464-3bec-961f-49199fbf8db1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b08587d1-b464-3bec-961f-49199fbf8db1', 9, NULL, 'Scene 6a. "There''s a law"', 'Trouble in Tahiti: Scene 6a. "There''s a law"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1648 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b08587d1-b464-3bec-961f-49199fbf8db1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Scene 3. "I was standing in a garden"', part.name_en = 'Trouble in Tahiti: Scene 3. "I was standing in a garden"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1648 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:e77eaf65-27a3-3b45-9d28-a8fa41b8c027' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e77eaf65-27a3-3b45-9d28-a8fa41b8c027', 10, NULL, 'Scene 3. "I was standing in a garden"', 'Trouble in Tahiti: Scene 3. "I was standing in a garden"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1648 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e77eaf65-27a3-3b45-9d28-a8fa41b8c027'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Scene 7. "Evenin'' shadows"', part.name_en = 'Trouble in Tahiti: Scene 7. "Evenin'' shadows"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1648 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:f13a3a12-ef5b-3663-bfec-eb4d43008e74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f13a3a12-ef5b-3663-bfec-eb4d43008e74', 11, NULL, 'Scene 7. "Evenin'' shadows"', 'Trouble in Tahiti: Scene 7. "Evenin'' shadows"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1648 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f13a3a12-ef5b-3663-bfec-eb4d43008e74'
);


-- None 가곡 <Two Love Songs>

UPDATE pieces piece
SET piece.title = '가곡 <Two Love Songs>', piece.title_en = 'Two Love Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2484 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Extinguish My Eyes', part.name_en = 'Two Love Songs: Extinguish My Eyes...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2484 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:5ffbe733-39f6-4a19-98e8-3436c4e57427' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ffbe733-39f6-4a19-98e8-3436c4e57427', 1, NULL, 'Extinguish My Eyes', 'Two Love Songs: Extinguish My Eyes...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2484 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ffbe733-39f6-4a19-98e8-3436c4e57427'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'When My Soul Touches Yours', part.name_en = 'Two Love Songs: When My Soul Touches Yours',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2484 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:288d447a-5801-4137-adb9-67efd21ddc0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:288d447a-5801-4137-adb9-67efd21ddc0c', 2, NULL, 'When My Soul Touches Yours', 'Two Love Songs: When My Soul Touches Yours', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2484 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:288d447a-5801-4137-adb9-67efd21ddc0c'
);


-- None 가곡 <Up! Up! Up!>

UPDATE pieces piece
SET piece.title = '가곡 <Up! Up! Up!>', piece.title_en = 'Up! Up! Up!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1070 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Warm-Up

UPDATE pieces piece
SET piece.title = 'Warm-Up', piece.title_en = 'Warm-Up',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1904 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None West Side Story: Melodies

UPDATE pieces piece
SET piece.title = 'West Side Story: Melodies', piece.title_en = 'West Side Story: Melodies',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2505 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Who Am I?>

UPDATE pieces piece
SET piece.title = '가곡 <Who Am I?>', piece.title_en = 'Who Am I?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 765 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 뮤지컬 <Wonderful Town>

UPDATE pieces piece
SET piece.title = '뮤지컬 <Wonderful Town>', piece.title_en = 'Wonderful Town',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2287 AND piece.composer_id = 87
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I. Overture', part.name_en = 'Wonderful Town: Act I. Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2287 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:f5aad716-d456-3103-acd7-e949a829d76c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5aad716-d456-3103-acd7-e949a829d76c', 1, NULL, 'Act I. Overture', 'Wonderful Town: Act I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2287 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5aad716-d456-3103-acd7-e949a829d76c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I. Christopher Street', part.name_en = 'Wonderful Town: Act I. Christopher Street',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2287 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:4c3f4efc-6a1a-35a8-b39a-48cfdf1bbc14' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c3f4efc-6a1a-35a8-b39a-48cfdf1bbc14', 2, NULL, 'Act I. Christopher Street', 'Wonderful Town: Act I. Christopher Street', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2287 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c3f4efc-6a1a-35a8-b39a-48cfdf1bbc14'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act I. Ohio', part.name_en = 'Wonderful Town: Act I. Ohio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2287 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:bd8ad98d-cb04-3ac8-a830-9e4df866639a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd8ad98d-cb04-3ac8-a830-9e4df866639a', 3, NULL, 'Act I. Ohio', 'Wonderful Town: Act I. Ohio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2287 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd8ad98d-cb04-3ac8-a830-9e4df866639a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act I. Conquering New York', part.name_en = 'Wonderful Town: Act I. Conquering New York',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2287 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:8a173c69-57ea-333a-8fb6-5b2f87aff672' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a173c69-57ea-333a-8fb6-5b2f87aff672', 4, NULL, 'Act I. Conquering New York', 'Wonderful Town: Act I. Conquering New York', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2287 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a173c69-57ea-333a-8fb6-5b2f87aff672'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act I. One Hundred Ways to Lose a Man', part.name_en = 'Wonderful Town: Act I. One Hundred Ways to Lose a Man',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2287 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:ab52e813-d143-3517-8d93-b6b7f99cc5ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab52e813-d143-3517-8d93-b6b7f99cc5ac', 5, NULL, 'Act I. One Hundred Ways to Lose a Man', 'Wonderful Town: Act I. One Hundred Ways to Lose a Man', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2287 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab52e813-d143-3517-8d93-b6b7f99cc5ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act I. What a Waste', part.name_en = 'Wonderful Town: Act I. What a Waste',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2287 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:4504dce1-dacc-3773-9a67-cabc9ff2f812' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4504dce1-dacc-3773-9a67-cabc9ff2f812', 6, NULL, 'Act I. What a Waste', 'Wonderful Town: Act I. What a Waste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2287 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4504dce1-dacc-3773-9a67-cabc9ff2f812'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act I. A Little Bit in Love', part.name_en = 'Wonderful Town: Act I. A Little Bit in Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2287 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:574bc81d-c387-3711-ac2c-88c13110c071' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:574bc81d-c387-3711-ac2c-88c13110c071', 7, NULL, 'Act I. A Little Bit in Love', 'Wonderful Town: Act I. A Little Bit in Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2287 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:574bc81d-c387-3711-ac2c-88c13110c071'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act I. Pass the Football', part.name_en = 'Wonderful Town: Act I. Pass the Football',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2287 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:bb13b32c-9e20-35bc-99a3-957df904d4fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb13b32c-9e20-35bc-99a3-957df904d4fe', 8, NULL, 'Act I. Pass the Football', 'Wonderful Town: Act I. Pass the Football', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2287 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb13b32c-9e20-35bc-99a3-957df904d4fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act I. Conversation Piece', part.name_en = 'Wonderful Town: Act I. Conversation Piece',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2287 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:e5a52d91-8920-3d4f-8e35-cd75974129a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5a52d91-8920-3d4f-8e35-cd75974129a2', 9, NULL, 'Act I. Conversation Piece', 'Wonderful Town: Act I. Conversation Piece', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2287 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5a52d91-8920-3d4f-8e35-cd75974129a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act I. A Quiet Girl', part.name_en = 'Wonderful Town: Act I. A Quiet Girl',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2287 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:7b5f5c2d-45d9-3f9b-96e6-31a23f3e599c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b5f5c2d-45d9-3f9b-96e6-31a23f3e599c', 10, NULL, 'Act I. A Quiet Girl', 'Wonderful Town: Act I. A Quiet Girl', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2287 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b5f5c2d-45d9-3f9b-96e6-31a23f3e599c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act I. Conga!', part.name_en = 'Wonderful Town: Act I. Conga!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2287 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:3f9e6cd9-d0a0-3f05-9e62-ddb78f0af9bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f9e6cd9-d0a0-3f05-9e62-ddb78f0af9bf', 11, NULL, 'Act I. Conga!', 'Wonderful Town: Act I. Conga!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2287 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f9e6cd9-d0a0-3f05-9e62-ddb78f0af9bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Act I. Entr''acte', part.name_en = 'Wonderful Town: Act I. Entr''acte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2287 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:9caea343-9206-3dfb-b0c7-9c2a1b0520b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9caea343-9206-3dfb-b0c7-9c2a1b0520b7', 12, NULL, 'Act I. Entr''acte', 'Wonderful Town: Act I. Entr''acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2287 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9caea343-9206-3dfb-b0c7-9c2a1b0520b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Act II. My Darlin'' Eileen', part.name_en = 'Wonderful Town: Act II. My Darlin'' Eileen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2287 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:275ccc7c-6876-3d8d-9776-840cf31a37c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:275ccc7c-6876-3d8d-9776-840cf31a37c9', 13, NULL, 'Act II. My Darlin'' Eileen', 'Wonderful Town: Act II. My Darlin'' Eileen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2287 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:275ccc7c-6876-3d8d-9776-840cf31a37c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Act II. Swing!', part.name_en = 'Wonderful Town: Act II. Swing!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2287 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:68b2060e-e72e-3adc-a080-731b5b244433' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68b2060e-e72e-3adc-a080-731b5b244433', 14, NULL, 'Act II. Swing!', 'Wonderful Town: Act II. Swing!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2287 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68b2060e-e72e-3adc-a080-731b5b244433'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Act II. Quiet Incidental', part.name_en = 'Wonderful Town: Act II. Quiet Incidental',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2287 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:0bf1dc1e-a156-3041-bc51-9fce6e2228f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bf1dc1e-a156-3041-bc51-9fce6e2228f6', 15, NULL, 'Act II. Quiet Incidental', 'Wonderful Town: Act II. Quiet Incidental', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2287 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bf1dc1e-a156-3041-bc51-9fce6e2228f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Act II: No. 16a. Ohio (Reprise)', part.name_en = 'Wonderful Town, Act II: No. 16a. Ohio (Reprise)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2287 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:09fdf70d-599e-4de4-8a58-2f6ab351ca88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09fdf70d-599e-4de4-8a58-2f6ab351ca88', 16, NULL, 'Act II: No. 16a. Ohio (Reprise)', 'Wonderful Town, Act II: No. 16a. Ohio (Reprise)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2287 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09fdf70d-599e-4de4-8a58-2f6ab351ca88'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Act II. It’s Love', part.name_en = 'Wonderful Town: Act II. It’s Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2287 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:55a7bfec-79c1-42f2-80ee-1493f5695bc0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55a7bfec-79c1-42f2-80ee-1493f5695bc0', 17, NULL, 'Act II. It’s Love', 'Wonderful Town: Act II. It’s Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2287 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55a7bfec-79c1-42f2-80ee-1493f5695bc0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Act II. Ballet at the Village Vortex', part.name_en = 'Wonderful Town: Act II. Ballet at the Village Vortex',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2287 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:4a7ca28f-751b-3bd5-bcd5-18a0eeac206b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a7ca28f-751b-3bd5-bcd5-18a0eeac206b', 18, NULL, 'Act II. Ballet at the Village Vortex', 'Wonderful Town: Act II. Ballet at the Village Vortex', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2287 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a7ca28f-751b-3bd5-bcd5-18a0eeac206b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Act II. Wrong Note Rag', part.name_en = 'Wonderful Town: Act II. Wrong Note Rag',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2287 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:d955c905-762c-3d7c-aab2-23d07bf1d42d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d955c905-762c-3d7c-aab2-23d07bf1d42d', 19, NULL, 'Act II. Wrong Note Rag', 'Wonderful Town: Act II. Wrong Note Rag', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2287 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d955c905-762c-3d7c-aab2-23d07bf1d42d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Act II. It''s Love (Reprise)', part.name_en = 'Wonderful Town: Act II. It''s Love (Reprise)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2287 AND p.composer_id = 87 AND part.part_key = 'musicbrainz:49c209c4-d4bb-3a97-b924-3974b294f849' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49c209c4-d4bb-3a97-b924-3974b294f849', 20, NULL, 'Act II. It''s Love (Reprise)', 'Wonderful Town: Act II. It''s Love (Reprise)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2287 AND p.composer_id = 87
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49c209c4-d4bb-3a97-b924-3974b294f849'
);


-- None 가곡 <Afterthought>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Afterthought>', 'Afterthought', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 87
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Afterthought>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '11038050-4425-4e7e-9243-b70e1d50752a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '11038050-4425-4e7e-9243-b70e1d50752a'
FROM pieces p
WHERE p.composer_id = 87 AND p.title = '가곡 <Afterthought>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '11038050-4425-4e7e-9243-b70e1d50752a'
);


-- None Chichester Psalms

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Chichester Psalms', 'Chichester Psalms', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 87
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Chichester Psalms'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9b986450-0ef9-4ec9-b5e8-fc04c03c164c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9b986450-0ef9-4ec9-b5e8-fc04c03c164c'
FROM pieces p
WHERE p.composer_id = 87 AND p.title = 'Chichester Psalms' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9b986450-0ef9-4ec9-b5e8-fc04c03c164c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a205c37c-7c45-39c5-8560-e0662309626c', 1, 'I', 'Psalm 108 verse 2, Psalm 100. Maestoso ma energico – Allegro molto', 'Chichester Psalms: I. Psalm 108 verse 2, Psalm 100. Maestoso ma energico – Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 87 AND p.title = 'Chichester Psalms' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a205c37c-7c45-39c5-8560-e0662309626c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00f84d9a-8f38-3261-ab8f-cbd897c722a7', 2, 'II', 'Psalm 23, Psalm 2 verses 1–4. Andante con moto, ma tranquillo – Allegro feroce', 'Chichester Psalms: II. Psalm 23, Psalm 2 verses 1–4. Andante con moto, ma tranquillo – Allegro feroce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 87 AND p.title = 'Chichester Psalms' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00f84d9a-8f38-3261-ab8f-cbd897c722a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15540161-5490-3aad-a6b4-0621b588492f', 3, 'III', 'Psalm 131, Psalm 133 verse 1. Prelude. Sostenuto molto – Peacefully flowing – Lento possible', 'Chichester Psalms: III. Psalm 131, Psalm 133 verse 1. Prelude. Sostenuto molto – Peacefully flowing – Lento possible', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 87 AND p.title = 'Chichester Psalms' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15540161-5490-3aad-a6b4-0621b588492f'
);


-- None Cool

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cool', 'Cool', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 87
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cool'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f8fdf05a-7a45-45ed-95fd-4b5f417f71ee'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f8fdf05a-7a45-45ed-95fd-4b5f417f71ee'
FROM pieces p
WHERE p.composer_id = 87 AND p.title = 'Cool' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f8fdf05a-7a45-45ed-95fd-4b5f417f71ee'
);


-- None 연가곡집 <La Bonne Cuisine (Four Recipes for Voice and Piano)>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <La Bonne Cuisine (Four Recipes for Voice and Piano)>', 'La Bonne Cuisine (Four Recipes for Voice and Piano)', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 87
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <La Bonne Cuisine (Four Recipes for Voice and Piano)>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b8533f89-0c40-44c4-9e7d-0c210232378b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b8533f89-0c40-44c4-9e7d-0c210232378b'
FROM pieces p
WHERE p.composer_id = 87 AND p.title = '연가곡집 <La Bonne Cuisine (Four Recipes for Voice and Piano)>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b8533f89-0c40-44c4-9e7d-0c210232378b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3d8f708-d9b6-42a7-87ab-7f08102348a6', 1, 'I', 'Plum Pudding', 'La Bonne Cuisine (Four Recipes for Voice and Piano): I. Plum Pudding', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 87 AND p.title = '연가곡집 <La Bonne Cuisine (Four Recipes for Voice and Piano)>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3d8f708-d9b6-42a7-87ab-7f08102348a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38cdb08c-36cb-4603-8d92-d53996e7b572', 2, 'II', 'Queues de bœuf (Oxtails)', 'La Bonne Cuisine (Four Recipes for Voice and Piano): II. Queues de bœuf (Oxtails)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 87 AND p.title = '연가곡집 <La Bonne Cuisine (Four Recipes for Voice and Piano)>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38cdb08c-36cb-4603-8d92-d53996e7b572'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a0ab037-ace1-4b00-a1fc-0266ecb28be3', 3, 'III', 'Tavouk Guenksis', 'La Bonne Cuisine (Four Recipes for Voice and Piano): III. Tavouk Guenksis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 87 AND p.title = '연가곡집 <La Bonne Cuisine (Four Recipes for Voice and Piano)>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a0ab037-ace1-4b00-a1fc-0266ecb28be3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba94db19-7400-4708-8a31-1fcb489de814', 4, 'IV', 'Civet à toute vitesse (Rabbit at Top Speed)', 'La Bonne Cuisine (Four Recipes for Voice and Piano): IV. Civet à toute vitesse (Rabbit at Top Speed)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 87 AND p.title = '연가곡집 <La Bonne Cuisine (Four Recipes for Voice and Piano)>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba94db19-7400-4708-8a31-1fcb489de814'
);


-- None On the Waterfront

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'On the Waterfront', 'On the Waterfront', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 87
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'On the Waterfront'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5e3f821d-6445-419f-8e43-a7f642aa3a83'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5e3f821d-6445-419f-8e43-a7f642aa3a83'
FROM pieces p
WHERE p.composer_id = 87 AND p.title = 'On the Waterfront' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5e3f821d-6445-419f-8e43-a7f642aa3a83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:528b3387-7693-4bed-aedd-eb87364cff41', 1, NULL, 'On the Waterfront', 'On the Waterfront', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 87 AND p.title = 'On the Waterfront' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:528b3387-7693-4bed-aedd-eb87364cff41'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e4762db-03c5-480d-9f90-914d9aa7bdc7', 2, NULL, 'Themes', 'On the Waterfront: Themes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 87 AND p.title = 'On the Waterfront' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e4762db-03c5-480d-9f90-914d9aa7bdc7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f265d544-c21d-37cc-b2be-550c276e190e', 3, NULL, 'Cab and Bedroom', 'On the Waterfront: Cab and Bedroom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 87 AND p.title = 'On the Waterfront' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f265d544-c21d-37cc-b2be-550c276e190e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcd78b55-58f2-4713-9065-34d82451ab39', 4, NULL, 'Love Theme', 'On the Waterfront: Love Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 87 AND p.title = 'On the Waterfront' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcd78b55-58f2-4713-9065-34d82451ab39'
);


-- 카탈로그에 대응이 없는 seed 작품 50개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 87 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    494, 585, 769, 779, 900, 918, 1031, 1103, 1298, 1333, 1381, 1409, 1459, 1465, 1470, 1494, 1617, 1657, 1690, 1713,
    1756, 1832, 1846, 1883, 1967, 1989, 2015, 2042, 2071, 2123, 2133, 2208, 2232, 2260, 2276, 2332, 2416, 2448, 2469, 2475,
    2581, 2591, 2695, 2771, 2888, 2900, 2937, 2943, 2971, 3016
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
