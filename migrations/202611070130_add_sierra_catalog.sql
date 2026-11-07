-- Roberto Sierra 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 29개(묶음 2, 다악장 19, 낱곡 8),
-- 새 작품 4개, part 106개, 그 아래 0개.
-- seed 25개 중 25개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.
--
-- 5차는 4차 규칙(사람·에이전트 판단 없음)을 그대로 썼다. 규칙은
-- seed_pipeline/curation/catalog-wave4-2026-10-12/auto/auto_catalog.py, 작곡가별 자료는
-- seed_pipeline/curation/catalog-wave5-2026-11-07/<작곡가>/(catalog.json·seed_map.json).
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

-- None Bongo-O

UPDATE pieces piece
SET piece.title = 'Bongo-O', piece.title_en = 'Bongo-O',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16565 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cantares

UPDATE pieces piece
SET piece.title = 'Cantares', piece.title_en = 'Cantares',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19784 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Hanacpachap cussicuinin', part.name_en = 'Cantares: I. Hanacpachap cussicuinin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19784 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:cf5a41b9-c185-4647-9e61-8f27daf12ccf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf5a41b9-c185-4647-9e61-8f27daf12ccf', 1, 'I', 'Hanacpachap cussicuinin', 'Cantares: I. Hanacpachap cussicuinin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19784 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf5a41b9-c185-4647-9e61-8f27daf12ccf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Canto lucumí', part.name_en = 'Cantares: II. Canto lucumí',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19784 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:3757e70d-06e6-4680-89f7-c5993e9f95bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3757e70d-06e6-4680-89f7-c5993e9f95bb', 2, 'II', 'Canto lucumí', 'Cantares: II. Canto lucumí', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19784 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3757e70d-06e6-4680-89f7-c5993e9f95bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Interludio', part.name_en = 'Cantares: III. Interludio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19784 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:c6031840-9775-4e73-a780-25fd5033f46c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6031840-9775-4e73-a780-25fd5033f46c', 3, 'III', 'Interludio', 'Cantares: III. Interludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19784 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6031840-9775-4e73-a780-25fd5033f46c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Suerte lamentosa', part.name_en = 'Cantares: IV. Suerte lamentosa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19784 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:80b1c3bf-14ea-439e-98d4-5b3451701235' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80b1c3bf-14ea-439e-98d4-5b3451701235', 4, 'IV', 'Suerte lamentosa', 'Cantares: IV. Suerte lamentosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19784 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80b1c3bf-14ea-439e-98d4-5b3451701235'
);


-- None Caribbean Rhapsody

UPDATE pieces piece
SET piece.title = 'Caribbean Rhapsody', piece.title_en = 'Caribbean Rhapsody',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19348 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Con Salsa

UPDATE pieces piece
SET piece.title = 'Con Salsa', piece.title_en = 'Con Salsa',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16809 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Concerto for Saxophones and Orchestra

UPDATE pieces piece
SET piece.title = 'Concerto for Saxophones and Orchestra', piece.title_en = 'Concerto for Saxophones and Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17165 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Rítmico', part.name_en = 'Concerto for Saxophones and Orchestra: I. Rítmico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17165 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:f0e7dff0-ccf3-46f2-9a75-3c53b51ae137' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0e7dff0-ccf3-46f2-9a75-3c53b51ae137', 1, 'I', 'Rítmico', 'Concerto for Saxophones and Orchestra: I. Rítmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17165 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0e7dff0-ccf3-46f2-9a75-3c53b51ae137'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Tender', part.name_en = 'Concerto for Saxophones and Orchestra: II. Tender',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17165 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:820b3754-355b-4a68-a6ea-8af7af54efc7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:820b3754-355b-4a68-a6ea-8af7af54efc7', 2, 'II', 'Tender', 'Concerto for Saxophones and Orchestra: II. Tender', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17165 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:820b3754-355b-4a68-a6ea-8af7af54efc7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Playful - Fast (With Swing)', part.name_en = 'Concerto for Saxophones and Orchestra: III. Playful - Fast (With Swing)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17165 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:14dad65f-c681-439f-96e1-4a1ff82a2c89' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14dad65f-c681-439f-96e1-4a1ff82a2c89', 3, 'III', 'Playful - Fast (With Swing)', 'Concerto for Saxophones and Orchestra: III. Playful - Fast (With Swing)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17165 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14dad65f-c681-439f-96e1-4a1ff82a2c89'
);


-- None Concierto barroco

UPDATE pieces piece
SET piece.title = 'Concierto barroco', piece.title_en = 'Concierto barroco',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16325 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Concierto nocturnal

UPDATE pieces piece
SET piece.title = 'Concierto nocturnal', piece.title_en = 'Concierto nocturnal',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16530 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Al caer la noche', part.name_en = 'Concierto nocturnal: I. Al caer la noche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16530 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:f28e48d2-613c-4d8b-b366-1b8fd134145a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f28e48d2-613c-4d8b-b366-1b8fd134145a', 1, 'I', 'Al caer la noche', 'Concierto nocturnal: I. Al caer la noche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16530 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f28e48d2-613c-4d8b-b366-1b8fd134145a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Bembé – Fauna', part.name_en = 'Concierto nocturnal: II. Bembé – Fauna',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16530 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:e7e2b6d8-77d3-4000-a5c2-f20c8f0bf3fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7e2b6d8-77d3-4000-a5c2-f20c8f0bf3fb', 2, 'II', 'Bembé – Fauna', 'Concierto nocturnal: II. Bembé – Fauna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16530 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7e2b6d8-77d3-4000-a5c2-f20c8f0bf3fb'
);


-- None Cuatro versos

