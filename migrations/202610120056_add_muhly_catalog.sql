-- 니코 멀리 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 194개(묶음 7, 다악장 7, 낱곡 180),
-- 새 작품 6개, part 70개, 그 아래 0개.
-- seed 234개 중 188개를 작품·part 에 잇고, 2개를 숨기고, 44개는 그대로 둔다.
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

-- None "And there they are—Rebecca. Fiona. Peter..."

UPDATE pieces piece
SET piece.title = '"And there they are—Rebecca. Fiona. Peter..."', piece.title_en = '"And there they are—Rebecca. Fiona. Peter..."',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17096 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None "Hey… I knew you wouldn't believe"

UPDATE pieces piece
SET piece.title = '"Hey… I knew you wouldn''t believe"', piece.title_en = '"Hey… I knew you wouldn''t believe"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16005 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None "I have to see you! / Ur in danger"

UPDATE pieces piece
SET piece.title = '"I have to see you! / Ur in danger"', piece.title_en = '"I have to see you! / Ur in danger"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19986 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None "Trick or treat!"

UPDATE pieces piece
SET piece.title = '"Trick or treat!"', piece.title_en = '"Trick or treat!"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16609 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 47 Days Old

UPDATE pieces piece
SET piece.title = '47 Days Old', piece.title_en = '47 Days Old',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16969 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Communist

UPDATE pieces piece
SET piece.title = 'A Communist', piece.title_en = 'A Communist',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16121 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <A Good Understanding>

UPDATE pieces piece
SET piece.title = '가곡 <A Good Understanding>', piece.title_en = 'A Good Understanding',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19242 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <A Great Stone>

UPDATE pieces piece
SET piece.title = '가곡 <A Great Stone>', piece.title_en = 'A Great Stone',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18965 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Hudson Cycle

UPDATE pieces piece
SET piece.title = 'A Hudson Cycle', piece.title_en = 'A Hudson Cycle',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18413 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Hymn on the Nativity

UPDATE pieces piece
SET piece.title = 'A Hymn on the Nativity', piece.title_en = 'A Hymn on the Nativity',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18769 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Lot to Say

UPDATE pieces piece
SET piece.title = 'A Lot to Say', piece.title_en = 'A Lot to Say',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18242 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Man Who Doesn’t Matter

UPDATE pieces piece
SET piece.title = 'A Man Who Doesn’t Matter', piece.title_en = 'A Man Who Doesn’t Matter',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17153 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A New Flame (after Sweelinck)

UPDATE pieces piece
SET piece.title = 'A New Flame (after Sweelinck)', piece.title_en = 'A New Flame (after Sweelinck)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19067 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Song of Ephrem the Syrian

UPDATE pieces piece
SET piece.title = 'A Song of Ephrem the Syrian', piece.title_en = 'A Song of Ephrem the Syrian',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17580 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Thief

UPDATE pieces piece
SET piece.title = 'A Thief', piece.title_en = 'A Thief',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16693 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Abalone Dive

UPDATE pieces piece
SET piece.title = 'Abalone Dive', piece.title_en = 'Abalone Dive',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18937 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Abyss

UPDATE pieces piece
SET piece.title = 'Abyss', piece.title_en = 'Abyss',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16440 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Advice to a Young Woman

UPDATE pieces piece
SET piece.title = 'Advice to a Young Woman', piece.title_en = 'Advice to a Young Woman',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16303 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None All a Front

UPDATE pieces piece
SET piece.title = 'All a Front', piece.title_en = 'All a Front',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20014 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Allen & Lucien

UPDATE pieces piece
SET piece.title = 'Allen & Lucien', piece.title_en = 'Allen & Lucien',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18388 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Americans

UPDATE pieces piece
SET piece.title = 'Americans', piece.title_en = 'Americans',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19090 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Appalling Umbrella

UPDATE pieces piece
SET piece.title = 'Appalling Umbrella', piece.title_en = 'Appalling Umbrella',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18888 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Balance Problems

UPDATE pieces piece
SET piece.title = 'Balance Problems', piece.title_en = 'Balance Problems',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16383 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bast Appears

UPDATE pieces piece
SET piece.title = 'Bast Appears', piece.title_en = 'Bast Appears',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16793 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bast's Death

UPDATE pieces piece
SET piece.title = 'Bast''s Death', piece.title_en = 'Bast''s Death',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19944 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Beaming Music

UPDATE pieces piece
SET piece.title = 'Beaming Music', piece.title_en = 'Beaming Music',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18964 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Benedicite Recitation

UPDATE pieces piece
SET piece.title = 'Benedicite Recitation', piece.title_en = 'Benedicite Recitation',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16000 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Berceuse with Seven Variations

UPDATE pieces piece
SET piece.title = 'Berceuse with Seven Variations', piece.title_en = 'Berceuse with Seven Variations',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18571 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Cycle', part.name_en = 'Berceuse with Seven Variations: Cycle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18571 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:583bc70d-8ab2-4c74-a49f-86712df91467' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:583bc70d-8ab2-4c74-a49f-86712df91467', 1, NULL, 'Cycle', 'Berceuse with Seven Variations: Cycle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18571 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:583bc70d-8ab2-4c74-a49f-86712df91467'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'First Berceuse', part.name_en = 'Berceuse with Seven Variations: First Berceuse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18571 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:a09ad1d8-017e-4091-be0c-2aaa9a1b68ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a09ad1d8-017e-4091-be0c-2aaa9a1b68ef', 2, NULL, 'First Berceuse', 'Berceuse with Seven Variations: First Berceuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18571 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a09ad1d8-017e-4091-be0c-2aaa9a1b68ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Second Berceuse', part.name_en = 'Berceuse with Seven Variations: Second Berceuse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18571 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:1826c1fa-e6c4-4c4b-b620-dcd2774d4aab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1826c1fa-e6c4-4c4b-b620-dcd2774d4aab', 3, NULL, 'Second Berceuse', 'Berceuse with Seven Variations: Second Berceuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18571 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1826c1fa-e6c4-4c4b-b620-dcd2774d4aab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scattershot', part.name_en = 'Berceuse with Seven Variations: Scattershot',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18571 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:f00519aa-db59-4263-944a-f73a671a00f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f00519aa-db59-4263-944a-f73a671a00f9', 4, NULL, 'Scattershot', 'Berceuse with Seven Variations: Scattershot', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18571 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f00519aa-db59-4263-944a-f73a671a00f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Lilt', part.name_en = 'Berceuse with Seven Variations: Lilt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18571 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:c44f0ca7-59cf-4252-9cca-8830b2ecd84c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c44f0ca7-59cf-4252-9cca-8830b2ecd84c', 5, NULL, 'Lilt', 'Berceuse with Seven Variations: Lilt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18571 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c44f0ca7-59cf-4252-9cca-8830b2ecd84c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Stutter', part.name_en = 'Berceuse with Seven Variations: Stutter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18571 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:4c855b89-ce99-49e8-a0b2-863e59789a00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c855b89-ce99-49e8-a0b2-863e59789a00', 6, NULL, 'Stutter', 'Berceuse with Seven Variations: Stutter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18571 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c855b89-ce99-49e8-a0b2-863e59789a00'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Coda', part.name_en = 'Berceuse with Seven Variations: Coda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18571 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:6f698d0a-ab1c-4b61-94a6-136d49210f3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f698d0a-ab1c-4b61-94a6-136d49210f3e', 7, NULL, 'Coda', 'Berceuse with Seven Variations: Coda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18571 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f698d0a-ab1c-4b61-94a6-136d49210f3e'
);


