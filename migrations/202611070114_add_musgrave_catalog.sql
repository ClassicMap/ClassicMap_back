-- Thea Musgrave 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 44개(묶음 4, 다악장 9, 낱곡 31),
-- 새 작품 6개, part 66개, 그 아래 4개.
-- seed 40개 중 38개를 작품·part 에 잇고, 2개를 숨기고, 0개는 그대로 둔다.
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

-- None Bassoon Concerto “Out of the Darkness”

UPDATE pieces piece
SET piece.title = 'Bassoon Concerto “Out of the Darkness”', piece.title_en = 'Bassoon Concerto “Out of the Darkness”',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24676 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chamber Concerto no. 2

UPDATE pieces piece
SET piece.title = 'Chamber Concerto no. 2', piece.title_en = 'Chamber Concerto no. 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24635 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Colloquy

UPDATE pieces piece
SET piece.title = 'Colloquy', piece.title_en = 'Colloquy',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24326 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Colloquy: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24326 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:bb102dc5-be81-425e-ab89-69d2848ec1e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb102dc5-be81-425e-ab89-69d2848ec1e1', 1, NULL, 'I', 'Colloquy: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24326 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb102dc5-be81-425e-ab89-69d2848ec1e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Colloquy: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24326 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:f317695e-7a33-4497-aeb2-4a14860ad665' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f317695e-7a33-4497-aeb2-4a14860ad665', 2, NULL, 'II', 'Colloquy: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24326 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f317695e-7a33-4497-aeb2-4a14860ad665'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Colloquy: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24326 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:2d4a11b7-7b5e-4405-87bd-200b7d1cb5bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d4a11b7-7b5e-4405-87bd-200b7d1cb5bb', 3, NULL, 'III', 'Colloquy: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24326 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d4a11b7-7b5e-4405-87bd-200b7d1cb5bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Colloquy: IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24326 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:01fcb8b2-1a01-4ee5-84fd-180a4f036ca9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01fcb8b2-1a01-4ee5-84fd-180a4f036ca9', 4, NULL, 'IV', 'Colloquy: IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24326 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01fcb8b2-1a01-4ee5-84fd-180a4f036ca9'
);


-- None Excursions

UPDATE pieces piece
SET piece.title = 'Excursions', piece.title_en = 'Excursions',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25949 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato (Driving in the Highlands)', part.name_en = 'Excursions: I. Moderato (Driving in the Highlands)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25949 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:e2bf012a-26f5-45f3-814a-be5d2c39f3c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2bf012a-26f5-45f3-814a-be5d2c39f3c8', 1, 'I', 'Moderato (Driving in the Highlands)', 'Excursions: I. Moderato (Driving in the Highlands)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25949 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2bf012a-26f5-45f3-814a-be5d2c39f3c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Pesante (The Road Hog)', part.name_en = 'Excursions: II. Pesante (The Road Hog)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25949 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:089d1712-5f7a-4c3c-9651-a41ff2d821c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:089d1712-5f7a-4c3c-9651-a41ff2d821c1', 2, 'II', 'Pesante (The Road Hog)', 'Excursions: II. Pesante (The Road Hog)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25949 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:089d1712-5f7a-4c3c-9651-a41ff2d821c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Semplice (Learner-Driver)', part.name_en = 'Excursions: III. Semplice (Learner-Driver)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25949 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:2856e42d-baea-421c-b292-d2f8a41c4602' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2856e42d-baea-421c-b292-d2f8a41c4602', 3, 'III', 'Semplice (Learner-Driver)', 'Excursions: III. Semplice (Learner-Driver)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25949 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2856e42d-baea-421c-b292-d2f8a41c4602'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Con brio (The Drunken Driver)', part.name_en = 'Excursions: IV. Con brio (The Drunken Driver)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25949 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:add08aff-e6e1-49e1-973b-2635fa3d4d0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:add08aff-e6e1-49e1-973b-2635fa3d4d0d', 4, 'IV', 'Con brio (The Drunken Driver)', 'Excursions: IV. Con brio (The Drunken Driver)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25949 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:add08aff-e6e1-49e1-973b-2635fa3d4d0d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Piacevole (The Sunday Driver)', part.name_en = 'Excursions: V. Piacevole (The Sunday Driver)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25949 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:18cee6a3-3057-4246-b0d8-e954894e217c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18cee6a3-3057-4246-b0d8-e954894e217c', 5, 'V', 'Piacevole (The Sunday Driver)', 'Excursions: V. Piacevole (The Sunday Driver)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25949 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18cee6a3-3057-4246-b0d8-e954894e217c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Scherzo (Roadside Repairs)', part.name_en = 'Excursions: VI. Scherzo (Roadside Repairs)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25949 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:ef5b0fc0-cc68-461a-9a20-a5d50ebb9704' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef5b0fc0-cc68-461a-9a20-a5d50ebb9704', 6, 'VI', 'Scherzo (Roadside Repairs)', 'Excursions: VI. Scherzo (Roadside Repairs)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25949 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef5b0fc0-cc68-461a-9a20-a5d50ebb9704'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Misterioso (Fog on the Motorway)', part.name_en = 'Excursions: VII. Misterioso (Fog on the Motorway)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25949 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:832ec611-f3cc-44cf-847b-7154c8b4ba87' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:832ec611-f3cc-44cf-847b-7154c8b4ba87', 7, 'VII', 'Misterioso (Fog on the Motorway)', 'Excursions: VII. Misterioso (Fog on the Motorway)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25949 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:832ec611-f3cc-44cf-847b-7154c8b4ba87'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Allegro (Backseat Driver)', part.name_en = 'Excursions: VIII. Allegro (Backseat Driver)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25949 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:f9676305-8b6d-4242-be83-55dd1e5005d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9676305-8b6d-4242-be83-55dd1e5005d0', 8, 'VIII', 'Allegro (Backseat Driver)', 'Excursions: VIII. Allegro (Backseat Driver)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25949 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9676305-8b6d-4242-be83-55dd1e5005d0'
);


