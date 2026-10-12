-- 파야 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 38개(묶음 8, 다악장 4, 낱곡 26),
-- 새 작품 3개, part 66개, 그 아래 31개.
-- seed 57개 중 35개를 작품·part 에 잇고, 21개를 숨기고, 1개는 그대로 둔다.
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
SET piece.title = 'Fantasía baetica (편곡 9340)'
WHERE piece.id = 9340 AND piece.composer_id = 80 AND piece.title = 'Fantasía baetica'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);


-- None Allegro de concierto

UPDATE pieces piece
SET piece.title = 'Allegro de concierto', piece.title_en = 'Allegro de concierto',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8249 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Balada de Mallorca

UPDATE pieces piece
SET piece.title = 'Balada de Mallorca', piece.title_en = 'Balada de Mallorca',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7461 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canción

UPDATE pieces piece
SET piece.title = 'Canción', piece.title_en = 'Canción',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9366 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <Cantares de Nochebuena>

UPDATE pieces piece
SET piece.title = '연가곡집 <Cantares de Nochebuena>', piece.title_en = 'Cantares de Nochebuena',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8194 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'N.º 1. Pastores venir', part.name_en = 'Cantares de Nochebuena: N.º 1. Pastores venir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8194 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:b49d5755-e0a2-4c10-8f65-d1abe39efeb9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b49d5755-e0a2-4c10-8f65-d1abe39efeb9', 1, NULL, 'N.º 1. Pastores venir', 'Cantares de Nochebuena: N.º 1. Pastores venir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8194 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b49d5755-e0a2-4c10-8f65-d1abe39efeb9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'N.º 2. Maravilla nunca vista', part.name_en = 'Cantares de Nochebuena: N.º 2. Maravilla nunca vista',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8194 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:f9aa2009-cf6f-4614-bebd-c50f3a88d12f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9aa2009-cf6f-4614-bebd-c50f3a88d12f', 2, NULL, 'N.º 2. Maravilla nunca vista', 'Cantares de Nochebuena: N.º 2. Maravilla nunca vista', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8194 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9aa2009-cf6f-4614-bebd-c50f3a88d12f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'N.º 3. Esta noche ha de nacer el Señor de los Señores', part.name_en = 'Cantares de Nochebuena: N.º 3. Esta noche ha de nacer el Señor de los Señores',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8194 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:8c0ebf83-edb2-4151-a222-486c36f921a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c0ebf83-edb2-4151-a222-486c36f921a2', 3, NULL, 'N.º 3. Esta noche ha de nacer el Señor de los Señores', 'Cantares de Nochebuena: N.º 3. Esta noche ha de nacer el Señor de los Señores', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8194 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c0ebf83-edb2-4151-a222-486c36f921a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'N.º 4. Un pastor Ileva un pavo', part.name_en = 'Cantares de Nochebuena: N.º 4. Un pastor Ileva un pavo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8194 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:d5fbc2fd-17a1-4850-b5fb-05195fbb088b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5fbc2fd-17a1-4850-b5fb-05195fbb088b', 4, NULL, 'N.º 4. Un pastor Ileva un pavo', 'Cantares de Nochebuena: N.º 4. Un pastor Ileva un pavo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8194 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5fbc2fd-17a1-4850-b5fb-05195fbb088b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'N.º 5. Venga la bota', part.name_en = 'Cantares de Nochebuena: N.º 5. Venga la bota',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8194 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:7aa2dea4-27ba-499d-879a-f01a369bb329' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7aa2dea4-27ba-499d-879a-f01a369bb329', 5, NULL, 'N.º 5. Venga la bota', 'Cantares de Nochebuena: N.º 5. Venga la bota', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8194 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7aa2dea4-27ba-499d-879a-f01a369bb329'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'N.º 6. En el portal de Belén', part.name_en = 'Cantares de Nochebuena: N.º 6. En el portal de Belén',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8194 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:c10ec84f-650d-42ca-89bd-aa222e78cc8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c10ec84f-650d-42ca-89bd-aa222e78cc8a', 6, NULL, 'N.º 6. En el portal de Belén', 'Cantares de Nochebuena: N.º 6. En el portal de Belén', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8194 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c10ec84f-650d-42ca-89bd-aa222e78cc8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'N.º 7. Por la calle abajito', part.name_en = 'Cantares de Nochebuena: N.º 7. Por la calle abajito',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8194 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:64b6ab5a-f122-431b-b94e-04f33e807360' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64b6ab5a-f122-431b-b94e-04f33e807360', 7, NULL, 'N.º 7. Por la calle abajito', 'Cantares de Nochebuena: N.º 7. Por la calle abajito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8194 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64b6ab5a-f122-431b-b94e-04f33e807360'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'N.º 8. La leche de viejas ésa es para mi', part.name_en = 'Cantares de Nochebuena: N.º 8. La leche de viejas ésa es para mi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8194 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:eedb6a05-de17-4669-85b0-e4ad66b65a9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eedb6a05-de17-4669-85b0-e4ad66b65a9f', 8, NULL, 'N.º 8. La leche de viejas ésa es para mi', 'Cantares de Nochebuena: N.º 8. La leche de viejas ésa es para mi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8194 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eedb6a05-de17-4669-85b0-e4ad66b65a9f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'N.º 9. Un zapatero aburrío le decía a su mujer', part.name_en = 'Cantares de Nochebuena: N.º 9. Un zapatero aburrío le decía a su mujer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8194 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:8b8d5582-aa3b-4d97-b777-2bd7abed756d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b8d5582-aa3b-4d97-b777-2bd7abed756d', 9, NULL, 'N.º 9. Un zapatero aburrío le decía a su mujer', 'Cantares de Nochebuena: N.º 9. Un zapatero aburrío le decía a su mujer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8194 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b8d5582-aa3b-4d97-b777-2bd7abed756d'
);


-- None Concierto para clave, flauta, oboe, clarinete, violín y violoncelo

UPDATE pieces piece
SET piece.title = 'Concierto para clave, flauta, oboe, clarinete, violín y violoncelo', piece.title_en = 'Concierto para clave, flauta, oboe, clarinete, violín y violoncelo',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7567 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Concierto para clave, flauta, oboe, clarinete, violín y violoncelo: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7567 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:dc4bd451-27e1-4481-bef4-f12fd31714fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc4bd451-27e1-4481-bef4-f12fd31714fb', 1, 'I', 'Allegro', 'Concierto para clave, flauta, oboe, clarinete, violín y violoncelo: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7567 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc4bd451-27e1-4481-bef4-f12fd31714fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'Concierto para clave, flauta, oboe, clarinete, violín y violoncelo: II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7567 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:9b005445-54b7-4a0a-8c8e-e7c084e744d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b005445-54b7-4a0a-8c8e-e7c084e744d6', 2, 'II', 'Lento', 'Concierto para clave, flauta, oboe, clarinete, violín y violoncelo: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7567 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b005445-54b7-4a0a-8c8e-e7c084e744d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivace', part.name_en = 'Concierto para clave, flauta, oboe, clarinete, violín y violoncelo: III. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7567 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:3498b085-f5d4-4754-a8d3-6e05739b9c76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3498b085-f5d4-4754-a8d3-6e05739b9c76', 3, 'III', 'Vivace', 'Concierto para clave, flauta, oboe, clarinete, violín y violoncelo: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7567 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3498b085-f5d4-4754-a8d3-6e05739b9c76'
);


