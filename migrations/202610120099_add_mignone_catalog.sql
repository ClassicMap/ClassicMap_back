-- Francisco Mignone 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 68개(묶음 2, 다악장 15, 낱곡 51),
-- 새 작품 9개, part 56개, 그 아래 0개.
-- seed 60개 중 59개를 작품·part 에 잇고, 0개를 숨기고, 1개는 그대로 둔다.
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

-- None 2 Essays

UPDATE pieces piece
SET piece.title = '2 Essays', piece.title_en = '2 Essays',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23861 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante cantabile', part.name_en = '2 Essays: I. Andante cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23861 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:fbc37ed3-b52f-402f-83b6-f038a23e4f8c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbc37ed3-b52f-402f-83b6-f038a23e4f8c', 1, 'I', 'Andante cantabile', '2 Essays: I. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23861 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbc37ed3-b52f-402f-83b6-f038a23e4f8c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Moderato', part.name_en = '2 Essays: II. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23861 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:eeaa44f8-7829-4c47-9445-ea2259983eb8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eeaa44f8-7829-4c47-9445-ea2259983eb8', 2, 'II', 'Moderato', '2 Essays: II. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23861 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eeaa44f8-7829-4c47-9445-ea2259983eb8'
);


-- None 3 Spanish Songs

UPDATE pieces piece
SET piece.title = '3 Spanish Songs', piece.title_en = '3 Spanish Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24555 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'III',
    part.name_ko = 'Las mujeres son las moscas', part.name_en = '3 Spanish Songs: III. Las mujeres son las moscas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24555 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:7ee4ed07-ef7e-4d7a-8406-99b17706559b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ee4ed07-ef7e-4d7a-8406-99b17706559b', 1, 'III', 'Las mujeres son las moscas', '3 Spanish Songs: III. Las mujeres son las moscas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24555 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ee4ed07-ef7e-4d7a-8406-99b17706559b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'I',
    part.name_ko = 'Nana', part.name_en = '3 Spanish Songs: I. Nana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24555 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:a87a5ef8-d00a-44d0-b7a9-20e7980ef756' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a87a5ef8-d00a-44d0-b7a9-20e7980ef756', 2, 'I', 'Nana', '3 Spanish Songs: I. Nana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24555 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a87a5ef8-d00a-44d0-b7a9-20e7980ef756'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'II',
    part.name_ko = 'Por qué lloras morenita', part.name_en = '3 Spanish Songs: II. Por qué lloras morenita',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24555 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:bb754531-350f-483b-bea0-b9ad2d208ce8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb754531-350f-483b-bea0-b9ad2d208ce8', 3, 'II', 'Por qué lloras morenita', '3 Spanish Songs: II. Por qué lloras morenita', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24555 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb754531-350f-483b-bea0-b9ad2d208ce8'
);


-- None Brazilian Song

UPDATE pieces piece
SET piece.title = 'Brazilian Song', piece.title_en = 'Brazilian Song',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23318 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Burlesca e Toccata

UPDATE pieces piece
SET piece.title = 'Burlesca e Toccata', piece.title_en = 'Burlesca e Toccata',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24151 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Caixinha de Brinquedos

