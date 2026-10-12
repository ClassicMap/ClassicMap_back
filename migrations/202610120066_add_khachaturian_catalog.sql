-- 하차투리안 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 123개(묶음 6, 다악장 22, 낱곡 95),
-- 새 작품 3개, part 158개, 그 아래 10개.
-- seed 155개 중 118개를 작품·part 에 잇고, 33개를 숨기고, 4개는 그대로 둔다.
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

-- Op. 47 "Budionovka", mass dance for piano

UPDATE pieces piece
SET piece.title = '"Budionovka", mass dance for piano', piece.title_en = '"Budionovka", mass dance for piano, op. 47',
    piece.type = 'song', piece.opus_number = 'Op. 47',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1092 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 52 "To the Heroes of the Patriotic War", march in A-flat major for wind band

UPDATE pieces piece
SET piece.title = '"To the Heroes of the Patriotic War", march in A-flat major for wind band', piece.title_en = '"To the Heroes of the Patriotic War", march in A-flat major for wind band, op. 52',
    piece.type = 'song', piece.opus_number = 'Op. 52',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2596 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 18 Allegretto for violin and piano

UPDATE pieces piece
SET piece.title = 'Allegretto for violin and piano', piece.title_en = 'Allegretto for violin and piano, op. 18',
    piece.type = 'song', piece.opus_number = 'Op. 18',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2579 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 5 Andantino for piano

UPDATE pieces piece
SET piece.title = 'Andantino for piano', piece.title_en = 'Andantino for piano, op. 5',
    piece.type = 'song', piece.opus_number = 'Op. 5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1802 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Armenian Dances

UPDATE pieces piece
SET piece.title = 'Armenian Dances', piece.title_en = 'Armenian Dances',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1550 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Armenian Dances: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1550 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:75497679-ac38-4f3f-b28c-ecc2962c4e68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75497679-ac38-4f3f-b28c-ecc2962c4e68', 1, 'I', 'Allegro moderato', 'Armenian Dances: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1550 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75497679-ac38-4f3f-b28c-ecc2962c4e68'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Armenian Dances: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1550 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:06e81422-9ba0-42ec-a8a9-57181d3213cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06e81422-9ba0-42ec-a8a9-57181d3213cc', 2, 'II', 'Allegro', 'Armenian Dances: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1550 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06e81422-9ba0-42ec-a8a9-57181d3213cc'
);


-- Op. 20 Army March no. 1 in A-flat major for wind orchestra

UPDATE pieces piece
SET piece.title = 'Army March no. 1 in A-flat major for wind orchestra', piece.title_en = 'Army March no. 1 in A-flat major for wind orchestra, op. 20',
    piece.type = 'song', piece.opus_number = 'Op. 20',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1033 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 21 Army March no. 2 in F minor for wind orchestra

UPDATE pieces piece
SET piece.title = 'Army March no. 2 in F minor for wind orchestra', piece.title_en = 'Army March no. 2 in F minor for wind orchestra, op. 21',
    piece.type = 'song', piece.opus_number = 'Op. 21',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1956 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 97 Ballad of the Motherland for bass and orchestra

UPDATE pieces piece
SET piece.title = 'Ballad of the Motherland for bass and orchestra', piece.title_en = 'Ballad of the Motherland for bass and orchestra, op. 97',
    piece.type = 'song', piece.opus_number = 'Op. 97',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2269 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Charlotte for Ever>

UPDATE pieces piece
SET piece.title = '가곡 <Charlotte for Ever>', piece.title_en = 'Charlotte for Ever',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 713 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 100 Children's Album, book II for piano Op. 100

UPDATE pieces piece
SET piece.catalogue_system = 'Op.', piece.catalogue_number = '100'
WHERE piece.id = 486 AND piece.composer_id = 101
  AND piece.catalogue_number IS NULL AND piece.opus_number IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Skipping Rope', part.name_en = 'Children''s Album, book II for piano, op. 100: 01. Skipping Rope',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 486 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:05af8f77-78df-4004-8bcc-3da415bfc4b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05af8f77-78df-4004-8bcc-3da415bfc4b9', 1, NULL, 'Skipping Rope', 'Children''s Album, book II for piano, op. 100: 01. Skipping Rope', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 486 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05af8f77-78df-4004-8bcc-3da415bfc4b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'An Evening Tale', part.name_en = 'Children''s Album, book II for piano, op. 100: 02. An Evening Tale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 486 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:0c131623-18de-4b9d-9eba-d5ab02c1b4e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c131623-18de-4b9d-9eba-d5ab02c1b4e8', 2, NULL, 'An Evening Tale', 'Children''s Album, book II for piano, op. 100: 02. An Evening Tale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 486 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c131623-18de-4b9d-9eba-d5ab02c1b4e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Oriental [Eastern] Dance', part.name_en = 'Children''s Album, book II for piano, op. 100: 03. Oriental [Eastern] Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 486 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:00d64cc7-cf01-405e-baed-122587c3ba2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00d64cc7-cf01-405e-baed-122587c3ba2f', 3, NULL, 'Oriental [Eastern] Dance', 'Children''s Album, book II for piano, op. 100: 03. Oriental [Eastern] Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 486 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00d64cc7-cf01-405e-baed-122587c3ba2f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Barsik on the Swing', part.name_en = 'Children''s Album, book II for piano, op. 100: 04. Barsik on the Swing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 486 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:e4e247ba-da19-44c2-837d-62e249ab62b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4e247ba-da19-44c2-837d-62e249ab62b3', 4, NULL, 'Barsik on the Swing', 'Children''s Album, book II for piano, op. 100: 04. Barsik on the Swing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 486 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4e247ba-da19-44c2-837d-62e249ab62b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Playing the Tambourine', part.name_en = 'Children''s Album, book II for piano, op. 100: 05. Playing the Tambourine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 486 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:1b087281-5f41-4919-a67f-1fe70902d26d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b087281-5f41-4919-a67f-1fe70902d26d', 5, NULL, 'Playing the Tambourine', 'Children''s Album, book II for piano, op. 100: 05. Playing the Tambourine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 486 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b087281-5f41-4919-a67f-1fe70902d26d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Two Funny Aunties Argued', part.name_en = 'Children''s Album, book II for piano, op. 100: 06. Two Funny Aunties Argued',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 486 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:69fc8436-9ac1-4151-9ee0-50121a6febe0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69fc8436-9ac1-4151-9ee0-50121a6febe0', 6, NULL, 'Two Funny Aunties Argued', 'Children''s Album, book II for piano, op. 100: 06. Two Funny Aunties Argued', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 486 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69fc8436-9ac1-4151-9ee0-50121a6febe0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Funeral March', part.name_en = 'Children''s Album, book II for piano, op. 100: 07. Funeral March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 486 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:9a234745-9b49-4b3f-bac6-c8a164ec1e82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a234745-9b49-4b3f-bac6-c8a164ec1e82', 7, NULL, 'Funeral March', 'Children''s Album, book II for piano, op. 100: 07. Funeral March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 486 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a234745-9b49-4b3f-bac6-c8a164ec1e82'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Rhythmic Gymnastics', part.name_en = 'Children''s Album, book II for piano, op. 100: 08. Rhythmic Gymnastics',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 486 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:ea7fca3b-43a8-4655-917b-6465acf04002' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea7fca3b-43a8-4655-917b-6465acf04002', 8, NULL, 'Rhythmic Gymnastics', 'Children''s Album, book II for piano, op. 100: 08. Rhythmic Gymnastics', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 486 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea7fca3b-43a8-4655-917b-6465acf04002'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Toccata', part.name_en = 'Children''s Album, book II for piano, op. 100: 09. Toccata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 486 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:3e9486c8-f640-4601-854e-2e3e76f9b3fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e9486c8-f640-4601-854e-2e3e76f9b3fd', 9, NULL, 'Toccata', 'Children''s Album, book II for piano, op. 100: 09. Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 486 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e9486c8-f640-4601-854e-2e3e76f9b3fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Fugue', part.name_en = 'Children''s Album, book II for piano, op. 100: 10. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 486 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:9247804a-2e77-4d6c-bc32-572ed60001a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9247804a-2e77-4d6c-bc32-572ed60001a0', 10, NULL, 'Fugue', 'Children''s Album, book II for piano, op. 100: 10. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 486 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9247804a-2e77-4d6c-bc32-572ed60001a0'
);


-- Op. 62 Children’s Album, Book I

UPDATE pieces piece
SET piece.title = 'Children’s Album, Book I', piece.title_en = 'Children’s Album, Book I, op. 62',
    piece.type = 'album', piece.opus_number = 'Op. 62',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 599 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andantino', part.name_en = 'Children’s Album, Book I, op. 62: I. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 599 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:1f6a53ee-08a9-44d1-bed2-5902eec7c24c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f6a53ee-08a9-44d1-bed2-5902eec7c24c', 1, 'I', 'Andantino', 'Children’s Album, Book I, op. 62: I. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 599 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f6a53ee-08a9-44d1-bed2-5902eec7c24c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'No Going for a Walk Today (dedicated to Renik)', part.name_en = 'Children’s Album, Book I, op. 62: II. No Going for a Walk Today (dedicated to Renik)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 599 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:d05f9f1d-5cce-4062-9065-51d293e08ef1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d05f9f1d-5cce-4062-9065-51d293e08ef1', 2, 'II', 'No Going for a Walk Today (dedicated to Renik)', 'Children’s Album, Book I, op. 62: II. No Going for a Walk Today (dedicated to Renik)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 599 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d05f9f1d-5cce-4062-9065-51d293e08ef1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Liado is Very Ill (dedicated to Renik)', part.name_en = 'Children’s Album, Book I, op. 62: III. Liado is Very Ill (dedicated to Renik)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 599 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:cb223bc1-0dba-4b0b-94e4-b159ed111b42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb223bc1-0dba-4b0b-94e4-b159ed111b42', 3, 'III', 'Liado is Very Ill (dedicated to Renik)', 'Children’s Album, Book I, op. 62: III. Liado is Very Ill (dedicated to Renik)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 599 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb223bc1-0dba-4b0b-94e4-b159ed111b42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'On a Birthday (dedicated to Tala)', part.name_en = 'Children’s Album, Book I, op. 62: IV. On a Birthday (dedicated to Tala)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 599 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:3f2fc8d3-16de-474d-ab6d-6c9bc3a0e570' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f2fc8d3-16de-474d-ab6d-6c9bc3a0e570', 4, 'IV', 'On a Birthday (dedicated to Tala)', 'Children’s Album, Book I, op. 62: IV. On a Birthday (dedicated to Tala)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 599 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f2fc8d3-16de-474d-ab6d-6c9bc3a0e570'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Etude (dedicated to Tala)', part.name_en = 'Children’s Album, Book I, op. 62: V. Etude (dedicated to Tala)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 599 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:a4c2d17e-bbe6-48f3-a13c-3520466093bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4c2d17e-bbe6-48f3-a13c-3520466093bc', 5, 'V', 'Etude (dedicated to Tala)', 'Children’s Album, Book I, op. 62: V. Etude (dedicated to Tala)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 599 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4c2d17e-bbe6-48f3-a13c-3520466093bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Musical Picture (dedicated to Rita)', part.name_en = 'Children’s Album, Book I, op. 62: VI. Musical Picture (dedicated to Rita)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 599 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:29e0567e-30e3-430a-b110-fdb041cab8ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29e0567e-30e3-430a-b110-fdb041cab8ec', 6, 'VI', 'Musical Picture (dedicated to Rita)', 'Children’s Album, Book I, op. 62: VI. Musical Picture (dedicated to Rita)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 599 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29e0567e-30e3-430a-b110-fdb041cab8ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'The Cavalry (dedicated to Vladik)', part.name_en = 'Children’s Album, Book I, op. 62: VII. The Cavalry (dedicated to Vladik)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 599 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:6710e5de-b49b-48c9-979d-a36f418f6664' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6710e5de-b49b-48c9-979d-a36f418f6664', 7, 'VII', 'The Cavalry (dedicated to Vladik)', 'Children’s Album, Book I, op. 62: VII. The Cavalry (dedicated to Vladik)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 599 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6710e5de-b49b-48c9-979d-a36f418f6664'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'IX',
    part.name_ko = 'In the Folk Style (dedicated to Nuneh)', part.name_en = 'Children’s Album, Book I, op. 62: IX. In the Folk Style (dedicated to Nuneh)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 599 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:6d045466-8888-4863-8878-3d25ecef529d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d045466-8888-4863-8878-3d25ecef529d', 8, 'IX', 'In the Folk Style (dedicated to Nuneh)', 'Children’s Album, Book I, op. 62: IX. In the Folk Style (dedicated to Nuneh)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 599 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d045466-8888-4863-8878-3d25ecef529d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'X',
    part.name_ko = 'Fugue (dedicated to Nuneh)', part.name_en = 'Children’s Album, Book I, op. 62: X. Fugue (dedicated to Nuneh)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 599 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:ed1bc505-11a1-49a9-ba17-15e210f3f11f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed1bc505-11a1-49a9-ba17-15e210f3f11f', 9, 'X', 'Fugue (dedicated to Nuneh)', 'Children’s Album, Book I, op. 62: X. Fugue (dedicated to Nuneh)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 599 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed1bc505-11a1-49a9-ba17-15e210f3f11f'
);


-- Op. 58 Choreographic Waltz for piano

UPDATE pieces piece
SET piece.title = 'Choreographic Waltz for piano', piece.title_en = 'Choreographic Waltz for piano, op. 58',
    piece.type = 'song', piece.opus_number = 'Op. 58',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1182 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 65 첼로 협주곡 E단조

UPDATE pieces piece
SET piece.title = '첼로 협주곡 E단조', piece.title_en = 'Concerto for Cello and Orchestra in E minor, op. 65',
    piece.type = 'album', piece.opus_number = 'Op. 65',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1570 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Concerto for Cello and Orchestra in E minor, op. 65: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1570 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:fb496791-d474-43dc-8615-0450ffacde85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb496791-d474-43dc-8615-0450ffacde85', 1, 'I', 'Allegro moderato', 'Concerto for Cello and Orchestra in E minor, op. 65: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1570 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb496791-d474-43dc-8615-0450ffacde85'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante sostenuto', part.name_en = 'Concerto for Cello and Orchestra in E minor, op. 65: II. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1570 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:dea48cea-f570-43b3-906e-01b04ff05b44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dea48cea-f570-43b3-906e-01b04ff05b44', 2, 'II', 'Andante sostenuto', 'Concerto for Cello and Orchestra in E minor, op. 65: II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1570 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dea48cea-f570-43b3-906e-01b04ff05b44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro (a battuta)', part.name_en = 'Concerto for Cello and Orchestra in E minor, op. 65: III. Allegro (a battuta)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1570 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:d0f71199-25aa-48e0-b799-06ac474292bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0f71199-25aa-48e0-b799-06ac474292bd', 3, 'III', 'Allegro (a battuta)', 'Concerto for Cello and Orchestra in E minor, op. 65: III. Allegro (a battuta)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1570 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0f71199-25aa-48e0-b799-06ac474292bd'
);


