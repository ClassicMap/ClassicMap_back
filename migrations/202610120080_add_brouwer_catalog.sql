-- Leo Brouwer 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 90개(묶음 12, 다악장 31, 낱곡 47),
-- 새 작품 3개, part 168개, 그 아래 7개.
-- seed 102개 중 87개를 작품·part 에 잇고, 8개를 숨기고, 7개는 그대로 둔다.
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
SET piece.title = 'Tita and Pedro''s Love Theme (중복 17764)'
WHERE piece.id = 17764 AND piece.composer_id = 204 AND piece.title = 'Tita and Pedro''s Love Theme'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

UPDATE pieces piece
SET piece.title = 'Tita''s Theme (piano) (중복 19706)'
WHERE piece.id = 19706 AND piece.composer_id = 204 AND piece.title = 'Tita''s Theme (piano)'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

UPDATE pieces piece
SET piece.title = 'Quail in Rose Petal Sauce (piano) (중복 19923)'
WHERE piece.id = 19923 AND piece.composer_id = 204 AND piece.title = 'Quail in Rose Petal Sauce (piano)'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);


-- None Acerca del cielo, el aire y la sonrisa

UPDATE pieces piece
SET piece.title = 'Acerca del cielo, el aire y la sonrisa', piece.title_en = 'Acerca del cielo, el aire y la sonrisa',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17339 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'La ciudad de las mil cuerdas', part.name_en = 'Acerca del cielo, el aire y la sonrisa: I. La ciudad de las mil cuerdas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17339 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:b2cfd13e-f7f8-4d92-8d15-fc94a8b1967e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2cfd13e-f7f8-4d92-8d15-fc94a8b1967e', 1, 'I', 'La ciudad de las mil cuerdas', 'Acerca del cielo, el aire y la sonrisa: I. La ciudad de las mil cuerdas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17339 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2cfd13e-f7f8-4d92-8d15-fc94a8b1967e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Fantasía de los ecos', part.name_en = 'Acerca del cielo, el aire y la sonrisa: II. Fantasía de los ecos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17339 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:ccfca519-af8b-44fa-85bb-f3510b121fbd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccfca519-af8b-44fa-85bb-f3510b121fbd', 2, 'II', 'Fantasía de los ecos', 'Acerca del cielo, el aire y la sonrisa: II. Fantasía de los ecos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17339 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccfca519-af8b-44fa-85bb-f3510b121fbd'
);


-- None 영화음악 <Alsino y el cóndor>

UPDATE pieces piece
SET piece.title = '영화음악 <Alsino y el cóndor>', piece.title_en = 'Alsino y el cóndor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17222 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None An Idea (Passacaglia for Eli)

UPDATE pieces piece
SET piece.title = 'An Idea (Passacaglia for Eli)', piece.title_en = 'An Idea (Passacaglia for Eli)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15753 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Beatlerianas for guitar and string quartet

UPDATE pieces piece
SET piece.title = 'Beatlerianas for guitar and string quartet', piece.title_en = 'Beatlerianas for guitar and string quartet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17197 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Eleanor Rigby', part.name_en = 'Beatlerianas for guitar and string quartet: I. Eleanor Rigby',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17197 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:7d94103f-a532-4384-b465-c35a89ba643c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d94103f-a532-4384-b465-c35a89ba643c', 1, 'I', 'Eleanor Rigby', 'Beatlerianas for guitar and string quartet: I. Eleanor Rigby', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17197 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d94103f-a532-4384-b465-c35a89ba643c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Here, there and everywhere', part.name_en = 'Beatlerianas for guitar and string quartet: II. Here, there and everywhere',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17197 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:84a977ec-195a-4707-ae48-f9cd9d90123f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84a977ec-195a-4707-ae48-f9cd9d90123f', 2, 'II', 'Here, there and everywhere', 'Beatlerianas for guitar and string quartet: II. Here, there and everywhere', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17197 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84a977ec-195a-4707-ae48-f9cd9d90123f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'She’s leaving home', part.name_en = 'Beatlerianas for guitar and string quartet: III. She’s leaving home',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17197 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:8c4e7af7-b98f-4f7a-be8e-8fc1131b2b74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c4e7af7-b98f-4f7a-be8e-8fc1131b2b74', 3, 'III', 'She’s leaving home', 'Beatlerianas for guitar and string quartet: III. She’s leaving home', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17197 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c4e7af7-b98f-4f7a-be8e-8fc1131b2b74'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'A Ticket to Ride', part.name_en = 'Beatlerianas for guitar and string quartet: IV. A Ticket to Ride',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17197 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:b6355e84-f543-4d59-9f7b-ec1dfd5cac36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6355e84-f543-4d59-9f7b-ec1dfd5cac36', 4, 'IV', 'A Ticket to Ride', 'Beatlerianas for guitar and string quartet: IV. A Ticket to Ride', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17197 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6355e84-f543-4d59-9f7b-ec1dfd5cac36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Yesterday', part.name_en = 'Beatlerianas for guitar and string quartet: V. Yesterday',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17197 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:f1b81158-6751-4ba7-90d3-b4c51d6e6597' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1b81158-6751-4ba7-90d3-b4c51d6e6597', 5, 'V', 'Yesterday', 'Beatlerianas for guitar and string quartet: V. Yesterday', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17197 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1b81158-6751-4ba7-90d3-b4c51d6e6597'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Got to get you into my life', part.name_en = 'Beatlerianas for guitar and string quartet: VI. Got to get you into my life',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17197 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:6bbfc967-1edb-4d60-9cca-c1a2fbd0b962' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bbfc967-1edb-4d60-9cca-c1a2fbd0b962', 6, 'VI', 'Got to get you into my life', 'Beatlerianas for guitar and string quartet: VI. Got to get you into my life', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17197 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bbfc967-1edb-4d60-9cca-c1a2fbd0b962'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Penny Lane', part.name_en = 'Beatlerianas for guitar and string quartet: VII. Penny Lane',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17197 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:8bf26e56-9902-45d6-bc1c-38dde2a15c82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bf26e56-9902-45d6-bc1c-38dde2a15c82', 7, 'VII', 'Penny Lane', 'Beatlerianas for guitar and string quartet: VII. Penny Lane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17197 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bf26e56-9902-45d6-bc1c-38dde2a15c82'
);


-- None Boceto no. 4 "Acosta León"

UPDATE pieces piece
SET piece.title = 'Boceto no. 4 "Acosta León"', piece.title_en = 'Boceto no. 4 "Acosta León"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17084 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canciones amatorias

UPDATE pieces piece
SET piece.title = 'Canciones amatorias', piece.title_en = 'Canciones amatorias',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18647 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'El Cantar de los Cantares', part.name_en = 'Canciones amatorias: El Cantar de los Cantares',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18647 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:2d176431-2829-4bf6-be24-311e69df36f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d176431-2829-4bf6-be24-311e69df36f7', 1, NULL, 'El Cantar de los Cantares', 'Canciones amatorias: El Cantar de los Cantares', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18647 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d176431-2829-4bf6-be24-311e69df36f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Yo he de enseñarte el camino', part.name_en = 'Canciones amatorias: Yo he de enseñarte el camino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18647 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:7a55702c-326b-4f97-9a35-4e784e389824' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a55702c-326b-4f97-9a35-4e784e389824', 2, NULL, 'Yo he de enseñarte el camino', 'Canciones amatorias: Yo he de enseñarte el camino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18647 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a55702c-326b-4f97-9a35-4e784e389824'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Balada de un día de julio', part.name_en = 'Canciones amatorias: Balada de un día de julio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18647 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:afab5ca6-5bb6-4afb-9855-08210342fb05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afab5ca6-5bb6-4afb-9855-08210342fb05', 3, NULL, 'Balada de un día de julio', 'Canciones amatorias: Balada de un día de julio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18647 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afab5ca6-5bb6-4afb-9855-08210342fb05'
);


-- None Canticum

UPDATE pieces piece
SET piece.title = 'Canticum', piece.title_en = 'Canticum',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16021 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Eclosión', part.name_en = 'Canticum: I. Eclosión',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16021 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:141fdb1e-7bec-4fa9-b604-e1b8c68789fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:141fdb1e-7bec-4fa9-b604-e1b8c68789fb', 1, 'I', 'Eclosión', 'Canticum: I. Eclosión', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16021 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:141fdb1e-7bec-4fa9-b604-e1b8c68789fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ditirambo', part.name_en = 'Canticum: II. Ditirambo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16021 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:6e437b5e-856e-4126-b6f3-55fcae188813' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e437b5e-856e-4126-b6f3-55fcae188813', 2, 'II', 'Ditirambo', 'Canticum: II. Ditirambo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16021 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e437b5e-856e-4126-b6f3-55fcae188813'
);


-- None Cantilena de los bosques

UPDATE pieces piece
SET piece.title = 'Cantilena de los bosques', piece.title_en = 'Cantilena de los bosques',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18148 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chencha and Sgt. Trevino's Potpourri

UPDATE pieces piece
SET piece.title = 'Chencha and Sgt. Trevino''s Potpourri', piece.title_en = 'Chencha and Sgt. Trevino''s Potpourri',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16457 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Como agua para chocolate

UPDATE pieces piece
SET piece.title = 'Como agua para chocolate', piece.title_en = 'Como agua para chocolate',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17066 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Codornices en pétalos de rosa', part.name_en = 'Codornices en pétalos de rosa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17066 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:08351dfd-00c8-4a3f-83cc-fb2f50daf8cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08351dfd-00c8-4a3f-83cc-fb2f50daf8cd', 1, NULL, 'Codornices en pétalos de rosa', 'Codornices en pétalos de rosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17066 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08351dfd-00c8-4a3f-83cc-fb2f50daf8cd'
);


-- None Concerto de Toronto