UPDATE pieces piece
SET piece.title = 'Caixinha de Brinquedos', piece.title_en = 'Caixinha de Brinquedos',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23919 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dorme bonequinha', part.name_en = 'Caixinha de Brinquedos: 1. Dorme bonequinha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23919 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:dddbcef0-23f3-476e-ac5a-66da7e2c8074' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dddbcef0-23f3-476e-ac5a-66da7e2c8074', 1, NULL, 'Dorme bonequinha', 'Caixinha de Brinquedos: 1. Dorme bonequinha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23919 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dddbcef0-23f3-476e-ac5a-66da7e2c8074'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Brinquedinho japonez', part.name_en = 'Caixinha de Brinquedos: 2. Brinquedinho japonez',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23919 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:22951b71-eac0-4e3b-8b4d-8b813fe23b67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22951b71-eac0-4e3b-8b4d-8b813fe23b67', 2, NULL, 'Brinquedinho japonez', 'Caixinha de Brinquedos: 2. Brinquedinho japonez', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23919 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22951b71-eac0-4e3b-8b4d-8b813fe23b67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Os dois gatinhos', part.name_en = 'Caixinha de Brinquedos: 3. Os dois gatinhos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23919 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:65889edc-b727-4837-915a-9b4e979c47ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65889edc-b727-4837-915a-9b4e979c47ac', 3, NULL, 'Os dois gatinhos', 'Caixinha de Brinquedos: 3. Os dois gatinhos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23919 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65889edc-b727-4837-915a-9b4e979c47ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'A boneca doentinha', part.name_en = 'Caixinha de Brinquedos: 4. A boneca doentinha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23919 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:f3798d56-fbf1-48e4-b630-926bf9cb4283' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3798d56-fbf1-48e4-b630-926bf9cb4283', 4, NULL, 'A boneca doentinha', 'Caixinha de Brinquedos: 4. A boneca doentinha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23919 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3798d56-fbf1-48e4-b630-926bf9cb4283'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Dansa campestre', part.name_en = 'Caixinha de Brinquedos: 5. Dansa campestre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23919 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:0cccc44f-1ff3-4ba3-a508-7c13e6526f17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0cccc44f-1ff3-4ba3-a508-7c13e6526f17', 5, NULL, 'Dansa campestre', 'Caixinha de Brinquedos: 5. Dansa campestre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23919 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cccc44f-1ff3-4ba3-a508-7c13e6526f17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Travessuras do mascarado', part.name_en = 'Caixinha de Brinquedos: 6. Travessuras do mascarado',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23919 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:ef691973-a9f6-42b6-b91d-9b716faf5bda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef691973-a9f6-42b6-b91d-9b716faf5bda', 6, NULL, 'Travessuras do mascarado', 'Caixinha de Brinquedos: 6. Travessuras do mascarado', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23919 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef691973-a9f6-42b6-b91d-9b716faf5bda'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Briga de borboletas', part.name_en = 'Caixinha de Brinquedos: 7. Briga de borboletas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23919 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:df1c58cf-1e63-46e1-a50d-d5e3b66bb938' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df1c58cf-1e63-46e1-a50d-d5e3b66bb938', 7, NULL, 'Briga de borboletas', 'Caixinha de Brinquedos: 7. Briga de borboletas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23919 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df1c58cf-1e63-46e1-a50d-d5e3b66bb938'
);


-- None Cateretê

UPDATE pieces piece
SET piece.title = 'Cateretê', piece.title_en = 'Cateretê',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25980 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Choro

UPDATE pieces piece
SET piece.title = 'Choro', piece.title_en = 'Choro',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25592 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Concertino for bassoon & orchestra

UPDATE pieces piece
SET piece.title = 'Concertino for bassoon & orchestra', piece.title_en = 'Concertino for bassoon & orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24656 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Assai moderato', part.name_en = 'Bassoon Concertino: I. Assai moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24656 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:46571560-257a-40fe-af2d-0ea06224c55e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46571560-257a-40fe-af2d-0ea06224c55e', 1, 'I', 'Assai moderato', 'Bassoon Concertino: I. Assai moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24656 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46571560-257a-40fe-af2d-0ea06224c55e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Bassoon Concertino: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24656 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:d82de78c-95b4-4279-a301-c1b2367bf851' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d82de78c-95b4-4279-a301-c1b2367bf851', 2, 'II', 'Allegro', 'Bassoon Concertino: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24656 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d82de78c-95b4-4279-a301-c1b2367bf851'
);


-- None Concertino for clarinet & orchestra

UPDATE pieces piece
SET piece.title = 'Concertino for clarinet & orchestra', piece.title_en = 'Concertino for clarinet & orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23550 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'II',
    part.name_ko = 'Toada. Andantino non troppo', part.name_en = 'Clarinet Concertino: II. Toada. Andantino non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23550 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:474d5e9a-5e34-4a40-982c-4e52e9289fe5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:474d5e9a-5e34-4a40-982c-4e52e9289fe5', 1, 'II', 'Toada. Andantino non troppo', 'Clarinet Concertino: II. Toada. Andantino non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23550 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:474d5e9a-5e34-4a40-982c-4e52e9289fe5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'III',
    part.name_ko = 'Final. Allegro', part.name_en = 'Clarinet Concertino: III. Final. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23550 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:97cd5c19-7b68-4f1a-8031-ee8bb1f5364b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97cd5c19-7b68-4f1a-8031-ee8bb1f5364b', 2, 'III', 'Final. Allegro', 'Clarinet Concertino: III. Final. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23550 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97cd5c19-7b68-4f1a-8031-ee8bb1f5364b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'I',
    part.name_ko = 'Lento - Moderato mosso', part.name_en = 'Clarinet Concertino: I. Lento - Moderato mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23550 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:e8b7400b-2bf9-48b0-b76d-266af693435d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8b7400b-2bf9-48b0-b76d-266af693435d', 3, 'I', 'Lento - Moderato mosso', 'Clarinet Concertino: I. Lento - Moderato mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23550 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8b7400b-2bf9-48b0-b76d-266af693435d'
);