-- Op. 102 Concerto-Rhapsody for piano and orchestra in D-flat major

UPDATE pieces piece
SET piece.title = 'Concerto-Rhapsody for piano and orchestra in D-flat major', piece.title_en = 'Concerto-Rhapsody for piano and orchestra in D-flat major, op. 102',
    piece.type = 'song', piece.opus_number = 'Op. 102',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1708 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 96 Concerto-Rhapsody for violin and orchestra in B-flat minor

UPDATE pieces piece
SET piece.title = 'Concerto-Rhapsody for violin and orchestra in B-flat minor', piece.title_en = 'Concerto-Rhapsody for violin and orchestra in B-flat minor, op. 96',
    piece.type = 'song', piece.opus_number = 'Op. 96',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 835 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 99 Concerto-Rhapsody in D minor for cello and orchestra

UPDATE pieces piece
SET piece.title = 'Concerto-Rhapsody in D minor for cello and orchestra', piece.title_en = 'Concerto-Rhapsody in D minor for cello and orchestra, op. 99',
    piece.type = 'song', piece.opus_number = 'Op. 99',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1807 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 32 Dance Suite for orchestra

UPDATE pieces piece
SET piece.title = 'Dance Suite for orchestra', piece.title_en = 'Dance Suite for orchestra, op. 32',
    piece.type = 'album', piece.opus_number = 'Op. 32',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1063 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Caucasian Dance', part.name_en = 'Dance Suite for orchestra, op. 32: I. Caucasian Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1063 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:346c4314-41d5-4d21-b38b-a4daa59ce3dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:346c4314-41d5-4d21-b38b-a4daa59ce3dc', 1, 'I', 'Caucasian Dance', 'Dance Suite for orchestra, op. 32: I. Caucasian Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1063 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:346c4314-41d5-4d21-b38b-a4daa59ce3dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Armenian Dance', part.name_en = 'Dance Suite for orchestra, op. 32: II. Armenian Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1063 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:4f464959-42c8-4b3d-8755-1663ee911e1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f464959-42c8-4b3d-8755-1663ee911e1a', 2, 'II', 'Armenian Dance', 'Dance Suite for orchestra, op. 32: II. Armenian Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1063 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f464959-42c8-4b3d-8755-1663ee911e1a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Uzbek Dance', part.name_en = 'Dance Suite for orchestra, op. 32: III. Uzbek Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1063 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:07f366d5-653c-49ae-bb11-97e4fbab2fd5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07f366d5-653c-49ae-bb11-97e4fbab2fd5', 3, 'III', 'Uzbek Dance', 'Dance Suite for orchestra, op. 32: III. Uzbek Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1063 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07f366d5-653c-49ae-bb11-97e4fbab2fd5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Uzbek March', part.name_en = 'Dance Suite for orchestra, op. 32: IV. Uzbek March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1063 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:bd279f12-44db-4d9d-8397-4e0b75cb2d34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd279f12-44db-4d9d-8397-4e0b75cb2d34', 4, 'IV', 'Uzbek March', 'Dance Suite for orchestra, op. 32: IV. Uzbek March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1063 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd279f12-44db-4d9d-8397-4e0b75cb2d34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Lezginka', part.name_en = 'Dance Suite for orchestra, op. 32: V. Lezginka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1063 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:fe3cb407-2761-43b7-88cb-fcbc6515cb8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe3cb407-2761-43b7-88cb-fcbc6515cb8e', 5, 'V', 'Lezginka', 'Dance Suite for orchestra, op. 32: V. Lezginka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1063 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe3cb407-2761-43b7-88cb-fcbc6515cb8e'
);


-- Op. 9 Dance in G minor for piano

UPDATE pieces piece
SET piece.title = 'Dance in G minor for piano', piece.title_en = 'Dance in G minor for piano, op. 9',
    piece.type = 'song', piece.opus_number = 'Op. 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1864 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 11 Dance no. 1 in B-flat major for violin and piano

UPDATE pieces piece
SET piece.title = 'Dance no. 1 in B-flat major for violin and piano', piece.title_en = 'Dance no. 1 in B-flat major for violin and piano, op. 11',
    piece.type = 'song', piece.opus_number = 'Op. 11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1231 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 31 Dance no. 3 for piano

UPDATE pieces piece
SET piece.title = 'Dance no. 3 for piano', piece.title_en = 'Dance no. 3 for piano, op. 31',
    piece.type = 'song', piece.opus_number = 'Op. 31',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1553 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 3 Dream for cello and piano

UPDATE pieces piece
SET piece.title = 'Dream for cello and piano', piece.title_en = 'Dream for cello and piano, op. 3',
    piece.type = 'song', piece.opus_number = 'Op. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1322 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 4 엘레지 G단조

UPDATE pieces piece
SET piece.title = '엘레지 G단조', piece.title_en = 'Elegy in G minor for cello and piano, op. 4',
    piece.type = 'song', piece.opus_number = 'Op. 4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2351 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Epilogue

UPDATE pieces piece
SET piece.title = 'Epilogue', piece.title_en = 'Epilogue',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2551 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 59 Fantasy on Russian Themes for symphony orchestra

UPDATE pieces piece
SET piece.title = 'Fantasy on Russian Themes for symphony orchestra', piece.title_en = 'Fantasy on Russian Themes for symphony orchestra, op. 59',
    piece.type = 'song', piece.opus_number = 'Op. 59',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1426 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 53 First Suite from the ballet “Gayaneh” for orchestra

UPDATE pieces piece
SET piece.opus_number = 'Op. 53'
WHERE piece.id = 2799 AND piece.composer_id = 101
  AND piece.catalogue_number IS NULL AND piece.opus_number IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction', part.name_en = 'First Suite from the ballet “Gayaneh” for orchestra, op. 53: I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2799 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:5d655a98-d28f-3db9-9c72-5f919a978eea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d655a98-d28f-3db9-9c72-5f919a978eea', 1, 'I', 'Introduction', 'First Suite from the ballet “Gayaneh” for orchestra, op. 53: I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2799 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d655a98-d28f-3db9-9c72-5f919a978eea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Dance of the Rose Maidens', part.name_en = 'First Suite from the ballet “Gayaneh” for orchestra, op. 53: II. Dance of the Rose Maidens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2799 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:51866579-5f6c-3cc2-9158-7c9af38b873e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51866579-5f6c-3cc2-9158-7c9af38b873e', 2, 'II', 'Dance of the Rose Maidens', 'First Suite from the ballet “Gayaneh” for orchestra, op. 53: II. Dance of the Rose Maidens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2799 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51866579-5f6c-3cc2-9158-7c9af38b873e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Aysheh’s awakening and dance', part.name_en = 'First Suite from the ballet “Gayaneh” for orchestra, op. 53: III. Aysheh’s awakening and dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2799 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:23ce07db-503a-41c0-9628-a90be4bd1e46' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23ce07db-503a-41c0-9628-a90be4bd1e46', 3, 'III', 'Aysheh’s awakening and dance', 'First Suite from the ballet “Gayaneh” for orchestra, op. 53: III. Aysheh’s awakening and dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2799 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23ce07db-503a-41c0-9628-a90be4bd1e46'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Mountaineers’ Dance', part.name_en = 'First Suite from the ballet “Gayaneh” for orchestra, op. 53: IV. Mountaineers’ Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2799 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:c4a062c3-b9d4-4085-9341-9963351d1624' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4a062c3-b9d4-4085-9341-9963351d1624', 4, 'IV', 'Mountaineers’ Dance', 'First Suite from the ballet “Gayaneh” for orchestra, op. 53: IV. Mountaineers’ Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2799 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4a062c3-b9d4-4085-9341-9963351d1624'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Lullaby', part.name_en = 'First Suite from the ballet “Gayaneh” for orchestra, op. 53: V. Lullaby',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2799 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:36c742e3-1043-338f-aa17-63c593ff1954' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36c742e3-1043-338f-aa17-63c593ff1954', 5, 'V', 'Lullaby', 'First Suite from the ballet “Gayaneh” for orchestra, op. 53: V. Lullaby', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2799 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36c742e3-1043-338f-aa17-63c593ff1954'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Scene of Gayane and Giko', part.name_en = 'First Suite from the ballet “Gayaneh” for orchestra, op. 53: VI. Scene of Gayane and Giko',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2799 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:a9bcfb5f-d99b-3684-8e59-6e01855f0114' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9bcfb5f-d99b-3684-8e59-6e01855f0114', 6, 'VI', 'Scene of Gayane and Giko', 'First Suite from the ballet “Gayaneh” for orchestra, op. 53: VI. Scene of Gayane and Giko', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2799 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9bcfb5f-d99b-3684-8e59-6e01855f0114'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Gayaneh’s Adagio', part.name_en = 'First Suite from the ballet “Gayaneh” for orchestra, op. 53: VII. Gayaneh’s Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2799 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:1afb47b4-89b6-33a1-8eb2-b601d6cb4ba5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1afb47b4-89b6-33a1-8eb2-b601d6cb4ba5', 7, 'VII', 'Gayaneh’s Adagio', 'First Suite from the ballet “Gayaneh” for orchestra, op. 53: VII. Gayaneh’s Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2799 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1afb47b4-89b6-33a1-8eb2-b601d6cb4ba5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Lezghinka', part.name_en = 'First Suite from the ballet “Gayaneh” for orchestra, op. 53: VIII. Lezghinka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2799 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:005567a4-127e-4409-95cd-4ca5c735ba63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:005567a4-127e-4409-95cd-4ca5c735ba63', 8, 'VIII', 'Lezghinka', 'First Suite from the ballet “Gayaneh” for orchestra, op. 53: VIII. Lezghinka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2799 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:005567a4-127e-4409-95cd-4ca5c735ba63'
);


-- None 5개의 소품

UPDATE pieces piece
SET piece.title = '5개의 소품', piece.title_en = 'Five Pieces for Wind Band',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2577 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Waltz', part.name_en = 'Five Pieces for Wind Band: I. Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2577 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:419db438-56c4-4821-9747-bb8e1e87b050' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:419db438-56c4-4821-9747-bb8e1e87b050', 1, 'I', 'Waltz', 'Five Pieces for Wind Band: I. Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2577 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:419db438-56c4-4821-9747-bb8e1e87b050'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Polka', part.name_en = 'Five Pieces for Wind Band: II. Polka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2577 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:6a357caa-4bf7-4e59-8189-6235043950e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a357caa-4bf7-4e59-8189-6235043950e6', 2, 'II', 'Polka', 'Five Pieces for Wind Band: II. Polka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2577 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a357caa-4bf7-4e59-8189-6235043950e6'
);


-- None 플루트 협주곡

UPDATE pieces piece
SET piece.title = '플루트 협주곡', piece.title_en = 'Flute Concerto',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1038 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Garun Yerevan

UPDATE pieces piece
SET piece.title = 'Garun Yerevan', piece.title_en = 'Garun Yerevan',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2955 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 50 발레 <Gayaneh> Op. 50