UPDATE pieces piece
SET piece.title = 'Concerto de Toronto', piece.title_en = 'Concerto de Toronto',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19185 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'Concerto de Toronto: I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19185 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:9acbc6ee-b2a4-4a67-a7b9-e241c8eeaf1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9acbc6ee-b2a4-4a67-a7b9-e241c8eeaf1a', 1, 'I', 'Moderato', 'Concerto de Toronto: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19185 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9acbc6ee-b2a4-4a67-a7b9-e241c8eeaf1a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Theme and Variations', part.name_en = 'Concerto de Toronto: II. Theme and Variations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19185 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:0e8ea8cd-70c7-4885-89f4-477abcfd74c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e8ea8cd-70c7-4885-89f4-477abcfd74c8', 2, 'II', 'Theme and Variations', 'Concerto de Toronto: II. Theme and Variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19185 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e8ea8cd-70c7-4885-89f4-477abcfd74c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e8ea8cd-70c7-4885-89f4-477abcfd74c8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Theme', part.name_en = 'Concerto de Toronto: II. Theme and Variations: Theme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19185 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:ccafc266-f0bb-4d76-a783-c9ab9307ebe9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ccafc266-f0bb-4d76-a783-c9ab9307ebe9', 1, NULL, 'Theme', 'Concerto de Toronto: II. Theme and Variations: Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e8ea8cd-70c7-4885-89f4-477abcfd74c8'
WHERE p.id = 19185 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccafc266-f0bb-4d76-a783-c9ab9307ebe9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e8ea8cd-70c7-4885-89f4-477abcfd74c8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Variation 1', part.name_en = 'Concerto de Toronto: II. Theme and Variations: Variation 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19185 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:ad432251-1ae7-4424-b7c7-d5cd41ab9b2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ad432251-1ae7-4424-b7c7-d5cd41ab9b2d', 2, NULL, 'Variation 1', 'Concerto de Toronto: II. Theme and Variations: Variation 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e8ea8cd-70c7-4885-89f4-477abcfd74c8'
WHERE p.id = 19185 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad432251-1ae7-4424-b7c7-d5cd41ab9b2d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e8ea8cd-70c7-4885-89f4-477abcfd74c8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Variation 2', part.name_en = 'Concerto de Toronto: II. Theme and Variations: Variation 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19185 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:9b302e06-9340-45eb-b52c-ca12dfebb366' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9b302e06-9340-45eb-b52c-ca12dfebb366', 3, NULL, 'Variation 2', 'Concerto de Toronto: II. Theme and Variations: Variation 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e8ea8cd-70c7-4885-89f4-477abcfd74c8'
WHERE p.id = 19185 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b302e06-9340-45eb-b52c-ca12dfebb366'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e8ea8cd-70c7-4885-89f4-477abcfd74c8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Variation 3', part.name_en = 'Concerto de Toronto: II. Theme and Variations: Variation 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19185 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:9f8dd455-2397-4893-b1b6-45930374f144' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9f8dd455-2397-4893-b1b6-45930374f144', 4, NULL, 'Variation 3', 'Concerto de Toronto: II. Theme and Variations: Variation 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e8ea8cd-70c7-4885-89f4-477abcfd74c8'
WHERE p.id = 19185 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f8dd455-2397-4893-b1b6-45930374f144'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e8ea8cd-70c7-4885-89f4-477abcfd74c8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Variation 4', part.name_en = 'Concerto de Toronto: II. Theme and Variations: Variation 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19185 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:dfb06b06-65a6-475e-ad5e-09d824b33a02' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dfb06b06-65a6-475e-ad5e-09d824b33a02', 5, NULL, 'Variation 4', 'Concerto de Toronto: II. Theme and Variations: Variation 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e8ea8cd-70c7-4885-89f4-477abcfd74c8'
WHERE p.id = 19185 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfb06b06-65a6-475e-ad5e-09d824b33a02'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tempo Libero. Allegro', part.name_en = 'Concerto de Toronto: III. Tempo Libero. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19185 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:dc5f119a-cc86-4132-b26a-9f4451b5a39f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc5f119a-cc86-4132-b26a-9f4451b5a39f', 3, 'III', 'Tempo Libero. Allegro', 'Concerto de Toronto: III. Tempo Libero. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19185 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc5f119a-cc86-4132-b26a-9f4451b5a39f'
);


-- None Concerto for Guitar and Small Orchestra

UPDATE pieces piece
SET piece.title = 'Concerto for Guitar and Small Orchestra', piece.title_en = 'Concerto for Guitar and Small Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18316 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'III',
    part.name_ko = 'Sonatas y Montunos', part.name_en = 'Concerto for Guitar and Small Orchestra: III. Sonatas y Montunos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18316 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:0e1c2882-f690-479c-90f0-9f63c17457c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e1c2882-f690-479c-90f0-9f63c17457c2', 1, 'III', 'Sonatas y Montunos', 'Concerto for Guitar and Small Orchestra: III. Sonatas y Montunos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18316 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e1c2882-f690-479c-90f0-9f63c17457c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ragas', part.name_en = 'Concerto for Guitar and Small Orchestra: II. Ragas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18316 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:30098179-a6ea-41f9-95ae-ca6f129a5004' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30098179-a6ea-41f9-95ae-ca6f129a5004', 2, 'II', 'Ragas', 'Concerto for Guitar and Small Orchestra: II. Ragas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18316 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30098179-a6ea-41f9-95ae-ca6f129a5004'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'I',
    part.name_ko = 'Punteos', part.name_en = 'Concerto for Guitar and Small Orchestra: I. Punteos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18316 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:3f2a6326-0912-4e75-b6f3-c7a14eae6d95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f2a6326-0912-4e75-b6f3-c7a14eae6d95', 3, 'I', 'Punteos', 'Concerto for Guitar and Small Orchestra: I. Punteos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18316 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f2a6326-0912-4e75-b6f3-c7a14eae6d95'
);


-- None 기타 협주곡 3번 "Elegiaco"

UPDATE pieces piece
SET piece.title = '기타 협주곡 3번 "Elegiaco"', piece.title_en = 'Concerto for Guitar no. 3 "Elegiaco"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17814 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Tranquillo', part.name_en = 'Concerto for Guitar no. 3 "Elegiaco": I. Tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17814 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:4530ad6b-40ca-4ec8-89a6-22ddb4414aab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4530ad6b-40ca-4ec8-89a6-22ddb4414aab', 1, 'I', 'Tranquillo', 'Concerto for Guitar no. 3 "Elegiaco": I. Tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17814 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4530ad6b-40ca-4ec8-89a6-22ddb4414aab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Interlude', part.name_en = 'Concerto for Guitar no. 3 "Elegiaco": II. Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17814 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:497ac0e1-2ad6-4dfb-8064-1999f451cc18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:497ac0e1-2ad6-4dfb-8064-1999f451cc18', 2, 'II', 'Interlude', 'Concerto for Guitar no. 3 "Elegiaco": II. Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17814 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:497ac0e1-2ad6-4dfb-8064-1999f451cc18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Finale: Toccata', part.name_en = 'Concerto for Guitar no. 3 "Elegiaco": III. Finale: Toccata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17814 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:9c5a0c79-cb34-4c52-98f5-7d867dcf2f15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c5a0c79-cb34-4c52-98f5-7d867dcf2f15', 3, 'III', 'Finale: Toccata', 'Concerto for Guitar no. 3 "Elegiaco": III. Finale: Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17814 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c5a0c79-cb34-4c52-98f5-7d867dcf2f15'
);


-- None Concierto de Volos

UPDATE pieces piece
SET piece.title = 'Concierto de Volos', piece.title_en = 'Concierto de Volos',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18580 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Aeolian Serenade', part.name_en = 'Concierto de Volos: I. Aeolian Serenade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18580 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:da30ae47-ca91-4605-8a55-e2ba58667429' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da30ae47-ca91-4605-8a55-e2ba58667429', 1, 'I', 'Aeolian Serenade', 'Concierto de Volos: I. Aeolian Serenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18580 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da30ae47-ca91-4605-8a55-e2ba58667429'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Sphynx', part.name_en = 'Concierto de Volos: II. The Sphynx',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18580 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:eac72c3a-a2ca-4ccb-ae48-8b806aa3be7c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eac72c3a-a2ca-4ccb-ae48-8b806aa3be7c', 2, 'II', 'The Sphynx', 'Concierto de Volos: II. The Sphynx', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18580 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eac72c3a-a2ca-4ccb-ae48-8b806aa3be7c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Bacchus Dance in Agria''s Beach', part.name_en = 'Concierto de Volos: III. Bacchus Dance in Agria''s Beach',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18580 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:2c7e1c28-8ae5-4f39-affe-61673c626e30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c7e1c28-8ae5-4f39-affe-61673c626e30', 3, 'III', 'Bacchus Dance in Agria''s Beach', 'Concierto de Volos: III. Bacchus Dance in Agria''s Beach', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18580 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c7e1c28-8ae5-4f39-affe-61673c626e30'
);


-- None Concierto para violín y orquesta

UPDATE pieces piece
SET piece.title = 'Concierto para violín y orquesta', piece.title_en = 'Concierto para violín y orquesta',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19861 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Toccata I', part.name_en = 'Concierto para violín y orquesta: I. Toccata I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19861 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:cd852e56-2de6-4951-92ca-ffbcfd5a68e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd852e56-2de6-4951-92ca-ffbcfd5a68e9', 1, 'I', 'Toccata I', 'Concierto para violín y orquesta: I. Toccata I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19861 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd852e56-2de6-4951-92ca-ffbcfd5a68e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Nocturno', part.name_en = 'Concierto para violín y orquesta: II. Nocturno',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19861 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:a7ef9cb8-3d14-4213-bd14-869d017c9162' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7ef9cb8-3d14-4213-bd14-869d017c9162', 2, 'II', 'Nocturno', 'Concierto para violín y orquesta: II. Nocturno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19861 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7ef9cb8-3d14-4213-bd14-869d017c9162'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Toccata II', part.name_en = 'Concierto para violín y orquesta: III. Toccata II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19861 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:a18dd47a-202e-4579-b023-65ae65a43620' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a18dd47a-202e-4579-b023-65ae65a43620', 3, 'III', 'Toccata II', 'Concierto para violín y orquesta: III. Toccata II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19861 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a18dd47a-202e-4579-b023-65ae65a43620'
);


-- None Conmutaciones

UPDATE pieces piece
SET piece.title = 'Conmutaciones', piece.title_en = 'Conmutaciones',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16760 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Danza característica

UPDATE pieces piece
SET piece.title = 'Danza característica', piece.title_en = 'Danza característica',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18227 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Danzas rituales y festivas (First Series)

UPDATE pieces piece
SET piece.title = 'Danzas rituales y festivas (First Series)', piece.title_en = 'Danzas rituales y festivas (First Series)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16566 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Danza de los altos cerros', part.name_en = 'Danzas rituales y festivas (First Series): I. Danza de los altos cerros',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16566 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:e610d98e-6167-4b9f-ae78-2097d8efe66c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e610d98e-6167-4b9f-ae78-2097d8efe66c', 1, 'I', 'Danza de los altos cerros', 'Danzas rituales y festivas (First Series): I. Danza de los altos cerros', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16566 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e610d98e-6167-4b9f-ae78-2097d8efe66c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Habanera trunca', part.name_en = 'Danzas rituales y festivas (First Series): II. Habanera trunca',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16566 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:ad4ef219-b15b-4c36-84a5-d471f5173936' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad4ef219-b15b-4c36-84a5-d471f5173936', 2, 'II', 'Habanera trunca', 'Danzas rituales y festivas (First Series): II. Habanera trunca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16566 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad4ef219-b15b-4c36-84a5-d471f5173936'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Guajira', part.name_en = 'Danzas rituales y festivas (First Series): III. Guajira',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16566 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:086a3d2a-bc44-48de-86ee-0ba242255ae2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:086a3d2a-bc44-48de-86ee-0ba242255ae2', 3, 'III', 'Guajira', 'Danzas rituales y festivas (First Series): III. Guajira', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16566 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:086a3d2a-bc44-48de-86ee-0ba242255ae2'
);


-- None Dos aires populares cubanos

UPDATE pieces piece
SET piece.title = 'Dos aires populares cubanos', piece.title_en = 'Dos aires populares cubanos',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18177 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Guajira criolla', part.name_en = 'Dos aires populares cubanos: No. 1. Guajira criolla',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18177 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:3e9df275-1af1-3a95-9762-aa4256ffa788' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e9df275-1af1-3a95-9762-aa4256ffa788', 1, NULL, 'Guajira criolla', 'Dos aires populares cubanos: No. 1. Guajira criolla', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18177 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e9df275-1af1-3a95-9762-aa4256ffa788'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Zapateado', part.name_en = 'Dos aires populares cubanos: No. 2. Zapateado',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18177 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:dffa1714-386b-4ab1-b847-f1b620e0be46' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dffa1714-386b-4ab1-b847-f1b620e0be46', 2, NULL, 'Zapateado', 'Dos aires populares cubanos: No. 2. Zapateado', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18177 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dffa1714-386b-4ab1-b847-f1b620e0be46'
);


-- None Dos conceptos del tiempo

UPDATE pieces piece
SET piece.title = 'Dos conceptos del tiempo', piece.title_en = 'Dos conceptos del tiempo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19162 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dr. Brown's Theme

