-- William Grant Still 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 73개(묶음 9, 다악장 25, 낱곡 39),
-- 새 작품 11개, part 110개, 그 아래 16개.
-- seed 63개 중 62개를 작품·part 에 잇고, 0개를 숨기고, 1개는 그대로 둔다.
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

-- None A Black Pierrot

UPDATE pieces piece
SET piece.title = 'A Black Pierrot', piece.title_en = 'A Black Pierrot',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17661 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Deserted Plantation

UPDATE pieces piece
SET piece.title = 'A Deserted Plantation', piece.title_en = 'A Deserted Plantation',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17747 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Spiritual', part.name_en = 'A Deserted Plantation: I. Spiritual',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17747 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:e79ec225-d8b5-488c-9298-b7074b5354f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e79ec225-d8b5-488c-9298-b7074b5354f4', 1, 'I', 'Spiritual', 'A Deserted Plantation: I. Spiritual', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17747 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e79ec225-d8b5-488c-9298-b7074b5354f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Young Missy', part.name_en = 'A Deserted Plantation: II. Young Missy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17747 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:dbe27cba-46fe-4271-a5fe-5e97b3b591cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbe27cba-46fe-4271-a5fe-5e97b3b591cb', 2, 'II', 'Young Missy', 'A Deserted Plantation: II. Young Missy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17747 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbe27cba-46fe-4271-a5fe-5e97b3b591cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Dance', part.name_en = 'A Deserted Plantation: III. Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17747 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:8dec6b39-4e11-4267-89b6-c946a749e866' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8dec6b39-4e11-4267-89b6-c946a749e866', 3, 'III', 'Dance', 'A Deserted Plantation: III. Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17747 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8dec6b39-4e11-4267-89b6-c946a749e866'
);


-- None 가곡 <All That I Am>

UPDATE pieces piece
SET piece.title = '가곡 <All That I Am>', piece.title_en = 'All That I Am',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16398 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None American Suite

UPDATE pieces piece
SET piece.title = 'American Suite', piece.title_en = 'American Suite',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18395 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Indian Love Song', part.name_en = 'American Suite: I. Indian Love Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18395 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:dae19368-0f02-4b01-9dcb-95c4089149df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dae19368-0f02-4b01-9dcb-95c4089149df', 1, 'I', 'Indian Love Song', 'American Suite: I. Indian Love Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18395 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dae19368-0f02-4b01-9dcb-95c4089149df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Danse', part.name_en = 'American Suite: II. Danse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18395 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:0b88c69d-d7e9-4d2d-a750-edb3f391ce57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b88c69d-d7e9-4d2d-a750-edb3f391ce57', 2, 'II', 'Danse', 'American Suite: II. Danse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18395 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b88c69d-d7e9-4d2d-a750-edb3f391ce57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Lament', part.name_en = 'American Suite: III. Lament',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18395 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:31eada33-ceed-4f62-9c68-ec6cba905154' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31eada33-ceed-4f62-9c68-ec6cba905154', 3, 'III', 'Lament', 'American Suite: III. Lament', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18395 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31eada33-ceed-4f62-9c68-ec6cba905154'
);


-- None 가곡 <Arkansas>

UPDATE pieces piece
SET piece.title = '가곡 <Arkansas>', piece.title_en = 'Arkansas',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16116 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Bayou Home>

UPDATE pieces piece
SET piece.title = '가곡 <Bayou Home>', piece.title_en = 'Bayou Home',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18811 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bells

UPDATE pieces piece
SET piece.title = 'Bells', piece.title_en = 'Bells',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19760 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Phantom Chapel', part.name_en = 'Bells: I. Phantom Chapel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19760 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:64cfbe8c-cef4-435d-99db-82be88f6bad8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64cfbe8c-cef4-435d-99db-82be88f6bad8', 1, 'I', 'Phantom Chapel', 'Bells: I. Phantom Chapel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19760 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64cfbe8c-cef4-435d-99db-82be88f6bad8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Fairy Knoll', part.name_en = 'Bells: II. Fairy Knoll',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19760 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:264334a5-cb59-47ec-931b-8e04f252f029' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:264334a5-cb59-47ec-931b-8e04f252f029', 2, 'II', 'Fairy Knoll', 'Bells: II. Fairy Knoll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19760 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:264334a5-cb59-47ec-931b-8e04f252f029'
);


-- None Can’t You Line ’Em

UPDATE pieces piece
SET piece.title = 'Can’t You Line ’Em', piece.title_en = 'Can’t You Line ’Em',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17565 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Carmela

UPDATE pieces piece
SET piece.title = 'Carmela', piece.title_en = 'Carmela',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19482 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Citadel>

UPDATE pieces piece
SET piece.title = '가곡 <Citadel>', piece.title_en = 'Citadel',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16480 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Costaso>

UPDATE pieces piece
SET piece.title = '오페라 <Costaso>', piece.title_en = 'Costaso',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18786 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Golden Days', part.name_en = 'Costaso: Golden Days',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18786 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:614e09b1-1109-44da-8fb7-d83b9356371b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:614e09b1-1109-44da-8fb7-d83b9356371b', 1, NULL, 'Golden Days', 'Costaso: Golden Days', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18786 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:614e09b1-1109-44da-8fb7-d83b9356371b'
);


-- None Dance of the Porteuses

UPDATE pieces piece
SET piece.title = 'Dance of the Porteuses', piece.title_en = 'Dance of the Porteuses',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20097 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Danzas de Panamá

UPDATE pieces piece
SET piece.title = 'Danzas de Panamá', piece.title_en = 'Danzas de Panamá',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19695 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Tamborito', part.name_en = 'Danzas de Panamá: I. Tamborito',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19695 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:61b65b61-0982-460e-bb59-b1701367371d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61b65b61-0982-460e-bb59-b1701367371d', 1, 'I', 'Tamborito', 'Danzas de Panamá: I. Tamborito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19695 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61b65b61-0982-460e-bb59-b1701367371d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Mejorana', part.name_en = 'Danzas de Panamá: II. Mejorana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19695 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:75328583-626d-497e-b21f-3ad311e9b2c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75328583-626d-497e-b21f-3ad311e9b2c5', 2, 'II', 'Mejorana', 'Danzas de Panamá: II. Mejorana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19695 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75328583-626d-497e-b21f-3ad311e9b2c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Punto', part.name_en = 'Danzas de Panamá: III. Punto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19695 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:704e8fbc-111c-4c03-8abf-aa8df792d2aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:704e8fbc-111c-4c03-8abf-aa8df792d2aa', 3, 'III', 'Punto', 'Danzas de Panamá: III. Punto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19695 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:704e8fbc-111c-4c03-8abf-aa8df792d2aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Cumbia y congo', part.name_en = 'Danzas de Panamá: IV. Cumbia y congo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19695 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:1b7565c9-538d-49c8-a717-06be699adb97' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b7565c9-538d-49c8-a717-06be699adb97', 4, 'IV', 'Cumbia y congo', 'Danzas de Panamá: IV. Cumbia y congo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19695 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b7565c9-538d-49c8-a717-06be699adb97'
);


-- None Elegy for Organ

UPDATE pieces piece
SET piece.title = 'Elegy for Organ', piece.title_en = 'Elegy for Organ',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19792 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ennanga

UPDATE pieces piece
SET piece.title = 'Ennanga', piece.title_en = 'Ennanga',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17772 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Ennanga: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17772 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:f36c5b73-d6d5-43fa-b966-d82bdd47d719' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f36c5b73-d6d5-43fa-b966-d82bdd47d719', 1, NULL, 'I', 'Ennanga: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17772 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f36c5b73-d6d5-43fa-b966-d82bdd47d719'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Ennanga: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17772 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:5e571036-405f-4a63-b92b-788d39fa9d20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e571036-405f-4a63-b92b-788d39fa9d20', 2, NULL, 'II', 'Ennanga: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17772 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e571036-405f-4a63-b92b-788d39fa9d20'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Ennanga: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17772 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:95521ef5-c810-4b09-80d3-d324269fe2f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95521ef5-c810-4b09-80d3-d324269fe2f0', 3, NULL, 'III', 'Ennanga: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17772 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95521ef5-c810-4b09-80d3-d324269fe2f0'
);


-- None Fanfare for the 99th Fighter Squadron

UPDATE pieces piece
SET piece.title = 'Fanfare for the 99th Fighter Squadron', piece.title_en = 'Fanfare for the 99th Fighter Squadron',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17881 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Festive Overture

UPDATE pieces piece
SET piece.title = 'Festive Overture', piece.title_en = 'Festive Overture',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18524 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 5개의 전주곡