-- None 5개의 가곡

UPDATE pieces piece
SET piece.title = '5개의 가곡', piece.title_en = 'Five Songs for Spring',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24036 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None From Darkness Into the Light

UPDATE pieces piece
SET piece.title = 'From Darkness Into the Light', piece.title_en = 'From Darkness Into the Light',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25802 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Helios

UPDATE pieces piece
SET piece.title = 'Helios', piece.title_en = 'Helios',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25798 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 호른 협주곡

UPDATE pieces piece
SET piece.title = '호른 협주곡', piece.title_en = 'Horn Concerto',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25458 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 즉흥곡 1번

UPDATE pieces piece
SET piece.title = '즉흥곡 1번', piece.title_en = 'Impromptu no. 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23371 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In the Still of the Night

UPDATE pieces piece
SET piece.title = 'In the Still of the Night', piece.title_en = 'In the Still of the Night',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23390 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ithaca

UPDATE pieces piece
SET piece.title = 'Ithaca', piece.title_en = 'Ithaca',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25561 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Journey Through a Japanese Landscape

UPDATE pieces piece
SET piece.title = 'Journey Through a Japanese Landscape', piece.title_en = 'Journey Through a Japanese Landscape',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24660 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Spring', part.name_en = 'Journey Through a Japanese Landscape: I. Spring',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24660 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:de753eb5-5ae7-48bb-bab5-80048ade1aa9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de753eb5-5ae7-48bb-bab5-80048ade1aa9', 1, 'I', 'Spring', 'Journey Through a Japanese Landscape: I. Spring', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24660 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de753eb5-5ae7-48bb-bab5-80048ade1aa9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Summer', part.name_en = 'Journey Through a Japanese Landscape: II. Summer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24660 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:0504e969-2b2f-4cc3-b31d-eb37153a1f6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0504e969-2b2f-4cc3-b31d-eb37153a1f6a', 2, 'II', 'Summer', 'Journey Through a Japanese Landscape: II. Summer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24660 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0504e969-2b2f-4cc3-b31d-eb37153a1f6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Autumn', part.name_en = 'Journey Through a Japanese Landscape: III. Autumn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24660 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:5f551c5e-632b-4155-941f-f14cca6a7c1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f551c5e-632b-4155-941f-f14cca6a7c1c', 3, 'III', 'Autumn', 'Journey Through a Japanese Landscape: III. Autumn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24660 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f551c5e-632b-4155-941f-f14cca6a7c1c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Winter', part.name_en = 'Journey Through a Japanese Landscape: IV. Winter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24660 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:40d1a707-671a-41f6-8d7b-ab07ae75727b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40d1a707-671a-41f6-8d7b-ab07ae75727b', 4, 'IV', 'Winter', 'Journey Through a Japanese Landscape: IV. Winter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24660 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40d1a707-671a-41f6-8d7b-ab07ae75727b'
);


-- None Light at the End of the Tunnel

UPDATE pieces piece
SET piece.title = 'Light at the End of the Tunnel', piece.title_en = 'Light at the End of the Tunnel',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25392 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Loch Ness - A Postcard From Scotland

UPDATE pieces piece
SET piece.title = 'Loch Ness - A Postcard From Scotland', piece.title_en = 'Loch Ness - A Postcard From Scotland',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25393 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Mary, Queen of Scots>

UPDATE pieces piece
SET piece.title = '오페라 <Mary, Queen of Scots>', piece.title_en = 'Mary, Queen of Scots',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25950 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Mary, Queen of Scots: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25950 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:97c9092a-e54b-4c45-86cd-8a630601ea56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97c9092a-e54b-4c45-86cd-8a630601ea56', 1, NULL, 'Act I', 'Mary, Queen of Scots: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25950 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97c9092a-e54b-4c45-86cd-8a630601ea56'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Mary, Queen of Scots: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25950 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:08e408c8-b1e1-414d-9641-b32de35b719f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08e408c8-b1e1-414d-9641-b32de35b719f', 2, NULL, 'Act II', 'Mary, Queen of Scots: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25950 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08e408c8-b1e1-414d-9641-b32de35b719f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act III', part.name_en = 'Mary, Queen of Scots: Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25950 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:311933e9-309a-40e9-aa33-bd0fb07ef380' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:311933e9-309a-40e9-aa33-bd0fb07ef380', 3, NULL, 'Act III', 'Mary, Queen of Scots: Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25950 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:311933e9-309a-40e9-aa33-bd0fb07ef380'
);