UPDATE pieces piece
SET piece.title = 'Dr. Brown''s Theme', piece.title_en = 'Dr. Brown''s Theme',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16185 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None El arpa y la sombra (Omaggio a Toru Takemitsu)

UPDATE pieces piece
SET piece.title = 'El arpa y la sombra (Omaggio a Toru Takemitsu)', piece.title_en = 'El arpa y la sombra (Omaggio a Toru Takemitsu)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19201 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None El decamerón negro

UPDATE pieces piece
SET piece.title = 'El decamerón negro', piece.title_en = 'El decamerón negro',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18831 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'El arpa del guerrero', part.name_en = 'El decamerón negro: I. El arpa del guerrero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18831 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:a4a4d747-6f16-30d2-b8ef-587944106b0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4a4d747-6f16-30d2-b8ef-587944106b0b', 1, 'I', 'El arpa del guerrero', 'El decamerón negro: I. El arpa del guerrero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18831 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4a4d747-6f16-30d2-b8ef-587944106b0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'La huída de los amantes por el valle de los ecos', part.name_en = 'El decamerón negro: II. La huída de los amantes por el valle de los ecos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18831 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:fb40e500-fedb-3291-8d4a-e98b3df79b03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb40e500-fedb-3291-8d4a-e98b3df79b03', 2, 'II', 'La huída de los amantes por el valle de los ecos', 'El decamerón negro: II. La huída de los amantes por el valle de los ecos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18831 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb40e500-fedb-3291-8d4a-e98b3df79b03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Ballada de la doncella enamorada', part.name_en = 'El decamerón negro: III. Ballada de la doncella enamorada',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18831 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:dfe43172-ff97-3907-bf24-a49693b58871' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfe43172-ff97-3907-bf24-a49693b58871', 3, 'III', 'Ballada de la doncella enamorada', 'El decamerón negro: III. Ballada de la doncella enamorada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18831 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfe43172-ff97-3907-bf24-a49693b58871'
);


-- None Elogio de la danza

UPDATE pieces piece
SET piece.title = 'Elogio de la danza', piece.title_en = 'Elogio de la danza',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18719 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lento', part.name_en = 'Elogio de la danza: I. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18719 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:98e02b17-5024-3e51-9554-74bb96296c29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98e02b17-5024-3e51-9554-74bb96296c29', 1, 'I', 'Lento', 'Elogio de la danza: I. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18719 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98e02b17-5024-3e51-9554-74bb96296c29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Obstinato', part.name_en = 'Elogio de la danza: II. Obstinato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18719 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:c776c5f8-a162-383d-ad62-111f6fdefc9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c776c5f8-a162-383d-ad62-111f6fdefc9f', 2, 'II', 'Obstinato', 'Elogio de la danza: II. Obstinato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18719 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c776c5f8-a162-383d-ad62-111f6fdefc9f'
);


-- None English Folk Songs

UPDATE pieces piece
SET piece.title = 'English Folk Songs', piece.title_en = 'English Folk Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17710 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'O Waly Waly', part.name_en = 'English Folk Songs: O Waly Waly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17710 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:122d3e00-d328-4d5f-ab43-ec44f00fa8ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:122d3e00-d328-4d5f-ab43-ec44f00fa8ab', 1, NULL, 'O Waly Waly', 'English Folk Songs: O Waly Waly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17710 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:122d3e00-d328-4d5f-ab43-ec44f00fa8ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'I Am a Poor Wayfaring Stranger', part.name_en = 'English Folk Songs: I Am a Poor Wayfaring Stranger',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17710 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:d0367847-6045-44a0-84eb-b1f4f5a50c80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0367847-6045-44a0-84eb-b1f4f5a50c80', 2, NULL, 'I Am a Poor Wayfaring Stranger', 'English Folk Songs: I Am a Poor Wayfaring Stranger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17710 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0367847-6045-44a0-84eb-b1f4f5a50c80'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Down by the Salley Gardens', part.name_en = 'English Folk Songs: Down by the Salley Gardens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17710 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:fc18519d-0638-4816-b493-21dbd4e6a1d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc18519d-0638-4816-b493-21dbd4e6a1d2', 3, NULL, 'Down by the Salley Gardens', 'English Folk Songs: Down by the Salley Gardens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17710 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc18519d-0638-4816-b493-21dbd4e6a1d2'
);


-- None Estudios sencillos

UPDATE pieces piece
SET piece.title = 'Estudios sencillos', piece.title_en = 'Estudios sencillos',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17119 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Movido', part.name_en = 'Estudios sencillos: No. 1. Movido',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17119 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:a4224b45-2ea2-419d-a828-e043e735b460' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4224b45-2ea2-419d-a828-e043e735b460', 1, NULL, 'Movido', 'Estudios sencillos: No. 1. Movido', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17119 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4224b45-2ea2-419d-a828-e043e735b460'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Lento', part.name_en = 'Estudios sencillos: No. 2. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17119 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:6e7e8b10-323e-4e01-b30f-1ef957dd8094' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e7e8b10-323e-4e01-b30f-1ef957dd8094', 2, NULL, 'Lento', 'Estudios sencillos: No. 2. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17119 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e7e8b10-323e-4e01-b30f-1ef957dd8094'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Rápido', part.name_en = 'Estudios sencillos: No. 3. Rápido',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17119 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:25590ba9-7fd8-476b-b070-7e18e00c6209' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25590ba9-7fd8-476b-b070-7e18e00c6209', 3, NULL, 'Rápido', 'Estudios sencillos: No. 3. Rápido', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17119 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25590ba9-7fd8-476b-b070-7e18e00c6209'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Comodo. Allegretto', part.name_en = 'Estudios sencillos: No. 4. Comodo. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17119 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:d651fe42-bf77-46b0-8c3e-f870f8cb1279' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d651fe42-bf77-46b0-8c3e-f870f8cb1279', 4, NULL, 'Comodo. Allegretto', 'Estudios sencillos: No. 4. Comodo. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17119 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d651fe42-bf77-46b0-8c3e-f870f8cb1279'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Allegretto (Montuno)', part.name_en = 'Estudios sencillos: No. 5. Allegretto (Montuno)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17119 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:65e08322-9e52-430c-b479-6b6ddf716eec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65e08322-9e52-430c-b479-6b6ddf716eec', 5, NULL, 'Allegretto (Montuno)', 'Estudios sencillos: No. 5. Allegretto (Montuno)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17119 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65e08322-9e52-430c-b479-6b6ddf716eec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '—', part.name_en = 'Estudios sencillos: No. 6. —',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17119 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:b43d0183-8018-4f34-be48-c1ac5c97fe19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b43d0183-8018-4f34-be48-c1ac5c97fe19', 6, NULL, '—', 'Estudios sencillos: No. 6. —', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17119 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b43d0183-8018-4f34-be48-c1ac5c97fe19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Lo más rápido posible', part.name_en = 'Estudios sencillos: No. 7. Lo más rápido posible',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17119 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:c83812ef-51e4-41c7-820a-16086ece3b12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c83812ef-51e4-41c7-820a-16086ece3b12', 7, NULL, 'Lo más rápido posible', 'Estudios sencillos: No. 7. Lo más rápido posible', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17119 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c83812ef-51e4-41c7-820a-16086ece3b12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Tranquillo', part.name_en = 'Estudios sencillos: No. 8. Tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17119 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:cadcece0-286c-4ac2-9907-a567f402f9f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cadcece0-286c-4ac2-9907-a567f402f9f5', 8, NULL, 'Tranquillo', 'Estudios sencillos: No. 8. Tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17119 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cadcece0-286c-4ac2-9907-a567f402f9f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Scherzo', part.name_en = 'Estudios sencillos: No. 9. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17119 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:9e91634d-e426-4343-ab67-09c4230ffea9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e91634d-e426-4343-ab67-09c4230ffea9', 9, NULL, 'Scherzo', 'Estudios sencillos: No. 9. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17119 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e91634d-e426-4343-ab67-09c4230ffea9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '—', part.name_en = 'Estudios sencillos: No. 10. —',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17119 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:f559b9a3-07d5-4210-806f-e2f5a2b6055c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f559b9a3-07d5-4210-806f-e2f5a2b6055c', 10, NULL, '—', 'Estudios sencillos: No. 10. —', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17119 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f559b9a3-07d5-4210-806f-e2f5a2b6055c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Estudios sencillos: No. 11. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17119 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:7766de3b-df15-4594-8801-0c2a1ca8812b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7766de3b-df15-4594-8801-0c2a1ca8812b', 11, NULL, 'Allegretto', 'Estudios sencillos: No. 11. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17119 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7766de3b-df15-4594-8801-0c2a1ca8812b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Tranquillo. Moderato', part.name_en = 'Estudios sencillos: No. 12. Tranquillo. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17119 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:d3e9f151-1696-4ada-8e7e-a7899fb5fb2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3e9f151-1696-4ada-8e7e-a7899fb5fb2a', 12, NULL, 'Tranquillo. Moderato', 'Estudios sencillos: No. 12. Tranquillo. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17119 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3e9f151-1696-4ada-8e7e-a7899fb5fb2a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Movido', part.name_en = 'Estudios sencillos: No. 13. Movido',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17119 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:92a56241-e820-4e45-bb9b-8b6e5a36b6f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92a56241-e820-4e45-bb9b-8b6e5a36b6f0', 13, NULL, 'Movido', 'Estudios sencillos: No. 13. Movido', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17119 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92a56241-e820-4e45-bb9b-8b6e5a36b6f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Allegro', part.name_en = 'Estudios sencillos: No. 14. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17119 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:4728384f-1e5a-4cde-805f-41bad8e73483' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4728384f-1e5a-4cde-805f-41bad8e73483', 14, NULL, 'Allegro', 'Estudios sencillos: No. 14. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17119 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4728384f-1e5a-4cde-805f-41bad8e73483'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Sarabande', part.name_en = 'Estudios sencillos: No. 15. Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17119 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:31130a5d-c855-4e70-93c0-9fa96f712743' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31130a5d-c855-4e70-93c0-9fa96f712743', 15, NULL, 'Sarabande', 'Estudios sencillos: No. 15. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17119 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31130a5d-c855-4e70-93c0-9fa96f712743'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Grave', part.name_en = 'Estudios sencillos: No. 16. Grave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17119 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:07d8f464-0b5b-4014-80f7-e4286e5234b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07d8f464-0b5b-4014-80f7-e4286e5234b6', 16, NULL, 'Grave', 'Estudios sencillos: No. 16. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17119 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07d8f464-0b5b-4014-80f7-e4286e5234b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Moderato', part.name_en = 'Estudios sencillos: No. 17. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17119 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:2a50995c-8c50-43d6-be73-ddaddaa54134' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a50995c-8c50-43d6-be73-ddaddaa54134', 17, NULL, 'Moderato', 'Estudios sencillos: No. 17. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17119 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a50995c-8c50-43d6-be73-ddaddaa54134'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Moderato quasi lento', part.name_en = 'Estudios sencillos: No. 18. Moderato quasi lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17119 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:029da96e-21d1-4658-a41d-4b7577120af0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:029da96e-21d1-4658-a41d-4b7577120af0', 18, NULL, 'Moderato quasi lento', 'Estudios sencillos: No. 18. Moderato quasi lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17119 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:029da96e-21d1-4658-a41d-4b7577120af0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Movido. Allegretto', part.name_en = 'Estudios sencillos: No. 19. Movido. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17119 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:10c087bc-e826-4177-8c93-291f667aa0f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10c087bc-e826-4177-8c93-291f667aa0f8', 19, NULL, 'Movido. Allegretto', 'Estudios sencillos: No. 19. Movido. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17119 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10c087bc-e826-4177-8c93-291f667aa0f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Movido. Rápido', part.name_en = 'Estudios sencillos: No. 20. Movido. Rápido',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17119 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:147e951d-9ea8-4431-a697-45d3eb48c108' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:147e951d-9ea8-4431-a697-45d3eb48c108', 20, NULL, 'Movido. Rápido', 'Estudios sencillos: No. 20. Movido. Rápido', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17119 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:147e951d-9ea8-4431-a697-45d3eb48c108'
);