-- G. 21 Cortejo de gnomos

UPDATE pieces piece
SET piece.title = 'Cortejo de gnomos', piece.title_en = 'Cortejo de gnomos, G. 21',
    piece.type = 'song', piece.opus_number = 'G. 21',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9152 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cuatro piezas españolas

UPDATE pieces piece
SET piece.title = 'Cuatro piezas españolas', piece.title_en = 'Cuatro piezas españolas',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10986 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Aragonesa', part.name_en = 'Cuatro piezas españolas: Nº 1. Aragonesa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10986 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:c2abce41-a2b9-48b9-a3e2-5bea3eb9b1c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2abce41-a2b9-48b9-a3e2-5bea3eb9b1c7', 1, NULL, 'Aragonesa', 'Cuatro piezas españolas: Nº 1. Aragonesa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10986 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2abce41-a2b9-48b9-a3e2-5bea3eb9b1c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Cubana', part.name_en = 'Cuatro piezas españolas: Nº 2. Cubana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10986 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:1a0eb70e-cc08-4254-b6c6-f27d47b76643' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a0eb70e-cc08-4254-b6c6-f27d47b76643', 2, NULL, 'Cubana', 'Cuatro piezas españolas: Nº 2. Cubana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10986 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a0eb70e-cc08-4254-b6c6-f27d47b76643'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Montañesa', part.name_en = 'Cuatro piezas españolas: Nº 3. Montañesa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10986 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:eddffb2e-328f-4b34-9a15-33def92fa4d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eddffb2e-328f-4b34-9a15-33def92fa4d0', 3, NULL, 'Montañesa', 'Cuatro piezas españolas: Nº 3. Montañesa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10986 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eddffb2e-328f-4b34-9a15-33def92fa4d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Andaluza', part.name_en = 'Cuatro piezas españolas: Nº 4. Andaluza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10986 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:cfc3a633-0200-4e0a-af96-2b3b3a79d91d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfc3a633-0200-4e0a-af96-2b3b3a79d91d', 4, NULL, 'Andaluza', 'Cuatro piezas españolas: Nº 4. Andaluza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10986 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfc3a633-0200-4e0a-af96-2b3b3a79d91d'
);


-- None Danza

UPDATE pieces piece
SET piece.title = 'Danza', piece.title_en = 'Danza',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10872 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- G. 69 El amor brujo

UPDATE pieces piece
SET piece.title = 'El amor brujo', piece.title_en = 'El amor brujo, G. 69',
    piece.type = 'song', piece.opus_number = 'G. 69',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8087 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None El corregidor y la molinera