-- None Memento Vitae

UPDATE pieces piece
SET piece.title = 'Memento Vitae', piece.title_en = 'Memento Vitae',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25984 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Memento creatoris>

UPDATE pieces piece
SET piece.title = '가곡 <Memento creatoris>', piece.title_en = 'Memento creatoris',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23676 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Midnight>

UPDATE pieces piece
SET piece.title = '가곡 <Midnight>', piece.title_en = 'Midnight',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25568 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Monologue

UPDATE pieces piece
SET piece.title = 'Monologue', piece.title_en = 'Monologue',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23742 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music for Horn and Piano

UPDATE pieces piece
SET piece.title = 'Music for Horn and Piano', piece.title_en = 'Music for Horn and Piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24202 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Night Music

UPDATE pieces piece
SET piece.title = 'Night Music', piece.title_en = 'Night Music',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25113 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None On the Underground

UPDATE pieces piece
SET piece.title = 'On the Underground', piece.title_en = 'On the Underground',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24596 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Set no. 1 "On Gratitude, Love and Madness"', part.name_en = 'On the Underground, Set no. 1 "On Gratitude, Love and Madness"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24596 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:0ed8e951-a28b-4ad7-8ea9-cd260090177d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ed8e951-a28b-4ad7-8ea9-cd260090177d', 1, NULL, 'Set no. 1 "On Gratitude, Love and Madness"', 'On the Underground, Set no. 1 "On Gratitude, Love and Madness"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24596 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ed8e951-a28b-4ad7-8ea9-cd260090177d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Set no. 2 “The Strange and the Exotic”', part.name_en = 'On the Underground, Set no. 2 “The Strange and the Exotic”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24596 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:ce6660bc-3975-433f-88a2-a6a56aa1de1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce6660bc-3975-433f-88a2-a6a56aa1de1a', 2, NULL, 'Set no. 2 “The Strange and the Exotic”', 'On the Underground, Set no. 2 “The Strange and the Exotic”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24596 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce6660bc-3975-433f-88a2-a6a56aa1de1a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ce6660bc-3975-433f-88a2-a6a56aa1de1a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dreams', part.name_en = 'On the Underground, Set no. 2 “The Strange and the Exotic”: I. Dreams',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24596 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:2c35db08-877a-4422-8de7-3df558ccfb58' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2c35db08-877a-4422-8de7-3df558ccfb58', 1, NULL, 'Dreams', 'On the Underground, Set no. 2 “The Strange and the Exotic”: I. Dreams', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ce6660bc-3975-433f-88a2-a6a56aa1de1a'
WHERE p.id = 24596 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c35db08-877a-4422-8de7-3df558ccfb58'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ce6660bc-3975-433f-88a2-a6a56aa1de1a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'I Saw a Peacock With a Fiery Tail', part.name_en = 'On the Underground, Set no. 2 “The Strange and the Exotic”: II. I Saw a Peacock With a Fiery Tail',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24596 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:2b0271be-ac91-4ac4-a917-18435004d6e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2b0271be-ac91-4ac4-a917-18435004d6e0', 2, NULL, 'I Saw a Peacock With a Fiery Tail', 'On the Underground, Set no. 2 “The Strange and the Exotic”: II. I Saw a Peacock With a Fiery Tail', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ce6660bc-3975-433f-88a2-a6a56aa1de1a'
WHERE p.id = 24596 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b0271be-ac91-4ac4-a917-18435004d6e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ce6660bc-3975-433f-88a2-a6a56aa1de1a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Subway Piranhas', part.name_en = 'On the Underground, Set no. 2 “The Strange and the Exotic”: III. The Subway Piranhas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24596 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:08f4b398-b773-4456-97fd-2deceac23562' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:08f4b398-b773-4456-97fd-2deceac23562', 3, NULL, 'The Subway Piranhas', 'On the Underground, Set no. 2 “The Strange and the Exotic”: III. The Subway Piranhas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ce6660bc-3975-433f-88a2-a6a56aa1de1a'
WHERE p.id = 24596 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08f4b398-b773-4456-97fd-2deceac23562'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ce6660bc-3975-433f-88a2-a6a56aa1de1a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Dreams (reprise)', part.name_en = 'On the Underground, Set no. 2 “The Strange and the Exotic”: IV. Dreams (reprise)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24596 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:42f485cd-81e5-4c2f-989c-0dd137d592ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:42f485cd-81e5-4c2f-989c-0dd137d592ef', 4, NULL, 'Dreams (reprise)', 'On the Underground, Set no. 2 “The Strange and the Exotic”: IV. Dreams (reprise)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ce6660bc-3975-433f-88a2-a6a56aa1de1a'
WHERE p.id = 24596 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42f485cd-81e5-4c2f-989c-0dd137d592ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Set no. 3 "A Medieval Summer"', part.name_en = 'On the Underground, Set no. 3 "A Medieval Summer"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24596 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:08b2ba1c-0c4a-404b-9972-7fd283ef1a4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08b2ba1c-0c4a-404b-9972-7fd283ef1a4e', 3, NULL, 'Set no. 3 "A Medieval Summer"', 'On the Underground, Set no. 3 "A Medieval Summer"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24596 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08b2ba1c-0c4a-404b-9972-7fd283ef1a4e'
);