UPDATE pieces piece
SET piece.title = 'Cuatro versos', piece.title_en = 'Cuatro versos',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17432 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Intenso', part.name_en = 'Cuatro versos: I. Intenso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17432 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:3b399f9d-b373-474f-a3f5-a978ea910c96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b399f9d-b373-474f-a3f5-a978ea910c96', 1, 'I', 'Intenso', 'Cuatro versos: I. Intenso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17432 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b399f9d-b373-474f-a3f5-a978ea910c96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Emotivo', part.name_en = 'Cuatro versos: II. Emotivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17432 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:a8b27016-5782-4d13-a2e8-ef00fa659428' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8b27016-5782-4d13-a2e8-ef00fa659428', 2, 'II', 'Emotivo', 'Cuatro versos: II. Emotivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17432 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8b27016-5782-4d13-a2e8-ef00fa659428'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivo', part.name_en = 'Cuatro versos: III. Vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17432 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:8b52ee3b-eed2-47f1-a481-7bd2f8b0aa0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b52ee3b-eed2-47f1-a481-7bd2f8b0aa0f', 3, 'III', 'Vivo', 'Cuatro versos: III. Vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17432 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b52ee3b-eed2-47f1-a481-7bd2f8b0aa0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Rítmico', part.name_en = 'Cuatro versos: IV. Rítmico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17432 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:7123a654-59ce-4dac-8b1e-db5ba24e97b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7123a654-59ce-4dac-8b1e-db5ba24e97b9', 4, 'IV', 'Rítmico', 'Cuatro versos: IV. Rítmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17432 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7123a654-59ce-4dac-8b1e-db5ba24e97b9'
);


-- None Cuentos

UPDATE pieces piece
SET piece.title = 'Cuentos', piece.title_en = 'Cuentos',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17390 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lenguas desconocidas', part.name_en = 'Cuentos: I. Lenguas desconocidas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17390 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:47e182eb-c312-49cb-8747-1392ff73855d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47e182eb-c312-49cb-8747-1392ff73855d', 1, 'I', 'Lenguas desconocidas', 'Cuentos: I. Lenguas desconocidas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17390 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47e182eb-c312-49cb-8747-1392ff73855d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lo que pasó en las nubes', part.name_en = 'Cuentos: II. Lo que pasó en las nubes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17390 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:d257aa0d-925a-4d29-9d56-0c5f327ff8a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d257aa0d-925a-4d29-9d56-0c5f327ff8a4', 2, 'II', 'Lo que pasó en las nubes', 'Cuentos: II. Lo que pasó en las nubes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17390 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d257aa0d-925a-4d29-9d56-0c5f327ff8a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Batata-Coco (¿mambo?)', part.name_en = 'Cuentos: III. Batata-Coco (¿mambo?)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17390 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:e1165090-d1ea-4e0e-8a75-049f30e11c6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1165090-d1ea-4e0e-8a75-049f30e11c6d', 3, 'III', 'Batata-Coco (¿mambo?)', 'Cuentos: III. Batata-Coco (¿mambo?)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17390 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1165090-d1ea-4e0e-8a75-049f30e11c6d'
);


-- None Diferencias

UPDATE pieces piece
SET piece.title = 'Diferencias', piece.title_en = 'Diferencias',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17909 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Como una fanfarria. Sonoro -', part.name_en = 'Diferencias: I. Como una fanfarria. Sonoro -',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17909 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:c2acca49-9a9e-4a1d-a03a-84c86bbc8082' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2acca49-9a9e-4a1d-a03a-84c86bbc8082', 1, 'I', 'Como una fanfarria. Sonoro -', 'Diferencias: I. Como una fanfarria. Sonoro -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17909 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2acca49-9a9e-4a1d-a03a-84c86bbc8082'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ritmico', part.name_en = 'Diferencias: II. Ritmico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17909 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:411618b2-f747-4a4a-8edf-30ad5b7ee6b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:411618b2-f747-4a4a-8edf-30ad5b7ee6b7', 2, 'II', 'Ritmico', 'Diferencias: II. Ritmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17909 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:411618b2-f747-4a4a-8edf-30ad5b7ee6b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sonoro -', part.name_en = 'Diferencias: III. Sonoro -',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17909 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:f9f8f8be-747f-42fd-bdbb-a6f40a642009' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9f8f8be-747f-42fd-bdbb-a6f40a642009', 3, 'III', 'Sonoro -', 'Diferencias: III. Sonoro -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17909 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9f8f8be-747f-42fd-bdbb-a6f40a642009'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vigoroso', part.name_en = 'Diferencias: IV. Vigoroso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17909 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:342340db-10a4-4503-afdc-102df3b52306' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:342340db-10a4-4503-afdc-102df3b52306', 4, 'IV', 'Vigoroso', 'Diferencias: IV. Vigoroso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17909 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:342340db-10a4-4503-afdc-102df3b52306'
);


-- None Dos Piezas para Orquesta

UPDATE pieces piece
SET piece.title = 'Dos Piezas para Orquesta', piece.title_en = 'Dos Piezas para Orquesta',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16967 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Como un lament', part.name_en = 'Dos Piezas para Orquesta: No. 1. Como un lament',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16967 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:326ed152-f495-418c-8bb4-f7d3f6408edb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:326ed152-f495-418c-8bb4-f7d3f6408edb', 1, NULL, 'Como un lament', 'Dos Piezas para Orquesta: No. 1. Como un lament', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16967 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:326ed152-f495-418c-8bb4-f7d3f6408edb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Animado', part.name_en = 'Dos Piezas para Orquesta: No. 2. Animado',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16967 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:0c46fdc6-9141-4957-ad7b-577493c102dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c46fdc6-9141-4957-ad7b-577493c102dc', 2, NULL, 'Animado', 'Dos Piezas para Orquesta: No. 2. Animado', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16967 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c46fdc6-9141-4957-ad7b-577493c102dc'
);


-- None Fandangos

UPDATE pieces piece
SET piece.title = 'Fandangos', piece.title_en = 'Fandangos',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17479 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Folias