-- None Danca do Botocudo

UPDATE pieces piece
SET piece.title = 'Danca do Botocudo', piece.title_en = 'Danca do Botocudo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25394 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dona Janaína

UPDATE pieces piece
SET piece.title = 'Dona Janaína', piece.title_en = 'Dona Janaína',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24138 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fantasia Brasileira nº 1

UPDATE pieces piece
SET piece.title = 'Fantasia Brasileira nº 1', piece.title_en = 'Fantasia Brasileira nº 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24393 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fantasia Brasileira nº 2

UPDATE pieces piece
SET piece.title = 'Fantasia Brasileira nº 2', piece.title_en = 'Fantasia Brasileira nº 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23565 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fantasia Brasileira nº 3

UPDATE pieces piece
SET piece.title = 'Fantasia Brasileira nº 3', piece.title_en = 'Fantasia Brasileira nº 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25744 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fantasia Brasileira nº 4

UPDATE pieces piece
SET piece.title = 'Fantasia Brasileira nº 4', piece.title_en = 'Fantasia Brasileira nº 4',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24694 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Festa das igrejas

UPDATE pieces piece
SET piece.title = 'Festa das igrejas', piece.title_en = 'Festa das igrejas',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24083 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'São Francisco da Bahia', part.name_en = 'Festa das igrejas: I. São Francisco da Bahia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24083 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:4a5d0596-72d6-4722-97da-0d45e18fcc93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a5d0596-72d6-4722-97da-0d45e18fcc93', 1, 'I', 'São Francisco da Bahia', 'Festa das igrejas: I. São Francisco da Bahia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24083 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a5d0596-72d6-4722-97da-0d45e18fcc93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Rosário de Ouro Preto - Minas', part.name_en = 'Festa das igrejas: II. Rosário de Ouro Preto - Minas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24083 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:6716ff5a-d45c-410b-a30a-a74b3c717d93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6716ff5a-d45c-410b-a30a-a74b3c717d93', 2, 'II', 'Rosário de Ouro Preto - Minas', 'Festa das igrejas: II. Rosário de Ouro Preto - Minas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24083 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6716ff5a-d45c-410b-a30a-a74b3c717d93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'O Outerinho da Glória - Rio de Janeiro', part.name_en = 'Festa das igrejas: III. O Outerinho da Glória - Rio de Janeiro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24083 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:e5a8f788-8f14-4af0-a144-dd655fca309c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5a8f788-8f14-4af0-a144-dd655fca309c', 3, 'III', 'O Outerinho da Glória - Rio de Janeiro', 'Festa das igrejas: III. O Outerinho da Glória - Rio de Janeiro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24083 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5a8f788-8f14-4af0-a144-dd655fca309c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Nossa Senhora do Brasil - Aparecida', part.name_en = 'Festa das igrejas: IV. Nossa Senhora do Brasil - Aparecida',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24083 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:44d50afe-eb9b-4952-a6f7-6c35a1bb977c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44d50afe-eb9b-4952-a6f7-6c35a1bb977c', 4, 'IV', 'Nossa Senhora do Brasil - Aparecida', 'Festa das igrejas: IV. Nossa Senhora do Brasil - Aparecida', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24083 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44d50afe-eb9b-4952-a6f7-6c35a1bb977c'
);


-- None 기타 협주곡

UPDATE pieces piece
SET piece.title = '기타 협주곡', piece.title_en = 'Guitar Concerto',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24276 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'III',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Guitar Concerto: III. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24276 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:4d4c3d5e-4553-45e7-8dc0-c38a52ec9599' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d4c3d5e-4553-45e7-8dc0-c38a52ec9599', 1, 'III', 'Allegro non troppo', 'Guitar Concerto: III. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24276 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d4c3d5e-4553-45e7-8dc0-c38a52ec9599'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento e molto romantico', part.name_en = 'Guitar Concerto: II. Lento e molto romantico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24276 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:6d0475c8-4fef-4493-8749-18993ea7e2c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d0475c8-4fef-4493-8749-18993ea7e2c6', 2, 'II', 'Lento e molto romantico', 'Guitar Concerto: II. Lento e molto romantico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24276 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d0475c8-4fef-4493-8749-18993ea7e2c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Guitar Concerto: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24276 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:a6fe7960-7c0f-441e-9c27-83f088a64a8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6fe7960-7c0f-441e-9c27-83f088a64a8f', 3, 'I', 'Allegro moderato', 'Guitar Concerto: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24276 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6fe7960-7c0f-441e-9c27-83f088a64a8f'
);