-- None Body in Water

UPDATE pieces piece
SET piece.title = 'Body in Water', piece.title_en = 'Body in Water',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17982 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Books

UPDATE pieces piece
SET piece.title = 'Books', piece.title_en = 'Books',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18594 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bridge of Tears

UPDATE pieces piece
SET piece.title = 'Bridge of Tears', piece.title_en = 'Bridge of Tears',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18705 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bright Mass with Canons

UPDATE pieces piece
SET piece.title = 'Bright Mass with Canons', piece.title_en = 'Bright Mass with Canons',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18352 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bright Star Carol

UPDATE pieces piece
SET piece.title = 'Bright Star Carol', piece.title_en = 'Bright Star Carol',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19894 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Buster

UPDATE pieces piece
SET piece.title = 'Buster', piece.title_en = 'Buster',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16909 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None By All Means

UPDATE pieces piece
SET piece.title = 'By All Means', piece.title_en = 'By All Means',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17506 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Choking

UPDATE pieces piece
SET piece.title = 'Choking', piece.title_en = 'Choking',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17587 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Christmas Shopping

UPDATE pieces piece
SET piece.title = 'Christmas Shopping', piece.title_en = 'Christmas Shopping',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19178 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Clear Music

UPDATE pieces piece
SET piece.title = 'Clear Music', piece.title_en = 'Clear Music',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19606 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Columbia

UPDATE pieces piece
SET piece.title = 'Columbia', piece.title_en = 'Columbia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18376 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Come Back Safe

UPDATE pieces piece
SET piece.title = 'Come Back Safe', piece.title_en = 'Come Back Safe',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17732 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Comfortable Cruising Altitude

UPDATE pieces piece
SET piece.title = 'Comfortable Cruising Altitude', piece.title_en = 'Comfortable Cruising Altitude',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16968 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Control (Five Landscapes for Orchestra)

UPDATE pieces piece
SET piece.title = 'Control (Five Landscapes for Orchestra)', piece.title_en = 'Control (Five Landscapes for Orchestra)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18309 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Landform', part.name_en = 'Control (Five Landscapes for Orchestra): No. 1. Landform',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18309 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:c477234c-bd63-498a-b82b-e6847f540d53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c477234c-bd63-498a-b82b-e6847f540d53', 1, NULL, 'Landform', 'Control (Five Landscapes for Orchestra): No. 1. Landform', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18309 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c477234c-bd63-498a-b82b-e6847f540d53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Mountain', part.name_en = 'Control (Five Landscapes for Orchestra): No. 2. Mountain',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18309 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:97ff7a5b-b328-4cfb-bd04-729e63a077e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97ff7a5b-b328-4cfb-bd04-729e63a077e8', 2, NULL, 'Mountain', 'Control (Five Landscapes for Orchestra): No. 2. Mountain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18309 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97ff7a5b-b328-4cfb-bd04-729e63a077e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Beehive', part.name_en = 'Control (Five Landscapes for Orchestra): No. 3. Beehive',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18309 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:ce51b8c8-308c-46d4-b4ae-3ad8df22dbc8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce51b8c8-308c-46d4-b4ae-3ad8df22dbc8', 3, NULL, 'Beehive', 'Control (Five Landscapes for Orchestra): No. 3. Beehive', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18309 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce51b8c8-308c-46d4-b4ae-3ad8df22dbc8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Petroglyph & Tobacco', part.name_en = 'Control (Five Landscapes for Orchestra): No. 4. Petroglyph & Tobacco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18309 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:4dbc49f3-e47a-443b-a584-3853572c2765' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4dbc49f3-e47a-443b-a584-3853572c2765', 4, NULL, 'Petroglyph & Tobacco', 'Control (Five Landscapes for Orchestra): No. 4. Petroglyph & Tobacco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18309 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dbc49f3-e47a-443b-a584-3853572c2765'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Red Dust', part.name_en = 'Control (Five Landscapes for Orchestra): No. 5. Red Dust',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18309 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:448235fc-98fc-4002-bfa7-a26ecc29b9cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:448235fc-98fc-4002-bfa7-a26ecc29b9cd', 5, NULL, 'Red Dust', 'Control (Five Landscapes for Orchestra): No. 5. Red Dust', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18309 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:448235fc-98fc-4002-bfa7-a26ecc29b9cd'
);


-- None Credits

UPDATE pieces piece
SET piece.title = 'Credits', piece.title_en = 'Credits',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18425 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cycling Holiday

UPDATE pieces piece
SET piece.title = 'Cycling Holiday', piece.title_en = 'Cycling Holiday',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19550 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Demolished House

UPDATE pieces piece
SET piece.title = 'Demolished House', piece.title_en = 'Demolished House',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19773 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Doublespeak

UPDATE pieces piece
SET piece.title = 'Doublespeak', piece.title_en = 'Doublespeak',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18320 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Drones and Viola da Gamba

UPDATE pieces piece
SET piece.title = 'Drones and Viola da Gamba', piece.title_en = 'Drones and Viola da Gamba',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19033 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Drones in Large Cycles

UPDATE pieces piece
SET piece.title = 'Drones in Large Cycles', piece.title_en = 'Drones in Large Cycles',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19087 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Drones, Variations, Ornaments

UPDATE pieces piece
SET piece.title = 'Drones, Variations, Ornaments', piece.title_en = 'Drones, Variations, Ornaments',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18503 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 2중창 1번 "Chorale Pointing Downwards"

UPDATE pieces piece
SET piece.title = '2중창 1번 "Chorale Pointing Downwards"', piece.title_en = 'Duet no. 1 "Chorale Pointing Downwards"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18170 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Eiris, Sones

UPDATE pieces piece
SET piece.title = 'Eiris, Sones', piece.title_en = 'Eiris, Sones',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19964 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Empty House

UPDATE pieces piece
SET piece.title = 'Empty House', piece.title_en = 'Empty House',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19222 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Endless Space

UPDATE pieces piece
SET piece.title = 'Endless Space', piece.title_en = 'Endless Space',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16902 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡 3번 "Running"

UPDATE pieces piece
SET piece.title = '연습곡 3번 "Running"', piece.title_en = 'Etude no. 3 "Running"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17787 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fairy Tales

UPDATE pieces piece
SET piece.title = 'Fairy Tales', piece.title_en = 'Fairy Tales',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18052 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fast Cycles

UPDATE pieces piece
SET piece.title = 'Fast Cycles', piece.title_en = 'Fast Cycles',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17850 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fast Dances

