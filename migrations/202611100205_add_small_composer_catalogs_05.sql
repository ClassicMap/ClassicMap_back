-- 작곡가 20명의 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동, 5/9).
-- 작품 70개(새 1개), seed 82개 중 잇기 69·숨김 10·그대로 3.
--
-- 6차는 4차 규칙(사람·에이전트 판단 없음)을 그대로 썼다. 규칙은
-- seed_pipeline/curation/catalog-wave4-2026-10-12/auto/auto_catalog.py, 작곡가별 자료는
-- seed_pipeline/curation/catalog-wave6-2026-11-10/<작곡가>/(catalog.json·seed_map.json).
--   작품: MusicBrainz 에서 이 작곡가가 composer 인 work 중 다른 work 의 part 가 아니고
--     편곡·다른 판·발췌·단편·리믹스 표시가 없는 것. part 는 MB parts 순서대로 두 겹까지.
--   제목: 「Symphony no. 5 in C minor」 꼴은 「교향곡 5번 C단조」로 옮기고,
--     못 읽으면 원제를 둔다(MB 갈래가 가곡·오페라 등이면 「가곡 <원제>」).
--   seed 작품: MBID 가 작품이면 그 자리(제목을 위 꼴로 고치고 잠금), part 면 part 로 잇고,
--     편곡·다른 판·중복·리믹스면 hidden_reason='catalog_unmatched' 로 숨긴다(지우지 않음).
--     판단이 서지 않는 seed 는 손대지 않고 보이게 둔다. 숨길 seed 가 카탈로그 제목을
--     쥐고 있으면 그 seed 제목 뒤에 까닭을 붙여 자리를 비운다(숨긴 작품이라 안 보임).
--   manual 작품: 제목·설명·링크는 바꾸지 않는다. MBID 가 엉뚱한 work 를 가리키면
--     (제목이 전혀 다름) 잇지 않고, MBID 가 없으면 영어 제목이 같은 작품에 잇는다
--     (식별자는 더하지 않음).
--   비교 구간이 있거나 part 가 가리키는 작품은 숨기지 않는다. 두 번 돌려도 같다.

-- ===== 오나카 메구미 (composer_id 289) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 0개(묶음 0, 다악장 0, 낱곡 0),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 6개 중 0개를 작품·part 에 잇고, 6개를 숨기고, 0개는 그대로 둔다.

-- 카탈로그에 대응이 없는 seed 작품 6개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 289 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    15723, 15742, 15830, 15925, 15927, 15929
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== 핫토리 다다시 (composer_id 292) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 2개 중 1개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.

-- None Sheep in the fields

UPDATE pieces piece
SET piece.title = 'Sheep in the fields', piece.title_en = 'Sheep in the fields',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16754 AND piece.composer_id = 292
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 292 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    15944
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Henry Brant (composer_id 295) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 19개(묶음 3, 다악장 2, 낱곡 14),
-- 새 작품 0개, part 42개, 그 아래 0개.
-- seed 19개 중 19개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None A Plan of the Air

UPDATE pieces piece
SET piece.title = 'A Plan of the Air', piece.title_en = 'A Plan of the Air',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16441 AND piece.composer_id = 295
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Angels and Devils

UPDATE pieces piece
SET piece.title = 'Angels and Devils', piece.title_en = 'Angels and Devils',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16120 AND piece.composer_id = 295
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Angels and Devils: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16120 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:3f0eb105-f95f-4708-bb61-b9468e86b1ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f0eb105-f95f-4708-bb61-b9468e86b1ee', 1, NULL, 'I', 'Angels and Devils: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16120 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f0eb105-f95f-4708-bb61-b9468e86b1ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Angels and Devils: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16120 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:c5d3ad0b-8c7c-4079-bfd7-4ad46e690ba6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5d3ad0b-8c7c-4079-bfd7-4ad46e690ba6', 2, NULL, 'II', 'Angels and Devils: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16120 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5d3ad0b-8c7c-4079-bfd7-4ad46e690ba6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Angels and Devils: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16120 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:a2f52e29-2456-4795-be78-8fbe0d09a4b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2f52e29-2456-4795-be78-8fbe0d09a4b8', 3, NULL, 'III', 'Angels and Devils: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16120 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2f52e29-2456-4795-be78-8fbe0d09a4b8'
);


-- None 칸타타 <Autumn Hurricanes>

UPDATE pieces piece
SET piece.title = '칸타타 <Autumn Hurricanes>', piece.title_en = 'Autumn Hurricanes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17757 AND piece.composer_id = 295
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'October 10, 1780. The Great Hurricane', part.name_en = 'Autumn Hurricanes: 1. October 10, 1780. The Great Hurricane',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17757 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:140ce038-f0f8-4670-9226-e762d6c0fdeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:140ce038-f0f8-4670-9226-e762d6c0fdeb', 1, NULL, 'October 10, 1780. The Great Hurricane', 'Autumn Hurricanes: 1. October 10, 1780. The Great Hurricane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17757 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:140ce038-f0f8-4670-9226-e762d6c0fdeb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'September 8, 1900. Galveston Bay', part.name_en = 'Autumn Hurricanes: 2. September 8, 1900. Galveston Bay',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17757 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:3c5bf947-0501-4c22-a358-75b0b8a6e45c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c5bf947-0501-4c22-a358-75b0b8a6e45c', 2, NULL, 'September 8, 1900. Galveston Bay', 'Autumn Hurricanes: 2. September 8, 1900. Galveston Bay', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17757 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c5bf947-0501-4c22-a358-75b0b8a6e45c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'September 16, 1828. Lake Okeechobee, Florida', part.name_en = 'Autumn Hurricanes: 3. September 16, 1828. Lake Okeechobee, Florida',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17757 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:14acfa32-70da-4014-aa30-9ac9f37bcaf0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14acfa32-70da-4014-aa30-9ac9f37bcaf0', 3, NULL, 'September 16, 1828. Lake Okeechobee, Florida', 'Autumn Hurricanes: 3. September 16, 1828. Lake Okeechobee, Florida', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17757 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14acfa32-70da-4014-aa30-9ac9f37bcaf0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Labor Day, 1935. Florida Keys', part.name_en = 'Autumn Hurricanes: 4. Labor Day, 1935. Florida Keys',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17757 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:ff7cf66b-098b-4f2d-9f66-e9cd166b4f43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff7cf66b-098b-4f2d-9f66-e9cd166b4f43', 4, NULL, 'Labor Day, 1935. Florida Keys', 'Autumn Hurricanes: 4. Labor Day, 1935. Florida Keys', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17757 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff7cf66b-098b-4f2d-9f66-e9cd166b4f43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'September 8 to 16, 1944. The Great Autumn Hurricane', part.name_en = 'Autumn Hurricanes: 5. September 8 to 16, 1944. The Great Autumn Hurricane',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17757 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:3601dc59-54bb-4365-bd79-b0e9f84f8171' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3601dc59-54bb-4365-bd79-b0e9f84f8171', 5, NULL, 'September 8 to 16, 1944. The Great Autumn Hurricane', 'Autumn Hurricanes: 5. September 8 to 16, 1944. The Great Autumn Hurricane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17757 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3601dc59-54bb-4365-bd79-b0e9f84f8171'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '1955. Eleven Hurricanes. Atlantic Coast', part.name_en = 'Autumn Hurricanes: 6. 1955. Eleven Hurricanes. Atlantic Coast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17757 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:706b762d-49a6-441e-b38c-17f7668d4bc3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:706b762d-49a6-441e-b38c-17f7668d4bc3', 6, NULL, '1955. Eleven Hurricanes. Atlantic Coast', 'Autumn Hurricanes: 6. 1955. Eleven Hurricanes. Atlantic Coast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17757 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:706b762d-49a6-441e-b38c-17f7668d4bc3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'September 7, 1967. Mexico', part.name_en = 'Autumn Hurricanes: 7. September 7, 1967. Mexico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17757 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:180957db-7be2-493d-8bfa-73cf3fd26f40' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:180957db-7be2-493d-8bfa-73cf3fd26f40', 7, NULL, 'September 7, 1967. Mexico', 'Autumn Hurricanes: 7. September 7, 1967. Mexico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17757 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:180957db-7be2-493d-8bfa-73cf3fd26f40'
);