UPDATE pieces piece
SET piece.title = '발레 <Gayaneh> Op. 50', piece.title_en = 'Gayaneh, op. 50',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '50',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1687 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introduction', part.name_en = 'Gayaneh: Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1687 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:dbb66a91-1290-4e01-a8c4-2928487a6494' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbb66a91-1290-4e01-a8c4-2928487a6494', 1, NULL, 'Introduction', 'Gayaneh: Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1687 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbb66a91-1290-4e01-a8c4-2928487a6494'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Prologue (Friendship)', part.name_en = 'Gayaneh: Prologue (Friendship)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1687 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:eeda4469-2eba-41fc-95dc-90b89a9f5159' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eeda4469-2eba-41fc-95dc-90b89a9f5159', 2, NULL, 'Prologue (Friendship)', 'Gayaneh: Prologue (Friendship)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1687 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eeda4469-2eba-41fc-95dc-90b89a9f5159'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eeda4469-2eba-41fc-95dc-90b89a9f5159'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prologue (Friendship). Dance of Armen and Georgi', part.name_en = 'Gayaneh: Prologue (Friendship). Dance of Armen and Georgi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1687 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:0c04b182-09ec-4c3c-b499-0680a5063bd3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0c04b182-09ec-4c3c-b499-0680a5063bd3', 1, NULL, 'Prologue (Friendship). Dance of Armen and Georgi', 'Gayaneh: Prologue (Friendship). Dance of Armen and Georgi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eeda4469-2eba-41fc-95dc-90b89a9f5159'
WHERE p.id = 1687 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c04b182-09ec-4c3c-b499-0680a5063bd3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eeda4469-2eba-41fc-95dc-90b89a9f5159'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Prologue (Friendship). The Hunters', part.name_en = 'Gayaneh: Prologue (Friendship). The Hunters',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1687 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:94859fab-d983-4cde-802f-8cb11a5c9d07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:94859fab-d983-4cde-802f-8cb11a5c9d07', 2, NULL, 'Prologue (Friendship). The Hunters', 'Gayaneh: Prologue (Friendship). The Hunters', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eeda4469-2eba-41fc-95dc-90b89a9f5159'
WHERE p.id = 1687 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94859fab-d983-4cde-802f-8cb11a5c9d07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eeda4469-2eba-41fc-95dc-90b89a9f5159'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Prologue (Friendship). The Storm Approaches', part.name_en = 'Gayaneh: Prologue (Friendship). The Storm Approaches',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1687 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:a0bb5503-3f9a-4359-8f11-c27d4d518b82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a0bb5503-3f9a-4359-8f11-c27d4d518b82', 3, NULL, 'Prologue (Friendship). The Storm Approaches', 'Gayaneh: Prologue (Friendship). The Storm Approaches', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eeda4469-2eba-41fc-95dc-90b89a9f5159'
WHERE p.id = 1687 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0bb5503-3f9a-4359-8f11-c27d4d518b82'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Gayaneh: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1687 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:9ffd930d-eb52-4c0a-8ee4-551a5d7c32ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ffd930d-eb52-4c0a-8ee4-551a5d7c32ad', 3, NULL, 'Act I', 'Gayaneh: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1687 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ffd930d-eb52-4c0a-8ee4-551a5d7c32ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ffd930d-eb52-4c0a-8ee4-551a5d7c32ad'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene I (Spring)', part.name_en = 'Gayaneh: Act I, Scene I (Spring)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1687 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:697f1f18-1a3c-4981-85ee-eb2c43e9c971' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:697f1f18-1a3c-4981-85ee-eb2c43e9c971', 1, NULL, 'Scene I (Spring)', 'Gayaneh: Act I, Scene I (Spring)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ffd930d-eb52-4c0a-8ee4-551a5d7c32ad'
WHERE p.id = 1687 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:697f1f18-1a3c-4981-85ee-eb2c43e9c971'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ffd930d-eb52-4c0a-8ee4-551a5d7c32ad'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene II (Recovery)', part.name_en = 'Gayaneh: Act I, Scene II (Recovery)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1687 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:54f203c0-b992-40da-a318-a35310f887bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:54f203c0-b992-40da-a318-a35310f887bb', 2, NULL, 'Scene II (Recovery)', 'Gayaneh: Act I, Scene II (Recovery)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ffd930d-eb52-4c0a-8ee4-551a5d7c32ad'
WHERE p.id = 1687 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54f203c0-b992-40da-a318-a35310f887bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Gayaneh: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1687 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:f1096e9a-f402-4a02-ac67-2134d8760a6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1096e9a-f402-4a02-ac67-2134d8760a6a', 4, NULL, 'Act II', 'Gayaneh: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1687 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1096e9a-f402-4a02-ac67-2134d8760a6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f1096e9a-f402-4a02-ac67-2134d8760a6a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene IV (Crime)', part.name_en = 'Gayaneh: Act II, Scene IV (Crime)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1687 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:326f7a00-314d-4fd2-b931-29f8d5f37001' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:326f7a00-314d-4fd2-b931-29f8d5f37001', 1, NULL, 'Scene IV (Crime)', 'Gayaneh: Act II, Scene IV (Crime)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f1096e9a-f402-4a02-ac67-2134d8760a6a'
WHERE p.id = 1687 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:326f7a00-314d-4fd2-b931-29f8d5f37001'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f1096e9a-f402-4a02-ac67-2134d8760a6a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene III (Jealousy)', part.name_en = 'Gayaneh: Act II, Scene III (Jealousy)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1687 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:3b261f86-09a8-4d6a-9ba9-58a7eb19a387' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3b261f86-09a8-4d6a-9ba9-58a7eb19a387', 2, NULL, 'Scene III (Jealousy)', 'Gayaneh: Act II, Scene III (Jealousy)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f1096e9a-f402-4a02-ac67-2134d8760a6a'
WHERE p.id = 1687 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b261f86-09a8-4d6a-9ba9-58a7eb19a387'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f1096e9a-f402-4a02-ac67-2134d8760a6a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene V (Love)', part.name_en = 'Gayaneh: Act II, Scene V (Love)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1687 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:cf1ed388-904b-4992-a056-76f9ecea6612' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cf1ed388-904b-4992-a056-76f9ecea6612', 3, NULL, 'Scene V (Love)', 'Gayaneh: Act II, Scene V (Love)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f1096e9a-f402-4a02-ac67-2134d8760a6a'
WHERE p.id = 1687 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf1ed388-904b-4992-a056-76f9ecea6612'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act III', part.name_en = 'Gayaneh: Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1687 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:412eb9ef-bb89-4c97-9201-d5856393a07b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:412eb9ef-bb89-4c97-9201-d5856393a07b', 5, NULL, 'Act III', 'Gayaneh: Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1687 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:412eb9ef-bb89-4c97-9201-d5856393a07b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:412eb9ef-bb89-4c97-9201-d5856393a07b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene VII (Expiation)', part.name_en = 'Gayaneh: Act III, Scene VII (Expiation)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1687 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:94cc5799-81d1-4447-b22b-979c86025c50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:94cc5799-81d1-4447-b22b-979c86025c50', 1, NULL, 'Scene VII (Expiation)', 'Gayaneh: Act III, Scene VII (Expiation)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:412eb9ef-bb89-4c97-9201-d5856393a07b'
WHERE p.id = 1687 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94cc5799-81d1-4447-b22b-979c86025c50'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:412eb9ef-bb89-4c97-9201-d5856393a07b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene VI (Conscience)', part.name_en = 'Gayaneh: Act III, Scene VI (Conscience)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1687 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:e7157173-14ff-4eab-a305-adfa84be9498' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e7157173-14ff-4eab-a305-adfa84be9498', 2, NULL, 'Scene VI (Conscience)', 'Gayaneh: Act III, Scene VI (Conscience)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:412eb9ef-bb89-4c97-9201-d5856393a07b'
WHERE p.id = 1687 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7157173-14ff-4eab-a305-adfa84be9498'
);


-- Op. 91 Greeting Overture in D-flat major for orchestra

UPDATE pieces piece
SET piece.title = 'Greeting Overture in D-flat major for orchestra', piece.title_en = 'Greeting Overture in D-flat major for orchestra, op. 91',
    piece.type = 'song', piece.opus_number = 'Op. 91',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2777 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 43 발레 <Happiness, ballet in three acts>

UPDATE pieces piece
SET piece.title = '발레 <Happiness, ballet in three acts>', piece.title_en = 'Happiness, ballet in three acts, op. 43',
    piece.type = 'song', piece.opus_number = 'Op. 43',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1225 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Iwans Lied

UPDATE pieces piece
SET piece.title = 'Iwans Lied', piece.title_en = 'Iwans Lied',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2733 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Light Lunch

UPDATE pieces piece
SET piece.title = 'Light Lunch', piece.title_en = 'Light Lunch',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1419 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 10 Lullaby for violin and piano

UPDATE pieces piece
SET piece.title = 'Lullaby for violin and piano', piece.title_en = 'Lullaby for violin and piano, op. 10',
    piece.type = 'song', piece.opus_number = 'Op. 10',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2003 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 42a March from the film "Zangezur" for wind orchestra

UPDATE pieces piece
SET piece.title = 'March from the film "Zangezur" for wind orchestra', piece.title_en = 'March from the film "Zangezur" for wind orchestra, op. 42a',
    piece.type = 'song', piece.opus_number = 'Op. 42a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1169 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 34 행진곡 3번

UPDATE pieces piece
SET piece.title = '행진곡 3번', piece.title_en = 'March no. 3 for piano, op. 34',
    piece.type = 'song', piece.opus_number = 'Op. 34',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2436 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Masquerade

UPDATE pieces piece
SET piece.title = 'Masquerade', piece.title_en = 'Masquerade',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2492 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 25 Mass Dance for bayan

UPDATE pieces piece
SET piece.title = 'Mass Dance for bayan', piece.title_en = 'Mass Dance for bayan, op. 25',
    piece.type = 'song', piece.opus_number = 'Op. 25',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1179 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 80 Music to A. Iakobson's Play "The Angel-Protector from Nebraska"

UPDATE pieces piece
SET piece.title = 'Music to A. Iakobson''s Play "The Angel-Protector from Nebraska"', piece.title_en = 'Music to A. Iakobson''s Play "The Angel-Protector from Nebraska", op. 80',
    piece.type = 'song', piece.opus_number = 'Op. 80',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2578 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 57 Music to A. Kron's Play "Detailed Reconnaissance"

UPDATE pieces piece
SET piece.title = 'Music to A. Kron''s Play "Detailed Reconnaissance"', piece.title_en = 'Music to A. Kron''s Play "Detailed Reconnaissance", op. 57',
    piece.type = 'song', piece.opus_number = 'Op. 57',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2420 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 17 Music to A. Paronian's Play "The Eastern Dentist"

UPDATE pieces piece
SET piece.title = 'Music to A. Paronian''s Play "The Eastern Dentist"', piece.title_en = 'Music to A. Paronian''s Play "The Eastern Dentist", op. 17',
    piece.type = 'song', piece.opus_number = 'Op. 17',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1236 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 14 Music to A. Paronian's Play "Uncle Bagdasar"

UPDATE pieces piece
SET piece.title = 'Music to A. Paronian''s Play "Uncle Bagdasar"', piece.title_en = 'Music to A. Paronian''s Play "Uncle Bagdasar", op. 14',
    piece.type = 'song', piece.opus_number = 'Op. 14',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2835 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 69 Music to A. Perventsev's Play "The Southern Junction"

UPDATE pieces piece
SET piece.title = 'Music to A. Perventsev''s Play "The Southern Junction"', piece.title_en = 'Music to A. Perventsev''s Play "The Southern Junction", op. 69',
    piece.type = 'song', piece.opus_number = 'Op. 69',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2658 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 83 Music to B. Lavrenev's Play "Lermontov"

UPDATE pieces piece
SET piece.title = 'Music to B. Lavrenev''s Play "Lermontov"', piece.title_en = 'Music to B. Lavrenev''s Play "Lermontov", op. 83',
    piece.type = 'song', piece.opus_number = 'Op. 83',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2726 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 15 Music to G. Sundukian's Play "Khatabala"

UPDATE pieces piece
SET piece.title = 'Music to G. Sundukian''s Play "Khatabala"', piece.title_en = 'Music to G. Sundukian''s Play "Khatabala", op. 15',
    piece.type = 'song', piece.opus_number = 'Op. 15',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1242 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 36 Music to G. Sundukian's Play "The Ravaged Hearth"

UPDATE pieces piece
SET piece.title = 'Music to G. Sundukian''s Play "The Ravaged Hearth"', piece.title_en = 'Music to G. Sundukian''s Play "The Ravaged Hearth", op. 36',
    piece.type = 'song', piece.opus_number = 'Op. 36',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1434 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 22 Music to I. Mikitenko's Play "An Affair of Honour"

UPDATE pieces piece
SET piece.title = 'Music to I. Mikitenko''s Play "An Affair of Honour"', piece.title_en = 'Music to I. Mikitenko''s Play "An Affair of Honour", op. 22',
    piece.type = 'song', piece.opus_number = 'Op. 22',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1670 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 81 Music to Iu. Chepurin's Play "Spring Stream"

UPDATE pieces piece
SET piece.title = 'Music to Iu. Chepurin''s Play "Spring Stream"', piece.title_en = 'Music to Iu. Chepurin''s Play "Spring Stream", op. 81',
    piece.type = 'song', piece.opus_number = 'Op. 81',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1078 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 45 Music to Lope de Vega's Comedy "The Valencian Widow"

UPDATE pieces piece
SET piece.title = 'Music to Lope de Vega''s Comedy "The Valencian Widow"', piece.title_en = 'Music to Lope de Vega''s Comedy "The Valencian Widow", op. 45',
    piece.type = 'song', piece.opus_number = 'Op. 45',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2121 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 68 Music to M. Aliger's Play "A Tale of Truth"

UPDATE pieces piece
SET piece.title = 'Music to M. Aliger''s Play "A Tale of Truth"', piece.title_en = 'Music to M. Aliger''s Play "A Tale of Truth", op. 68',
    piece.type = 'song', piece.opus_number = 'Op. 68',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1892 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 48 Music to M. Lermontov's Drama "Masquerada" Op. 48

UPDATE pieces piece
SET piece.title = 'Music to M. Lermontov''s Drama "Masquerada" Op. 48', piece.title_en = 'Music to M. Lermontov''s Drama "Masquerada", op. 48',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '48',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1951 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Nina''s Song', part.name_en = 'Nina''s Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1951 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:7e18f61f-f212-4710-9d2a-029ecc1c1b2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e18f61f-f212-4710-9d2a-029ecc1c1b2a', 1, NULL, 'Nina''s Song', 'Nina''s Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1951 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e18f61f-f212-4710-9d2a-029ecc1c1b2a'
);


-- Op. 40 Music to N. Nikitin's Play "Baku"

UPDATE pieces piece
SET piece.title = 'Music to N. Nikitin''s Play "Baku"', piece.title_en = 'Music to N. Nikitin''s Play "Baku", op. 40',
    piece.type = 'song', piece.opus_number = 'Op. 40',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1250 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 51 Music to N. Pogodin's Play "The Kremlin Chimes"

UPDATE pieces piece
SET piece.title = 'Music to N. Pogodin''s Play "The Kremlin Chimes"', piece.title_en = 'Music to N. Pogodin''s Play "The Kremlin Chimes", op. 51',
    piece.type = 'song', piece.opus_number = 'Op. 51',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1902 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 73 Music to S. Mikhalkov's Play "Ilia Golovin"

UPDATE pieces piece
SET piece.title = 'Music to S. Mikhalkov''s Play "Ilia Golovin"', piece.title_en = 'Music to S. Mikhalkov''s Play "Ilia Golovin", op. 73',
    piece.type = 'song', piece.opus_number = 'Op. 73',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1629 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 39 Music to V. Kirshon's Play "The Big Day"

UPDATE pieces piece
SET piece.title = 'Music to V. Kirshon''s Play "The Big Day"', piece.title_en = 'Music to V. Kirshon''s Play "The Big Day", op. 39',
    piece.type = 'song', piece.opus_number = 'Op. 39',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1983 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 63 Music to V. Shkvarkin's Play "The Last Day"

UPDATE pieces piece
SET piece.title = 'Music to V. Shkvarkin''s Play "The Last Day"', piece.title_en = 'Music to V. Shkvarkin''s Play "The Last Day", op. 63',
    piece.type = 'song', piece.opus_number = 'Op. 63',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1086 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 92 Music to W. Shakespeare's Tragedy "King Lear"

UPDATE pieces piece
SET piece.title = 'Music to W. Shakespeare''s Tragedy "King Lear"', piece.title_en = 'Music to W. Shakespeare''s Tragedy "King Lear", op. 92',
    piece.type = 'song', piece.opus_number = 'Op. 92',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2891 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 33 Music to W. Shakespeare's Tragedy "Macbeth"

UPDATE pieces piece
SET piece.title = 'Music to W. Shakespeare''s Tragedy "Macbeth"', piece.title_en = 'Music to W. Shakespeare''s Tragedy "Macbeth", op. 33',
    piece.type = 'song', piece.opus_number = 'Op. 33',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1650 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 84 Music to W. Shakespeare's Tragedy "Macbeth" Op. 84

UPDATE pieces piece
SET piece.title = 'Music to W. Shakespeare''s Tragedy "Macbeth" Op. 84', piece.title_en = 'Music to W. Shakespeare''s Tragedy "Macbeth", op. 84',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '84',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1311 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 98 Music to the Documentary Film "The Tocsin of Peace"

UPDATE pieces piece
SET piece.title = 'Music to the Documentary Film "The Tocsin of Peace"', piece.title_en = 'Music to the Documentary Film "The Tocsin of Peace", op. 98',
    piece.type = 'song', piece.opus_number = 'Op. 98',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1022 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 72 Music to the Documentary Film "Vladimir Ilich Lenin"

UPDATE pieces piece
SET piece.title = 'Music to the Documentary Film "Vladimir Ilich Lenin"', piece.title_en = 'Music to the Documentary Film "Vladimir Ilich Lenin", op. 72',
    piece.type = 'song', piece.opus_number = 'Op. 72',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1376 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 49 Music to the Film "Salavat Iulaev"