UPDATE pieces piece
SET piece.title = 'Fast Dances', piece.title_en = 'Fast Dances',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16881 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Fast Dances: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16881 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:48547682-4b73-4768-9f70-2b660321a7e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48547682-4b73-4768-9f70-2b660321a7e2', 1, NULL, 'No. 1', 'Fast Dances: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16881 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48547682-4b73-4768-9f70-2b660321a7e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Fast Dances: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16881 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:9d0a456f-9348-416a-98fe-152faa30ace7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d0a456f-9348-416a-98fe-152faa30ace7', 2, NULL, 'No. 2', 'Fast Dances: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16881 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d0a456f-9348-416a-98fe-152faa30ace7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = 'Fast Dances: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16881 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:138f7e62-57b5-4b8f-a5b8-45ac80992e62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:138f7e62-57b5-4b8f-a5b8-45ac80992e62', 3, NULL, 'No. 3', 'Fast Dances: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16881 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:138f7e62-57b5-4b8f-a5b8-45ac80992e62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'No. 4', part.name_en = 'Fast Dances: No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16881 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:10493f20-d604-49b9-9691-420f8f3c9b77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10493f20-d604-49b9-9691-420f8f3c9b77', 4, NULL, 'No. 4', 'Fast Dances: No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16881 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10493f20-d604-49b9-9691-420f8f3c9b77'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'No. 5', part.name_en = 'Fast Dances: No. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16881 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:caf141e0-73a7-4593-9f3f-ccb648c6e210' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:caf141e0-73a7-4593-9f3f-ccb648c6e210', 5, NULL, 'No. 5', 'Fast Dances: No. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16881 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:caf141e0-73a7-4593-9f3f-ccb648c6e210'
);


-- None Final Call

UPDATE pieces piece
SET piece.title = 'Final Call', piece.title_en = 'Final Call',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17545 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Formula

UPDATE pieces piece
SET piece.title = 'Formula', piece.title_en = 'Formula',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18351 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Four Studies

UPDATE pieces piece
SET piece.title = 'Four Studies', piece.title_en = 'Four Studies',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18625 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Suspensions', part.name_en = 'Four Studies: I. Suspensions',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18625 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:56a831d2-58b0-47e7-bf63-ff61e96f0eb3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56a831d2-58b0-47e7-bf63-ff61e96f0eb3', 1, 'I', 'Suspensions', 'Four Studies: I. Suspensions', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18625 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56a831d2-58b0-47e7-bf63-ff61e96f0eb3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Fast Canons', part.name_en = 'Four Studies: II. Fast Canons',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18625 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:0877ed09-caab-4bd3-a61e-48f988148179' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0877ed09-caab-4bd3-a61e-48f988148179', 2, 'II', 'Fast Canons', 'Four Studies: II. Fast Canons', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18625 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0877ed09-caab-4bd3-a61e-48f988148179'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Slow Canons', part.name_en = 'Four Studies: III. Slow Canons',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18625 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:ad316516-b768-48be-8995-a8149246763e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad316516-b768-48be-8995-a8149246763e', 3, 'III', 'Slow Canons', 'Four Studies: III. Slow Canons', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18625 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad316516-b768-48be-8995-a8149246763e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Open Notes', part.name_en = 'Four Studies: IV. Open Notes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18625 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:2eb82542-6ad0-41b5-a5a0-a1ff01cee6d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2eb82542-6ad0-41b5-a5a0-a1ff01cee6d6', 4, 'IV', 'Open Notes', 'Four Studies: IV. Open Notes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18625 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2eb82542-6ad0-41b5-a5a0-a1ff01cee6d6'
);


-- None Four Traditional Songs

UPDATE pieces piece
SET piece.title = 'Four Traditional Songs', piece.title_en = 'Four Traditional Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18714 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'A Brisk Young Lad', part.name_en = 'Four Traditional Songs: No. 1. A Brisk Young Lad',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18714 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:aaccd56d-293e-4e48-a835-d616193b6ed0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aaccd56d-293e-4e48-a835-d616193b6ed0', 1, NULL, 'A Brisk Young Lad', 'Four Traditional Songs: No. 1. A Brisk Young Lad', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18714 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaccd56d-293e-4e48-a835-d616193b6ed0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Searching for Lambs', part.name_en = 'Four Traditional Songs: No. 2. Searching for Lambs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18714 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:7cbc63fe-0e1c-439b-9212-65174bde4d36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7cbc63fe-0e1c-439b-9212-65174bde4d36', 2, NULL, 'Searching for Lambs', 'Four Traditional Songs: No. 2. Searching for Lambs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18714 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cbc63fe-0e1c-439b-9212-65174bde4d36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Cruel Mother', part.name_en = 'Four Traditional Songs: No. 3. The Cruel Mother',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18714 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:07dec372-e3ef-41c8-b215-90fbd4f27484' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07dec372-e3ef-41c8-b215-90fbd4f27484', 3, NULL, 'The Cruel Mother', 'Four Traditional Songs: No. 3. The Cruel Mother', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18714 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07dec372-e3ef-41c8-b215-90fbd4f27484'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'The Bitter Withy', part.name_en = 'Four Traditional Songs: No. 4. The Bitter Withy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18714 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:28696039-fb66-45a1-8267-5aca6a6e742d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28696039-fb66-45a1-8267-5aca6a6e742d', 4, NULL, 'The Bitter Withy', 'Four Traditional Songs: No. 4. The Bitter Withy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18714 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28696039-fb66-45a1-8267-5aca6a6e742d'
);


-- None Fourteen Years

UPDATE pieces piece
SET piece.title = 'Fourteen Years', piece.title_en = 'Fourteen Years',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18653 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Funeral

UPDATE pieces piece
SET piece.title = 'Funeral', piece.title_en = 'Funeral',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17362 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gait

UPDATE pieces piece
SET piece.title = 'Gait', piece.title_en = 'Gait',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19828 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Genshikaku Bakudan

UPDATE pieces piece
SET piece.title = 'Genshikaku Bakudan', piece.title_en = 'Genshikaku Bakudan',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17318 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Go Back to Your Friends

UPDATE pieces piece
SET piece.title = 'Go Back to Your Friends', piece.title_en = 'Go Back to Your Friends',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17178 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hana Calls

UPDATE pieces piece
SET piece.title = 'Hana Calls', piece.title_en = 'Hana Calls',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19519 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Handwriting

UPDATE pieces piece
SET piece.title = 'Handwriting', piece.title_en = 'Handwriting',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16122 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hansu Sees Sunja

UPDATE pieces piece
SET piece.title = 'Hansu Sees Sunja', piece.title_en = 'Hansu Sees Sunja',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16113 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Home Video

UPDATE pieces piece
SET piece.title = 'Home Video', piece.title_en = 'Home Video',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17133 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Honest Music

UPDATE pieces piece
SET piece.title = 'Honest Music', piece.title_en = 'Honest Music',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18021 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None How About Now

UPDATE pieces piece
SET piece.title = 'How About Now', piece.title_en = 'How About Now',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18779 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hudson Preludes