UPDATE pieces piece
SET piece.title = '5개의 전주곡', piece.title_en = 'Five Preludes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17801 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Briskly', part.name_en = 'Five Preludes: No. 1. Briskly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17801 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:949155d4-3649-4eee-810a-9c25cf2f904f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:949155d4-3649-4eee-810a-9c25cf2f904f', 1, NULL, 'Briskly', 'Five Preludes: No. 1. Briskly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17801 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:949155d4-3649-4eee-810a-9c25cf2f904f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Placidly', part.name_en = 'Five Preludes: No. 2. Placidly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17801 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:a18670a5-b38e-4106-b3a5-3fcaa4126349' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a18670a5-b38e-4106-b3a5-3fcaa4126349', 2, NULL, 'Placidly', 'Five Preludes: No. 2. Placidly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17801 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a18670a5-b38e-4106-b3a5-3fcaa4126349'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Delicately', part.name_en = 'Five Preludes: No. 3. Delicately',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17801 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:0a4f0374-775d-47ec-b2ab-cd8a98997ce9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a4f0374-775d-47ec-b2ab-cd8a98997ce9', 3, NULL, 'Delicately', 'Five Preludes: No. 3. Delicately', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17801 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a4f0374-775d-47ec-b2ab-cd8a98997ce9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Smooth and Sustained', part.name_en = 'Five Preludes: No. 4. Smooth and Sustained',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17801 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:7b983378-36cc-492b-9f79-bbcf11e9a767' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b983378-36cc-492b-9f79-bbcf11e9a767', 4, NULL, 'Smooth and Sustained', 'Five Preludes: No. 4. Smooth and Sustained', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17801 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b983378-36cc-492b-9f79-bbcf11e9a767'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Liltingly', part.name_en = 'Five Preludes: No. 5. Liltingly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17801 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:a2372331-bd61-4c39-8116-aec57e3137b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2372331-bd61-4c39-8116-aec57e3137b8', 5, NULL, 'Liltingly', 'Five Preludes: No. 5. Liltingly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17801 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2372331-bd61-4c39-8116-aec57e3137b8'
);


-- None Folk Suite no. 4

UPDATE pieces piece
SET piece.title = 'Folk Suite no. 4', piece.title_en = 'Folk Suite no. 4',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18210 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'El monigote', part.name_en = 'Folk Suite no. 4: I. El monigote',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18210 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:a55b0c40-0e15-461c-b0c4-a9531e1a9d8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a55b0c40-0e15-461c-b0c4-a9531e1a9d8e', 1, 'I', 'El monigote', 'Folk Suite no. 4: I. El monigote', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18210 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a55b0c40-0e15-461c-b0c4-a9531e1a9d8e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Anda buscando de rosa en rosa', part.name_en = 'Folk Suite no. 4: II. Anda buscando de rosa en rosa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18210 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:f65ed328-700d-4716-a53e-5b300311119d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f65ed328-700d-4716-a53e-5b300311119d', 2, 'II', 'Anda buscando de rosa en rosa', 'Folk Suite no. 4: II. Anda buscando de rosa en rosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18210 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f65ed328-700d-4716-a53e-5b300311119d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tayeras', part.name_en = 'Folk Suite no. 4: III. Tayeras',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18210 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:f8d64fa1-d21d-40e3-8477-8cbc29f63bfc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8d64fa1-d21d-40e3-8477-8cbc29f63bfc', 3, 'III', 'Tayeras', 'Folk Suite no. 4: III. Tayeras', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18210 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8d64fa1-d21d-40e3-8477-8cbc29f63bfc'
);


-- None 가곡 <Grief>

UPDATE pieces piece
SET piece.title = '가곡 <Grief>', piece.title_en = 'Grief',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20038 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Highway 1, USA>

UPDATE pieces piece
SET piece.title = '오페라 <Highway 1, USA>', piece.title_en = 'Highway 1, USA',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17937 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'You''re Wonderful, Mary', part.name_en = 'Highway 1, USA: You''re Wonderful, Mary',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17937 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:9d024c4e-4751-440e-86c1-336739de3301' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d024c4e-4751-440e-86c1-336739de3301', 1, NULL, 'You''re Wonderful, Mary', 'Highway 1, USA: You''re Wonderful, Mary', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17937 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d024c4e-4751-440e-86c1-336739de3301'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'What Does He Know of Dreams?', part.name_en = 'Highway 1, USA: What Does He Know of Dreams?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17937 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:f9a92c14-824c-442b-bf9f-e7fb8aff8b07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9a92c14-824c-442b-bf9f-e7fb8aff8b07', 2, NULL, 'What Does He Know of Dreams?', 'Highway 1, USA: What Does He Know of Dreams?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17937 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9a92c14-824c-442b-bf9f-e7fb8aff8b07'
);


-- None I Feel Like My Time Ain't Long

UPDATE pieces piece
SET piece.title = 'I Feel Like My Time Ain''t Long', piece.title_en = 'I Feel Like My Time Ain''t Long',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19854 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Incantation and Dance

UPDATE pieces piece
SET piece.title = 'Incantation and Dance', piece.title_en = 'Incantation and Dance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16746 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Kaintuck'

UPDATE pieces piece
SET piece.title = 'Kaintuck''', piece.title_en = 'Kaintuck''',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16386 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lenox Avenue

UPDATE pieces piece
SET piece.title = 'Lenox Avenue', piece.title_en = 'Lenox Avenue',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19871 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The House Rent Party', part.name_en = 'The House Rent Party',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19871 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:eac36760-c273-4d16-9405-9b6e64c5c8ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eac36760-c273-4d16-9405-9b6e64c5c8ca', 1, NULL, 'The House Rent Party', 'The House Rent Party', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19871 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eac36760-c273-4d16-9405-9b6e64c5c8ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eac36760-c273-4d16-9405-9b6e64c5c8ca'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Blues from "Lenox Avenue"', part.name_en = 'Blues from "Lenox Avenue"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19871 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:c1c23de9-952c-4c2a-9b13-bc8d46435b51' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c1c23de9-952c-4c2a-9b13-bc8d46435b51', 1, NULL, 'Blues from "Lenox Avenue"', 'Blues from "Lenox Avenue"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eac36760-c273-4d16-9405-9b6e64c5c8ca'
WHERE p.id = 19871 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1c23de9-952c-4c2a-9b13-bc8d46435b51'
);


-- None Little Folk Suite from the Western Hemisphere no. 1

UPDATE pieces piece
SET piece.title = 'Little Folk Suite from the Western Hemisphere no. 1', piece.title_en = 'Little Folk Suite from the Western Hemisphere no. 1',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19896 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Salangadou', part.name_en = 'Little Folk Suite from the Western Hemisphere no. 1: I. Salangadou',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19896 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:ce54d739-37c1-4c81-a6c0-41f43733a6f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce54d739-37c1-4c81-a6c0-41f43733a6f5', 1, 'I', 'Salangadou', 'Little Folk Suite from the Western Hemisphere no. 1: I. Salangadou', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19896 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce54d739-37c1-4c81-a6c0-41f43733a6f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'El Capotín', part.name_en = 'Little Folk Suite from the Western Hemisphere no. 1: II. El Capotín',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19896 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:1c6f3968-efe8-4fa5-a173-a9ce41ec9c2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c6f3968-efe8-4fa5-a173-a9ce41ec9c2c', 2, 'II', 'El Capotín', 'Little Folk Suite from the Western Hemisphere no. 1: II. El Capotín', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19896 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c6f3968-efe8-4fa5-a173-a9ce41ec9c2c'
);


-- None Little Folk Suite from the Western Hemisphere no. 2

UPDATE pieces piece
SET piece.title = 'Little Folk Suite from the Western Hemisphere no. 2', piece.title_en = 'Little Folk Suite from the Western Hemisphere no. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18093 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'El Nido', part.name_en = 'Little Folk Suite from the Western Hemisphere no. 2: I. El Nido',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18093 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:19b51f70-77e0-478b-aff4-d8ccadf0ebbb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19b51f70-77e0-478b-aff4-d8ccadf0ebbb', 1, 'I', 'El Nido', 'Little Folk Suite from the Western Hemisphere no. 2: I. El Nido', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18093 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19b51f70-77e0-478b-aff4-d8ccadf0ebbb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sweet Betsy from Pike', part.name_en = 'Little Folk Suite from the Western Hemisphere no. 2: II. Sweet Betsy from Pike',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18093 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:a8e0b50e-4e6c-40a2-b0f4-0ff5ee85219b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8e0b50e-4e6c-40a2-b0f4-0ff5ee85219b', 2, 'II', 'Sweet Betsy from Pike', 'Little Folk Suite from the Western Hemisphere no. 2: II. Sweet Betsy from Pike', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18093 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8e0b50e-4e6c-40a2-b0f4-0ff5ee85219b'
);


-- None Little Folk Suite from the Western Hemisphere no. 3

UPDATE pieces piece
SET piece.title = 'Little Folk Suite from the Western Hemisphere no. 3', piece.title_en = 'Little Folk Suite from the Western Hemisphere no. 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19313 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Aurore Pradere and Tant Sirop est Doux', part.name_en = 'Little Folk Suite from the Western Hemisphere no. 3: I. Aurore Pradere and Tant Sirop est Doux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19313 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:9d6e013d-83d1-4791-a2c9-11eaba5c1ad5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d6e013d-83d1-4791-a2c9-11eaba5c1ad5', 1, 'I', 'Aurore Pradere and Tant Sirop est Doux', 'Little Folk Suite from the Western Hemisphere no. 3: I. Aurore Pradere and Tant Sirop est Doux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19313 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d6e013d-83d1-4791-a2c9-11eaba5c1ad5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Wade in the Water', part.name_en = 'Little Folk Suite from the Western Hemisphere no. 3: II. Wade in the Water',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19313 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:263fd20c-72a9-4b78-b24e-ad449633c1b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:263fd20c-72a9-4b78-b24e-ad449633c1b7', 2, 'II', 'Wade in the Water', 'Little Folk Suite from the Western Hemisphere no. 3: II. Wade in the Water', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19313 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:263fd20c-72a9-4b78-b24e-ad449633c1b7'
);