-- None 연습곡 6번

UPDATE pieces piece
SET piece.title = '연습곡 6번', piece.title_en = 'Etude no. 6',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18004 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Exaedros I

UPDATE pieces piece
SET piece.title = 'Exaedros I', piece.title_en = 'Exaedros I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18119 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 푸가 1번

UPDATE pieces piece
SET piece.title = '푸가 1번', piece.title_en = 'Fuga N°1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18317 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 기타 협주곡 5번 "Helsinki"

UPDATE pieces piece
SET piece.title = '기타 협주곡 5번 "Helsinki"', piece.title_en = 'Guitar Concerto no. 5 "Helsinki"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17901 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Spaces', part.name_en = 'Guitar Concerto no. 5 "Helsinki": I. Spaces',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17901 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:6ac46ba9-728e-4dd5-997f-c46f698802cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ac46ba9-728e-4dd5-997f-c46f698802cc', 1, 'I', 'Spaces', 'Guitar Concerto no. 5 "Helsinki": I. Spaces', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17901 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ac46ba9-728e-4dd5-997f-c46f698802cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lightness and Heaviness', part.name_en = 'Guitar Concerto no. 5 "Helsinki": II. Lightness and Heaviness',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17901 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:4272f9cd-7a31-4adc-a8d6-33d7ff529cae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4272f9cd-7a31-4adc-a8d6-33d7ff529cae', 2, 'II', 'Lightness and Heaviness', 'Guitar Concerto no. 5 "Helsinki": II. Lightness and Heaviness', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17901 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4272f9cd-7a31-4adc-a8d6-33d7ff529cae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Luminosity', part.name_en = 'Guitar Concerto no. 5 "Helsinki": III. Luminosity',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17901 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:5805ea44-85d5-4e53-a19a-0597310e4d9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5805ea44-85d5-4e53-a19a-0597310e4d9b', 3, 'III', 'Luminosity', 'Guitar Concerto no. 5 "Helsinki": III. Luminosity', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17901 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5805ea44-85d5-4e53-a19a-0597310e4d9b'
);


-- None Hika "In Memorium Toru Takemitsu"

UPDATE pieces piece
SET piece.title = 'Hika "In Memorium Toru Takemitsu"', piece.title_en = 'Hika "In Memorium Toru Takemitsu"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16875 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hoja de álbum "La gota de agua"

UPDATE pieces piece
SET piece.title = 'Hoja de álbum "La gota de agua"', piece.title_en = 'Hoja de álbum "La gota de agua"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18768 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Jesusita en chihuahua (Little Jesus in Chihuahua)

UPDATE pieces piece
SET piece.title = 'Jesusita en chihuahua (Little Jesus in Chihuahua)', piece.title_en = 'Jesusita en chihuahua (Little Jesus in Chihuahua)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16997 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La ciudad de las columnas

UPDATE pieces piece
SET piece.title = 'La ciudad de las columnas', piece.title_en = 'La ciudad de las columnas',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17032 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introducción (quasi lento)', part.name_en = 'La ciudad de las columnas: Introducción (quasi lento)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17032 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:514bf5b3-3956-47e1-8c3b-70a0506f4452' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:514bf5b3-3956-47e1-8c3b-70a0506f4452', 1, NULL, 'Introducción (quasi lento)', 'La ciudad de las columnas: Introducción (quasi lento)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17032 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:514bf5b3-3956-47e1-8c3b-70a0506f4452'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Andar la Habana', part.name_en = 'La ciudad de las columnas: I. Andar la Habana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17032 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:4e8c0e0a-de9c-4c59-a172-57d4028ecd21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e8c0e0a-de9c-4c59-a172-57d4028ecd21', 2, NULL, 'Andar la Habana', 'La ciudad de las columnas: I. Andar la Habana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17032 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e8c0e0a-de9c-4c59-a172-57d4028ecd21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La ceiba y el colibrí', part.name_en = 'La ciudad de las columnas: II. La ceiba y el colibrí',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17032 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:19576b5f-d6d4-423e-9a36-a0de47936a7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19576b5f-d6d4-423e-9a36-a0de47936a7a', 3, NULL, 'La ceiba y el colibrí', 'La ciudad de las columnas: II. La ceiba y el colibrí', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17032 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19576b5f-d6d4-423e-9a36-a0de47936a7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Convento de San Francisco', part.name_en = 'La ciudad de las columnas: III. Convento de San Francisco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17032 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:7523832e-ee6c-42a1-a25b-79be609135fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7523832e-ee6c-42a1-a25b-79be609135fa', 4, NULL, 'Convento de San Francisco', 'La ciudad de las columnas: III. Convento de San Francisco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17032 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7523832e-ee6c-42a1-a25b-79be609135fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Por la Calle del Obispo', part.name_en = 'La ciudad de las columnas: IV. Por la Calle del Obispo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17032 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:e2bda7a3-5a22-4780-a714-eddedc51578e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2bda7a3-5a22-4780-a714-eddedc51578e', 5, NULL, 'Por la Calle del Obispo', 'La ciudad de las columnas: IV. Por la Calle del Obispo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17032 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2bda7a3-5a22-4780-a714-eddedc51578e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Amanecer en el Morro', part.name_en = 'La ciudad de las columnas: V. Amanecer en el Morro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17032 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:cbcf7587-ab67-4496-a89d-71ae270dd2c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbcf7587-ab67-4496-a89d-71ae270dd2c8', 6, NULL, 'Amanecer en el Morro', 'La ciudad de las columnas: V. Amanecer en el Morro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17032 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbcf7587-ab67-4496-a89d-71ae270dd2c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Toque en la Plaza de armas', part.name_en = 'La ciudad de las columnas: VI. Toque en la Plaza de armas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17032 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:e2343d26-eb7a-411e-b623-f503286bcd6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2343d26-eb7a-411e-b623-f503286bcd6d', 7, NULL, 'Toque en la Plaza de armas', 'La ciudad de las columnas: VI. Toque en la Plaza de armas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17032 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2343d26-eb7a-411e-b623-f503286bcd6d'
);


-- None La espiral eterna

UPDATE pieces piece
SET piece.title = 'La espiral eterna', piece.title_en = 'La espiral eterna',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15746 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La tradición se rompe… pero cuesta trabajo

UPDATE pieces piece
SET piece.title = 'La tradición se rompe… pero cuesta trabajo', piece.title_en = 'La tradición se rompe… pero cuesta trabajo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16049 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Las Cíclades arcaicas

UPDATE pieces piece
SET piece.title = 'Las Cíclades arcaicas', piece.title_en = 'Las Cíclades arcaicas',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16770 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Laude al Árbol Gigante

UPDATE pieces piece
SET piece.title = 'Laude al Árbol Gigante', piece.title_en = 'Laude al Árbol Gigante',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16573 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mi Carro Ford (My Ford)

UPDATE pieces piece
SET piece.title = 'Mi Carro Ford (My Ford)', piece.title_en = 'Mi Carro Ford (My Ford)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17753 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mi querido capitan (My Dear Captain)

UPDATE pieces piece
SET piece.title = 'Mi querido capitan (My Dear Captain)', piece.title_en = 'Mi querido capitan (My Dear Captain)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17911 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Mi sento solo>

UPDATE pieces piece
SET piece.title = '가곡 <Mi sento solo>', piece.title_en = 'Mi sento solo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16953 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Micro Piezas for Two Guitars

UPDATE pieces piece
SET piece.title = 'Micro Piezas for Two Guitars', piece.title_en = 'Micro Piezas for Two Guitars',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18970 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Tranquillo', part.name_en = 'Micro Piezas: I. Tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18970 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:0617698b-bccb-4bad-b75b-a7278972de9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0617698b-bccb-4bad-b75b-a7278972de9d', 1, 'I', 'Tranquillo', 'Micro Piezas: I. Tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18970 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0617698b-bccb-4bad-b75b-a7278972de9d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro Vivace', part.name_en = 'Micro Piezas: II. Allegro Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18970 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:74a70397-65cb-4713-abb8-7afd1c24afd9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74a70397-65cb-4713-abb8-7afd1c24afd9', 2, 'II', 'Allegro Vivace', 'Micro Piezas: II. Allegro Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18970 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74a70397-65cb-4713-abb8-7afd1c24afd9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivacissimo Muy Ritmico', part.name_en = 'Micro Piezas: III. Vivacissimo Muy Ritmico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18970 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:c919dc55-ba93-4311-8990-d4973c0801ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c919dc55-ba93-4311-8990-d4973c0801ea', 3, 'III', 'Vivacissimo Muy Ritmico', 'Micro Piezas: III. Vivacissimo Muy Ritmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18970 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c919dc55-ba93-4311-8990-d4973c0801ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sonoro', part.name_en = 'Micro Piezas: IV. Sonoro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18970 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:71be6cd1-aa46-4515-872d-5e5c6b8d88cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71be6cd1-aa46-4515-872d-5e5c6b8d88cc', 4, 'IV', 'Sonoro', 'Micro Piezas: IV. Sonoro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18970 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71be6cd1-aa46-4515-872d-5e5c6b8d88cc'
);


-- None Micropiezas

UPDATE pieces piece
SET piece.title = 'Micropiezas', piece.title_en = 'Micropiezas',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17193 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tranquillo', part.name_en = 'Micropiezas: No. 1. Tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17193 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:84d368b6-6249-48ce-9194-f5dc794501bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84d368b6-6249-48ce-9194-f5dc794501bc', 1, NULL, 'Tranquillo', 'Micropiezas: No. 1. Tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17193 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84d368b6-6249-48ce-9194-f5dc794501bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro vivace', part.name_en = 'Micropiezas: No. 2. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17193 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:089ed168-5dcb-472c-ad00-c413adff8797' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:089ed168-5dcb-472c-ad00-c413adff8797', 2, NULL, 'Allegro vivace', 'Micropiezas: No. 2. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17193 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:089ed168-5dcb-472c-ad00-c413adff8797'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Vivacissimo muy rítmico', part.name_en = 'Micropiezas: No. 3. Vivacissimo muy rítmico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17193 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:5772f856-4982-48b7-81e9-8e4442fea124' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5772f856-4982-48b7-81e9-8e4442fea124', 3, NULL, 'Vivacissimo muy rítmico', 'Micropiezas: No. 3. Vivacissimo muy rítmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17193 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5772f856-4982-48b7-81e9-8e4442fea124'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'No. 4', part.name_en = 'Micropiezas: No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17193 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:97b6c028-648b-49ca-8b41-9754c2e97f70' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97b6c028-648b-49ca-8b41-9754c2e97f70', 4, NULL, 'No. 4', 'Micropiezas: No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17193 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97b6c028-648b-49ca-8b41-9754c2e97f70'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Andante tranquillo', part.name_en = 'Micropiezas: No. 5. Andante tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17193 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:4ce772f6-8f4f-4181-9025-5bfffd17326b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ce772f6-8f4f-4181-9025-5bfffd17326b', 5, NULL, 'Andante tranquillo', 'Micropiezas: No. 5. Andante tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17193 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ce772f6-8f4f-4181-9025-5bfffd17326b'
);