-- None Orfeo II

UPDATE pieces piece
SET piece.title = 'Orfeo II', piece.title_en = 'Orfeo II',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24689 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Orfeo laments', part.name_en = 'Orfeo II: I. Orfeo laments',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24689 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:2bdf0c2e-87b4-4d7f-883d-a75c0ac25398' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bdf0c2e-87b4-4d7f-883d-a75c0ac25398', 1, 'I', 'Orfeo laments', 'Orfeo II: I. Orfeo laments', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24689 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bdf0c2e-87b4-4d7f-883d-a75c0ac25398'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Orfeo crosses the river Styx', part.name_en = 'Orfeo II: II. Orfeo crosses the river Styx',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24689 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:6feb77cb-e31a-42f9-b01e-6a5f4473fde2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6feb77cb-e31a-42f9-b01e-6a5f4473fde2', 2, 'II', 'Orfeo crosses the river Styx', 'Orfeo II: II. Orfeo crosses the river Styx', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24689 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6feb77cb-e31a-42f9-b01e-6a5f4473fde2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Orfeo calms the Furies', part.name_en = 'Orfeo II: III. Orfeo calms the Furies',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24689 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:d7e104f8-b205-418d-8f15-31410ef52089' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7e104f8-b205-418d-8f15-31410ef52089', 3, 'III', 'Orfeo calms the Furies', 'Orfeo II: III. Orfeo calms the Furies', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24689 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7e104f8-b205-418d-8f15-31410ef52089'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Orfeo searches amongst the Shades', part.name_en = 'Orfeo II: IV. Orfeo searches amongst the Shades',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24689 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:ea30cc60-8752-4189-ba8d-dd41b3454e4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea30cc60-8752-4189-ba8d-dd41b3454e4c', 4, 'IV', 'Orfeo searches amongst the Shades', 'Orfeo II: IV. Orfeo searches amongst the Shades', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24689 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea30cc60-8752-4189-ba8d-dd41b3454e4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Orfeo hears Euridice''s pleas', part.name_en = 'Orfeo II: V. Orfeo hears Euridice''s pleas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24689 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:014d01e9-ef0e-435a-9a54-b0b890e9e991' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:014d01e9-ef0e-435a-9a54-b0b890e9e991', 5, 'V', 'Orfeo hears Euridice''s pleas', 'Orfeo II: V. Orfeo hears Euridice''s pleas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24689 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:014d01e9-ef0e-435a-9a54-b0b890e9e991'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Orfeo is attacked by the Bacchantes', part.name_en = 'Orfeo II: VI. Orfeo is attacked by the Bacchantes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24689 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:79bf5fa9-02d0-4c5e-aee8-61b83827b6d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79bf5fa9-02d0-4c5e-aee8-61b83827b6d9', 6, 'VI', 'Orfeo is attacked by the Bacchantes', 'Orfeo II: VI. Orfeo is attacked by the Bacchantes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24689 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79bf5fa9-02d0-4c5e-aee8-61b83827b6d9'
);


-- None Phoenix Rising

UPDATE pieces piece
SET piece.title = 'Phoenix Rising', piece.title_en = 'Phoenix Rising',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24889 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pierrot