UPDATE pieces piece
SET piece.title = 'Folias', piece.title_en = 'Folias',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17842 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Kandinsky

UPDATE pieces piece
SET piece.title = 'Kandinsky', piece.title_en = 'Kandinsky',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16482 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lyrisches', part.name_en = 'Kandinsky: I. Lyrisches',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16482 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:24cea820-1388-4a19-9af5-0c6706ebdab0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24cea820-1388-4a19-9af5-0c6706ebdab0', 1, 'I', 'Lyrisches', 'Kandinsky: I. Lyrisches', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16482 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24cea820-1388-4a19-9af5-0c6706ebdab0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Improvisation 19', part.name_en = 'Kandinsky: II. Improvisation 19',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16482 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:ce48a8a8-c227-4c72-bd84-c7b3c2c6f3b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce48a8a8-c227-4c72-bd84-c7b3c2c6f3b1', 2, 'II', 'Improvisation 19', 'Kandinsky: II. Improvisation 19', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16482 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce48a8a8-c227-4c72-bd84-c7b3c2c6f3b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Bild mit schwarzem Bogen', part.name_en = 'Kandinsky: III. Bild mit schwarzem Bogen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16482 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:ee515a04-004b-41d8-83d3-265964064353' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee515a04-004b-41d8-83d3-265964064353', 3, 'III', 'Bild mit schwarzem Bogen', 'Kandinsky: III. Bild mit schwarzem Bogen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16482 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee515a04-004b-41d8-83d3-265964064353'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Improvisation 26', part.name_en = 'Kandinsky: IV. Improvisation 26',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16482 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:bfcac5cb-c222-41c2-85cc-8ea7d094b91d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfcac5cb-c222-41c2-85cc-8ea7d094b91d', 4, 'IV', 'Improvisation 26', 'Kandinsky: IV. Improvisation 26', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16482 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfcac5cb-c222-41c2-85cc-8ea7d094b91d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Kleine Freuden', part.name_en = 'Kandinsky: V. Kleine Freuden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16482 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:6fd3c454-07cb-4972-8ac7-b4a135dabf62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fd3c454-07cb-4972-8ac7-b4a135dabf62', 5, 'V', 'Kleine Freuden', 'Kandinsky: V. Kleine Freuden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16482 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fd3c454-07cb-4972-8ac7-b4a135dabf62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Schwarze Striche I', part.name_en = 'Kandinsky: VI. Schwarze Striche I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16482 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:bf4f8df0-e590-48ad-85ae-32efff70800f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf4f8df0-e590-48ad-85ae-32efff70800f', 6, 'VI', 'Schwarze Striche I', 'Kandinsky: VI. Schwarze Striche I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16482 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf4f8df0-e590-48ad-85ae-32efff70800f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Weisser Strich', part.name_en = 'Kandinsky: VII. Weisser Strich',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16482 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:43027d8d-4d6e-443d-ab2f-140ff33bb1dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43027d8d-4d6e-443d-ab2f-140ff33bb1dc', 7, 'VII', 'Weisser Strich', 'Kandinsky: VII. Weisser Strich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16482 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43027d8d-4d6e-443d-ab2f-140ff33bb1dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Kleine Welten III', part.name_en = 'Kandinsky: VIII. Kleine Welten III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16482 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:1c733625-28ea-4741-91fb-b8e7d3983595' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c733625-28ea-4741-91fb-b8e7d3983595', 8, 'VIII', 'Kleine Welten III', 'Kandinsky: VIII. Kleine Welten III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16482 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c733625-28ea-4741-91fb-b8e7d3983595'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Komposition VIII', part.name_en = 'Kandinsky: IX. Komposition VIII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16482 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:123fb2e4-4973-4e9b-a777-db4a1e6a438a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:123fb2e4-4973-4e9b-a777-db4a1e6a438a', 9, 'IX', 'Komposition VIII', 'Kandinsky: IX. Komposition VIII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16482 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:123fb2e4-4973-4e9b-a777-db4a1e6a438a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Launisches', part.name_en = 'Kandinsky: X. Launisches',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16482 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:d1726e71-3644-4681-ab40-54ae29c58b67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1726e71-3644-4681-ab40-54ae29c58b67', 10, 'X', 'Launisches', 'Kandinsky: X. Launisches', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16482 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1726e71-3644-4681-ab40-54ae29c58b67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Buntes Ensemble', part.name_en = 'Kandinsky: XI. Buntes Ensemble',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16482 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:cd47e450-c78e-4a42-a2e5-78692c5371cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd47e450-c78e-4a42-a2e5-78692c5371cf', 11, 'XI', 'Buntes Ensemble', 'Kandinsky: XI. Buntes Ensemble', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16482 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd47e450-c78e-4a42-a2e5-78692c5371cf'
);


-- None Loíza

UPDATE pieces piece
SET piece.title = 'Loíza', piece.title_en = 'Loíza',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19437 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pequeño concierto

UPDATE pieces piece
SET piece.title = 'Pequeño concierto', piece.title_en = 'Pequeño concierto',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17424 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Rítmico', part.name_en = 'Pequeño concierto: I. Rítmico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17424 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:c8b6077d-aa58-44d3-b391-7e01f7b7cd22' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8b6077d-aa58-44d3-b391-7e01f7b7cd22', 1, 'I', 'Rítmico', 'Pequeño concierto: I. Rítmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17424 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8b6077d-aa58-44d3-b391-7e01f7b7cd22'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Delicado y transparente', part.name_en = 'Pequeño concierto: II. Delicado y transparente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17424 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:2a9bf4c8-cf7e-46ab-bf0c-0366e32b45c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a9bf4c8-cf7e-46ab-bf0c-0366e32b45c6', 2, 'II', 'Delicado y transparente', 'Pequeño concierto: II. Delicado y transparente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17424 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a9bf4c8-cf7e-46ab-bf0c-0366e32b45c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Intenso', part.name_en = 'Pequeño concierto: III. Intenso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17424 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:86489a43-a9f1-4d22-b9b3-f3cd48cee3ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86489a43-a9f1-4d22-b9b3-f3cd48cee3ee', 3, 'III', 'Intenso', 'Pequeño concierto: III. Intenso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17424 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86489a43-a9f1-4d22-b9b3-f3cd48cee3ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Preciso', part.name_en = 'Pequeño concierto: IV. Preciso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17424 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:d5b5a1b0-d1e7-4853-a8b1-7a67ff132666' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5b5a1b0-d1e7-4853-a8b1-7a67ff132666', 4, 'IV', 'Preciso', 'Pequeño concierto: IV. Preciso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17424 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5b5a1b0-d1e7-4853-a8b1-7a67ff132666'
);