UPDATE pieces piece
SET piece.title = 'Music to the Film "Salavat Iulaev"', piece.title_en = 'Music to the Film "Salavat Iulaev", op. 49',
    piece.type = 'song', piece.opus_number = 'Op. 49',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 856 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 85 Music to the Film "Saltanat"

UPDATE pieces piece
SET piece.title = 'Music to the Film "Saltanat"', piece.title_en = 'Music to the Film "Saltanat", op. 85',
    piece.type = 'song', piece.opus_number = 'Op. 85',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2928 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 79 Music to the Film "Ships Storming the Bastions"

UPDATE pieces piece
SET piece.title = 'Music to the Film "Ships Storming the Bastions"', piece.title_en = 'Music to the Film "Ships Storming the Bastions", op. 79',
    piece.type = 'song', piece.opus_number = 'Op. 79',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2426 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 74 Music to the Film "The Battle of Stalingrad"

UPDATE pieces piece
SET piece.title = 'Music to the Film "The Battle of Stalingrad"', piece.title_en = 'Music to the Film "The Battle of Stalingrad", op. 74',
    piece.type = 'song', piece.opus_number = 'Op. 74',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 888 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 86 Music to the Film "The Bonfire of Immortality / Undying Flame" Op. 86

UPDATE pieces piece
SET piece.title = 'Music to the Film "The Bonfire of Immortality / Undying Flame" Op. 86', piece.title_en = 'Music to the Film "The Bonfire of Immortality / Undying Flame", op. 86',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '86',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2145 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Battle and Christ', part.name_en = 'Undying Flame: The Battle and Christ',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2145 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:146084c1-1420-4b5b-b781-a083953844e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:146084c1-1420-4b5b-b781-a083953844e0', 1, NULL, 'The Battle and Christ', 'Undying Flame: The Battle and Christ', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2145 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:146084c1-1420-4b5b-b781-a083953844e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Banishment and Wanderings', part.name_en = 'Undying Flame: Banishment and Wanderings',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2145 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:263919d3-dade-473c-9765-a71e02e2469e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:263919d3-dade-473c-9765-a71e02e2469e', 2, NULL, 'Banishment and Wanderings', 'Undying Flame: Banishment and Wanderings', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2145 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:263919d3-dade-473c-9765-a71e02e2469e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Rebels Capture Bruno in the Forest', part.name_en = 'Undying Flame: Rebels Capture Bruno in the Forest',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2145 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:4e278f08-dd2b-4c7e-9aef-803c34e14733' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e278f08-dd2b-4c7e-9aef-803c34e14733', 3, NULL, 'Rebels Capture Bruno in the Forest', 'Undying Flame: Rebels Capture Bruno in the Forest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2145 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e278f08-dd2b-4c7e-9aef-803c34e14733'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Finale', part.name_en = 'Undying Flame: Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2145 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:7d230aeb-a563-439f-97e2-8ef19d918888' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d230aeb-a563-439f-97e2-8ef19d918888', 4, NULL, 'Finale', 'Undying Flame: Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2145 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d230aeb-a563-439f-97e2-8ef19d918888'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Bruno''s Return to His Homeland', part.name_en = 'Undying Flame: Bruno''s Return to His Homeland',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2145 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:afbbb211-4c1c-4eb7-b443-b40f594299c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afbbb211-4c1c-4eb7-b443-b40f594299c3', 5, NULL, 'Bruno''s Return to His Homeland', 'Undying Flame: Bruno''s Return to His Homeland', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2145 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afbbb211-4c1c-4eb7-b443-b40f594299c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Introduction (Overture)', part.name_en = 'Undying Flame: Introduction (Overture)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2145 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:b0140172-cac0-40ef-bbdd-fef0ee63696e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0140172-cac0-40ef-bbdd-fef0ee63696e', 6, NULL, 'Introduction (Overture)', 'Undying Flame: Introduction (Overture)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2145 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0140172-cac0-40ef-bbdd-fef0ee63696e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Bruno at the Consistory Court', part.name_en = 'Undying Flame: Bruno at the Consistory Court',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2145 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:ec2b07ba-f648-43f5-b505-2d88b0754079' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec2b07ba-f648-43f5-b505-2d88b0754079', 7, NULL, 'Bruno at the Consistory Court', 'Undying Flame: Bruno at the Consistory Court', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2145 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec2b07ba-f648-43f5-b505-2d88b0754079'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Dance Before the Queen', part.name_en = 'Undying Flame: Dance Before the Queen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2145 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:ec8cc537-7eb6-4a6c-8add-084bee4410cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec8cc537-7eb6-4a6c-8add-084bee4410cb', 8, NULL, 'Dance Before the Queen', 'Undying Flame: Dance Before the Queen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2145 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec8cc537-7eb6-4a6c-8add-084bee4410cb'
);


-- Op. 44 Music to the Film "The Garden"

UPDATE pieces piece
SET piece.title = 'Music to the Film "The Garden"', piece.title_en = 'Music to the Film "The Garden", op. 44',
    piece.type = 'song', piece.opus_number = 'Op. 44',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1797 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 90 Music to the Film of A. Kuprin's Story "The Duel"

UPDATE pieces piece
SET piece.title = 'Music to the Film of A. Kuprin''s Story "The Duel"', piece.title_en = 'Music to the Film of A. Kuprin''s Story "The Duel", op. 90',
    piece.type = 'song', piece.opus_number = 'Op. 90',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2573 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 70 Music to the Film of K. Simonov's Play "The Russian Question"

UPDATE pieces piece
SET piece.title = 'Music to the Film of K. Simonov''s Play "The Russian Question"', piece.title_en = 'Music to the Film of K. Simonov''s Play "The Russian Question", op. 70',
    piece.type = 'song', piece.opus_number = 'Op. 70',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1845 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 87 Music to the Film of Shakespeare's tragedy "Othello"

UPDATE pieces piece
SET piece.title = 'Music to the Film of Shakespeare''s tragedy "Othello"', piece.title_en = 'Music to the Film of Shakespeare''s tragedy "Othello", op. 87',
    piece.type = 'song', piece.opus_number = 'Op. 87',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2016 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 37 Music to the Film “Pepo”

UPDATE pieces piece
SET piece.title = 'Music to the Film “Pepo”', piece.title_en = 'Music to the Film “Pepo”, op. 37',
    piece.type = 'album', piece.opus_number = 'Op. 37',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2841 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Overture', part.name_en = 'Music to the Film “Pepo”, op. 37: I. Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2841 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:21e23073-3d08-4c84-911b-f930a9379ecf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21e23073-3d08-4c84-911b-f930a9379ecf', 1, 'I', 'Overture', 'Music to the Film “Pepo”, op. 37: I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2841 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21e23073-3d08-4c84-911b-f930a9379ecf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Pepo’s Song', part.name_en = 'Music to the Film “Pepo”, op. 37: II. Pepo’s Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2841 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:fa07e9ee-12f2-4b76-a7f4-bbdd34b6cffa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa07e9ee-12f2-4b76-a7f4-bbdd34b6cffa', 2, 'II', 'Pepo’s Song', 'Music to the Film “Pepo”, op. 37: II. Pepo’s Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2841 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa07e9ee-12f2-4b76-a7f4-bbdd34b6cffa'
);


-- Op. 64 Music to the Film “Prisoner no. 217”

UPDATE pieces piece
SET piece.title = 'Music to the Film “Prisoner no. 217”', piece.title_en = 'Music to the Film “Prisoner no. 217”, op. 64',
    piece.type = 'album', piece.opus_number = 'Op. 64',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1018 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Overture', part.name_en = 'Music to the Film “Prisoner no. 217”, op. 64: I. Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1018 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:5ce3aeeb-808f-47c5-b4b5-b74fcbab8de2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ce3aeeb-808f-47c5-b4b5-b74fcbab8de2', 1, 'I', 'Overture', 'Music to the Film “Prisoner no. 217”, op. 64: I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1018 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ce3aeeb-808f-47c5-b4b5-b74fcbab8de2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Murder', part.name_en = 'Music to the Film “Prisoner no. 217”, op. 64: II. Murder',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1018 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:f21ec044-41d6-4ef8-8a8b-e09bb318301f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f21ec044-41d6-4ef8-8a8b-e09bb318301f', 2, 'II', 'Murder', 'Music to the Film “Prisoner no. 217”, op. 64: II. Murder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1018 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f21ec044-41d6-4ef8-8a8b-e09bb318301f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'In the Prison', part.name_en = 'Music to the Film “Prisoner no. 217”, op. 64: III. In the Prison',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1018 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:5a13a30f-5594-427c-973c-d796ecfe32d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a13a30f-5594-427c-973c-d796ecfe32d3', 3, 'III', 'In the Prison', 'Music to the Film “Prisoner no. 217”, op. 64: III. In the Prison', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1018 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a13a30f-5594-427c-973c-d796ecfe32d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Work – Recapitulation – Finale', part.name_en = 'Music to the Film “Prisoner no. 217”, op. 64: IV. Work – Recapitulation – Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1018 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:0a380244-86f5-4d52-965d-5a4b2b741003' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a380244-86f5-4d52-965d-5a4b2b741003', 4, 'IV', 'Work – Recapitulation – Finale', 'Music to the Film “Prisoner no. 217”, op. 64: IV. Work – Recapitulation – Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1018 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a380244-86f5-4d52-965d-5a4b2b741003'
);


-- Op. 77 Music to the Film “Secret Mission”

UPDATE pieces piece
SET piece.title = 'Music to the Film “Secret Mission”', piece.title_en = 'Music to the Film “Secret Mission”, op. 77',
    piece.type = 'album', piece.opus_number = 'Op. 77',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1744 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Overture', part.name_en = 'Music to the Film “Secret Mission”, op. 77: I. Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1744 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:cdb14cdf-4669-47b1-a2aa-1f3a8a62a413' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdb14cdf-4669-47b1-a2aa-1f3a8a62a413', 1, 'I', 'Overture', 'Music to the Film “Secret Mission”, op. 77: I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1744 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdb14cdf-4669-47b1-a2aa-1f3a8a62a413'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Pilot', part.name_en = 'Music to the Film “Secret Mission”, op. 77: II. The Pilot',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1744 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:3f1c30ca-2c8e-4b91-b736-954a3a7f9463' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f1c30ca-2c8e-4b91-b736-954a3a7f9463', 2, 'II', 'The Pilot', 'Music to the Film “Secret Mission”, op. 77: II. The Pilot', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1744 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f1c30ca-2c8e-4b91-b736-954a3a7f9463'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Ardenees', part.name_en = 'Music to the Film “Secret Mission”, op. 77: III. The Ardenees',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1744 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:cc73747b-6cc0-454e-9e2f-437e9241692c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc73747b-6cc0-454e-9e2f-437e9241692c', 3, 'III', 'The Ardenees', 'Music to the Film “Secret Mission”, op. 77: III. The Ardenees', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1744 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc73747b-6cc0-454e-9e2f-437e9241692c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Surrender', part.name_en = 'Music to the Film “Secret Mission”, op. 77: IV. Surrender',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1744 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:db793e10-e57d-42d9-bad6-e4839fe5df1b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db793e10-e57d-42d9-bad6-e4839fe5df1b', 4, 'IV', 'Surrender', 'Music to the Film “Secret Mission”, op. 77: IV. Surrender', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1744 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db793e10-e57d-42d9-bad6-e4839fe5df1b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Armaments – Finale', part.name_en = 'Music to the Film “Secret Mission”, op. 77: V. Armaments – Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1744 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:f560c975-d3f4-482a-bb01-3cfcff6bdf15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f560c975-d3f4-482a-bb01-3cfcff6bdf15', 5, 'V', 'Armaments – Finale', 'Music to the Film “Secret Mission”, op. 77: V. Armaments – Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1744 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f560c975-d3f4-482a-bb01-3cfcff6bdf15'
);


-- Op. 78 Music to the film “Admiral Ushakov”

UPDATE pieces piece
SET piece.title = 'Music to the film “Admiral Ushakov”', piece.title_en = 'Music to the film “Admiral Ushakov”, op. 78',
    piece.type = 'album', piece.opus_number = 'Op. 78',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2446 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Overture', part.name_en = 'Music to the film “Admiral Ushakov”, op. 78: I. Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2446 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:1646fa11-9a36-4c84-8030-902482c69a2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1646fa11-9a36-4c84-8030-902482c69a2d', 1, 'I', 'Overture', 'Music to the film “Admiral Ushakov”, op. 78: I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2446 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1646fa11-9a36-4c84-8030-902482c69a2d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Battle', part.name_en = 'Music to the film “Admiral Ushakov”, op. 78: II. Battle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2446 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:8b80be8d-8040-4520-86b0-af36aa6e6585' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b80be8d-8040-4520-86b0-af36aa6e6585', 2, 'II', 'Battle', 'Music to the film “Admiral Ushakov”, op. 78: II. Battle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2446 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b80be8d-8040-4520-86b0-af36aa6e6585'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Funeral', part.name_en = 'Music to the film “Admiral Ushakov”, op. 78: III. Funeral',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2446 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:78589f8c-da6c-42f7-ad37-83c3521b6750' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78589f8c-da6c-42f7-ad37-83c3521b6750', 3, 'III', 'Funeral', 'Music to the film “Admiral Ushakov”, op. 78: III. Funeral', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2446 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78589f8c-da6c-42f7-ad37-83c3521b6750'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Russian Sailors in Naples (The Review of the Fleet)', part.name_en = 'Music to the film “Admiral Ushakov”, op. 78: IV. Russian Sailors in Naples (The Review of the Fleet)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2446 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:69015d04-7d91-4eb0-b7b3-ff38b227335f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69015d04-7d91-4eb0-b7b3-ff38b227335f', 4, 'IV', 'Russian Sailors in Naples (The Review of the Fleet)', 'Music to the film “Admiral Ushakov”, op. 78: IV. Russian Sailors in Naples (The Review of the Fleet)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2446 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69015d04-7d91-4eb0-b7b3-ff38b227335f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Finale', part.name_en = 'Music to the film “Admiral Ushakov”, op. 78: V. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2446 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:1c565d00-c9dc-4311-a9f2-ae7e5ae2edcd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c565d00-c9dc-4311-a9f2-ae7e5ae2edcd', 5, 'V', 'Finale', 'Music to the film “Admiral Ushakov”, op. 78: V. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2446 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c565d00-c9dc-4311-a9f2-ae7e5ae2edcd'
);


-- Op. 13 Pantomime for oboe and piano

UPDATE pieces piece
SET piece.title = 'Pantomime for oboe and piano', piece.title_en = 'Pantomime for oboe and piano, op. 13',
    piece.type = 'song', piece.opus_number = 'Op. 13',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1019 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 38 피아노 협주곡 D♭장조