-- None Galaxy 2

UPDATE pieces piece
SET piece.title = 'Galaxy 2', piece.title_en = 'Galaxy 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16231 AND piece.composer_id = 295
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ghost Nets

UPDATE pieces piece
SET piece.title = 'Ghost Nets', piece.title_en = 'Ghost Nets',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17602 AND piece.composer_id = 295
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ghosts and Gargoyles

UPDATE pieces piece
SET piece.title = 'Ghosts and Gargoyles', piece.title_en = 'Ghosts and Gargoyles',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16850 AND piece.composer_id = 295
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Ghosts and Gargoyles: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16850 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:e751f44c-f3a7-4df6-8dc5-5d9c08486f77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e751f44c-f3a7-4df6-8dc5-5d9c08486f77', 1, NULL, 'I', 'Ghosts and Gargoyles: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16850 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e751f44c-f3a7-4df6-8dc5-5d9c08486f77'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Ghosts and Gargoyles: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16850 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:ace4e7c8-8115-4608-a47e-66f554401d16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ace4e7c8-8115-4608-a47e-66f554401d16', 2, NULL, 'II', 'Ghosts and Gargoyles: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16850 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ace4e7c8-8115-4608-a47e-66f554401d16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Ghosts and Gargoyles: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16850 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:957901ef-17a9-4013-bddf-697d56496bcd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:957901ef-17a9-4013-bddf-697d56496bcd', 3, NULL, 'III', 'Ghosts and Gargoyles: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16850 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:957901ef-17a9-4013-bddf-697d56496bcd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Ghosts and Gargoyles: IV.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16850 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:c67d9f57-5a69-487f-98d7-47dfed0e1fd5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c67d9f57-5a69-487f-98d7-47dfed0e1fd5', 4, NULL, 'IV', 'Ghosts and Gargoyles: IV.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16850 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c67d9f57-5a69-487f-98d7-47dfed0e1fd5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'V', part.name_en = 'Ghosts and Gargoyles: V.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16850 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:72aaea53-0441-40d4-981a-3242f483d878' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72aaea53-0441-40d4-981a-3242f483d878', 5, NULL, 'V', 'Ghosts and Gargoyles: V.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16850 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72aaea53-0441-40d4-981a-3242f483d878'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'VI', part.name_en = 'Ghosts and Gargoyles: VI.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16850 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:90352845-479e-4b64-b3f6-de46ffc685e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90352845-479e-4b64-b3f6-de46ffc685e8', 6, NULL, 'VI', 'Ghosts and Gargoyles: VI.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16850 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90352845-479e-4b64-b3f6-de46ffc685e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'VII', part.name_en = 'Ghosts and Gargoyles: VII.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16850 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:e70bc2d3-0b91-491c-90d6-37a338613811' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e70bc2d3-0b91-491c-90d6-37a338613811', 7, NULL, 'VII', 'Ghosts and Gargoyles: VII.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16850 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e70bc2d3-0b91-491c-90d6-37a338613811'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'VIII', part.name_en = 'Ghosts and Gargoyles: VIII.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16850 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:02287a01-dc61-43e2-8f0c-ccf4d94df299' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02287a01-dc61-43e2-8f0c-ccf4d94df299', 8, NULL, 'VIII', 'Ghosts and Gargoyles: VIII.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16850 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02287a01-dc61-43e2-8f0c-ccf4d94df299'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'IX', part.name_en = 'Ghosts and Gargoyles: IX.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16850 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:3172c0d1-dde6-4982-b3bf-697d5991bf82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3172c0d1-dde6-4982-b3bf-697d5991bf82', 9, NULL, 'IX', 'Ghosts and Gargoyles: IX.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16850 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3172c0d1-dde6-4982-b3bf-697d5991bf82'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'X', part.name_en = 'Ghosts and Gargoyles: X.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16850 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:3b6efd99-6f27-4bf6-a939-ef8d0b50a6b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b6efd99-6f27-4bf6-a939-ef8d0b50a6b0', 10, NULL, 'X', 'Ghosts and Gargoyles: X.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16850 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b6efd99-6f27-4bf6-a939-ef8d0b50a6b0'
);


-- None Ice Field

UPDATE pieces piece
SET piece.title = 'Ice Field', piece.title_en = 'Ice Field',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19012 AND piece.composer_id = 295
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Litany of Tides

UPDATE pieces piece
SET piece.title = 'Litany of Tides', piece.title_en = 'Litany of Tides',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19603 AND piece.composer_id = 295
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 미사 "Mass for June 16"

UPDATE pieces piece
SET piece.title = '미사 "Mass for June 16"', piece.title_en = 'Mass in Gregorian Chant for Multiple Flutes "Mass for June 16"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17922 AND piece.composer_id = 295
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introitus', part.name_en = 'Mass in Gregorian Chant for Multiple Flutes "Mass for June 16": I. Introitus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17922 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:ad6b548d-8e09-4652-9088-88774284a796' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad6b548d-8e09-4652-9088-88774284a796', 1, 'I', 'Introitus', 'Mass in Gregorian Chant for Multiple Flutes "Mass for June 16": I. Introitus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17922 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad6b548d-8e09-4652-9088-88774284a796'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Gloria Patri', part.name_en = 'Mass in Gregorian Chant for Multiple Flutes "Mass for June 16": II. Gloria Patri',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17922 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:5a9c6370-d5be-41e1-9d48-3431661fc7b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a9c6370-d5be-41e1-9d48-3431661fc7b3', 2, 'II', 'Gloria Patri', 'Mass in Gregorian Chant for Multiple Flutes "Mass for June 16": II. Gloria Patri', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17922 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a9c6370-d5be-41e1-9d48-3431661fc7b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Gradual', part.name_en = 'Mass in Gregorian Chant for Multiple Flutes "Mass for June 16": III. Gradual',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17922 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:213ae16e-9488-44fc-9e40-934ef5df30de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:213ae16e-9488-44fc-9e40-934ef5df30de', 3, 'III', 'Gradual', 'Mass in Gregorian Chant for Multiple Flutes "Mass for June 16": III. Gradual', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17922 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:213ae16e-9488-44fc-9e40-934ef5df30de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Alleluja I', part.name_en = 'Mass in Gregorian Chant for Multiple Flutes "Mass for June 16": IV. Alleluja I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17922 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:c67298bc-5d4b-47a9-8f94-a2cb75f74deb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c67298bc-5d4b-47a9-8f94-a2cb75f74deb', 4, 'IV', 'Alleluja I', 'Mass in Gregorian Chant for Multiple Flutes "Mass for June 16": IV. Alleluja I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17922 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c67298bc-5d4b-47a9-8f94-a2cb75f74deb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Tractus', part.name_en = 'Mass in Gregorian Chant for Multiple Flutes "Mass for June 16": V. Tractus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17922 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:ac2630e5-4368-48d6-8041-8887989fb709' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac2630e5-4368-48d6-8041-8887989fb709', 5, 'V', 'Tractus', 'Mass in Gregorian Chant for Multiple Flutes "Mass for June 16": V. Tractus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17922 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac2630e5-4368-48d6-8041-8887989fb709'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Alleluja II', part.name_en = 'Mass in Gregorian Chant for Multiple Flutes "Mass for June 16": VI. Alleluja II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17922 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:f11f3069-4bab-40f4-94b5-876e1b17ab3d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f11f3069-4bab-40f4-94b5-876e1b17ab3d', 6, 'VI', 'Alleluja II', 'Mass in Gregorian Chant for Multiple Flutes "Mass for June 16": VI. Alleluja II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17922 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f11f3069-4bab-40f4-94b5-876e1b17ab3d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Offertorium', part.name_en = 'Mass in Gregorian Chant for Multiple Flutes "Mass for June 16": VII. Offertorium',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17922 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:28397a23-a926-48be-bf60-2646dd518d53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28397a23-a926-48be-bf60-2646dd518d53', 7, 'VII', 'Offertorium', 'Mass in Gregorian Chant for Multiple Flutes "Mass for June 16": VII. Offertorium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17922 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28397a23-a926-48be-bf60-2646dd518d53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Communio', part.name_en = 'Mass in Gregorian Chant for Multiple Flutes "Mass for June 16": VIII. Communio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17922 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:a5d95568-26b9-4fe7-a9cb-3781637ca83f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5d95568-26b9-4fe7-a9cb-3781637ca83f', 8, 'VIII', 'Communio', 'Mass in Gregorian Chant for Multiple Flutes "Mass for June 16": VIII. Communio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17922 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5d95568-26b9-4fe7-a9cb-3781637ca83f'
);