-- None Prelude, Habanera & Perpetual Motion

UPDATE pieces piece
SET piece.title = 'Prelude, Habanera & Perpetual Motion', piece.title_en = 'Prelude, Habanera & Perpetual Motion',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20070 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prelude', part.name_en = 'Prelude, Habanera & Perpetual Motion: I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20070 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:73eae3bf-ad7d-4623-92b5-3edc846fca31' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73eae3bf-ad7d-4623-92b5-3edc846fca31', 1, 'I', 'Prelude', 'Prelude, Habanera & Perpetual Motion: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20070 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73eae3bf-ad7d-4623-92b5-3edc846fca31'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Habanera', part.name_en = 'Prelude, Habanera & Perpetual Motion: II. Habanera',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20070 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:6ae3ad3e-2960-4e0e-b63d-8ca13d30b333' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ae3ad3e-2960-4e0e-b63d-8ca13d30b333', 2, 'II', 'Habanera', 'Prelude, Habanera & Perpetual Motion: II. Habanera', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20070 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ae3ad3e-2960-4e0e-b63d-8ca13d30b333'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Perpetual Motion', part.name_en = 'Prelude, Habanera & Perpetual Motion: III. Perpetual Motion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20070 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:a9d1e3ec-ccfe-4da3-9084-0764fbbb999b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9d1e3ec-ccfe-4da3-9084-0764fbbb999b', 3, 'III', 'Perpetual Motion', 'Prelude, Habanera & Perpetual Motion: III. Perpetual Motion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20070 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9d1e3ec-ccfe-4da3-9084-0764fbbb999b'
);


-- None Primera crónica del descubrimiento

UPDATE pieces piece
SET piece.title = 'Primera crónica del descubrimiento', piece.title_en = 'Primera crónica del descubrimiento',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17497 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Leyenda taína', part.name_en = 'Primera crónica del descubrimiento: I. Leyenda taína',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17497 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:4c421420-bda3-44ad-87a0-4666f6dc6469' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c421420-bda3-44ad-87a0-4666f6dc6469', 1, 'I', 'Leyenda taína', 'Primera crónica del descubrimiento: I. Leyenda taína', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17497 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c421420-bda3-44ad-87a0-4666f6dc6469'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Danza', part.name_en = 'Primera crónica del descubrimiento: II. Danza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17497 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:b4479676-7ae6-48a2-85dc-bdb4bc828495' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4479676-7ae6-48a2-85dc-bdb4bc828495', 2, 'II', 'Danza', 'Primera crónica del descubrimiento: II. Danza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17497 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4479676-7ae6-48a2-85dc-bdb4bc828495'
);


-- None Segunda crónica del descubrimiento

UPDATE pieces piece
SET piece.title = 'Segunda crónica del descubrimiento', piece.title_en = 'Segunda crónica del descubrimiento',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19983 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Noche', part.name_en = 'Segunda crónica del descubrimiento: I. Noche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19983 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:1d750f6e-ccfb-4c92-9f70-35540c520f42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d750f6e-ccfb-4c92-9f70-35540c520f42', 1, 'I', 'Noche', 'Segunda crónica del descubrimiento: I. Noche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19983 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d750f6e-ccfb-4c92-9f70-35540c520f42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'En busca del oro', part.name_en = 'Segunda crónica del descubrimiento: II. En busca del oro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19983 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:375594a3-b9e0-4b04-a873-e53a29985fcf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:375594a3-b9e0-4b04-a873-e53a29985fcf', 2, 'II', 'En busca del oro', 'Segunda crónica del descubrimiento: II. En busca del oro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19983 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:375594a3-b9e0-4b04-a873-e53a29985fcf'
);


-- None Sinfonietta for String Orchestra

UPDATE pieces piece
SET piece.title = 'Sinfonietta for String Orchestra', piece.title_en = 'Sinfonietta for String Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17168 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Rítmico', part.name_en = 'Sinfonietta for String Orchestra: I. Rítmico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17168 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:cea444c9-ebd7-48bf-b3c1-ef9fca60ad50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cea444c9-ebd7-48bf-b3c1-ef9fca60ad50', 1, 'I', 'Rítmico', 'Sinfonietta for String Orchestra: I. Rítmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17168 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cea444c9-ebd7-48bf-b3c1-ef9fca60ad50'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Expresivo', part.name_en = 'Sinfonietta for String Orchestra: II. Expresivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17168 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:76931fdd-d87c-4f51-8f28-c1950136655b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76931fdd-d87c-4f51-8f28-c1950136655b', 2, 'II', 'Expresivo', 'Sinfonietta for String Orchestra: II. Expresivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17168 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76931fdd-d87c-4f51-8f28-c1950136655b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivo', part.name_en = 'Sinfonietta for String Ochestra: III. Vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17168 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:7f5c8796-470a-4977-9096-977442db909e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f5c8796-470a-4977-9096-977442db909e', 3, 'III', 'Vivo', 'Sinfonietta for String Ochestra: III. Vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17168 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f5c8796-470a-4977-9096-977442db909e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Rápido', part.name_en = 'Sinfonietta for String Orchestra: IV. Rápido',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17168 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:082845ef-4479-416c-a75d-52d7bf3ac225' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:082845ef-4479-416c-a75d-52d7bf3ac225', 4, 'IV', 'Rápido', 'Sinfonietta for String Orchestra: IV. Rápido', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17168 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:082845ef-4479-416c-a75d-52d7bf3ac225'
);