UPDATE pieces piece
SET piece.title = 'Pierrot', piece.title_en = 'Pierrot',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24898 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Pierrot: Andante espressivo', part.name_en = 'Pierrot: I. Pierrot: Andante espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24898 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:68976da4-e4fe-485b-8016-2077d7a3dd2b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68976da4-e4fe-485b-8016-2077d7a3dd2b', 1, 'I', 'Pierrot: Andante espressivo', 'Pierrot: I. Pierrot: Andante espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24898 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68976da4-e4fe-485b-8016-2077d7a3dd2b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Columbine: Con frivolezza', part.name_en = 'Pierrot: II. Columbine: Con frivolezza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24898 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:5e936a4d-b350-4ce4-a699-42827cdb30f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e936a4d-b350-4ce4-a699-42827cdb30f0', 2, 'II', 'Columbine: Con frivolezza', 'Pierrot: II. Columbine: Con frivolezza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24898 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e936a4d-b350-4ce4-a699-42827cdb30f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Pierrot’s Serenade: Spettrale', part.name_en = 'Pierrot: III. Pierrot’s Serenade: Spettrale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24898 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:cb168dfa-b3ed-4cb0-8552-f9c956ee1261' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb168dfa-b3ed-4cb0-8552-f9c956ee1261', 3, 'III', 'Pierrot’s Serenade: Spettrale', 'Pierrot: III. Pierrot’s Serenade: Spettrale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24898 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb168dfa-b3ed-4cb0-8552-f9c956ee1261'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Harlequin: Con energia', part.name_en = 'Pierrot: IV. Harlequin: Con energia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24898 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:242cce2f-c145-4199-bed2-c342f4423b94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:242cce2f-c145-4199-bed2-c342f4423b94', 4, 'IV', 'Harlequin: Con energia', 'Pierrot: IV. Harlequin: Con energia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24898 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:242cce2f-c145-4199-bed2-c342f4423b94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Harlequin attacks Pierrot: Furioso', part.name_en = 'Pierrot: V. Harlequin attacks Pierrot: Furioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24898 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:a3660f8d-076a-46e0-83c4-d40739baf246' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3660f8d-076a-46e0-83c4-d40739baf246', 5, 'V', 'Harlequin attacks Pierrot: Furioso', 'Pierrot: V. Harlequin attacks Pierrot: Furioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24898 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3660f8d-076a-46e0-83c4-d40739baf246'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Columbine rejects Pierrot: Molto meno mosso', part.name_en = 'Pierrot: VI. Columbine rejects Pierrot: Molto meno mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24898 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:fab57797-ac32-461e-9ad2-e80d510af9a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fab57797-ac32-461e-9ad2-e80d510af9a6', 6, 'VI', 'Columbine rejects Pierrot: Molto meno mosso', 'Pierrot: VI. Columbine rejects Pierrot: Molto meno mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24898 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fab57797-ac32-461e-9ad2-e80d510af9a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Harlequin’s Serenade: Sensuale', part.name_en = 'Pierrot: VII. Harlequin’s Serenade: Sensuale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24898 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:6a53e033-ec0c-4858-80fa-f858414cef06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a53e033-ec0c-4858-80fa-f858414cef06', 7, 'VII', 'Harlequin’s Serenade: Sensuale', 'Pierrot: VII. Harlequin’s Serenade: Sensuale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24898 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a53e033-ec0c-4858-80fa-f858414cef06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Pierrot: Andante espressivo', part.name_en = 'Pierrot: VIII. Pierrot: Andante espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24898 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:38f90bd8-5db5-430e-b44d-f1e3141529f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38f90bd8-5db5-430e-b44d-f1e3141529f5', 8, 'VIII', 'Pierrot: Andante espressivo', 'Pierrot: VIII. Pierrot: Andante espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24898 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38f90bd8-5db5-430e-b44d-f1e3141529f5'
);


-- None Rainbow

UPDATE pieces piece
SET piece.title = 'Rainbow', piece.title_en = 'Rainbow',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24343 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rorate coeli

UPDATE pieces piece
SET piece.title = 'Rorate coeli', piece.title_en = 'Rorate coeli',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25618 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Simón Bolívar>

UPDATE pieces piece
SET piece.title = '오페라 <Simón Bolívar>', piece.title_en = 'Simón Bolívar',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25231 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Song of the Enchanter

UPDATE pieces piece
SET piece.title = 'Song of the Enchanter', piece.title_en = 'Song of the Enchanter',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24210 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Songs for a Winter's Evening