-- None Música incidental campesina

UPDATE pieces piece
SET piece.title = 'Música incidental campesina', piece.title_en = 'Música incidental campesina',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16085 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Preludio', part.name_en = 'Música incidental campesina: I. Preludio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16085 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:b791e94e-0b05-4a14-9c26-a96ac90a2448' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b791e94e-0b05-4a14-9c26-a96ac90a2448', 1, 'I', 'Preludio', 'Música incidental campesina: I. Preludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16085 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b791e94e-0b05-4a14-9c26-a96ac90a2448'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Interludio', part.name_en = 'Música incidental campesina: II. Interludio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16085 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:738b5404-43e5-4835-854a-4cdfad45a86b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:738b5404-43e5-4835-854a-4cdfad45a86b', 2, 'II', 'Interludio', 'Música incidental campesina: II. Interludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16085 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:738b5404-43e5-4835-854a-4cdfad45a86b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Danza', part.name_en = 'Música incidental campesina: III. Danza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16085 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:d8f03483-cec6-4d62-a713-60c24ca4e01f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8f03483-cec6-4d62-a713-60c24ca4e01f', 3, 'III', 'Danza', 'Música incidental campesina: III. Danza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16085 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8f03483-cec6-4d62-a713-60c24ca4e01f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Final', part.name_en = 'Música incidental campesina: IV. Final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16085 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:5480e8ea-8221-41f4-903e-7ec81751a0d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5480e8ea-8221-41f4-903e-7ec81751a0d5', 4, 'IV', 'Final', 'Música incidental campesina: IV. Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16085 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5480e8ea-8221-41f4-903e-7ec81751a0d5'
);


-- None Nacha's Theme

UPDATE pieces piece
SET piece.title = 'Nacha''s Theme', piece.title_en = 'Nacha''s Theme',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17101 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Nuevos estudios sencillos

UPDATE pieces piece
SET piece.title = 'Nuevos estudios sencillos', piece.title_en = 'Nuevos estudios sencillos',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18043 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Omaggio a Debussy', part.name_en = 'Nuevos estudios sencillos: I. Omaggio a Debussy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18043 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:6edcf204-52bf-42ff-bed3-ba6f254887b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6edcf204-52bf-42ff-bed3-ba6f254887b0', 1, 'I', 'Omaggio a Debussy', 'Nuevos estudios sencillos: I. Omaggio a Debussy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18043 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6edcf204-52bf-42ff-bed3-ba6f254887b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Omaggio a Mangoré', part.name_en = 'Nuevos estudios sencillos: II. Omaggio a Mangoré',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18043 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:b455307d-3a2c-4e0b-a244-02a78301f29e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b455307d-3a2c-4e0b-a244-02a78301f29e', 2, 'II', 'Omaggio a Mangoré', 'Nuevos estudios sencillos: II. Omaggio a Mangoré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18043 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b455307d-3a2c-4e0b-a244-02a78301f29e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Omaggio a Caturla', part.name_en = 'Nuevos estudios sencillos: III. Omaggio a Caturla',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18043 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:af1a36fc-290b-4822-9fd8-d36bf1b6d5be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af1a36fc-290b-4822-9fd8-d36bf1b6d5be', 3, 'III', 'Omaggio a Caturla', 'Nuevos estudios sencillos: III. Omaggio a Caturla', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18043 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af1a36fc-290b-4822-9fd8-d36bf1b6d5be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Omaggio a Prokofiev', part.name_en = 'Nuevos estudios sencillos: IV. Omaggio a Prokofiev',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18043 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:7c988a76-b036-4aa1-9030-6cd6b5fb1d45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c988a76-b036-4aa1-9030-6cd6b5fb1d45', 4, 'IV', 'Omaggio a Prokofiev', 'Nuevos estudios sencillos: IV. Omaggio a Prokofiev', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18043 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c988a76-b036-4aa1-9030-6cd6b5fb1d45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Omaggio a Tárrega', part.name_en = 'Nuevos estudios sencillos: V. Omaggio a Tárrega',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18043 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:fd597f3f-f627-4ea3-bf61-6396ba54f277' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd597f3f-f627-4ea3-bf61-6396ba54f277', 5, 'V', 'Omaggio a Tárrega', 'Nuevos estudios sencillos: V. Omaggio a Tárrega', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18043 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd597f3f-f627-4ea3-bf61-6396ba54f277'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Omaggio a Sor', part.name_en = 'Nuevos estudios sencillos: VI. Omaggio a Sor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18043 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:49d6d99c-3c57-406a-b883-06e9bbdd7fed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49d6d99c-3c57-406a-b883-06e9bbdd7fed', 6, 'VI', 'Omaggio a Sor', 'Nuevos estudios sencillos: VI. Omaggio a Sor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18043 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49d6d99c-3c57-406a-b883-06e9bbdd7fed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Omaggio a Piazzolla', part.name_en = 'Nuevos estudios sencillos: VII. Omaggio a Piazzolla',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18043 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:8733e26b-c81b-4118-8865-e7224194c35a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8733e26b-c81b-4118-8865-e7224194c35a', 7, 'VII', 'Omaggio a Piazzolla', 'Nuevos estudios sencillos: VII. Omaggio a Piazzolla', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18043 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8733e26b-c81b-4118-8865-e7224194c35a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Omaggio a Villa-Lobos', part.name_en = 'Nuevos estudios sencillos: VIII. Omaggio a Villa-Lobos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18043 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:a21761fe-7e93-4cc7-83d2-93af8c804b5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a21761fe-7e93-4cc7-83d2-93af8c804b5a', 8, 'VIII', 'Omaggio a Villa-Lobos', 'Nuevos estudios sencillos: VIII. Omaggio a Villa-Lobos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18043 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a21761fe-7e93-4cc7-83d2-93af8c804b5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Omaggio a Szymanowski', part.name_en = 'Nuevos estudios sencillos: IX. Omaggio a Szymanowski',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18043 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:1f2174c6-8881-4fc9-9366-0c204ac104cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f2174c6-8881-4fc9-9366-0c204ac104cb', 9, 'IX', 'Omaggio a Szymanowski', 'Nuevos estudios sencillos: IX. Omaggio a Szymanowski', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18043 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f2174c6-8881-4fc9-9366-0c204ac104cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Omaggio a Stravinsky', part.name_en = 'Nuevos estudios sencillos: X. Omaggio a Stravinsky',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18043 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:69bf6941-df71-412e-94cf-e68e38cb59cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69bf6941-df71-412e-94cf-e68e38cb59cb', 10, 'X', 'Omaggio a Stravinsky', 'Nuevos estudios sencillos: X. Omaggio a Stravinsky', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18043 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69bf6941-df71-412e-94cf-e68e38cb59cb'
);


-- None Paisaje Cubano con campanas

UPDATE pieces piece
SET piece.title = 'Paisaje Cubano con campanas', piece.title_en = 'Paisaje Cubano con campanas',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17568 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Paisaje cubano con fiesta

UPDATE pieces piece
SET piece.title = 'Paisaje cubano con fiesta', piece.title_en = 'Paisaje cubano con fiesta',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16221 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Paisaje cubano con lluvia

UPDATE pieces piece
SET piece.title = 'Paisaje cubano con lluvia', piece.title_en = 'Paisaje cubano con lluvia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15811 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Paisaje cubano con rumba

UPDATE pieces piece
SET piece.title = 'Paisaje cubano con rumba', piece.title_en = 'Paisaje cubano con rumba',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19634 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Paisaje cubano con tristeza

UPDATE pieces piece
SET piece.title = 'Paisaje cubano con tristeza', piece.title_en = 'Paisaje cubano con tristeza',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16045 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Parábola

UPDATE pieces piece
SET piece.title = 'Parábola', piece.title_en = 'Parábola',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16765 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Per suonare a due

UPDATE pieces piece
SET piece.title = 'Per suonare a due', piece.title_en = 'Per suonare a due',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16619 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prologo o epilogo', part.name_en = 'Per suonare a due: I. Prologo o epilogo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16619 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:7296abd6-7198-4f71-832b-4f6689b36071' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7296abd6-7198-4f71-832b-4f6689b36071', 1, 'I', 'Prologo o epilogo', 'Per suonare a due: I. Prologo o epilogo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16619 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7296abd6-7198-4f71-832b-4f6689b36071'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Interludio', part.name_en = 'Per suonare a due: II. Interludio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16619 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:fce72f6c-f5eb-49c3-a7d2-914689e7c7b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fce72f6c-f5eb-49c3-a7d2-914689e7c7b7', 2, 'II', 'Interludio', 'Per suonare a due: II. Interludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16619 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fce72f6c-f5eb-49c3-a7d2-914689e7c7b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Grand Pas de Deux', part.name_en = 'Per suonare a due: III. Grand Pas de Deux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16619 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:03977176-b390-4938-bcee-35769dd600a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03977176-b390-4938-bcee-35769dd600a4', 3, 'III', 'Grand Pas de Deux', 'Per suonare a due: III. Grand Pas de Deux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16619 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03977176-b390-4938-bcee-35769dd600a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Prologo o epilogo II', part.name_en = 'Per suonare a due: IV. Prologo o epilogo II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16619 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:753ec9a4-bf5f-4c6d-aa05-539de849f9fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:753ec9a4-bf5f-4c6d-aa05-539de849f9fe', 4, 'IV', 'Prologo o epilogo II', 'Per suonare a due: IV. Prologo o epilogo II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16619 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:753ec9a4-bf5f-4c6d-aa05-539de849f9fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Scherzo di bravura', part.name_en = 'Per suonare a due: V. Scherzo di bravura',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16619 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:69c0ca2e-d66e-4fad-90f6-0170e548e6d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69c0ca2e-d66e-4fad-90f6-0170e548e6d9', 5, 'V', 'Scherzo di bravura', 'Per suonare a due: V. Scherzo di bravura', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16619 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69c0ca2e-d66e-4fad-90f6-0170e548e6d9'
);


-- None Piezas sin título

UPDATE pieces piece
SET piece.title = 'Piezas sin título', piece.title_en = 'Piezas sin título',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16782 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Piezas sin título: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16782 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:b3e1b018-7077-4797-a5eb-9b2b81eab25d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3e1b018-7077-4797-a5eb-9b2b81eab25d', 1, NULL, 'No. 1', 'Piezas sin título: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16782 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3e1b018-7077-4797-a5eb-9b2b81eab25d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Piezas sin título: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16782 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:bef7eea5-4e87-4252-8df1-c22867c8d2ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bef7eea5-4e87-4252-8df1-c22867c8d2ee', 2, NULL, 'No. 2', 'Piezas sin título: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16782 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bef7eea5-4e87-4252-8df1-c22867c8d2ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = 'Piezas sin título: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16782 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:ae2d9a09-9289-4d1d-b1fe-9cff1b635f82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae2d9a09-9289-4d1d-b1fe-9cff1b635f82', 3, NULL, 'No. 3', 'Piezas sin título: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16782 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae2d9a09-9289-4d1d-b1fe-9cff1b635f82'
);


-- None Preludios epigramáticos