-- None Sinfonía n.º 4

UPDATE pieces piece
SET piece.title = 'Sinfonía n.º 4', piece.title_en = 'Sinfonía n.º 4',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18192 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderadamente rápido', part.name_en = 'Sinfonía n.º 4: I. Moderadamente rápido',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18192 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:b75356ac-5481-4c97-aa82-c19efa0a15bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b75356ac-5481-4c97-aa82-c19efa0a15bf', 1, 'I', 'Moderadamente rápido', 'Sinfonía n.º 4: I. Moderadamente rápido', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18192 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b75356ac-5481-4c97-aa82-c19efa0a15bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Rápido', part.name_en = 'Sinfonía n.º 4: II. Rápido',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18192 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:cd59422b-64c8-4154-a5c7-fb75a73aa485' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd59422b-64c8-4154-a5c7-fb75a73aa485', 2, 'II', 'Rápido', 'Sinfonía n.º 4: II. Rápido', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18192 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd59422b-64c8-4154-a5c7-fb75a73aa485'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tiempo de bolero', part.name_en = 'Sinfonía n.º 4: III. Tiempo de bolero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18192 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:3fb03941-bfa1-40e3-b129-8dd5b9ed4db8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fb03941-bfa1-40e3-b129-8dd5b9ed4db8', 3, 'III', 'Tiempo de bolero', 'Sinfonía n.º 4: III. Tiempo de bolero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18192 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fb03941-bfa1-40e3-b129-8dd5b9ed4db8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Muy rápido y rítmico', part.name_en = 'Sinfonía n.º 4: IV. Muy rápido y rítmico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18192 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:fe064761-1aa5-47f4-ba7f-17c89a1c552f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe064761-1aa5-47f4-ba7f-17c89a1c552f', 4, 'IV', 'Muy rápido y rítmico', 'Sinfonía n.º 4: IV. Muy rápido y rítmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18192 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe064761-1aa5-47f4-ba7f-17c89a1c552f'
);


-- None Sinfonía no. 6

UPDATE pieces piece
SET piece.title = 'Sinfonía no. 6', piece.title_en = 'Sinfonía no. 6',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19023 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Memoria Urbana', part.name_en = 'Sinfonía no. 6: I. Memoria Urbana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19023 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:c1de421b-fc94-4836-849a-908c4f99b402' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1de421b-fc94-4836-849a-908c4f99b402', 1, 'I', 'Memoria Urbana', 'Sinfonía no. 6: I. Memoria Urbana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19023 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1de421b-fc94-4836-849a-908c4f99b402'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'De noche', part.name_en = 'Sinfonía no. 6: II. De noche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19023 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:bb6cdb11-7ce5-4fa9-b670-701236f90f39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb6cdb11-7ce5-4fa9-b670-701236f90f39', 2, 'II', 'De noche', 'Sinfonía no. 6: II. De noche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19023 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb6cdb11-7ce5-4fa9-b670-701236f90f39'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Huracán', part.name_en = 'Sinfonía no. 6: III. Huracán',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19023 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:86df81cd-4f69-450b-a831-4bfe1f17f49f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86df81cd-4f69-450b-a831-4bfe1f17f49f', 3, 'III', 'Huracán', 'Sinfonía no. 6: III. Huracán', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19023 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86df81cd-4f69-450b-a831-4bfe1f17f49f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Final', part.name_en = 'Sinfonía no. 6: IV. Final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19023 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:46699044-ed71-47d0-ac90-d54687a0c37a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46699044-ed71-47d0-ac90-d54687a0c37a', 4, 'IV', 'Final', 'Sinfonía no. 6: IV. Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19023 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46699044-ed71-47d0-ac90-d54687a0c37a'
);


-- None Tercera crónica del descubrimiento

UPDATE pieces piece
SET piece.title = 'Tercera crónica del descubrimiento', piece.title_en = 'Tercera crónica del descubrimiento',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16737 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Canción', part.name_en = 'Tercera crónica del descubrimiento: I. Canción',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16737 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:12e4b88e-d3a7-45a1-8d62-a71dad83eadd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12e4b88e-d3a7-45a1-8d62-a71dad83eadd', 1, 'I', 'Canción', 'Tercera crónica del descubrimiento: I. Canción', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16737 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12e4b88e-d3a7-45a1-8d62-a71dad83eadd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Batalla', part.name_en = 'Tercera crónica del descubrimiento: II. Batalla',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16737 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:94069a37-d4a0-40d3-ab81-9ea46f5491ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94069a37-d4a0-40d3-ab81-9ea46f5491ed', 2, 'II', 'Batalla', 'Tercera crónica del descubrimiento: II. Batalla', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16737 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94069a37-d4a0-40d3-ab81-9ea46f5491ed'
);


-- None Treinta y tres formas de mirar un mismo objeto