UPDATE pieces piece
SET piece.title = 'El corregidor y la molinera', piece.title_en = 'El corregidor y la molinera',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8015 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '1ª parte', part.name_en = 'El corregidor y la molinera: 1ª parte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8015 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:fb5c5279-b117-45e1-807d-ae59fd4c4678' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb5c5279-b117-45e1-807d-ae59fd4c4678', 1, NULL, '1ª parte', 'El corregidor y la molinera: 1ª parte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8015 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb5c5279-b117-45e1-807d-ae59fd4c4678'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb5c5279-b117-45e1-807d-ae59fd4c4678'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Cuadro 1: I. El mirlo', part.name_en = 'El corregidor y la molinera: Cuadro 1: I. El mirlo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8015 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:0f4560f7-287d-40d1-b4d2-ff3e3c6bf0b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0f4560f7-287d-40d1-b4d2-ff3e3c6bf0b1', 1, NULL, 'Cuadro 1: I. El mirlo', 'El corregidor y la molinera: Cuadro 1: I. El mirlo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb5c5279-b117-45e1-807d-ae59fd4c4678'
WHERE p.id = 8015 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f4560f7-287d-40d1-b4d2-ff3e3c6bf0b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb5c5279-b117-45e1-807d-ae59fd4c4678'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Cuadro 1: II. Los celos', part.name_en = 'El corregidor y la molinera: Cuadro 1: II. Los celos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8015 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:604889bd-45f4-435f-975f-af3683904df9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:604889bd-45f4-435f-975f-af3683904df9', 2, NULL, 'Cuadro 1: II. Los celos', 'El corregidor y la molinera: Cuadro 1: II. Los celos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb5c5279-b117-45e1-807d-ae59fd4c4678'
WHERE p.id = 8015 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:604889bd-45f4-435f-975f-af3683904df9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb5c5279-b117-45e1-807d-ae59fd4c4678'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Cuadro 1: III. El cortejo', part.name_en = 'El corregidor y la molinera: Cuadro 1: III. El cortejo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8015 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:cd53f909-cb18-4cc0-9488-2affb32c4d59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cd53f909-cb18-4cc0-9488-2affb32c4d59', 3, NULL, 'Cuadro 1: III. El cortejo', 'El corregidor y la molinera: Cuadro 1: III. El cortejo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb5c5279-b117-45e1-807d-ae59fd4c4678'
WHERE p.id = 8015 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd53f909-cb18-4cc0-9488-2affb32c4d59'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb5c5279-b117-45e1-807d-ae59fd4c4678'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Cuadro 1: IV. El fandango. Danza de la molinera', part.name_en = 'El corregidor y la molinera: Cuadro 1: IV. El fandango. Danza de la molinera',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8015 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:9239d8d0-b53d-4ebf-a9c1-6a3e2921936a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9239d8d0-b53d-4ebf-a9c1-6a3e2921936a', 4, NULL, 'Cuadro 1: IV. El fandango. Danza de la molinera', 'El corregidor y la molinera: Cuadro 1: IV. El fandango. Danza de la molinera', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb5c5279-b117-45e1-807d-ae59fd4c4678'
WHERE p.id = 8015 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9239d8d0-b53d-4ebf-a9c1-6a3e2921936a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb5c5279-b117-45e1-807d-ae59fd4c4678'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Cuadro 1: V. El corregidor', part.name_en = 'El corregidor y la molinera: Cuadro 1: V. El corregidor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8015 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:cc70b4fd-a2ee-4f94-bd49-7ca25239b66b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cc70b4fd-a2ee-4f94-bd49-7ca25239b66b', 5, NULL, 'Cuadro 1: V. El corregidor', 'El corregidor y la molinera: Cuadro 1: V. El corregidor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb5c5279-b117-45e1-807d-ae59fd4c4678'
WHERE p.id = 8015 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc70b4fd-a2ee-4f94-bd49-7ca25239b66b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb5c5279-b117-45e1-807d-ae59fd4c4678'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Cuadro 1: VI. Las uvas', part.name_en = 'El corregidor y la molinera: Cuadro 1: VI. Las uvas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8015 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:65dbff90-4c02-46f4-bdc6-59952e22dbfc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:65dbff90-4c02-46f4-bdc6-59952e22dbfc', 6, NULL, 'Cuadro 1: VI. Las uvas', 'El corregidor y la molinera: Cuadro 1: VI. Las uvas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb5c5279-b117-45e1-807d-ae59fd4c4678'
WHERE p.id = 8015 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65dbff90-4c02-46f4-bdc6-59952e22dbfc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb5c5279-b117-45e1-807d-ae59fd4c4678'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Cuadro 1: VII. Fandango & final', part.name_en = 'El corregidor y la molinera: Cuadro 1: VII. Fandango & final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8015 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:105bb6de-956c-4cd4-8a1b-4b6ebcdead47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:105bb6de-956c-4cd4-8a1b-4b6ebcdead47', 7, NULL, 'Cuadro 1: VII. Fandango & final', 'El corregidor y la molinera: Cuadro 1: VII. Fandango & final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb5c5279-b117-45e1-807d-ae59fd4c4678'
WHERE p.id = 8015 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:105bb6de-956c-4cd4-8a1b-4b6ebcdead47'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '2ª parte', part.name_en = 'El corregidor y la molinera: 2ª parte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8015 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:555eabe0-f7f3-4524-8edb-91aa1ff17591' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:555eabe0-f7f3-4524-8edb-91aa1ff17591', 2, NULL, '2ª parte', 'El corregidor y la molinera: 2ª parte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8015 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:555eabe0-f7f3-4524-8edb-91aa1ff17591'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:555eabe0-f7f3-4524-8edb-91aa1ff17591'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Cuadro 2: I. La cena. Seguidillas', part.name_en = 'El corregidor y la molinera: Cuadro 2: I. La cena. Seguidillas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8015 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:0df15b87-72e9-4b32-8c84-030eca54b452' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0df15b87-72e9-4b32-8c84-030eca54b452', 1, NULL, 'Cuadro 2: I. La cena. Seguidillas', 'El corregidor y la molinera: Cuadro 2: I. La cena. Seguidillas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:555eabe0-f7f3-4524-8edb-91aa1ff17591'
WHERE p.id = 8015 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0df15b87-72e9-4b32-8c84-030eca54b452'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:555eabe0-f7f3-4524-8edb-91aa1ff17591'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Cuadro 2: II. La espera galante', part.name_en = 'El corregidor y la molinera: Cuadro 2: II. La espera galante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8015 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:159e2a6c-de85-493d-822a-8bc3eb5e0573' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:159e2a6c-de85-493d-822a-8bc3eb5e0573', 2, NULL, 'Cuadro 2: II. La espera galante', 'El corregidor y la molinera: Cuadro 2: II. La espera galante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:555eabe0-f7f3-4524-8edb-91aa1ff17591'
WHERE p.id = 8015 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:159e2a6c-de85-493d-822a-8bc3eb5e0573'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:555eabe0-f7f3-4524-8edb-91aa1ff17591'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Cuadro 2: III. Los alguaciles', part.name_en = 'El corregidor y la molinera: Cuadro 2: III. Los alguaciles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8015 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:366529a2-7ad2-47ec-89e8-34f58b21d0c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:366529a2-7ad2-47ec-89e8-34f58b21d0c4', 3, NULL, 'Cuadro 2: III. Los alguaciles', 'El corregidor y la molinera: Cuadro 2: III. Los alguaciles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:555eabe0-f7f3-4524-8edb-91aa1ff17591'
WHERE p.id = 8015 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:366529a2-7ad2-47ec-89e8-34f58b21d0c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:555eabe0-f7f3-4524-8edb-91aa1ff17591'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Cuadro 2: IV. La copia del cuco', part.name_en = 'El corregidor y la molinera: Cuadro 2: IV. La copia del cuco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8015 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:015c056b-99e0-4800-af68-798e3cdf084a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:015c056b-99e0-4800-af68-798e3cdf084a', 4, NULL, 'Cuadro 2: IV. La copia del cuco', 'El corregidor y la molinera: Cuadro 2: IV. La copia del cuco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:555eabe0-f7f3-4524-8edb-91aa1ff17591'
WHERE p.id = 8015 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:015c056b-99e0-4800-af68-798e3cdf084a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:555eabe0-f7f3-4524-8edb-91aa1ff17591'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Cuadro 2: V. El chapuzón', part.name_en = 'El corregidor y la molinera: Cuadro 2: V. El chapuzón',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8015 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:e075d24d-2a71-4cee-8ced-e694f6dd9c44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e075d24d-2a71-4cee-8ced-e694f6dd9c44', 5, NULL, 'Cuadro 2: V. El chapuzón', 'El corregidor y la molinera: Cuadro 2: V. El chapuzón', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:555eabe0-f7f3-4524-8edb-91aa1ff17591'
WHERE p.id = 8015 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e075d24d-2a71-4cee-8ced-e694f6dd9c44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:555eabe0-f7f3-4524-8edb-91aa1ff17591'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Cuadro 2: VI. El asalto', part.name_en = 'El corregidor y la molinera: Cuadro 2: VI. El asalto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8015 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:ce1c98d4-580f-412c-b92a-68b7e8618328' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ce1c98d4-580f-412c-b92a-68b7e8618328', 6, NULL, 'Cuadro 2: VI. El asalto', 'El corregidor y la molinera: Cuadro 2: VI. El asalto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:555eabe0-f7f3-4524-8edb-91aa1ff17591'
WHERE p.id = 8015 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce1c98d4-580f-412c-b92a-68b7e8618328'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:555eabe0-f7f3-4524-8edb-91aa1ff17591'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Cuadro 2: VII. El alguacil / El molinero', part.name_en = 'El corregidor y la molinera: Cuadro 2: VII. El alguacil / El molinero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8015 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:f2123479-aa83-465f-b508-8d8aa37d9c57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f2123479-aa83-465f-b508-8d8aa37d9c57', 7, NULL, 'Cuadro 2: VII. El alguacil / El molinero', 'El corregidor y la molinera: Cuadro 2: VII. El alguacil / El molinero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:555eabe0-f7f3-4524-8edb-91aa1ff17591'
WHERE p.id = 8015 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2123479-aa83-465f-b508-8d8aa37d9c57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:555eabe0-f7f3-4524-8edb-91aa1ff17591'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Cuadro 2: VIII. También la corregidora es guapa', part.name_en = 'El corregidor y la molinera: Cuadro 2: VIII. También la corregidora es guapa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8015 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:add0451a-68d8-4df4-bad9-949d4af1de92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:add0451a-68d8-4df4-bad9-949d4af1de92', 8, NULL, 'Cuadro 2: VIII. También la corregidora es guapa', 'El corregidor y la molinera: Cuadro 2: VIII. También la corregidora es guapa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:555eabe0-f7f3-4524-8edb-91aa1ff17591'
WHERE p.id = 8015 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:add0451a-68d8-4df4-bad9-949d4af1de92'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:555eabe0-f7f3-4524-8edb-91aa1ff17591'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Cuadro 2: IX. El corregidor', part.name_en = 'El corregidor y la molinera: Cuadro 2: IX. El corregidor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8015 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:3eb9390b-7bea-40f5-b80c-5f0ab021982b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3eb9390b-7bea-40f5-b80c-5f0ab021982b', 9, NULL, 'Cuadro 2: IX. El corregidor', 'El corregidor y la molinera: Cuadro 2: IX. El corregidor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:555eabe0-f7f3-4524-8edb-91aa1ff17591'
WHERE p.id = 8015 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3eb9390b-7bea-40f5-b80c-5f0ab021982b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:555eabe0-f7f3-4524-8edb-91aa1ff17591'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Cuadro 2: X. La pelea final', part.name_en = 'El corregidor y la molinera: Cuadro 2: X. La pelea final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8015 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:951d1bff-6e5d-41df-9c5e-2bb80ae280d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:951d1bff-6e5d-41df-9c5e-2bb80ae280d1', 10, NULL, 'Cuadro 2: X. La pelea final', 'El corregidor y la molinera: Cuadro 2: X. La pelea final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:555eabe0-f7f3-4524-8edb-91aa1ff17591'
WHERE p.id = 8015 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:951d1bff-6e5d-41df-9c5e-2bb80ae280d1'
);