-- None 발레 <Maracatu de Chico Rei>

UPDATE pieces piece
SET piece.title = '발레 <Maracatu de Chico Rei>', piece.title_en = 'Maracatu de Chico Rei',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23238 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction', part.name_en = 'Maracatu de Chico Rei: I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23238 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:f27cd53a-7cda-4cc9-a91f-ec78a25233dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f27cd53a-7cda-4cc9-a91f-ec78a25233dd', 1, 'I', 'Introduction', 'Maracatu de Chico Rei: I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23238 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f27cd53a-7cda-4cc9-a91f-ec78a25233dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Arrival of the Maracatu', part.name_en = 'Maracatu de Chico Rei: II. Arrival of the Maracatu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23238 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:a726783c-329b-4de6-889b-1a5673b87726' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a726783c-329b-4de6-889b-1a5673b87726', 2, 'II', 'Arrival of the Maracatu', 'Maracatu de Chico Rei: II. Arrival of the Maracatu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23238 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a726783c-329b-4de6-889b-1a5673b87726'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Dance of the Mucambas', part.name_en = 'Maracatu de Chico Rei: III. Dance of the Mucambas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23238 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:78c0d4d8-4be1-4629-82dd-82afa9a8449f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78c0d4d8-4be1-4629-82dd-82afa9a8449f', 3, 'III', 'Dance of the Mucambas', 'Maracatu de Chico Rei: III. Dance of the Mucambas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23238 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78c0d4d8-4be1-4629-82dd-82afa9a8449f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Dance of the Three Macotas', part.name_en = 'Maracatu de Chico Rei: IV. Dance of the Three Macotas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23238 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:af9620ec-ce77-4fa2-9ca8-2fc70e35f3ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af9620ec-ce77-4fa2-9ca8-2fc70e35f3ed', 4, 'IV', 'Dance of the Three Macotas', 'Maracatu de Chico Rei: IV. Dance of the Three Macotas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23238 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af9620ec-ce77-4fa2-9ca8-2fc70e35f3ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Dance of King Chico and Queen N''Ginga', part.name_en = 'Maracatu de Chico Rei: V. Dance of King Chico and Queen N''Ginga',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23238 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:871a6094-f56d-4d97-b76e-5dedfc8097b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:871a6094-f56d-4d97-b76e-5dedfc8097b2', 5, 'V', 'Dance of King Chico and Queen N''Ginga', 'Maracatu de Chico Rei: V. Dance of King Chico and Queen N''Ginga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23238 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:871a6094-f56d-4d97-b76e-5dedfc8097b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Dance of Prince Samba-Eb', part.name_en = 'Maracatu de Chico Rei: VI. Dance of Prince Samba-Eb',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23238 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:5de62214-e509-4f2a-9f83-8ad97f993953' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5de62214-e509-4f2a-9f83-8ad97f993953', 6, 'VI', 'Dance of Prince Samba-Eb', 'Maracatu de Chico Rei: VI. Dance of Prince Samba-Eb', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23238 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5de62214-e509-4f2a-9f83-8ad97f993953'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Dance of the Six Slaves', part.name_en = 'Maracatu de Chico Rei: VII. Dance of the Six Slaves',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23238 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:55a13cb6-9315-45e9-b1e8-aee2aad3cf72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55a13cb6-9315-45e9-b1e8-aee2aad3cf72', 7, 'VII', 'Dance of the Six Slaves', 'Maracatu de Chico Rei: VII. Dance of the Six Slaves', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23238 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55a13cb6-9315-45e9-b1e8-aee2aad3cf72'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Dance of the White Princes', part.name_en = 'Maracatu de Chico Rei: VIII. Dance of the White Princes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23238 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:c299756a-9693-4547-9d94-a4f1c5fd951e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c299756a-9693-4547-9d94-a4f1c5fd951e', 8, 'VIII', 'Dance of the White Princes', 'Maracatu de Chico Rei: VIII. Dance of the White Princes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23238 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c299756a-9693-4547-9d94-a4f1c5fd951e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'The Liberation of the Slaves - Final Dance', part.name_en = 'Maracatu de Chico Rei: IX. The Liberation of the Slaves - Final Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23238 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:c819fcaa-c6f1-4be8-8def-92e11154b9d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c819fcaa-c6f1-4be8-8def-92e11154b9d0', 9, 'IX', 'The Liberation of the Slaves - Final Dance', 'Maracatu de Chico Rei: IX. The Liberation of the Slaves - Final Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23238 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c819fcaa-c6f1-4be8-8def-92e11154b9d0'
);