UPDATE pieces piece
SET piece.title = '피아노 협주곡 D♭장조', piece.title_en = 'Piano Concerto, op. 38',
    piece.type = 'album', piece.opus_number = 'Op. 38',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1071 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro ma non troppo e maestoso', part.name_en = 'Piano Concerto, op. 38: I. Allegro ma non troppo e maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1071 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:a831e32f-9ecc-4af2-a3f4-970fd3082d9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a831e32f-9ecc-4af2-a3f4-970fd3082d9b', 1, 'I', 'Allegro ma non troppo e maestoso', 'Piano Concerto, op. 38: I. Allegro ma non troppo e maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1071 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a831e32f-9ecc-4af2-a3f4-970fd3082d9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante con anima', part.name_en = 'Piano Concerto, op. 38: II. Andante con anima',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1071 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:6bb9b65d-3a0a-4da4-9943-a148375b1314' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bb9b65d-3a0a-4da4-9943-a148375b1314', 2, 'II', 'Andante con anima', 'Piano Concerto, op. 38: II. Andante con anima', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1071 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bb9b65d-3a0a-4da4-9943-a148375b1314'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro brillante', part.name_en = 'Piano Concerto, op. 38: III. Allegro brillante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1071 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:2b49086e-6b64-4c00-ad0c-96f099b5e70b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b49086e-6b64-4c00-ad0c-96f099b5e70b', 3, 'III', 'Allegro brillante', 'Piano Concerto, op. 38: III. Allegro brillante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1071 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b49086e-6b64-4c00-ad0c-96f099b5e70b'
);


-- Op. 95 피아노 소나타 E♭장조

UPDATE pieces piece
SET piece.title = '피아노 소나타 E♭장조', piece.title_en = 'Piano Sonata in E-flat major, op. 95',
    piece.type = 'album', piece.opus_number = 'Op. 95',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 633 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro vivace', part.name_en = 'Piano Sonata in E-flat major, op. 95: I. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 633 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:3b09e31d-07bd-4ef3-834c-00ba888d78b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b09e31d-07bd-4ef3-834c-00ba888d78b8', 1, 'I', 'Allegro vivace', 'Piano Sonata in E-flat major, op. 95: I. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 633 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b09e31d-07bd-4ef3-834c-00ba888d78b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante tranquillo', part.name_en = 'Piano Sonata in E-flat major, op. 95: II. Andante tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 633 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:aa4317ea-5854-4a83-a9eb-a0360911cb87' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa4317ea-5854-4a83-a9eb-a0360911cb87', 2, 'II', 'Andante tranquillo', 'Piano Sonata in E-flat major, op. 95: II. Andante tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 633 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa4317ea-5854-4a83-a9eb-a0360911cb87'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro assai', part.name_en = 'Piano Sonata in E-flat major, op. 95: III. Allegro assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 633 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:41478c3a-bc6f-49d7-b29c-2b7d8fe69888' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41478c3a-bc6f-49d7-b29c-2b7d8fe69888', 3, 'III', 'Allegro assai', 'Piano Sonata in E-flat major, op. 95: III. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 633 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41478c3a-bc6f-49d7-b29c-2b7d8fe69888'
);


-- Op. 7 첼로와 피아노를 위한 소품

UPDATE pieces piece
SET piece.title = '첼로와 피아노를 위한 소품', piece.title_en = 'Piece for cello and piano, op. 7',
    piece.type = 'song', piece.opus_number = 'Op. 7',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1289 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 41 Poem about Stalin "Song of the Ashug" for orchestra and mixed chorus

UPDATE pieces piece
SET piece.title = 'Poem about Stalin "Song of the Ashug" for orchestra and mixed chorus', piece.title_en = 'Poem about Stalin "Song of the Ashug" for orchestra and mixed chorus, op. 41',
    piece.type = 'song', piece.opus_number = 'Op. 41',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2678 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 1 Poem for Piano

UPDATE pieces piece
SET piece.title = 'Poem for Piano', piece.title_en = 'Poem for Piano, op. 1',
    piece.type = 'song', piece.opus_number = 'Op. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1562 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 12 Poem in C-sharp minor for piano

UPDATE pieces piece
SET piece.title = 'Poem in C-sharp minor for piano', piece.title_en = 'Poem in C-sharp minor for piano, op. 12',
    piece.type = 'song', piece.opus_number = 'Op. 12',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1082 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Prologue

UPDATE pieces piece
SET piece.title = 'Prologue', piece.title_en = 'Prologue',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1916 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 101 Recitatives and Fugues for piano

UPDATE pieces piece
SET piece.title = 'Recitatives and Fugues for piano', piece.title_en = 'Recitatives and Fugues for piano, op. 101',
    piece.type = 'song', piece.opus_number = 'Op. 101',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1948 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Sabre Dance>

UPDATE pieces piece
SET piece.title = '가곡 <Sabre Dance>', piece.title_en = 'Sabre Dance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 830 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 54 Second Suite from the ballet “Gayaneh” for orchestra

UPDATE pieces piece
SET piece.title = 'Second Suite from the ballet “Gayaneh” for orchestra', piece.title_en = 'Second Suite from the ballet “Gayaneh” for orchestra, op. 54',
    piece.type = 'album', piece.opus_number = 'Op. 54',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1946 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Greeting Dance', part.name_en = 'Second Suite from the ballet “Gayaneh” for orchestra, op. 54: I. Greeting Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1946 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:73aea1a7-9a70-4fee-b223-dbdeacb96651' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73aea1a7-9a70-4fee-b223-dbdeacb96651', 1, 'I', 'Greeting Dance', 'Second Suite from the ballet “Gayaneh” for orchestra, op. 54: I. Greeting Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1946 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73aea1a7-9a70-4fee-b223-dbdeacb96651'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lyrical Duet of Ayesha and Armen', part.name_en = 'Second Suite from the ballet “Gayaneh” for orchestra, op. 54: II. Lyrical Duet of Ayesha and Armen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1946 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:f64107f9-1903-42a1-b12f-c8e5d6720bad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f64107f9-1903-42a1-b12f-c8e5d6720bad', 2, 'II', 'Lyrical Duet of Ayesha and Armen', 'Second Suite from the ballet “Gayaneh” for orchestra, op. 54: II. Lyrical Duet of Ayesha and Armen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1946 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f64107f9-1903-42a1-b12f-c8e5d6720bad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Russian Dance', part.name_en = 'Second Suite from the ballet “Gayaneh” for orchestra, op. 54: III. Russian Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1946 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:254bb88f-5f40-44fd-9c90-73ccc4e67b50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:254bb88f-5f40-44fd-9c90-73ccc4e67b50', 3, 'III', 'Russian Dance', 'Second Suite from the ballet “Gayaneh” for orchestra, op. 54: III. Russian Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1946 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:254bb88f-5f40-44fd-9c90-73ccc4e67b50'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Nouné’s Dance', part.name_en = 'Second Suite from the ballet “Gayaneh” for orchestra, op. 54: IV. Nouné’s Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1946 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:f9d2676f-0922-454c-8b10-32b8a8d225de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9d2676f-0922-454c-8b10-32b8a8d225de', 4, 'IV', 'Nouné’s Dance', 'Second Suite from the ballet “Gayaneh” for orchestra, op. 54: IV. Nouné’s Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1946 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9d2676f-0922-454c-8b10-32b8a8d225de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Dance of the Old Men and the Female Carpetweavers', part.name_en = 'Second Suite from the ballet “Gayaneh” for orchestra, op. 54: V. Dance of the Old Men and the Female Carpetweavers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1946 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:ec7536fa-8e1b-45fb-99a1-5efc99fcd0cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec7536fa-8e1b-45fb-99a1-5efc99fcd0cd', 5, 'V', 'Dance of the Old Men and the Female Carpetweavers', 'Second Suite from the ballet “Gayaneh” for orchestra, op. 54: V. Dance of the Old Men and the Female Carpetweavers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1946 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec7536fa-8e1b-45fb-99a1-5efc99fcd0cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Armen’s Variation', part.name_en = 'Second Suite from the ballet “Gayaneh” for orchestra, op. 54: VI. Armen’s Variation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1946 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:83a2830d-fb85-34d6-871d-8a5a8369dcdb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83a2830d-fb85-34d6-871d-8a5a8369dcdb', 6, 'VI', 'Armen’s Variation', 'Second Suite from the ballet “Gayaneh” for orchestra, op. 54: VI. Armen’s Variation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1946 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83a2830d-fb85-34d6-871d-8a5a8369dcdb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Fire', part.name_en = 'Second Suite from the ballet “Gayaneh” for orchestra, op. 54: VII. Fire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1946 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:e1778ca9-ffdf-41a8-aa1f-bde3d6905e71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1778ca9-ffdf-41a8-aa1f-bde3d6905e71', 7, 'VII', 'Fire', 'Second Suite from the ballet “Gayaneh” for orchestra, op. 54: VII. Fire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1946 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1778ca9-ffdf-41a8-aa1f-bde3d6905e71'
);


-- Op. 29a 첼로와 피아노를 위한 소나타

UPDATE pieces piece
SET piece.title = '첼로와 피아노를 위한 소나타', piece.title_en = 'Sonata for cello and piano, op. 29a',
    piece.type = 'song', piece.opus_number = 'Op. 29a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2819 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 29 바이올린과 피아노를 위한 소나타

UPDATE pieces piece
SET piece.title = '바이올린과 피아노를 위한 소나타', piece.title_en = 'Sonata for violin and piano, op. 29',
    piece.type = 'album', piece.opus_number = 'Op. 29',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2954 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lent. Rubato ed espressivo', part.name_en = 'Sonata for violin and piano, op. 29: I. Lent. Rubato ed espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2954 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:1c21ad8c-df96-493c-9945-b28030064216' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c21ad8c-df96-493c-9945-b28030064216', 1, 'I', 'Lent. Rubato ed espressivo', 'Sonata for violin and piano, op. 29: I. Lent. Rubato ed espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2954 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c21ad8c-df96-493c-9945-b28030064216'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro ma non troppo', part.name_en = 'Sonata for violin and piano, op. 29: II. Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2954 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:1f067f66-07bd-4546-aad7-d2fe40883f73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f067f66-07bd-4546-aad7-d2fe40883f73', 2, 'II', 'Allegro ma non troppo', 'Sonata for violin and piano, op. 29: II. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2954 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f067f66-07bd-4546-aad7-d2fe40883f73'
);


-- Op. 104 Sonata-Fantasy in C major for cello solo

UPDATE pieces piece
SET piece.title = 'Sonata-Fantasy in C major for cello solo', piece.title_en = 'Sonata-Fantasy in C major for cello solo, op. 104',
    piece.type = 'song', piece.opus_number = 'Op. 104',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2262 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sonata-Monologue for violin solo

UPDATE pieces piece
SET piece.title = 'Sonata-Monologue for violin solo', piece.title_en = 'Sonata-Monologue for violin solo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2442 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 107 Sonata-Song for viola solo

UPDATE pieces piece
SET piece.title = 'Sonata-Song for viola solo', piece.title_en = 'Sonata-Song for viola solo, op. 107',
    piece.type = 'song', piece.opus_number = 'Op. 107',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2439 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 93 소나티네 C장조

UPDATE pieces piece
SET piece.title = '소나티네 C장조', piece.title_en = 'Sonatina in C major for piano, op. 93',
    piece.type = 'album', piece.opus_number = 'Op. 93',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 978 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro giocoso', part.name_en = 'Sonatina in C major for piano, op. 93: I. Allegro giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 978 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:93aacc14-7530-4340-8fb4-dbdfed251110' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93aacc14-7530-4340-8fb4-dbdfed251110', 1, 'I', 'Allegro giocoso', 'Sonatina in C major for piano, op. 93: I. Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 978 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93aacc14-7530-4340-8fb4-dbdfed251110'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante con anima, rubato', part.name_en = 'Sonatina in C major for piano, op. 93: II. Andante con anima, rubato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 978 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:c69a93e5-8125-4810-9254-67d35ac77499' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c69a93e5-8125-4810-9254-67d35ac77499', 2, 'II', 'Andante con anima, rubato', 'Sonatina in C major for piano, op. 93: II. Andante con anima, rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 978 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c69a93e5-8125-4810-9254-67d35ac77499'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro mosso', part.name_en = 'Sonatina in C major for piano, op. 93: III. Allegro mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 978 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:3b437586-1c4e-464c-a360-5b1e4969d764' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b437586-1c4e-464c-a360-5b1e4969d764', 3, 'III', 'Allegro mosso', 'Sonatina in C major for piano, op. 93: III. Allegro mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 978 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b437586-1c4e-464c-a360-5b1e4969d764'
);


-- Op. 2 Song of the Strolling Ashug for cello and piano

UPDATE pieces piece
SET piece.title = 'Song of the Strolling Ashug for cello and piano', piece.title_en = 'Song of the Strolling Ashug for cello and piano, op. 2',
    piece.type = 'song', piece.opus_number = 'Op. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2024 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Song-Poem, op. 19 "In Honor of Ashugs"

UPDATE pieces piece
SET piece.title = 'Song-Poem, op. 19 "In Honor of Ashugs"', piece.title_en = 'Song-Poem, op. 19 "In Honor of Ashugs"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2224 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 82 발레 <Spartacus> Op. 82