UPDATE pieces piece
SET piece.title = 'Hudson Preludes', piece.title_en = 'Hudson Preludes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20088 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Take Care', part.name_en = 'Hudson Preludes: I. Take Care',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20088 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:06558845-1cb1-4a93-b2f3-d7daa421b61e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06558845-1cb1-4a93-b2f3-d7daa421b61e', 1, 'I', 'Take Care', 'Hudson Preludes: I. Take Care', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20088 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06558845-1cb1-4a93-b2f3-d7daa421b61e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Follow Up', part.name_en = 'Hudson Preludes: II. Follow Up',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20088 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:40edd547-75f1-42fa-be76-23b3b5f976ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40edd547-75f1-42fa-be76-23b3b5f976ba', 2, 'II', 'Follow Up', 'Hudson Preludes: II. Follow Up', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20088 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40edd547-75f1-42fa-be76-23b3b5f976ba'
);


-- None I Cannot Attain Unto It

UPDATE pieces piece
SET piece.title = 'I Cannot Attain Unto It', piece.title_en = 'I Cannot Attain Unto It',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18179 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None I Have No One Else to Ask

UPDATE pieces piece
SET piece.title = 'I Have No One Else to Ask', piece.title_en = 'I Have No One Else to Ask',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18419 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None I Have To Die

UPDATE pieces piece
SET piece.title = 'I Have To Die', piece.title_en = 'I Have To Die',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18796 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None I Know

UPDATE pieces piece
SET piece.title = 'I Know', piece.title_en = 'I Know',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19816 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Impossible Things

UPDATE pieces piece
SET piece.title = 'Impossible Things', piece.title_en = 'Impossible Things',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17829 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Part III: 27 June 1906, 2pm; Impossible Things', part.name_en = 'Impossible Things: Part III: 27 June 1906, 2pm; Impossible Things',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17829 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:011430d9-3109-442e-a7c8-30059022a2e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:011430d9-3109-442e-a7c8-30059022a2e6', 1, NULL, 'Part III: 27 June 1906, 2pm; Impossible Things', 'Impossible Things: Part III: 27 June 1906, 2pm; Impossible Things', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17829 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:011430d9-3109-442e-a7c8-30059022a2e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Part II: September of 1903, January of 1904', part.name_en = 'Impossible Things: Part II: September of 1903, January of 1904',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17829 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:4b12ecb2-d6c2-4f9f-a877-f220813895ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b12ecb2-d6c2-4f9f-a877-f220813895ff', 2, NULL, 'Part II: September of 1903, January of 1904', 'Impossible Things: Part II: September of 1903, January of 1904', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17829 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b12ecb2-d6c2-4f9f-a877-f220813895ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Part I: The Hereafter, Near an Open Window', part.name_en = 'Impossible Things: Part I: The Hereafter, Near an Open Window',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17829 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:c68f176c-390c-409a-87f9-2845a13074b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c68f176c-390c-409a-87f9-2845a13074b4', 3, NULL, 'Part I: The Hereafter, Near an Open Window', 'Impossible Things: Part I: The Hereafter, Near an Open Window', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17829 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c68f176c-390c-409a-87f9-2845a13074b4'
);


-- None In a Mist

UPDATE pieces piece
SET piece.title = 'In a Mist', piece.title_en = 'In a Mist',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17405 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Innsbruck

UPDATE pieces piece
SET piece.title = 'Innsbruck', piece.title_en = 'Innsbruck',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16257 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Inward Things>

UPDATE pieces piece
SET piece.title = '가곡 <Inward Things>', piece.title_en = 'Inward Things',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16583 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Irredeemable

UPDATE pieces piece
SET piece.title = 'Irredeemable', piece.title_en = 'Irredeemable',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16160 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Isak Arrested

UPDATE pieces piece
SET piece.title = 'Isak Arrested', piece.title_en = 'Isak Arrested',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17943 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Isak Taken

UPDATE pieces piece
SET piece.title = 'Isak Taken', piece.title_en = 'Isak Taken',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19554 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None It Goes Without Saying

UPDATE pieces piece
SET piece.title = 'It Goes Without Saying', piece.title_en = 'It Goes Without Saying',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19097 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None It's Delightful

UPDATE pieces piece
SET piece.title = 'It''s Delightful', piece.title_en = 'It''s Delightful',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18740 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None It's Not Just About You

UPDATE pieces piece
SET piece.title = 'It''s Not Just About You', piece.title_en = 'It''s Not Just About You',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18359 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None I’m Home

UPDATE pieces piece
SET piece.title = 'I’m Home', piece.title_en = 'I’m Home',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17099 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Joshua Hiding

UPDATE pieces piece
SET piece.title = 'Joshua Hiding', piece.title_en = 'Joshua Hiding',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16099 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Keep In Touch

UPDATE pieces piece
SET piece.title = 'Keep In Touch', piece.title_en = 'Keep In Touch',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15990 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Kimchi

UPDATE pieces piece
SET piece.title = 'Kimchi', piece.title_en = 'Kimchi',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18315 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Letter

UPDATE pieces piece
SET piece.title = 'Letter', piece.title_en = 'Letter',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19349 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Letters

UPDATE pieces piece
SET piece.title = 'Letters', piece.title_en = 'Letters',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16534 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Let’s Call Him Noa

UPDATE pieces piece
SET piece.title = 'Let’s Call Him Noa', piece.title_en = 'Let’s Call Him Noa',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19646 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Like as the Hart

UPDATE pieces piece
SET piece.title = 'Like as the Hart', piece.title_en = 'Like as the Hart',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17839 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Long Phrases for the Wilton Diptych

UPDATE pieces piece
SET piece.title = 'Long Phrases for the Wilton Diptych', piece.title_en = 'Long Phrases for the Wilton Diptych',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16080 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lorne Ys My Likinge

UPDATE pieces piece
SET piece.title = 'Lorne Ys My Likinge', piece.title_en = 'Lorne Ys My Likinge',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16282 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mail

UPDATE pieces piece
SET piece.title = 'Mail', piece.title_en = 'Mail',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17692 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Marnie>

UPDATE pieces piece
SET piece.title = '오페라 <Marnie>', piece.title_en = 'Marnie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16416 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Meeting

UPDATE pieces piece
SET piece.title = 'Meeting', piece.title_en = 'Meeting',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17739 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Miscommunication

UPDATE pieces piece
SET piece.title = 'Miscommunication', piece.title_en = 'Miscommunication',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17643 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mistress

UPDATE pieces piece
SET piece.title = 'Mistress', piece.title_en = 'Mistress',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17985 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mount Hiei Crazy Version

UPDATE pieces piece
SET piece.title = 'Mount Hiei Crazy Version', piece.title_en = 'Mount Hiei Crazy Version',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18266 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mount Hiei Rhythm Version

UPDATE pieces piece
SET piece.title = 'Mount Hiei Rhythm Version', piece.title_en = 'Mount Hiei Rhythm Version',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17076 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Move

UPDATE pieces piece
SET piece.title = 'Move', piece.title_en = 'Move',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16538 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mummification