-- None Nomads

UPDATE pieces piece
SET piece.title = 'Nomads', piece.title_en = 'Nomads',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18231 AND piece.composer_id = 295
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Northern Lights Over the Twin Cities

UPDATE pieces piece
SET piece.title = 'Northern Lights Over the Twin Cities', piece.title_en = 'Northern Lights Over the Twin Cities',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18208 AND piece.composer_id = 295
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Battles of Gods', part.name_en = 'Northern Lights Over the Twin Cities: Battles of Gods',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18208 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:5e734f59-bee9-42f8-9f5e-fe681b961888' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e734f59-bee9-42f8-9f5e-fe681b961888', 1, NULL, 'Battles of Gods', 'Northern Lights Over the Twin Cities: Battles of Gods', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18208 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e734f59-bee9-42f8-9f5e-fe681b961888'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ionized Atoms', part.name_en = 'Northern Lights Over the Twin Cities: Ionized Atoms',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18208 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:0644f014-c20b-430c-a767-0b51f8600714' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0644f014-c20b-430c-a767-0b51f8600714', 2, NULL, 'Ionized Atoms', 'Northern Lights Over the Twin Cities: Ionized Atoms', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18208 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0644f014-c20b-430c-a767-0b51f8600714'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Celestial Glow', part.name_en = 'Northern Lights Over the Twin Cities: Celestial Glow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18208 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:a00c20ff-2b82-4bc4-97a5-da9f6b57c3b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a00c20ff-2b82-4bc4-97a5-da9f6b57c3b8', 3, NULL, 'Celestial Glow', 'Northern Lights Over the Twin Cities: Celestial Glow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18208 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a00c20ff-2b82-4bc4-97a5-da9f6b57c3b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Rarefied Air', part.name_en = 'Northern Lights Over the Twin Cities: Rarefied Air',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18208 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:7ae8328f-4ac1-466f-96a4-6b9b2fd78ba7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ae8328f-4ac1-466f-96a4-6b9b2fd78ba7', 4, NULL, 'Rarefied Air', 'Northern Lights Over the Twin Cities: Rarefied Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18208 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ae8328f-4ac1-466f-96a4-6b9b2fd78ba7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Aksanialo!', part.name_en = 'Northern Lights Over the Twin Cities: Aksanialo!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18208 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:affd47fb-75f5-48bd-a9c1-2f5d16003ba5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:affd47fb-75f5-48bd-a9c1-2f5d16003ba5', 5, NULL, 'Aksanialo!', 'Northern Lights Over the Twin Cities: Aksanialo!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18208 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:affd47fb-75f5-48bd-a9c1-2f5d16003ba5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Flaming Horizons', part.name_en = 'Northern Lights Over the Twin Cities: Flaming Horizons',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18208 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:041c9fdb-8002-47a7-ba87-5a18a145c8ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:041c9fdb-8002-47a7-ba87-5a18a145c8ed', 6, NULL, 'Flaming Horizons', 'Northern Lights Over the Twin Cities: Flaming Horizons', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18208 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:041c9fdb-8002-47a7-ba87-5a18a145c8ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Luminous Fans', part.name_en = 'Northern Lights Over the Twin Cities: Luminous Fans',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18208 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:822adb00-5522-4274-a4a5-888af1a9a99e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:822adb00-5522-4274-a4a5-888af1a9a99e', 7, NULL, 'Luminous Fans', 'Northern Lights Over the Twin Cities: Luminous Fans', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18208 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:822adb00-5522-4274-a4a5-888af1a9a99e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Inner Demons', part.name_en = 'Northern Lights Over the Twin Cities: Inner Demons',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18208 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:b1a91ff3-3d0f-4eb9-9964-cdd1aabc6a7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1a91ff3-3d0f-4eb9-9964-cdd1aabc6a7b', 8, NULL, 'Inner Demons', 'Northern Lights Over the Twin Cities: Inner Demons', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18208 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1a91ff3-3d0f-4eb9-9964-cdd1aabc6a7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Curtains of Light', part.name_en = 'Northern Lights Over the Twin Cities: Curtains of Light',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18208 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:a19d2c86-026d-4e74-9a48-7ba22a0ee018' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a19d2c86-026d-4e74-9a48-7ba22a0ee018', 9, NULL, 'Curtains of Light', 'Northern Lights Over the Twin Cities: Curtains of Light', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18208 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a19d2c86-026d-4e74-9a48-7ba22a0ee018'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Pulsating Arcs', part.name_en = 'Northern Lights Over the Twin Cities: Pulsating Arcs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18208 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:cdbdaceb-0c7f-4536-8fc8-2c207a05f240' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdbdaceb-0c7f-4536-8fc8-2c207a05f240', 10, NULL, 'Pulsating Arcs', 'Northern Lights Over the Twin Cities: Pulsating Arcs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18208 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdbdaceb-0c7f-4536-8fc8-2c207a05f240'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Reflected Mirages', part.name_en = 'Northern Lights Over the Twin Cities: Reflected Mirages',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18208 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:425389cc-0e19-47f5-aba8-d795aeb153fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:425389cc-0e19-47f5-aba8-d795aeb153fb', 11, NULL, 'Reflected Mirages', 'Northern Lights Over the Twin Cities: Reflected Mirages', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18208 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:425389cc-0e19-47f5-aba8-d795aeb153fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '[Silent]', part.name_en = 'Northern Lights Over the Twin Cities: [Silent]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18208 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:6c1a4e84-a805-4f32-9b98-a4ebd8950113' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c1a4e84-a805-4f32-9b98-a4ebd8950113', 12, NULL, '[Silent]', 'Northern Lights Over the Twin Cities: [Silent]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18208 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c1a4e84-a805-4f32-9b98-a4ebd8950113'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Northern Lights Over the Twin Cities', part.name_en = 'Northern Lights Over the Twin Cities: Northern Lights Over the Twin Cities',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18208 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:74e0f186-ffc6-4fac-8b61-3de1ee229b11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74e0f186-ffc6-4fac-8b61-3de1ee229b11', 13, NULL, 'Northern Lights Over the Twin Cities', 'Northern Lights Over the Twin Cities: Northern Lights Over the Twin Cities', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18208 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74e0f186-ffc6-4fac-8b61-3de1ee229b11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Earth''s Upper Atmosphere', part.name_en = 'Northern Lights Over the Twin Cities: Earth''s Upper Atmosphere',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18208 AND p.composer_id = 295 AND part.part_key = 'musicbrainz:a5a85356-e606-4f7c-8aa7-84030a13d029' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5a85356-e606-4f7c-8aa7-84030a13d029', 14, NULL, 'Earth''s Upper Atmosphere', 'Northern Lights Over the Twin Cities: Earth''s Upper Atmosphere', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18208 AND p.composer_id = 295
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5a85356-e606-4f7c-8aa7-84030a13d029'
);