UPDATE pieces piece
SET piece.opus_number = 'Op. 82'
WHERE piece.id = 382 AND piece.composer_id = 101
  AND piece.catalogue_number IS NULL AND piece.opus_number IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act 1. 6. Scene and dance with Crotales', part.name_en = 'Spartacus, op. 82: Act 1. 6. Scene and dance with Crotales',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:001e85be-3f34-43cd-ac59-36a81dfe300d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:001e85be-3f34-43cd-ac59-36a81dfe300d', 1, NULL, 'Act 1. 6. Scene and dance with Crotales', 'Spartacus, op. 82: Act 1. 6. Scene and dance with Crotales', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:001e85be-3f34-43cd-ac59-36a81dfe300d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act 2. 10. Adagio', part.name_en = 'Spartacus, op. 82: Act 2. 10. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:02289850-fb2e-4863-99c2-0fb83c205f06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02289850-fb2e-4863-99c2-0fb83c205f06', 2, NULL, 'Act 2. 10. Adagio', 'Spartacus, op. 82: Act 2. 10. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02289850-fb2e-4863-99c2-0fb83c205f06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Variation of Aegina', part.name_en = 'Spartacus: Variation of Aegina',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:054d5c18-1f68-4b01-9106-b188bce39a4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:054d5c18-1f68-4b01-9106-b188bce39a4b', 3, NULL, 'Variation of Aegina', 'Spartacus: Variation of Aegina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:054d5c18-1f68-4b01-9106-b188bce39a4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act 3. 10. Final battle', part.name_en = 'Spartacus, op. 82: Act 3. 10. Final battle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:0847e0b3-2834-4f38-9834-8318ca3f73e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0847e0b3-2834-4f38-9834-8318ca3f73e8', 4, NULL, 'Act 3. 10. Final battle', 'Spartacus, op. 82: Act 3. 10. Final battle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0847e0b3-2834-4f38-9834-8318ca3f73e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act 2. 11. Crassus''s Dance', part.name_en = 'Spartacus, op. 82: Act 2. 11. Crassus''s Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:12fa667b-81f7-4881-a145-b9830a604cbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12fa667b-81f7-4881-a145-b9830a604cbf', 5, NULL, 'Act 2. 11. Crassus''s Dance', 'Spartacus, op. 82: Act 2. 11. Crassus''s Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12fa667b-81f7-4881-a145-b9830a604cbf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act 2. 2. Dance of the shepherd and shepherdess', part.name_en = 'Spartacus, op. 82: Act 2. 2. Dance of the shepherd and shepherdess',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:13752d18-0db0-475d-9846-0d359f7486a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13752d18-0db0-475d-9846-0d359f7486a1', 6, NULL, 'Act 2. 2. Dance of the shepherd and shepherdess', 'Spartacus, op. 82: Act 2. 2. Dance of the shepherd and shepherdess', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13752d18-0db0-475d-9846-0d359f7486a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act 3. 4. Scene', part.name_en = 'Spartacus, op. 82: Act 3. 4. Scene',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:1baf3371-8630-447a-954c-e39ebc240c98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1baf3371-8630-447a-954c-e39ebc240c98', 7, NULL, 'Act 3. 4. Scene', 'Spartacus, op. 82: Act 3. 4. Scene', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1baf3371-8630-447a-954c-e39ebc240c98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act 3. 7. Aegina''s dance', part.name_en = 'Spartacus, op. 82: Act 3. 7. Aegina''s dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:22bdd467-2da7-48a5-8f4a-f8ff379e308f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22bdd467-2da7-48a5-8f4a-f8ff379e308f', 8, NULL, 'Act 3. 7. Aegina''s dance', 'Spartacus, op. 82: Act 3. 7. Aegina''s dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22bdd467-2da7-48a5-8f4a-f8ff379e308f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act 1. 9. Fight of the blindfold gladiators', part.name_en = 'Spartacus, op. 82: Act 1. 9. Fight of the blindfold gladiators',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:2e9beb9d-6a44-433e-aeea-a61734d05767' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e9beb9d-6a44-433e-aeea-a61734d05767', 9, NULL, 'Act 1. 9. Fight of the blindfold gladiators', 'Spartacus, op. 82: Act 1. 9. Fight of the blindfold gladiators', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e9beb9d-6a44-433e-aeea-a61734d05767'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act 1. 10. Gladiator''s death', part.name_en = 'Spartacus, op. 82: Act 1. 10. Gladiator''s death',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:32c2d089-4bc1-499a-98e3-8b009cc7d4e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32c2d089-4bc1-499a-98e3-8b009cc7d4e8', 10, NULL, 'Act 1. 10. Gladiator''s death', 'Spartacus, op. 82: Act 1. 10. Gladiator''s death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32c2d089-4bc1-499a-98e3-8b009cc7d4e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act 2. 13. Spartacus and Crassus fight', part.name_en = 'Spartacus, op. 82: Act 2. 13. Spartacus and Crassus fight',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:516340dc-0a34-4ab1-90b9-f1b088752617' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:516340dc-0a34-4ab1-90b9-f1b088752617', 11, NULL, 'Act 2. 13. Spartacus and Crassus fight', 'Spartacus, op. 82: Act 2. 13. Spartacus and Crassus fight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:516340dc-0a34-4ab1-90b9-f1b088752617'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Act 1. 8. Aegina''s variation and Bacchanalia', part.name_en = 'Spartacus, op. 82: Act 1. 8. Aegina''s variation and Bacchanalia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:521e5332-9c11-416e-af89-c28fb9217883' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:521e5332-9c11-416e-af89-c28fb9217883', 12, NULL, 'Act 1. 8. Aegina''s variation and Bacchanalia', 'Spartacus, op. 82: Act 1. 8. Aegina''s variation and Bacchanalia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:521e5332-9c11-416e-af89-c28fb9217883'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Act 1. 4. Dance of Phrygia and scene of parting', part.name_en = 'Spartacus, op. 82: Act 1. 4. Dance of Phrygia and scene of parting',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:549cc3f5-a761-460b-92c8-e73459e5c603' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:549cc3f5-a761-460b-92c8-e73459e5c603', 13, NULL, 'Act 1. 4. Dance of Phrygia and scene of parting', 'Spartacus, op. 82: Act 1. 4. Dance of Phrygia and scene of parting', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:549cc3f5-a761-460b-92c8-e73459e5c603'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Act 1. 3. Egyptian dance', part.name_en = 'Spartacus, op. 82: Act 1. 3. Egyptian dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:6715dd79-bc64-48f3-9e61-83c227221894' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6715dd79-bc64-48f3-9e61-83c227221894', 14, NULL, 'Act 1. 3. Egyptian dance', 'Spartacus, op. 82: Act 1. 3. Egyptian dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6715dd79-bc64-48f3-9e61-83c227221894'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Act 3. 11. Spartacus''s path', part.name_en = 'Spartacus, op. 82: Act 3. 11. Spartacus''s path',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:713f1fff-8768-416e-b849-01a84f73465a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:713f1fff-8768-416e-b849-01a84f73465a', 15, NULL, 'Act 3. 11. Spartacus''s path', 'Spartacus, op. 82: Act 3. 11. Spartacus''s path', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:713f1fff-8768-416e-b849-01a84f73465a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Act 3. 12. Death of Spartacus and Requiem', part.name_en = 'Spartacus, op. 82: Act 3. 12. Death of Spartacus and Requiem',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:7208fdfc-73f2-4541-8407-04129d06e7ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7208fdfc-73f2-4541-8407-04129d06e7ea', 16, NULL, 'Act 3. 12. Death of Spartacus and Requiem', 'Spartacus, op. 82: Act 3. 12. Death of Spartacus and Requiem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7208fdfc-73f2-4541-8407-04129d06e7ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Act 2. 7. Introduction and dance of the nymphs', part.name_en = 'Spartacus, op. 82: Act 2. 7. Introduction and dance of the nymphs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:77ce3cff-490d-41d6-aba5-3e7aba27fcc5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77ce3cff-490d-41d6-aba5-3e7aba27fcc5', 17, NULL, 'Act 2. 7. Introduction and dance of the nymphs', 'Spartacus, op. 82: Act 2. 7. Introduction and dance of the nymphs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77ce3cff-490d-41d6-aba5-3e7aba27fcc5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Adagio of Spartacus & Phrygia', part.name_en = 'Spartacus: Adagio of Spartacus & Phrygia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:7e4a0b3c-e791-3e85-99e0-4b3328e23191' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e4a0b3c-e791-3e85-99e0-4b3328e23191', 18, NULL, 'Adagio of Spartacus & Phrygia', 'Spartacus: Adagio of Spartacus & Phrygia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e4a0b3c-e791-3e85-99e0-4b3328e23191'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Act 2. 9. Adagio of Aegina and Crassus', part.name_en = 'Spartacus, op. 82: Act 2. 9. Adagio of Aegina and Crassus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:86bafe5e-70e0-44cf-827b-c8a5b6c7fd3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86bafe5e-70e0-44cf-827b-c8a5b6c7fd3f', 19, NULL, 'Act 2. 9. Adagio of Aegina and Crassus', 'Spartacus, op. 82: Act 2. 9. Adagio of Aegina and Crassus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86bafe5e-70e0-44cf-827b-c8a5b6c7fd3f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'The Entrance of Harmodius – Adagio of Aegina and Harmodius', part.name_en = 'Spartacus: The Entrance of Harmodius – Adagio of Aegina and Harmodius',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:8fd31212-908d-4e9e-8781-3b0a0b7439a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fd31212-908d-4e9e-8781-3b0a0b7439a6', 20, NULL, 'The Entrance of Harmodius – Adagio of Aegina and Harmodius', 'Spartacus: The Entrance of Harmodius – Adagio of Aegina and Harmodius', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fd31212-908d-4e9e-8781-3b0a0b7439a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Act 3. 2. Bustle', part.name_en = 'Spartacus, op. 82: Act 3. 2. Bustle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:9b750c1c-8d94-442d-a939-32bd3911ed99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b750c1c-8d94-442d-a939-32bd3911ed99', 21, NULL, 'Act 3. 2. Bustle', 'Spartacus, op. 82: Act 3. 2. Bustle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b750c1c-8d94-442d-a939-32bd3911ed99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Act 3. 3. Adagio of Spartacus and Phrygia', part.name_en = 'Spartacus, op. 82: Act 3. 3. Adagio of Spartacus and Phrygia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:9c246259-2832-4c5c-8fd5-ada9b15524ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c246259-2832-4c5c-8fd5-ada9b15524ac', 22, NULL, 'Act 3. 3. Adagio of Spartacus and Phrygia', 'Spartacus, op. 82: Act 3. 3. Adagio of Spartacus and Phrygia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c246259-2832-4c5c-8fd5-ada9b15524ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Act 2. 3. Slaves'' variation', part.name_en = 'Spartacus, op. 82: Act 2. 3. Slaves'' variation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:9fc17a7e-9997-4b8f-9726-febe6c380384' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fc17a7e-9997-4b8f-9726-febe6c380384', 23, NULL, 'Act 2. 3. Slaves'' variation', 'Spartacus, op. 82: Act 2. 3. Slaves'' variation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fc17a7e-9997-4b8f-9726-febe6c380384'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Act 3. 1. Crassus and Aegina', part.name_en = 'Spartacus, op. 82: Act 3. 1. Crassus and Aegina',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:a0531201-879e-4215-8bce-0b395d3ea553' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0531201-879e-4215-8bce-0b395d3ea553', 24, NULL, 'Act 3. 1. Crassus and Aegina', 'Spartacus, op. 82: Act 3. 1. Crassus and Aegina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0531201-879e-4215-8bce-0b395d3ea553'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Act 2. 8. Aegina''s dance', part.name_en = 'Spartacus, op. 82: Act 2. 8. Aegina''s dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:a3d5204e-6f32-4298-a24b-f5d53f482034' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3d5204e-6f32-4298-a24b-f5d53f482034', 25, NULL, 'Act 2. 8. Aegina''s dance', 'Spartacus, op. 82: Act 2. 8. Aegina''s dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3d5204e-6f32-4298-a24b-f5d53f482034'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'Act 1. 11. Revolt of the slaves and Phrygia''s jubilation', part.name_en = 'Spartacus, op. 82: Act 1. 11. Revolt of the slaves and Phrygia''s jubilation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:a9ff6402-36ff-418d-8a00-ab159eb65953' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9ff6402-36ff-418d-8a00-ab159eb65953', 26, NULL, 'Act 1. 11. Revolt of the slaves and Phrygia''s jubilation', 'Spartacus, op. 82: Act 1. 11. Revolt of the slaves and Phrygia''s jubilation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9ff6402-36ff-418d-8a00-ab159eb65953'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'Act 1. 5. Dance of the Greek slaves', part.name_en = 'Spartacus, op. 82: Act 1. 5. Dance of the Greek slaves',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:ab72f795-52cc-4ace-b300-83cbcd3a2bfd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab72f795-52cc-4ace-b300-83cbcd3a2bfd', 27, NULL, 'Act 1. 5. Dance of the Greek slaves', 'Spartacus, op. 82: Act 1. 5. Dance of the Greek slaves', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab72f795-52cc-4ace-b300-83cbcd3a2bfd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'Act 2. 5. Arrival of Spartacus and his narrative', part.name_en = 'Spartacus, op. 82: Act 2. 5. Arrival of Spartacus and his narrative',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:b251c58a-6fb7-4544-a3a6-233770e6cfbe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b251c58a-6fb7-4544-a3a6-233770e6cfbe', 28, NULL, 'Act 2. 5. Arrival of Spartacus and his narrative', 'Spartacus, op. 82: Act 2. 5. Arrival of Spartacus and his narrative', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b251c58a-6fb7-4544-a3a6-233770e6cfbe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'Act 3. 9. Entry of Spartacus, quarrel and Harmodius''s treachery', part.name_en = 'Spartacus, op. 82: Act 3. 9. Entry of Spartacus, quarrel and Harmodius''s treachery',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:be11abca-f774-4010-9f92-cc734f591be2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be11abca-f774-4010-9f92-cc734f591be2', 29, NULL, 'Act 3. 9. Entry of Spartacus, quarrel and Harmodius''s treachery', 'Spartacus, op. 82: Act 3. 9. Entry of Spartacus, quarrel and Harmodius''s treachery', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be11abca-f774-4010-9f92-cc734f591be2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'Act 1. 2. March of the gladiators', part.name_en = 'Spartacus, op. 82: Act 1. 2. March of the gladiators',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:bfa62935-3d3b-4f7d-881a-89f7c2c621d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfa62935-3d3b-4f7d-881a-89f7c2c621d0', 30, NULL, 'Act 1. 2. March of the gladiators', 'Spartacus, op. 82: Act 1. 2. March of the gladiators', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfa62935-3d3b-4f7d-881a-89f7c2c621d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'Dance of the Gaditanae – The Rebels’ Approach', part.name_en = 'Spartacus: Dance of the Gaditanae – The Rebels’ Approach',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:c3feb5e1-8da9-4bd7-8e26-9b8f7c5f2ca0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3feb5e1-8da9-4bd7-8e26-9b8f7c5f2ca0', 31, NULL, 'Dance of the Gaditanae – The Rebels’ Approach', 'Spartacus: Dance of the Gaditanae – The Rebels’ Approach', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3feb5e1-8da9-4bd7-8e26-9b8f7c5f2ca0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = 'Act 3. 5. Entry of Spartacus', part.name_en = 'Spartacus, op. 82: Act 3. 5. Entry of Spartacus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:d200b565-97e4-40b7-b9b3-abeffd5ebee3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d200b565-97e4-40b7-b9b3-abeffd5ebee3', 32, NULL, 'Act 3. 5. Entry of Spartacus', 'Spartacus, op. 82: Act 3. 5. Entry of Spartacus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d200b565-97e4-40b7-b9b3-abeffd5ebee3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 33, part.movement_number = NULL,
    part.name_ko = 'Act 2. 1. The Via Appia', part.name_en = 'Spartacus, op. 82: Act 2. 1. The Via Appia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:d9706376-b0e5-4d3d-89ec-02a40d7a2df4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9706376-b0e5-4d3d-89ec-02a40d7a2df4', 33, NULL, 'Act 2. 1. The Via Appia', 'Spartacus, op. 82: Act 2. 1. The Via Appia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9706376-b0e5-4d3d-89ec-02a40d7a2df4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 34, part.movement_number = NULL,
    part.name_ko = 'Act 2. 12. Dance of the Gaditanian maidens - Victory of Spartacus', part.name_en = 'Spartacus, op. 82: Act 2. 12. Dance of the Gaditanian maidens - Victory of Spartacus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:e10be214-c228-4da2-b63b-447d448f77f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e10be214-c228-4da2-b63b-447d448f77f2', 34, NULL, 'Act 2. 12. Dance of the Gaditanian maidens - Victory of Spartacus', 'Spartacus, op. 82: Act 2. 12. Dance of the Gaditanian maidens - Victory of Spartacus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e10be214-c228-4da2-b63b-447d448f77f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 35, part.movement_number = NULL,
    part.name_ko = 'Act 3. 6. Entry of the merchants. General dance', part.name_en = 'Spartacus, op. 82: Act 3. 6. Entry of the merchants. General dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:e19a8271-0b76-4b0c-a90d-51b4dce5445f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e19a8271-0b76-4b0c-a90d-51b4dce5445f', 35, NULL, 'Act 3. 6. Entry of the merchants. General dance', 'Spartacus, op. 82: Act 3. 6. Entry of the merchants. General dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e19a8271-0b76-4b0c-a90d-51b4dce5445f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 36, part.movement_number = NULL,
    part.name_ko = 'Act 2. 4. Dance on the shields', part.name_en = 'Spartacus, op. 82: Act 2. 4. Dance on the shields',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:e248e124-8c5f-432f-87ce-4c9eb3c8cff6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e248e124-8c5f-432f-87ce-4c9eb3c8cff6', 36, NULL, 'Act 2. 4. Dance on the shields', 'Spartacus, op. 82: Act 2. 4. Dance on the shields', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e248e124-8c5f-432f-87ce-4c9eb3c8cff6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 37, part.movement_number = NULL,
    part.name_ko = 'Act 1. 7. Etruscan Dance', part.name_en = 'Spartacus, op. 82: Act 1. 7. Etruscan Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:e35131e3-5c84-402b-85bc-a1b0d42ee60b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e35131e3-5c84-402b-85bc-a1b0d42ee60b', 37, NULL, 'Act 1. 7. Etruscan Dance', 'Spartacus, op. 82: Act 1. 7. Etruscan Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e35131e3-5c84-402b-85bc-a1b0d42ee60b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 38, part.movement_number = NULL,
    part.name_ko = 'Act 3. 8. General dance', part.name_en = 'Spartacus, op. 82: Act 3. 8. General dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:e353b937-9f8c-4eda-b219-fec8b1af83ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e353b937-9f8c-4eda-b219-fec8b1af83ea', 38, NULL, 'Act 3. 8. General dance', 'Spartacus, op. 82: Act 3. 8. General dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e353b937-9f8c-4eda-b219-fec8b1af83ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 39, part.movement_number = NULL,
    part.name_ko = 'Act 1. 1. Introduction', part.name_en = 'Spartacus, op. 82: Act 1. 1. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:f3b79bea-7e1c-49ea-9342-d40c2cf9d083' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3b79bea-7e1c-49ea-9342-d40c2cf9d083', 39, NULL, 'Act 1. 1. Introduction', 'Spartacus, op. 82: Act 1. 1. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3b79bea-7e1c-49ea-9342-d40c2cf9d083'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 40, part.movement_number = NULL,
    part.name_ko = 'Act 2. 6. Parting of Spartacus and Phrygia', part.name_en = 'Spartacus, op. 82: Act 2. 6. Parting of Spartacus and Phrygia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 382 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:f3e47cd7-2a14-49c6-ac85-3a99fabc7b70' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3e47cd7-2a14-49c6-ac85-3a99fabc7b70', 40, NULL, 'Act 2. 6. Parting of Spartacus and Phrygia', 'Spartacus, op. 82: Act 2. 6. Parting of Spartacus and Phrygia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 382 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3e47cd7-2a14-49c6-ac85-3a99fabc7b70'
);