UPDATE pieces piece
SET piece.title = 'Preludios epigramáticos', piece.title_en = 'Preludios epigramáticos',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16010 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Preludio epigramático no. 1', part.name_en = 'Preludio epigramático no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16010 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:d0a053aa-6755-38cd-8756-8b204ccf4365' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0a053aa-6755-38cd-8756-8b204ccf4365', 1, NULL, 'Preludio epigramático no. 1', 'Preludio epigramático no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16010 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0a053aa-6755-38cd-8756-8b204ccf4365'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Preludio epigramático no. 2', part.name_en = 'Preludio epigramático no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16010 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:058e9024-ea51-4bd4-9b11-f9dc9dc89a93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:058e9024-ea51-4bd4-9b11-f9dc9dc89a93', 2, NULL, 'Preludio epigramático no. 2', 'Preludio epigramático no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16010 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:058e9024-ea51-4bd4-9b11-f9dc9dc89a93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Preludio epigramático no. 3', part.name_en = 'Preludio epigramático no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16010 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:e4e8cebc-313c-4fdc-814b-96826abbf9d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4e8cebc-313c-4fdc-814b-96826abbf9d8', 3, NULL, 'Preludio epigramático no. 3', 'Preludio epigramático no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16010 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4e8cebc-313c-4fdc-814b-96826abbf9d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Preludio epigramático no. 4', part.name_en = 'Preludio epigramático no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16010 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:034b7d06-4ba4-474f-807d-8fa083670a78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:034b7d06-4ba4-474f-807d-8fa083670a78', 4, NULL, 'Preludio epigramático no. 4', 'Preludio epigramático no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16010 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:034b7d06-4ba4-474f-807d-8fa083670a78'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Preludio epigramático no. 5', part.name_en = 'Preludio epigramático no. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16010 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:dc63354a-f5ad-468b-af8c-2d2f39fc64f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc63354a-f5ad-468b-af8c-2d2f39fc64f2', 5, NULL, 'Preludio epigramático no. 5', 'Preludio epigramático no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16010 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc63354a-f5ad-468b-af8c-2d2f39fc64f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Preludio epigramático no. 6', part.name_en = 'Preludio epigramático no. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16010 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:e9314055-8d78-4b96-89e9-ff2be026a224' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9314055-8d78-4b96-89e9-ff2be026a224', 6, NULL, 'Preludio epigramático no. 6', 'Preludio epigramático no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16010 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9314055-8d78-4b96-89e9-ff2be026a224'
);


-- None Quail in Rose Petal Sauce (piano)

UPDATE pieces piece
SET piece.title = 'Quail in Rose Petal Sauce (piano)', piece.title_en = 'Quail in Rose Petal Sauce (piano)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16818 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quintet for String Quartet and Guitar

UPDATE pieces piece
SET piece.title = 'Quintet for String Quartet and Guitar', piece.title_en = 'Quintet for String Quartet and Guitar',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16661 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Quintetto: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16661 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:70136828-4cbd-4280-95d0-87499c039fe2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70136828-4cbd-4280-95d0-87499c039fe2', 1, 'I', 'Allegro', 'Quintetto: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16661 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70136828-4cbd-4280-95d0-87499c039fe2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '♩ = 60', part.name_en = 'Quintetto: II. ♩ = 60',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16661 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:d8a071f4-a76d-4a85-9854-2425670b7cbb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8a071f4-a76d-4a85-9854-2425670b7cbb', 2, 'II', '♩ = 60', 'Quintetto: II. ♩ = 60', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16661 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8a071f4-a76d-4a85-9854-2425670b7cbb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Finale. Allegro vivace', part.name_en = 'Quintetto: III. Finale. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16661 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:0562bb50-1fe4-42e6-8f6a-4b7a8d4d99dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0562bb50-1fe4-42e6-8f6a-4b7a8d4d99dc', 3, 'III', 'Finale. Allegro vivace', 'Quintetto: III. Finale. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16661 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0562bb50-1fe4-42e6-8f6a-4b7a8d4d99dc'
);


-- None Ranch Theme

UPDATE pieces piece
SET piece.title = 'Ranch Theme', piece.title_en = 'Ranch Theme',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16900 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rito de los Orishas

UPDATE pieces piece
SET piece.title = 'Rito de los Orishas', piece.title_en = 'Rito de los Orishas',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16836 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Exordium - Conjuro', part.name_en = 'Rito de los Orishas: I. Exordium - Conjuro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16836 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:b79ac836-8855-48a1-82f2-951e6601f4b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b79ac836-8855-48a1-82f2-951e6601f4b1', 1, 'I', 'Exordium - Conjuro', 'Rito de los Orishas: I. Exordium - Conjuro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16836 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b79ac836-8855-48a1-82f2-951e6601f4b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Danza de las diosas negras', part.name_en = 'Rito de los Orishas: II. Danza de las diosas negras',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16836 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:85f3fe8b-82cf-4041-a81f-f4e8bfbc47ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85f3fe8b-82cf-4041-a81f-f4e8bfbc47ce', 2, 'II', 'Danza de las diosas negras', 'Rito de los Orishas: II. Danza de las diosas negras', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16836 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85f3fe8b-82cf-4041-a81f-f4e8bfbc47ce'
);


-- None Son Mercedes

UPDATE pieces piece
SET piece.title = 'Son Mercedes', piece.title_en = 'Son Mercedes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18144 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 소나타

UPDATE pieces piece
SET piece.title = '소나타', piece.title_en = 'Sonata',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16577 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Fandangos y boleros', part.name_en = 'Sonata: I. Fandangos y boleros',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16577 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:85a3d1fa-edde-42f9-bc8e-4c20386a0538' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85a3d1fa-edde-42f9-bc8e-4c20386a0538', 1, 'I', 'Fandangos y boleros', 'Sonata: I. Fandangos y boleros', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16577 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85a3d1fa-edde-42f9-bc8e-4c20386a0538'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sarabanda de Scriabin', part.name_en = 'Sonata: II. Sarabanda de Scriabin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16577 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:3aa9389e-6465-4f63-b730-1c77e772ea36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3aa9389e-6465-4f63-b730-1c77e772ea36', 2, 'II', 'Sarabanda de Scriabin', 'Sonata: II. Sarabanda de Scriabin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16577 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3aa9389e-6465-4f63-b730-1c77e772ea36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'La Toccata de Pasquini', part.name_en = 'Sonata: III. La Toccata de Pasquini',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16577 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:6df893ec-45c0-446a-8f41-0f71b35ab477' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6df893ec-45c0-446a-8f41-0f71b35ab477', 3, 'III', 'La Toccata de Pasquini', 'Sonata: III. La Toccata de Pasquini', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16577 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6df893ec-45c0-446a-8f41-0f71b35ab477'
);


-- None Sonata de los viajeros

UPDATE pieces piece
SET piece.title = 'Sonata de los viajeros', piece.title_en = 'Sonata de los viajeros',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18126 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Primer viaje a tierras heladas', part.name_en = 'Sonata de los viajeros: I. Primer viaje a tierras heladas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18126 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:4fc1fcf8-52a4-46a1-b0fe-ebf3473342c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fc1fcf8-52a4-46a1-b0fe-ebf3473342c2', 1, 'I', 'Primer viaje a tierras heladas', 'Sonata de los viajeros: I. Primer viaje a tierras heladas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18126 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fc1fcf8-52a4-46a1-b0fe-ebf3473342c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'El retablo de las maravillas - La venus de Praxiteles', part.name_en = 'Sonata de los viajeros: II. El retablo de las maravillas - La venus de Praxiteles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18126 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:a44ec10e-370f-4bb4-b712-cdee80309451' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a44ec10e-370f-4bb4-b712-cdee80309451', 2, 'II', 'El retablo de las maravillas - La venus de Praxiteles', 'Sonata de los viajeros: II. El retablo de las maravillas - La venus de Praxiteles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18126 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a44ec10e-370f-4bb4-b712-cdee80309451'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Visita a Bach en Leipzig', part.name_en = 'Sonata de los viajeros: III. Visita a Bach en Leipzig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18126 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:49f9ec6c-a63e-4e34-a3d4-28e29d856243' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49f9ec6c-a63e-4e34-a3d4-28e29d856243', 3, 'III', 'Visita a Bach en Leipzig', 'Sonata de los viajeros: III. Visita a Bach en Leipzig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18126 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49f9ec6c-a63e-4e34-a3d4-28e29d856243'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Por el mar de las Antillas', part.name_en = 'Sonata de los viajeros: IV. Por el mar de las Antillas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18126 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:4d43e4fb-5f64-4093-b959-d5c0cbf9ad14' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d43e4fb-5f64-4093-b959-d5c0cbf9ad14', 4, 'IV', 'Por el mar de las Antillas', 'Sonata de los viajeros: IV. Por el mar de las Antillas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18126 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d43e4fb-5f64-4093-b959-d5c0cbf9ad14'
);


-- None 소나타 2번 "del caminante"

UPDATE pieces piece
SET piece.title = '소나타 2번 "del caminante"', piece.title_en = 'Sonata no. 2 "del caminante"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17734 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Visión de la Amazonia', part.name_en = 'Sonata no. 2 "del caminante": I. Visión de la Amazonia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17734 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:4d24d6c2-e391-4736-8759-c187c78b7109' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d24d6c2-e391-4736-8759-c187c78b7109', 1, 'I', 'Visión de la Amazonia', 'Sonata no. 2 "del caminante": I. Visión de la Amazonia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17734 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d24d6c2-e391-4736-8759-c187c78b7109'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'El gran sertao', part.name_en = 'Sonata no. 2 "del caminante": II. El gran sertao',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17734 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:60f4e62e-5c01-41bb-b072-3f7fd141de99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60f4e62e-5c01-41bb-b072-3f7fd141de99', 2, 'II', 'El gran sertao', 'Sonata no. 2 "del caminante": II. El gran sertao', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17734 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60f4e62e-5c01-41bb-b072-3f7fd141de99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Danza festiva', part.name_en = 'Sonata no. 2 "del caminante": III. Danza festiva',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17734 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:d6027f75-1bd0-48b4-8845-66d57d2f2556' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6027f75-1bd0-48b4-8845-66d57d2f2556', 3, 'III', 'Danza festiva', 'Sonata no. 2 "del caminante": III. Danza festiva', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17734 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6027f75-1bd0-48b4-8845-66d57d2f2556'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Toccata nordestina', part.name_en = 'Sonata no. 2 "del caminante": IV. Toccata nordestina',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17734 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:b35163f8-4168-49ee-8448-b675dc305779' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b35163f8-4168-49ee-8448-b675dc305779', 4, 'IV', 'Toccata nordestina', 'Sonata no. 2 "del caminante": IV. Toccata nordestina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17734 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b35163f8-4168-49ee-8448-b675dc305779'
);


-- None 소나타 3번 "del Decamerón Negro"

UPDATE pieces piece
SET piece.title = '소나타 3번 "del Decamerón Negro"', piece.title_en = 'Sonata no. 3 "del Decamerón Negro"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19151 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Güijes y gnomos', part.name_en = 'Sonata no. 3 "del Decamerón Negro": I. Güijes y gnomos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19151 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:505ca232-a188-4fe0-a890-e83e247b4e34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:505ca232-a188-4fe0-a890-e83e247b4e34', 1, 'I', 'Güijes y gnomos', 'Sonata no. 3 "del Decamerón Negro": I. Güijes y gnomos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19151 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:505ca232-a188-4fe0-a890-e83e247b4e34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Treno por Oyá', part.name_en = 'Sonata no. 3 "del Decamerón Negro": II. Treno por Oyá',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19151 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:7faa436e-2385-4403-bf0d-2d895ac81a21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7faa436e-2385-4403-bf0d-2d895ac81a21', 2, 'II', 'Treno por Oyá', 'Sonata no. 3 "del Decamerón Negro": II. Treno por Oyá', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19151 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7faa436e-2385-4403-bf0d-2d895ac81a21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Burlesca del aire', part.name_en = 'Sonata no. 3 "del Decamerón Negro": III. Burlesca del aire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19151 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:dd0c8826-5305-42ad-84b2-374eb4fcd86f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd0c8826-5305-42ad-84b2-374eb4fcd86f', 3, 'III', 'Burlesca del aire', 'Sonata no. 3 "del Decamerón Negro": III. Burlesca del aire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19151 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd0c8826-5305-42ad-84b2-374eb4fcd86f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'La risa de los griots', part.name_en = 'Sonata no. 3 "del Decamerón Negro": IV. La risa de los griots',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19151 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:454b3f60-0a75-4455-8ec5-d402c1c35ce1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:454b3f60-0a75-4455-8ec5-d402c1c35ce1', 4, 'IV', 'La risa de los griots', 'Sonata no. 3 "del Decamerón Negro": IV. La risa de los griots', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19151 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:454b3f60-0a75-4455-8ec5-d402c1c35ce1'
);