-- G. 47 가곡 <El pan de Ronda que sabe a verdad>

UPDATE pieces piece
SET piece.title = '가곡 <El pan de Ronda que sabe a verdad>', piece.title_en = 'El pan de Ronda que sabe a verdad, G. 47',
    piece.type = 'song', piece.opus_number = 'G. 47',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9337 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <El retablo de maese Pedro>

UPDATE pieces piece
SET piece.title = '오페라 <El retablo de maese Pedro>', piece.title_en = 'El retablo de maese Pedro',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7906 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'El pregón', part.name_en = 'El retablo de maese Pedro: I. El pregón',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7906 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:d3d48697-4a21-4431-ba17-26585560d33a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3d48697-4a21-4431-ba17-26585560d33a', 1, 'I', 'El pregón', 'El retablo de maese Pedro: I. El pregón', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7906 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3d48697-4a21-4431-ba17-26585560d33a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'La sinfonía de maese Pedro', part.name_en = 'El retablo de maese Pedro: II. La sinfonía de maese Pedro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7906 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:5335f19b-b867-42e7-a340-e0b380fab6f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5335f19b-b867-42e7-a340-e0b380fab6f8', 2, 'II', 'La sinfonía de maese Pedro', 'El retablo de maese Pedro: II. La sinfonía de maese Pedro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7906 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5335f19b-b867-42e7-a340-e0b380fab6f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'La corte de Carlomagno', part.name_en = 'El retablo de maese Pedro: III. La corte de Carlomagno',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7906 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:af4191cf-3cb1-4f3d-a79a-256e4ab8797d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af4191cf-3cb1-4f3d-a79a-256e4ab8797d', 3, 'III', 'La corte de Carlomagno', 'El retablo de maese Pedro: III. La corte de Carlomagno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7906 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af4191cf-3cb1-4f3d-a79a-256e4ab8797d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'La entrada de Carlomagno', part.name_en = 'El retablo de maese Pedro: IV. La entrada de Carlomagno',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7906 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:866bab4d-24e9-426b-92fe-16aa5c28d56a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:866bab4d-24e9-426b-92fe-16aa5c28d56a', 4, 'IV', 'La entrada de Carlomagno', 'El retablo de maese Pedro: IV. La entrada de Carlomagno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7906 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:866bab4d-24e9-426b-92fe-16aa5c28d56a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Melisendra', part.name_en = 'El retablo de maese Pedro: V. Melisendra',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7906 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:ee61bddc-1340-4031-a8cd-565d81b13f24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee61bddc-1340-4031-a8cd-565d81b13f24', 5, 'V', 'Melisendra', 'El retablo de maese Pedro: V. Melisendra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7906 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee61bddc-1340-4031-a8cd-565d81b13f24'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'El suplicio del moro', part.name_en = 'El retablo de maese Pedro: VI. El suplicio del moro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7906 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:a7cb5db8-31af-4b02-83e3-3b5c41ab6754' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7cb5db8-31af-4b02-83e3-3b5c41ab6754', 6, 'VI', 'El suplicio del moro', 'El retablo de maese Pedro: VI. El suplicio del moro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7906 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7cb5db8-31af-4b02-83e3-3b5c41ab6754'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Los Pirineos', part.name_en = 'El retablo de maese Pedro: VII. Los Pirineos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7906 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:0b13fdca-30f8-47d4-8516-f05cf4154580' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b13fdca-30f8-47d4-8516-f05cf4154580', 7, 'VII', 'Los Pirineos', 'El retablo de maese Pedro: VII. Los Pirineos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7906 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b13fdca-30f8-47d4-8516-f05cf4154580'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'La fuga', part.name_en = 'El retablo de maese Pedro: VIII. La fuga',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7906 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:127fbd7a-0a18-463d-acb2-3206aed0678e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:127fbd7a-0a18-463d-acb2-3206aed0678e', 8, 'VIII', 'La fuga', 'El retablo de maese Pedro: VIII. La fuga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7906 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:127fbd7a-0a18-463d-acb2-3206aed0678e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'La persecución', part.name_en = 'El retablo de maese Pedro: IX. La persecución',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7906 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:4e8b2c1c-aa45-4d1a-a161-f5d7d7e90ac7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e8b2c1c-aa45-4d1a-a161-f5d7d7e90ac7', 9, 'IX', 'La persecución', 'El retablo de maese Pedro: IX. La persecución', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7906 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e8b2c1c-aa45-4d1a-a161-f5d7d7e90ac7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Final', part.name_en = 'El retablo de maese Pedro: X. Final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7906 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:5859b2d1-045a-4bca-966a-b4e2b8ac9e98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5859b2d1-045a-4bca-966a-b4e2b8ac9e98', 10, 'X', 'Final', 'El retablo de maese Pedro: X. Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7906 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5859b2d1-045a-4bca-966a-b4e2b8ac9e98'
);


-- None Fanfare pour une fête

UPDATE pieces piece
SET piece.title = 'Fanfare pour une fête', piece.title_en = 'Fanfare pour une fête',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1587 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- G. 55 Fantasía baetica

UPDATE pieces piece
SET piece.title = 'Fantasía baetica', piece.title_en = 'Fantasía baetica, G. 55',
    piece.type = 'song', piece.opus_number = 'G. 55',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7433 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Fire Dance>

UPDATE pieces piece
SET piece.title = '가곡 <Fire Dance>', piece.title_en = 'Fire Dance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8474 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Homenajes