-- None Little Folk Suite from the Western Hemisphere no. 4

UPDATE pieces piece
SET piece.title = 'Little Folk Suite from the Western Hemisphere no. 4', piece.title_en = 'Little Folk Suite from the Western Hemisphere no. 4',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17501 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Los Indios and Yaravi', part.name_en = 'Little Folk Suite from the Western Hemisphere no. 4: I. Los Indios and Yaravi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17501 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:9c9d8d0c-bba5-4e86-8a43-592672c336d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c9d8d0c-bba5-4e86-8a43-592672c336d4', 1, 'I', 'Los Indios and Yaravi', 'Little Folk Suite from the Western Hemisphere no. 4: I. Los Indios and Yaravi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17501 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c9d8d0c-bba5-4e86-8a43-592672c336d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Crawdad Song', part.name_en = 'Little Folk Suite from the Western Hemisphere no. 4: II. The Crawdad Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17501 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:51be1af7-cab2-49c7-a73c-195ed623edbb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51be1af7-cab2-49c7-a73c-195ed623edbb', 2, 'II', 'The Crawdad Song', 'Little Folk Suite from the Western Hemisphere no. 4: II. The Crawdad Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17501 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51be1af7-cab2-49c7-a73c-195ed623edbb'
);


-- None Little Folk Suite from the Western Hemisphere no. 5

UPDATE pieces piece
SET piece.title = 'Little Folk Suite from the Western Hemisphere no. 5', piece.title_en = 'Little Folk Suite from the Western Hemisphere no. 5',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16273 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Tutu Marimba', part.name_en = 'Little Folk Suite from the Western Hemisphere no. 5: I. Tutu Marimba',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16273 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:aaecb0aa-74b7-4e27-a9a8-b10f0b92d40a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aaecb0aa-74b7-4e27-a9a8-b10f0b92d40a', 1, 'I', 'Tutu Marimba', 'Little Folk Suite from the Western Hemisphere no. 5: I. Tutu Marimba', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16273 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaecb0aa-74b7-4e27-a9a8-b10f0b92d40a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'La Varsoviana', part.name_en = 'Little Folk Suite from the Western Hemisphere no. 5: II. La Varsoviana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16273 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:66b22bbe-8248-447b-a1db-020ae70ce381' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66b22bbe-8248-447b-a1db-020ae70ce381', 2, 'II', 'La Varsoviana', 'Little Folk Suite from the Western Hemisphere no. 5: II. La Varsoviana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16273 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66b22bbe-8248-447b-a1db-020ae70ce381'
);


-- None Little Folk Suite from the Western Hemisphere no. 6

UPDATE pieces piece
SET piece.title = 'Little Folk Suite from the Western Hemisphere no. 6', piece.title_en = 'Little Folk Suite from the Western Hemisphere no. 6',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20050 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Anda buscando de rosa en rosa', part.name_en = 'Little Folk Suite from the Western Hemisphere no. 6: I. Anda buscando de rosa en rosa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20050 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:de24f850-85ca-478f-a9c2-ef4f08d4a099' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de24f850-85ca-478f-a9c2-ef4f08d4a099', 1, 'I', 'Anda buscando de rosa en rosa', 'Little Folk Suite from the Western Hemisphere no. 6: I. Anda buscando de rosa en rosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20050 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de24f850-85ca-478f-a9c2-ef4f08d4a099'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Whoopee Ti Yi Yo', part.name_en = 'Little Folk Suite from the Western Hemisphere no. 6: II. Whoopee Ti Yi Yo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20050 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:c0aae5ba-76a5-4531-9c91-35e5677cabfe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0aae5ba-76a5-4531-9c91-35e5677cabfe', 2, 'II', 'Whoopee Ti Yi Yo', 'Little Folk Suite from the Western Hemisphere no. 6: II. Whoopee Ti Yi Yo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20050 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0aae5ba-76a5-4531-9c91-35e5677cabfe'
);


-- None Lyric Quartet

UPDATE pieces piece
SET piece.title = 'Lyric Quartet', piece.title_en = 'Lyric Quartet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16511 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The Sentimental One', part.name_en = 'Lyric Quartet: I. The Sentimental One',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16511 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:1331ae38-39d6-45fa-b34f-6f94d0a29a52' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1331ae38-39d6-45fa-b34f-6f94d0a29a52', 1, 'I', 'The Sentimental One', 'Lyric Quartet: I. The Sentimental One', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16511 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1331ae38-39d6-45fa-b34f-6f94d0a29a52'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Quiet One', part.name_en = 'Lyric Quartet: II. The Quiet One',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16511 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:d9169cc9-41a6-458f-89af-b19d4c15052d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9169cc9-41a6-458f-89af-b19d4c15052d', 2, 'II', 'The Quiet One', 'Lyric Quartet: II. The Quiet One', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16511 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9169cc9-41a6-458f-89af-b19d4c15052d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Jovial One', part.name_en = 'Lyric Quartet: III. The Jovial One',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16511 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:9bea43d8-f988-4383-9846-9198bd3d570c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bea43d8-f988-4383-9846-9198bd3d570c', 3, 'III', 'The Jovial One', 'Lyric Quartet: III. The Jovial One', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16511 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bea43d8-f988-4383-9846-9198bd3d570c'
);


-- None Miniatures

UPDATE pieces piece
SET piece.title = 'Miniatures', piece.title_en = 'Miniatures',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18679 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I Ride an Old Paint (USA)', part.name_en = 'Miniatures: No. 1. I Ride an Old Paint (USA)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18679 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:98c610d1-ecea-4bb3-b009-af652f5e9885' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98c610d1-ecea-4bb3-b009-af652f5e9885', 1, NULL, 'I Ride an Old Paint (USA)', 'Miniatures: No. 1. I Ride an Old Paint (USA)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18679 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98c610d1-ecea-4bb3-b009-af652f5e9885'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Adolorido (Mexico)', part.name_en = 'Miniatures: No. 2. Adolorido (Mexico)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18679 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:2fe9cbf0-95ee-4ad2-b583-78390244e60b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fe9cbf0-95ee-4ad2-b583-78390244e60b', 2, NULL, 'Adolorido (Mexico)', 'Miniatures: No. 2. Adolorido (Mexico)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18679 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fe9cbf0-95ee-4ad2-b583-78390244e60b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Jesus Is a Rock in the Weary Land (USA)', part.name_en = 'Miniatures: No. 3. Jesus Is a Rock in the Weary Land (USA)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18679 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:4af93968-97aa-4e31-b2c4-4cc36d6083eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4af93968-97aa-4e31-b2c4-4cc36d6083eb', 3, NULL, 'Jesus Is a Rock in the Weary Land (USA)', 'Miniatures: No. 3. Jesus Is a Rock in the Weary Land (USA)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18679 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4af93968-97aa-4e31-b2c4-4cc36d6083eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Yaravi (Peru)', part.name_en = 'Miniatures: No. 4. Yaravi (Peru)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18679 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:b61c68fe-04e8-4ba9-bbc5-196dbe6e6d65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b61c68fe-04e8-4ba9-bbc5-196dbe6e6d65', 4, NULL, 'Yaravi (Peru)', 'Miniatures: No. 4. Yaravi (Peru)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18679 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b61c68fe-04e8-4ba9-bbc5-196dbe6e6d65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'A Frog Went A-Courtin'' (USA)', part.name_en = 'Miniatures: No. 5. A Frog Went A-Courtin'' (USA)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18679 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:f3ff4543-6047-4b5f-b9fb-9c4aa66b2be3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3ff4543-6047-4b5f-b9fb-9c4aa66b2be3', 5, NULL, 'A Frog Went A-Courtin'' (USA)', 'Miniatures: No. 5. A Frog Went A-Courtin'' (USA)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18679 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3ff4543-6047-4b5f-b9fb-9c4aa66b2be3'
);


-- None 가곡 <My Brother American>

UPDATE pieces piece
SET piece.title = '가곡 <My Brother American>', piece.title_en = 'My Brother American',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16734 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Old California

UPDATE pieces piece
SET piece.title = 'Old California', piece.title_en = 'Old California',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16901 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Plain-Chant for America>

UPDATE pieces piece
SET piece.title = '가곡 <Plain-Chant for America>', piece.title_en = 'Plain-Chant for America',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18205 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Poem for Orchestra

UPDATE pieces piece
SET piece.title = 'Poem for Orchestra', piece.title_en = 'Poem for Orchestra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16798 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Prince and the Mermaid Suite