UPDATE pieces piece
SET piece.title = 'Mummification', piece.title_en = 'Mummification',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19261 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mushrooms

UPDATE pieces piece
SET piece.title = 'Mushrooms', piece.title_en = 'Mushrooms',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16345 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None My Days

UPDATE pieces piece
SET piece.title = 'My Days', piece.title_en = 'My Days',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17981 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None My Dearest Boy

UPDATE pieces piece
SET piece.title = 'My Dearest Boy', piece.title_en = 'My Dearest Boy',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19682 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None New Baby

UPDATE pieces piece
SET piece.title = 'New Baby', piece.title_en = 'New Baby',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18838 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <New‐Made Tongue>

UPDATE pieces piece
SET piece.title = '가곡 <New‐Made Tongue>', piece.title_en = 'New‐Made Tongue',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19218 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Night Walk

UPDATE pieces piece
SET piece.title = 'Night Walk', piece.title_en = 'Night Walk',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20072 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Nobody Will Ever Love You

UPDATE pieces piece
SET piece.title = 'Nobody Will Ever Love You', piece.title_en = 'Nobody Will Ever Love You',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19681 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Not What I Expected

UPDATE pieces piece
SET piece.title = 'Not What I Expected', piece.title_en = 'Not What I Expected',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18175 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Okinawa Footage

UPDATE pieces piece
SET piece.title = 'Okinawa Footage', piece.title_en = 'Okinawa Footage',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17003 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Old Bones

UPDATE pieces piece
SET piece.title = 'Old Bones', piece.title_en = 'Old Bones',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16555 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opening

UPDATE pieces piece
SET piece.title = 'Opening', piece.title_en = 'Opening',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18389 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opening Cards

UPDATE pieces piece
SET piece.title = 'Opening Cards', piece.title_en = 'Opening Cards',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17410 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Osaka 1931 / Busan 1989

UPDATE pieces piece
SET piece.title = 'Osaka 1931 / Busan 1989', piece.title_en = 'Osaka 1931 / Busan 1989',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16139 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Packing

UPDATE pieces piece
SET piece.title = 'Packing', piece.title_en = 'Packing',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18760 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Pater noster>

UPDATE pieces piece
SET piece.title = '가곡 <Pater noster>', piece.title_en = 'Pater noster',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18407 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Piles of Books

UPDATE pieces piece
SET piece.title = 'Piles of Books', piece.title_en = 'Piles of Books',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18305 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pillaging Music

UPDATE pieces piece
SET piece.title = 'Pillaging Music', piece.title_en = 'Pillaging Music',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19390 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Plan on a Boat

UPDATE pieces piece
SET piece.title = 'Plan on a Boat', piece.title_en = 'Plan on a Boat',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15991 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pleasure Ground

UPDATE pieces piece
SET piece.title = 'Pleasure Ground', piece.title_en = 'Pleasure Ground',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16068 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Five minutes of admiration', part.name_en = 'Pleasure Ground: I. Five minutes of admiration',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16068 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:365a2f61-eeeb-4f17-830a-04660454b30d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:365a2f61-eeeb-4f17-830a-04660454b30d', 1, 'I', 'Five minutes of admiration', 'Pleasure Ground: I. Five minutes of admiration', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16068 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:365a2f61-eeeb-4f17-830a-04660454b30d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'I found still a great number', part.name_en = 'Pleasure Ground: II. I found still a great number',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16068 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:be108975-308d-49b5-8501-cb05f17f24e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be108975-308d-49b5-8501-cb05f17f24e9', 2, 'II', 'I found still a great number', 'Pleasure Ground: II. I found still a great number', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16068 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be108975-308d-49b5-8501-cb05f17f24e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The trees had grown thickly', part.name_en = 'Pleasure Ground: III. The trees had grown thickly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16068 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:6ad2f53b-37ea-4006-a2a0-78d6ad57248a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ad2f53b-37ea-4006-a2a0-78d6ad57248a', 3, 'III', 'The trees had grown thickly', 'Pleasure Ground: III. The trees had grown thickly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16068 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ad2f53b-37ea-4006-a2a0-78d6ad57248a'
);


-- None Pottery Studio

UPDATE pieces piece
SET piece.title = 'Pottery Studio', piece.title_en = 'Pottery Studio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16026 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Proposal

UPDATE pieces piece
SET piece.title = 'Proposal', piece.title_en = 'Proposal',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16034 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quiet Music

UPDATE pieces piece
SET piece.title = 'Quiet Music', piece.title_en = 'Quiet Music',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19929 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Reading

UPDATE pieces piece
SET piece.title = 'Reading', piece.title_en = 'Reading',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18762 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Recordare, Domine>

UPDATE pieces piece
SET piece.title = '가곡 <Recordare, Domine>', piece.title_en = 'Recordare, Domine',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16726 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Refine

UPDATE pieces piece
SET piece.title = 'Refine', piece.title_en = 'Refine',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19857 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rubble

UPDATE pieces piece
SET piece.title = 'Rubble', piece.title_en = 'Rubble',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19232 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Runs to Setsu

UPDATE pieces piece
SET piece.title = 'Runs to Setsu', piece.title_en = 'Runs to Setsu',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16898 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scruples

UPDATE pieces piece
SET piece.title = 'Scruples', piece.title_en = 'Scruples',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18060 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sea Side

UPDATE pieces piece
SET piece.title = 'Sea Side', piece.title_en = 'Sea Side',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19111 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Seeing Is Believing

UPDATE pieces piece
SET piece.title = 'Seeing Is Believing', piece.title_en = 'Seeing Is Believing',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16937 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Self-Defense

UPDATE pieces piece
SET piece.title = 'Self-Defense', piece.title_en = 'Self-Defense',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18755 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Senex puerum portabat

UPDATE pieces piece
SET piece.title = 'Senex puerum portabat', piece.title_en = 'Senex puerum portabat',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18784 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sentimental Reasons

UPDATE pieces piece
SET piece.title = 'Sentimental Reasons', piece.title_en = 'Sentimental Reasons',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17429 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Set Me as a Seal>

UPDATE pieces piece
SET piece.title = '가곡 <Set Me as a Seal>', piece.title_en = 'Set Me as a Seal',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16986 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Seth and Apep

UPDATE pieces piece
SET piece.title = 'Seth and Apep', piece.title_en = 'Seth and Apep',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20044 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Seven O Antiphon Preludes