UPDATE pieces piece
SET piece.title = 'Homenajes', piece.title_en = 'Homenajes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11191 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Fanfare sobre el nombre de E. F. Arbós', part.name_en = 'Homenajes: I. Fanfare sobre el nombre de E. F. Arbós',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11191 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:861276c6-57f9-44d9-9883-483032ebfa7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:861276c6-57f9-44d9-9883-483032ebfa7a', 1, 'I', 'Fanfare sobre el nombre de E. F. Arbós', 'Homenajes: I. Fanfare sobre el nombre de E. F. Arbós', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11191 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:861276c6-57f9-44d9-9883-483032ebfa7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Rappel de la Fanfare', part.name_en = 'Homenajes: Rappel de la Fanfare',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11191 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:9cc3d349-aa7f-48f2-8792-4e9711bf7b6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9cc3d349-aa7f-48f2-8792-4e9711bf7b6d', 2, NULL, 'Rappel de la Fanfare', 'Homenajes: Rappel de la Fanfare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11191 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cc3d349-aa7f-48f2-8792-4e9711bf7b6d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'À Paul Dukas (Spes vitae)', part.name_en = 'Homenajes: III. À Paul Dukas (Spes vitae)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11191 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:3ad82a96-2140-4979-a1bb-14159a1d566d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ad82a96-2140-4979-a1bb-14159a1d566d', 3, 'III', 'À Paul Dukas (Spes vitae)', 'Homenajes: III. À Paul Dukas (Spes vitae)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11191 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ad82a96-2140-4979-a1bb-14159a1d566d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Pedrelliana', part.name_en = 'Homenajes: IV. Pedrelliana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11191 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:7ea0642a-99d7-47c2-973c-3efb1a375be0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ea0642a-99d7-47c2-973c-3efb1a375be0', 4, 'IV', 'Pedrelliana', 'Homenajes: IV. Pedrelliana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11191 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ea0642a-99d7-47c2-973c-3efb1a375be0'
);


-- None Invocatio ad Individuam Trinitatem

UPDATE pieces piece
SET piece.title = 'Invocatio ad Individuam Trinitatem', piece.title_en = 'Invocatio ad Individuam Trinitatem',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10892 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <La vida breve>

UPDATE pieces piece
SET piece.title = '오페라 <La vida breve>', piece.title_en = 'La vida breve',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9316 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acto I', part.name_en = 'La vida breve: Acto I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9316 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:4703c431-e1c6-4ccf-a371-4ac24d97c77e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4703c431-e1c6-4ccf-a371-4ac24d97c77e', 1, NULL, 'Acto I', 'La vida breve: Acto I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9316 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4703c431-e1c6-4ccf-a371-4ac24d97c77e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4703c431-e1c6-4ccf-a371-4ac24d97c77e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acto I. Cuarta escena', part.name_en = 'La vida breve: Acto I. Cuarta escena',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9316 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:030ee00f-111d-4f67-8cf2-321f67187b5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:030ee00f-111d-4f67-8cf2-321f67187b5d', 1, NULL, 'Acto I. Cuarta escena', 'La vida breve: Acto I. Cuarta escena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4703c431-e1c6-4ccf-a371-4ac24d97c77e'
WHERE p.id = 9316 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:030ee00f-111d-4f67-8cf2-321f67187b5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4703c431-e1c6-4ccf-a371-4ac24d97c77e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acto I. Intermezzo', part.name_en = 'La vida breve: Acto I. Intermezzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9316 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:3fcc90f8-80e6-48ce-9be4-afdc45042bea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3fcc90f8-80e6-48ce-9be4-afdc45042bea', 2, NULL, 'Acto I. Intermezzo', 'La vida breve: Acto I. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4703c431-e1c6-4ccf-a371-4ac24d97c77e'
WHERE p.id = 9316 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fcc90f8-80e6-48ce-9be4-afdc45042bea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4703c431-e1c6-4ccf-a371-4ac24d97c77e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acto I. Sexta escena', part.name_en = 'La vida breve: Acto I. Sexta escena',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9316 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:4c5700b8-4cf6-414d-ae7a-f0a42074477b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4c5700b8-4cf6-414d-ae7a-f0a42074477b', 3, NULL, 'Acto I. Sexta escena', 'La vida breve: Acto I. Sexta escena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4703c431-e1c6-4ccf-a371-4ac24d97c77e'
WHERE p.id = 9316 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c5700b8-4cf6-414d-ae7a-f0a42074477b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4703c431-e1c6-4ccf-a371-4ac24d97c77e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acto I. Segunda escena', part.name_en = 'La vida breve: Acto I. Segunda escena',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9316 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:6c47b77a-e9e6-4296-837e-3daac56084be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6c47b77a-e9e6-4296-837e-3daac56084be', 4, NULL, 'Acto I. Segunda escena', 'La vida breve: Acto I. Segunda escena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4703c431-e1c6-4ccf-a371-4ac24d97c77e'
WHERE p.id = 9316 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c47b77a-e9e6-4296-837e-3daac56084be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4703c431-e1c6-4ccf-a371-4ac24d97c77e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acto I. Primera escena', part.name_en = 'La vida breve: Acto I. Primera escena',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9316 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:b7bc4651-9836-423e-95e6-3cd01f19f5d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b7bc4651-9836-423e-95e6-3cd01f19f5d8', 5, NULL, 'Acto I. Primera escena', 'La vida breve: Acto I. Primera escena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4703c431-e1c6-4ccf-a371-4ac24d97c77e'
WHERE p.id = 9316 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7bc4651-9836-423e-95e6-3cd01f19f5d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4703c431-e1c6-4ccf-a371-4ac24d97c77e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acto I. Quinta escena', part.name_en = 'La vida breve: Acto I. Quinta escena',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9316 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:cdf1cc02-c907-4f36-803f-9960bd9c66c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cdf1cc02-c907-4f36-803f-9960bd9c66c3', 6, NULL, 'Acto I. Quinta escena', 'La vida breve: Acto I. Quinta escena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4703c431-e1c6-4ccf-a371-4ac24d97c77e'
WHERE p.id = 9316 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdf1cc02-c907-4f36-803f-9960bd9c66c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4703c431-e1c6-4ccf-a371-4ac24d97c77e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acto I. Tercera escena', part.name_en = 'La vida breve: Acto I. Tercera escena',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9316 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:ef3c5844-3dbd-4af3-8c80-e1bf3e0d01cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ef3c5844-3dbd-4af3-8c80-e1bf3e0d01cf', 7, NULL, 'Acto I. Tercera escena', 'La vida breve: Acto I. Tercera escena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4703c431-e1c6-4ccf-a371-4ac24d97c77e'
WHERE p.id = 9316 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef3c5844-3dbd-4af3-8c80-e1bf3e0d01cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acto II', part.name_en = 'La vida breve: Acto II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9316 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:098f8cda-64bd-4a7f-a2cc-b46caf37ba84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:098f8cda-64bd-4a7f-a2cc-b46caf37ba84', 2, NULL, 'Acto II', 'La vida breve: Acto II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9316 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:098f8cda-64bd-4a7f-a2cc-b46caf37ba84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098f8cda-64bd-4a7f-a2cc-b46caf37ba84'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acto II. Danza', part.name_en = 'La vida breve: Acto II. Danza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9316 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:0fd8e488-4f65-4c9c-b022-cbadf41b32c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0fd8e488-4f65-4c9c-b022-cbadf41b32c6', 1, NULL, 'Acto II. Danza', 'La vida breve: Acto II. Danza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098f8cda-64bd-4a7f-a2cc-b46caf37ba84'
WHERE p.id = 9316 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fd8e488-4f65-4c9c-b022-cbadf41b32c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098f8cda-64bd-4a7f-a2cc-b46caf37ba84'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Acto II. Segunda escena', part.name_en = 'La vida breve: Acto II. Segunda escena',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9316 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:7c2c7958-ac14-4111-8850-9bf33e380c3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7c2c7958-ac14-4111-8850-9bf33e380c3f', 2, NULL, 'Acto II. Segunda escena', 'La vida breve: Acto II. Segunda escena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098f8cda-64bd-4a7f-a2cc-b46caf37ba84'
WHERE p.id = 9316 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c2c7958-ac14-4111-8850-9bf33e380c3f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098f8cda-64bd-4a7f-a2cc-b46caf37ba84'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Acto II. Escena final', part.name_en = 'La vida breve: Acto II. Escena final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9316 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:7fdb0a56-7ef2-4f34-b855-7100f2324555' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7fdb0a56-7ef2-4f34-b855-7100f2324555', 3, NULL, 'Acto II. Escena final', 'La vida breve: Acto II. Escena final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098f8cda-64bd-4a7f-a2cc-b46caf37ba84'
WHERE p.id = 9316 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fdb0a56-7ef2-4f34-b855-7100f2324555'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098f8cda-64bd-4a7f-a2cc-b46caf37ba84'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Acto II. Tercera escena', part.name_en = 'La vida breve: Acto II. Tercera escena',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9316 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:886a5fda-4582-4775-92fc-e56f4432921f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:886a5fda-4582-4775-92fc-e56f4432921f', 4, NULL, 'Acto II. Tercera escena', 'La vida breve: Acto II. Tercera escena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098f8cda-64bd-4a7f-a2cc-b46caf37ba84'
WHERE p.id = 9316 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:886a5fda-4582-4775-92fc-e56f4432921f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098f8cda-64bd-4a7f-a2cc-b46caf37ba84'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Acto II. Danza española', part.name_en = 'La vida breve: Acto II. Danza española',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9316 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:c9b692bf-5d38-3ee1-b1cd-2520bc2e9c81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c9b692bf-5d38-3ee1-b1cd-2520bc2e9c81', 5, NULL, 'Acto II. Danza española', 'La vida breve: Acto II. Danza española', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098f8cda-64bd-4a7f-a2cc-b46caf37ba84'
WHERE p.id = 9316 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9b692bf-5d38-3ee1-b1cd-2520bc2e9c81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098f8cda-64bd-4a7f-a2cc-b46caf37ba84'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Acto II. Primera escena', part.name_en = 'La vida breve: Acto II. Primera escena',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9316 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:f31dda5c-40b7-4fbf-8e80-7ed1b14b7d4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f31dda5c-40b7-4fbf-8e80-7ed1b14b7d4d', 6, NULL, 'Acto II. Primera escena', 'La vida breve: Acto II. Primera escena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098f8cda-64bd-4a7f-a2cc-b46caf37ba84'
WHERE p.id = 9316 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f31dda5c-40b7-4fbf-8e80-7ed1b14b7d4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098f8cda-64bd-4a7f-a2cc-b46caf37ba84'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Acto II. Interludio orquestal', part.name_en = 'La vida breve: Acto II. Interludio orquestal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9316 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:fa153509-a585-48c9-a788-161074af790b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fa153509-a585-48c9-a788-161074af790b', 7, NULL, 'Acto II. Interludio orquestal', 'La vida breve: Acto II. Interludio orquestal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:098f8cda-64bd-4a7f-a2cc-b46caf37ba84'
WHERE p.id = 9316 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa153509-a585-48c9-a788-161074af790b'
);