UPDATE pieces piece
SET piece.title = 'Prince and the Mermaid Suite', piece.title_en = 'Prince and the Mermaid Suite',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19436 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Song of the Sea', part.name_en = 'Prince and the Mermaid Suite: I. Song of the Sea',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19436 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:5d51cb04-bee1-427c-8e73-b5366cdbb4c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d51cb04-bee1-427c-8e73-b5366cdbb4c9', 1, 'I', 'Song of the Sea', 'Prince and the Mermaid Suite: I. Song of the Sea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19436 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d51cb04-bee1-427c-8e73-b5366cdbb4c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Waltz', part.name_en = 'Prince and the Mermaid Suite: II. Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19436 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:c576ea26-ea01-46bd-bcba-9f952f807d4f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c576ea26-ea01-46bd-bcba-9f952f807d4f', 2, 'II', 'Waltz', 'Prince and the Mermaid Suite: II. Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19436 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c576ea26-ea01-46bd-bcba-9f952f807d4f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Minuet', part.name_en = 'Prince and the Mermaid Suite: III. Minuet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19436 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:c4e08d9b-a1ef-450f-bebb-75dbfbf787fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4e08d9b-a1ef-450f-bebb-75dbfbf787fe', 3, 'III', 'Minuet', 'Prince and the Mermaid Suite: III. Minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19436 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4e08d9b-a1ef-450f-bebb-75dbfbf787fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Scherzo', part.name_en = 'Prince and the Mermaid Suite: IV. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19436 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:0bf9dee2-a8ba-446c-9b2d-94c04073f464' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bf9dee2-a8ba-446c-9b2d-94c04073f464', 4, 'IV', 'Scherzo', 'Prince and the Mermaid Suite: IV. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19436 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bf9dee2-a8ba-446c-9b2d-94c04073f464'
);


-- None 가곡 <Rising Tide>

UPDATE pieces piece
SET piece.title = '가곡 <Rising Tide>', piece.title_en = 'Rising Tide',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19221 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Romance for Saxophone and Piano

UPDATE pieces piece
SET piece.title = 'Romance for Saxophone and Piano', piece.title_en = 'Romance for Saxophone and Piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18137 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 발레 <Sahdji>

UPDATE pieces piece
SET piece.title = '발레 <Sahdji>', piece.title_en = 'Sahdji',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16015 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Seven Traceries

UPDATE pieces piece
SET piece.title = 'Seven Traceries', piece.title_en = 'Seven Traceries',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17211 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Cloud Cradles', part.name_en = 'Seven Traceries: I. Cloud Cradles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17211 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:f76ea6c0-3d9c-446a-96c7-00b19764def5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f76ea6c0-3d9c-446a-96c7-00b19764def5', 1, 'I', 'Cloud Cradles', 'Seven Traceries: I. Cloud Cradles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17211 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f76ea6c0-3d9c-446a-96c7-00b19764def5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Mystic Pool', part.name_en = 'Seven Traceries: II. Mystic Pool',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17211 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:48266d22-1ebf-4501-9917-3accb6a08857' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48266d22-1ebf-4501-9917-3accb6a08857', 2, 'II', 'Mystic Pool', 'Seven Traceries: II. Mystic Pool', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17211 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48266d22-1ebf-4501-9917-3accb6a08857'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Muted Laughter', part.name_en = 'Seven Traceries: III. Muted Laughter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17211 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:35e28b45-f35f-4d80-a149-c9e331ee9c5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35e28b45-f35f-4d80-a149-c9e331ee9c5e', 3, 'III', 'Muted Laughter', 'Seven Traceries: III. Muted Laughter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17211 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35e28b45-f35f-4d80-a149-c9e331ee9c5e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Out of the Silence', part.name_en = 'Seven Traceries: IV. Out of the Silence',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17211 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:011a5a6e-b88c-45b3-9d64-0f89db6dfc2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:011a5a6e-b88c-45b3-9d64-0f89db6dfc2c', 4, 'IV', 'Out of the Silence', 'Seven Traceries: IV. Out of the Silence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17211 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:011a5a6e-b88c-45b3-9d64-0f89db6dfc2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Woven Silver', part.name_en = 'Seven Traceries: V. Woven Silver',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17211 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:8c1d7cce-c982-4377-a543-2baf28c50cdf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c1d7cce-c982-4377-a543-2baf28c50cdf', 5, 'V', 'Woven Silver', 'Seven Traceries: V. Woven Silver', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17211 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c1d7cce-c982-4377-a543-2baf28c50cdf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Wailing Dawn', part.name_en = 'Seven Traceries: VI. Wailing Dawn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17211 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:7a145a31-6f7d-4594-9e50-0835e74ebebc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a145a31-6f7d-4594-9e50-0835e74ebebc', 6, 'VI', 'Wailing Dawn', 'Seven Traceries: VI. Wailing Dawn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17211 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a145a31-6f7d-4594-9e50-0835e74ebebc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'A Bit of Wit', part.name_en = 'Seven Traceries: VII. A Bit of Wit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17211 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:cb30e303-357f-4362-ba34-38ea031326c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb30e303-357f-4362-ba34-38ea031326c5', 7, 'VII', 'A Bit of Wit', 'Seven Traceries: VII. A Bit of Wit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17211 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb30e303-357f-4362-ba34-38ea031326c5'
);


-- None 가곡 <Sinner, Please Don't Let This Harvest Pass>

UPDATE pieces piece
SET piece.title = '가곡 <Sinner, Please Don''t Let This Harvest Pass>', piece.title_en = 'Sinner, Please Don''t Let This Harvest Pass',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19642 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sometimes I Feel Like a Motherless Child

UPDATE pieces piece
SET piece.title = 'Sometimes I Feel Like a Motherless Child', piece.title_en = 'Sometimes I Feel Like a Motherless Child',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19294 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Song for the Lonely

UPDATE pieces piece
SET piece.title = 'Song for the Lonely', piece.title_en = 'Song for the Lonely',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19471 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Song for the Valiant

UPDATE pieces piece
SET piece.title = 'Song for the Valiant', piece.title_en = 'Song for the Valiant',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17125 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Songs of Separation

UPDATE pieces piece
SET piece.title = 'Songs of Separation', piece.title_en = 'Songs of Separation',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18721 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Idolatry', part.name_en = 'Songs of Separation: No. 1. Idolatry',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18721 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:c2e90b49-1da1-4ada-b80a-ba333e21fa42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2e90b49-1da1-4ada-b80a-ba333e21fa42', 1, NULL, 'Idolatry', 'Songs of Separation: No. 1. Idolatry', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18721 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2e90b49-1da1-4ada-b80a-ba333e21fa42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Poème', part.name_en = 'Songs of Separation: No. 2. Poème',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18721 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:58172c01-a69e-48a1-b4e9-fae80c1075c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58172c01-a69e-48a1-b4e9-fae80c1075c4', 2, NULL, 'Poème', 'Songs of Separation: No. 2. Poème', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18721 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58172c01-a69e-48a1-b4e9-fae80c1075c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Parted', part.name_en = 'Songs of Separation: No. 3. Parted',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18721 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:cca9d9e2-cea9-443f-8481-b4e15521c4c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cca9d9e2-cea9-443f-8481-b4e15521c4c6', 3, NULL, 'Parted', 'Songs of Separation: No. 3. Parted', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18721 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cca9d9e2-cea9-443f-8481-b4e15521c4c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'If You Should Go', part.name_en = 'Songs of Separation: No. 4. If You Should Go',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18721 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:79285237-ee51-4348-a5d4-8b887b24f47c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79285237-ee51-4348-a5d4-8b887b24f47c', 4, NULL, 'If You Should Go', 'Songs of Separation: No. 4. If You Should Go', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18721 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79285237-ee51-4348-a5d4-8b887b24f47c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'A Black Pierrot', part.name_en = 'Songs of Separation: No. 5. A Black Pierrot',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18721 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:21913a16-710d-40da-9969-74ca55633c7e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21913a16-710d-40da-9969-74ca55633c7e', 5, NULL, 'A Black Pierrot', 'Songs of Separation: No. 5. A Black Pierrot', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18721 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21913a16-710d-40da-9969-74ca55633c7e'
);


-- None 바이올린 모음곡

UPDATE pieces piece
SET piece.title = '바이올린 모음곡', piece.title_en = 'Suite for Violin and Orchestra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19958 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Swanee River

UPDATE pieces piece
SET piece.title = 'Swanee River', piece.title_en = 'Swanee River',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18677 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 교향곡 1번 "Afro-American"