-- None 소나타 4번 "del pensador"

UPDATE pieces piece
SET piece.title = '소나타 4번 "del pensador"', piece.title_en = 'Sonata no. 4 "del pensador"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17994 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Recuperación de la memoria', part.name_en = 'Sonata no. 4 "del pensador": I. Recuperación de la memoria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17994 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:66cea584-4a20-4356-8ed9-9fcb553cb877' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66cea584-4a20-4356-8ed9-9fcb553cb877', 1, 'I', 'Recuperación de la memoria', 'Sonata no. 4 "del pensador": I. Recuperación de la memoria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17994 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66cea584-4a20-4356-8ed9-9fcb553cb877'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Iluminaciones', part.name_en = 'Sonata no. 4 "del pensador": II. Iluminaciones',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17994 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:c1b6c515-e324-4e1e-9741-9a2a76bf7b1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1b6c515-e324-4e1e-9741-9a2a76bf7b1f', 2, 'II', 'Iluminaciones', 'Sonata no. 4 "del pensador": II. Iluminaciones', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17994 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1b6c515-e324-4e1e-9741-9a2a76bf7b1f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Elogio de la meditación', part.name_en = 'Sonata no. 4 "del pensador": III. Elogio de la meditación',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17994 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:80131b7e-b782-42fb-8c9c-eb25a3f30412' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80131b7e-b782-42fb-8c9c-eb25a3f30412', 3, 'III', 'Elogio de la meditación', 'Sonata no. 4 "del pensador": III. Elogio de la meditación', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17994 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80131b7e-b782-42fb-8c9c-eb25a3f30412'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Celebración de la memoria', part.name_en = 'Sonata no. 4 "del pensador": IV. Celebración de la memoria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17994 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:d03f9ff4-2879-45ec-86f4-00a4006111d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d03f9ff4-2879-45ec-86f4-00a4006111d5', 4, 'IV', 'Celebración de la memoria', 'Sonata no. 4 "del pensador": IV. Celebración de la memoria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17994 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d03f9ff4-2879-45ec-86f4-00a4006111d5'
);


-- None 소나타 5번 "Ars combinatoria"

UPDATE pieces piece
SET piece.title = '소나타 5번 "Ars combinatoria"', piece.title_en = 'Sonata no. 5 "Ars combinatoria"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18094 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Toccata', part.name_en = 'Sonata no. 5 "Ars combinatoria": I. Toccata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18094 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:966dbc0d-6a85-4446-b895-343d8e54b7df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:966dbc0d-6a85-4446-b895-343d8e54b7df', 1, 'I', 'Toccata', 'Sonata no. 5 "Ars combinatoria": I. Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18094 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:966dbc0d-6a85-4446-b895-343d8e54b7df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Fantasía que contrahaze la harpa', part.name_en = 'Sonata no. 5 "Ars combinatoria": II. Fantasía que contrahaze la harpa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18094 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:89edac0d-6e06-42a4-8efc-33a125aca1db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89edac0d-6e06-42a4-8efc-33a125aca1db', 2, 'II', 'Fantasía que contrahaze la harpa', 'Sonata no. 5 "Ars combinatoria": II. Fantasía que contrahaze la harpa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18094 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89edac0d-6e06-42a4-8efc-33a125aca1db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Finale', part.name_en = 'Sonata no. 5 "Ars combinatoria": III. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18094 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:591395bc-2ee8-4450-b582-fdf50fea92b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:591395bc-2ee8-4450-b582-fdf50fea92b6', 3, 'III', 'Finale', 'Sonata no. 5 "Ars combinatoria": III. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18094 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:591395bc-2ee8-4450-b582-fdf50fea92b6'
);


-- None 소나타 6번 "de los enigmas"

UPDATE pieces piece
SET piece.title = '소나타 6번 "de los enigmas"', piece.title_en = 'Sonata no. 6 "de los enigmas"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16768 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Preludio', part.name_en = 'Sonata no. 6 "de los enigmas": I. Preludio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16768 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:c92a75a9-cb1d-46ca-b6d6-c85b461243e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c92a75a9-cb1d-46ca-b6d6-c85b461243e1', 1, 'I', 'Preludio', 'Sonata no. 6 "de los enigmas": I. Preludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16768 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c92a75a9-cb1d-46ca-b6d6-c85b461243e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Pavana melancólica (con permiso de Luys de Milán)', part.name_en = 'Sonata no. 6 "de los enigmas": II. Pavana melancólica (con permiso de Luys de Milán)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16768 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:0725821f-4d91-45b0-9e46-a53e67601d76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0725821f-4d91-45b0-9e46-a53e67601d76', 2, 'II', 'Pavana melancólica (con permiso de Luys de Milán)', 'Sonata no. 6 "de los enigmas": II. Pavana melancólica (con permiso de Luys de Milán)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16768 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0725821f-4d91-45b0-9e46-a53e67601d76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Fantasía y toccata', part.name_en = 'Sonata no. 6 "de los enigmas": III. Fantasía y toccata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16768 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:dc27727b-220f-4740-ac9d-5147a2f5d391' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc27727b-220f-4740-ac9d-5147a2f5d391', 3, 'III', 'Fantasía y toccata', 'Sonata no. 6 "de los enigmas": III. Fantasía y toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16768 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc27727b-220f-4740-ac9d-5147a2f5d391'
);


-- None Sonograma III

UPDATE pieces piece
SET piece.title = 'Sonograma III', piece.title_en = 'Sonograma III',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17156 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 모음곡 1번 "Antigua"

UPDATE pieces piece
SET piece.title = '모음곡 1번 "Antigua"', piece.title_en = 'Suite no. 1 "Antigua"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17770 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Preludio', part.name_en = 'Suite no. 1 "Antigua": I. Preludio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17770 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:5734d202-259e-4b7b-bdf2-7ccffe62b9c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5734d202-259e-4b7b-bdf2-7ccffe62b9c2', 1, 'I', 'Preludio', 'Suite no. 1 "Antigua": I. Preludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17770 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5734d202-259e-4b7b-bdf2-7ccffe62b9c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Fuga', part.name_en = 'Suite no. 1 "Antigua": II. Fuga',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17770 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:aae491f5-caa0-48f9-82d9-43f5d89295e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aae491f5-caa0-48f9-82d9-43f5d89295e0', 2, 'II', 'Fuga', 'Suite no. 1 "Antigua": II. Fuga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17770 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aae491f5-caa0-48f9-82d9-43f5d89295e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sarabanda', part.name_en = 'Suite no. 1 "Antigua": III. Sarabanda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17770 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:42f90808-5ef9-4ddd-8651-5e44ad3c3fa4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42f90808-5ef9-4ddd-8651-5e44ad3c3fa4', 3, 'III', 'Sarabanda', 'Suite no. 1 "Antigua": III. Sarabanda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17770 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42f90808-5ef9-4ddd-8651-5e44ad3c3fa4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Giga', part.name_en = 'Suite no. 1 "Antigua": IV. Giga',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17770 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:8b1e0ed8-61cc-4fee-a4e4-f54490292c37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b1e0ed8-61cc-4fee-a4e4-f54490292c37', 4, 'IV', 'Giga', 'Suite no. 1 "Antigua": IV. Giga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17770 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b1e0ed8-61cc-4fee-a4e4-f54490292c37'
);


-- None 모음곡 2번 D장조

UPDATE pieces piece
SET piece.title = '모음곡 2번 D장조', piece.title_en = 'Suite no. 2 in D major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15999 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Preludio', part.name_en = 'Suite no. 2 in D major: I. Preludio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15999 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:2ec802da-e319-4a6d-a2fb-1dca099c0883' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ec802da-e319-4a6d-a2fb-1dca099c0883', 1, 'I', 'Preludio', 'Suite no. 2 in D major: I. Preludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15999 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ec802da-e319-4a6d-a2fb-1dca099c0883'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro burlesco', part.name_en = 'Suite no. 2 in D major: II. Allegro burlesco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15999 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:7badf2af-ffd2-4026-818b-975629ea0984' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7badf2af-ffd2-4026-818b-975629ea0984', 2, 'II', 'Allegro burlesco', 'Suite no. 2 in D major: II. Allegro burlesco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15999 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7badf2af-ffd2-4026-818b-975629ea0984'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andantino', part.name_en = 'Suite no. 2 in D major: III. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15999 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:750c0140-8485-4cf2-b93b-05f61e6e2e4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:750c0140-8485-4cf2-b93b-05f61e6e2e4d', 3, 'III', 'Andantino', 'Suite no. 2 in D major: III. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15999 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:750c0140-8485-4cf2-b93b-05f61e6e2e4d'
);


-- None Tarantos

UPDATE pieces piece
SET piece.title = 'Tarantos', piece.title_en = 'Tarantos',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18087 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tema de "El rancheador de la naturaleza"

UPDATE pieces piece
SET piece.title = 'Tema de "El rancheador de la naturaleza"', piece.title_en = 'Tema de "El rancheador de la naturaleza"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17685 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Book of Signs

UPDATE pieces piece
SET piece.title = 'The Book of Signs', piece.title_en = 'The Book of Signs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18666 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The Signs of Memory (Theme and Variations)', part.name_en = 'The Book of Signs: I. The Signs of Memory (Theme and Variations)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18666 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:6340f820-e97d-4c39-a089-b844d2fdf63b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6340f820-e97d-4c39-a089-b844d2fdf63b', 1, 'I', 'The Signs of Memory (Theme and Variations)', 'The Book of Signs: I. The Signs of Memory (Theme and Variations)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18666 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6340f820-e97d-4c39-a089-b844d2fdf63b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Variaciones sobre un tema sentimental', part.name_en = 'The Book of Signs: II. Variaciones sobre un tema sentimental',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18666 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:8d3d919c-172a-46aa-bed7-44777bbf3c7c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d3d919c-172a-46aa-bed7-44777bbf3c7c', 2, 'II', 'Variaciones sobre un tema sentimental', 'The Book of Signs: II. Variaciones sobre un tema sentimental', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18666 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d3d919c-172a-46aa-bed7-44777bbf3c7c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'The Book of Signs: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18666 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:f11cd729-838c-4d46-a477-4e7854bddbd7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f11cd729-838c-4d46-a477-4e7854bddbd7', 3, 'III', 'Allegro', 'The Book of Signs: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18666 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f11cd729-838c-4d46-a477-4e7854bddbd7'
);


-- None The Circle Game (after Margaret Atwood)

UPDATE pieces piece
SET piece.title = 'The Circle Game (after Margaret Atwood)', piece.title_en = 'The Circle Game (after Margaret Atwood)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16610 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Kidnapping of Gertrudis