UPDATE pieces piece
SET piece.title = 'Seven O Antiphon Preludes', piece.title_en = 'Seven O Antiphon Preludes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19164 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'O Sapientia', part.name_en = 'Seven O Antiphon Preludes: I. O Sapientia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19164 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:1e9b7124-11fd-49a9-b774-ef6c8a25717d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e9b7124-11fd-49a9-b774-ef6c8a25717d', 1, 'I', 'O Sapientia', 'Seven O Antiphon Preludes: I. O Sapientia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19164 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e9b7124-11fd-49a9-b774-ef6c8a25717d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'O Adonai', part.name_en = 'Seven O Antiphon Preludes: II. O Adonai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19164 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:e28a2852-b756-41d3-b8e4-1f3bd7a8c2a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e28a2852-b756-41d3-b8e4-1f3bd7a8c2a9', 2, 'II', 'O Adonai', 'Seven O Antiphon Preludes: II. O Adonai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19164 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e28a2852-b756-41d3-b8e4-1f3bd7a8c2a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'O Radix Jesse', part.name_en = 'Seven O Antiphon Preludes: III. O Radix Jesse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19164 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:4a52b72c-2b65-49e7-91c2-ac71dcb44230' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a52b72c-2b65-49e7-91c2-ac71dcb44230', 3, 'III', 'O Radix Jesse', 'Seven O Antiphon Preludes: III. O Radix Jesse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19164 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a52b72c-2b65-49e7-91c2-ac71dcb44230'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'O Clavis David', part.name_en = 'Seven O Antiphon Preludes: IV. O Clavis David',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19164 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:f072c00e-16d6-48e3-9fae-61631b52330f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f072c00e-16d6-48e3-9fae-61631b52330f', 4, 'IV', 'O Clavis David', 'Seven O Antiphon Preludes: IV. O Clavis David', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19164 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f072c00e-16d6-48e3-9fae-61631b52330f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'O Oriens', part.name_en = 'Seven O Antiphon Preludes: V. O Oriens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19164 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:c96e3706-270d-49c3-a25d-836cf48d789f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c96e3706-270d-49c3-a25d-836cf48d789f', 5, 'V', 'O Oriens', 'Seven O Antiphon Preludes: V. O Oriens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19164 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c96e3706-270d-49c3-a25d-836cf48d789f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'O Rex Gentium', part.name_en = 'Seven O Antiphon Preludes: VI. O Rex Gentium',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19164 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:13ff27ca-f034-4adc-afa8-3d1aefc1e270' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13ff27ca-f034-4adc-afa8-3d1aefc1e270', 6, 'VI', 'O Rex Gentium', 'Seven O Antiphon Preludes: VI. O Rex Gentium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19164 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13ff27ca-f034-4adc-afa8-3d1aefc1e270'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'O Emmanuel', part.name_en = 'Seven O Antiphon Preludes: VII. O Emmanuel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19164 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:07abdbff-960c-44cb-ab54-a4160c1a591f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07abdbff-960c-44cb-ab54-a4160c1a591f', 7, 'VII', 'O Emmanuel', 'Seven O Antiphon Preludes: VII. O Emmanuel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19164 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07abdbff-960c-44cb-ab54-a4160c1a591f'
);


-- None She's Made a Mistake

UPDATE pieces piece
SET piece.title = 'She''s Made a Mistake', piece.title_en = 'She''s Made a Mistake',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18663 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Shrink

UPDATE pieces piece
SET piece.title = 'Shrink', piece.title_en = 'Shrink',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19292 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'III',
    part.name_ko = 'Turns', part.name_en = 'Shrink: III. Turns',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19292 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:1371623c-a485-48ea-8b33-436144c4ed08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1371623c-a485-48ea-8b33-436144c4ed08', 1, 'III', 'Turns', 'Shrink: III. Turns', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19292 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1371623c-a485-48ea-8b33-436144c4ed08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sixths', part.name_en = 'Shrink: II. Sixths',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19292 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:3b9638ec-3759-402c-aac5-4c0f16d979d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b9638ec-3759-402c-aac5-4c0f16d979d1', 2, 'II', 'Sixths', 'Shrink: II. Sixths', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19292 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b9638ec-3759-402c-aac5-4c0f16d979d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'I',
    part.name_ko = 'Ninths', part.name_en = 'Shrink: I. Ninths',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19292 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:65d8966e-539a-445f-a07a-c6f2bee4a926' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65d8966e-539a-445f-a07a-c6f2bee4a926', 3, 'I', 'Ninths', 'Shrink: I. Ninths', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19292 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65d8966e-539a-445f-a07a-c6f2bee4a926'
);


-- None Shu In The Water

UPDATE pieces piece
SET piece.title = 'Shu In The Water', piece.title_en = 'Shu In The Water',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18522 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Side Piece

UPDATE pieces piece
SET piece.title = 'Side Piece', piece.title_en = 'Side Piece',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16473 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Slow Twitchy Organs

UPDATE pieces piece
SET piece.title = 'Slow Twitchy Organs', piece.title_en = 'Slow Twitchy Organs',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18090 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None So Many Things

UPDATE pieces piece
SET piece.title = 'So Many Things', piece.title_en = 'So Many Things',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18775 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sophie / The Lady With the Little Dog

UPDATE pieces piece
SET piece.title = 'Sophie / The Lady With the Little Dog', piece.title_en = 'Sophie / The Lady With the Little Dog',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18656 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Spying

UPDATE pieces piece
SET piece.title = 'Spying', piece.title_en = 'Spying',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17012 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Stampede

UPDATE pieces piece
SET piece.title = 'Stampede', piece.title_en = 'Stampede',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18235 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Step Team

UPDATE pieces piece
SET piece.title = 'Step Team', piece.title_en = 'Step Team',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16182 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Stranger

UPDATE pieces piece
SET piece.title = 'Stranger', piece.title_en = 'Stranger',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17810 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'III',
    part.name_ko = 'All Men', part.name_en = 'Stranger: III. All Men',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17810 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:4e4c8968-f93c-425f-9bdc-af84a55d1564' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e4c8968-f93c-425f-9bdc-af84a55d1564', 1, 'III', 'All Men', 'Stranger: III. All Men', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17810 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e4c8968-f93c-425f-9bdc-af84a55d1564'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ellis Island', part.name_en = 'Stranger: II. Ellis Island',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17810 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:9b5b2884-150b-4423-84d9-127cc4d092c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b5b2884-150b-4423-84d9-127cc4d092c0', 2, 'II', 'Ellis Island', 'Stranger: II. Ellis Island', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17810 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b5b2884-150b-4423-84d9-127cc4d092c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'V',
    part.name_ko = 'Threats & Intimidations', part.name_en = 'Stranger: V. Threats & Intimidations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17810 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:a89891b4-f67b-4db0-9e46-f1ea7f61dff9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a89891b4-f67b-4db0-9e46-f1ea7f61dff9', 3, 'V', 'Threats & Intimidations', 'Stranger: V. Threats & Intimidations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17810 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a89891b4-f67b-4db0-9e46-f1ea7f61dff9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'VII',
    part.name_ko = 'My Love', part.name_en = 'Stranger: VII. My Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17810 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:d72411bf-245b-464b-b0a4-58fb0cc11dce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d72411bf-245b-464b-b0a4-58fb0cc11dce', 4, 'VII', 'My Love', 'Stranger: VII. My Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17810 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d72411bf-245b-464b-b0a4-58fb0cc11dce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'VI',
    part.name_ko = 'Everyone Cries', part.name_en = 'Stranger: VI. Everyone Cries',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17810 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:e18a22e3-91e0-4a9e-bb00-d74cc74cd2e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e18a22e3-91e0-4a9e-bb00-d74cc74cd2e1', 5, 'VI', 'Everyone Cries', 'Stranger: VI. Everyone Cries', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17810 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e18a22e3-91e0-4a9e-bb00-d74cc74cd2e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'I',
    part.name_ko = 'Fragments of the Past', part.name_en = 'Stranger: I. Fragments of the Past',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17810 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:e4fbdf99-b770-48b7-ae78-eda9e3fd1b84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4fbdf99-b770-48b7-ae78-eda9e3fd1b84', 6, 'I', 'Fragments of the Past', 'Stranger: I. Fragments of the Past', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17810 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4fbdf99-b770-48b7-ae78-eda9e3fd1b84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'IV',
    part.name_ko = 'Leviticus 19:34', part.name_en = 'Stranger: IV. Leviticus 19:34',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17810 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:fc6a78b8-4a25-4380-a45a-7422db70f118' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc6a78b8-4a25-4380-a45a-7422db70f118', 7, 'IV', 'Leviticus 19:34', 'Stranger: IV. Leviticus 19:34', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17810 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc6a78b8-4a25-4380-a45a-7422db70f118'
);