UPDATE pieces piece
SET piece.title = '교향곡 1번 "Afro-American"', piece.title_en = 'Symphony no. 1 “Afro-American”',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17870 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato assai', part.name_en = 'Symphony no. 1 “Afro-American”: I. Moderato assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17870 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:c4da5704-871b-432b-ac6b-cce1daf06883' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4da5704-871b-432b-ac6b-cce1daf06883', 1, 'I', 'Moderato assai', 'Symphony no. 1 “Afro-American”: I. Moderato assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17870 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4da5704-871b-432b-ac6b-cce1daf06883'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Symphony no. 1 “Afro-American”: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17870 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:e25d1c72-d22a-4a7b-a320-99688229bf7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e25d1c72-d22a-4a7b-a320-99688229bf7f', 2, 'II', 'Adagio', 'Symphony no. 1 “Afro-American”: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17870 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e25d1c72-d22a-4a7b-a320-99688229bf7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Animato', part.name_en = 'Symphony no. 1 “Afro-American”: III. Animato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17870 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:3863636a-06c2-4733-a7bb-f2d078cbd21d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3863636a-06c2-4733-a7bb-f2d078cbd21d', 3, 'III', 'Animato', 'Symphony no. 1 “Afro-American”: III. Animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17870 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3863636a-06c2-4733-a7bb-f2d078cbd21d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lento, con risoluzione', part.name_en = 'Symphony no. 1 “Afro-American”: IV. Lento, con risoluzione',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17870 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:507b9854-0d51-4ed7-b3b8-4d35a0fd1119' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:507b9854-0d51-4ed7-b3b8-4d35a0fd1119', 4, 'IV', 'Lento, con risoluzione', 'Symphony no. 1 “Afro-American”: IV. Lento, con risoluzione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17870 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:507b9854-0d51-4ed7-b3b8-4d35a0fd1119'
);


-- None 교향곡 2번 G단조 "Song of a New Race"

UPDATE pieces piece
SET piece.title = '교향곡 2번 G단조 "Song of a New Race"', piece.title_en = 'Symphony no. 2 in G minor “Song of a New Race”',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19630 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Slowly', part.name_en = 'Symphony no. 2 in G minor “Song of a New Race”: I. Slowly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19630 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:5cbe2283-c8ea-4f14-b2bd-5431fe7f91e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cbe2283-c8ea-4f14-b2bd-5431fe7f91e4', 1, 'I', 'Slowly', 'Symphony no. 2 in G minor “Song of a New Race”: I. Slowly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19630 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cbe2283-c8ea-4f14-b2bd-5431fe7f91e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Slowly and deeply expressive', part.name_en = 'Symphony no. 2 in G minor “Song of a New Race”: II. Slowly and deeply expressive',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19630 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:f8aa879e-acd7-4278-affe-d9f6e21d8265' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8aa879e-acd7-4278-affe-d9f6e21d8265', 2, 'II', 'Slowly and deeply expressive', 'Symphony no. 2 in G minor “Song of a New Race”: II. Slowly and deeply expressive', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19630 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8aa879e-acd7-4278-affe-d9f6e21d8265'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Moderately fast', part.name_en = 'Symphony no. 2 in G minor “Song of a New Race”: III. Moderately fast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19630 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:84944cfd-81ef-4d82-9184-145bbbd848ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84944cfd-81ef-4d82-9184-145bbbd848ef', 3, 'III', 'Moderately fast', 'Symphony no. 2 in G minor “Song of a New Race”: III. Moderately fast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19630 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84944cfd-81ef-4d82-9184-145bbbd848ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Moderately slow', part.name_en = 'Symphony no. 2 in G minor “Song of a New Race”: IV. Moderately slow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19630 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:21d69194-d76c-43ed-9db0-1267cd84fe7c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21d69194-d76c-43ed-9db0-1267cd84fe7c', 4, 'IV', 'Moderately slow', 'Symphony no. 2 in G minor “Song of a New Race”: IV. Moderately slow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19630 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21d69194-d76c-43ed-9db0-1267cd84fe7c'
);


-- None 교향곡 3번 "The Sunday Symphony"

UPDATE pieces piece
SET piece.title = '교향곡 3번 "The Sunday Symphony"', piece.title_en = 'Symphony no. 3 "The Sunday Symphony"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17449 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Awakening (Moderately Fast)', part.name_en = 'Symphony no. 3 "The Sunday Symphony": I. Awakening (Moderately Fast)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17449 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:4bd09551-d77c-47a4-92c1-258a3680dc1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4bd09551-d77c-47a4-92c1-258a3680dc1c', 1, 'I', 'Awakening (Moderately Fast)', 'Symphony no. 3 "The Sunday Symphony": I. Awakening (Moderately Fast)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17449 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bd09551-d77c-47a4-92c1-258a3680dc1c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Prayer (Very Slow)', part.name_en = 'Symphony no. 3 "The Sunday Symphony": II. Prayer (Very Slow)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17449 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:37e23283-a95f-47c0-b2d5-38661893aa84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37e23283-a95f-47c0-b2d5-38661893aa84', 2, 'II', 'Prayer (Very Slow)', 'Symphony no. 3 "The Sunday Symphony": II. Prayer (Very Slow)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17449 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37e23283-a95f-47c0-b2d5-38661893aa84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Relaxation (Gaily)', part.name_en = 'Symphony no. 3 "The Sunday Symphony": III. Relaxation (Gaily)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17449 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:9c27b2af-3cab-4b3b-8d28-742d715b2eab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c27b2af-3cab-4b3b-8d28-742d715b2eab', 3, 'III', 'Relaxation (Gaily)', 'Symphony no. 3 "The Sunday Symphony": III. Relaxation (Gaily)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17449 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c27b2af-3cab-4b3b-8d28-742d715b2eab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Day''s End and a New Beginning (Resolutely)', part.name_en = 'Symphony no. 3 "The Sunday Symphony": IV. Day''s End and a New Beginning (Resolutely)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17449 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:c5eca993-1aa7-4e1b-924b-8ef1d18b7523' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5eca993-1aa7-4e1b-924b-8ef1d18b7523', 4, 'IV', 'Day''s End and a New Beginning (Resolutely)', 'Symphony no. 3 "The Sunday Symphony": IV. Day''s End and a New Beginning (Resolutely)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17449 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5eca993-1aa7-4e1b-924b-8ef1d18b7523'
);


-- None 교향곡 4번 "Autochthonous"

UPDATE pieces piece
SET piece.title = '교향곡 4번 "Autochthonous"', piece.title_en = 'Symphony no. 4 "Autochthonous"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17120 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderately', part.name_en = 'Symphony no. 4 "Autochthonous": I. Moderately',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17120 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:c24e6bdd-5183-445f-97d0-8d47bf74d69a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c24e6bdd-5183-445f-97d0-8d47bf74d69a', 1, 'I', 'Moderately', 'Symphony no. 4 "Autochthonous": I. Moderately', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17120 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c24e6bdd-5183-445f-97d0-8d47bf74d69a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Slowly', part.name_en = 'Symphony no. 4 "Autochthonous": II. Slowly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17120 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:0e620f0e-7724-425f-963e-5ff1dc34be8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e620f0e-7724-425f-963e-5ff1dc34be8b', 2, 'II', 'Slowly', 'Symphony no. 4 "Autochthonous": II. Slowly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17120 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e620f0e-7724-425f-963e-5ff1dc34be8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'With a graceful lilt', part.name_en = 'Symphony no. 4 "Autochthonous": III. With a graceful lilt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17120 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:feced6b2-fe6b-40cb-9b8a-52ee193e0bc8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:feced6b2-fe6b-40cb-9b8a-52ee193e0bc8', 3, 'III', 'With a graceful lilt', 'Symphony no. 4 "Autochthonous": III. With a graceful lilt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17120 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:feced6b2-fe6b-40cb-9b8a-52ee193e0bc8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Slowly and reverently', part.name_en = 'Symphony no. 4 "Autochthonous": IV. Slowly and reverently',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17120 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:bde18310-ec96-4054-b7aa-01b6c4c3a395' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bde18310-ec96-4054-b7aa-01b6c4c3a395', 4, 'IV', 'Slowly and reverently', 'Symphony no. 4 "Autochthonous": IV. Slowly and reverently', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17120 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bde18310-ec96-4054-b7aa-01b6c4c3a395'
);


-- None 교향곡 5번 "Western Hemisphere"

UPDATE pieces piece
SET piece.title = '교향곡 5번 "Western Hemisphere"', piece.title_en = 'Symphony no. 5 "Western Hemisphere"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16700 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Briskly', part.name_en = 'Symphony no. 5 "Western Hemisphere": I. Briskly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16700 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:a34ba489-e78f-4ba1-97d5-6978e2ff8276' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a34ba489-e78f-4ba1-97d5-6978e2ff8276', 1, 'I', 'Briskly', 'Symphony no. 5 "Western Hemisphere": I. Briskly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16700 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a34ba489-e78f-4ba1-97d5-6978e2ff8276'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Slower, and with utmost grace', part.name_en = 'Symphony no. 5 "Western Hemisphere": II. Slower, and with utmost grace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16700 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:5335c7e3-4252-4609-89fe-8895b6c57f49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5335c7e3-4252-4609-89fe-8895b6c57f49', 2, 'II', 'Slower, and with utmost grace', 'Symphony no. 5 "Western Hemisphere": II. Slower, and with utmost grace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16700 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5335c7e3-4252-4609-89fe-8895b6c57f49'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Energetically', part.name_en = 'Symphony no. 5 "Western Hemisphere": III. Energetically',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16700 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:7e700242-2697-4e6d-ad14-cbfcb80bb311' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e700242-2697-4e6d-ad14-cbfcb80bb311', 3, 'III', 'Energetically', 'Symphony no. 5 "Western Hemisphere": III. Energetically', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16700 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e700242-2697-4e6d-ad14-cbfcb80bb311'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Moderately', part.name_en = 'Symphony no. 5 "Western Hemisphere": IV. Moderately',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16700 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:9e5a98a5-3e31-4161-9f1b-2ec85f3813ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e5a98a5-3e31-4161-9f1b-2ec85f3813ed', 4, 'IV', 'Moderately', 'Symphony no. 5 "Western Hemisphere": IV. Moderately', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16700 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e5a98a5-3e31-4161-9f1b-2ec85f3813ed'
);


