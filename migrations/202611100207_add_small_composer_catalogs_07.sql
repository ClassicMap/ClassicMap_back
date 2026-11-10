-- 작곡가 20명의 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동, 7/9).
-- 작품 82개(새 7개), seed 84개 중 잇기 75·숨김 3·그대로 6.
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

-- ===== Geoffrey Bush (composer_id 387) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 15개(묶음 5, 다악장 3, 낱곡 7),
-- 새 작품 2개, part 54개, 그 아래 0개.
-- seed 14개 중 13개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.

-- None 가곡 <'Twas in the Year that King Uzziah Died>

UPDATE pieces piece
SET piece.title = '가곡 <''Twas in the Year that King Uzziah Died>', piece.title_en = '''Twas in the Year that King Uzziah Died',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23819 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <A Christmas Cantata>

UPDATE pieces piece
SET piece.title = '칸타타 <A Christmas Cantata>', piece.title_en = 'A Christmas Cantata',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25963 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelude - Lullay Jesu', part.name_en = 'A Christmas Cantata: 1. Prelude - Lullay Jesu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25963 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:2399825e-a497-4867-b17b-6ed9b5131901' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2399825e-a497-4867-b17b-6ed9b5131901', 1, NULL, 'Prelude - Lullay Jesu', 'A Christmas Cantata: 1. Prelude - Lullay Jesu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25963 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2399825e-a497-4867-b17b-6ed9b5131901'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The First Good Joy That Mary Had', part.name_en = 'A Christmas Cantata: 2. The First Good Joy That Mary Had',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25963 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:2e9841cd-3f75-4aba-8a4d-d122500e6040' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e9841cd-3f75-4aba-8a4d-d122500e6040', 2, NULL, 'The First Good Joy That Mary Had', 'A Christmas Cantata: 2. The First Good Joy That Mary Had', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25963 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e9841cd-3f75-4aba-8a4d-d122500e6040'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'When Jesus Christ Was Four Years Old', part.name_en = 'A Christmas Cantata: 3. When Jesus Christ Was Four Years Old',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25963 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:1ebf9b07-3bba-4a50-9d92-726b56f84af9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ebf9b07-3bba-4a50-9d92-726b56f84af9', 3, NULL, 'When Jesus Christ Was Four Years Old', 'A Christmas Cantata: 3. When Jesus Christ Was Four Years Old', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25963 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ebf9b07-3bba-4a50-9d92-726b56f84af9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Little Jesus, Sweetly Sleep', part.name_en = 'A Christmas Cantata: 4. Little Jesus, Sweetly Sleep',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25963 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:76521b4d-f831-438a-9a44-fc408c363608' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76521b4d-f831-438a-9a44-fc408c363608', 4, NULL, 'Little Jesus, Sweetly Sleep', 'A Christmas Cantata: 4. Little Jesus, Sweetly Sleep', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25963 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76521b4d-f831-438a-9a44-fc408c363608'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Rejoice O Make We Merry, Both More & Less', part.name_en = 'A Christmas Cantata: 5. Rejoice O Make We Merry, Both More & Less',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25963 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:fe1ca5df-4c4a-424d-a18a-97108f096c5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe1ca5df-4c4a-424d-a18a-97108f096c5b', 5, NULL, 'Rejoice O Make We Merry, Both More & Less', 'A Christmas Cantata: 5. Rejoice O Make We Merry, Both More & Less', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25963 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe1ca5df-4c4a-424d-a18a-97108f096c5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'I Sing of a Maiden', part.name_en = 'A Christmas Cantata: 6. I Sing of a Maiden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25963 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:e0126438-cf32-4e4d-8d5e-360496278544' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0126438-cf32-4e4d-8d5e-360496278544', 6, NULL, 'I Sing of a Maiden', 'A Christmas Cantata: 6. I Sing of a Maiden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25963 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0126438-cf32-4e4d-8d5e-360496278544'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'By By Lullay, Thou Little Tiny Child', part.name_en = 'A Christmas Cantata: 7. By By Lullay, Thou Little Tiny Child',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25963 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:4e7a95f8-5057-41f3-88f4-9354fc5dd63e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e7a95f8-5057-41f3-88f4-9354fc5dd63e', 7, NULL, 'By By Lullay, Thou Little Tiny Child', 'A Christmas Cantata: 7. By By Lullay, Thou Little Tiny Child', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25963 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e7a95f8-5057-41f3-88f4-9354fc5dd63e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Epilogue/I Saw Three Ships Come Sailing In', part.name_en = 'A Christmas Cantata: 8. Epilogue/I Saw Three Ships Come Sailing In',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25963 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:dfe88c23-d5c4-4674-ac6b-99e95558b2f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfe88c23-d5c4-4674-ac6b-99e95558b2f2', 8, NULL, 'Epilogue/I Saw Three Ships Come Sailing In', 'A Christmas Cantata: 8. Epilogue/I Saw Three Ships Come Sailing In', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25963 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfe88c23-d5c4-4674-ac6b-99e95558b2f2'
);


-- None A Little Concerto on Themes of Thomas Arne

UPDATE pieces piece
SET piece.title = 'A Little Concerto on Themes of Thomas Arne', piece.title_en = 'A Little Concerto on Themes of Thomas Arne',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25589 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'A Little Concerto on Themes of Thomas Arne: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25589 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:8cb6e5b0-b9f5-41fb-9d64-500f385fdcec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8cb6e5b0-b9f5-41fb-9d64-500f385fdcec', 1, 'I', 'Andante', 'A Little Concerto on Themes of Thomas Arne: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25589 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cb6e5b0-b9f5-41fb-9d64-500f385fdcec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'A Little Concerto on Themes of Thomas Arne: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25589 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:9ed223a3-93c9-4c23-81dc-1957790199df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ed223a3-93c9-4c23-81dc-1957790199df', 2, 'II', 'Allegro', 'A Little Concerto on Themes of Thomas Arne: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25589 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ed223a3-93c9-4c23-81dc-1957790199df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Siciliano', part.name_en = 'A Little Concerto on Themes of Thomas Arne: III. Siciliano',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25589 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:4f0aea7e-a600-41bb-9562-6b97a0a3ff80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f0aea7e-a600-41bb-9562-6b97a0a3ff80', 3, 'III', 'Siciliano', 'A Little Concerto on Themes of Thomas Arne: III. Siciliano', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25589 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f0aea7e-a600-41bb-9562-6b97a0a3ff80'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vivace', part.name_en = 'A Little Concerto on Themes of Thomas Arne: IV. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25589 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:1ac0bc6a-7643-4d52-b935-6d9d5477eaa6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ac0bc6a-7643-4d52-b935-6d9d5477eaa6', 4, 'IV', 'Vivace', 'A Little Concerto on Themes of Thomas Arne: IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25589 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ac0bc6a-7643-4d52-b935-6d9d5477eaa6'
);


-- None 오보에 협주곡

UPDATE pieces piece
SET piece.title = '오보에 협주곡', piece.title_en = 'Concerto for Oboe',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25697 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Consort Music

UPDATE pieces piece
SET piece.title = 'Consort Music', piece.title_en = 'Consort Music',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25332 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Song without Words', part.name_en = 'Consort Music: I. Song without Words',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25332 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:897e7f09-c4d5-40bc-92c7-a495d149c471' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:897e7f09-c4d5-40bc-92c7-a495d149c471', 1, 'I', 'Song without Words', 'Consort Music: I. Song without Words', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25332 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:897e7f09-c4d5-40bc-92c7-a495d149c471'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Valse', part.name_en = 'Consort Music: II. Valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25332 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:11ea3546-48f6-4c47-a4bb-376b0625e1e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11ea3546-48f6-4c47-a4bb-376b0625e1e6', 2, 'II', 'Valse', 'Consort Music: II. Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25332 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11ea3546-48f6-4c47-a4bb-376b0625e1e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ballade', part.name_en = 'Consort Music: III. Ballade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25332 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:299cc046-2d1a-466e-9942-6b6fd6ce3faf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:299cc046-2d1a-466e-9942-6b6fd6ce3faf', 3, 'III', 'Ballade', 'Consort Music: III. Ballade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25332 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:299cc046-2d1a-466e-9942-6b6fd6ce3faf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Caprice', part.name_en = 'Consort Music: IV. Caprice',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25332 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:33cb1e2c-ad63-4c71-b3db-1241d5225645' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33cb1e2c-ad63-4c71-b3db-1241d5225645', 4, 'IV', 'Caprice', 'Consort Music: IV. Caprice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25332 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33cb1e2c-ad63-4c71-b3db-1241d5225645'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Cradle Song', part.name_en = 'Consort Music: V. Cradle Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25332 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:9d70c292-d373-4bd0-8e20-42a3a2615d8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d70c292-d373-4bd0-8e20-42a3a2615d8b', 5, 'V', 'Cradle Song', 'Consort Music: V. Cradle Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25332 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d70c292-d373-4bd0-8e20-42a3a2615d8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Finale', part.name_en = 'Consort Music: VI. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25332 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:29f55004-2e0d-4cc9-b662-30dbca8615fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29f55004-2e0d-4cc9-b662-30dbca8615fa', 6, 'VI', 'Finale', 'Consort Music: VI. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25332 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29f55004-2e0d-4cc9-b662-30dbca8615fa'
);


-- None 가곡 <Cuisine Provençale>

UPDATE pieces piece
SET piece.title = '가곡 <Cuisine Provençale>', piece.title_en = 'Cuisine Provençale',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24375 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <In Praise of Mary>

UPDATE pieces piece
SET piece.title = '칸타타 <In Praise of Mary>', piece.title_en = 'In Praise of Mary',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24158 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Love for such a cherry lip>

UPDATE pieces piece
SET piece.title = '가곡 <Love for such a cherry lip>', piece.title_en = 'Love for such a cherry lip',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24338 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <Mirabile misterium (A great and mighty wonder)>

UPDATE pieces piece
SET piece.title = '연가곡집 <Mirabile misterium (A great and mighty wonder)>', piece.title_en = 'Mirabile misterium (A great and mighty wonder)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25588 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'A marvellous thing have I mused in my mind', part.name_en = 'Mirabile misterium (A great and mighty wonder): No. 1. A marvellous thing have I mused in my mind',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25588 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:e1329d63-bcb4-4975-b81d-a5a968009e32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1329d63-bcb4-4975-b81d-a5a968009e32', 1, NULL, 'A marvellous thing have I mused in my mind', 'Mirabile misterium (A great and mighty wonder): No. 1. A marvellous thing have I mused in my mind', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25588 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1329d63-bcb4-4975-b81d-a5a968009e32'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'About th field they pipèd right', part.name_en = 'Mirabile misterium (A great and mighty wonder): No. 2. About th field they pipèd right',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25588 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:1ebfbb41-72e2-43fd-a94f-c1439d3f2ea0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ebfbb41-72e2-43fd-a94f-c1439d3f2ea0', 2, NULL, 'About th field they pipèd right', 'Mirabile misterium (A great and mighty wonder): No. 2. About th field they pipèd right', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25588 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ebfbb41-72e2-43fd-a94f-c1439d3f2ea0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'There is a flow''r sprung of a tree', part.name_en = 'Mirabile misterium (A great and mighty wonder): No. 3. There is a flow''r sprung of a tree',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25588 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:c42d212e-7847-458e-a91f-f6e52e2f9b21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c42d212e-7847-458e-a91f-f6e52e2f9b21', 3, NULL, 'There is a flow''r sprung of a tree', 'Mirabile misterium (A great and mighty wonder): No. 3. There is a flow''r sprung of a tree', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25588 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c42d212e-7847-458e-a91f-f6e52e2f9b21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Jesu Christ, my leman sweet', part.name_en = 'Mirabile misterium (A great and mighty wonder): No. 4. Jesu Christ, my leman sweet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25588 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:00b4b89d-e08d-41bf-bf1f-ba6340471d0a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00b4b89d-e08d-41bf-bf1f-ba6340471d0a', 4, NULL, 'Jesu Christ, my leman sweet', 'Mirabile misterium (A great and mighty wonder): No. 4. Jesu Christ, my leman sweet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25588 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00b4b89d-e08d-41bf-bf1f-ba6340471d0a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Blessed Mary, moder virginal', part.name_en = 'Mirabile misterium (A great and mighty wonder): No. 5. Blessed Mary, moder virginal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25588 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:c4cd1635-3e2c-427d-afb5-8e2d5bb32766' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4cd1635-3e2c-427d-afb5-8e2d5bb32766', 5, NULL, 'Blessed Mary, moder virginal', 'Mirabile misterium (A great and mighty wonder): No. 5. Blessed Mary, moder virginal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25588 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4cd1635-3e2c-427d-afb5-8e2d5bb32766'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'When I see on Rose Jesu, my leman', part.name_en = 'Mirabile misterium (A great and mighty wonder): No. 6. When I see on Rose Jesu, my leman',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25588 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:de5a93b7-a6c2-43d3-8659-67fd746adc91' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de5a93b7-a6c2-43d3-8659-67fd746adc91', 6, NULL, 'When I see on Rose Jesu, my leman', 'Mirabile misterium (A great and mighty wonder): No. 6. When I see on Rose Jesu, my leman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25588 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de5a93b7-a6c2-43d3-8659-67fd746adc91'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Out of your sleep arise and wake', part.name_en = 'Mirabile misterium (A great and mighty wonder): No. 7. Out of your sleep arise and wake',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25588 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:349d7e9e-b9a2-4917-8adb-4165b0a2c559' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:349d7e9e-b9a2-4917-8adb-4165b0a2c559', 7, NULL, 'Out of your sleep arise and wake', 'Mirabile misterium (A great and mighty wonder): No. 7. Out of your sleep arise and wake', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25588 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:349d7e9e-b9a2-4917-8adb-4165b0a2c559'
);


-- None Summer Serenade

UPDATE pieces piece
SET piece.title = 'Summer Serenade', piece.title_en = 'Summer Serenade',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23310 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prologue "Worship ye that lovers be this May"', part.name_en = 'Summer Serenade: I. Prologue "Worship ye that lovers be this May"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23310 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:bdbd48df-c25f-4da7-aa7f-e39fb1314477' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdbd48df-c25f-4da7-aa7f-e39fb1314477', 1, 'I', 'Prologue "Worship ye that lovers be this May"', 'Summer Serenade: I. Prologue "Worship ye that lovers be this May"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23310 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdbd48df-c25f-4da7-aa7f-e39fb1314477'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Madrigal "Love is a sickness full of woes"', part.name_en = 'Summer Serenade: II. Madrigal "Love is a sickness full of woes"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23310 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:d3d21e55-dafd-4e7e-82f6-4d112d8fe6d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3d21e55-dafd-4e7e-82f6-4d112d8fe6d8', 2, 'II', 'Madrigal "Love is a sickness full of woes"', 'Summer Serenade: II. Madrigal "Love is a sickness full of woes"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23310 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3d21e55-dafd-4e7e-82f6-4d112d8fe6d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo "Love is a pretty frenzy"', part.name_en = 'Summer Serenade: III. Scherzo "Love is a pretty frenzy"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23310 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:229394ce-f9a0-4f16-9c6f-7cb4a3f292d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:229394ce-f9a0-4f16-9c6f-7cb4a3f292d8', 3, 'III', 'Scherzo "Love is a pretty frenzy"', 'Summer Serenade: III. Scherzo "Love is a pretty frenzy"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23310 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:229394ce-f9a0-4f16-9c6f-7cb4a3f292d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Dirge “O Rose, thou art sick”', part.name_en = 'Summer Serenade: IV. Dirge “O Rose, thou art sick”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23310 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:41c9ec0c-f33c-45cc-89ed-d29d1a52d96f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41c9ec0c-f33c-45cc-89ed-d29d1a52d96f', 4, 'IV', 'Dirge “O Rose, thou art sick”', 'Summer Serenade: IV. Dirge “O Rose, thou art sick”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23310 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41c9ec0c-f33c-45cc-89ed-d29d1a52d96f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Aubade "Pack, clouds, away"', part.name_en = 'Summer Serenade: V. Aubade "Pack, clouds, away"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23310 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:27587d0d-3906-4f77-9f5a-6c39f4ef6879' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27587d0d-3906-4f77-9f5a-6c39f4ef6879', 5, 'V', 'Aubade "Pack, clouds, away"', 'Summer Serenade: V. Aubade "Pack, clouds, away"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23310 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27587d0d-3906-4f77-9f5a-6c39f4ef6879'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Nocturne "Music, when soft voices die"', part.name_en = 'Summer Serenade: VI. Nocturne "Music, when soft voices die"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23310 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:fa2571f1-9d5f-4972-8f22-e02a155095de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa2571f1-9d5f-4972-8f22-e02a155095de', 6, 'VI', 'Nocturne "Music, when soft voices die"', 'Summer Serenade: VI. Nocturne "Music, when soft voices die"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23310 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa2571f1-9d5f-4972-8f22-e02a155095de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Finale "Pleasure it is, I wis, to hear the birdés sing"', part.name_en = 'Summer Serenade: VII. Finale "Pleasure it is, I wis, to hear the birdés sing"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23310 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:d301fef2-f755-4877-92a8-072e2a6eb40f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d301fef2-f755-4877-92a8-072e2a6eb40f', 7, 'VII', 'Finale "Pleasure it is, I wis, to hear the birdés sing"', 'Summer Serenade: VII. Finale "Pleasure it is, I wis, to hear the birdés sing"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23310 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d301fef2-f755-4877-92a8-072e2a6eb40f'
);


-- None Three Songs of Ben Jonson

UPDATE pieces piece
SET piece.title = 'Three Songs of Ben Jonson', piece.title_en = 'Three Songs of Ben Jonson',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23733 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Echo''s Lament for Narcissus', part.name_en = 'Three Songs of Ben Jonson: No. 1. Echo''s Lament for Narcissus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23733 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:47c9a9aa-141e-4e39-b882-5f36f5ff8e45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47c9a9aa-141e-4e39-b882-5f36f5ff8e45', 1, NULL, 'Echo''s Lament for Narcissus', 'Three Songs of Ben Jonson: No. 1. Echo''s Lament for Narcissus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23733 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47c9a9aa-141e-4e39-b882-5f36f5ff8e45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Kiss', part.name_en = 'Three Songs of Ben Jonson: No. 2. The Kiss',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23733 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:55198bdd-2273-4cc5-8902-af0ae5e8861d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55198bdd-2273-4cc5-8902-af0ae5e8861d', 2, NULL, 'The Kiss', 'Three Songs of Ben Jonson: No. 2. The Kiss', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23733 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55198bdd-2273-4cc5-8902-af0ae5e8861d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'A Rebuke', part.name_en = 'Three Songs of Ben Jonson: No. 3. A Rebuke',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23733 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:2f47b6a9-7c4a-486d-95fa-51986af24bf2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f47b6a9-7c4a-486d-95fa-51986af24bf2', 3, NULL, 'A Rebuke', 'Three Songs of Ben Jonson: No. 3. A Rebuke', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23733 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f47b6a9-7c4a-486d-95fa-51986af24bf2'
);


-- None Yorick

UPDATE pieces piece
SET piece.title = 'Yorick', piece.title_en = 'Yorick',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25342 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <archy at the zoo>

UPDATE pieces piece
SET piece.title = '연가곡집 <archy at the zoo>', piece.title_en = 'archy at the zoo',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24696 AND piece.composer_id = 387
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'centipede', part.name_en = 'archy at the zoo: No. 1. centipede',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24696 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:c76075ef-c76d-44ff-a51e-fac21d3adce0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c76075ef-c76d-44ff-a51e-fac21d3adce0', 1, NULL, 'centipede', 'archy at the zoo: No. 1. centipede', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24696 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c76075ef-c76d-44ff-a51e-fac21d3adce0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'camel and giraffe', part.name_en = 'archy at the zoo: No. 2. camel and giraffe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24696 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:4894981d-9057-4962-bfea-0ef4602fdfd9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4894981d-9057-4962-bfea-0ef4602fdfd9', 2, NULL, 'camel and giraffe', 'archy at the zoo: No. 2. camel and giraffe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24696 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4894981d-9057-4962-bfea-0ef4602fdfd9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'hippopotamus', part.name_en = 'archy at the zoo: No. 3. hippopotamus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24696 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:027c839d-5d6f-473e-9b58-688e5556ded3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:027c839d-5d6f-473e-9b58-688e5556ded3', 3, NULL, 'hippopotamus', 'archy at the zoo: No. 3. hippopotamus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24696 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:027c839d-5d6f-473e-9b58-688e5556ded3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'hen', part.name_en = 'archy at the zoo: No. 4. hen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24696 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:5a627c7a-0728-4195-802a-303357022f89' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a627c7a-0728-4195-802a-303357022f89', 4, NULL, 'hen', 'archy at the zoo: No. 4. hen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24696 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a627c7a-0728-4195-802a-303357022f89'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'octopus', part.name_en = 'archy at the zoo: No. 5. octopus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24696 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:8f42832c-178c-4807-8dd7-7e00ffe85e7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f42832c-178c-4807-8dd7-7e00ffe85e7a', 5, NULL, 'octopus', 'archy at the zoo: No. 5. octopus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24696 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f42832c-178c-4807-8dd7-7e00ffe85e7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'man and monkey', part.name_en = 'archy at the zoo: No. 6. man and monkey',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24696 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:d62ebed5-63d2-47c2-b390-b9e0acdbef5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d62ebed5-63d2-47c2-b390-b9e0acdbef5e', 6, NULL, 'man and monkey', 'archy at the zoo: No. 6. man and monkey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24696 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d62ebed5-63d2-47c2-b390-b9e0acdbef5e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'penguin', part.name_en = 'archy at the zoo: No. 7. penguin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24696 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:08e3788c-039b-4301-8129-828157526839' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08e3788c-039b-4301-8129-828157526839', 7, NULL, 'penguin', 'archy at the zoo: No. 7. penguin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24696 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08e3788c-039b-4301-8129-828157526839'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'ichneumon', part.name_en = 'archy at the zoo: No. 8. ichneumon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24696 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:7b66e8c2-cc82-4fb5-9e7c-853114ec3db6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b66e8c2-cc82-4fb5-9e7c-853114ec3db6', 8, NULL, 'ichneumon', 'archy at the zoo: No. 8. ichneumon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24696 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b66e8c2-cc82-4fb5-9e7c-853114ec3db6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'shark', part.name_en = 'archy at the zoo: No. 9. shark',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24696 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:a9ab0478-12a5-4a66-b73c-33bacba2a272' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9ab0478-12a5-4a66-b73c-33bacba2a272', 9, NULL, 'shark', 'archy at the zoo: No. 9. shark', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24696 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9ab0478-12a5-4a66-b73c-33bacba2a272'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'young whale', part.name_en = 'archy at the zoo: No. 10. young whale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24696 AND p.composer_id = 387 AND part.part_key = 'musicbrainz:f514b12c-dc7c-4aa6-b894-4331e0ec7391' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f514b12c-dc7c-4aa6-b894-4331e0ec7391', 10, NULL, 'young whale', 'archy at the zoo: No. 10. young whale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24696 AND p.composer_id = 387
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f514b12c-dc7c-4aa6-b894-4331e0ec7391'
);


-- None 교향곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 1번', 'Symphony no. 1', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 387
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a485d0d-587a-41f6-b7d2-32671f0fde09'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5a485d0d-587a-41f6-b7d2-32671f0fde09'
FROM pieces p
WHERE p.composer_id = 387 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a485d0d-587a-41f6-b7d2-32671f0fde09'
);


-- None 연가곡집 <Yesterday>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <Yesterday>', 'Yesterday', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 387
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <Yesterday>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f3e5922e-8e43-4f1e-b19b-1bd8899f1dd6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f3e5922e-8e43-4f1e-b19b-1bd8899f1dd6'
FROM pieces p
WHERE p.composer_id = 387 AND p.title = '연가곡집 <Yesterday>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f3e5922e-8e43-4f1e-b19b-1bd8899f1dd6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1975ae34-99ab-4acc-8e1d-edafc9dd1912', 1, NULL, 'Daniel Brent', 'Yesterday: No. 1. Daniel Brent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 387 AND p.title = '연가곡집 <Yesterday>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1975ae34-99ab-4acc-8e1d-edafc9dd1912'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5142646-90d2-4b97-8fe7-cd5cc133bbbf', 2, NULL, 'Lady Jane Grey', 'Yesterday: No. 2. Lady Jane Grey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 387 AND p.title = '연가곡집 <Yesterday>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5142646-90d2-4b97-8fe7-cd5cc133bbbf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e48e9e39-3094-4f7a-bc7b-9bd6c4e533b9', 3, NULL, 'Smuggler''s Song', 'Yesterday: No. 3. Smuggler''s Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 387 AND p.title = '연가곡집 <Yesterday>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e48e9e39-3094-4f7a-bc7b-9bd6c4e533b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8cb044c-c325-4081-856c-34bb3a55f5ff', 4, NULL, 'Mistletoe', 'Yesterday: No. 4. Mistletoe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 387 AND p.title = '연가곡집 <Yesterday>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8cb044c-c325-4081-856c-34bb3a55f5ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18be0a82-847c-4763-97e2-bb9addddc1ac', 5, NULL, 'Sleigh Ride', 'Yesterday: No. 5. Sleigh Ride', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 387 AND p.title = '연가곡집 <Yesterday>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18be0a82-847c-4763-97e2-bb9addddc1ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1af9e30-c569-4bd2-9bbf-ebfabf1e7bdc', 6, NULL, 'By the Tamar', 'Yesterday: No. 6. By the Tamar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 387 AND p.title = '연가곡집 <Yesterday>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1af9e30-c569-4bd2-9bbf-ebfabf1e7bdc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f6b40d7-d11a-4a57-9d89-bd0ec4ca2faf', 7, NULL, 'Morwenstow: A dialogue', 'Yesterday: No. 7. Morwenstow: A dialogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 387 AND p.title = '연가곡집 <Yesterday>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f6b40d7-d11a-4a57-9d89-bd0ec4ca2faf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:514bad78-0014-4436-8934-a0866e501ada', 8, NULL, 'Transience', 'Yesterday: No. 8. Transience', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 387 AND p.title = '연가곡집 <Yesterday>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:514bad78-0014-4436-8934-a0866e501ada'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f189df3-3dd5-45de-96ec-31c6b2bcde36', 9, NULL, 'Wishes', 'Yesterday: No. 9. Wishes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 387 AND p.title = '연가곡집 <Yesterday>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f189df3-3dd5-45de-96ec-31c6b2bcde36'
);

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 387 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    23738
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Charles Sanford Skilton (composer_id 388) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 5개(묶음 0, 다악장 0, 낱곡 5),
-- 새 작품 1개, part 0개, 그 아래 0개.
-- seed 4개 중 4개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Cheyenne War‐Dance

UPDATE pieces piece
SET piece.title = 'Cheyenne War‐Dance', piece.title_en = 'Cheyenne War‐Dance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25888 AND piece.composer_id = 388
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Kikapoo Social Dance

UPDATE pieces piece
SET piece.title = 'Kikapoo Social Dance', piece.title_en = 'Kikapoo Social Dance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23475 AND piece.composer_id = 388
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Shawnee Indian Hunting Dance

UPDATE pieces piece
SET piece.title = 'Shawnee Indian Hunting Dance', piece.title_en = 'Shawnee Indian Hunting Dance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24666 AND piece.composer_id = 388
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sioux Flute Serenade

UPDATE pieces piece
SET piece.title = 'Sioux Flute Serenade', piece.title_en = 'Sioux Flute Serenade',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23296 AND piece.composer_id = 388
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Two Indian Dances

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Two Indian Dances', 'Two Indian Dances', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 388
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Two Indian Dances'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cf2c1321-60bb-4e7e-ba33-74265235d16e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cf2c1321-60bb-4e7e-ba33-74265235d16e'
FROM pieces p
WHERE p.composer_id = 388 AND p.title = 'Two Indian Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cf2c1321-60bb-4e7e-ba33-74265235d16e'
);

-- 숨길 seed 작품 없음

-- ===== Henri Mulet (composer_id 391) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 0, 다악장 1, 낱곡 1),
-- 새 작품 0개, part 10개, 그 아래 0개.
-- seed 2개 중 2개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Carillon-sortie en ré majeur

UPDATE pieces piece
SET piece.title = 'Carillon-sortie en ré majeur', piece.title_en = 'Carillon-sortie en ré majeur',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24869 AND piece.composer_id = 391
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Esquisses byzantines

UPDATE pieces piece
SET piece.title = 'Esquisses byzantines', piece.title_en = 'Esquisses byzantines',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25552 AND piece.composer_id = 391
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Nef', part.name_en = 'Esquisses byzantines: I. Nef',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25552 AND p.composer_id = 391 AND part.part_key = 'musicbrainz:5c8a6370-2987-4aa9-9c75-e3dc6c90c6d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c8a6370-2987-4aa9-9c75-e3dc6c90c6d8', 1, 'I', 'Nef', 'Esquisses byzantines: I. Nef', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25552 AND p.composer_id = 391
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c8a6370-2987-4aa9-9c75-e3dc6c90c6d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Vitrail', part.name_en = 'Esquisses byzantines: II. Vitrail',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25552 AND p.composer_id = 391 AND part.part_key = 'musicbrainz:1e66dd30-6803-405d-a1d8-7d47ee1a686f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e66dd30-6803-405d-a1d8-7d47ee1a686f', 2, 'II', 'Vitrail', 'Esquisses byzantines: II. Vitrail', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25552 AND p.composer_id = 391
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e66dd30-6803-405d-a1d8-7d47ee1a686f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rosace', part.name_en = 'Esquisses byzantines: III. Rosace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25552 AND p.composer_id = 391 AND part.part_key = 'musicbrainz:9d76dbb5-bfa2-4311-ba3b-35b09eaaf132' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d76dbb5-bfa2-4311-ba3b-35b09eaaf132', 3, 'III', 'Rosace', 'Esquisses byzantines: III. Rosace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25552 AND p.composer_id = 391
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d76dbb5-bfa2-4311-ba3b-35b09eaaf132'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Chapelle des morts', part.name_en = 'Esquisses byzantines: IV. Chapelle des morts',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25552 AND p.composer_id = 391 AND part.part_key = 'musicbrainz:a6791eb9-a879-4f28-b9ee-7864456deef4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6791eb9-a879-4f28-b9ee-7864456deef4', 4, 'IV', 'Chapelle des morts', 'Esquisses byzantines: IV. Chapelle des morts', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25552 AND p.composer_id = 391
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6791eb9-a879-4f28-b9ee-7864456deef4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Campanile', part.name_en = 'Esquisses byzantines: V. Campanile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25552 AND p.composer_id = 391 AND part.part_key = 'musicbrainz:0b64517b-a7f0-4055-a70c-bdad0e6f6d5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b64517b-a7f0-4055-a70c-bdad0e6f6d5b', 5, 'V', 'Campanile', 'Esquisses byzantines: V. Campanile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25552 AND p.composer_id = 391
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b64517b-a7f0-4055-a70c-bdad0e6f6d5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Procession', part.name_en = 'Esquisses byzantines: VI. Procession',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25552 AND p.composer_id = 391 AND part.part_key = 'musicbrainz:964de168-6172-42dc-ba41-5cd4e6a33261' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:964de168-6172-42dc-ba41-5cd4e6a33261', 6, 'VI', 'Procession', 'Esquisses byzantines: VI. Procession', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25552 AND p.composer_id = 391
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:964de168-6172-42dc-ba41-5cd4e6a33261'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Chant funèbre', part.name_en = 'Esquisses byzantines: VII. Chant funèbre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25552 AND p.composer_id = 391 AND part.part_key = 'musicbrainz:9f3b37a6-28dd-4238-80c8-e79225f8674e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f3b37a6-28dd-4238-80c8-e79225f8674e', 7, 'VII', 'Chant funèbre', 'Esquisses byzantines: VII. Chant funèbre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25552 AND p.composer_id = 391
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f3b37a6-28dd-4238-80c8-e79225f8674e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Noël', part.name_en = 'Esquisses byzantines: VIII. Noël',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25552 AND p.composer_id = 391 AND part.part_key = 'musicbrainz:945bdf93-9dd1-4db5-b9d1-016f3299da02' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:945bdf93-9dd1-4db5-b9d1-016f3299da02', 8, 'VIII', 'Noël', 'Esquisses byzantines: VIII. Noël', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25552 AND p.composer_id = 391
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:945bdf93-9dd1-4db5-b9d1-016f3299da02'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'In Paradisum', part.name_en = 'Esquisses byzantines: IX. In Paradisum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25552 AND p.composer_id = 391 AND part.part_key = 'musicbrainz:e8986cf5-98c3-4cc2-aa2b-d99f699a7b62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8986cf5-98c3-4cc2-aa2b-d99f699a7b62', 9, 'IX', 'In Paradisum', 'Esquisses byzantines: IX. In Paradisum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25552 AND p.composer_id = 391
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8986cf5-98c3-4cc2-aa2b-d99f699a7b62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Tu es Petra', part.name_en = 'Esquisses byzantines: X. Tu es Petra',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25552 AND p.composer_id = 391 AND part.part_key = 'musicbrainz:ae28d8d9-6533-4bdb-bb04-d75cf900d02a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae28d8d9-6533-4bdb-bb04-d75cf900d02a', 10, 'X', 'Tu es Petra', 'Esquisses byzantines: X. Tu es Petra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25552 AND p.composer_id = 391
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae28d8d9-6533-4bdb-bb04-d75cf900d02a'
);

-- 숨길 seed 작품 없음

-- ===== Geoffrey Toye (composer_id 392) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 1, 다악장 0, 낱곡 0),
-- 새 작품 0개, part 1개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 발레 <The Haunted Ballroom>

UPDATE pieces piece
SET piece.title = '발레 <The Haunted Ballroom>', piece.title_en = 'The Haunted Ballroom',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23370 AND piece.composer_id = 392
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Waltz', part.name_en = 'The Haunted Ballroom: Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23370 AND p.composer_id = 392 AND part.part_key = 'musicbrainz:1b52b7d3-69db-4bdc-b3c8-74a0157c8b93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b52b7d3-69db-4bdc-b3c8-74a0157c8b93', 1, NULL, 'Waltz', 'The Haunted Ballroom: Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23370 AND p.composer_id = 392
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b52b7d3-69db-4bdc-b3c8-74a0157c8b93'
);

-- 숨길 seed 작품 없음

-- ===== Pierre Certon (composer_id 395) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 13개(묶음 0, 다악장 0, 낱곡 13),
-- 새 작품 2개, part 0개, 그 아래 0개.
-- seed 13개 중 11개를 작품·part 에 잇고, 1개를 숨기고, 1개는 그대로 둔다.

-- None C'Est Trop Parlé de Bacchus

UPDATE pieces piece
SET piece.title = 'C''Est Trop Parlé de Bacchus', piece.title_en = 'C''Est Trop Parlé de Bacchus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25385 AND piece.composer_id = 395
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <C'est grand pitié quant argent fault>

UPDATE pieces piece
SET piece.title = '가곡 <C''est grand pitié quant argent fault>', piece.title_en = 'C''est grand pitié quant argent fault',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25338 AND piece.composer_id = 395
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None De profundis

UPDATE pieces piece
SET piece.title = 'De profundis', piece.title_en = 'De profundis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24063 AND piece.composer_id = 395
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None En languissant avoir secours j'attens

UPDATE pieces piece
SET piece.title = 'En languissant avoir secours j''attens', piece.title_en = 'En languissant avoir secours j''attens',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24971 AND piece.composer_id = 395
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Exultate Justi in Domino

UPDATE pieces piece
SET piece.title = 'Exultate Justi in Domino', piece.title_en = 'Exultate Justi in Domino',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24618 AND piece.composer_id = 395
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Je l'ay aimé>

UPDATE pieces piece
SET piece.title = '가곡 <Je l''ay aimé>', piece.title_en = 'Je l''ay aimé',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24825 AND piece.composer_id = 395
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Je suis un demidieu>

UPDATE pieces piece
SET piece.title = '가곡 <Je suis un demidieu>', piece.title_en = 'Je suis un demidieu',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24303 AND piece.composer_id = 395
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <La, la, la, la je ne l'ose dire>

UPDATE pieces piece
SET piece.title = '가곡 <La, la, la, la je ne l''ose dire>', piece.title_en = 'La, la, la, la je ne l''ose dire',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23088 AND piece.composer_id = 395
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None O Adonai

UPDATE pieces piece
SET piece.title = 'O Adonai', piece.title_en = 'O Adonai',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25743 AND piece.composer_id = 395
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Que n'est elle auprès de moy>

UPDATE pieces piece
SET piece.title = '가곡 <Que n''est elle auprès de moy>', piece.title_en = 'Que n''est elle auprès de moy',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24502 AND piece.composer_id = 395
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Ung Verd Galland>

UPDATE pieces piece
SET piece.title = '가곡 <Ung Verd Galland>', piece.title_en = 'Ung Verd Galland',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25354 AND piece.composer_id = 395
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Inviolata>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Inviolata>', 'Inviolata', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 395
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Inviolata>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13ca48bc-e20e-471f-9f9f-e08d965016f7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '13ca48bc-e20e-471f-9f9f-e08d965016f7'
FROM pieces p
WHERE p.composer_id = 395 AND p.title = '모테트 <Inviolata>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13ca48bc-e20e-471f-9f9f-e08d965016f7'
);


-- None Super flumina Babylonis

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Super flumina Babylonis', 'Super flumina Babylonis', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 395
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Super flumina Babylonis'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9f08e5f-b44a-4280-a46a-817cd511d950'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c9f08e5f-b44a-4280-a46a-817cd511d950'
FROM pieces p
WHERE p.composer_id = 395 AND p.title = 'Super flumina Babylonis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9f08e5f-b44a-4280-a46a-817cd511d950'
);

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 395 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    25666
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Gustave Doret (composer_id 398) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Heureux celui qui revoit sa patrie

UPDATE pieces piece
SET piece.title = 'Heureux celui qui revoit sa patrie', piece.title_en = 'Heureux celui qui revoit sa patrie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16468 AND piece.composer_id = 398
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== 프랑수아 바쟁 (composer_id 400) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 3개(묶음 3, 다악장 0, 낱곡 0),
-- 새 작품 0개, part 23개, 그 아래 19개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 오페라 <Le Voyage en Chine>

UPDATE pieces piece
SET piece.title = '오페라 <Le Voyage en Chine>', piece.title_en = 'Le Voyage en Chine',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25497 AND piece.composer_id = 400
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I', part.name_en = 'Le Voyage en Chine: Acte I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf', 1, NULL, 'Acte I', 'Le Voyage en Chine: Acte I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte I. “Je vous présente ici ma femme” (Pompéry, Rosenville, Fréval, Mme Pompéry, Marie, Berthe)', part.name_en = 'Le Voyage en Chine: Acte I. “Je vous présente ici ma femme” (Pompéry, Rosenville, Fréval, Mme Pompéry, Marie, Berthe)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:0636dfab-334c-4b9f-a04b-b66c72a08690' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0636dfab-334c-4b9f-a04b-b66c72a08690', 1, NULL, 'Acte I. “Je vous présente ici ma femme” (Pompéry, Rosenville, Fréval, Mme Pompéry, Marie, Berthe)', 'Le Voyage en Chine: Acte I. “Je vous présente ici ma femme” (Pompéry, Rosenville, Fréval, Mme Pompéry, Marie, Berthe)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0636dfab-334c-4b9f-a04b-b66c72a08690'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte I. Texte', part.name_en = 'Le Voyage en Chine: Acte I. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:235021f0-efb0-4ef3-b7d2-6ef464facfff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:235021f0-efb0-4ef3-b7d2-6ef464facfff', 2, NULL, 'Acte I. Texte', 'Le Voyage en Chine: Acte I. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:235021f0-efb0-4ef3-b7d2-6ef464facfff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte I. “Qu''a t-elle donc ?” (Marie, Berthe, Mme Pompéry)', part.name_en = 'Le Voyage en Chine: Acte I. “Qu''a t-elle donc ?” (Marie, Berthe, Mme Pompéry)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:253ee916-4c1c-4a6a-adc2-3484d3794a2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:253ee916-4c1c-4a6a-adc2-3484d3794a2c', 3, NULL, 'Acte I. “Qu''a t-elle donc ?” (Marie, Berthe, Mme Pompéry)', 'Le Voyage en Chine: Acte I. “Qu''a t-elle donc ?” (Marie, Berthe, Mme Pompéry)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:253ee916-4c1c-4a6a-adc2-3484d3794a2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte I. Texte', part.name_en = 'Le Voyage en Chine: Acte I. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:35009305-cb46-4fac-8c4b-6ded42d38ab8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:35009305-cb46-4fac-8c4b-6ded42d38ab8', 4, NULL, 'Acte I. Texte', 'Le Voyage en Chine: Acte I. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35009305-cb46-4fac-8c4b-6ded42d38ab8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte I. Texte', part.name_en = 'Le Voyage en Chine: Acte I. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:58528a8b-1d34-4611-945e-fdaf65b9d9a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:58528a8b-1d34-4611-945e-fdaf65b9d9a4', 5, NULL, 'Acte I. Texte', 'Le Voyage en Chine: Acte I. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58528a8b-1d34-4611-945e-fdaf65b9d9a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte I. “Ah ! Quelle amusante folie” (Marie, Kernoisan)', part.name_en = 'Le Voyage en Chine: Acte I. “Ah ! Quelle amusante folie” (Marie, Kernoisan)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:63e0f4d5-45c3-4876-9fda-9c142e446790' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:63e0f4d5-45c3-4876-9fda-9c142e446790', 6, NULL, 'Acte I. “Ah ! Quelle amusante folie” (Marie, Kernoisan)', 'Le Voyage en Chine: Acte I. “Ah ! Quelle amusante folie” (Marie, Kernoisan)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63e0f4d5-45c3-4876-9fda-9c142e446790'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte I. Texte', part.name_en = 'Le Voyage en Chine: Acte I. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:64b12f18-75d5-4984-bb38-a9d7591521e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:64b12f18-75d5-4984-bb38-a9d7591521e9', 7, NULL, 'Acte I. Texte', 'Le Voyage en Chine: Acte I. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64b12f18-75d5-4984-bb38-a9d7591521e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte I. “Ah ! Je vais donc la revoir” (Kernoisan)', part.name_en = 'Le Voyage en Chine: Acte I. “Ah ! Je vais donc la revoir” (Kernoisan)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:7853788c-d7cc-4213-afc1-2fdb6c91010c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7853788c-d7cc-4213-afc1-2fdb6c91010c', 8, NULL, 'Acte I. “Ah ! Je vais donc la revoir” (Kernoisan)', 'Le Voyage en Chine: Acte I. “Ah ! Je vais donc la revoir” (Kernoisan)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7853788c-d7cc-4213-afc1-2fdb6c91010c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Acte I. “C''est jour de fête” (Les Jardiniers, Mme Pompéry, Pompéry)', part.name_en = 'Le Voyage en Chine: Acte I. “C''est jour de fête” (Les Jardiniers, Mme Pompéry, Pompéry)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:9f8da391-035b-43cf-9c1b-0cecdcff8f6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9f8da391-035b-43cf-9c1b-0cecdcff8f6c', 9, NULL, 'Acte I. “C''est jour de fête” (Les Jardiniers, Mme Pompéry, Pompéry)', 'Le Voyage en Chine: Acte I. “C''est jour de fête” (Les Jardiniers, Mme Pompéry, Pompéry)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f8da391-035b-43cf-9c1b-0cecdcff8f6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Acte I. Texte', part.name_en = 'Le Voyage en Chine: Acte I. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:a8bd5e7c-674b-4e52-8490-48513ba335c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a8bd5e7c-674b-4e52-8490-48513ba335c9', 10, NULL, 'Acte I. Texte', 'Le Voyage en Chine: Acte I. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8bd5e7c-674b-4e52-8490-48513ba335c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Acte I. “C''est jour de fête” (reprise) (Les Jardiniers, Pompéry, Fréval, Kernoisan, Mme Pompéry, Marie)', part.name_en = 'Le Voyage en Chine: Acte I. “C''est jour de fête” (reprise) (Les Jardiniers, Pompéry, Fréval, Kernoisan, Mme Pompéry, Marie)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:c9f8eb89-ed08-43d4-87c5-52b4e587349f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c9f8eb89-ed08-43d4-87c5-52b4e587349f', 11, NULL, 'Acte I. “C''est jour de fête” (reprise) (Les Jardiniers, Pompéry, Fréval, Kernoisan, Mme Pompéry, Marie)', 'Le Voyage en Chine: Acte I. “C''est jour de fête” (reprise) (Les Jardiniers, Pompéry, Fréval, Kernoisan, Mme Pompéry, Marie)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9f8eb89-ed08-43d4-87c5-52b4e587349f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Acte I. Ouverture', part.name_en = 'Le Voyage en Chine: Acte I. Ouverture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:ff258f2d-4a6b-47d3-bc6d-2e4b1debc0a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ff258f2d-4a6b-47d3-bc6d-2e4b1debc0a9', 12, NULL, 'Acte I. Ouverture', 'Le Voyage en Chine: Acte I. Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:684d903c-91f2-4752-ad57-83b1e76cb6cf'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff258f2d-4a6b-47d3-bc6d-2e4b1debc0a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte III', part.name_en = 'Le Voyage en Chine: Acte III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a', 2, NULL, 'Acte III', 'Le Voyage en Chine: Acte III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte III. “En Chine, en Chine” (Kernoisan)', part.name_en = 'Le Voyage en Chine: Acte III. “En Chine, en Chine” (Kernoisan)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:0b3bfafe-330d-4821-9ed0-619454eb0cf0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0b3bfafe-330d-4821-9ed0-619454eb0cf0', 1, NULL, 'Acte III. “En Chine, en Chine” (Kernoisan)', 'Le Voyage en Chine: Acte III. “En Chine, en Chine” (Kernoisan)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b3bfafe-330d-4821-9ed0-619454eb0cf0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte III. Texte', part.name_en = 'Le Voyage en Chine: Acte III. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:1464e9d5-43bb-45e7-9e4d-7123cedac34b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1464e9d5-43bb-45e7-9e4d-7123cedac34b', 2, NULL, 'Acte III. Texte', 'Le Voyage en Chine: Acte III. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1464e9d5-43bb-45e7-9e4d-7123cedac34b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte III. Texte', part.name_en = 'Le Voyage en Chine: Acte III. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:20d75fea-3713-42e4-9270-e64fa38f31f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:20d75fea-3713-42e4-9270-e64fa38f31f3', 3, NULL, 'Acte III. Texte', 'Le Voyage en Chine: Acte III. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20d75fea-3713-42e4-9270-e64fa38f31f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte III. Texte', part.name_en = 'Le Voyage en Chine: Acte III. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:298f5989-a659-42e3-b523-d92f7f2f79c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:298f5989-a659-42e3-b523-d92f7f2f79c6', 4, NULL, 'Acte III. Texte', 'Le Voyage en Chine: Acte III. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:298f5989-a659-42e3-b523-d92f7f2f79c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte III. “Quand le soleil sur notre monde” (Pompéry)', part.name_en = 'Le Voyage en Chine: Acte III. “Quand le soleil sur notre monde” (Pompéry)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:78e5b84f-a65e-4584-b77e-57c77010409a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:78e5b84f-a65e-4584-b77e-57c77010409a', 5, NULL, 'Acte III. “Quand le soleil sur notre monde” (Pompéry)', 'Le Voyage en Chine: Acte III. “Quand le soleil sur notre monde” (Pompéry)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78e5b84f-a65e-4584-b77e-57c77010409a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte III. “Faut-il hisser, capitaine” (Tous)', part.name_en = 'Le Voyage en Chine: Acte III. “Faut-il hisser, capitaine” (Tous)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:cbd10f7d-e0b0-49ad-b689-5a6c0024789c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cbd10f7d-e0b0-49ad-b689-5a6c0024789c', 6, NULL, 'Acte III. “Faut-il hisser, capitaine” (Tous)', 'Le Voyage en Chine: Acte III. “Faut-il hisser, capitaine” (Tous)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbd10f7d-e0b0-49ad-b689-5a6c0024789c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte III. “Voguons, la mer est belle” (Chœur)', part.name_en = 'Le Voyage en Chine: Acte III. “Voguons, la mer est belle” (Chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25497 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:d3b51eaa-2653-430f-9fe0-d5942f44a5d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d3b51eaa-2653-430f-9fe0-d5942f44a5d8', 7, NULL, 'Acte III. “Voguons, la mer est belle” (Chœur)', 'Le Voyage en Chine: Acte III. “Voguons, la mer est belle” (Chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7285071c-f871-4376-b410-cafd7235f76a'
WHERE p.id = 25497 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3b51eaa-2653-430f-9fe0-d5942f44a5d8'
);


-- None Le Voyage en Chine: Acte II

UPDATE pieces piece
SET piece.title = 'Le Voyage en Chine: Acte II', piece.title_en = 'Le Voyage en Chine: Acte II',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24055 AND piece.composer_id = 400
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acte II. Texte', part.name_en = 'Le Voyage en Chine: Acte II. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24055 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:26de728b-234f-48d5-9024-1a31ed9d7a86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26de728b-234f-48d5-9024-1a31ed9d7a86', 1, NULL, 'Acte II. Texte', 'Le Voyage en Chine: Acte II. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24055 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26de728b-234f-48d5-9024-1a31ed9d7a86'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acte II. Texte', part.name_en = 'Le Voyage en Chine: Acte II. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24055 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:2db0f0da-346a-4fb7-8317-edd2f2bc067b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2db0f0da-346a-4fb7-8317-edd2f2bc067b', 2, NULL, 'Acte II. Texte', 'Le Voyage en Chine: Acte II. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24055 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2db0f0da-346a-4fb7-8317-edd2f2bc067b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acte II. “Quel temps effroyable” (Les Baigneurs, Kernoisan, Bonneteau, Pompéry, Marie, Rosenville)', part.name_en = 'Le Voyage en Chine: Acte II. “Quel temps effroyable” (Les Baigneurs, Kernoisan, Bonneteau, Pompéry, Marie, Rosenville)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24055 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:372e1cf0-ef7e-4dff-9f26-c72060da9e1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:372e1cf0-ef7e-4dff-9f26-c72060da9e1a', 3, NULL, 'Acte II. “Quel temps effroyable” (Les Baigneurs, Kernoisan, Bonneteau, Pompéry, Marie, Rosenville)', 'Le Voyage en Chine: Acte II. “Quel temps effroyable” (Les Baigneurs, Kernoisan, Bonneteau, Pompéry, Marie, Rosenville)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24055 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:372e1cf0-ef7e-4dff-9f26-c72060da9e1a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acte II. Texte', part.name_en = 'Le Voyage en Chine: Acte II. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24055 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:af3fba1c-bb7c-4dde-aadf-547f2811a4c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af3fba1c-bb7c-4dde-aadf-547f2811a4c7', 4, NULL, 'Acte II. Texte', 'Le Voyage en Chine: Acte II. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24055 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af3fba1c-bb7c-4dde-aadf-547f2811a4c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acte II. “Je suis Breton” (Kernoisan, Pompéry)', part.name_en = 'Le Voyage en Chine: Acte II. “Je suis Breton” (Kernoisan, Pompéry)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24055 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:cc5c22bc-1864-4c6a-8337-20ed26946244' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc5c22bc-1864-4c6a-8337-20ed26946244', 5, NULL, 'Acte II. “Je suis Breton” (Kernoisan, Pompéry)', 'Le Voyage en Chine: Acte II. “Je suis Breton” (Kernoisan, Pompéry)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24055 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc5c22bc-1864-4c6a-8337-20ed26946244'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acte II. “Six cailloux, cinq cailloux” (Rosenville)', part.name_en = 'Le Voyage en Chine: Acte II. “Six cailloux, cinq cailloux” (Rosenville)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24055 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:d1bd36e6-5c7b-420c-b7cd-ebe2d0f7d00b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1bd36e6-5c7b-420c-b7cd-ebe2d0f7d00b', 6, NULL, 'Acte II. “Six cailloux, cinq cailloux” (Rosenville)', 'Le Voyage en Chine: Acte II. “Six cailloux, cinq cailloux” (Rosenville)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24055 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1bd36e6-5c7b-420c-b7cd-ebe2d0f7d00b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acte II. Texte', part.name_en = 'Le Voyage en Chine: Acte II. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24055 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:dd0cfab2-db8b-458a-9547-98dfbac674af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd0cfab2-db8b-458a-9547-98dfbac674af', 7, NULL, 'Acte II. Texte', 'Le Voyage en Chine: Acte II. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24055 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd0cfab2-db8b-458a-9547-98dfbac674af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Acte II. “Ah ! Quelle heureuse destinée” (Chœur, Pompéry, Marie)', part.name_en = 'Le Voyage en Chine: Acte II. “Ah ! Quelle heureuse destinée” (Chœur, Pompéry, Marie)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24055 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:e70afbac-2b0f-460d-9be1-9b8bbf5bc8a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e70afbac-2b0f-460d-9be1-9b8bbf5bc8a9', 8, NULL, 'Acte II. “Ah ! Quelle heureuse destinée” (Chœur, Pompéry, Marie)', 'Le Voyage en Chine: Acte II. “Ah ! Quelle heureuse destinée” (Chœur, Pompéry, Marie)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24055 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e70afbac-2b0f-460d-9be1-9b8bbf5bc8a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Acte II. Texte', part.name_en = 'Le Voyage en Chine: Acte II. Texte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24055 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:e949385c-d9b5-4c26-be1e-636cdefd503e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e949385c-d9b5-4c26-be1e-636cdefd503e', 9, NULL, 'Acte II. Texte', 'Le Voyage en Chine: Acte II. Texte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24055 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e949385c-d9b5-4c26-be1e-636cdefd503e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Acte II. “Fille dénaturée” (Pompéry, Marie, Mme Pompéry, Rosenville, Kernoisan, Berthe)', part.name_en = 'Le Voyage en Chine: Acte II. “Fille dénaturée” (Pompéry, Marie, Mme Pompéry, Rosenville, Kernoisan, Berthe)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24055 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:f947ebe1-a0b4-43d6-9f3d-aed54a82a107' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f947ebe1-a0b4-43d6-9f3d-aed54a82a107', 10, NULL, 'Acte II. “Fille dénaturée” (Pompéry, Marie, Mme Pompéry, Rosenville, Kernoisan, Berthe)', 'Le Voyage en Chine: Acte II. “Fille dénaturée” (Pompéry, Marie, Mme Pompéry, Rosenville, Kernoisan, Berthe)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24055 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f947ebe1-a0b4-43d6-9f3d-aed54a82a107'
);


-- None 오페레타 <Maître Pathelin>

UPDATE pieces piece
SET piece.title = '오페레타 <Maître Pathelin>', piece.title_en = 'Maître Pathelin',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24897 AND piece.composer_id = 400
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '“Veux-tu bien ranger la boutique” (Josseaume, Charlot)', part.name_en = 'Maître Pathelin: “Veux-tu bien ranger la boutique” (Josseaume, Charlot)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24897 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:22941f9a-fab2-4a20-a657-ddc356b8d8a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22941f9a-fab2-4a20-a657-ddc356b8d8a9', 1, NULL, '“Veux-tu bien ranger la boutique” (Josseaume, Charlot)', 'Maître Pathelin: “Veux-tu bien ranger la boutique” (Josseaume, Charlot)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24897 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22941f9a-fab2-4a20-a657-ddc356b8d8a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Romance “Je pense à vous quand je m''éveille“ (Charlot)', part.name_en = 'Maître Pathelin: Romance “Je pense à vous quand je m''éveille“ (Charlot)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24897 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:404190e1-3a87-4f50-92a0-f5bde4868e63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:404190e1-3a87-4f50-92a0-f5bde4868e63', 2, NULL, 'Romance “Je pense à vous quand je m''éveille“ (Charlot)', 'Maître Pathelin: Romance “Je pense à vous quand je m''éveille“ (Charlot)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24897 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:404190e1-3a87-4f50-92a0-f5bde4868e63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '“Quel air de probité” (Pathelin, Josseaume)', part.name_en = 'Maître Pathelin: “Quel air de probité” (Pathelin, Josseaume)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24897 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:460c7463-bfbc-45a9-b480-6203d5a22c03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:460c7463-bfbc-45a9-b480-6203d5a22c03', 3, NULL, '“Quel air de probité” (Pathelin, Josseaume)', 'Maître Pathelin: “Quel air de probité” (Pathelin, Josseaume)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24897 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:460c7463-bfbc-45a9-b480-6203d5a22c03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ouverture', part.name_en = 'Maître Pathelin: Ouverture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24897 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:53cb6e16-def5-4640-a527-b4652c44636e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53cb6e16-def5-4640-a527-b4652c44636e', 4, NULL, 'Ouverture', 'Maître Pathelin: Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24897 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53cb6e16-def5-4640-a527-b4652c44636e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '“Pauvre acocat dans ton état” (Guillemette, Bobinette, Pathelin)', part.name_en = 'Maître Pathelin: “Pauvre acocat dans ton état” (Guillemette, Bobinette, Pathelin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24897 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:6788ec6b-75c2-4e46-8bc8-42389a323476' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6788ec6b-75c2-4e46-8bc8-42389a323476', 5, NULL, '“Pauvre acocat dans ton état” (Guillemette, Bobinette, Pathelin)', 'Maître Pathelin: “Pauvre acocat dans ton état” (Guillemette, Bobinette, Pathelin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24897 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6788ec6b-75c2-4e46-8bc8-42389a323476'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'La romance de maître Pathelin', part.name_en = 'La romance de maître Pathelin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24897 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:67a2be37-13fe-435a-9c58-e350a5b6c077' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67a2be37-13fe-435a-9c58-e350a5b6c077', 6, NULL, 'La romance de maître Pathelin', 'La romance de maître Pathelin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24897 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67a2be37-13fe-435a-9c58-e350a5b6c077'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '“Nous ferons ripaille (Pathelin, Guillemette, Bobinette)', part.name_en = 'Maître Pathelin: “Nous ferons ripaille (Pathelin, Guillemette, Bobinette)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24897 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:7b0dd441-ade1-4419-85b2-efef56963ea1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b0dd441-ade1-4419-85b2-efef56963ea1', 7, NULL, '“Nous ferons ripaille (Pathelin, Guillemette, Bobinette)', 'Maître Pathelin: “Nous ferons ripaille (Pathelin, Guillemette, Bobinette)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24897 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b0dd441-ade1-4419-85b2-efef56963ea1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '“Quand on allait te faire pendre” (Pathelin, Aignelet)', part.name_en = 'Maître Pathelin: “Quand on allait te faire pendre” (Pathelin, Aignelet)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24897 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:b97e7e53-7e45-45f0-8ff2-38cf963005f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b97e7e53-7e45-45f0-8ff2-38cf963005f2', 8, NULL, '“Quand on allait te faire pendre” (Pathelin, Aignelet)', 'Maître Pathelin: “Quand on allait te faire pendre” (Pathelin, Aignelet)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24897 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b97e7e53-7e45-45f0-8ff2-38cf963005f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '“Je suis un avocat d''Ithaque” (Guillemette, Pathelin, Josseaume)', part.name_en = 'Maître Pathelin: “Je suis un avocat d''Ithaque” (Guillemette, Pathelin, Josseaume)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24897 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:bba33cd4-7d5c-4c14-9932-1e617381d39d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bba33cd4-7d5c-4c14-9932-1e617381d39d', 9, NULL, '“Je suis un avocat d''Ithaque” (Guillemette, Pathelin, Josseaume)', 'Maître Pathelin: “Je suis un avocat d''Ithaque” (Guillemette, Pathelin, Josseaume)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24897 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bba33cd4-7d5c-4c14-9932-1e617381d39d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '“C''est effroyable” (Tous)', part.name_en = 'Maître Pathelin: “C''est effroyable” (Tous)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24897 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:e30069d0-f77c-43e1-bac9-f778e4941097' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e30069d0-f77c-43e1-bac9-f778e4941097', 10, NULL, '“C''est effroyable” (Tous)', 'Maître Pathelin: “C''est effroyable” (Tous)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24897 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e30069d0-f77c-43e1-bac9-f778e4941097'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '“Quel triste sort (Aignelet)', part.name_en = 'Maître Pathelin: “Quel triste sort (Aignelet)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24897 AND p.composer_id = 400 AND part.part_key = 'musicbrainz:ea3416ba-39dd-46e5-bceb-a81a3f9b22d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea3416ba-39dd-46e5-bceb-a81a3f9b22d3', 11, NULL, '“Quel triste sort (Aignelet)', 'Maître Pathelin: “Quel triste sort (Aignelet)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24897 AND p.composer_id = 400
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea3416ba-39dd-46e5-bceb-a81a3f9b22d3'
);

-- 숨길 seed 작품 없음

-- ===== Hisato Ohzawa (composer_id 401) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 0, 다악장 2, 낱곡 0),
-- 새 작품 1개, part 7개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 피아노 협주곡 3번 "Kamikaze"

UPDATE pieces piece
SET piece.title = '피아노 협주곡 3번 "Kamikaze"', piece.title_en = 'Piano Concerto No. 3 "Kamikaze"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24848 AND piece.composer_id = 401
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Larghetto maestoso - Allegro assai', part.name_en = 'Piano Concerto No. 3 "Kamikaze": I. Larghetto maestoso - Allegro assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24848 AND p.composer_id = 401 AND part.part_key = 'musicbrainz:f24be643-ee96-4fcf-a8ae-be98d6143c85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f24be643-ee96-4fcf-a8ae-be98d6143c85', 1, 'I', 'Larghetto maestoso - Allegro assai', 'Piano Concerto No. 3 "Kamikaze": I. Larghetto maestoso - Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24848 AND p.composer_id = 401
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f24be643-ee96-4fcf-a8ae-be98d6143c85'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante cantabile', part.name_en = 'Piano Concerto No. 3 "Kamikaze": II. Andante cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24848 AND p.composer_id = 401 AND part.part_key = 'musicbrainz:0f849cad-0d99-4cd4-9c6d-7c0d9079353a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f849cad-0d99-4cd4-9c6d-7c0d9079353a', 2, 'II', 'Andante cantabile', 'Piano Concerto No. 3 "Kamikaze": II. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24848 AND p.composer_id = 401
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f849cad-0d99-4cd4-9c6d-7c0d9079353a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro moderato - Allegro - Vivace', part.name_en = 'Piano Concerto No. 3 "Kamikaze": III. Allegro moderato - Allegro - Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24848 AND p.composer_id = 401 AND part.part_key = 'musicbrainz:9090e161-ba71-4da8-a6fa-96458df89fe4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9090e161-ba71-4da8-a6fa-96458df89fe4', 3, 'III', 'Allegro moderato - Allegro - Vivace', 'Piano Concerto No. 3 "Kamikaze": III. Allegro moderato - Allegro - Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24848 AND p.composer_id = 401
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9090e161-ba71-4da8-a6fa-96458df89fe4'
);


-- None 교향곡 3번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 3번', 'Symphony No. 3', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 401
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 3번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c17918cd-ae99-447f-a0f1-2e03b951f90e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c17918cd-ae99-447f-a0f1-2e03b951f90e'
FROM pieces p
WHERE p.composer_id = 401 AND p.title = '교향곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c17918cd-ae99-447f-a0f1-2e03b951f90e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d5601e6-1d5a-4029-a529-0140db708d12', 1, 'I', 'Allegretto risoluto - Allegro', 'Symphony No. 3 "Symphony of the Founding of Japan": I. Allegretto risoluto - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 401 AND p.title = '교향곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d5601e6-1d5a-4029-a529-0140db708d12'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fcddfe3-00e1-43f6-a503-4690e7085fc7', 2, 'II', 'Adagio grazioso', 'Symphony No. 3 "Symphony of the Founding of Japan": II. Adagio grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 401 AND p.title = '교향곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fcddfe3-00e1-43f6-a503-4690e7085fc7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19625ca9-bf11-43fc-8cdb-3eb2a64126d3', 3, 'III', 'Moderato (Menuet con fantasia)', 'Symphony No. 3 "Symphony of the Founding of Japan": III. Moderato (Menuet con fantasia)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 401 AND p.title = '교향곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19625ca9-bf11-43fc-8cdb-3eb2a64126d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:575b5fa9-2bc0-414c-be83-acb75cb97cac', 4, 'IV', 'Allegro non troppo con fuoco', 'Symphony No. 3 "Symphony of the Founding of Japan": IV. Allegro non troppo con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 401 AND p.title = '교향곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:575b5fa9-2bc0-414c-be83-acb75cb97cac'
);

-- 숨길 seed 작품 없음

-- ===== 아서 버거 (composer_id 404) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 5개(묶음 1, 다악장 0, 낱곡 4),
-- 새 작품 0개, part 3개, 그 아래 0개.
-- seed 5개 중 5개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Ideas of Order

UPDATE pieces piece
SET piece.title = 'Ideas of Order', piece.title_en = 'Ideas of Order',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25528 AND piece.composer_id = 404
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Perspectives II

UPDATE pieces piece
SET piece.title = 'Perspectives II', piece.title_en = 'Perspectives II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25754 AND piece.composer_id = 404
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Polyphony

UPDATE pieces piece
SET piece.title = 'Polyphony', piece.title_en = 'Polyphony',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24355 AND piece.composer_id = 404
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Prelude, Aria and Waltz

UPDATE pieces piece
SET piece.title = 'Prelude, Aria and Waltz', piece.title_en = 'Prelude, Aria and Waltz',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25536 AND piece.composer_id = 404
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelude', part.name_en = 'Prelude, Aria and Waltz: Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25536 AND p.composer_id = 404 AND part.part_key = 'musicbrainz:82ce9a05-1ebb-4ce4-b6a0-1bf8442c7ebd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82ce9a05-1ebb-4ce4-b6a0-1bf8442c7ebd', 1, NULL, 'Prelude', 'Prelude, Aria and Waltz: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25536 AND p.composer_id = 404
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82ce9a05-1ebb-4ce4-b6a0-1bf8442c7ebd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Aria', part.name_en = 'Prelude, Aria and Waltz: Aria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25536 AND p.composer_id = 404 AND part.part_key = 'musicbrainz:7020b71a-a124-4625-9a60-700650526412' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7020b71a-a124-4625-9a60-700650526412', 2, NULL, 'Aria', 'Prelude, Aria and Waltz: Aria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25536 AND p.composer_id = 404
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7020b71a-a124-4625-9a60-700650526412'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Waltz', part.name_en = 'Prelude, Aria and Waltz: Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25536 AND p.composer_id = 404 AND part.part_key = 'musicbrainz:7e420216-12fb-4aca-9379-b0eda53504e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e420216-12fb-4aca-9379-b0eda53504e1', 3, NULL, 'Waltz', 'Prelude, Aria and Waltz: Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25536 AND p.composer_id = 404
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e420216-12fb-4aca-9379-b0eda53504e1'
);


-- None Serenade Concertante

UPDATE pieces piece
SET piece.title = 'Serenade Concertante', piece.title_en = 'Serenade Concertante',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24879 AND piece.composer_id = 404
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Murray Boren (composer_id 406) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 0개(묶음 0, 다악장 0, 낱곡 0),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 0개를 작품·part 에 잇고, 0개를 숨기고, 1개는 그대로 둔다.

-- 숨길 seed 작품 없음

-- ===== Waldemar Kazanecki (composer_id 408) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 0, 다악장 0, 낱곡 2),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 2개 중 2개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 영화음악 <Cygańska jesień>

UPDATE pieces piece
SET piece.title = '영화음악 <Cygańska jesień>', piece.title_en = 'Cygańska jesień',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25777 AND piece.composer_id = 408
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None For One String

UPDATE pieces piece
SET piece.title = 'For One String', piece.title_en = 'For One String',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 26000 AND piece.composer_id = 408
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Geoffrey Shaw (composer_id 409) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 3개(묶음 0, 다악장 0, 낱곡 3),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 가곡 <For the beauty of the earth>

UPDATE pieces piece
SET piece.title = '가곡 <For the beauty of the earth>', piece.title_en = 'For the beauty of the earth',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24429 AND piece.composer_id = 409
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Glad That I Live Am I>

UPDATE pieces piece
SET piece.title = '가곡 <Glad That I Live Am I>', piece.title_en = 'Glad That I Live Am I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25814 AND piece.composer_id = 409
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Variations on an Old Carol Tune

UPDATE pieces piece
SET piece.title = 'Variations on an Old Carol Tune', piece.title_en = 'Variations on an Old Carol Tune',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24620 AND piece.composer_id = 409
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Nicholas O'Neill (composer_id 414) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Ave verum corpus

UPDATE pieces piece
SET piece.title = 'Ave verum corpus', piece.title_en = 'Ave verum corpus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24918 AND piece.composer_id = 414
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Bernardo Adam Ferrero (composer_id 416) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 0개(묶음 0, 다악장 0, 낱곡 0),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 4개 중 0개를 작품·part 에 잇고, 0개를 숨기고, 4개는 그대로 둔다.

-- 숨길 seed 작품 없음

-- ===== 쿠르트 슈베르치크 (composer_id 420) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 7개(묶음 0, 다악장 5, 낱곡 2),
-- 새 작품 0개, part 22개, 그 아래 0개.
-- seed 7개 중 7개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- Op. 86 Adieu Satie

UPDATE pieces piece
SET piece.title = 'Adieu Satie', piece.title_en = 'Adieu Satie, op. 86',
    piece.type = 'album', piece.opus_number = 'Op. 86',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24258 AND piece.composer_id = 420
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Parade', part.name_en = 'Adieu Satie, op. 86: I. Parade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24258 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:6d853c8e-2095-4af0-ab47-f40e541d42d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d853c8e-2095-4af0-ab47-f40e541d42d6', 1, 'I', 'Parade', 'Adieu Satie, op. 86: I. Parade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24258 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d853c8e-2095-4af0-ab47-f40e541d42d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Darius en vacances', part.name_en = 'Adieu Satie, op. 86: II. Darius en vacances',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24258 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:8c30d6be-6ed2-4e9d-a739-cc6021b39f44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c30d6be-6ed2-4e9d-a739-cc6021b39f44', 2, 'II', 'Darius en vacances', 'Adieu Satie, op. 86: II. Darius en vacances', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24258 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c30d6be-6ed2-4e9d-a739-cc6021b39f44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Le Coq et l''Arlequin', part.name_en = 'Adieu Satie, op. 86: III. Le Coq et l''Arlequin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24258 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:21684d2e-5990-46fe-b01c-437543b51c7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21684d2e-5990-46fe-b01c-437543b51c7f', 3, 'III', 'Le Coq et l''Arlequin', 'Adieu Satie, op. 86: III. Le Coq et l''Arlequin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24258 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21684d2e-5990-46fe-b01c-437543b51c7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Gymnopédie', part.name_en = 'Adieu Satie, op. 86: IV. Gymnopédie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24258 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:29e265c8-998c-4f8d-b14e-344de11a9b12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29e265c8-998c-4f8d-b14e-344de11a9b12', 4, 'IV', 'Gymnopédie', 'Adieu Satie, op. 86: IV. Gymnopédie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24258 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29e265c8-998c-4f8d-b14e-344de11a9b12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Clownerie acrobatique', part.name_en = 'Adieu Satie, op. 86: V. Clownerie acrobatique',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24258 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:6521be3a-003b-40de-9d8e-619f72010fed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6521be3a-003b-40de-9d8e-619f72010fed', 5, 'V', 'Clownerie acrobatique', 'Adieu Satie, op. 86: V. Clownerie acrobatique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24258 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6521be3a-003b-40de-9d8e-619f72010fed'
);


-- Op. 65 Baumgesänge

UPDATE pieces piece
SET piece.title = 'Baumgesänge', piece.title_en = 'Baumgesänge, op. 65',
    piece.type = 'album', piece.opus_number = 'Op. 65',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25257 AND piece.composer_id = 420
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Breit gesungen (Cantabile, ma pesante)', part.name_en = 'Baumgesänge, op. 65: I. Breit gesungen (Cantabile, ma pesante)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25257 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:2adea239-8594-4980-9979-4f02e6776017' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2adea239-8594-4980-9979-4f02e6776017', 1, 'I', 'Breit gesungen (Cantabile, ma pesante)', 'Baumgesänge, op. 65: I. Breit gesungen (Cantabile, ma pesante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25257 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2adea239-8594-4980-9979-4f02e6776017'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lebhaft, Agressiv (Vivace)', part.name_en = 'Baumgesänge, op. 65: II. Lebhaft, Agressiv (Vivace)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25257 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:c66cbd4d-44d1-4ae1-9157-2e442c8cff08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c66cbd4d-44d1-4ae1-9157-2e442c8cff08', 2, 'II', 'Lebhaft, Agressiv (Vivace)', 'Baumgesänge, op. 65: II. Lebhaft, Agressiv (Vivace)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25257 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c66cbd4d-44d1-4ae1-9157-2e442c8cff08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Bleischwer (Molto pesante)', part.name_en = 'Baumgesänge, op. 65: III. Bleischwer (Molto pesante)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25257 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:80df14c1-8be0-4927-989e-2435b4826ca4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80df14c1-8be0-4927-989e-2435b4826ca4', 3, 'III', 'Bleischwer (Molto pesante)', 'Baumgesänge, op. 65: III. Bleischwer (Molto pesante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25257 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80df14c1-8be0-4927-989e-2435b4826ca4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sehr gedehnt (Allagare il Tempo)', part.name_en = 'Baumgesänge, op. 65: IV. Sehr gedehnt (Allagare il Tempo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25257 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:6a8c98e9-ffe5-4dd2-8d82-8ce87e876d81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a8c98e9-ffe5-4dd2-8d82-8ce87e876d81', 4, 'IV', 'Sehr gedehnt (Allagare il Tempo)', 'Baumgesänge, op. 65: IV. Sehr gedehnt (Allagare il Tempo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25257 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a8c98e9-ffe5-4dd2-8d82-8ce87e876d81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Beweglich (Poco rubato)', part.name_en = 'Baumgesänge, op. 65: V. Beweglich (Poco rubato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25257 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:5bcda00a-2784-4f77-a14c-5aaff7ab0cc5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bcda00a-2784-4f77-a14c-5aaff7ab0cc5', 5, 'V', 'Beweglich (Poco rubato)', 'Baumgesänge, op. 65: V. Beweglich (Poco rubato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25257 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bcda00a-2784-4f77-a14c-5aaff7ab0cc5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Lebhaft, Agressiv (Vivace)', part.name_en = 'Baumgesänge, op. 65: VI. Lebhaft, Agressiv (Vivace)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25257 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:23bc890d-c43d-4c21-9ec8-3cfc43dad494' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23bc890d-c43d-4c21-9ec8-3cfc43dad494', 6, 'VI', 'Lebhaft, Agressiv (Vivace)', 'Baumgesänge, op. 65: VI. Lebhaft, Agressiv (Vivace)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25257 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23bc890d-c43d-4c21-9ec8-3cfc43dad494'
);


-- Op. 33 Epilog zu Rosamunde

UPDATE pieces piece
SET piece.title = 'Epilog zu Rosamunde', piece.title_en = 'Epilog zu Rosamunde, op. 33',
    piece.type = 'song', piece.opus_number = 'Op. 33',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24990 AND piece.composer_id = 420
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 101 Herr K entdeckt Amerika

UPDATE pieces piece
SET piece.title = 'Herr K entdeckt Amerika', piece.title_en = 'Herr K entdeckt Amerika, op. 101',
    piece.type = 'album', piece.opus_number = 'Op. 101',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25715 AND piece.composer_id = 420
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Überfahrt', part.name_en = 'Herr K entdeckt Amerika, op. 101: I. Überfahrt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25715 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:066de9e1-0390-4703-bacd-8ef1c1d5381c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:066de9e1-0390-4703-bacd-8ef1c1d5381c', 1, 'I', 'Überfahrt', 'Herr K entdeckt Amerika, op. 101: I. Überfahrt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25715 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:066de9e1-0390-4703-bacd-8ef1c1d5381c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Im Hotel', part.name_en = 'Herr K entdeckt Amerika, op. 101: II. Im Hotel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25715 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:19a6f500-54aa-41ef-b250-446177cef4b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19a6f500-54aa-41ef-b250-446177cef4b4', 2, 'II', 'Im Hotel', 'Herr K entdeckt Amerika, op. 101: II. Im Hotel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25715 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19a6f500-54aa-41ef-b250-446177cef4b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Unterwegs', part.name_en = 'Herr K entdeckt Amerika, op. 101: III. Unterwegs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25715 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:a4ba97a1-83ca-4107-bc64-53b1b28ef037' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4ba97a1-83ca-4107-bc64-53b1b28ef037', 3, 'III', 'Unterwegs', 'Herr K entdeckt Amerika, op. 101: III. Unterwegs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25715 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4ba97a1-83ca-4107-bc64-53b1b28ef037'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Das Naturtheater von Oklahoma', part.name_en = 'Herr K entdeckt Amerika, op. 101: IV. Das Naturtheater von Oklahoma',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25715 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:e6952653-3b16-44ab-a211-e77d9a9e3096' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6952653-3b16-44ab-a211-e77d9a9e3096', 4, 'IV', 'Das Naturtheater von Oklahoma', 'Herr K entdeckt Amerika, op. 101: IV. Das Naturtheater von Oklahoma', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25715 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6952653-3b16-44ab-a211-e77d9a9e3096'
);


-- None Locken-House/Un-Locked

UPDATE pieces piece
SET piece.title = 'Locken-House/Un-Locked', piece.title_en = 'Locken-House/Un-Locked',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24324 AND piece.composer_id = 420
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 104 Nachtmusiken

UPDATE pieces piece
SET piece.title = 'Nachtmusiken', piece.title_en = 'Nachtmusiken, op. 104',
    piece.type = 'album', piece.opus_number = 'Op. 104',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24342 AND piece.composer_id = 420
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Janáček ist mir im Traum erschienen', part.name_en = 'Nachtmusiken, op. 104: I. Janáček ist mir im Traum erschienen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24342 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:2835718a-b9f1-49d9-b61f-89c8522027e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2835718a-b9f1-49d9-b61f-89c8522027e1', 1, 'I', 'Janáček ist mir im Traum erschienen', 'Nachtmusiken, op. 104: I. Janáček ist mir im Traum erschienen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24342 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2835718a-b9f1-49d9-b61f-89c8522027e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Wienerlied', part.name_en = 'Nachtmusiken, op. 104: II. Wienerlied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24342 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:7520cadb-ef85-40d6-b4af-94cc06d7b0a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7520cadb-ef85-40d6-b4af-94cc06d7b0a2', 2, 'II', 'Wienerlied', 'Nachtmusiken, op. 104: II. Wienerlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24342 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7520cadb-ef85-40d6-b4af-94cc06d7b0a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'for David Drew', part.name_en = 'Nachtmusiken, op. 104: III. ... for David Drew',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24342 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:4f0d2bad-a875-4360-9607-47beac3aad11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f0d2bad-a875-4360-9607-47beac3aad11', 3, 'III', 'for David Drew', 'Nachtmusiken, op. 104: III. ... for David Drew', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24342 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f0d2bad-a875-4360-9607-47beac3aad11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Geschwindmarsch', part.name_en = 'Nachtmusiken, op. 104: IV. Geschwindmarsch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24342 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:d4973260-afcd-4c9a-a6dd-38c90daded43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4973260-afcd-4c9a-a6dd-38c90daded43', 4, 'IV', 'Geschwindmarsch', 'Nachtmusiken, op. 104: IV. Geschwindmarsch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24342 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4973260-afcd-4c9a-a6dd-38c90daded43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Flucht', part.name_en = 'Nachtmusiken, op. 104: V. Flucht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24342 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:c1998649-8477-4034-8cb9-9b71f27a2e63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1998649-8477-4034-8cb9-9b71f27a2e63', 5, 'V', 'Flucht', 'Nachtmusiken, op. 104: V. Flucht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24342 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1998649-8477-4034-8cb9-9b71f27a2e63'
);


-- None Unterwegs nach Heiligenstadt

UPDATE pieces piece
SET piece.title = 'Unterwegs nach Heiligenstadt', piece.title_en = 'Unterwegs nach Heiligenstadt',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23571 AND piece.composer_id = 420
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Energico', part.name_en = 'Unterwegs nach Heiligenstadt: I. Energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23571 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:ee349e11-d57c-4e5f-a1bf-c77f259ed5d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee349e11-d57c-4e5f-a1bf-c77f259ed5d8', 1, 'I', 'Energico', 'Unterwegs nach Heiligenstadt: I. Energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23571 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee349e11-d57c-4e5f-a1bf-c77f259ed5d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Tranquillo', part.name_en = 'Unterwegs nach Heiligenstadt: II. Tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23571 AND p.composer_id = 420 AND part.part_key = 'musicbrainz:143ece2e-a119-4672-bb01-c029cfec15a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:143ece2e-a119-4672-bb01-c029cfec15a0', 2, 'II', 'Tranquillo', 'Unterwegs nach Heiligenstadt: II. Tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23571 AND p.composer_id = 420
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:143ece2e-a119-4672-bb01-c029cfec15a0'
);

-- 숨길 seed 작품 없음

-- ===== José Luis Turina (composer_id 422) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 0, 다악장 0, 낱곡 2),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 2개 중 2개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Divertimento, Aria y Serenata

UPDATE pieces piece
SET piece.title = 'Divertimento, Aria y Serenata', piece.title_en = 'Divertimento, Aria y Serenata',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24180 AND piece.composer_id = 422
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Movimiento

UPDATE pieces piece
SET piece.title = 'Movimiento', piece.title_en = 'Movimiento',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23541 AND piece.composer_id = 422
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== 장프랑수아 르쉬외르 (composer_id 423) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 5개(묶음 1, 다악장 0, 낱곡 4),
-- 새 작품 0개, part 16개, 그 아래 0개.
-- seed 6개 중 5개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.

-- None Hymne pour l’inauguration d’un temple de la Liberté

UPDATE pieces piece
SET piece.title = 'Hymne pour l’inauguration d’un temple de la Liberté', piece.title_en = 'Hymne pour l’inauguration d’un temple de la Liberté',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24321 AND piece.composer_id = 423
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Marche du Sacre de Napoléon 1er

UPDATE pieces piece
SET piece.title = 'Marche du Sacre de Napoléon 1er', piece.title_en = 'Marche du Sacre de Napoléon 1er',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23060 AND piece.composer_id = 423
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Oratorios pour le couronnement des princes souverains de la chrétienté

UPDATE pieces piece
SET piece.title = 'Oratorios pour le couronnement des princes souverains de la chrétienté', piece.title_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24606 AND piece.composer_id = 423
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andantino religioso', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Andantino religioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:01f4d296-968d-4617-8580-298b201bd3e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01f4d296-968d-4617-8580-298b201bd3e4', 1, NULL, 'Andantino religioso', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Andantino religioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01f4d296-968d-4617-8580-298b201bd3e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegretto pomposo', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegretto pomposo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:3ed38b63-843e-47de-b5b5-d186211b5d95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ed38b63-843e-47de-b5b5-d186211b5d95', 2, NULL, 'Allegretto pomposo', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegretto pomposo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ed38b63-843e-47de-b5b5-d186211b5d95'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro pomposo', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro pomposo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:4e03e0a1-dfd2-4fd2-a907-70957954bff0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e03e0a1-dfd2-4fd2-a907-70957954bff0', 3, NULL, 'Allegro pomposo', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro pomposo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e03e0a1-dfd2-4fd2-a907-70957954bff0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Allegro commodo', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro commodo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:501d4034-c118-45a2-a780-91c5ae7c87c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:501d4034-c118-45a2-a780-91c5ae7c87c3', 4, NULL, 'Allegro commodo', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro commodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:501d4034-c118-45a2-a780-91c5ae7c87c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:650bc14a-4d1a-45f1-ba98-75c124dcf0cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:650bc14a-4d1a-45f1-ba98-75c124dcf0cf', 5, NULL, 'Allegretto', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:650bc14a-4d1a-45f1-ba98-75c124dcf0cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Moderato religioso', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Moderato religioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:81a0af87-5003-42b1-b488-62cfe071b465' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81a0af87-5003-42b1-b488-62cfe071b465', 6, NULL, 'Moderato religioso', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Moderato religioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81a0af87-5003-42b1-b488-62cfe071b465'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'In poco lento cum antique caractere', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: In poco lento cum antique caractere',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:8afa2c87-b563-4f89-b68a-672771ba6eb8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8afa2c87-b563-4f89-b68a-672771ba6eb8', 7, NULL, 'In poco lento cum antique caractere', 'Oratorios pour le couronnement des princes souverains de la chrétienté: In poco lento cum antique caractere', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8afa2c87-b563-4f89-b68a-672771ba6eb8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Lento sempre', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Lento sempre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:8b3a6a9b-bc7f-4b8a-80a0-1d58c8d098f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b3a6a9b-bc7f-4b8a-80a0-1d58c8d098f4', 8, NULL, 'Lento sempre', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Lento sempre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b3a6a9b-bc7f-4b8a-80a0-1d58c8d098f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Allegro commodo', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro commodo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:8ff03914-8282-46c7-94b1-b8d3fe4d3f65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ff03914-8282-46c7-94b1-b8d3fe4d3f65', 9, NULL, 'Allegro commodo', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro commodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ff03914-8282-46c7-94b1-b8d3fe4d3f65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Allegro spirituoso', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro spirituoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:b185891b-2fe9-448a-ba05-87d7841339e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b185891b-2fe9-448a-ba05-87d7841339e9', 10, NULL, 'Allegro spirituoso', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro spirituoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b185891b-2fe9-448a-ba05-87d7841339e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Moderato nobile', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Moderato nobile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:b43e9016-de9f-4465-b8ae-9d72775b24b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b43e9016-de9f-4465-b8ae-9d72775b24b8', 11, NULL, 'Moderato nobile', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Moderato nobile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b43e9016-de9f-4465-b8ae-9d72775b24b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Allegro fieramente', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro fieramente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:b63a8274-2594-4215-888c-970ca9d57280' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b63a8274-2594-4215-888c-970ca9d57280', 12, NULL, 'Allegro fieramente', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro fieramente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b63a8274-2594-4215-888c-970ca9d57280'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Gracioso affettuoso, ma fieramente', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Gracioso affettuoso, ma fieramente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:dfb58c82-80d9-4055-b5b4-4557d70656e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfb58c82-80d9-4055-b5b4-4557d70656e0', 13, NULL, 'Gracioso affettuoso, ma fieramente', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Gracioso affettuoso, ma fieramente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfb58c82-80d9-4055-b5b4-4557d70656e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Allegretto pomposo e nobile', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegretto pomposo e nobile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:ea0c0ace-94ca-49ac-82c8-349d0ddfa5a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea0c0ace-94ca-49ac-82c8-349d0ddfa5a1', 14, NULL, 'Allegretto pomposo e nobile', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegretto pomposo e nobile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea0c0ace-94ca-49ac-82c8-349d0ddfa5a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Allegro commodo', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro commodo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:f3b4e9d9-ad48-41de-bec3-27aaf82bff32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3b4e9d9-ad48-41de-bec3-27aaf82bff32', 15, NULL, 'Allegro commodo', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Allegro commodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3b4e9d9-ad48-41de-bec3-27aaf82bff32'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Moderato affettuoso collo stele antico', part.name_en = 'Oratorios pour le couronnement des princes souverains de la chrétienté: Moderato affettuoso collo stele antico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24606 AND p.composer_id = 423 AND part.part_key = 'musicbrainz:fbf25c78-2b65-4b26-87b7-acc25dc7aa08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbf25c78-2b65-4b26-87b7-acc25dc7aa08', 16, NULL, 'Moderato affettuoso collo stele antico', 'Oratorios pour le couronnement des princes souverains de la chrétienté: Moderato affettuoso collo stele antico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24606 AND p.composer_id = 423
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbf25c78-2b65-4b26-87b7-acc25dc7aa08'
);


-- None 모테트 <Tu es Petrus>

UPDATE pieces piece
SET piece.title = '모테트 <Tu es Petrus>', piece.title_en = 'Tu es Petrus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24978 AND piece.composer_id = 423
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모테트 <Unxerunt Salomonem>

UPDATE pieces piece
SET piece.title = '모테트 <Unxerunt Salomonem>', piece.title_en = 'Unxerunt Salomonem',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23649 AND piece.composer_id = 423
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 423 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    23860
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Jaroslav Krček (composer_id 425) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 1, 다악장 0, 낱곡 0),
-- 새 작품 0개, part 6개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Mše č.9

UPDATE pieces piece
SET piece.title = 'Mše č.9', piece.title_en = 'Mše č.9',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25103 AND piece.composer_id = 425
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Kyrie', part.name_en = 'Mše č.9: Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25103 AND p.composer_id = 425 AND part.part_key = 'musicbrainz:c4c8ceff-1240-4d36-b359-0c8682cc735a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4c8ceff-1240-4d36-b359-0c8682cc735a', 1, NULL, 'Kyrie', 'Mše č.9: Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25103 AND p.composer_id = 425
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4c8ceff-1240-4d36-b359-0c8682cc735a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Gloria', part.name_en = 'Mše č.9: Gloria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25103 AND p.composer_id = 425 AND part.part_key = 'musicbrainz:b44263e3-6468-43c8-b276-dd1ae8f4d4e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b44263e3-6468-43c8-b276-dd1ae8f4d4e8', 2, NULL, 'Gloria', 'Mše č.9: Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25103 AND p.composer_id = 425
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b44263e3-6468-43c8-b276-dd1ae8f4d4e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Credo', part.name_en = 'Mše č.9: Credo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25103 AND p.composer_id = 425 AND part.part_key = 'musicbrainz:4896a694-774a-403b-8ea4-c7750de863bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4896a694-774a-403b-8ea4-c7750de863bd', 3, NULL, 'Credo', 'Mše č.9: Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25103 AND p.composer_id = 425
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4896a694-774a-403b-8ea4-c7750de863bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sanctus', part.name_en = 'Mše č.9: Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25103 AND p.composer_id = 425 AND part.part_key = 'musicbrainz:49fae751-d4af-4594-b4af-5292f647e9af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49fae751-d4af-4594-b4af-5292f647e9af', 4, NULL, 'Sanctus', 'Mše č.9: Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25103 AND p.composer_id = 425
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49fae751-d4af-4594-b4af-5292f647e9af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Benedictus', part.name_en = 'Mše č.9: Benedictus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25103 AND p.composer_id = 425 AND part.part_key = 'musicbrainz:e937c573-d93b-4849-935f-d1ea49b6a899' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e937c573-d93b-4849-935f-d1ea49b6a899', 5, NULL, 'Benedictus', 'Mše č.9: Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25103 AND p.composer_id = 425
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e937c573-d93b-4849-935f-d1ea49b6a899'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Agnus Dei', part.name_en = 'Mše č.9: Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25103 AND p.composer_id = 425 AND part.part_key = 'musicbrainz:64fcf069-9d23-4850-bea4-94333a3db486' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64fcf069-9d23-4850-bea4-94333a3db486', 6, NULL, 'Agnus Dei', 'Mše č.9: Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25103 AND p.composer_id = 425
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64fcf069-9d23-4850-bea4-94333a3db486'
);

-- 숨길 seed 작품 없음

-- ===== Mieko Shiomi (composer_id 428) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 3개(묶음 1, 다악장 0, 낱곡 2),
-- 새 작품 0개, part 80개, 그 아래 0개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None A Celestial Tune by 108 Glass Marbles

UPDATE pieces piece
SET piece.title = 'A Celestial Tune by 108 Glass Marbles', piece.title_en = 'A Celestial Tune by 108 Glass Marbles',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25571 AND piece.composer_id = 428
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Boundary Music

UPDATE pieces piece
SET piece.title = 'Boundary Music', piece.title_en = 'Boundary Music',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24554 AND piece.composer_id = 428
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fluxus Suite

UPDATE pieces piece
SET piece.title = 'Fluxus Suite', piece.title_en = 'Fluxus Suite',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24261 AND piece.composer_id = 428
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ludwig Gosewitz', part.name_en = 'Fluxus Suite: Ludwig Gosewitz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:06aed801-0f6b-4538-8df4-9d648c1f8c7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06aed801-0f6b-4538-8df4-9d648c1f8c7b', 1, NULL, 'Ludwig Gosewitz', 'Fluxus Suite: Ludwig Gosewitz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06aed801-0f6b-4538-8df4-9d648c1f8c7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Pauline Oliveros', part.name_en = 'Fluxus Suite: Pauline Oliveros',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:09bce5b3-2406-4f34-84dd-6f9573a1f6d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09bce5b3-2406-4f34-84dd-6f9573a1f6d9', 2, NULL, 'Pauline Oliveros', 'Fluxus Suite: Pauline Oliveros', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09bce5b3-2406-4f34-84dd-6f9573a1f6d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Mieko Shiomi', part.name_en = 'Fluxus Suite: Mieko Shiomi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:18874eb7-5736-46e8-8975-540ceffe56a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18874eb7-5736-46e8-8975-540ceffe56a2', 3, NULL, 'Mieko Shiomi', 'Fluxus Suite: Mieko Shiomi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18874eb7-5736-46e8-8975-540ceffe56a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Tomas Schmit', part.name_en = 'Fluxus Suite: Tomas Schmit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:19f0e1c7-2f18-438b-87fb-698cbfb21219' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19f0e1c7-2f18-438b-87fb-698cbfb21219', 4, NULL, 'Tomas Schmit', 'Fluxus Suite: Tomas Schmit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19f0e1c7-2f18-438b-87fb-698cbfb21219'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Giuseppe Chiari', part.name_en = 'Fluxus Suite: Giuseppe Chiari',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:1f1bd3bc-7884-439a-8857-7a219e4642a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f1bd3bc-7884-439a-8857-7a219e4642a6', 5, NULL, 'Giuseppe Chiari', 'Fluxus Suite: Giuseppe Chiari', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f1bd3bc-7884-439a-8857-7a219e4642a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Armin Hundertmark', part.name_en = 'Fluxus Suite: Armin Hundertmark',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:277e81c6-0b49-4736-869f-0153efb0c782' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:277e81c6-0b49-4736-869f-0153efb0c782', 6, NULL, 'Armin Hundertmark', 'Fluxus Suite: Armin Hundertmark', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:277e81c6-0b49-4736-869f-0153efb0c782'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Robert Watts', part.name_en = 'Fluxus Suite: Robert Watts',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:2aaf9438-e88d-4df5-98e0-f4a4ec572af2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2aaf9438-e88d-4df5-98e0-f4a4ec572af2', 7, NULL, 'Robert Watts', 'Fluxus Suite: Robert Watts', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2aaf9438-e88d-4df5-98e0-f4a4ec572af2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Gilbert Silverman', part.name_en = 'Fluxus Suite: Gilbert Silverman',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:2d4dbe42-88d1-4d65-865d-c69b803973d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d4dbe42-88d1-4d65-865d-c69b803973d2', 8, NULL, 'Gilbert Silverman', 'Fluxus Suite: Gilbert Silverman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d4dbe42-88d1-4d65-865d-c69b803973d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Hermann Nitsch', part.name_en = 'Fluxus Suite: Hermann Nitsch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:337dbc8e-8dc7-4b7f-944c-4d221f7d56b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:337dbc8e-8dc7-4b7f-944c-4d221f7d56b2', 9, NULL, 'Hermann Nitsch', 'Fluxus Suite: Hermann Nitsch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:337dbc8e-8dc7-4b7f-944c-4d221f7d56b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Harry Ruhé', part.name_en = 'Fluxus Suite: Harry Ruhé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:352157ba-407f-47fa-b0dd-317bac7e1108' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:352157ba-407f-47fa-b0dd-317bac7e1108', 10, NULL, 'Harry Ruhé', 'Fluxus Suite: Harry Ruhé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:352157ba-407f-47fa-b0dd-317bac7e1108'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Serge Oldenbourg', part.name_en = 'Fluxus Suite: Serge Oldenbourg',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:397d9bd9-d523-4938-a442-d256459efc26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:397d9bd9-d523-4938-a442-d256459efc26', 11, NULL, 'Serge Oldenbourg', 'Fluxus Suite: Serge Oldenbourg', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:397d9bd9-d523-4938-a442-d256459efc26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Shigeko Kubota', part.name_en = 'Fluxus Suite: Shigeko Kubota',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:3b6f2ac7-4414-43c3-8fd1-dea7376adeb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b6f2ac7-4414-43c3-8fd1-dea7376adeb4', 12, NULL, 'Shigeko Kubota', 'Fluxus Suite: Shigeko Kubota', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b6f2ac7-4414-43c3-8fd1-dea7376adeb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Dietrich Albrecht', part.name_en = 'Fluxus Suite: Dietrich Albrecht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:3c043eb0-51c6-4163-a25a-eea63f940723' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c043eb0-51c6-4163-a25a-eea63f940723', 13, NULL, 'Dietrich Albrecht', 'Fluxus Suite: Dietrich Albrecht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c043eb0-51c6-4163-a25a-eea63f940723'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Jackson Mac Low', part.name_en = 'Fluxus Suite: Jackson Mac Low',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:3fea42fd-fe1d-4b0f-85bf-eef947e4a788' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fea42fd-fe1d-4b0f-85bf-eef947e4a788', 14, NULL, 'Jackson Mac Low', 'Fluxus Suite: Jackson Mac Low', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fea42fd-fe1d-4b0f-85bf-eef947e4a788'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Juan Hidalgo', part.name_en = 'Fluxus Suite: Juan Hidalgo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:42b0488b-bbdb-41bb-a864-41f6df2344ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42b0488b-bbdb-41bb-a864-41f6df2344ac', 15, NULL, 'Juan Hidalgo', 'Fluxus Suite: Juan Hidalgo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42b0488b-bbdb-41bb-a864-41f6df2344ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Daniel Spoerri', part.name_en = 'Fluxus Suite: Daniel Spoerri',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:470d2260-a0f5-4962-84cf-744143245d05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:470d2260-a0f5-4962-84cf-744143245d05', 16, NULL, 'Daniel Spoerri', 'Fluxus Suite: Daniel Spoerri', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:470d2260-a0f5-4962-84cf-744143245d05'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Henry Flynt', part.name_en = 'Fluxus Suite: Henry Flynt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:49445619-6d11-4422-a844-88518b7bc1c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49445619-6d11-4422-a844-88518b7bc1c5', 17, NULL, 'Henry Flynt', 'Fluxus Suite: Henry Flynt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49445619-6d11-4422-a844-88518b7bc1c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Stanley Brouwn', part.name_en = 'Fluxus Suite: Stanley Brouwn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:4a10edc4-952e-4db9-a85d-f8334d75f946' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a10edc4-952e-4db9-a85d-f8334d75f946', 18, NULL, 'Stanley Brouwn', 'Fluxus Suite: Stanley Brouwn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a10edc4-952e-4db9-a85d-f8334d75f946'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'John Cage', part.name_en = 'Fluxus Suite: John Cage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:52c30738-d696-4227-acd6-7fccc0ba31f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52c30738-d696-4227-acd6-7fccc0ba31f8', 19, NULL, 'John Cage', 'Fluxus Suite: John Cage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52c30738-d696-4227-acd6-7fccc0ba31f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Luigi Bonotto', part.name_en = 'Fluxus Suite: Luigi Bonotto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:5454e0cc-c6d5-40c4-9895-1560dc7e5295' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5454e0cc-c6d5-40c4-9895-1560dc7e5295', 20, NULL, 'Luigi Bonotto', 'Fluxus Suite: Luigi Bonotto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5454e0cc-c6d5-40c4-9895-1560dc7e5295'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Yasunao Tone', part.name_en = 'Fluxus Suite: Yasunao Tone',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:5a306d2c-4514-4485-92ab-11a16d209b0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a306d2c-4514-4485-92ab-11a16d209b0e', 21, NULL, 'Yasunao Tone', 'Fluxus Suite: Yasunao Tone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a306d2c-4514-4485-92ab-11a16d209b0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Emmett Williams', part.name_en = 'Fluxus Suite: Emmett Williams',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:5ac89cb5-3d6b-4f50-97bd-8a7d27c28eaf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ac89cb5-3d6b-4f50-97bd-8a7d27c28eaf', 22, NULL, 'Emmett Williams', 'Fluxus Suite: Emmett Williams', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ac89cb5-3d6b-4f50-97bd-8a7d27c28eaf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Dick Higgins', part.name_en = 'Fluxus Suite: Dick Higgins',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:60d067cb-0a95-4597-8a30-a6b423e65e60' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60d067cb-0a95-4597-8a30-a6b423e65e60', 23, NULL, 'Dick Higgins', 'Fluxus Suite: Dick Higgins', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60d067cb-0a95-4597-8a30-a6b423e65e60'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Gianni Sassi', part.name_en = 'Fluxus Suite: Gianni Sassi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:6300ae18-1960-4171-92ff-667f30c03f2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6300ae18-1960-4171-92ff-667f30c03f2e', 24, NULL, 'Gianni Sassi', 'Fluxus Suite: Gianni Sassi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6300ae18-1960-4171-92ff-667f30c03f2e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Davi Det Hompson', part.name_en = 'Fluxus Suite: Davi Det Hompson',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:64f3542e-7f4f-4d15-8a41-238985fdb4d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64f3542e-7f4f-4d15-8a41-238985fdb4d0', 25, NULL, 'Davi Det Hompson', 'Fluxus Suite: Davi Det Hompson', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64f3542e-7f4f-4d15-8a41-238985fdb4d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'Yoshimasa Wada', part.name_en = 'Fluxus Suite: Yoshimasa Wada',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:666947ee-2644-4e4e-9f9f-08ff33d73784' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:666947ee-2644-4e4e-9f9f-08ff33d73784', 26, NULL, 'Yoshimasa Wada', 'Fluxus Suite: Yoshimasa Wada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:666947ee-2644-4e4e-9f9f-08ff33d73784'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'Gianni-Emilio Simonetti', part.name_en = 'Fluxus Suite: Gianni-Emilio Simonetti',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:6855ba2f-ae5a-4835-849d-4dd52a9dd4be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6855ba2f-ae5a-4835-849d-4dd52a9dd4be', 27, NULL, 'Gianni-Emilio Simonetti', 'Fluxus Suite: Gianni-Emilio Simonetti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6855ba2f-ae5a-4835-849d-4dd52a9dd4be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'Geoffrey Hendricks', part.name_en = 'Fluxus Suite: Geoffrey Hendricks',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:6a3cb9b9-49b1-4e8e-9abb-1bb7e644b24b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a3cb9b9-49b1-4e8e-9abb-1bb7e644b24b', 28, NULL, 'Geoffrey Hendricks', 'Fluxus Suite: Geoffrey Hendricks', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a3cb9b9-49b1-4e8e-9abb-1bb7e644b24b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'Joseph Beuys', part.name_en = 'Fluxus Suite: Joseph Beuys',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:6f5cc1dc-80a1-40a7-aa5a-969347d2b941' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f5cc1dc-80a1-40a7-aa5a-969347d2b941', 29, NULL, 'Joseph Beuys', 'Fluxus Suite: Joseph Beuys', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f5cc1dc-80a1-40a7-aa5a-969347d2b941'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'George Maciunas (A) (B)', part.name_en = 'Fluxus Suite: George Maciunas (A) (B)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:710ed1c4-f16c-4105-bc30-9cf94b88ba81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:710ed1c4-f16c-4105-bc30-9cf94b88ba81', 30, NULL, 'George Maciunas (A) (B)', 'Fluxus Suite: George Maciunas (A) (B)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:710ed1c4-f16c-4105-bc30-9cf94b88ba81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'Marian Zazeela', part.name_en = 'Fluxus Suite: Marian Zazeela',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:737f5587-5b02-47bf-816a-eb9b6ddb036c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:737f5587-5b02-47bf-816a-eb9b6ddb036c', 31, NULL, 'Marian Zazeela', 'Fluxus Suite: Marian Zazeela', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:737f5587-5b02-47bf-816a-eb9b6ddb036c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = 'Philip Corner', part.name_en = 'Fluxus Suite: Philip Corner',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:74778ec2-9a7b-456c-a567-ebb09be4f8dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74778ec2-9a7b-456c-a567-ebb09be4f8dd', 32, NULL, 'Philip Corner', 'Fluxus Suite: Philip Corner', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74778ec2-9a7b-456c-a567-ebb09be4f8dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 33, part.movement_number = NULL,
    part.name_ko = 'Alice Hutchins', part.name_en = 'Fluxus Suite: Alice Hutchins',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:7c276230-94bf-4fa8-a808-3ea20005c1c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c276230-94bf-4fa8-a808-3ea20005c1c0', 33, NULL, 'Alice Hutchins', 'Fluxus Suite: Alice Hutchins', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c276230-94bf-4fa8-a808-3ea20005c1c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 34, part.movement_number = NULL,
    part.name_ko = 'Walter Marchetti', part.name_en = 'Fluxus Suite: Walter Marchetti',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:7d546ff3-aae5-4c4a-9bdd-2ef79b743c90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d546ff3-aae5-4c4a-9bdd-2ef79b743c90', 34, NULL, 'Walter Marchetti', 'Fluxus Suite: Walter Marchetti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d546ff3-aae5-4c4a-9bdd-2ef79b743c90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 35, part.movement_number = NULL,
    part.name_ko = 'Henri Chopin', part.name_en = 'Fluxus Suite: Henri Chopin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:7fe5d3bc-9a1d-487f-a933-8660275ef230' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fe5d3bc-9a1d-487f-a933-8660275ef230', 35, NULL, 'Henri Chopin', 'Fluxus Suite: Henri Chopin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fe5d3bc-9a1d-487f-a933-8660275ef230'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 36, part.movement_number = NULL,
    part.name_ko = 'Willem de Ridder', part.name_en = 'Fluxus Suite: Willem de Ridder',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:81e71cce-b6a7-42cc-ad0a-557f02b43792' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81e71cce-b6a7-42cc-ad0a-557f02b43792', 36, NULL, 'Willem de Ridder', 'Fluxus Suite: Willem de Ridder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81e71cce-b6a7-42cc-ad0a-557f02b43792'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 37, part.movement_number = NULL,
    part.name_ko = 'Vytautas Landsbergis', part.name_en = 'Fluxus Suite: Vytautas Landsbergis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:834ddee5-4be7-4058-85dd-ec27799c1f02' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:834ddee5-4be7-4058-85dd-ec27799c1f02', 37, NULL, 'Vytautas Landsbergis', 'Fluxus Suite: Vytautas Landsbergis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:834ddee5-4be7-4058-85dd-ec27799c1f02'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 38, part.movement_number = NULL,
    part.name_ko = 'Charlotte Moorman', part.name_en = 'Fluxus Suite: Charlotte Moorman',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:85ca5245-4cf5-4bd7-8e62-46ca92947427' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85ca5245-4cf5-4bd7-8e62-46ca92947427', 38, NULL, 'Charlotte Moorman', 'Fluxus Suite: Charlotte Moorman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85ca5245-4cf5-4bd7-8e62-46ca92947427'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 39, part.movement_number = NULL,
    part.name_ko = 'Robert Filliou', part.name_en = 'Fluxus Suite: Robert Filliou',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:892980a7-cc2b-4754-a56c-e8ede1df7f87' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:892980a7-cc2b-4754-a56c-e8ede1df7f87', 39, NULL, 'Robert Filliou', 'Fluxus Suite: Robert Filliou', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:892980a7-cc2b-4754-a56c-e8ede1df7f87'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 40, part.movement_number = NULL,
    part.name_ko = 'George Brecht', part.name_en = 'Fluxus Suite: George Brecht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:8c90e852-3dad-4559-8164-32256eb3bd2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c90e852-3dad-4559-8164-32256eb3bd2a', 40, NULL, 'George Brecht', 'Fluxus Suite: George Brecht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c90e852-3dad-4559-8164-32256eb3bd2a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 41, part.movement_number = NULL,
    part.name_ko = 'Jacques Donguy', part.name_en = 'Fluxus Suite: Jacques Donguy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:8efe0da1-a4a9-4067-a444-2780c7880af3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8efe0da1-a4a9-4067-a444-2780c7880af3', 41, NULL, 'Jacques Donguy', 'Fluxus Suite: Jacques Donguy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8efe0da1-a4a9-4067-a444-2780c7880af3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 42, part.movement_number = NULL,
    part.name_ko = 'René Block', part.name_en = 'Fluxus Suite: René Block',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:90c896a5-a682-4271-b6aa-7f91f768b5bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90c896a5-a682-4271-b6aa-7f91f768b5bc', 42, NULL, 'René Block', 'Fluxus Suite: René Block', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90c896a5-a682-4271-b6aa-7f91f768b5bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 43, part.movement_number = NULL,
    part.name_ko = 'Bengt af Klintberg', part.name_en = 'Fluxus Suite: Bengt af Klintberg',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:9294b4a6-9b0f-466b-bdff-34284793f7c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9294b4a6-9b0f-466b-bdff-34284793f7c6', 43, NULL, 'Bengt af Klintberg', 'Fluxus Suite: Bengt af Klintberg', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9294b4a6-9b0f-466b-bdff-34284793f7c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 44, part.movement_number = NULL,
    part.name_ko = 'Jonas Mekas', part.name_en = 'Fluxus Suite: Jonas Mekas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:937258aa-a446-4c96-93a0-623bcea9edb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:937258aa-a446-4c96-93a0-623bcea9edb0', 44, NULL, 'Jonas Mekas', 'Fluxus Suite: Jonas Mekas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:937258aa-a446-4c96-93a0-623bcea9edb0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 45, part.movement_number = NULL,
    part.name_ko = 'Ben Patterson', part.name_en = 'Fluxus Suite: Ben Patterson',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:947c6cb5-e9e9-4a96-97aa-a23e3427ee80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:947c6cb5-e9e9-4a96-97aa-a23e3427ee80', 45, NULL, 'Ben Patterson', 'Fluxus Suite: Ben Patterson', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:947c6cb5-e9e9-4a96-97aa-a23e3427ee80'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 46, part.movement_number = NULL,
    part.name_ko = 'Milan Knizak', part.name_en = 'Fluxus Suite: Milan Knizak',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:94ffc680-4923-415f-ae5c-2219164a21e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94ffc680-4923-415f-ae5c-2219164a21e9', 46, NULL, 'Milan Knizak', 'Fluxus Suite: Milan Knizak', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94ffc680-4923-415f-ae5c-2219164a21e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 47, part.movement_number = NULL,
    part.name_ko = 'Allen Ginsberg', part.name_en = 'Fluxus Suite: Allen Ginsberg',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:9601b5ea-9d5c-412f-8c08-c14a14724b95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9601b5ea-9d5c-412f-8c08-c14a14724b95', 47, NULL, 'Allen Ginsberg', 'Fluxus Suite: Allen Ginsberg', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9601b5ea-9d5c-412f-8c08-c14a14724b95'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 48, part.movement_number = NULL,
    part.name_ko = 'Takako Saito', part.name_en = 'Fluxus Suite: Takako Saito',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:9a991035-c13e-41c7-88e9-baf7b768d367' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a991035-c13e-41c7-88e9-baf7b768d367', 48, NULL, 'Takako Saito', 'Fluxus Suite: Takako Saito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a991035-c13e-41c7-88e9-baf7b768d367'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 49, part.movement_number = NULL,
    part.name_ko = 'Ben Vautier', part.name_en = 'Fluxus Suite: Ben Vautier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:9b0ef7fd-7957-4c06-ac1f-4a2b64fd01b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b0ef7fd-7957-4c06-ac1f-4a2b64fd01b5', 49, NULL, 'Ben Vautier', 'Fluxus Suite: Ben Vautier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b0ef7fd-7957-4c06-ac1f-4a2b64fd01b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 50, part.movement_number = NULL,
    part.name_ko = 'Carolee Schneemann', part.name_en = 'Fluxus Suite: Carolee Schneemann',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:9b2e8c4c-618d-4ddf-a716-00d32f45772f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b2e8c4c-618d-4ddf-a716-00d32f45772f', 50, NULL, 'Carolee Schneemann', 'Fluxus Suite: Carolee Schneemann', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b2e8c4c-618d-4ddf-a716-00d32f45772f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 51, part.movement_number = NULL,
    part.name_ko = 'Jon Hendricks', part.name_en = 'Fluxus Suite: Jon Hendricks',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:9d797acd-e9ba-4e0b-a6fd-d4416426f149' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d797acd-e9ba-4e0b-a6fd-d4416426f149', 51, NULL, 'Jon Hendricks', 'Fluxus Suite: Jon Hendricks', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d797acd-e9ba-4e0b-a6fd-d4416426f149'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 52, part.movement_number = NULL,
    part.name_ko = 'Arthur Koepcke', part.name_en = 'Fluxus Suite: Arthur Koepcke',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:9eae5778-c184-4a49-9d3b-eff031805e36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9eae5778-c184-4a49-9d3b-eff031805e36', 52, NULL, 'Arthur Koepcke', 'Fluxus Suite: Arthur Koepcke', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9eae5778-c184-4a49-9d3b-eff031805e36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 53, part.movement_number = NULL,
    part.name_ko = 'Gerhard Rühm', part.name_en = 'Fluxus Suite: Gerhard Rühm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:9f3e1c43-80dc-4bde-aa12-551d93ea95ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f3e1c43-80dc-4bde-aa12-551d93ea95ad', 53, NULL, 'Gerhard Rühm', 'Fluxus Suite: Gerhard Rühm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f3e1c43-80dc-4bde-aa12-551d93ea95ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 54, part.movement_number = NULL,
    part.name_ko = 'Yoko Ono (Silence)', part.name_en = 'Fluxus Suite: Yoko Ono (Silence)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:a11a8f5b-30b9-4ac0-a9de-e856ae37fbca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a11a8f5b-30b9-4ac0-a9de-e856ae37fbca', 54, NULL, 'Yoko Ono (Silence)', 'Fluxus Suite: Yoko Ono (Silence)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a11a8f5b-30b9-4ac0-a9de-e856ae37fbca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 55, part.movement_number = NULL,
    part.name_ko = 'Jean Dupuy', part.name_en = 'Fluxus Suite: Jean Dupuy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:ac185772-e6c7-4a40-a7ef-baf67f44f75f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac185772-e6c7-4a40-a7ef-baf67f44f75f', 55, NULL, 'Jean Dupuy', 'Fluxus Suite: Jean Dupuy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac185772-e6c7-4a40-a7ef-baf67f44f75f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 56, part.movement_number = NULL,
    part.name_ko = 'Barbara Moore', part.name_en = 'Fluxus Suite: Barbara Moore',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:b7c9f222-8807-47de-a929-c5bc95b96480' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7c9f222-8807-47de-a929-c5bc95b96480', 56, NULL, 'Barbara Moore', 'Fluxus Suite: Barbara Moore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7c9f222-8807-47de-a929-c5bc95b96480'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 57, part.movement_number = NULL,
    part.name_ko = 'Wolf Vostell', part.name_en = 'Fluxus Suite: Wolf Vostell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:b8d8dabe-8d66-4d6c-a243-84dc0dca2839' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8d8dabe-8d66-4d6c-a243-84dc0dca2839', 57, NULL, 'Wolf Vostell', 'Fluxus Suite: Wolf Vostell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8d8dabe-8d66-4d6c-a243-84dc0dca2839'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 58, part.movement_number = NULL,
    part.name_ko = 'Alison Knowles', part.name_en = 'Fluxus Suite: Alison Knowles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:b98e6275-b133-4fc9-8499-83267e5bc3f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b98e6275-b133-4fc9-8499-83267e5bc3f8', 58, NULL, 'Alison Knowles', 'Fluxus Suite: Alison Knowles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b98e6275-b133-4fc9-8499-83267e5bc3f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 59, part.movement_number = NULL,
    part.name_ko = 'Al Hansen', part.name_en = 'Fluxus Suite: Al Hansen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:bc59aba7-1f63-4d26-9a49-c77a7acf22ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc59aba7-1f63-4d26-9a49-c77a7acf22ee', 59, NULL, 'Al Hansen', 'Fluxus Suite: Al Hansen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc59aba7-1f63-4d26-9a49-c77a7acf22ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 60, part.movement_number = NULL,
    part.name_ko = 'La Monte Young', part.name_en = 'Fluxus Suite: La Monte Young',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:c22850c0-39ff-493d-b596-12a95c5bde6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c22850c0-39ff-493d-b596-12a95c5bde6b', 60, NULL, 'La Monte Young', 'Fluxus Suite: La Monte Young', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c22850c0-39ff-493d-b596-12a95c5bde6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 61, part.movement_number = NULL,
    part.name_ko = 'Henning Christiansen', part.name_en = 'Fluxus Suite: Henning Christiansen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:c2d52909-0302-4ba1-bd81-db14a26a5630' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2d52909-0302-4ba1-bd81-db14a26a5630', 61, NULL, 'Henning Christiansen', 'Fluxus Suite: Henning Christiansen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2d52909-0302-4ba1-bd81-db14a26a5630'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 62, part.movement_number = NULL,
    part.name_ko = 'Esther Ferrer', part.name_en = 'Fluxus Suite: Esther Ferrer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:c334e3f4-2207-461b-907a-47a657af85f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c334e3f4-2207-461b-907a-47a657af85f8', 62, NULL, 'Esther Ferrer', 'Fluxus Suite: Esther Ferrer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c334e3f4-2207-461b-907a-47a657af85f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 63, part.movement_number = NULL,
    part.name_ko = 'Jean Jacques Lebel', part.name_en = 'Fluxus Suite: Jean Jacques Lebel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:c6cda82f-982d-4ee0-a55b-92ed2e607b08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6cda82f-982d-4ee0-a55b-92ed2e607b08', 63, NULL, 'Jean Jacques Lebel', 'Fluxus Suite: Jean Jacques Lebel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6cda82f-982d-4ee0-a55b-92ed2e607b08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 64, part.movement_number = NULL,
    part.name_ko = 'Endre Tót', part.name_en = 'Fluxus Suite: Endre Tót',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:ca0b1f90-a71f-4de7-9353-1691b5552728' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca0b1f90-a71f-4de7-9353-1691b5552728', 64, NULL, 'Endre Tót', 'Fluxus Suite: Endre Tót', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca0b1f90-a71f-4de7-9353-1691b5552728'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 65, part.movement_number = NULL,
    part.name_ko = 'Ken Friedman', part.name_en = 'Fluxus Suite: Ken Friedman',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:cb9a0acb-fd9e-4730-b3ba-4b4fa9fa8811' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb9a0acb-fd9e-4730-b3ba-4b4fa9fa8811', 65, NULL, 'Ken Friedman', 'Fluxus Suite: Ken Friedman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb9a0acb-fd9e-4730-b3ba-4b4fa9fa8811'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 66, part.movement_number = NULL,
    part.name_ko = 'Hanns Sohm', part.name_en = 'Fluxus Suite: Hanns Sohm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:ce12354a-09fd-49cc-bce0-0d6b16f67e12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce12354a-09fd-49cc-bce0-0d6b16f67e12', 66, NULL, 'Hanns Sohm', 'Fluxus Suite: Hanns Sohm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce12354a-09fd-49cc-bce0-0d6b16f67e12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 67, part.movement_number = NULL,
    part.name_ko = 'Joe Jones', part.name_en = 'Fluxus Suite: Joe Jones',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:d5680dbf-4ffc-46c9-acd3-224ef3e0088c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5680dbf-4ffc-46c9-acd3-224ef3e0088c', 67, NULL, 'Joe Jones', 'Fluxus Suite: Joe Jones', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5680dbf-4ffc-46c9-acd3-224ef3e0088c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 68, part.movement_number = NULL,
    part.name_ko = 'Takehisa Kosugi', part.name_en = 'Fluxus Suite: Takehisa Kosugi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:d8de6f10-aaf1-484e-bf21-9290e0f47a16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8de6f10-aaf1-484e-bf21-9290e0f47a16', 68, NULL, 'Takehisa Kosugi', 'Fluxus Suite: Takehisa Kosugi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8de6f10-aaf1-484e-bf21-9290e0f47a16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 69, part.movement_number = NULL,
    part.name_ko = 'Christo', part.name_en = 'Fluxus Suite: Christo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:d9326ff3-b09a-4397-914e-024736d7886c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9326ff3-b09a-4397-914e-024736d7886c', 69, NULL, 'Christo', 'Fluxus Suite: Christo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9326ff3-b09a-4397-914e-024736d7886c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 70, part.movement_number = NULL,
    part.name_ko = 'Jean Brown', part.name_en = 'Fluxus Suite: Jean Brown',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:daae62ff-a622-455a-8688-131be52571ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:daae62ff-a622-455a-8688-131be52571ce', 70, NULL, 'Jean Brown', 'Fluxus Suite: Jean Brown', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:daae62ff-a622-455a-8688-131be52571ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 71, part.movement_number = NULL,
    part.name_ko = 'Francesco Conz', part.name_en = 'Fluxus Suite: Francesco Conz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:dce723ee-961a-41a1-b759-3cc437a63d8c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dce723ee-961a-41a1-b759-3cc437a63d8c', 71, NULL, 'Francesco Conz', 'Fluxus Suite: Francesco Conz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dce723ee-961a-41a1-b759-3cc437a63d8c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 72, part.movement_number = NULL,
    part.name_ko = 'Eric Andersen', part.name_en = 'Fluxus Suite: Eric Andersen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:ddf13fd4-c9df-4768-ac50-5bab8dafcc48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddf13fd4-c9df-4768-ac50-5bab8dafcc48', 72, NULL, 'Eric Andersen', 'Fluxus Suite: Eric Andersen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddf13fd4-c9df-4768-ac50-5bab8dafcc48'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 73, part.movement_number = NULL,
    part.name_ko = 'Gino Di Maggio', part.name_en = 'Fluxus Suite: Gino Di Maggio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:e3769caf-589e-4909-8d33-853788f46efc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3769caf-589e-4909-8d33-853788f46efc', 73, NULL, 'Gino Di Maggio', 'Fluxus Suite: Gino Di Maggio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3769caf-589e-4909-8d33-853788f46efc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 74, part.movement_number = NULL,
    part.name_ko = 'Dieter Roth', part.name_en = 'Fluxus Suite: Dieter Roth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:e3b1e2a5-f9bc-4c55-a416-4af96a781b85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3b1e2a5-f9bc-4c55-a416-4af96a781b85', 74, NULL, 'Dieter Roth', 'Fluxus Suite: Dieter Roth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3b1e2a5-f9bc-4c55-a416-4af96a781b85'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 75, part.movement_number = NULL,
    part.name_ko = 'Nam June Paik', part.name_en = 'Fluxus Suite: Nam June Paik',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:ec8cb96b-2e38-4ee8-b80d-403c9169cacd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec8cb96b-2e38-4ee8-b80d-403c9169cacd', 75, NULL, 'Nam June Paik', 'Fluxus Suite: Nam June Paik', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec8cb96b-2e38-4ee8-b80d-403c9169cacd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 76, part.movement_number = NULL,
    part.name_ko = 'Larry Miller', part.name_en = 'Fluxus Suite: Larry Miller',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:f3b56e49-e54d-4ae0-9378-2f60e6198c48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3b56e49-e54d-4ae0-9378-2f60e6198c48', 76, NULL, 'Larry Miller', 'Fluxus Suite: Larry Miller', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3b56e49-e54d-4ae0-9378-2f60e6198c48'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 77, part.movement_number = NULL,
    part.name_ko = 'Peter Moore', part.name_en = 'Fluxus Suite: Peter Moore',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:fa8712c5-8de6-4244-b500-7a7fababec9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa8712c5-8de6-4244-b500-7a7fababec9f', 77, NULL, 'Peter Moore', 'Fluxus Suite: Peter Moore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa8712c5-8de6-4244-b500-7a7fababec9f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 78, part.movement_number = NULL,
    part.name_ko = 'Michael Berger', part.name_en = 'Fluxus Suite: Michael Berger',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:fad44297-0673-4c92-b5d0-3378297c1221' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fad44297-0673-4c92-b5d0-3378297c1221', 78, NULL, 'Michael Berger', 'Fluxus Suite: Michael Berger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fad44297-0673-4c92-b5d0-3378297c1221'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 79, part.movement_number = NULL,
    part.name_ko = 'Allan Kaprow', part.name_en = 'Fluxus Suite: Allan Kaprow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:fbc1160e-4a5a-4fbd-a54f-49878fde6fba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbc1160e-4a5a-4fbd-a54f-49878fde6fba', 79, NULL, 'Allan Kaprow', 'Fluxus Suite: Allan Kaprow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbc1160e-4a5a-4fbd-a54f-49878fde6fba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 80, part.movement_number = NULL,
    part.name_ko = 'Ay-O', part.name_en = 'Fluxus Suite: Ay-O',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24261 AND p.composer_id = 428 AND part.part_key = 'musicbrainz:fbdfdd76-e9ff-4994-9d97-7d4a6c8ff908' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbdfdd76-e9ff-4994-9d97-7d4a6c8ff908', 80, NULL, 'Ay-O', 'Fluxus Suite: Ay-O', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24261 AND p.composer_id = 428
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbdfdd76-e9ff-4994-9d97-7d4a6c8ff908'
);

-- 숨길 seed 작품 없음

-- ===== Michael Waller (composer_id 429) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 11개(묶음 2, 다악장 1, 낱곡 8),
-- 새 작품 1개, part 10개, 그 아래 0개.
-- seed 10개 중 10개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Bounding

UPDATE pieces piece
SET piece.title = 'Bounding', piece.title_en = 'Bounding',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24729 AND piece.composer_id = 429
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 디베르티멘토

UPDATE pieces piece
SET piece.title = '디베르티멘토', piece.title_en = 'Divertimento',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23781 AND piece.composer_id = 429
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None For Papa

UPDATE pieces piece
SET piece.title = 'For Papa', piece.title_en = 'For Papa',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23968 AND piece.composer_id = 429
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None For Pauline

UPDATE pieces piece
SET piece.title = 'For Pauline', piece.title_en = 'For Pauline',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25284 AND piece.composer_id = 429
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Jennifer

UPDATE pieces piece
SET piece.title = 'Jennifer', piece.title_en = 'Jennifer',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23422 AND piece.composer_id = 429
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 녹턴

UPDATE pieces piece
SET piece.title = '녹턴', piece.title_en = 'Nocturnes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23800 AND piece.composer_id = 429
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Nocturnes: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23800 AND p.composer_id = 429 AND part.part_key = 'musicbrainz:9b057fd2-2052-499e-9e63-cd4b5b2feed2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b057fd2-2052-499e-9e63-cd4b5b2feed2', 1, NULL, 'No. 1', 'Nocturnes: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23800 AND p.composer_id = 429
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b057fd2-2052-499e-9e63-cd4b5b2feed2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 4', part.name_en = 'Nocturnes: No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23800 AND p.composer_id = 429 AND part.part_key = 'musicbrainz:a555ce6e-1487-4438-af81-03c05c02d41c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a555ce6e-1487-4438-af81-03c05c02d41c', 2, NULL, 'No. 4', 'Nocturnes: No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23800 AND p.composer_id = 429
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a555ce6e-1487-4438-af81-03c05c02d41c'
);


-- None Return From L.A.

UPDATE pieces piece
SET piece.title = 'Return From L.A.', piece.title_en = 'Return From L.A.',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24782 AND piece.composer_id = 429
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Return From L.A.: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24782 AND p.composer_id = 429 AND part.part_key = 'musicbrainz:26af6521-2050-47c3-a093-00725c89ebf8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26af6521-2050-47c3-a093-00725c89ebf8', 1, NULL, 'I', 'Return From L.A.: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24782 AND p.composer_id = 429
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26af6521-2050-47c3-a093-00725c89ebf8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Return From L.A.: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24782 AND p.composer_id = 429 AND part.part_key = 'musicbrainz:0d6bda47-590a-4a5e-9459-648f906c766e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d6bda47-590a-4a5e-9459-648f906c766e', 2, NULL, 'II', 'Return From L.A.: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24782 AND p.composer_id = 429
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d6bda47-590a-4a5e-9459-648f906c766e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Return From L.A.: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24782 AND p.composer_id = 429 AND part.part_key = 'musicbrainz:514b74b4-2f2c-4245-8dad-c57e9e3fcb94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:514b74b4-2f2c-4245-8dad-c57e9e3fcb94', 3, NULL, 'III', 'Return From L.A.: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24782 AND p.composer_id = 429
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:514b74b4-2f2c-4245-8dad-c57e9e3fcb94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Return From L.A.: IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24782 AND p.composer_id = 429 AND part.part_key = 'musicbrainz:49414d47-fd24-44ff-8629-b460b5fa5ab4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49414d47-fd24-44ff-8629-b460b5fa5ab4', 4, NULL, 'IV', 'Return From L.A.: IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24782 AND p.composer_id = 429
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49414d47-fd24-44ff-8629-b460b5fa5ab4'
);


-- None Roman

UPDATE pieces piece
SET piece.title = 'Roman', piece.title_en = 'Roman',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24707 AND piece.composer_id = 429
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Stolen Moments

UPDATE pieces piece
SET piece.title = 'Stolen Moments', piece.title_en = 'Stolen Moments',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25014 AND piece.composer_id = 429
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vibrafono Studio

UPDATE pieces piece
SET piece.title = 'Vibrafono Studio', piece.title_en = 'Vibrafono Studio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24157 AND piece.composer_id = 429
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Love

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Love', 'Love', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 429
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Love'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5e17532f-5b4c-4f21-9886-c7df3a1eb040'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5e17532f-5b4c-4f21-9886-c7df3a1eb040'
FROM pieces p
WHERE p.composer_id = 429 AND p.title = 'Love' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5e17532f-5b4c-4f21-9886-c7df3a1eb040'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d080f381-01f3-42ed-a95f-8507347b6a2e', 1, 'I', 'Valentine', 'Love: I. Valentine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 429 AND p.title = 'Love' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d080f381-01f3-42ed-a95f-8507347b6a2e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d182f9f6-6778-4b28-a126-9b83477369cc', 2, 'II', 'Baby’s Return', 'Love: II. Baby’s Return', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 429 AND p.title = 'Love' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d182f9f6-6778-4b28-a126-9b83477369cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a26bda1-60e7-4242-87eb-1ba8dae2aafb', 3, 'III', 'Images', 'Love: III. Images', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 429 AND p.title = 'Love' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a26bda1-60e7-4242-87eb-1ba8dae2aafb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb175adb-fc90-49b8-a543-411379a360d3', 4, 'IV', 'Sizing', 'Love: IV. Sizing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 429 AND p.title = 'Love' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb175adb-fc90-49b8-a543-411379a360d3'
);

-- 숨길 seed 작품 없음