-- None Tambourin

UPDATE pieces piece
SET piece.title = 'Tambourin', piece.title_en = 'Tambourin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18357 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Textbook Abuse

UPDATE pieces piece
SET piece.title = 'Textbook Abuse', piece.title_en = 'Textbook Abuse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18624 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None That's Decided

UPDATE pieces piece
SET piece.title = 'That''s Decided', piece.title_en = 'That''s Decided',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16148 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Cove

UPDATE pieces piece
SET piece.title = 'The Cove', piece.title_en = 'The Cove',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19071 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Egg

UPDATE pieces piece
SET piece.title = 'The Egg', piece.title_en = 'The Egg',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16309 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Failed Visit

UPDATE pieces piece
SET piece.title = 'The Failed Visit', piece.title_en = 'The Failed Visit',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18057 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The First Bath

UPDATE pieces piece
SET piece.title = 'The First Bath', piece.title_en = 'The First Bath',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19320 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Fishermen

UPDATE pieces piece
SET piece.title = 'The Fishermen', piece.title_en = 'The Fishermen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18843 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Library

UPDATE pieces piece
SET piece.title = 'The Library', piece.title_en = 'The Library',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19980 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Mudang

UPDATE pieces piece
SET piece.title = 'The Mudang', piece.title_en = 'The Mudang',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19113 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Murder

UPDATE pieces piece
SET piece.title = 'The Murder', piece.title_en = 'The Murder',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18267 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Park

UPDATE pieces piece
SET piece.title = 'The Park', piece.title_en = 'The Park',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17480 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Revd Mustard his Installation Prelude

UPDATE pieces piece
SET piece.title = 'The Revd Mustard his Installation Prelude', piece.title_en = 'The Revd Mustard his Installation Prelude',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16089 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None They're Starving

UPDATE pieces piece
SET piece.title = 'They''re Starving', piece.title_en = 'They''re Starving',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17310 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None This Reminds Me

UPDATE pieces piece
SET piece.title = 'This Reminds Me', piece.title_en = 'This Reminds Me',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17475 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Three Moon Songs

UPDATE pieces piece
SET piece.title = 'Three Moon Songs', piece.title_en = 'Three Moon Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18420 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Harlequin', part.name_en = 'Three Moon Songs: No. 1. Harlequin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18420 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:7ede8456-19f5-491b-851b-a6595d438a8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ede8456-19f5-491b-851b-a6595d438a8f', 1, NULL, 'Harlequin', 'Three Moon Songs: No. 1. Harlequin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18420 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ede8456-19f5-491b-851b-a6595d438a8f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Moondrunk', part.name_en = 'Three Moon Songs: No. 2. Moondrunk',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18420 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:329136d2-cdbb-4b59-9667-ff4c6737caa5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:329136d2-cdbb-4b59-9667-ff4c6737caa5', 2, NULL, 'Moondrunk', 'Three Moon Songs: No. 2. Moondrunk', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18420 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:329136d2-cdbb-4b59-9667-ff4c6737caa5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Alphabet', part.name_en = 'Three Moon Songs: No. 3. The Alphabet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18420 AND p.composer_id = 293 AND part.part_key = 'musicbrainz:3fa6bdd0-6c92-4c80-be4b-5dfa2adc3af6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fa6bdd0-6c92-4c80-be4b-5dfa2adc3af6', 3, NULL, 'The Alphabet', 'Three Moon Songs: No. 3. The Alphabet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18420 AND p.composer_id = 293
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fa6bdd0-6c92-4c80-be4b-5dfa2adc3af6'
);


-- None Through the Ceiling

UPDATE pieces piece
SET piece.title = 'Through the Ceiling', piece.title_en = 'Through the Ceiling',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18468 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tops

UPDATE pieces piece
SET piece.title = 'Tops', piece.title_en = 'Tops',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16053 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Train

UPDATE pieces piece
SET piece.title = 'Train', piece.title_en = 'Train',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19860 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tram at Dawn

UPDATE pieces piece
SET piece.title = 'Tram at Dawn', piece.title_en = 'Tram at Dawn',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17894 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Two Voices

UPDATE pieces piece
SET piece.title = 'Two Voices', piece.title_en = 'Two Voices',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16929 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Typing

UPDATE pieces piece
SET piece.title = 'Typing', piece.title_en = 'Typing',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19358 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Viola Concerto Part. I

UPDATE pieces piece
SET piece.title = 'Viola Concerto Part. I', piece.title_en = 'Viola Concerto Part. I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17646 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Viola Concerto Part. II

UPDATE pieces piece
SET piece.title = 'Viola Concerto Part. II', piece.title_en = 'Viola Concerto Part. II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18976 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Viola Concerto Part. III

UPDATE pieces piece
SET piece.title = 'Viola Concerto Part. III', piece.title_en = 'Viola Concerto Part. III',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17926 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None White Rice

UPDATE pieces piece
SET piece.title = 'White Rice', piece.title_en = 'White Rice',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19334 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Who Was She?

UPDATE pieces piece
SET piece.title = 'Who Was She?', piece.title_en = 'Who Was She?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16318 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Without a Body

UPDATE pieces piece
SET piece.title = 'Without a Body', piece.title_en = 'Without a Body',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18825 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Yellow, Fission & Title

UPDATE pieces piece
SET piece.title = 'Yellow, Fission & Title', piece.title_en = 'Yellow, Fission & Title',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19617 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None You Don't Matter

UPDATE pieces piece
SET piece.title = 'You Don''t Matter', piece.title_en = 'You Don''t Matter',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17832 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None You Haven’t Changed

UPDATE pieces piece
SET piece.title = 'You Haven’t Changed', piece.title_en = 'You Haven’t Changed',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18102 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Young Sunja

UPDATE pieces piece
SET piece.title = 'Young Sunja', piece.title_en = 'Young Sunja',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17322 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Your Words are Terrifying

UPDATE pieces piece
SET piece.title = 'Your Words are Terrifying', piece.title_en = 'Your Words are Terrifying',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16242 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Étude 1