UPDATE pieces piece
SET piece.title = 'Songs for a Winter''s Evening', piece.title_en = 'Songs for a Winter''s Evening',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23752 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I Am My Mammy’s Ae Bairn', part.name_en = 'Songs for a Winter’s Evening: No. 1. I Am My Mammy’s Ae Bairn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23752 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:34e10fca-6ed6-4cf5-a2d1-b9324ce5954a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34e10fca-6ed6-4cf5-a2d1-b9324ce5954a', 1, NULL, 'I Am My Mammy’s Ae Bairn', 'Songs for a Winter’s Evening: No. 1. I Am My Mammy’s Ae Bairn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23752 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34e10fca-6ed6-4cf5-a2d1-b9324ce5954a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Summer’s a Pleasant Time', part.name_en = 'Songs for a Winter’s Evening: No. 2. Summer’s a Pleasant Time',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23752 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:919587a9-203b-4fae-b84c-ebb72fef3764' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:919587a9-203b-4fae-b84c-ebb72fef3764', 2, NULL, 'Summer’s a Pleasant Time', 'Songs for a Winter’s Evening: No. 2. Summer’s a Pleasant Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23752 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:919587a9-203b-4fae-b84c-ebb72fef3764'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'O, Whistle an’ I’ll Come to Ye, My Lad!', part.name_en = 'Songs for a Winter’s Evening: No. 3. O, Whistle an’ I’ll Come to Ye, My Lad!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23752 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:73824261-7433-456a-9d8b-f92dd8d972dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73824261-7433-456a-9d8b-f92dd8d972dd', 3, NULL, 'O, Whistle an’ I’ll Come to Ye, My Lad!', 'Songs for a Winter’s Evening: No. 3. O, Whistle an’ I’ll Come to Ye, My Lad!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23752 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73824261-7433-456a-9d8b-f92dd8d972dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ca’ the Yowes to the Knowes', part.name_en = 'Songs for a Winter’s Evening: No. 4. Ca’ the Yowes to the Knowes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23752 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:78a36c7f-fc9d-42ee-b20a-bbd757cab7ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78a36c7f-fc9d-42ee-b20a-bbd757cab7ff', 4, NULL, 'Ca’ the Yowes to the Knowes', 'Songs for a Winter’s Evening: No. 4. Ca’ the Yowes to the Knowes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23752 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78a36c7f-fc9d-42ee-b20a-bbd757cab7ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Ye Banks and Braes O’ Bonnie Doon', part.name_en = 'Songs for a Winter’s Evening: No. 5. Ye Banks and Braes O’ Bonnie Doon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23752 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:46caa022-d8fd-486c-80b1-132858c17653' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46caa022-d8fd-486c-80b1-132858c17653', 5, NULL, 'Ye Banks and Braes O’ Bonnie Doon', 'Songs for a Winter’s Evening: No. 5. Ye Banks and Braes O’ Bonnie Doon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23752 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46caa022-d8fd-486c-80b1-132858c17653'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Jamie Come Try Me', part.name_en = 'Songs for a Winter’s Evening: No. 6. Jamie Come Try Me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23752 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:8188a6bd-0b26-456d-a7f3-19fc45933fbe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8188a6bd-0b26-456d-a7f3-19fc45933fbe', 6, NULL, 'Jamie Come Try Me', 'Songs for a Winter’s Evening: No. 6. Jamie Come Try Me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23752 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8188a6bd-0b26-456d-a7f3-19fc45933fbe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'John Anderson My Jo', part.name_en = 'Songs for a Winter’s Evening: No. 7. John Anderson My Jo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23752 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:4ac0007a-8810-419a-a031-33a5ce46600b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ac0007a-8810-419a-a031-33a5ce46600b', 7, NULL, 'John Anderson My Jo', 'Songs for a Winter’s Evening: No. 7. John Anderson My Jo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23752 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ac0007a-8810-419a-a031-33a5ce46600b'
);


-- None Space Play

UPDATE pieces piece
SET piece.title = 'Space Play', piece.title_en = 'Space Play',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24787 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Phoenix and the Turtle

UPDATE pieces piece
SET piece.title = 'The Phoenix and the Turtle', piece.title_en = 'The Phoenix and the Turtle',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23393 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Seasons

UPDATE pieces piece
SET piece.title = 'The Seasons', piece.title_en = 'The Seasons',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24068 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Autumn', part.name_en = 'The Seasons: I. Autumn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24068 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:9b699fb5-e02e-4a7f-b59d-6f295f124910' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b699fb5-e02e-4a7f-b59d-6f295f124910', 1, 'I', 'Autumn', 'The Seasons: I. Autumn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24068 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b699fb5-e02e-4a7f-b59d-6f295f124910'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Winter', part.name_en = 'The Seasons: II. Winter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24068 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:4347b5ad-0941-4117-9307-8ee706622fbc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4347b5ad-0941-4117-9307-8ee706622fbc', 2, 'II', 'Winter', 'The Seasons: II. Winter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24068 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4347b5ad-0941-4117-9307-8ee706622fbc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Spring', part.name_en = 'The Seasons: III. Spring',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24068 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:89531810-da9e-4ae1-ac3f-d441e68b06cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89531810-da9e-4ae1-ac3f-d441e68b06cf', 3, 'III', 'Spring', 'The Seasons: III. Spring', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24068 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89531810-da9e-4ae1-ac3f-d441e68b06cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Summer', part.name_en = 'The Seasons: IV. Summer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24068 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:737d6b43-133e-48c6-b4f2-896522ad080d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:737d6b43-133e-48c6-b4f2-896522ad080d', 4, 'IV', 'Summer', 'The Seasons: IV. Summer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24068 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:737d6b43-133e-48c6-b4f2-896522ad080d'
);


-- None Triptych

UPDATE pieces piece
SET piece.title = 'Triptych', piece.title_en = 'Triptych',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24711 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Turbulent Landscapes