-- None Mazurka en do menor

UPDATE pieces piece
SET piece.title = 'Mazurka en do menor', piece.title_en = 'Mazurka en do menor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8834 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Noches en los jardines de España

UPDATE pieces piece
SET piece.title = 'Noches en los jardines de España', piece.title_en = 'Noches en los jardines de España',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7598 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'En el Generalife', part.name_en = 'Noches en los jardines de España: I. En el Generalife',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7598 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:0a72d9bc-7b84-4e32-a322-04513ac89743' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a72d9bc-7b84-4e32-a322-04513ac89743', 1, 'I', 'En el Generalife', 'Noches en los jardines de España: I. En el Generalife', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7598 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a72d9bc-7b84-4e32-a322-04513ac89743'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Danza lejana', part.name_en = 'Noches en los jardines de España: II. Danza lejana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7598 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:6b0b712c-2f43-4a3c-b21d-59ddf15ed5c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b0b712c-2f43-4a3c-b21d-59ddf15ed5c4', 2, 'II', 'Danza lejana', 'Noches en los jardines de España: II. Danza lejana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7598 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b0b712c-2f43-4a3c-b21d-59ddf15ed5c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'En los jardines de la sierra de Córdoba', part.name_en = 'Noches en los jardines de España: III. En los jardines de la sierra de Córdoba',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7598 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:dd300b5a-7765-450e-b138-27a0e15d43aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd300b5a-7765-450e-b138-27a0e15d43aa', 3, 'III', 'En los jardines de la sierra de Córdoba', 'Noches en los jardines de España: III. En los jardines de la sierra de Córdoba', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7598 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd300b5a-7765-450e-b138-27a0e15d43aa'
);


-- None Nocturno

UPDATE pieces piece
SET piece.title = 'Nocturno', piece.title_en = 'Nocturno',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9660 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- G. 19 가곡 <Olas gigantes>

UPDATE pieces piece
SET piece.title = '가곡 <Olas gigantes>', piece.title_en = 'Olas gigantes, G. 19',
    piece.type = 'song', piece.opus_number = 'G. 19',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10669 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Oración de las madres que tienen a sus hijos en brazos>

UPDATE pieces piece
SET piece.title = '가곡 <Oración de las madres que tienen a sus hijos en brazos>', piece.title_en = 'Oración de las madres que tienen a sus hijos en brazos',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9177 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pour le tombeau de Paul Dukas

UPDATE pieces piece
SET piece.title = 'Pour le tombeau de Paul Dukas', piece.title_en = 'Pour le tombeau de Paul Dukas',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8014 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- G. 16 전주곡

UPDATE pieces piece
SET piece.title = '전주곡', piece.title_en = 'Preludios, G. 16',
    piece.type = 'song', piece.opus_number = 'G. 16',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8561 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Psyché