UPDATE pieces piece
SET piece.title = 'Étude 1', piece.title_en = 'Étude 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16559 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Étude 1A

UPDATE pieces piece
SET piece.title = 'Étude 1A', piece.title_en = 'Étude 1A',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17073 AND piece.composer_id = 293
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 첼로 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로 협주곡', 'Cello Concerto', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 293
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9339e649-8c2e-49b2-82cd-d1cb9902775d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9339e649-8c2e-49b2-82cd-d1cb9902775d'
FROM pieces p
WHERE p.composer_id = 293 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9339e649-8c2e-49b2-82cd-d1cb9902775d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05489ba7-a067-4342-a663-3d06e2c74d23', 1, NULL, 'Part Three', 'Cello Concerto: Part Three', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05489ba7-a067-4342-a663-3d06e2c74d23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44321efb-c954-49b8-84fc-3243f544d74c', 2, NULL, 'Part Two', 'Cello Concerto: Part Two', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44321efb-c954-49b8-84fc-3243f544d74c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd56d86c-df96-4ef6-9f49-78687716d00a', 3, NULL, 'Part One', 'Cello Concerto: Part One', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd56d86c-df96-4ef6-9f49-78687716d00a'
);


-- None Hide and Seek

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Hide and Seek', 'Hide and Seek', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 293
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Hide and Seek'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3334b148-96e2-48c6-a3d8-3dee0f2e1882'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3334b148-96e2-48c6-a3d8-3dee0f2e1882'
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Hide and Seek' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3334b148-96e2-48c6-a3d8-3dee0f2e1882'
);


-- None Motion

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Motion', 'Motion', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 293
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Motion'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3b926475-a5cf-49f0-a59e-c5c4e08f7580'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3b926475-a5cf-49f0-a59e-c5c4e08f7580'
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Motion' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3b926475-a5cf-49f0-a59e-c5c4e08f7580'
);


-- None The Street

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Street', 'The Street', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 293
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Street'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6373eff-4e9c-4090-8b04-578c5459f1fa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd6373eff-4e9c-4090-8b04-578c5459f1fa'
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'The Street' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6373eff-4e9c-4090-8b04-578c5459f1fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10743231-74ac-4ccd-8a79-5fa31b923562', 1, NULL, 'Station XIII. Jesus is taken down from the Cross', 'The Street (full version): Station XIII. Jesus is taken down from the Cross', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'The Street' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10743231-74ac-4ccd-8a79-5fa31b923562'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:167146eb-0f85-4dbf-86a7-366a6b09c2d6', 2, NULL, 'Station XII. Jesus dies on the Cross', 'The Street (full version): Station XII. Jesus dies on the Cross', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'The Street' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:167146eb-0f85-4dbf-86a7-366a6b09c2d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1af5030e-b9bb-4758-bb61-6ada09401ce5', 3, NULL, 'Station IX. Jesus falls for the third time', 'The Street (full version): Station IX. Jesus falls for the third time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'The Street' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1af5030e-b9bb-4758-bb61-6ada09401ce5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d0a0aa7-6327-4279-8d6d-47f9c322ce04', 4, NULL, 'Station I. Jesus is condemned to death', 'The Street (full version): Station I. Jesus is condemned to death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'The Street' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d0a0aa7-6327-4279-8d6d-47f9c322ce04'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ac30fd9-d1cf-44a2-b701-f16b79d73675', 5, NULL, 'Station X. Jesus is stripped of his garments', 'The Street (full version): Station X. Jesus is stripped of his garments', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'The Street' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ac30fd9-d1cf-44a2-b701-f16b79d73675'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b9d64d0-eaff-4a1f-8554-dc3bf9682faa', 6, NULL, 'Station VII. Jesus falls for the second time', 'The Street (full version): Station VII. Jesus falls for the second time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'The Street' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b9d64d0-eaff-4a1f-8554-dc3bf9682faa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:845dec4a-0ff8-4a9e-9f95-18a56e74b6c7', 7, NULL, 'Station VI. Veronica wipes the face of Jesus', 'The Street (full version): Station VI. Veronica wipes the face of Jesus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'The Street' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:845dec4a-0ff8-4a9e-9f95-18a56e74b6c7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88f941c3-2e67-41bf-9925-a1bea3a78525', 8, NULL, 'Station XI. Jesus is nailed to the Cross', 'The Street (full version): Station XI. Jesus is nailed to the Cross', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'The Street' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88f941c3-2e67-41bf-9925-a1bea3a78525'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3f369de-632b-4808-a505-1812d6a3a1e3', 9, NULL, 'Station V. Simon of Cyrene helps Jesus carry the Cross', 'The Street (full version): Station V. Simon of Cyrene helps Jesus carry the Cross', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'The Street' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3f369de-632b-4808-a505-1812d6a3a1e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ceea3412-7a4e-4efe-b9c1-0de68ba7de9a', 10, NULL, 'Station VIII. Jesus meets the women of Jerusalem', 'The Street (full version): Station VIII. Jesus meets the women of Jerusalem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'The Street' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ceea3412-7a4e-4efe-b9c1-0de68ba7de9a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d777d490-49b4-472c-a0f4-f741358d9282', 11, NULL, 'Station XIV. Jesus is laid in the tomb', 'The Street (full version): Station XIV. Jesus is laid in the tomb', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'The Street' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d777d490-49b4-472c-a0f4-f741358d9282'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9848329-d501-4a87-9de4-4cfefa0a3a33', 12, NULL, 'Station III. Jesus falls for the first time', 'The Street (full version): Station III. Jesus falls for the first time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'The Street' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9848329-d501-4a87-9de4-4cfefa0a3a33'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f31f6634-00e8-4056-ae2e-885f4bec06fa', 13, NULL, 'Station II. Jesus takes up his Cross', 'The Street (full version): Station II. Jesus takes up his Cross', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'The Street' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f31f6634-00e8-4056-ae2e-885f4bec06fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffa6eb0b-ae4e-46e2-81ee-42ee0c912f83', 14, NULL, 'Station IV. Jesus meets his Mother', 'The Street (full version): Station IV. Jesus meets his Mother', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'The Street' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffa6eb0b-ae4e-46e2-81ee-42ee0c912f83'
);


-- None The Wedding

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Wedding', 'The Wedding', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 293
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Wedding'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c1361ff8-12ec-4527-b815-08ba2d3074c3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c1361ff8-12ec-4527-b815-08ba2d3074c3'
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'The Wedding' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c1361ff8-12ec-4527-b815-08ba2d3074c3'
);


-- None Verdict

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Verdict', 'Verdict', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 293
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Verdict'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cd93e509-566d-3d2f-9dc4-b5becdb2c20f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cd93e509-566d-3d2f-9dc4-b5becdb2c20f'
FROM pieces p
WHERE p.composer_id = 293 AND p.title = 'Verdict' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cd93e509-566d-3d2f-9dc4-b5becdb2c20f'
);


-- 카탈로그에 대응이 없는 seed 작품 2개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 293 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    17270, 17598
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