-- None Quombex

UPDATE pieces piece
SET piece.title = 'Quombex', piece.title_en = 'Quombex',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17722 AND piece.composer_id = 295
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오라토리오 <Rainforest>

UPDATE pieces piece
SET piece.title = '오라토리오 <Rainforest>', piece.title_en = 'Rainforest',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17154 AND piece.composer_id = 295
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rosewood

UPDATE pieces piece
SET piece.title = 'Rosewood', piece.title_en = 'Rosewood',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16218 AND piece.composer_id = 295
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Signs and Alarms

UPDATE pieces piece
SET piece.title = 'Signs and Alarms', piece.title_en = 'Signs and Alarms',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19433 AND piece.composer_id = 295
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Solar Moth

UPDATE pieces piece
SET piece.title = 'Solar Moth', piece.title_en = 'Solar Moth',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17887 AND piece.composer_id = 295
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Trinity of Spheres

UPDATE pieces piece
SET piece.title = 'Trinity of Spheres', piece.title_en = 'Trinity of Spheres',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17061 AND piece.composer_id = 295
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Verticals Ascending

UPDATE pieces piece
SET piece.title = 'Verticals Ascending', piece.title_en = 'Verticals Ascending',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19139 AND piece.composer_id = 295
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Wind, Water, Clouds & Fire

UPDATE pieces piece
SET piece.title = 'Wind, Water, Clouds & Fire', piece.title_en = 'Wind, Water, Clouds & Fire',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19679 AND piece.composer_id = 295
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Franck Bedrossian (composer_id 299) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 9개(묶음 0, 다악장 0, 낱곡 9),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 12개 중 9개를 작품·part 에 잇고, 0개를 숨기고, 3개는 그대로 둔다.

-- None Charleston

UPDATE pieces piece
SET piece.title = 'Charleston', piece.title_en = 'Charleston',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17372 AND piece.composer_id = 299
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Digital

UPDATE pieces piece
SET piece.title = 'Digital', piece.title_en = 'Digital',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18190 AND piece.composer_id = 299
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Edges

UPDATE pieces piece
SET piece.title = 'Edges', piece.title_en = 'Edges',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16427 AND piece.composer_id = 299
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None L'Usage de la parole

UPDATE pieces piece
SET piece.title = 'L''Usage de la parole', piece.title_en = 'L''Usage de la parole',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19307 AND piece.composer_id = 299
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La Conspiration du silence

UPDATE pieces piece
SET piece.title = 'La Conspiration du silence', piece.title_en = 'La Conspiration du silence',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20057 AND piece.composer_id = 299
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La Solitude du coureur de fond

UPDATE pieces piece
SET piece.title = 'La Solitude du coureur de fond', piece.title_en = 'La Solitude du coureur de fond',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18562 AND piece.composer_id = 299
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Swing

UPDATE pieces piece
SET piece.title = 'Swing', piece.title_en = 'Swing',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19481 AND piece.composer_id = 299
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Transmission

UPDATE pieces piece
SET piece.title = 'Transmission', piece.title_en = 'Transmission',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16925 AND piece.composer_id = 299
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Twist

UPDATE pieces piece
SET piece.title = 'Twist', piece.title_en = 'Twist',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16104 AND piece.composer_id = 299
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Adrien Talexy (composer_id 300) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- Op. 23 발레 <Bella Aminta, polka-mazurka>

UPDATE pieces piece
SET piece.title = '발레 <Bella Aminta, polka-mazurka>', piece.title_en = 'Bella Aminta, polka-mazurka, op. 23',
    piece.type = 'song', piece.opus_number = 'Op. 23',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17845 AND piece.composer_id = 300
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== 브뤼노 뒤콜 (composer_id 302) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- Op. 34 Le Cri

UPDATE pieces piece
SET piece.title = 'Le Cri', piece.title_en = 'Le Cri, op. 34',
    piece.type = 'song', piece.opus_number = 'Op. 34',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16764 AND piece.composer_id = 302
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Zygmunt Konieczny (composer_id 312) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 가곡 <Oczy tej małej>

UPDATE pieces piece
SET piece.title = '가곡 <Oczy tej małej>', piece.title_en = 'Oczy tej małej',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19149 AND piece.composer_id = 312
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Meinrad Schütter (composer_id 313) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 0, 다악장 0, 낱곡 2),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 2개 중 2개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Adorazione dei Pastori

UPDATE pieces piece
SET piece.title = 'Adorazione dei Pastori', piece.title_en = 'Adorazione dei Pastori',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19198 AND piece.composer_id = 313
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 파르티타 "Mit meinem Gott geh ich zur Ruh"

UPDATE pieces piece
SET piece.title = '파르티타 "Mit meinem Gott geh ich zur Ruh"', piece.title_en = 'Partita "Mit meinem Gott geh ich zur Ruh"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16535 AND piece.composer_id = 313
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Makoto Shinohara (composer_id 314) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 6개(묶음 0, 다악장 0, 낱곡 6),
-- 새 작품 1개, part 0개, 그 아래 0개.
-- seed 5개 중 5개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Alternances

UPDATE pieces piece
SET piece.title = 'Alternances', piece.title_en = 'Alternances',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17935 AND piece.composer_id = 314
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Broadcasting

UPDATE pieces piece
SET piece.title = 'Broadcasting', piece.title_en = 'Broadcasting',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15759 AND piece.composer_id = 314
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fragmente

UPDATE pieces piece
SET piece.title = 'Fragmente', piece.title_en = 'Fragmente',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16949 AND piece.composer_id = 314
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Kassouga

UPDATE pieces piece
SET piece.title = 'Kassouga', piece.title_en = 'Kassouga',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18313 AND piece.composer_id = 314
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Passage

UPDATE pieces piece
SET piece.title = 'Passage', piece.title_en = 'Passage',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16135 AND piece.composer_id = 314
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Obsession

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Obsession', 'Obsession', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 314
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Obsession'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '920e95b7-9154-441f-b845-ce40592e6531'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '920e95b7-9154-441f-b845-ce40592e6531'
FROM pieces p
WHERE p.composer_id = 314 AND p.title = 'Obsession' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '920e95b7-9154-441f-b845-ce40592e6531'
);

-- 숨길 seed 작품 없음

-- ===== Nikolai Golovanov (composer_id 315) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 4개(묶음 0, 다악장 0, 낱곡 4),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 4개 중 4개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Cherubic Hymn

UPDATE pieces piece
SET piece.title = 'Cherubic Hymn', piece.title_en = 'Cherubic Hymn',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18299 AND piece.composer_id = 315
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 9 No. 3 Otche nash

UPDATE pieces piece
SET piece.title = 'Otche nash', piece.title_en = 'Otche nash, op. 9 no. 3',
    piece.type = 'song', piece.opus_number = 'Op. 9 No. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18646 AND piece.composer_id = 315
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 5 No. 5 Slava. Edinorodnii sine