-- None Marvadinho

UPDATE pieces piece
SET piece.title = 'Marvadinho', piece.title_en = 'Marvadinho',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24222 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Minueto‐Fantasia

UPDATE pieces piece
SET piece.title = 'Minueto‐Fantasia', piece.title_en = 'Minueto‐Fantasia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25973 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Modinha

UPDATE pieces piece
SET piece.title = 'Modinha', piece.title_en = 'Modinha',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25998 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Momento musical

UPDATE pieces piece
SET piece.title = 'Momento musical', piece.title_en = 'Momento musical',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23525 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quatro Pecas Brasileiras

UPDATE pieces piece
SET piece.title = 'Quatro Pecas Brasileiras', piece.title_en = 'Quatro Pecas Brasileiras',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25801 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Maroca', part.name_en = 'Quatro Pecas Brasileiras: I. Maroca',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25801 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:217b38fa-47f0-4c18-9de3-a369247b092a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:217b38fa-47f0-4c18-9de3-a369247b092a', 1, 'I', 'Maroca', 'Quatro Pecas Brasileiras: I. Maroca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25801 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:217b38fa-47f0-4c18-9de3-a369247b092a'
);


-- None Quatro Peças Para Pequena Orquestra de Câmara

UPDATE pieces piece
SET piece.title = 'Quatro Peças Para Pequena Orquestra de Câmara', piece.title_en = 'Quatro Peças Para Pequena Orquestra de Câmara',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25504 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Modinha imperial', part.name_en = 'Quatro Peças Para Pequena Orquestra de Câmara: Modinha imperial',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25504 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:061c9395-4b1b-47b2-93a3-3fb52e565c2b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:061c9395-4b1b-47b2-93a3-3fb52e565c2b', 1, NULL, 'Modinha imperial', 'Quatro Peças Para Pequena Orquestra de Câmara: Modinha imperial', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25504 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:061c9395-4b1b-47b2-93a3-3fb52e565c2b'
);


-- None Repinicando

UPDATE pieces piece
SET piece.title = 'Repinicando', piece.title_en = 'Repinicando',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24054 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Romanza for Violin and Piano

UPDATE pieces piece
SET piece.title = 'Romanza for Violin and Piano', piece.title_en = 'Romanza for Violin and Piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23995 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Seresta no. 2

UPDATE pieces piece
SET piece.title = 'Seresta no. 2', piece.title_en = 'Seresta no. 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25914 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sinfonia Tropical

UPDATE pieces piece
SET piece.title = 'Sinfonia Tropical', piece.title_en = 'Sinfonia Tropical',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23432 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sonata para violino em lá maior

UPDATE pieces piece
SET piece.title = 'Sonata para violino em lá maior', piece.title_en = 'Sonata para violino em lá maior',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23907 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Sonata para violino em lá maior: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23907 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:1610bd37-8318-4d32-b108-af1ea2e5bcd3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1610bd37-8318-4d32-b108-af1ea2e5bcd3', 1, 'I', 'Allegro moderato', 'Sonata para violino em lá maior: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23907 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1610bd37-8318-4d32-b108-af1ea2e5bcd3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Sonata para violino em lá maior: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23907 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:0445b298-74ce-49dd-a0d8-b0a56d08c159' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0445b298-74ce-49dd-a0d8-b0a56d08c159', 2, 'II', 'Andante', 'Sonata para violino em lá maior: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23907 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0445b298-74ce-49dd-a0d8-b0a56d08c159'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro non troppo ma deciso', part.name_en = 'Sonata para violino em lá maior: III. Allegro non troppo ma deciso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23907 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:e97fb6b8-ec63-433b-8b1f-ea428a7c3d56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e97fb6b8-ec63-433b-8b1f-ea428a7c3d56', 3, 'III', 'Allegro non troppo ma deciso', 'Sonata para violino em lá maior: III. Allegro non troppo ma deciso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23907 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e97fb6b8-ec63-433b-8b1f-ea428a7c3d56'
);


-- None Sonata para violino em sol maior

UPDATE pieces piece
SET piece.title = 'Sonata para violino em sol maior', piece.title_en = 'Sonata para violino em sol maior',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23822 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sonata para violino n.º 1