UPDATE pieces piece
SET piece.title = 'The Kidnapping of Gertrudis', piece.title_en = 'The Kidnapping of Gertrudis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19112 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Theme of Tita Knitting

UPDATE pieces piece
SET piece.title = 'Theme of Tita Knitting', piece.title_en = 'Theme of Tita Knitting',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18091 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tita and Pedro's Love Theme

UPDATE pieces piece
SET piece.title = 'Tita and Pedro''s Love Theme', piece.title_en = 'Tita and Pedro''s Love Theme',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17590 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tita's Theme (piano)

UPDATE pieces piece
SET piece.title = 'Tita''s Theme (piano)', piece.title_en = 'Tita''s Theme (piano)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16596 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Toccata for 4 Guitars

UPDATE pieces piece
SET piece.title = 'Toccata for 4 Guitars', piece.title_en = 'Toccata for 4 Guitars',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16735 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tres apuntes

UPDATE pieces piece
SET piece.title = 'Tres apuntes', piece.title_en = 'Tres apuntes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19341 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'De el "Homenaje a Falla"', part.name_en = 'Tres apuntes: I. De el "Homenaje a Falla"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19341 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:0c5188a4-f97c-473c-b3e2-8a1d948889f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c5188a4-f97c-473c-b3e2-8a1d948889f4', 1, 'I', 'De el "Homenaje a Falla"', 'Tres apuntes: I. De el "Homenaje a Falla"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19341 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c5188a4-f97c-473c-b3e2-8a1d948889f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'De un fragmento instrumental', part.name_en = 'Tres apuntes: II. De un fragmento instrumental',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19341 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:b8d798ac-f39c-4485-8e3b-1ed427fc7b77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8d798ac-f39c-4485-8e3b-1ed427fc7b77', 2, 'II', 'De un fragmento instrumental', 'Tres apuntes: II. De un fragmento instrumental', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19341 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8d798ac-f39c-4485-8e3b-1ed427fc7b77'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sobre un canto de Bulgaria', part.name_en = 'Tres apuntes: III. Sobre un canto de Bulgaria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19341 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:e8bbc6e5-3f6d-49ae-9098-de679921a368' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8bbc6e5-3f6d-49ae-9098-de679921a368', 3, 'III', 'Sobre un canto de Bulgaria', 'Tres apuntes: III. Sobre un canto de Bulgaria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19341 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8bbc6e5-3f6d-49ae-9098-de679921a368'
);


-- None Tres danzas concertantes

UPDATE pieces piece
SET piece.title = 'Tres danzas concertantes', piece.title_en = 'Tres danzas concertantes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19534 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Tres danzas concertantes: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19534 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:9b28aece-1c89-432a-9064-69d476351150' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b28aece-1c89-432a-9064-69d476351150', 1, 'I', 'Allegro', 'Tres danzas concertantes: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19534 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b28aece-1c89-432a-9064-69d476351150'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andantino', part.name_en = 'Tres danzas concertantes: II. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19534 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:3e52637c-3a84-4530-9cf2-eda0ad0fbc40' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e52637c-3a84-4530-9cf2-eda0ad0fbc40', 2, 'II', 'Andantino', 'Tres danzas concertantes: II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19534 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e52637c-3a84-4530-9cf2-eda0ad0fbc40'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Toccata', part.name_en = 'Tres danzas concertantes: III. Toccata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19534 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:efc44098-afd2-47ff-a224-67501a56edce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efc44098-afd2-47ff-a224-67501a56edce', 3, 'III', 'Toccata', 'Tres danzas concertantes: III. Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19534 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efc44098-afd2-47ff-a224-67501a56edce'
);


-- None Tres piezas latinoamericanas (en estilo popular)

UPDATE pieces piece
SET piece.title = 'Tres piezas latinoamericanas (en estilo popular)', piece.title_en = 'Tres piezas latinoamericanas (en estilo popular)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16061 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Danza del altiplano', part.name_en = 'Tres piezas latinoamericanas (en estilo popular): Danza del altiplano',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16061 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:0b1b58c6-b844-4d92-9b51-2679b037045f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b1b58c6-b844-4d92-9b51-2679b037045f', 1, NULL, 'Danza del altiplano', 'Tres piezas latinoamericanas (en estilo popular): Danza del altiplano', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16061 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b1b58c6-b844-4d92-9b51-2679b037045f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Canción - Triste argentino', part.name_en = 'Tres piezas latinoamericanas (en estilo popular): Canción - Triste argentino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16061 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:124f7bff-5738-414f-a5a8-36b01b5401e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:124f7bff-5738-414f-a5a8-36b01b5401e7', 2, NULL, 'Canción - Triste argentino', 'Tres piezas latinoamericanas (en estilo popular): Canción - Triste argentino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16061 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:124f7bff-5738-414f-a5a8-36b01b5401e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Tango', part.name_en = 'Tres piezas latinoamericanas (en estilo popular): Tango',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16061 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:d9c2d299-bcb9-4ce1-a3c3-d76c8c75ab91' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9c2d299-bcb9-4ce1-a3c3-d76c8c75ab91', 3, NULL, 'Tango', 'Tres piezas latinoamericanas (en estilo popular): Tango', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16061 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9c2d299-bcb9-4ce1-a3c3-d76c8c75ab91'
);


-- None Un día de noviembre

UPDATE pieces piece
SET piece.title = 'Un día de noviembre', piece.title_en = 'Un día de noviembre',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15836 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Variantes

UPDATE pieces piece
SET piece.title = 'Variantes', piece.title_en = 'Variantes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19879 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Lento', part.name_en = 'Variantes: Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19879 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:658d6887-83b2-4a45-b659-fb80020b151d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:658d6887-83b2-4a45-b659-fb80020b151d', 1, NULL, 'Lento', 'Variantes: Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19879 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:658d6887-83b2-4a45-b659-fb80020b151d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Variation I. Con moto', part.name_en = 'Variantes: Variation I. Con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19879 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:3d6ab051-22e7-4194-acde-05874cd0ec9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d6ab051-22e7-4194-acde-05874cd0ec9d', 2, NULL, 'Variation I. Con moto', 'Variantes: Variation I. Con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19879 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d6ab051-22e7-4194-acde-05874cd0ec9d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Variation II. Rapido', part.name_en = 'Variantes: Variation II. Rapido',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19879 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:1fb43bc2-e8ae-4357-a44d-0d1894ff5668' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fb43bc2-e8ae-4357-a44d-0d1894ff5668', 3, NULL, 'Variation II. Rapido', 'Variantes: Variation II. Rapido', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19879 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fb43bc2-e8ae-4357-a44d-0d1894ff5668'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Variation III. Con delicatezza', part.name_en = 'Variantes: Variation III. Con delicatezza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19879 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:f5993504-9911-45be-8fa6-e7d7f51efac1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5993504-9911-45be-8fa6-e7d7f51efac1', 4, NULL, 'Variation III. Con delicatezza', 'Variantes: Variation III. Con delicatezza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19879 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5993504-9911-45be-8fa6-e7d7f51efac1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Variation IV. Molto rapido', part.name_en = 'Variantes: Variation IV. Molto rapido',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19879 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:9ba55b64-ed24-43a0-a83a-4d27fe9a23da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ba55b64-ed24-43a0-a83a-4d27fe9a23da', 5, NULL, 'Variation IV. Molto rapido', 'Variantes: Variation IV. Molto rapido', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19879 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ba55b64-ed24-43a0-a83a-4d27fe9a23da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Variation V. Epilogo', part.name_en = 'Variantes: Variation V. Epilogo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19879 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:b89d30c2-ca99-4a35-935d-e008be5078cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b89d30c2-ca99-4a35-935d-e008be5078cc', 6, NULL, 'Variation V. Epilogo', 'Variantes: Variation V. Epilogo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19879 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b89d30c2-ca99-4a35-935d-e008be5078cc'
);


-- None Variations on a Theme of Django Reinhardt

UPDATE pieces piece
SET piece.title = 'Variations on a Theme of Django Reinhardt', piece.title_en = 'Variations on a Theme of Django Reinhardt',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19768 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction and Theme', part.name_en = 'Variations on a Theme of Django Reinhardt: I. Introduction and Theme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19768 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:57dcd526-114c-40ca-8d2e-46276998486d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57dcd526-114c-40ca-8d2e-46276998486d', 1, 'I', 'Introduction and Theme', 'Variations on a Theme of Django Reinhardt: I. Introduction and Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19768 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57dcd526-114c-40ca-8d2e-46276998486d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Variations', part.name_en = 'Variations on a Theme of Django Reinhardt: II. Variations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19768 AND p.composer_id = 204 AND part.part_key = 'musicbrainz:df0ba623-54f7-4375-b437-f623056b3135' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df0ba623-54f7-4375-b437-f623056b3135', 2, 'II', 'Variations', 'Variations on a Theme of Django Reinhardt: II. Variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19768 AND p.composer_id = 204
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df0ba623-54f7-4375-b437-f623056b3135'
);


-- None Viaje a la semilla

UPDATE pieces piece
SET piece.title = 'Viaje a la semilla', piece.title_en = 'Viaje a la semilla',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19323 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Zapateo

UPDATE pieces piece
SET piece.title = 'Zapateo', piece.title_en = 'Zapateo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17485 AND piece.composer_id = 204
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ojos de juventud (Eyes of Youth)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Ojos de juventud (Eyes of Youth)', 'Ojos de juventud (Eyes of Youth)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 204
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Ojos de juventud (Eyes of Youth)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1050ec67-03de-40fb-b606-4da5c55f56ca'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1050ec67-03de-40fb-b606-4da5c55f56ca'
FROM pieces p
WHERE p.composer_id = 204 AND p.title = 'Ojos de juventud (Eyes of Youth)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1050ec67-03de-40fb-b606-4da5c55f56ca'
);


-- None 전주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡', 'Preludio', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 204
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c37a88f2-a37b-4c17-9cf1-21a27f521ea7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c37a88f2-a37b-4c17-9cf1-21a27f521ea7'
FROM pieces p
WHERE p.composer_id = 204 AND p.title = '전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c37a88f2-a37b-4c17-9cf1-21a27f521ea7'
);


-- None Triptico

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Triptico', 'Triptico', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 204
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Triptico'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b03535e-b05b-430c-a382-58116b5c7caf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2b03535e-b05b-430c-a382-58116b5c7caf'
FROM pieces p
WHERE p.composer_id = 204 AND p.title = 'Triptico' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b03535e-b05b-430c-a382-58116b5c7caf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9cc78927-22e0-4b19-8ce3-ce5f1d228b57', 1, NULL, 'Triptico', 'Triptico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 204 AND p.title = 'Triptico' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cc78927-22e0-4b19-8ce3-ce5f1d228b57'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b0c6d95f-1355-4ea4-be75-515665c535a6', 1, NULL, 'Allegro', 'Triptico: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9cc78927-22e0-4b19-8ce3-ce5f1d228b57'
WHERE p.composer_id = 204 AND p.title = 'Triptico' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0c6d95f-1355-4ea4-be75-515665c535a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:08b39ba4-326b-4a5a-9854-92ae264528cf', 2, NULL, 'Interlude', 'Triptico: II. Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9cc78927-22e0-4b19-8ce3-ce5f1d228b57'
WHERE p.composer_id = 204 AND p.title = 'Triptico' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08b39ba4-326b-4a5a-9854-92ae264528cf'
);


-- 카탈로그에 대응이 없는 seed 작품 8개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 204 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    16477, 17655, 17688, 17764, 19331, 19706, 19923, 19937
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