UPDATE pieces piece
SET piece.title = 'Psyché', piece.title_en = 'Psyché',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10486 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Serenata andaluza

UPDATE pieces piece
SET piece.title = 'Serenata andaluza', piece.title_en = 'Serenata andaluza',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9558 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- G. 40 연가곡집 <Siete canciones populares españolas> G. 40

UPDATE pieces piece
SET piece.title = '연가곡집 <Siete canciones populares españolas> G. 40', piece.title_en = 'Siete canciones populares españolas, G. 40',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'G.', piece.catalogue_number = '40',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7507 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'El paño moruno', part.name_en = 'Siete canciones populares españolas, G. 40, nº 1: El paño moruno',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7507 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:08f58c24-513d-3576-a241-52e7209e7f71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08f58c24-513d-3576-a241-52e7209e7f71', 1, NULL, 'El paño moruno', 'Siete canciones populares españolas, G. 40, nº 1: El paño moruno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7507 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08f58c24-513d-3576-a241-52e7209e7f71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Seguidilla murciana', part.name_en = 'Siete canciones populares españolas, G. 40, nº 2: Seguidilla murciana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7507 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:526288e3-3d64-3919-b2f2-4bd943240ec2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:526288e3-3d64-3919-b2f2-4bd943240ec2', 2, NULL, 'Seguidilla murciana', 'Siete canciones populares españolas, G. 40, nº 2: Seguidilla murciana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7507 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:526288e3-3d64-3919-b2f2-4bd943240ec2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Asturiana', part.name_en = 'Siete canciones populares españolas, G. 40, nº 3: Asturiana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7507 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:02dd5ff5-0109-3a03-ad2f-50475f214f4f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02dd5ff5-0109-3a03-ad2f-50475f214f4f', 3, NULL, 'Asturiana', 'Siete canciones populares españolas, G. 40, nº 3: Asturiana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7507 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02dd5ff5-0109-3a03-ad2f-50475f214f4f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Jota', part.name_en = 'Siete canciones populares españolas, G. 40, nº 4: Jota',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7507 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:913f8f29-b39d-30ee-9212-db42058b1185' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:913f8f29-b39d-30ee-9212-db42058b1185', 4, NULL, 'Jota', 'Siete canciones populares españolas, G. 40, nº 4: Jota', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7507 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:913f8f29-b39d-30ee-9212-db42058b1185'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Nana', part.name_en = 'Siete canciones populares españolas, G. 40, nº 5: Nana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7507 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:6324f110-af0f-3a77-87d9-09e31197d071' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6324f110-af0f-3a77-87d9-09e31197d071', 5, NULL, 'Nana', 'Siete canciones populares españolas, G. 40, nº 5: Nana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7507 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6324f110-af0f-3a77-87d9-09e31197d071'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Canción', part.name_en = 'Siete canciones populares españolas, G. 40, nº 6: Canción',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7507 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:7ad53ea7-6618-38d6-83f1-97ed7b62c031' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ad53ea7-6618-38d6-83f1-97ed7b62c031', 6, NULL, 'Canción', 'Siete canciones populares españolas, G. 40, nº 6: Canción', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7507 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ad53ea7-6618-38d6-83f1-97ed7b62c031'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Polo', part.name_en = 'Siete canciones populares españolas, G. 40, nº 7: Polo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7507 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:d5a7328c-ff51-3d45-ad58-67c60c2fe511' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5a7328c-ff51-3d45-ad58-67c60c2fe511', 7, NULL, 'Polo', 'Siete canciones populares españolas, G. 40, nº 7: Polo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7507 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5a7328c-ff51-3d45-ad58-67c60c2fe511'
);


-- None 가곡 <Soneto a Córdoba>

UPDATE pieces piece
SET piece.title = '가곡 <Soneto a Córdoba>', piece.title_en = 'Soneto a Córdoba',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10718 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Song of Injured Love>

UPDATE pieces piece
SET piece.title = '가곡 <Song of Injured Love>', piece.title_en = 'Song of Injured Love',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10312 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tres obras

UPDATE pieces piece
SET piece.title = 'Tres obras', piece.title_en = 'Tres obras',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9742 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Melodía', part.name_en = 'Tres obras, nº 1: Melodía',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9742 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:20938a01-cfbb-4fa0-9146-9057ee58d1dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20938a01-cfbb-4fa0-9146-9057ee58d1dd', 1, NULL, 'Melodía', 'Tres obras, nº 1: Melodía', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9742 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20938a01-cfbb-4fa0-9146-9057ee58d1dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Romanza', part.name_en = 'Tres obras, nº 2: Romanza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9742 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:89ab66dd-5e7c-41ed-b9ea-0907e22a31fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89ab66dd-5e7c-41ed-b9ea-0907e22a31fd', 2, NULL, 'Romanza', 'Tres obras, nº 2: Romanza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9742 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89ab66dd-5e7c-41ed-b9ea-0907e22a31fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Pieza en do mayor', part.name_en = 'Tres obras, nº 3: Pieza en do mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9742 AND p.composer_id = 80 AND part.part_key = 'musicbrainz:8a5f5bc9-bb3b-4506-a7c7-61bcf4b507e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a5f5bc9-bb3b-4506-a7c7-61bcf4b507e5', 3, NULL, 'Pieza en do mayor', 'Tres obras, nº 3: Pieza en do mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9742 AND p.composer_id = 80
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a5f5bc9-bb3b-4506-a7c7-61bcf4b507e5'
);


-- G. 28 가곡 <Tus ojillos negros>

UPDATE pieces piece
SET piece.title = '가곡 <Tus ojillos negros>', piece.title_en = 'Tus ojillos negros, G. 28',
    piece.type = 'song', piece.opus_number = 'G. 28',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7676 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- G. 15 Vals-capricho

UPDATE pieces piece
SET piece.title = 'Vals-capricho', piece.title_en = 'Vals-capricho, G. 15',
    piece.type = 'song', piece.opus_number = 'G. 15',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10999 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- G. 20 가곡 <¡Dios mío, qué solos se quedan los muertos!>

UPDATE pieces piece
SET piece.title = '가곡 <¡Dios mío, qué solos se quedan los muertos!>', piece.title_en = '¡Dios mío, qué solos se quedan los muertos!, G. 20',
    piece.type = 'song', piece.opus_number = 'G. 20',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9492 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Скажите, девушки>