UPDATE pieces piece
SET piece.title = 'Slava. Edinorodnii sine', piece.title_en = 'Slava. Edinorodnii sine, op. 5, no. 5',
    piece.type = 'song', piece.opus_number = 'Op. 5 No. 5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19576 AND piece.composer_id = 315
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 1 No. 2 Милость мира

UPDATE pieces piece
SET piece.title = 'Милость мира', piece.title_en = 'Милость мира, op. 1 no. 2',
    piece.type = 'song', piece.opus_number = 'Op. 1 No. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15728 AND piece.composer_id = 315
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Robert Turner (composer_id 318) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 0, 다악장 0, 낱곡 2),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 2개 중 2개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Symphony for Strings

UPDATE pieces piece
SET piece.title = 'Symphony for Strings', piece.title_en = 'Symphony for Strings',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18781 AND piece.composer_id = 318
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Third Symphony

UPDATE pieces piece
SET piece.title = 'Third Symphony', piece.title_en = 'Third Symphony',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19826 AND piece.composer_id = 318
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== 카츠오 후쿠시마 (composer_id 321) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Mei

UPDATE pieces piece
SET piece.title = 'Mei', piece.title_en = 'Mei',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17974 AND piece.composer_id = 321
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== 에벤시오 카스테야노스 (composer_id 322) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 4개(묶음 0, 다악장 1, 낱곡 3),
-- 새 작품 0개, part 5개, 그 아래 0개.
-- seed 4개 중 4개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None El río de las siete estrellas

UPDATE pieces piece
SET piece.title = 'El río de las siete estrellas', piece.title_en = 'El río de las siete estrellas',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18371 AND piece.composer_id = 322
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mañanita caraqueña

UPDATE pieces piece
SET piece.title = 'Mañanita caraqueña', piece.title_en = 'Mañanita caraqueña',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16910 AND piece.composer_id = 322
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Santa Cruz de Pacairigua

UPDATE pieces piece
SET piece.title = 'Santa Cruz de Pacairigua', piece.title_en = 'Santa Cruz de Pacairigua',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19570 AND piece.composer_id = 322
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Suite avileña

UPDATE pieces piece
SET piece.title = 'Suite avileña', piece.title_en = 'Suite avileña',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19973 AND piece.composer_id = 322
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Avileña', part.name_en = 'Suite avileña: I. Avileña',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19973 AND p.composer_id = 322 AND part.part_key = 'musicbrainz:d3c91352-24fc-42e3-ba0b-a7b3cd770637' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3c91352-24fc-42e3-ba0b-a7b3cd770637', 1, 'I', 'Avileña', 'Suite avileña: I. Avileña', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19973 AND p.composer_id = 322
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3c91352-24fc-42e3-ba0b-a7b3cd770637'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'La ronda de niños', part.name_en = 'Suite avileña: II. La ronda de niños',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19973 AND p.composer_id = 322 AND part.part_key = 'musicbrainz:ec547c60-56af-4843-ba92-f54dce851423' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec547c60-56af-4843-ba92-f54dce851423', 2, 'II', 'La ronda de niños', 'Suite avileña: II. La ronda de niños', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19973 AND p.composer_id = 322
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec547c60-56af-4843-ba92-f54dce851423'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Nocturno', part.name_en = 'Suite avileña: III. Nocturno',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19973 AND p.composer_id = 322 AND part.part_key = 'musicbrainz:09c5ba8e-ef92-4d87-8987-c5290dedbc36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09c5ba8e-ef92-4d87-8987-c5290dedbc36', 3, 'III', 'Nocturno', 'Suite avileña: III. Nocturno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19973 AND p.composer_id = 322
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09c5ba8e-ef92-4d87-8987-c5290dedbc36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Amanecer de Navidad', part.name_en = 'Suite avileña: IV. Amanecer de Navidad',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19973 AND p.composer_id = 322 AND part.part_key = 'musicbrainz:6a1f3ca2-bb66-4910-be0d-901d629b005d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a1f3ca2-bb66-4910-be0d-901d629b005d', 4, 'IV', 'Amanecer de Navidad', 'Suite avileña: IV. Amanecer de Navidad', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19973 AND p.composer_id = 322
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a1f3ca2-bb66-4910-be0d-901d629b005d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Navidad', part.name_en = 'Suite avileña: V. Navidad',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19973 AND p.composer_id = 322 AND part.part_key = 'musicbrainz:2b67f9dd-b912-47e6-9044-f62155234078' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b67f9dd-b912-47e6-9044-f62155234078', 5, 'V', 'Navidad', 'Suite avileña: V. Navidad', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19973 AND p.composer_id = 322
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b67f9dd-b912-47e6-9044-f62155234078'
);

-- 숨길 seed 작품 없음

-- ===== Edgar Tinel (composer_id 324) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 6개(묶음 3, 다악장 1, 낱곡 2),
-- 새 작품 0개, part 10개, 그 아래 0개.
-- seed 9개 중 6개를 작품·part 에 잇고, 3개를 숨기고, 0개는 그대로 둔다.

-- Op. 44 오페라 <Catharina> Op. 44

UPDATE pieces piece
SET piece.title = '오페라 <Catharina> Op. 44', piece.title_en = 'Catharina, op. 44',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '44',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18583 AND piece.composer_id = 324
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'Catharina, op. 44: Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18583 AND p.composer_id = 324 AND part.part_key = 'musicbrainz:ce4019ae-044a-4dcd-be69-004b67385ae7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce4019ae-044a-4dcd-be69-004b67385ae7', 1, NULL, 'Overture', 'Catharina, op. 44: Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18583 AND p.composer_id = 324
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce4019ae-044a-4dcd-be69-004b67385ae7'
);


-- Op. 36 오라토리오 <Franciscus> Op. 36

UPDATE pieces piece
SET piece.title = '오라토리오 <Franciscus> Op. 36', piece.title_en = 'Franciscus, op. 36',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '36',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17560 AND piece.composer_id = 324
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Trauermarsch', part.name_en = 'Franciscus, op. 36: Trauermarsch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17560 AND p.composer_id = 324 AND part.part_key = 'musicbrainz:c1c7981c-96a6-4a3b-a1d5-1c3316a6e517' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1c7981c-96a6-4a3b-a1d5-1c3316a6e517', 1, NULL, 'Trauermarsch', 'Franciscus, op. 36: Trauermarsch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17560 AND p.composer_id = 324
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1c7981c-96a6-4a3b-a1d5-1c3316a6e517'
);


-- Op. 43 오페라 <Godelieve>

UPDATE pieces piece
SET piece.title = '오페라 <Godelieve>', piece.title_en = 'Godelieve, op. 43',
    piece.type = 'song', piece.opus_number = 'Op. 43',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16431 AND piece.composer_id = 324
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 41 Missa in honorem Beatae Mariae Virginis de Lourdes