UPDATE pieces piece
SET piece.title = 'Sonata para violino n.º 1', piece.title_en = 'Sonata para violino n.º 1',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23537 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lento', part.name_en = 'Sonata para violino n.º 1: I. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23537 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:5f92b9a7-e53e-4d7f-b114-098e7ca8b7d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f92b9a7-e53e-4d7f-b114-098e7ca8b7d9', 1, 'I', 'Lento', 'Sonata para violino n.º 1: I. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23537 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f92b9a7-e53e-4d7f-b114-098e7ca8b7d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto amabile', part.name_en = 'Sonata para violino n.º 1: II. Allegretto amabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23537 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:71d19256-af57-43cc-ad1f-a761ec383b9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71d19256-af57-43cc-ad1f-a761ec383b9c', 2, 'II', 'Allegretto amabile', 'Sonata para violino n.º 1: II. Allegretto amabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23537 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71d19256-af57-43cc-ad1f-a761ec383b9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Moderato energico', part.name_en = 'Sonata para violino n.º 1: III. Moderato energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23537 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:09db188c-8d5f-4d02-9693-a82d5adc85b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09db188c-8d5f-4d02-9693-a82d5adc85b4', 3, 'III', 'Moderato energico', 'Sonata para violino n.º 1: III. Moderato energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23537 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09db188c-8d5f-4d02-9693-a82d5adc85b4'
);


-- None Sonata para violino n.º 2

UPDATE pieces piece
SET piece.title = 'Sonata para violino n.º 2', piece.title_en = 'Sonata para violino n.º 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25310 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sonata para violino n.º 3

UPDATE pieces piece
SET piece.title = 'Sonata para violino n.º 3', piece.title_en = 'Sonata para violino n.º 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23531 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro tranquillo', part.name_en = 'Sonata para violino n.º 3: I. Allegro tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23531 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:d2fdc154-62bc-4798-9322-628faf09b3e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2fdc154-62bc-4798-9322-628faf09b3e5', 1, 'I', 'Allegro tranquillo', 'Sonata para violino n.º 3: I. Allegro tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23531 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2fdc154-62bc-4798-9322-628faf09b3e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante molto sostenuto', part.name_en = 'Sonata para violino n.º 3: II. Andante molto sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23531 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:ce6d1d3c-8c86-4e5a-b1b3-f5fbf4c689ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce6d1d3c-8c86-4e5a-b1b3-f5fbf4c689ed', 2, 'II', 'Andante molto sostenuto', 'Sonata para violino n.º 3: II. Andante molto sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23531 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce6d1d3c-8c86-4e5a-b1b3-f5fbf4c689ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rondó. Allegro scherzoso', part.name_en = 'Sonata para violino n.º 3: III. Rondó. Allegro scherzoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23531 AND p.composer_id = 415 AND part.part_key = 'musicbrainz:8290cfbb-20fd-4e97-ab89-c53ae45e4622' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8290cfbb-20fd-4e97-ab89-c53ae45e4622', 3, 'III', 'Rondó. Allegro scherzoso', 'Sonata para violino n.º 3: III. Rondó. Allegro scherzoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23531 AND p.composer_id = 415
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8290cfbb-20fd-4e97-ab89-c53ae45e4622'
);


-- None Valsa chôro no. 1

UPDATE pieces piece
SET piece.title = 'Valsa chôro no. 1', piece.title_en = 'Valsa chôro no. 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23650 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa chôro no. 10

UPDATE pieces piece
SET piece.title = 'Valsa chôro no. 10', piece.title_en = 'Valsa chôro no. 10',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24370 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa chôro no. 11

UPDATE pieces piece
SET piece.title = 'Valsa chôro no. 11', piece.title_en = 'Valsa chôro no. 11',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25016 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa chôro no. 12

UPDATE pieces piece
SET piece.title = 'Valsa chôro no. 12', piece.title_en = 'Valsa chôro no. 12',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24733 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa chôro no. 2

UPDATE pieces piece
SET piece.title = 'Valsa chôro no. 2', piece.title_en = 'Valsa chôro no. 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23489 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa chôro no. 3

UPDATE pieces piece
SET piece.title = 'Valsa chôro no. 3', piece.title_en = 'Valsa chôro no. 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25214 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa chôro no. 4

UPDATE pieces piece
SET piece.title = 'Valsa chôro no. 4', piece.title_en = 'Valsa chôro no. 4',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25511 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa chôro no. 5

UPDATE pieces piece
SET piece.title = 'Valsa chôro no. 5', piece.title_en = 'Valsa chôro no. 5',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25716 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa chôro no. 6

UPDATE pieces piece
SET piece.title = 'Valsa chôro no. 6', piece.title_en = 'Valsa chôro no. 6',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25572 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa chôro no. 7

UPDATE pieces piece
SET piece.title = 'Valsa chôro no. 7', piece.title_en = 'Valsa chôro no. 7',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25920 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa chôro no. 8