-- None The American Scene

UPDATE pieces piece
SET piece.title = 'The American Scene', piece.title_en = 'The American Scene',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16911 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The American Scene Suite No. 1, "The East"', part.name_en = 'The American Scene Suite No. 1, "The East"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16911 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:63fc35dd-c41c-48ab-b66c-5f9cda196069' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63fc35dd-c41c-48ab-b66c-5f9cda196069', 1, NULL, 'The American Scene Suite No. 1, "The East"', 'The American Scene Suite No. 1, "The East"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16911 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63fc35dd-c41c-48ab-b66c-5f9cda196069'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:63fc35dd-c41c-48ab-b66c-5f9cda196069'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'On the Village Green', part.name_en = 'The American Scene Suite No. 1, "The East": I. On the Village Green',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16911 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:868d1de0-e9ef-48a3-b1e7-94a511d848bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:868d1de0-e9ef-48a3-b1e7-94a511d848bc', 1, NULL, 'On the Village Green', 'The American Scene Suite No. 1, "The East": I. On the Village Green', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:63fc35dd-c41c-48ab-b66c-5f9cda196069'
WHERE p.id = 16911 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:868d1de0-e9ef-48a3-b1e7-94a511d848bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:63fc35dd-c41c-48ab-b66c-5f9cda196069'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Berkshire Night', part.name_en = 'The American Scene Suite No. 1, "The East": II. Berkshire Night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16911 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:57590df8-a101-4889-85c0-fd873675fe16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:57590df8-a101-4889-85c0-fd873675fe16', 2, NULL, 'Berkshire Night', 'The American Scene Suite No. 1, "The East": II. Berkshire Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:63fc35dd-c41c-48ab-b66c-5f9cda196069'
WHERE p.id = 16911 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57590df8-a101-4889-85c0-fd873675fe16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:63fc35dd-c41c-48ab-b66c-5f9cda196069'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Manhattan Skyline', part.name_en = 'The American Scene Suite No. 1, "The East": III. Manhattan Skyline',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16911 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:30d9714f-3928-4cc0-a13e-559e588d2e24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:30d9714f-3928-4cc0-a13e-559e588d2e24', 3, NULL, 'Manhattan Skyline', 'The American Scene Suite No. 1, "The East": III. Manhattan Skyline', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:63fc35dd-c41c-48ab-b66c-5f9cda196069'
WHERE p.id = 16911 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30d9714f-3928-4cc0-a13e-559e588d2e24'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The American Scene Suite No. 2, "The South"', part.name_en = 'The American Scene Suite No. 2, "The South"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16911 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:c7f8fb36-c3f2-403f-95f4-ae6a7d7448e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7f8fb36-c3f2-403f-95f4-ae6a7d7448e9', 2, NULL, 'The American Scene Suite No. 2, "The South"', 'The American Scene Suite No. 2, "The South"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16911 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7f8fb36-c3f2-403f-95f4-ae6a7d7448e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c7f8fb36-c3f2-403f-95f4-ae6a7d7448e9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Florida Night (Soft Loveliness)', part.name_en = 'The American Scene Suite No. 2, "The South": I. Florida Night (Soft Loveliness)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16911 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:1a6bfe88-2b35-47c0-b314-1ac0588c0fdb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1a6bfe88-2b35-47c0-b314-1ac0588c0fdb', 1, NULL, 'Florida Night (Soft Loveliness)', 'The American Scene Suite No. 2, "The South": I. Florida Night (Soft Loveliness)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c7f8fb36-c3f2-403f-95f4-ae6a7d7448e9'
WHERE p.id = 16911 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a6bfe88-2b35-47c0-b314-1ac0588c0fdb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c7f8fb36-c3f2-403f-95f4-ae6a7d7448e9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Levee Land (Birthplace of Blues and Spirituals)', part.name_en = 'The American Scene Suite No. 2, "The South": II. Levee Land (Birthplace of Blues and Spirituals)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16911 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:a5d77579-3772-4e29-b53f-72ef8fade369' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a5d77579-3772-4e29-b53f-72ef8fade369', 2, NULL, 'Levee Land (Birthplace of Blues and Spirituals)', 'The American Scene Suite No. 2, "The South": II. Levee Land (Birthplace of Blues and Spirituals)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c7f8fb36-c3f2-403f-95f4-ae6a7d7448e9'
WHERE p.id = 16911 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5d77579-3772-4e29-b53f-72ef8fade369'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c7f8fb36-c3f2-403f-95f4-ae6a7d7448e9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'A New Orleans'' Street (The festive spirit of yesterday)', part.name_en = 'The American Scene Suite No. 2, "The South": III. A New Orleans'' Street (The festive spirit of yesterday)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16911 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:4a8cf3a9-04f9-4371-be75-e594639e0ea6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4a8cf3a9-04f9-4371-be75-e594639e0ea6', 3, NULL, 'A New Orleans'' Street (The festive spirit of yesterday)', 'The American Scene Suite No. 2, "The South": III. A New Orleans'' Street (The festive spirit of yesterday)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c7f8fb36-c3f2-403f-95f4-ae6a7d7448e9'
WHERE p.id = 16911 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a8cf3a9-04f9-4371-be75-e594639e0ea6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The American Scene Suite No. 3, "The Old West"', part.name_en = 'The American Scene Suite No. 3, "The Old West"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16911 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:f3587043-87a8-4c3b-87b5-bf44b7fdfa8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3587043-87a8-4c3b-87b5-bf44b7fdfa8b', 3, NULL, 'The American Scene Suite No. 3, "The Old West"', 'The American Scene Suite No. 3, "The Old West"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16911 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3587043-87a8-4c3b-87b5-bf44b7fdfa8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f3587043-87a8-4c3b-87b5-bf44b7fdfa8b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Song of the Plainsmen', part.name_en = 'The American Scene Suite No. 3, "The Old West": I. Song of the Plainsmen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16911 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:8166fc0e-976b-43e0-a74b-7a5b0fb5138d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8166fc0e-976b-43e0-a74b-7a5b0fb5138d', 1, NULL, 'Song of the Plainsmen', 'The American Scene Suite No. 3, "The Old West": I. Song of the Plainsmen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f3587043-87a8-4c3b-87b5-bf44b7fdfa8b'
WHERE p.id = 16911 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8166fc0e-976b-43e0-a74b-7a5b0fb5138d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f3587043-87a8-4c3b-87b5-bf44b7fdfa8b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sioux Love Song (Based on a Sioux Melody)', part.name_en = 'The American Scene Suite No. 3, "The Old West": II. Sioux Love Song (Based on a Sioux Melody)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16911 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:a62b8169-1f06-46c7-832c-84ed34bc1f50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a62b8169-1f06-46c7-832c-84ed34bc1f50', 2, NULL, 'Sioux Love Song (Based on a Sioux Melody)', 'The American Scene Suite No. 3, "The Old West": II. Sioux Love Song (Based on a Sioux Melody)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f3587043-87a8-4c3b-87b5-bf44b7fdfa8b'
WHERE p.id = 16911 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a62b8169-1f06-46c7-832c-84ed34bc1f50'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f3587043-87a8-4c3b-87b5-bf44b7fdfa8b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Tribal Dance', part.name_en = 'The American Scene Suite No. 3, "The Old West": III. Tribal Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16911 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:7a6c6975-c740-4154-9fd4-bbb0ae4d482e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7a6c6975-c740-4154-9fd4-bbb0ae4d482e', 3, NULL, 'Tribal Dance', 'The American Scene Suite No. 3, "The Old West": III. Tribal Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f3587043-87a8-4c3b-87b5-bf44b7fdfa8b'
WHERE p.id = 16911 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a6c6975-c740-4154-9fd4-bbb0ae4d482e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'The American Scene Suite No. 4, "The Far West"', part.name_en = 'The American Scene Suite No. 4, "The Far West"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16911 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:ac8cf537-badb-42ed-b9ef-05b84e1df1ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac8cf537-badb-42ed-b9ef-05b84e1df1ac', 4, NULL, 'The American Scene Suite No. 4, "The Far West"', 'The American Scene Suite No. 4, "The Far West"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16911 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac8cf537-badb-42ed-b9ef-05b84e1df1ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ac8cf537-badb-42ed-b9ef-05b84e1df1ac'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Plaza (Los Angeles)', part.name_en = 'The American Scene Suite No. 4, "The Far West": I. The Plaza (Los Angeles)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16911 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:70e9530b-46be-4173-aa03-e2cc14a4cabe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:70e9530b-46be-4173-aa03-e2cc14a4cabe', 1, NULL, 'The Plaza (Los Angeles)', 'The American Scene Suite No. 4, "The Far West": I. The Plaza (Los Angeles)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ac8cf537-badb-42ed-b9ef-05b84e1df1ac'
WHERE p.id = 16911 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70e9530b-46be-4173-aa03-e2cc14a4cabe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ac8cf537-badb-42ed-b9ef-05b84e1df1ac'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sundown Land', part.name_en = 'The American Scene Suite No. 4, "The Far West": II. Sundown Land',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16911 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:caa069e7-5590-4e19-baef-6993172252c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:caa069e7-5590-4e19-baef-6993172252c3', 2, NULL, 'Sundown Land', 'The American Scene Suite No. 4, "The Far West": II. Sundown Land', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ac8cf537-badb-42ed-b9ef-05b84e1df1ac'
WHERE p.id = 16911 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:caa069e7-5590-4e19-baef-6993172252c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ac8cf537-badb-42ed-b9ef-05b84e1df1ac'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Navaho Country', part.name_en = 'The American Scene Suite No. 4, "The Far West": III. Navaho Country',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16911 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:162555a0-a44a-44fb-8322-9eee204e11ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:162555a0-a44a-44fb-8322-9eee204e11ff', 3, NULL, 'Navaho Country', 'The American Scene Suite No. 4, "The Far West": III. Navaho Country', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ac8cf537-badb-42ed-b9ef-05b84e1df1ac'
WHERE p.id = 16911 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:162555a0-a44a-44fb-8322-9eee204e11ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'The American Scene Suite No. 5, "A Mountain, a Memorial, and a Song"', part.name_en = 'The American Scene Suite No. 5, "A Mountain, a Memorial, and a Song"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16911 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:0c4ded06-800a-4448-ba81-09c4cc11f9a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c4ded06-800a-4448-ba81-09c4cc11f9a5', 5, NULL, 'The American Scene Suite No. 5, "A Mountain, a Memorial, and a Song"', 'The American Scene Suite No. 5, "A Mountain, a Memorial, and a Song"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16911 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c4ded06-800a-4448-ba81-09c4cc11f9a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0c4ded06-800a-4448-ba81-09c4cc11f9a5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Grand Teton (A symbol of America''s strength)', part.name_en = 'The American Scene Suite No. 5, "A Mountain, a Memorial, and a Song": I. Grand Teton (A symbol of America''s strength)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16911 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:10fb83d1-7508-4ba5-9c2d-441360643b4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:10fb83d1-7508-4ba5-9c2d-441360643b4c', 1, NULL, 'Grand Teton (A symbol of America''s strength)', 'The American Scene Suite No. 5, "A Mountain, a Memorial, and a Song": I. Grand Teton (A symbol of America''s strength)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0c4ded06-800a-4448-ba81-09c4cc11f9a5'
WHERE p.id = 16911 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10fb83d1-7508-4ba5-9c2d-441360643b4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0c4ded06-800a-4448-ba81-09c4cc11f9a5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tomb of the Unknown Soldier ("Our Boys" will never be forgotten)', part.name_en = 'The American Scene Suite No. 5, "A Mountain, a Memorial, and a Song": II. Tomb of the Unknown Soldier ("Our Boys" will never be forgotten)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16911 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:40bbdbea-eea0-405c-b6ae-0b0b68e9dc7e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:40bbdbea-eea0-405c-b6ae-0b0b68e9dc7e', 2, NULL, 'Tomb of the Unknown Soldier ("Our Boys" will never be forgotten)', 'The American Scene Suite No. 5, "A Mountain, a Memorial, and a Song": II. Tomb of the Unknown Soldier ("Our Boys" will never be forgotten)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0c4ded06-800a-4448-ba81-09c4cc11f9a5'
WHERE p.id = 16911 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40bbdbea-eea0-405c-b6ae-0b0b68e9dc7e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0c4ded06-800a-4448-ba81-09c4cc11f9a5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Song of the Rivermen (They sing of the Mississippi)', part.name_en = 'The American Scene Suite No. 5, "A Mountain, a Memorial, and a Song": III. Song of the Rivermen (They sing of the Mississippi)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16911 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:c6b03b11-e00d-474e-8066-e912a8ea357b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c6b03b11-e00d-474e-8066-e912a8ea357b', 3, NULL, 'Song of the Rivermen (They sing of the Mississippi)', 'The American Scene Suite No. 5, "A Mountain, a Memorial, and a Song": III. Song of the Rivermen (They sing of the Mississippi)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0c4ded06-800a-4448-ba81-09c4cc11f9a5'
WHERE p.id = 16911 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6b03b11-e00d-474e-8066-e912a8ea357b'
);