UPDATE pieces piece
SET piece.title = 'Missa in honorem Beatae Mariae Virginis de Lourdes', piece.title_en = 'Missa in honorem Beatae Mariae Virginis de Lourdes, op. 41',
    piece.type = 'album', piece.opus_number = 'Op. 41',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16526 AND piece.composer_id = 324
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Kyrie', part.name_en = 'Missa in honorem Beatae Mariae Virginis de Lourdes, op. 41: I. Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16526 AND p.composer_id = 324 AND part.part_key = 'musicbrainz:b02c1546-b376-4957-9cad-2047e4907fbd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b02c1546-b376-4957-9cad-2047e4907fbd', 1, 'I', 'Kyrie', 'Missa in honorem Beatae Mariae Virginis de Lourdes, op. 41: I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16526 AND p.composer_id = 324
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b02c1546-b376-4957-9cad-2047e4907fbd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Gloria', part.name_en = 'Missa in honorem Beatae Mariae Virginis de Lourdes, op. 41: II. Gloria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16526 AND p.composer_id = 324 AND part.part_key = 'musicbrainz:9cc6eb0b-5f03-46bc-9515-8b3c395ca5ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9cc6eb0b-5f03-46bc-9515-8b3c395ca5ad', 2, 'II', 'Gloria', 'Missa in honorem Beatae Mariae Virginis de Lourdes, op. 41: II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16526 AND p.composer_id = 324
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cc6eb0b-5f03-46bc-9515-8b3c395ca5ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Credo', part.name_en = 'Missa in honorem Beatae Mariae Virginis de Lourdes, op. 41: III. Credo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16526 AND p.composer_id = 324 AND part.part_key = 'musicbrainz:8dcefecf-ff9c-4b41-ae04-b81f37f93664' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8dcefecf-ff9c-4b41-ae04-b81f37f93664', 3, 'III', 'Credo', 'Missa in honorem Beatae Mariae Virginis de Lourdes, op. 41: III. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16526 AND p.composer_id = 324
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8dcefecf-ff9c-4b41-ae04-b81f37f93664'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sanctus', part.name_en = 'Missa in honorem Beatae Mariae Virginis de Lourdes, op. 41: IV. Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16526 AND p.composer_id = 324 AND part.part_key = 'musicbrainz:5c6f213a-9549-4142-af2f-d71dd7a1246a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c6f213a-9549-4142-af2f-d71dd7a1246a', 4, 'IV', 'Sanctus', 'Missa in honorem Beatae Mariae Virginis de Lourdes, op. 41: IV. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16526 AND p.composer_id = 324
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c6f213a-9549-4142-af2f-d71dd7a1246a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Agnus Dei', part.name_en = 'Missa in honorem Beatae Mariae Virginis de Lourdes, op. 41: V. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16526 AND p.composer_id = 324 AND part.part_key = 'musicbrainz:321dc81f-ea8b-49d6-8ece-f24fca3be8c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:321dc81f-ea8b-49d6-8ece-f24fca3be8c9', 5, 'V', 'Agnus Dei', 'Missa in honorem Beatae Mariae Virginis de Lourdes, op. 41: V. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16526 AND p.composer_id = 324
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:321dc81f-ea8b-49d6-8ece-f24fca3be8c9'
);


-- Op. 26 Te Deum laudamus

UPDATE pieces piece
SET piece.title = 'Te Deum laudamus', piece.title_en = 'Te Deum laudamus, op. 26',
    piece.type = 'song', piece.opus_number = 'Op. 26',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18452 AND piece.composer_id = 324
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 31 Trois motets à la Sainte Vierge Op. 31

UPDATE pieces piece
SET piece.title = 'Trois motets à la Sainte Vierge Op. 31', piece.title_en = 'Trois motets à la Sainte Vierge, op. 31',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '31',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17218 AND piece.composer_id = 324
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ave Regina coelorum', part.name_en = 'Trois motets à la Sainte Vierge, op. 31: Ave Regina coelorum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17218 AND p.composer_id = 324 AND part.part_key = 'musicbrainz:461a2f1a-8edc-4b08-97a3-e636b321638f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:461a2f1a-8edc-4b08-97a3-e636b321638f', 1, NULL, 'Ave Regina coelorum', 'Trois motets à la Sainte Vierge, op. 31: Ave Regina coelorum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17218 AND p.composer_id = 324
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:461a2f1a-8edc-4b08-97a3-e636b321638f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Regina coeli', part.name_en = 'Trois motets à la Sainte Vierge, op. 31: Regina coeli',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17218 AND p.composer_id = 324 AND part.part_key = 'musicbrainz:ccf32913-2db8-49c7-b568-ae00dcf51ecf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccf32913-2db8-49c7-b568-ae00dcf51ecf', 2, NULL, 'Regina coeli', 'Trois motets à la Sainte Vierge, op. 31: Regina coeli', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17218 AND p.composer_id = 324
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccf32913-2db8-49c7-b568-ae00dcf51ecf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ave Maria', part.name_en = 'Trois motets à la Sainte Vierge, op. 31: Ave Maria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17218 AND p.composer_id = 324 AND part.part_key = 'musicbrainz:ddb9bdcf-d061-44d2-add9-5984545e4184' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddb9bdcf-d061-44d2-add9-5984545e4184', 3, NULL, 'Ave Maria', 'Trois motets à la Sainte Vierge, op. 31: Ave Maria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17218 AND p.composer_id = 324
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddb9bdcf-d061-44d2-add9-5984545e4184'
);

-- 카탈로그에 대응이 없는 seed 작품 3개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 324 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    17895, 18258, 18392
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Carles Baguer (composer_id 325) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 5개(묶음 0, 다악장 5, 낱곡 0),
-- 새 작품 0개, part 20개, 그 아래 0개.
-- seed 5개 중 5개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Simfonia núm. 2 en do menor

UPDATE pieces piece
SET piece.title = 'Simfonia núm. 2 en do menor', piece.title_en = 'Simfonia núm. 2 en do menor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16238 AND piece.composer_id = 325
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro presto', part.name_en = 'Simfonia núm. 2 en do menor: I. Allegro presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16238 AND p.composer_id = 325 AND part.part_key = 'musicbrainz:43e3eb30-4f84-4784-8d95-3de7470980e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43e3eb30-4f84-4784-8d95-3de7470980e6', 1, 'I', 'Allegro presto', 'Simfonia núm. 2 en do menor: I. Allegro presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16238 AND p.composer_id = 325
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43e3eb30-4f84-4784-8d95-3de7470980e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Simfonia núm. 2 en do menor: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16238 AND p.composer_id = 325 AND part.part_key = 'musicbrainz:de2b765c-c013-428e-9467-bc4b5ab1231f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de2b765c-c013-428e-9467-bc4b5ab1231f', 2, 'II', 'Andante', 'Simfonia núm. 2 en do menor: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16238 AND p.composer_id = 325
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de2b765c-c013-428e-9467-bc4b5ab1231f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Minuetto - Trio', part.name_en = 'Simfonia núm. 2 en do menor: III. Minuetto - Trio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16238 AND p.composer_id = 325 AND part.part_key = 'musicbrainz:16e82286-2fe6-47af-a463-168c9f17d253' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16e82286-2fe6-47af-a463-168c9f17d253', 3, 'III', 'Minuetto - Trio', 'Simfonia núm. 2 en do menor: III. Minuetto - Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16238 AND p.composer_id = 325
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16e82286-2fe6-47af-a463-168c9f17d253'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Rondó (Presto)', part.name_en = 'Simfonia núm. 2 en do menor: IV. Rondó (Presto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16238 AND p.composer_id = 325 AND part.part_key = 'musicbrainz:4a91d701-2dc6-407b-9414-bee55a485552' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a91d701-2dc6-407b-9414-bee55a485552', 4, 'IV', 'Rondó (Presto)', 'Simfonia núm. 2 en do menor: IV. Rondó (Presto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16238 AND p.composer_id = 325
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a91d701-2dc6-407b-9414-bee55a485552'
);


-- None 교향곡 12번 E♭장조