-- Op. 60 State Anthem of the Armenian SSR for chorus and symphony orchestra

UPDATE pieces piece
SET piece.title = 'State Anthem of the Armenian SSR for chorus and symphony orchestra', piece.title_en = 'State Anthem of the Armenian SSR for chorus and symphony orchestra, op. 60',
    piece.type = 'song', piece.opus_number = 'Op. 60',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1096 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 23 현악 4중주

UPDATE pieces piece
SET piece.title = '현악 4중주', piece.title_en = 'String Quartet, op. 23',
    piece.type = 'song', piece.opus_number = 'Op. 23',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1117 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 28 피아노 모음곡

UPDATE pieces piece
SET piece.title = '피아노 모음곡', piece.title_en = 'Suite for piano, op. 28',
    piece.type = 'song', piece.opus_number = 'Op. 28',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1819 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 94 Suite from the Music to Lavrenev’s Play “Lermontov” for orchestra

UPDATE pieces piece
SET piece.title = 'Suite from the Music to Lavrenev’s Play “Lermontov” for orchestra', piece.title_en = 'Suite from the Music to Lavrenev’s Play “Lermontov” for orchestra, op. 94',
    piece.type = 'album', piece.opus_number = 'Op. 94',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1445 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction — On the Death of a Poet', part.name_en = 'Suite from the Music to Lavrenev’s Play “Lermontov” for orchestra, op. 94: I. Introduction — On the Death of a Poet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1445 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:0a2fa7ed-97e9-4422-82f0-da8d2af41acb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a2fa7ed-97e9-4422-82f0-da8d2af41acb', 1, 'I', 'Introduction — On the Death of a Poet', 'Suite from the Music to Lavrenev’s Play “Lermontov” for orchestra, op. 94: I. Introduction — On the Death of a Poet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1445 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a2fa7ed-97e9-4422-82f0-da8d2af41acb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Mazurka', part.name_en = 'Suite from the Music to Lavrenev’s Play “Lermontov” for orchestra, op. 94: II. Mazurka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1445 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:3cc1daa2-f42e-4ca4-b386-8ab9984f43ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3cc1daa2-f42e-4ca4-b386-8ab9984f43ee', 2, 'II', 'Mazurka', 'Suite from the Music to Lavrenev’s Play “Lermontov” for orchestra, op. 94: II. Mazurka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1445 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3cc1daa2-f42e-4ca4-b386-8ab9984f43ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Waltz', part.name_en = 'Suite from the Music to Lavrenev’s Play “Lermontov” for orchestra, op. 94: III. Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1445 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:c55064c0-317d-4e61-b258-29e12b4ce035' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c55064c0-317d-4e61-b258-29e12b4ce035', 3, 'III', 'Waltz', 'Suite from the Music to Lavrenev’s Play “Lermontov” for orchestra, op. 94: III. Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1445 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c55064c0-317d-4e61-b258-29e12b4ce035'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Intermezzo and Finale. Lermontov in the Caucasus', part.name_en = 'Suite from the Music to Lavrenev’s Play “Lermontov” for orchestra, op. 94: IV. Intermezzo and Finale. Lermontov in the Caucasus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1445 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:e039293a-bdf0-49d6-9791-eebde15cd3a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e039293a-bdf0-49d6-9791-eebde15cd3a7', 4, 'IV', 'Intermezzo and Finale. Lermontov in the Caucasus', 'Suite from the Music to Lavrenev’s Play “Lermontov” for orchestra, op. 94: IV. Intermezzo and Finale. Lermontov in the Caucasus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1445 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e039293a-bdf0-49d6-9791-eebde15cd3a7'
);


-- Op. 45a Suite from the Music to Lope de Vega’s Comedy “The Valencian Widow” for orchestra

UPDATE pieces piece
SET piece.title = 'Suite from the Music to Lope de Vega’s Comedy “The Valencian Widow” for orchestra', piece.title_en = 'Suite from the Music to Lope de Vega’s Comedy “The Valencian Widow” for orchestra, op. 45a',
    piece.type = 'album', piece.opus_number = 'Op. 45a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1963 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction', part.name_en = 'Suite from the Music to Lope de Vega’s Comedy “The Valencian Widow” for orchestra, op. 45a: I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1963 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:e20a9878-b036-46b6-9e07-1f705854796c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e20a9878-b036-46b6-9e07-1f705854796c', 1, 'I', 'Introduction', 'Suite from the Music to Lope de Vega’s Comedy “The Valencian Widow” for orchestra, op. 45a: I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1963 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e20a9878-b036-46b6-9e07-1f705854796c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Serenade', part.name_en = 'Suite from the Music to Lope de Vega’s Comedy “The Valencian Widow” for orchestra, op. 45a: II. Serenade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1963 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:1ae736cb-9803-459c-a0bf-363e935917c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ae736cb-9803-459c-a0bf-363e935917c9', 2, 'II', 'Serenade', 'Suite from the Music to Lope de Vega’s Comedy “The Valencian Widow” for orchestra, op. 45a: II. Serenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1963 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ae736cb-9803-459c-a0bf-363e935917c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Song', part.name_en = 'Suite from the Music to Lope de Vega’s Comedy “The Valencian Widow” for orchestra, op. 45a: III. Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1963 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:e8842ed1-0a01-4f96-86bb-2f56a684b6f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8842ed1-0a01-4f96-86bb-2f56a684b6f6', 3, 'III', 'Song', 'Suite from the Music to Lope de Vega’s Comedy “The Valencian Widow” for orchestra, op. 45a: III. Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1963 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8842ed1-0a01-4f96-86bb-2f56a684b6f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Comic Dance', part.name_en = 'Suite from the Music to Lope de Vega’s Comedy “The Valencian Widow” for orchestra, op. 45a: IV. Comic Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1963 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:54760dc5-56ae-4458-9f41-a4c39b74f68e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54760dc5-56ae-4458-9f41-a4c39b74f68e', 4, 'IV', 'Comic Dance', 'Suite from the Music to Lope de Vega’s Comedy “The Valencian Widow” for orchestra, op. 45a: IV. Comic Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1963 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54760dc5-56ae-4458-9f41-a4c39b74f68e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Intermezzo', part.name_en = 'Suite from the Music to Lope de Vega’s Comedy “The Valencian Widow” for orchestra, op. 45a: V. Intermezzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1963 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:a606a5b7-3cba-4f38-bb5c-381d818a1e0a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a606a5b7-3cba-4f38-bb5c-381d818a1e0a', 5, 'V', 'Intermezzo', 'Suite from the Music to Lope de Vega’s Comedy “The Valencian Widow” for orchestra, op. 45a: V. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1963 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a606a5b7-3cba-4f38-bb5c-381d818a1e0a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Dance', part.name_en = 'Suite from the Music to Lope de Vega’s Comedy “The Valencian Widow” for orchestra, op. 45a: VI. Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1963 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:567f41d5-a32b-4882-b403-a99b658dada9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:567f41d5-a32b-4882-b403-a99b658dada9', 6, 'VI', 'Dance', 'Suite from the Music to Lope de Vega’s Comedy “The Valencian Widow” for orchestra, op. 45a: VI. Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1963 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:567f41d5-a32b-4882-b403-a99b658dada9'
);


-- Op. 35 교향곡 1번 E단조

UPDATE pieces piece
SET piece.title = '교향곡 1번 E단조', piece.title_en = 'Symphony no. 1 in E minor, op. 35',
    piece.type = 'album', piece.opus_number = 'Op. 35',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1492 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante maestoso con passione – Allegro ma non troppo', part.name_en = 'Symphony no. 1 in E minor, op. 35: I. Andante maestoso con passione – Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1492 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:ca843e53-789d-4d36-ad80-9a92671f9c21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca843e53-789d-4d36-ad80-9a92671f9c21', 1, 'I', 'Andante maestoso con passione – Allegro ma non troppo', 'Symphony no. 1 in E minor, op. 35: I. Andante maestoso con passione – Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1492 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca843e53-789d-4d36-ad80-9a92671f9c21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio sostenuto', part.name_en = 'Symphony no. 1 in E minor, op. 35: II. Adagio sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1492 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:fcc0b5aa-bd3c-4d13-b30d-a477c50907ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcc0b5aa-bd3c-4d13-b30d-a477c50907ca', 2, 'II', 'Adagio sostenuto', 'Symphony no. 1 in E minor, op. 35: II. Adagio sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1492 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcc0b5aa-bd3c-4d13-b30d-a477c50907ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro risoluto', part.name_en = 'Symphony no. 1 in E minor, op. 35: III. Allegro risoluto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1492 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:76d9bebd-012d-40c4-a887-3b637c375056' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76d9bebd-012d-40c4-a887-3b637c375056', 3, 'III', 'Allegro risoluto', 'Symphony no. 1 in E minor, op. 35: III. Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1492 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76d9bebd-012d-40c4-a887-3b637c375056'
);


-- Op. 56 교향곡 2번 E단조 "The Bell"

UPDATE pieces piece
SET piece.title = '교향곡 2번 E단조 "The Bell"', piece.title_en = 'Symphony no. 2 “The Bell” in E minor, op. 56',
    piece.type = 'album', piece.opus_number = 'Op. 56',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1290 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante maestoso', part.name_en = 'Symphony no. 2 “The Bell” in E minor, op. 56: I. Andante maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1290 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:e29bc4fa-74a5-4fba-a45f-9a5efdf2de38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e29bc4fa-74a5-4fba-a45f-9a5efdf2de38', 1, 'I', 'Andante maestoso', 'Symphony no. 2 “The Bell” in E minor, op. 56: I. Andante maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1290 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e29bc4fa-74a5-4fba-a45f-9a5efdf2de38'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro risoluto', part.name_en = 'Symphony no. 2 “The Bell” in E minor, op. 56: II. Allegro risoluto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1290 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:758accbd-c4a9-494d-a3d4-ce623c88789c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:758accbd-c4a9-494d-a3d4-ce623c88789c', 2, 'II', 'Allegro risoluto', 'Symphony no. 2 “The Bell” in E minor, op. 56: II. Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1290 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:758accbd-c4a9-494d-a3d4-ce623c88789c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante sostenuto', part.name_en = 'Symphony no. 2 “The Bell” in E minor, op. 56: III. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1290 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:1160e71f-e1d1-4095-a28a-bbb518438cf1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1160e71f-e1d1-4095-a28a-bbb518438cf1', 3, 'III', 'Andante sostenuto', 'Symphony no. 2 “The Bell” in E minor, op. 56: III. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1290 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1160e71f-e1d1-4095-a28a-bbb518438cf1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Andante mosso — Allegro sostenuto. Maestoso', part.name_en = 'Symphony no. 2 “The Bell” in E minor, op. 56: IV. Andante mosso — Allegro sostenuto. Maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1290 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:07937ae4-0b21-4114-80d8-0e5b09644b7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07937ae4-0b21-4114-80d8-0e5b09644b7b', 4, 'IV', 'Andante mosso — Allegro sostenuto. Maestoso', 'Symphony no. 2 “The Bell” in E minor, op. 56: IV. Andante mosso — Allegro sostenuto. Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1290 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07937ae4-0b21-4114-80d8-0e5b09644b7b'
);