-- None 가곡 <The Breath of a Rose>

UPDATE pieces piece
SET piece.title = '가곡 <The Breath of a Rose>', piece.title_en = 'The Breath of a Rose',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17057 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Three Rhythmic Spirituals

UPDATE pieces piece
SET piece.title = 'Three Rhythmic Spirituals', piece.title_en = 'Three Rhythmic Spirituals',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17166 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Lord I Looked Down the Road', part.name_en = 'Three Rhythmic Spirituals: No. 1. Lord I Looked Down the Road',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17166 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:93be3a55-ba49-4d42-8df1-72cc4b1eb654' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93be3a55-ba49-4d42-8df1-72cc4b1eb654', 1, NULL, 'Lord I Looked Down the Road', 'Three Rhythmic Spirituals: No. 1. Lord I Looked Down the Road', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17166 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93be3a55-ba49-4d42-8df1-72cc4b1eb654'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Hard Trials', part.name_en = 'Three Rhythmic Spirituals: No. 2. Hard Trials',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17166 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:29777287-0406-4133-a171-047df59164a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29777287-0406-4133-a171-047df59164a3', 2, NULL, 'Hard Trials', 'Three Rhythmic Spirituals: No. 2. Hard Trials', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17166 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29777287-0406-4133-a171-047df59164a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Holy Spirit Don''t You Leave Me', part.name_en = 'Three Rhythmic Spirituals: No. 3. Holy Spirit Don''t You Leave Me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17166 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:bc43bff1-0789-43c5-a0f0-456403346a2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc43bff1-0789-43c5-a0f0-456403346a2c', 3, NULL, 'Holy Spirit Don''t You Leave Me', 'Three Rhythmic Spirituals: No. 3. Holy Spirit Don''t You Leave Me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17166 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc43bff1-0789-43c5-a0f0-456403346a2c'
);


-- None Three Visions

UPDATE pieces piece
SET piece.title = 'Three Visions', piece.title_en = 'Three Visions',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16279 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Dark Horsemen', part.name_en = 'Three Visions: I. Dark Horsemen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16279 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:ec880046-49a2-453d-89ed-23ff76de1f17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec880046-49a2-453d-89ed-23ff76de1f17', 1, 'I', 'Dark Horsemen', 'Three Visions: I. Dark Horsemen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16279 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec880046-49a2-453d-89ed-23ff76de1f17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Summerland', part.name_en = 'Three Visions: II. Summerland',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16279 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:feacf600-c49a-4536-b772-970317bf0327' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:feacf600-c49a-4536-b772-970317bf0327', 2, 'II', 'Summerland', 'Three Visions: II. Summerland', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16279 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:feacf600-c49a-4536-b772-970317bf0327'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Radiant Pinnacle', part.name_en = 'Three Visions: III. Radiant Pinnacle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16279 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:8239aa6b-b3d5-4f5b-ba99-7b02e98b2cae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8239aa6b-b3d5-4f5b-ba99-7b02e98b2cae', 3, 'III', 'Radiant Pinnacle', 'Three Visions: III. Radiant Pinnacle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16279 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8239aa6b-b3d5-4f5b-ba99-7b02e98b2cae'
);


-- None Two Vignettes for Violin and Piano

UPDATE pieces piece
SET piece.title = 'Two Vignettes for Violin and Piano', piece.title_en = 'Two Vignettes for Violin and Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16504 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Carmela', part.name_en = 'Two Vignettes for Violin and Piano: Carmela',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16504 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:8f7e94ea-7050-4485-a647-c2fa914848a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f7e94ea-7050-4485-a647-c2fa914848a1', 1, NULL, 'Carmela', 'Two Vignettes for Violin and Piano: Carmela', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16504 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f7e94ea-7050-4485-a647-c2fa914848a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Bambelele E Espin Garda', part.name_en = 'Two Vignettes for Violin and Piano: Bambelele E Espin Garda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16504 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:e8903219-3dfb-48da-9358-12dc6feded67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8903219-3dfb-48da-9358-12dc6feded67', 2, NULL, 'Bambelele E Espin Garda', 'Two Vignettes for Violin and Piano: Bambelele E Espin Garda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16504 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8903219-3dfb-48da-9358-12dc6feded67'
);


-- None 가곡 <Up There>

UPDATE pieces piece
SET piece.title = '가곡 <Up There>', piece.title_en = 'Up There',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19132 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Weeping Angel (Grief)>

UPDATE pieces piece
SET piece.title = '가곡 <Weeping Angel (Grief)>', piece.title_en = 'Weeping Angel (Grief)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16703 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Wood Notes