UPDATE pieces piece
SET piece.title = 'Treinta y tres formas de mirar un mismo objeto', piece.title_en = 'Treinta y tres formas de mirar un mismo objeto',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18508 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:440d8968-ad0a-4fa3-9fab-fd75b2c8f8f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:440d8968-ad0a-4fa3-9fab-fd75b2c8f8f3', 1, NULL, 'No. 1', 'Treinta y tres formas de mirar un mismo objeto: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:440d8968-ad0a-4fa3-9fab-fd75b2c8f8f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:5a518e0c-1a87-490a-88ff-82ab5adce894' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a518e0c-1a87-490a-88ff-82ab5adce894', 2, NULL, 'No. 2', 'Treinta y tres formas de mirar un mismo objeto: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a518e0c-1a87-490a-88ff-82ab5adce894'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:95c10f6a-02f8-4382-bf10-c21059fac670' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95c10f6a-02f8-4382-bf10-c21059fac670', 3, NULL, 'No. 3', 'Treinta y tres formas de mirar un mismo objeto: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95c10f6a-02f8-4382-bf10-c21059fac670'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'No. 4', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:80370c09-1761-495a-a60e-16fb783c4a90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80370c09-1761-495a-a60e-16fb783c4a90', 4, NULL, 'No. 4', 'Treinta y tres formas de mirar un mismo objeto: No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80370c09-1761-495a-a60e-16fb783c4a90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'No. 5', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:946f2146-245d-43fc-9525-324b522fed16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:946f2146-245d-43fc-9525-324b522fed16', 5, NULL, 'No. 5', 'Treinta y tres formas de mirar un mismo objeto: No. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:946f2146-245d-43fc-9525-324b522fed16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'No. 6', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:aab8b425-f587-4341-8efc-aa14514600bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aab8b425-f587-4341-8efc-aa14514600bc', 6, NULL, 'No. 6', 'Treinta y tres formas de mirar un mismo objeto: No. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aab8b425-f587-4341-8efc-aa14514600bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'No. 7', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:9db6315d-0db5-4e05-8ef1-971af9f03bf6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9db6315d-0db5-4e05-8ef1-971af9f03bf6', 7, NULL, 'No. 7', 'Treinta y tres formas de mirar un mismo objeto: No. 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9db6315d-0db5-4e05-8ef1-971af9f03bf6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'No. 8', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:dbc3726a-c7fb-4030-8f3f-f0001b360058' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbc3726a-c7fb-4030-8f3f-f0001b360058', 8, NULL, 'No. 8', 'Treinta y tres formas de mirar un mismo objeto: No. 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbc3726a-c7fb-4030-8f3f-f0001b360058'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'No. 9', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 9',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:b2c6c5b3-0985-425a-95a7-24267b1b5344' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2c6c5b3-0985-425a-95a7-24267b1b5344', 9, NULL, 'No. 9', 'Treinta y tres formas de mirar un mismo objeto: No. 9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2c6c5b3-0985-425a-95a7-24267b1b5344'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'No. 10', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 10',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:b4131851-8ee1-49ce-8f1d-1d40cf0567ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4131851-8ee1-49ce-8f1d-1d40cf0567ce', 10, NULL, 'No. 10', 'Treinta y tres formas de mirar un mismo objeto: No. 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4131851-8ee1-49ce-8f1d-1d40cf0567ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'No. 11', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 11',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:a10b0e93-d1ca-438c-8832-5eb632b211c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a10b0e93-d1ca-438c-8832-5eb632b211c9', 11, NULL, 'No. 11', 'Treinta y tres formas de mirar un mismo objeto: No. 11', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a10b0e93-d1ca-438c-8832-5eb632b211c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'No. 12', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 12',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:89fe229b-0b38-4a6d-aa36-c17a77078939' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89fe229b-0b38-4a6d-aa36-c17a77078939', 12, NULL, 'No. 12', 'Treinta y tres formas de mirar un mismo objeto: No. 12', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89fe229b-0b38-4a6d-aa36-c17a77078939'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'No. 13', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 13',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:139abb79-3f53-46ea-8d4a-a3f90d15c7c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:139abb79-3f53-46ea-8d4a-a3f90d15c7c8', 13, NULL, 'No. 13', 'Treinta y tres formas de mirar un mismo objeto: No. 13', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:139abb79-3f53-46ea-8d4a-a3f90d15c7c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'No. 14', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 14',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:5d014381-d5fe-4d4c-9be9-2a4c7d491dd4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d014381-d5fe-4d4c-9be9-2a4c7d491dd4', 14, NULL, 'No. 14', 'Treinta y tres formas de mirar un mismo objeto: No. 14', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d014381-d5fe-4d4c-9be9-2a4c7d491dd4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'No. 15', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 15',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:2017f379-3480-46f7-9577-7e599101f107' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2017f379-3480-46f7-9577-7e599101f107', 15, NULL, 'No. 15', 'Treinta y tres formas de mirar un mismo objeto: No. 15', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2017f379-3480-46f7-9577-7e599101f107'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'No. 16', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 16',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:0ee052da-56f8-4a3b-84a3-f294fd1a7aa0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ee052da-56f8-4a3b-84a3-f294fd1a7aa0', 16, NULL, 'No. 16', 'Treinta y tres formas de mirar un mismo objeto: No. 16', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ee052da-56f8-4a3b-84a3-f294fd1a7aa0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'No. 17', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 17',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:4e7e7e05-5bcd-41bc-a42c-5ffc2c21a7c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e7e7e05-5bcd-41bc-a42c-5ffc2c21a7c7', 17, NULL, 'No. 17', 'Treinta y tres formas de mirar un mismo objeto: No. 17', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e7e7e05-5bcd-41bc-a42c-5ffc2c21a7c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'No. 18', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 18',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:ee980af9-0ee0-4152-9a58-409b88c12779' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee980af9-0ee0-4152-9a58-409b88c12779', 18, NULL, 'No. 18', 'Treinta y tres formas de mirar un mismo objeto: No. 18', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee980af9-0ee0-4152-9a58-409b88c12779'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'No. 19', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 19',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:54dcc350-4e57-4bce-88df-9ba9fea511e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54dcc350-4e57-4bce-88df-9ba9fea511e9', 19, NULL, 'No. 19', 'Treinta y tres formas de mirar un mismo objeto: No. 19', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54dcc350-4e57-4bce-88df-9ba9fea511e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'No. 20', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 20',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:6ed15deb-7a2e-44c7-bea0-d36d11ca3ab5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ed15deb-7a2e-44c7-bea0-d36d11ca3ab5', 20, NULL, 'No. 20', 'Treinta y tres formas de mirar un mismo objeto: No. 20', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ed15deb-7a2e-44c7-bea0-d36d11ca3ab5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'No. 21', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 21',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:d09bbc5c-1076-4cdd-b30b-33991bf6bc92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d09bbc5c-1076-4cdd-b30b-33991bf6bc92', 21, NULL, 'No. 21', 'Treinta y tres formas de mirar un mismo objeto: No. 21', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d09bbc5c-1076-4cdd-b30b-33991bf6bc92'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'No. 22', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 22',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:4115c885-7acd-4cab-abac-3b38abecc7fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4115c885-7acd-4cab-abac-3b38abecc7fd', 22, NULL, 'No. 22', 'Treinta y tres formas de mirar un mismo objeto: No. 22', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4115c885-7acd-4cab-abac-3b38abecc7fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'No. 23', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 23',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:73cc3a3c-e890-48a7-9ad0-aa4c61a3c021' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73cc3a3c-e890-48a7-9ad0-aa4c61a3c021', 23, NULL, 'No. 23', 'Treinta y tres formas de mirar un mismo objeto: No. 23', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73cc3a3c-e890-48a7-9ad0-aa4c61a3c021'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'No. 24', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 24',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:f8dfd799-0657-49aa-abb7-698344700f51' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8dfd799-0657-49aa-abb7-698344700f51', 24, NULL, 'No. 24', 'Treinta y tres formas de mirar un mismo objeto: No. 24', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8dfd799-0657-49aa-abb7-698344700f51'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'No. 25', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 25',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:90b8cd0c-f1e5-438f-bf9b-4ff9b707874c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90b8cd0c-f1e5-438f-bf9b-4ff9b707874c', 25, NULL, 'No. 25', 'Treinta y tres formas de mirar un mismo objeto: No. 25', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90b8cd0c-f1e5-438f-bf9b-4ff9b707874c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'No. 26', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 26',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:3c8359ad-6199-4ca1-8aed-e64038dc6aa1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c8359ad-6199-4ca1-8aed-e64038dc6aa1', 26, NULL, 'No. 26', 'Treinta y tres formas de mirar un mismo objeto: No. 26', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c8359ad-6199-4ca1-8aed-e64038dc6aa1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'No. 27', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 27',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:067eaf8b-960b-4da6-9164-6dfd7b43d06a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:067eaf8b-960b-4da6-9164-6dfd7b43d06a', 27, NULL, 'No. 27', 'Treinta y tres formas de mirar un mismo objeto: No. 27', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:067eaf8b-960b-4da6-9164-6dfd7b43d06a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'No. 28', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 28',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:30b028d0-0b43-48e5-956f-9f4873ef6b6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30b028d0-0b43-48e5-956f-9f4873ef6b6d', 28, NULL, 'No. 28', 'Treinta y tres formas de mirar un mismo objeto: No. 28', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30b028d0-0b43-48e5-956f-9f4873ef6b6d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'No. 29', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 29',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:6ae667c9-b82a-4dfc-a194-682badb095d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ae667c9-b82a-4dfc-a194-682badb095d9', 29, NULL, 'No. 29', 'Treinta y tres formas de mirar un mismo objeto: No. 29', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ae667c9-b82a-4dfc-a194-682badb095d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'No. 30', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 30',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:9b3266f3-8983-4dc6-bd00-e8401fcb760b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b3266f3-8983-4dc6-bd00-e8401fcb760b', 30, NULL, 'No. 30', 'Treinta y tres formas de mirar un mismo objeto: No. 30', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b3266f3-8983-4dc6-bd00-e8401fcb760b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'No. 31', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 31',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:69d30d22-a1c3-4e6e-ac26-a93422f3ca95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69d30d22-a1c3-4e6e-ac26-a93422f3ca95', 31, NULL, 'No. 31', 'Treinta y tres formas de mirar un mismo objeto: No. 31', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69d30d22-a1c3-4e6e-ac26-a93422f3ca95'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = 'No. 32', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 32',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:84b77850-97e8-4e61-a6f6-d30e6de34891' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84b77850-97e8-4e61-a6f6-d30e6de34891', 32, NULL, 'No. 32', 'Treinta y tres formas de mirar un mismo objeto: No. 32', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84b77850-97e8-4e61-a6f6-d30e6de34891'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 33, part.movement_number = NULL,
    part.name_ko = 'No. 33', part.name_en = 'Treinta y tres formas de mirar un mismo objeto: No. 33',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18508 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:7f7a5b89-69de-4c2d-b86c-66564c2b4747' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f7a5b89-69de-4c2d-b86c-66564c2b4747', 33, NULL, 'No. 33', 'Treinta y tres formas de mirar un mismo objeto: No. 33', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18508 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f7a5b89-69de-4c2d-b86c-66564c2b4747'
);