UPDATE pieces piece
SET piece.title = 'Turbulent Landscapes', piece.title_en = 'Turbulent Landscapes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23855 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sunrise With Sea Monsters', part.name_en = 'Turbulent Landscapes: I. Sunrise With Sea Monsters',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23855 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:d780557c-77d5-453d-94c0-936abbb573ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d780557c-77d5-453d-94c0-936abbb573ee', 1, 'I', 'Sunrise With Sea Monsters', 'Turbulent Landscapes: I. Sunrise With Sea Monsters', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23855 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d780557c-77d5-453d-94c0-936abbb573ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Shipwreck', part.name_en = 'Turbulent Landscapes: II. The Shipwreck',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23855 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:98949e69-9423-4cfb-8000-ac57846fcaed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98949e69-9423-4cfb-8000-ac57846fcaed', 2, 'II', 'The Shipwreck', 'Turbulent Landscapes: II. The Shipwreck', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23855 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98949e69-9423-4cfb-8000-ac57846fcaed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Snow Storm. Hannibal and His Army Crossing the Alps', part.name_en = 'Turbulent Landscapes: III. Snow Storm. Hannibal and His Army Crossing the Alps',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23855 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:8aeade32-81b6-4d53-8d91-1edb91044727' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8aeade32-81b6-4d53-8d91-1edb91044727', 3, 'III', 'Snow Storm. Hannibal and His Army Crossing the Alps', 'Turbulent Landscapes: III. Snow Storm. Hannibal and His Army Crossing the Alps', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23855 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8aeade32-81b6-4d53-8d91-1edb91044727'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'War. The Exile and the Rock Limpet', part.name_en = 'Turbulent Landscapes: IV. War. The Exile and the Rock Limpet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23855 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:b3c57d3b-5fbc-4806-8101-cb52a33fcccb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3c57d3b-5fbc-4806-8101-cb52a33fcccb', 4, 'IV', 'War. The Exile and the Rock Limpet', 'Turbulent Landscapes: IV. War. The Exile and the Rock Limpet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23855 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3c57d3b-5fbc-4806-8101-cb52a33fcccb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '16th October, 1834. The Burning of the Houses of Parliament', part.name_en = 'Turbulent Landscapes: V. 16th October, 1834. The Burning of the Houses of Parliament',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23855 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:31bbdf5b-bd0e-4879-9e87-e3efa757e947' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31bbdf5b-bd0e-4879-9e87-e3efa757e947', 5, 'V', '16th October, 1834. The Burning of the Houses of Parliament', 'Turbulent Landscapes: V. 16th October, 1834. The Burning of the Houses of Parliament', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23855 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31bbdf5b-bd0e-4879-9e87-e3efa757e947'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Sunrise, With a Boat Between Headlands', part.name_en = 'Turbulent Landscapes: VI. Sunrise, With a Boat Between Headlands',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23855 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:a0dc0bad-fe69-4b5a-af1d-1766dd79a6d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0dc0bad-fe69-4b5a-af1d-1766dd79a6d8', 6, 'VI', 'Sunrise, With a Boat Between Headlands', 'Turbulent Landscapes: VI. Sunrise, With a Boat Between Headlands', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23855 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0dc0bad-fe69-4b5a-af1d-1766dd79a6d8'
);


-- None Two's Company

UPDATE pieces piece
SET piece.title = 'Two''s Company', piece.title_en = 'Two''s Company',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24312 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Desolate, Lonely', part.name_en = 'Two’s Company: I. Desolate, Lonely',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24312 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:1d8f7ea1-3902-4de1-8679-964fe0b13f2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d8f7ea1-3902-4de1-8679-964fe0b13f2f', 1, 'I', 'Desolate, Lonely', 'Two’s Company: I. Desolate, Lonely', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24312 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d8f7ea1-3902-4de1-8679-964fe0b13f2f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Frivolous, Playful', part.name_en = 'Two’s Company: II. Frivolous, Playful',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24312 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:e82a11e0-9a6d-452a-b34b-cd05d42d818f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e82a11e0-9a6d-452a-b34b-cd05d42d818f', 2, 'II', 'Frivolous, Playful', 'Two’s Company: II. Frivolous, Playful', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24312 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e82a11e0-9a6d-452a-b34b-cd05d42d818f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Dramatic. Furious - Expressive', part.name_en = 'Two’s Company: III. Dramatic. Furious - Expressive',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24312 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:52bfece3-6cd0-4f50-b9f7-31477dff7b61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52bfece3-6cd0-4f50-b9f7-31477dff7b61', 3, 'III', 'Dramatic. Furious - Expressive', 'Two’s Company: III. Dramatic. Furious - Expressive', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24312 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52bfece3-6cd0-4f50-b9f7-31477dff7b61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Warm - Passionate - Exultant', part.name_en = 'Two’s Company: IV. Warm - Passionate - Exultant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24312 AND p.composer_id = 433 AND part.part_key = 'musicbrainz:36e91e3b-fe7b-42be-baaa-05aa48a9f8ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36e91e3b-fe7b-42be-baaa-05aa48a9f8ab', 4, 'IV', 'Warm - Passionate - Exultant', 'Two’s Company: IV. Warm - Passionate - Exultant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24312 AND p.composer_id = 433
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36e91e3b-fe7b-42be-baaa-05aa48a9f8ab'
);


-- None 비올라 협주곡

UPDATE pieces piece
SET piece.title = '비올라 협주곡', piece.title_en = 'Viola Concerto',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24169 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Wild Winter I