UPDATE pieces piece
SET piece.title = 'Wood Notes', piece.title_en = 'Wood Notes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17790 AND piece.composer_id = 291
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Singing River (Moderately Slow)', part.name_en = 'Wood Notes: I. Singing River (Moderately Slow)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17790 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:4c98723a-1727-43c7-b5e9-c94fe994678f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c98723a-1727-43c7-b5e9-c94fe994678f', 1, 'I', 'Singing River (Moderately Slow)', 'Wood Notes: I. Singing River (Moderately Slow)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17790 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c98723a-1727-43c7-b5e9-c94fe994678f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Autumn Night (Lightly)', part.name_en = 'Wood Notes: II. Autumn Night (Lightly)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17790 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:17e7298b-c5da-42dc-bd82-290440bcd116' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17e7298b-c5da-42dc-bd82-290440bcd116', 2, 'II', 'Autumn Night (Lightly)', 'Wood Notes: II. Autumn Night (Lightly)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17790 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17e7298b-c5da-42dc-bd82-290440bcd116'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Moon Dusk (Slowly and Expressively)', part.name_en = 'Wood Notes: III. Moon Dusk (Slowly and Expressively)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17790 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:8bec7305-c3dc-4583-b6ed-7116dbd35a3d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bec7305-c3dc-4583-b6ed-7116dbd35a3d', 3, 'III', 'Moon Dusk (Slowly and Expressively)', 'Wood Notes: III. Moon Dusk (Slowly and Expressively)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17790 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bec7305-c3dc-4583-b6ed-7116dbd35a3d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Whippoorwill''s Shoes (Humorously)', part.name_en = 'Wood Notes: IV. Whippoorwill''s Shoes (Humorously)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17790 AND p.composer_id = 291 AND part.part_key = 'musicbrainz:dd4917ad-a299-4578-8f81-f7bccf28aadf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd4917ad-a299-4578-8f81-f7bccf28aadf', 4, 'IV', 'Whippoorwill''s Shoes (Humorously)', 'Wood Notes: IV. Whippoorwill''s Shoes (Humorously)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17790 AND p.composer_id = 291
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd4917ad-a299-4578-8f81-f7bccf28aadf'
);


-- None Africa

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Africa', 'Africa', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 291
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Africa'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'afe87af0-a821-486f-8b55-a11e5fdf9e14'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'afe87af0-a821-486f-8b55-a11e5fdf9e14'
FROM pieces p
WHERE p.composer_id = 291 AND p.title = 'Africa' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'afe87af0-a821-486f-8b55-a11e5fdf9e14'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:baf2ae45-1231-484d-8764-87f260704f84', 1, 'I', 'Land of Peace', 'Africa: I. Land of Peace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 291 AND p.title = 'Africa' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:baf2ae45-1231-484d-8764-87f260704f84'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ce9f323-20c7-4d7d-bf24-9043cec079eb', 2, 'II', 'Land of Romance', 'Africa: II. Land of Romance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 291 AND p.title = 'Africa' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ce9f323-20c7-4d7d-bf24-9043cec079eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:270832a5-c3d6-4dd7-850c-8b48114dea96', 3, 'III', 'Land of Superstition', 'Africa: III. Land of Superstition', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 291 AND p.title = 'Africa' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:270832a5-c3d6-4dd7-850c-8b48114dea96'
);


-- None 연가곡집 <From the Hearts of Women>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <From the Hearts of Women>', 'From the Hearts of Women', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 291
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <From the Hearts of Women>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a5232e70-e2a3-4363-9764-9252ed002282'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a5232e70-e2a3-4363-9764-9252ed002282'
FROM pieces p
WHERE p.composer_id = 291 AND p.title = '연가곡집 <From the Hearts of Women>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a5232e70-e2a3-4363-9764-9252ed002282'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0d71372-8382-44a3-b6e0-4ab49e8078bb', 1, NULL, 'Little Mother', 'From the Hearts of Women: No. 1. Little Mother', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 291 AND p.title = '연가곡집 <From the Hearts of Women>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0d71372-8382-44a3-b6e0-4ab49e8078bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c92705df-1f16-49ab-aa22-8c8655d9d8b2', 2, NULL, 'Midtide', 'From the Hearts of Women: No. 2. Midtide', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 291 AND p.title = '연가곡집 <From the Hearts of Women>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c92705df-1f16-49ab-aa22-8c8655d9d8b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdaf7db9-57bf-48e0-849f-46704e3f5b10', 3, NULL, 'Coquette', 'From the Hearts of Women: No. 3. Coquette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 291 AND p.title = '연가곡집 <From the Hearts of Women>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdaf7db9-57bf-48e0-849f-46704e3f5b10'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b39cd1e-1f15-4d74-bd81-a9b8baddafe2', 4, NULL, 'Bereft', 'From the Hearts of Women: No. 4. Bereft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 291 AND p.title = '연가곡집 <From the Hearts of Women>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b39cd1e-1f15-4d74-bd81-a9b8baddafe2'
);


-- None 가곡 <Here's One>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Here''s One>', 'Here''s One', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 291
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Here''s One>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b790941f-7e73-4c7b-9cbc-4370461fd579'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b790941f-7e73-4c7b-9cbc-4370461fd579'
FROM pieces p
WHERE p.composer_id = 291 AND p.title = '가곡 <Here''s One>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b790941f-7e73-4c7b-9cbc-4370461fd579'
);


-- None In Memoriam

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'In Memoriam', 'In Memoriam', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 291
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'In Memoriam'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9835a1e3-e508-4253-a829-24c8a3fd5575'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9835a1e3-e508-4253-a829-24c8a3fd5575'
FROM pieces p
WHERE p.composer_id = 291 AND p.title = 'In Memoriam' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9835a1e3-e508-4253-a829-24c8a3fd5575'
);


-- None 가곡 <Mississippi>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Mississippi>', 'Mississippi', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 291
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Mississippi>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0dc5e23c-6bc0-4034-9004-9801f657231d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0dc5e23c-6bc0-4034-9004-9801f657231d'
FROM pieces p
WHERE p.composer_id = 291 AND p.title = '가곡 <Mississippi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0dc5e23c-6bc0-4034-9004-9801f657231d'
);


-- None Pastorela

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Pastorela', 'Pastorela', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 291
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Pastorela'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '59aa79c9-bd11-4439-90cc-d755744d99f5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '59aa79c9-bd11-4439-90cc-d755744d99f5'
FROM pieces p
WHERE p.composer_id = 291 AND p.title = 'Pastorela' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '59aa79c9-bd11-4439-90cc-d755744d99f5'
);


-- None 전주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡', 'Prelude', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 291
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '044c876c-28b2-4096-896b-b38e857ab9fe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '044c876c-28b2-4096-896b-b38e857ab9fe'
FROM pieces p
WHERE p.composer_id = 291 AND p.title = '전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '044c876c-28b2-4096-896b-b38e857ab9fe'
);


-- None Quit Dat Fool'nish

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Quit Dat Fool''nish', 'Quit Dat Fool''nish', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 291
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Quit Dat Fool''nish'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd73cdcb4-7f71-4f95-ab27-e09dcd2c9bc0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd73cdcb4-7f71-4f95-ab27-e09dcd2c9bc0'
FROM pieces p
WHERE p.composer_id = 291 AND p.title = 'Quit Dat Fool''nish' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd73cdcb4-7f71-4f95-ab27-e09dcd2c9bc0'
);


-- None 세레나데

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세레나데', 'Serenade', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 291
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세레나데'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2da1cfc0-5869-477c-a3e0-11b981fe88b1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2da1cfc0-5869-477c-a3e0-11b981fe88b1'
FROM pieces p
WHERE p.composer_id = 291 AND p.title = '세레나데' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2da1cfc0-5869-477c-a3e0-11b981fe88b1'
);


-- None 바이올린과 피아노를 위한 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 모음곡', 'Suite for Violin and Piano', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 291
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3712d2dd-5ccc-4ada-92e7-f4fdaede2260'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3712d2dd-5ccc-4ada-92e7-f4fdaede2260'
FROM pieces p
WHERE p.composer_id = 291 AND p.title = '바이올린과 피아노를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3712d2dd-5ccc-4ada-92e7-f4fdaede2260'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d493a781-6ae4-4745-804a-f8701ac3ebef', 1, 'I', 'African Dancer', 'Suite for Violin and Piano: I. African Dancer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 291 AND p.title = '바이올린과 피아노를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d493a781-6ae4-4745-804a-f8701ac3ebef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d330ef4-89f1-4b9c-b68f-c857b8bb4199', 2, 'II', 'Mother and Child', 'Suite for Violin and Piano: II. Mother and Child', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 291 AND p.title = '바이올린과 피아노를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d330ef4-89f1-4b9c-b68f-c857b8bb4199'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1feb3c63-ba1f-4496-a97f-dd9bb46896f6', 3, 'III', 'Gamin', 'Suite for Violin and Piano: III. Gamin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 291 AND p.title = '바이올린과 피아노를 위한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1feb3c63-ba1f-4496-a97f-dd9bb46896f6'
);


-- None Summerland

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Summerland', 'Summerland', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 291
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Summerland'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '50136308-02cc-437a-8f72-81efb8fc1d64'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '50136308-02cc-437a-8f72-81efb8fc1d64'
FROM pieces p
WHERE p.composer_id = 291 AND p.title = 'Summerland' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '50136308-02cc-437a-8f72-81efb8fc1d64'
);


-- 숨길 seed 작품 없음