-- None Triple Concierto for Violin, Cello & Piano

UPDATE pieces piece
SET piece.title = 'Triple Concierto for Violin, Cello & Piano', piece.title_en = 'Triple Concierto for Violin, Cello & Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16578 AND piece.composer_id = 267
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Enérgico', part.name_en = 'Triple Concierto for Violin, Cello & Piano: I. Enérgico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16578 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:9bf2ebe3-6547-46e7-ad3b-7d40f606a8b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bf2ebe3-6547-46e7-ad3b-7d40f606a8b3', 1, 'I', 'Enérgico', 'Triple Concierto for Violin, Cello & Piano: I. Enérgico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16578 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bf2ebe3-6547-46e7-ad3b-7d40f606a8b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Tiempo de bolero', part.name_en = 'Triple Concierto for Violin, Cello & Piano: II. Tiempo de bolero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16578 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:aff838f9-4d03-49ed-ba64-d1b7c5aaf5d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aff838f9-4d03-49ed-ba64-d1b7c5aaf5d2', 2, 'II', 'Tiempo de bolero', 'Triple Concierto for Violin, Cello & Piano: II. Tiempo de bolero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16578 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aff838f9-4d03-49ed-ba64-d1b7c5aaf5d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Veloz, con aire de merengue', part.name_en = 'Triple Concierto for Violin, Cello & Piano: III. Veloz, con aire de merengue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16578 AND p.composer_id = 267 AND part.part_key = 'musicbrainz:ffd26b7e-a32b-47a1-b40c-1460e9ae3cb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffd26b7e-a32b-47a1-b40c-1460e9ae3cb4', 3, 'III', 'Veloz, con aire de merengue', 'Triple Concierto for Violin, Cello & Piano: III. Veloz, con aire de merengue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16578 AND p.composer_id = 267
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffd26b7e-a32b-47a1-b40c-1460e9ae3cb4'
);