UPDATE pieces piece
SET piece.title = '교향곡 12번 E♭장조', piece.title_en = 'Symphony no. 12 in E-flat major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17642 AND piece.composer_id = 325
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con brio', part.name_en = 'Symphony no. 12 in E-flat major: I. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17642 AND p.composer_id = 325 AND part.part_key = 'musicbrainz:735b33a2-cbdd-49bf-8319-dff2f4c3f6d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:735b33a2-cbdd-49bf-8319-dff2f4c3f6d2', 1, 'I', 'Allegro con brio', 'Symphony no. 12 in E-flat major: I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17642 AND p.composer_id = 325
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:735b33a2-cbdd-49bf-8319-dff2f4c3f6d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Symphony no. 12 in E-flat major: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17642 AND p.composer_id = 325 AND part.part_key = 'musicbrainz:f5121457-5b42-400e-bbf9-b31ea734814f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5121457-5b42-400e-bbf9-b31ea734814f', 2, 'II', 'Andante', 'Symphony no. 12 in E-flat major: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17642 AND p.composer_id = 325
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5121457-5b42-400e-bbf9-b31ea734814f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Menuetto', part.name_en = 'Symphony no. 12 in E-flat major: III. Menuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17642 AND p.composer_id = 325 AND part.part_key = 'musicbrainz:67fb45ea-47f0-4af2-ab4e-41ef28876437' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67fb45ea-47f0-4af2-ab4e-41ef28876437', 3, 'III', 'Menuetto', 'Symphony no. 12 in E-flat major: III. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17642 AND p.composer_id = 325
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67fb45ea-47f0-4af2-ab4e-41ef28876437'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale: Presto', part.name_en = 'Symphony no. 12 in E-flat major: IV. Finale: Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17642 AND p.composer_id = 325 AND part.part_key = 'musicbrainz:8d95fd72-f047-4ab7-b32c-d9e799b2642d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d95fd72-f047-4ab7-b32c-d9e799b2642d', 4, 'IV', 'Finale: Presto', 'Symphony no. 12 in E-flat major: IV. Finale: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17642 AND p.composer_id = 325
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d95fd72-f047-4ab7-b32c-d9e799b2642d'
);


-- None 교향곡 13번 E♭장조

UPDATE pieces piece
SET piece.title = '교향곡 13번 E♭장조', piece.title_en = 'Symphony no. 13 in E-flat major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17083 AND piece.composer_id = 325
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con brio', part.name_en = 'Symphony no. 13 in E-flat major: I. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17083 AND p.composer_id = 325 AND part.part_key = 'musicbrainz:c156e3dd-2b19-47af-ab87-184e77eacd86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c156e3dd-2b19-47af-ab87-184e77eacd86', 1, 'I', 'Allegro con brio', 'Symphony no. 13 in E-flat major: I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17083 AND p.composer_id = 325
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c156e3dd-2b19-47af-ab87-184e77eacd86'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Symphony no. 13 in E-flat major: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17083 AND p.composer_id = 325 AND part.part_key = 'musicbrainz:dc175918-57ba-4a4c-9b09-8e251e202af1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc175918-57ba-4a4c-9b09-8e251e202af1', 2, 'II', 'Adagio', 'Symphony no. 13 in E-flat major: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17083 AND p.composer_id = 325
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc175918-57ba-4a4c-9b09-8e251e202af1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Menuetto', part.name_en = 'Symphony no. 13 in E-flat major: III. Menuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17083 AND p.composer_id = 325 AND part.part_key = 'musicbrainz:67fb21be-1a11-4fbc-85b8-7d9e3fb012bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67fb21be-1a11-4fbc-85b8-7d9e3fb012bf', 3, 'III', 'Menuetto', 'Symphony no. 13 in E-flat major: III. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17083 AND p.composer_id = 325
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67fb21be-1a11-4fbc-85b8-7d9e3fb012bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Final: Allegro presto', part.name_en = 'Symphony no. 13 in E-flat major: IV. Final: Allegro presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17083 AND p.composer_id = 325 AND part.part_key = 'musicbrainz:6ab483db-f0ad-453e-9b62-6604afdd15ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ab483db-f0ad-453e-9b62-6604afdd15ec', 4, 'IV', 'Final: Allegro presto', 'Symphony no. 13 in E-flat major: IV. Final: Allegro presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17083 AND p.composer_id = 325
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ab483db-f0ad-453e-9b62-6604afdd15ec'
);


-- None 교향곡 16번 G장조

UPDATE pieces piece
SET piece.title = '교향곡 16번 G장조', piece.title_en = 'Symphony no. 16 in G major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16235 AND piece.composer_id = 325
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro assai', part.name_en = 'Symphony no. 16 in G major: I. Allegro assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16235 AND p.composer_id = 325 AND part.part_key = 'musicbrainz:cd89e941-7022-4e0e-a6a8-a5ab313f1c37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd89e941-7022-4e0e-a6a8-a5ab313f1c37', 1, 'I', 'Allegro assai', 'Symphony no. 16 in G major: I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16235 AND p.composer_id = 325
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd89e941-7022-4e0e-a6a8-a5ab313f1c37'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio a solo con sordina', part.name_en = 'Symphony no. 16 in G major: II. Adagio a solo con sordina',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16235 AND p.composer_id = 325 AND part.part_key = 'musicbrainz:45c2afe9-12ab-46a5-a84d-66e8540f8a61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45c2afe9-12ab-46a5-a84d-66e8540f8a61', 2, 'II', 'Adagio a solo con sordina', 'Symphony no. 16 in G major: II. Adagio a solo con sordina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16235 AND p.composer_id = 325
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45c2afe9-12ab-46a5-a84d-66e8540f8a61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Menuetto', part.name_en = 'Symphony no. 16 in G major: III. Menuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16235 AND p.composer_id = 325 AND part.part_key = 'musicbrainz:dc6a12bc-a5ac-4c66-9fe4-bd11109d6418' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc6a12bc-a5ac-4c66-9fe4-bd11109d6418', 3, 'III', 'Menuetto', 'Symphony no. 16 in G major: III. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16235 AND p.composer_id = 325
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc6a12bc-a5ac-4c66-9fe4-bd11109d6418'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Rondo: Presto', part.name_en = 'Symphony no. 16 in G major: IV. Rondo: Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16235 AND p.composer_id = 325 AND part.part_key = 'musicbrainz:ebecc59d-6c7b-49d3-bfde-5789fe4ab3cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebecc59d-6c7b-49d3-bfde-5789fe4ab3cd', 4, 'IV', 'Rondo: Presto', 'Symphony no. 16 in G major: IV. Rondo: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16235 AND p.composer_id = 325
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebecc59d-6c7b-49d3-bfde-5789fe4ab3cd'
);


-- None 교향곡 18번 B♭장조

UPDATE pieces piece
SET piece.title = '교향곡 18번 B♭장조', piece.title_en = 'Symphony no. 18 in B-flat major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18236 AND piece.composer_id = 325
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Symphony no. 18 in B-flat major: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18236 AND p.composer_id = 325 AND part.part_key = 'musicbrainz:676ac04a-3ff5-4703-a3bf-7182d8673671' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:676ac04a-3ff5-4703-a3bf-7182d8673671', 1, 'I', 'Allegro', 'Symphony no. 18 in B-flat major: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18236 AND p.composer_id = 325
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:676ac04a-3ff5-4703-a3bf-7182d8673671'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andantino allegretto', part.name_en = 'Symphony no. 18 in B-flat major: II. Andantino allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18236 AND p.composer_id = 325 AND part.part_key = 'musicbrainz:fdcf44a0-ee8a-4e91-be2c-9473d292123e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fdcf44a0-ee8a-4e91-be2c-9473d292123e', 2, 'II', 'Andantino allegretto', 'Symphony no. 18 in B-flat major: II. Andantino allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18236 AND p.composer_id = 325
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fdcf44a0-ee8a-4e91-be2c-9473d292123e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Menuetto', part.name_en = 'Symphony no. 18 in B-flat major: III. Menuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18236 AND p.composer_id = 325 AND part.part_key = 'musicbrainz:352eb92c-e4a8-4db4-bade-f856ccb76730' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:352eb92c-e4a8-4db4-bade-f856ccb76730', 3, 'III', 'Menuetto', 'Symphony no. 18 in B-flat major: III. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18236 AND p.composer_id = 325
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:352eb92c-e4a8-4db4-bade-f856ccb76730'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale. Vivace', part.name_en = 'Symphony no. 18 in B-flat major: IV. Finale. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18236 AND p.composer_id = 325 AND part.part_key = 'musicbrainz:fbec983e-c626-4f0a-a928-97f0813af8af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbec983e-c626-4f0a-a928-97f0813af8af', 4, 'IV', 'Finale. Vivace', 'Symphony no. 18 in B-flat major: IV. Finale. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18236 AND p.composer_id = 325
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbec983e-c626-4f0a-a928-97f0813af8af'
);