-- Op. 67 교향곡 3번 C장조 "Simfoniya-poema"

UPDATE pieces piece
SET piece.title = '교향곡 3번 C장조 "Simfoniya-poema"', piece.title_en = 'Symphony no. 3 in C major “Simfoniya-poema”, op. 67',
    piece.type = 'song', piece.opus_number = 'Op. 67',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1373 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 55 Third Suite from the ballet “Gayaneh” for orchestra

UPDATE pieces piece
SET piece.title = 'Third Suite from the ballet “Gayaneh” for orchestra', piece.title_en = 'Third Suite from the ballet “Gayaneh” for orchestra, op. 55',
    piece.type = 'album', piece.opus_number = 'Op. 55',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1050 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Cotton Harvest', part.name_en = 'Third Suite from the ballet “Gayaneh” for orchestra, op. 55: I. Cotton Harvest',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1050 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:1fb3f039-ffbc-4339-8389-3f7b4adb0f7c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fb3f039-ffbc-4339-8389-3f7b4adb0f7c', 1, 'I', 'Cotton Harvest', 'Third Suite from the ballet “Gayaneh” for orchestra, op. 55: I. Cotton Harvest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1050 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fb3f039-ffbc-4339-8389-3f7b4adb0f7c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Dance of the Young Kurds', part.name_en = 'Third Suite from the ballet “Gayaneh” for orchestra, op. 55: II. Dance of the Young Kurds',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1050 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:0e6621ca-fba1-43e5-80dc-0311cfc816e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e6621ca-fba1-43e5-80dc-0311cfc816e1', 2, 'II', 'Dance of the Young Kurds', 'Third Suite from the ballet “Gayaneh” for orchestra, op. 55: II. Dance of the Young Kurds', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1050 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e6621ca-fba1-43e5-80dc-0311cfc816e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Introduction and Dance of the Old Men', part.name_en = 'Third Suite from the ballet “Gayaneh” for orchestra, op. 55: III. Introduction and Dance of the Old Men',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1050 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:042b18ea-9497-48ef-a53e-b70a631249f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:042b18ea-9497-48ef-a53e-b70a631249f3', 3, 'III', 'Introduction and Dance of the Old Men', 'Third Suite from the ballet “Gayaneh” for orchestra, op. 55: III. Introduction and Dance of the Old Men', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1050 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:042b18ea-9497-48ef-a53e-b70a631249f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Scene of the Carpetweavers', part.name_en = 'Third Suite from the ballet “Gayaneh” for orchestra, op. 55: IV. Scene of the Carpetweavers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1050 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:1299456a-705a-489b-a246-19fc340ef361' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1299456a-705a-489b-a246-19fc340ef361', 4, 'IV', 'Scene of the Carpetweavers', 'Third Suite from the ballet “Gayaneh” for orchestra, op. 55: IV. Scene of the Carpetweavers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1050 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1299456a-705a-489b-a246-19fc340ef361'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'VI',
    part.name_ko = 'Gopak', part.name_en = 'Third Suite from the ballet “Gayaneh” for orchestra, op. 55: VI. Gopak',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1050 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:885ce30a-8de6-3dd4-9c6f-69dac765a850' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:885ce30a-8de6-3dd4-9c6f-69dac765a850', 5, 'VI', 'Gopak', 'Third Suite from the ballet “Gayaneh” for orchestra, op. 55: VI. Gopak', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1050 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:885ce30a-8de6-3dd4-9c6f-69dac765a850'
);


-- Op. 66 Three Concert Arias for high voice and orchestra Op. 66

UPDATE pieces piece
SET piece.title = 'Three Concert Arias for high voice and orchestra Op. 66', piece.title_en = 'Three Concert Arias for high voice and orchestra, op. 66',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '66',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2087 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Poem', part.name_en = 'Three Concert Arias for high voice and orchestra, op. 66: 1. Poem',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2087 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:a6f4995b-e5a7-489d-9b56-147761efeee4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6f4995b-e5a7-489d-9b56-147761efeee4', 1, NULL, 'Poem', 'Three Concert Arias for high voice and orchestra, op. 66: 1. Poem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2087 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6f4995b-e5a7-489d-9b56-147761efeee4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Legend', part.name_en = 'Three Concert Arias for high voice and orchestra, op. 66: 2. Legend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2087 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:320f467b-4714-4834-b70e-78b3859aa61e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:320f467b-4714-4834-b70e-78b3859aa61e', 2, NULL, 'Legend', 'Three Concert Arias for high voice and orchestra, op. 66: 2. Legend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2087 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:320f467b-4714-4834-b70e-78b3859aa61e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Dithyramb', part.name_en = 'Three Concert Arias for high voice and orchestra, op. 66: 3. Dithyramb',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2087 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:f43aa507-389b-49d3-85cb-63c2e8faa0a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f43aa507-389b-49d3-85cb-63c2e8faa0a5', 3, NULL, 'Dithyramb', 'Three Concert Arias for high voice and orchestra, op. 66: 3. Dithyramb', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2087 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f43aa507-389b-49d3-85cb-63c2e8faa0a5'
);


-- Op. 61 3개의 소품

UPDATE pieces piece
SET piece.title = '3개의 소품', piece.title_en = 'Three Pieces for two pianos, op. 61',
    piece.type = 'song', piece.opus_number = 'Op. 61',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1680 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 토카타 B♭단조

UPDATE pieces piece
SET piece.title = '토카타 B♭단조', piece.title_en = 'Toccata in B-flat minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1958 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 24 토카타 E♭단조

UPDATE pieces piece
SET piece.title = '토카타 E♭단조', piece.title_en = 'Toccata in E-flat minor for piano, op. 24',
    piece.type = 'song', piece.opus_number = 'Op. 24',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2219 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 30 Trio in C minor for B-flat Clarinet, Violin and Piano

UPDATE pieces piece
SET piece.title = 'Trio in C minor for B-flat Clarinet, Violin and Piano', piece.title_en = 'Trio in C minor for B-flat Clarinet, Violin and Piano, op. 30',
    piece.type = 'album', piece.opus_number = 'Op. 30',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1672 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante con dolore', part.name_en = 'Trio in C minor for B-flat Clarinet, Violin and Piano, op. 30: I. Andante con dolore',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1672 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:ba6fb610-502f-49af-a283-2654481a8b48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba6fb610-502f-49af-a283-2654481a8b48', 1, 'I', 'Andante con dolore', 'Trio in C minor for B-flat Clarinet, Violin and Piano, op. 30: I. Andante con dolore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1672 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba6fb610-502f-49af-a283-2654481a8b48'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Trio in C minor for B-flat Clarinet, Violin and Piano, op. 30: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1672 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:d9e9f714-5919-4384-9c06-f7ecc854d27c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9e9f714-5919-4384-9c06-f7ecc854d27c', 2, 'II', 'Allegro', 'Trio in C minor for B-flat Clarinet, Violin and Piano, op. 30: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1672 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9e9f714-5919-4384-9c06-f7ecc854d27c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Moderato', part.name_en = 'Trio in C minor for B-flat Clarinet, Violin and Piano, op. 30: III. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1672 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:97940b7d-896d-443e-ab45-255f86d8fd10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97940b7d-896d-443e-ab45-255f86d8fd10', 3, 'III', 'Moderato', 'Trio in C minor for B-flat Clarinet, Violin and Piano, op. 30: III. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1672 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97940b7d-896d-443e-ab45-255f86d8fd10'
);


-- Op. 105 Triumphal Fanfares in F major for trumpets and drums

UPDATE pieces piece
SET piece.title = 'Triumphal Fanfares in F major for trumpets and drums', piece.title_en = 'Triumphal Fanfares in F major for trumpets and drums, op. 105',
    piece.type = 'song', piece.opus_number = 'Op. 105',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 997 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 75 Triumphal Poem (Festive Poem) in D major for orchestra

UPDATE pieces piece
SET piece.title = 'Triumphal Poem (Festive Poem) in D major for orchestra', piece.title_en = 'Triumphal Poem (Festive Poem) in D major for orchestra, op. 75',
    piece.type = 'song', piece.opus_number = 'Op. 75',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 603 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 27 Two Pieces on Themes of Armenian Folk Songs for wind orchestra

UPDATE pieces piece
SET piece.title = 'Two Pieces on Themes of Armenian Folk Songs for wind orchestra', piece.title_en = 'Two Pieces on Themes of Armenian Folk Songs for wind orchestra, op. 27',
    piece.type = 'song', piece.opus_number = 'Op. 27',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2352 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 26 Two Pieces on Themes of Uzbek Folk Songs for wind orchestra

UPDATE pieces piece
SET piece.title = 'Two Pieces on Themes of Uzbek Folk Songs for wind orchestra', piece.title_en = 'Two Pieces on Themes of Uzbek Folk Songs for wind orchestra, op. 26',
    piece.type = 'song', piece.opus_number = 'Op. 26',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2389 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 16 Variations on the Theme "Solveig" for piano

UPDATE pieces piece
SET piece.title = 'Variations on the Theme "Solveig" for piano', piece.title_en = 'Variations on the Theme "Solveig" for piano, op. 16',
    piece.type = 'song', piece.opus_number = 'Op. 16',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1509 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 46 바이올린 협주곡 D단조

UPDATE pieces piece
SET piece.opus_number = 'Op. 46'
WHERE piece.id = 383 AND piece.composer_id = 101
  AND piece.catalogue_number IS NULL AND piece.opus_number IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con fermezza', part.name_en = 'Violin Concerto in D minor, op. 46: I. Allegro con fermezza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 383 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:ddb3e4c4-bc8f-357d-bb2c-1a88b6ad5516' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddb3e4c4-bc8f-357d-bb2c-1a88b6ad5516', 1, 'I', 'Allegro con fermezza', 'Violin Concerto in D minor, op. 46: I. Allegro con fermezza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 383 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddb3e4c4-bc8f-357d-bb2c-1a88b6ad5516'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante sostenuto', part.name_en = 'Violin Concerto in D minor, op. 46: II. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 383 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:b23c43e4-b5f2-3132-b797-11ddd9427a0a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b23c43e4-b5f2-3132-b797-11ddd9427a0a', 2, 'II', 'Andante sostenuto', 'Violin Concerto in D minor, op. 46: II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 383 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b23c43e4-b5f2-3132-b797-11ddd9427a0a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro vivace', part.name_en = 'Violin Concerto in D minor, op. 46: III. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 383 AND p.composer_id = 101 AND part.part_key = 'musicbrainz:07de8274-b0d3-3b05-b6e4-d9775496a7bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07de8274-b0d3-3b05-b6e4-d9775496a7bc', 3, 'III', 'Allegro vivace', 'Violin Concerto in D minor, op. 46: III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 383 AND p.composer_id = 101
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07de8274-b0d3-3b05-b6e4-d9775496a7bc'
);


-- None Vocalise in C major for piano

UPDATE pieces piece
SET piece.title = 'Vocalise in C major for piano', piece.title_en = 'Vocalise in C major for piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 3001 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 8 Waltz-Caprice in C-sharp minor for piano

UPDATE pieces piece
SET piece.title = 'Waltz-Caprice in C-sharp minor for piano', piece.title_en = 'Waltz-Caprice in C-sharp minor for piano, op. 8',
    piece.type = 'song', piece.opus_number = 'Op. 8',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2528 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 6 Waltz-Etude for piano

UPDATE pieces piece
SET piece.title = 'Waltz-Etude for piano', piece.title_en = 'Waltz-Etude for piano, op. 6',
    piece.type = 'song', piece.opus_number = 'Op. 6',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2903 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Zdravitsa

UPDATE pieces piece
SET piece.title = 'Zdravitsa', piece.title_en = 'Zdravitsa',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 979 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Марш московской милиции>

UPDATE pieces piece
SET piece.title = '가곡 <Марш московской милиции>', piece.title_en = 'Марш московской милиции',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2374 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 88 “Ode To Joy”, cantata for mezzo-soprano, mixed chorus, ensemble of violinists, ensemble of harps and orchestra

UPDATE pieces piece
SET piece.title = '“Ode To Joy”, cantata for mezzo-soprano, mixed chorus, ensemble of violinists, ensemble of harps and orchestra', piece.title_en = '“Ode To Joy”, cantata for mezzo-soprano, mixed chorus, ensemble of violinists, ensemble of harps and orchestra, op. 88',
    piece.type = 'song', piece.opus_number = 'Op. 88',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1833 AND piece.composer_id = 101
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Andantino>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Andantino>', 'Andantino', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 101
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Andantino>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2cd04258-4a00-4be2-a744-7085a1d42648'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2cd04258-4a00-4be2-a744-7085a1d42648'
FROM pieces p
WHERE p.composer_id = 101 AND p.title = '가곡 <Andantino>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2cd04258-4a00-4be2-a744-7085a1d42648'
);


-- Op. 103 March of the Soviet Militia in E-flat major

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'March of the Soviet Militia in E-flat major', 'March of the Soviet Militia in E-flat major, op. 103', 'song', 'Op. 103', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 101
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'March of the Soviet Militia in E-flat major'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17f5e19d-44e0-4c32-8b58-3c86f40c4d87'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '17f5e19d-44e0-4c32-8b58-3c86f40c4d87'
FROM pieces p
WHERE p.composer_id = 101 AND p.title = 'March of the Soviet Militia in E-flat major' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17f5e19d-44e0-4c32-8b58-3c86f40c4d87'
);


-- Op. 42 Music to the Historical-Revolutionary Film "Zangezur"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Music to the Historical-Revolutionary Film "Zangezur"', 'Music to the Historical-Revolutionary Film "Zangezur", op. 42', 'song', 'Op. 42', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 101
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Music to the Historical-Revolutionary Film "Zangezur"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3dc82237-26ec-465f-ad85-fccac03e039a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3dc82237-26ec-465f-ad85-fccac03e039a'
FROM pieces p
WHERE p.composer_id = 101 AND p.title = 'Music to the Historical-Revolutionary Film "Zangezur"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3dc82237-26ec-465f-ad85-fccac03e039a'
);


-- 카탈로그에 대응이 없는 seed 작품 33개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 101 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    555, 725, 831, 847, 864, 886, 903, 966, 1017, 1043, 1263, 1334, 1414, 1449, 1502, 1642, 1692, 1729, 1786, 1860,
    2076, 2182, 2217, 2257, 2330, 2367, 2522, 2584, 2781, 2812, 2887, 2961, 2964
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