-- None Alegría

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Alegría', 'Alegría', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 267
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Alegría'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd86b6b1f-be56-4dad-9482-d0054222f746'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd86b6b1f-be56-4dad-9482-d0054222f746'
FROM pieces p
WHERE p.composer_id = 267 AND p.title = 'Alegría' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd86b6b1f-be56-4dad-9482-d0054222f746'
);


-- None Carnaval

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carnaval', 'Carnaval', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 267
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carnaval'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2aec4d21-35d8-4c75-992f-429e4a5706dc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2aec4d21-35d8-4c75-992f-429e4a5706dc'
FROM pieces p
WHERE p.composer_id = 267 AND p.title = 'Carnaval' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2aec4d21-35d8-4c75-992f-429e4a5706dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64e221a9-3cf3-46e6-a44d-b2d40eaf62fe', 1, 'I', 'Gargoyles', 'Carnaval: I. Gargoyles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 267 AND p.title = 'Carnaval' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64e221a9-3cf3-46e6-a44d-b2d40eaf62fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78902958-fd41-4e95-bfca-3d25694afa8b', 2, 'II', 'Sphinxes', 'Carnaval: II. Sphinxes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 267 AND p.title = 'Carnaval' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78902958-fd41-4e95-bfca-3d25694afa8b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21684048-f312-46ae-8d5c-f1fc10729a58', 3, 'III', 'Unicorns', 'Carnaval: III. Unicorns', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 267 AND p.title = 'Carnaval' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21684048-f312-46ae-8d5c-f1fc10729a58'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b632761-71b9-4c94-ad75-0008d2f4dc83', 4, 'IV', 'Dragons', 'Carnaval: IV. Dragons', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 267 AND p.title = 'Carnaval' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b632761-71b9-4c94-ad75-0008d2f4dc83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e02cd63e-3791-41f4-bf2c-5289c8a6de43', 5, 'V', 'The Phoenix', 'Carnaval: V. The Phoenix', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 267 AND p.title = 'Carnaval' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e02cd63e-3791-41f4-bf2c-5289c8a6de43'
);


-- None 클라리넷 소나타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라리넷 소나타', 'Clarinet Sonata', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 267
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라리넷 소나타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '70169a6e-1966-4ff7-8643-aaa54ac34b50'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '70169a6e-1966-4ff7-8643-aaa54ac34b50'
FROM pieces p
WHERE p.composer_id = 267 AND p.title = '클라리넷 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '70169a6e-1966-4ff7-8643-aaa54ac34b50'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51df3ba1-c8fc-479b-bc51-0136fa7a6129', 1, 'I', 'Salseado', 'Clarinet Sonata: I. Salseado', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 267 AND p.title = '클라리넷 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51df3ba1-c8fc-479b-bc51-0136fa7a6129'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40ba3040-21b2-4251-9917-c66a162cee79', 2, 'II', 'Delicado y expresivo', 'Clarinet Sonata: II. Delicado y expresivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 267 AND p.title = '클라리넷 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40ba3040-21b2-4251-9917-c66a162cee79'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3fc3391-9853-4b12-8224-6719bc35cb44', 3, 'III', 'Enérgico', 'Clarinet Sonata: III. Enérgico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 267 AND p.title = '클라리넷 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3fc3391-9853-4b12-8224-6719bc35cb44'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33ef8f30-0a89-4bde-a72c-0c0410859e48', 4, 'IV', 'Veloz (with swing)', 'Clarinet Sonata: IV. Veloz (with swing)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 267 AND p.title = '클라리넷 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33ef8f30-0a89-4bde-a72c-0c0410859e48'
);


-- None Tríptico

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Tríptico', 'Tríptico', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 267
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Tríptico'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd4fbaee2-aab5-4543-8d42-f9e9fa529e07'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd4fbaee2-aab5-4543-8d42-f9e9fa529e07'
FROM pieces p
WHERE p.composer_id = 267 AND p.title = 'Tríptico' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd4fbaee2-aab5-4543-8d42-f9e9fa529e07'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46f405cd-f27a-436b-9ee0-2d54e568fd0c', 1, 'I', 'Tranquillo', 'Tríptico: I. Tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 267 AND p.title = 'Tríptico' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46f405cd-f27a-436b-9ee0-2d54e568fd0c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23c790e3-43bc-4d63-94dd-4c577d557b7d', 2, 'II', 'Rítmico', 'Tríptico: II. Rítmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 267 AND p.title = 'Tríptico' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23c790e3-43bc-4d63-94dd-4c577d557b7d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7739afe5-a662-4d00-9d95-7a9fda915411', 3, 'III', 'Fluido', 'Tríptico: III. Fluido', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 267 AND p.title = 'Tríptico' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7739afe5-a662-4d00-9d95-7a9fda915411'
);


-- 숨길 seed 작품 없음