UPDATE pieces piece
SET piece.title = 'Valsa chôro no. 8', piece.title_en = 'Valsa chôro no. 8',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25232 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa chôro no. 9

UPDATE pieces piece
SET piece.title = 'Valsa chôro no. 9', piece.title_en = 'Valsa chôro no. 9',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24153 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa de esquina

UPDATE pieces piece
SET piece.title = 'Valsa de esquina', piece.title_en = 'Valsa de esquina',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24089 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa de esquina no. 1

UPDATE pieces piece
SET piece.title = 'Valsa de esquina no. 1', piece.title_en = 'Valsa de esquina no. 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24519 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa de esquina no. 10

UPDATE pieces piece
SET piece.title = 'Valsa de esquina no. 10', piece.title_en = 'Valsa de esquina no. 10',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24542 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa de esquina no. 11

UPDATE pieces piece
SET piece.title = 'Valsa de esquina no. 11', piece.title_en = 'Valsa de esquina no. 11',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23652 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa de esquina no. 12

UPDATE pieces piece
SET piece.title = 'Valsa de esquina no. 12', piece.title_en = 'Valsa de esquina no. 12',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24509 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa de esquina no. 2

UPDATE pieces piece
SET piece.title = 'Valsa de esquina no. 2', piece.title_en = 'Valsa de esquina no. 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25899 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa de esquina no. 3

UPDATE pieces piece
SET piece.title = 'Valsa de esquina no. 3', piece.title_en = 'Valsa de esquina no. 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25928 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa de esquina no. 4

UPDATE pieces piece
SET piece.title = 'Valsa de esquina no. 4', piece.title_en = 'Valsa de esquina no. 4',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25328 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa de esquina no. 5

UPDATE pieces piece
SET piece.title = 'Valsa de esquina no. 5', piece.title_en = 'Valsa de esquina no. 5',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24314 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa de esquina no. 6

UPDATE pieces piece
SET piece.title = 'Valsa de esquina no. 6', piece.title_en = 'Valsa de esquina no. 6',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24091 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa de esquina no. 7

UPDATE pieces piece
SET piece.title = 'Valsa de esquina no. 7', piece.title_en = 'Valsa de esquina no. 7',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24498 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa de esquina no. 8

UPDATE pieces piece
SET piece.title = 'Valsa de esquina no. 8', piece.title_en = 'Valsa de esquina no. 8',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24917 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valsa de esquina no. 9

UPDATE pieces piece
SET piece.title = 'Valsa de esquina no. 9', piece.title_en = 'Valsa de esquina no. 9',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23748 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valse Elegante

UPDATE pieces piece
SET piece.title = 'Valse Elegante', piece.title_en = 'Valse Elegante',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24018 AND piece.composer_id = 415
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Barcarola

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Barcarola', 'Barcarola', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 415
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Barcarola'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8cbee29b-c1ab-4f5b-bf99-9fa842be7ae0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8cbee29b-c1ab-4f5b-bf99-9fa842be7ae0'
FROM pieces p
WHERE p.composer_id = 415 AND p.title = 'Barcarola' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8cbee29b-c1ab-4f5b-bf99-9fa842be7ae0'
);


-- None Congada

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Congada', 'Congada', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 415
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Congada'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1cc74cae-1a2a-4d0a-8e0b-d59750d49d6d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1cc74cae-1a2a-4d0a-8e0b-d59750d49d6d'
FROM pieces p
WHERE p.composer_id = 415 AND p.title = 'Congada' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1cc74cae-1a2a-4d0a-8e0b-d59750d49d6d'
);


-- None Lenda sertaneja

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Lenda sertaneja', 'Lenda sertaneja', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 415
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Lenda sertaneja'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b13aed3-871b-32d6-ac1c-06c648bd019d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2b13aed3-871b-32d6-ac1c-06c648bd019d'
FROM pieces p
WHERE p.composer_id = 415 AND p.title = 'Lenda sertaneja' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b13aed3-871b-32d6-ac1c-06c648bd019d'
);


-- None Lundu (em forma de rondó)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Lundu (em forma de rondó)', 'Lundu (em forma de rondó)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 415
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Lundu (em forma de rondó)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '151c7793-c342-4af3-bb1b-3ba78b42ed27'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '151c7793-c342-4af3-bb1b-3ba78b42ed27'
FROM pieces p
WHERE p.composer_id = 415 AND p.title = 'Lundu (em forma de rondó)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '151c7793-c342-4af3-bb1b-3ba78b42ed27'
);