-- 숨길 seed 작품 없음

-- ===== José García Román (composer_id 327) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None La resurrección de Don Quijote

UPDATE pieces piece
SET piece.title = 'La resurrección de Don Quijote', piece.title_en = 'La resurrección de Don Quijote',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16458 AND piece.composer_id = 327
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Julius Weismann (composer_id 328) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 0, 다악장 1, 낱곡 1),
-- 새 작품 0개, part 1개, 그 아래 0개.
-- seed 2개 중 2개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- Op. 39 No. 4 Variation for Oboe and Piano

UPDATE pieces piece
SET piece.title = 'Variation for Oboe and Piano', piece.title_en = 'Variation for Oboe and Piano, Op. 39 No. 4',
    piece.type = 'song', piece.opus_number = 'Op. 39 No. 4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18589 AND piece.composer_id = 328
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 39 Variationen für Oboe und Klavier

UPDATE pieces piece
SET piece.title = 'Variationen für Oboe und Klavier', piece.title_en = 'Variationen für Oboe und Klavier, op. 39',
    piece.type = 'album', piece.opus_number = 'Op. 39',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19651 AND piece.composer_id = 328
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'IV',
    part.name_ko = 'Lento, molto tranquillo', part.name_en = 'Variationen für Oboe und Klavier, op. 39: IV. Lento, molto tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19651 AND p.composer_id = 328 AND part.part_key = 'musicbrainz:af4f3c70-e276-475b-80b1-05c1c13890e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af4f3c70-e276-475b-80b1-05c1c13890e4', 1, 'IV', 'Lento, molto tranquillo', 'Variationen für Oboe und Klavier, op. 39: IV. Lento, molto tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19651 AND p.composer_id = 328
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af4f3c70-e276-475b-80b1-05c1c13890e4'
);

-- 숨길 seed 작품 없음

-- ===== Auguste Mermet (composer_id 329) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 1, 다악장 0, 낱곡 0),
-- 새 작품 0개, part 1개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 오페라 <Roland à Roncevaux>

UPDATE pieces piece
SET piece.title = '오페라 <Roland à Roncevaux>', piece.title_en = 'Roland à Roncevaux',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17161 AND piece.composer_id = 329
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '« Prête à te fuir … Le soir pensive » (Alde)', part.name_en = 'Roland à Roncevaux : « Prête à te fuir … Le soir pensive » (Alde)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17161 AND p.composer_id = 329 AND part.part_key = 'musicbrainz:e29f3577-78a4-4045-bcd3-aff03c8efda9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e29f3577-78a4-4045-bcd3-aff03c8efda9', 1, NULL, '« Prête à te fuir … Le soir pensive » (Alde)', 'Roland à Roncevaux : « Prête à te fuir … Le soir pensive » (Alde)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17161 AND p.composer_id = 329
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e29f3577-78a4-4045-bcd3-aff03c8efda9'
);

-- 숨길 seed 작품 없음

-- ===== Michel Corboz (composer_id 332) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Laudate Dominum

UPDATE pieces piece
SET piece.title = 'Laudate Dominum', piece.title_en = 'Laudate Dominum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18542 AND piece.composer_id = 332
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== 발보리 아울린 (composer_id 334) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 3개(묶음 0, 다악장 1, 낱곡 2),
-- 새 작품 0개, part 4개, 그 아래 0개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- Op. 29 Feuille d'album

UPDATE pieces piece
SET piece.title = 'Feuille d''album', piece.title_en = 'Feuille d''album, op. 29',
    piece.type = 'song', piece.opus_number = 'Op. 29',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18036 AND piece.composer_id = 334
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 15 Tableaux Parisiens

UPDATE pieces piece
SET piece.title = 'Tableaux Parisiens', piece.title_en = 'Tableaux Parisiens, op. 15',
    piece.type = 'album', piece.opus_number = 'Op. 15',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19095 AND piece.composer_id = 334
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Vie bruyante dans le lointain ou entend sonner les carillons qui se mêlent avec les sons d''un orgue', part.name_en = 'Tableaux Parisiens, op. 15: I. Vie bruyante dans le lointain ou entend sonner les carillons qui se mêlent avec les sons d''un orgue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19095 AND p.composer_id = 334 AND part.part_key = 'musicbrainz:3349eeb2-3309-4913-b6bb-0e2d00883d6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3349eeb2-3309-4913-b6bb-0e2d00883d6c', 1, 'I', 'Vie bruyante dans le lointain ou entend sonner les carillons qui se mêlent avec les sons d''un orgue', 'Tableaux Parisiens, op. 15: I. Vie bruyante dans le lointain ou entend sonner les carillons qui se mêlent avec les sons d''un orgue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19095 AND p.composer_id = 334
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3349eeb2-3309-4913-b6bb-0e2d00883d6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Dans la calme de nuit', part.name_en = 'Tableaux Parisiens, op. 15: II. Dans la calme de nuit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19095 AND p.composer_id = 334 AND part.part_key = 'musicbrainz:21af19b9-7130-41c8-84b5-4c148a56a51e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21af19b9-7130-41c8-84b5-4c148a56a51e', 2, 'II', 'Dans la calme de nuit', 'Tableaux Parisiens, op. 15: II. Dans la calme de nuit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19095 AND p.composer_id = 334
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21af19b9-7130-41c8-84b5-4c148a56a51e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scène de bal', part.name_en = 'Tableaux Parisiens, op. 15: III. Scène de bal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19095 AND p.composer_id = 334 AND part.part_key = 'musicbrainz:38378e0f-b5cd-4687-809e-f4ad8dc58312' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38378e0f-b5cd-4687-809e-f4ad8dc58312', 3, 'III', 'Scène de bal', 'Tableaux Parisiens, op. 15: III. Scène de bal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19095 AND p.composer_id = 334
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38378e0f-b5cd-4687-809e-f4ad8dc58312'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Un soir de fête à Trocadero', part.name_en = 'Tableaux Parisiens, op. 15: IV. Un soir de fête à Trocadero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19095 AND p.composer_id = 334 AND part.part_key = 'musicbrainz:f5938f59-c583-43f0-a42b-ca790c2d6d8c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5938f59-c583-43f0-a42b-ca790c2d6d8c', 4, 'IV', 'Un soir de fête à Trocadero', 'Tableaux Parisiens, op. 15: IV. Un soir de fête à Trocadero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19095 AND p.composer_id = 334
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5938f59-c583-43f0-a42b-ca790c2d6d8c'
);


-- None Valse élégiaque

UPDATE pieces piece
SET piece.title = 'Valse élégiaque', piece.title_en = 'Valse élégiaque',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17314 AND piece.composer_id = 334
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음