UPDATE pieces piece
SET piece.title = '가곡 <Скажите, девушки>', piece.title_en = 'Скажите, девушки',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9618 AND piece.composer_id = 80
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 발레 <El amor brujo>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <El amor brujo>', 'El amor brujo', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 80
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <El amor brujo>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '854ad5f7-0d5f-4cf5-b5cd-2085df1b2c06'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '854ad5f7-0d5f-4cf5-b5cd-2085df1b2c06'
FROM pieces p
WHERE p.composer_id = 80 AND p.title = '발레 <El amor brujo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '854ad5f7-0d5f-4cf5-b5cd-2085df1b2c06'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0860f483-fac6-4f0c-8767-e605a1787f66', 1, NULL, 'Cuadro primero: Introducción y escena', 'El amor brujo: Cuadro primero: Introducción y escena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 80 AND p.title = '발레 <El amor brujo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0860f483-fac6-4f0c-8767-e605a1787f66'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c819af79-7aa8-46b3-9991-34f2f8bdbcdc', 2, NULL, 'Cuadro primero: Canción del amor dolido', 'El amor brujo: Cuadro primero: Canción del amor dolido', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 80 AND p.title = '발레 <El amor brujo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c819af79-7aa8-46b3-9991-34f2f8bdbcdc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c5e328f-4088-41c2-ab4f-91c5284926b8', 3, NULL, 'Cuadro primero: Sortilegio', 'El amor brujo: Cuadro primero: Sortilegio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 80 AND p.title = '발레 <El amor brujo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c5e328f-4088-41c2-ab4f-91c5284926b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70d32220-b2f0-4b03-9627-2cdea9e03d1d', 4, NULL, 'Cuadro primero: Danza del fin del día', 'El amor brujo: Cuadro primero: Danza del fin del día', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 80 AND p.title = '발레 <El amor brujo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70d32220-b2f0-4b03-9627-2cdea9e03d1d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f990240-e40c-4347-9b4d-69694e8e53b8', 5, NULL, 'Cuadro primero: Escena', 'El amor brujo: Cuadro primero: Escena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 80 AND p.title = '발레 <El amor brujo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f990240-e40c-4347-9b4d-69694e8e53b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46967d43-569a-4f63-ac15-a52de6f664e7', 6, NULL, 'Cuadro primero: Romance del pescador', 'El amor brujo: Cuadro primero: Romance del pescador', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 80 AND p.title = '발레 <El amor brujo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46967d43-569a-4f63-ac15-a52de6f664e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe576013-44c6-4e73-bb86-051948381429', 7, NULL, 'Cuadro primero: Intermezzo', 'El amor brujo: Cuadro primero: Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 80 AND p.title = '발레 <El amor brujo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe576013-44c6-4e73-bb86-051948381429'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:718719c3-13d7-437e-b9e5-42cd270d737d', 8, NULL, 'Cuadro segundo: Introducción', 'El amor brujo: Cuadro segundo: Introducción', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 80 AND p.title = '발레 <El amor brujo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:718719c3-13d7-437e-b9e5-42cd270d737d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64698cc0-415e-4632-b0a6-08080f4e7ddc', 9, NULL, 'Cuadro segundo: Escena', 'El amor brujo: Cuadro segundo: Escena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 80 AND p.title = '발레 <El amor brujo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64698cc0-415e-4632-b0a6-08080f4e7ddc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6772d9f6-55c1-4e16-aef5-071c403805b9', 10, NULL, 'Cuadro segundo: Danza del fuego fatuo', 'El amor brujo: Cuadro segundo: Danza del fuego fatuo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 80 AND p.title = '발레 <El amor brujo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6772d9f6-55c1-4e16-aef5-071c403805b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca5394a9-ab5b-4c97-8880-a891a6c048f4', 11, NULL, 'Cuadro segundo: Interludio', 'El amor brujo: Cuadro segundo: Interludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 80 AND p.title = '발레 <El amor brujo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca5394a9-ab5b-4c97-8880-a891a6c048f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19b3d304-df7b-4826-891b-c24a061b2897', 12, NULL, 'Cuadro segundo: Canción del fuego fatuo', 'El amor brujo: Cuadro segundo: Canción del fuego fatuo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 80 AND p.title = '발레 <El amor brujo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19b3d304-df7b-4826-891b-c24a061b2897'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2efeb836-06ba-4424-8b97-4bf28a497867', 13, NULL, 'Cuadro segundo: Conjuro para reconquistar el amor perdido', 'El amor brujo: Cuadro segundo: Conjuro para reconquistar el amor perdido', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 80 AND p.title = '발레 <El amor brujo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2efeb836-06ba-4424-8b97-4bf28a497867'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f6d360d-b3c8-4616-93d7-f35c8e2a1acb', 14, NULL, 'Cuadro segundo: Escena', 'El amor brujo: Cuadro segundo: Escena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 80 AND p.title = '발레 <El amor brujo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f6d360d-b3c8-4616-93d7-f35c8e2a1acb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:feb004db-1e78-4a3a-a2d6-2880004f2cec', 15, NULL, 'Cuadro segundo: Danza y canción de la bruja fingida', 'El amor brujo: Cuadro segundo: Danza y canción de la bruja fingida', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 80 AND p.title = '발레 <El amor brujo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:feb004db-1e78-4a3a-a2d6-2880004f2cec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:daf89157-4043-4768-a803-9888283a09a1', 16, NULL, 'Cuadro segundo: Final', 'El amor brujo: Cuadro segundo: Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 80 AND p.title = '발레 <El amor brujo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:daf89157-4043-4768-a803-9888283a09a1'
);


-- None 세레나데

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세레나데', 'Serenata', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 80
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세레나데'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d576bba-1085-4d2d-ae02-81c04b147e3c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7d576bba-1085-4d2d-ae02-81c04b147e3c'
FROM pieces p
WHERE p.composer_id = 80 AND p.title = '세레나데' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d576bba-1085-4d2d-ae02-81c04b147e3c'
);


-- None Trois mélodies

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Trois mélodies', 'Trois mélodies', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 80
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Trois mélodies'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '33549fbb-4114-43b8-8d27-3ca2674ec441'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '33549fbb-4114-43b8-8d27-3ca2674ec441'
FROM pieces p
WHERE p.composer_id = 80 AND p.title = 'Trois mélodies' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '33549fbb-4114-43b8-8d27-3ca2674ec441'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:acf829eb-2bc5-4598-872e-86519717aca3', 1, NULL, 'Les Colombes', 'Trois mélodies: Nº 1. Les Colombes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 80 AND p.title = 'Trois mélodies' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acf829eb-2bc5-4598-872e-86519717aca3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07870afa-a2a9-439c-b7df-3a7d9a246744', 2, NULL, 'Chinoiserie', 'Trois mélodies: Nº 2. Chinoiserie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 80 AND p.title = 'Trois mélodies' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07870afa-a2a9-439c-b7df-3a7d9a246744'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a16e1d8c-25a6-4b21-ace1-e72d58b2d8fa', 3, NULL, 'Séguidille', 'Trois mélodies: Nº 3. Séguidille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 80 AND p.title = 'Trois mélodies' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a16e1d8c-25a6-4b21-ace1-e72d58b2d8fa'
);


-- 카탈로그에 대응이 없는 seed 작품 21개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 80 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    2602, 7489, 7557, 7597, 7728, 7740, 8277, 8700, 8806, 8900, 8930, 8937, 9041, 9044, 9340, 9421, 9585, 9694, 9881, 11036,
    11078
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