-- None 피아노 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡', 'Piano Concerto', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 415
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4fa84514-5614-4423-b7ac-b6f2c3a7dc3a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4fa84514-5614-4423-b7ac-b6f2c3a7dc3a'
FROM pieces p
WHERE p.composer_id = 415 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4fa84514-5614-4423-b7ac-b6f2c3a7dc3a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52d5a7b3-8467-4557-bd4f-709803a86a5c', 1, 'I', 'Allegro', 'Piano Concerto: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 415 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52d5a7b3-8467-4557-bd4f-709803a86a5c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8c25906-1686-4839-be1d-7360fe3eb9d5', 2, 'II', 'Andante', 'Piano Concerto: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 415 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8c25906-1686-4839-be1d-7360fe3eb9d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c77beac-67eb-4e5e-9376-d098ce917e46', 3, 'III', 'Allegretto marziale', 'Piano Concerto: III. Allegretto marziale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 415 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c77beac-67eb-4e5e-9376-d098ce917e46'
);


-- None 현악 4중주 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 1번', 'String Quartet no. 1', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 415
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c95dd37-3749-434a-90d0-7fca2e4052f1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1c95dd37-3749-434a-90d0-7fca2e4052f1'
FROM pieces p
WHERE p.composer_id = 415 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c95dd37-3749-434a-90d0-7fca2e4052f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49ce62cc-af0b-470e-aa4d-3538ca6270a4', 1, 'I', 'Allegro deciso', 'String Quartet no. 1: I. Allegro deciso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 415 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49ce62cc-af0b-470e-aa4d-3538ca6270a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b262b87b-a100-4953-a348-dcd0133ae6e6', 2, 'II', 'Andante', 'String Quartet no. 1: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 415 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b262b87b-a100-4953-a348-dcd0133ae6e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e31f3e6a-ffb4-4e9f-9280-ad96b60153bd', 3, 'III', 'Rondo. Allegretto grazioso e amabile', 'String Quartet no. 1: III. Rondo. Allegretto grazioso e amabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 415 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e31f3e6a-ffb4-4e9f-9280-ad96b60153bd'
);


-- None 현악 4중주 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 2번', 'String Quartet no. 2', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 415
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54c24257-6f19-44eb-a4ee-bfbd5e3381ec'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '54c24257-6f19-44eb-a4ee-bfbd5e3381ec'
FROM pieces p
WHERE p.composer_id = 415 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54c24257-6f19-44eb-a4ee-bfbd5e3381ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35db0bd4-55fb-4f68-918e-a7947e0e028f', 1, 'I', 'Allegro', 'String Quartet no. 2: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 415 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35db0bd4-55fb-4f68-918e-a7947e0e028f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d10f167a-c2b3-4480-ac47-b7fa24954095', 2, 'II', 'Seresta', 'String Quartet no. 2: II. Seresta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 415 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d10f167a-c2b3-4480-ac47-b7fa24954095'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17a5fce2-13af-429c-9506-a124882a109f', 3, 'III', 'Desafio', 'String Quartet no. 2: III. Desafio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 415 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17a5fce2-13af-429c-9506-a124882a109f'
);


-- None 탱고

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '탱고', 'Tango', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 415
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '탱고'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c98dfef-3e49-4ed6-ba7d-df882ecd2699'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6c98dfef-3e49-4ed6-ba7d-df882ecd2699'
FROM pieces p
WHERE p.composer_id = 415 AND p.title = '탱고' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c98dfef-3e49-4ed6-ba7d-df882ecd2699'
);


-- None 바이올린 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡', 'Violin Concerto', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 415
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f09e6d03-48b9-4921-8b21-e07acfd033b9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f09e6d03-48b9-4921-8b21-e07acfd033b9'
FROM pieces p
WHERE p.composer_id = 415 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f09e6d03-48b9-4921-8b21-e07acfd033b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c6a65df-9a3d-4cf8-bad3-b19726bc0c6c', 1, 'I', 'Allegro moderato', 'Violin Concerto: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 415 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c6a65df-9a3d-4cf8-bad3-b19726bc0c6c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbf911bd-b5d1-4e63-a606-fc24fe2f0c0e', 2, 'III', 'Allegro con brio', 'Violin Concerto: III. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 415 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbf911bd-b5d1-4e63-a606-fc24fe2f0c0e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7fb0ff0-c498-4157-8615-bb54ed9bb0c0', 3, 'II', 'Lento', 'Violin Concerto: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 415 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7fb0ff0-c498-4157-8615-bb54ed9bb0c0'
);


-- 숨길 seed 작품 없음