UPDATE pieces piece
SET piece.title = 'Wild Winter I', piece.title_en = 'Wild Winter I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23319 AND piece.composer_id = 433
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <A Suite o' Bairnsangs>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <A Suite o'' Bairnsangs>', 'A Suite o'' Bairnsangs', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 433
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <A Suite o'' Bairnsangs>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a685f28-80de-498b-8b5d-5501921d810c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1a685f28-80de-498b-8b5d-5501921d810c'
FROM pieces p
WHERE p.composer_id = 433 AND p.title = '연가곡집 <A Suite o'' Bairnsangs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a685f28-80de-498b-8b5d-5501921d810c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5dff97f-e2fe-4c14-868e-c8d73587c2ce', 1, 'I', 'The Man-in-the-Mune', 'A Suite o'' Bairnsangs: I. The Man-in-the-Mune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 433 AND p.title = '연가곡집 <A Suite o'' Bairnsangs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5dff97f-e2fe-4c14-868e-c8d73587c2ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80e31dc2-8bae-4d78-a824-686c5e1811ba', 2, 'II', 'Daffins', 'A Suite o'' Bairnsangs: II. Daffins', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 433 AND p.title = '연가곡집 <A Suite o'' Bairnsangs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80e31dc2-8bae-4d78-a824-686c5e1811ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63b5832e-ac73-41f1-8e3c-284e5cd70be4', 3, 'III', 'Willie Wabster', 'A Suite o'' Bairnsangs: III. Willie Wabster', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 433 AND p.title = '연가곡집 <A Suite o'' Bairnsangs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63b5832e-ac73-41f1-8e3c-284e5cd70be4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c0c6caa-6eb8-467f-9932-c120b19b426e', 4, 'IV', 'A Bairn''s Prayer at Nicht', 'A Suite o'' Bairnsangs: IV. A Bairn''s Prayer at Nicht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 433 AND p.title = '연가곡집 <A Suite o'' Bairnsangs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c0c6caa-6eb8-467f-9932-c120b19b426e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c08fa766-6056-473b-9838-ed5975de3b4e', 5, 'V', 'The Gean', 'A Suite o'' Bairnsangs: V. The Gean', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 433 AND p.title = '연가곡집 <A Suite o'' Bairnsangs>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c08fa766-6056-473b-9838-ed5975de3b4e'
);


-- None Cantilena

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Cantilena', 'Cantilena', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 433
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Cantilena'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ea09d651-4691-4c59-8d6f-e8516fb02e86'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ea09d651-4691-4c59-8d6f-e8516fb02e86'
FROM pieces p
WHERE p.composer_id = 433 AND p.title = 'Cantilena' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ea09d651-4691-4c59-8d6f-e8516fb02e86'
);


-- None 클라리넷 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라리넷 협주곡', 'Clarinet Concerto', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 433
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라리넷 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '36a061d0-b712-4349-a9d5-98006664ed6d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '36a061d0-b712-4349-a9d5-98006664ed6d'
FROM pieces p
WHERE p.composer_id = 433 AND p.title = '클라리넷 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '36a061d0-b712-4349-a9d5-98006664ed6d'
);


-- None 관현악 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 협주곡', 'Concerto for Orchestra', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 433
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef0435d0-3415-4da3-9188-4b81c8d25e22'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ef0435d0-3415-4da3-9188-4b81c8d25e22'
FROM pieces p
WHERE p.composer_id = 433 AND p.title = '관현악 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef0435d0-3415-4da3-9188-4b81c8d25e22'
);


-- None 세레나데

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세레나데', 'Serenade', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 433
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세레나데'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8eb8123b-e61d-4127-9a6c-50d192bcc1ec'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8eb8123b-e61d-4127-9a6c-50d192bcc1ec'
FROM pieces p
WHERE p.composer_id = 433 AND p.title = '세레나데' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8eb8123b-e61d-4127-9a6c-50d192bcc1ec'
);


-- None 목관 5중주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '목관 5중주', 'Wind Quintet', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 433
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '목관 5중주'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06e227f6-de0f-43ea-b4f7-0ebf04cd8ed2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '06e227f6-de0f-43ea-b4f7-0ebf04cd8ed2'
FROM pieces p
WHERE p.composer_id = 433 AND p.title = '목관 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06e227f6-de0f-43ea-b4f7-0ebf04cd8ed2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fd99476-9172-4415-97c6-e58edca54d06', 1, 'I', 'Andante espressivo', 'Wind Quintet: I. Andante espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 433 AND p.title = '목관 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fd99476-9172-4415-97c6-e58edca54d06'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58b83925-3ef3-4075-ac71-b14a307e3a33', 2, 'II', 'Più mosso. Drammatico', 'Wind Quintet: II. Più mosso. Drammatico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 433 AND p.title = '목관 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58b83925-3ef3-4075-ac71-b14a307e3a33'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be3ae4fe-3c67-4968-80fe-69690f9ab735', 3, 'III', 'Mesto elegiaco', 'Wind Quintet: III. Mesto elegiaco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 433 AND p.title = '목관 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be3ae4fe-3c67-4968-80fe-69690f9ab735'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6d01cf8-b874-4c2d-a2c7-b6560dcf4d28', 4, 'IV', 'Pochissimo più mosso. Andante e espressivo', 'Wind Quintet: IV. Pochissimo più mosso. Andante e espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 433 AND p.title = '목관 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6d01cf8-b874-4c2d-a2c7-b6560dcf4d28'
);


-- 카탈로그에 대응이 없는 seed 작품 2개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 433 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    24339, 25185
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
