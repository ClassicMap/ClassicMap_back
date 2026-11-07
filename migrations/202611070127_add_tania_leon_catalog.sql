-- Tania León 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 27개(묶음 1, 다악장 1, 낱곡 25),
-- 새 작품 1개, part 9개, 그 아래 0개.
-- seed 27개 중 26개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.
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

-- None A la Par

UPDATE pieces piece
SET piece.title = 'A la Par', piece.title_en = 'A la Par',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17237 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Abanico

UPDATE pieces piece
SET piece.title = 'Abanico', piece.title_en = 'Abanico',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20003 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Anima

UPDATE pieces piece
SET piece.title = 'Anima', piece.title_en = 'Anima',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17474 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Axon

UPDATE pieces piece
SET piece.title = 'Axon', piece.title_en = 'Axon',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19669 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Ciego reto>

UPDATE pieces piece
SET piece.title = '가곡 <Ciego reto>', piece.title_en = 'Ciego reto',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15974 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Homenaje a Prokofiew

UPDATE pieces piece
SET piece.title = 'Homenaje a Prokofiew', piece.title_en = 'Homenaje a Prokofiew',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17680 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Homenatge

UPDATE pieces piece
SET piece.title = 'Homenatge', piece.title_en = 'Homenatge',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17859 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Horizons

UPDATE pieces piece
SET piece.title = 'Horizons', piece.title_en = 'Horizons',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18746 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Indígena

UPDATE pieces piece
SET piece.title = 'Indígena', piece.title_en = 'Indígena',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17677 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Inura

UPDATE pieces piece
SET piece.title = 'Inura', piece.title_en = 'Inura',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17473 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The Power', part.name_en = 'Inura: I. The Power',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17473 AND p.composer_id = 235 AND part.part_key = 'musicbrainz:e83231f0-151b-4703-9e81-e3aa80ed9461' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e83231f0-151b-4703-9e81-e3aa80ed9461', 1, 'I', 'The Power', 'Inura: I. The Power', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17473 AND p.composer_id = 235
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e83231f0-151b-4703-9e81-e3aa80ed9461'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Sharing', part.name_en = 'Inura: II. The Sharing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17473 AND p.composer_id = 235 AND part.part_key = 'musicbrainz:78971c93-8868-4efb-9f44-f600d4fb0eb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78971c93-8868-4efb-9f44-f600d4fb0eb0', 2, 'II', 'The Sharing', 'Inura: II. The Sharing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17473 AND p.composer_id = 235
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78971c93-8868-4efb-9f44-f600d4fb0eb0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Teaching', part.name_en = 'Inura: III. Teaching',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17473 AND p.composer_id = 235 AND part.part_key = 'musicbrainz:55eff231-4766-4017-9f94-b86c0db96ba4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55eff231-4766-4017-9f94-b86c0db96ba4', 3, 'III', 'Teaching', 'Inura: III. Teaching', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17473 AND p.composer_id = 235
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55eff231-4766-4017-9f94-b86c0db96ba4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Understanding', part.name_en = 'Inura: IV. Understanding',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17473 AND p.composer_id = 235 AND part.part_key = 'musicbrainz:d14f75e1-0a8e-4103-a41b-f2f8732f96c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d14f75e1-0a8e-4103-a41b-f2f8732f96c8', 4, 'IV', 'Understanding', 'Inura: IV. Understanding', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17473 AND p.composer_id = 235
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d14f75e1-0a8e-4103-a41b-f2f8732f96c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Respect', part.name_en = 'Inura: V. Respect',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17473 AND p.composer_id = 235 AND part.part_key = 'musicbrainz:6d28f3cc-625a-42de-b7f7-737418441140' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d28f3cc-625a-42de-b7f7-737418441140', 5, 'V', 'Respect', 'Inura: V. Respect', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17473 AND p.composer_id = 235
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d28f3cc-625a-42de-b7f7-737418441140'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'The Lust', part.name_en = 'Inura: VI. The Lust',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17473 AND p.composer_id = 235 AND part.part_key = 'musicbrainz:11b952b5-a846-430c-854f-837c54dd440d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11b952b5-a846-430c-854f-837c54dd440d', 6, 'VI', 'The Lust', 'Inura: VI. The Lust', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17473 AND p.composer_id = 235
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11b952b5-a846-430c-854f-837c54dd440d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Funny Battle', part.name_en = 'Inura: VII. Funny Battle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17473 AND p.composer_id = 235 AND part.part_key = 'musicbrainz:4a5aa2d7-e96b-45c7-91f3-2738e93e0285' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a5aa2d7-e96b-45c7-91f3-2738e93e0285', 7, 'VII', 'Funny Battle', 'Inura: VII. Funny Battle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17473 AND p.composer_id = 235
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a5aa2d7-e96b-45c7-91f3-2738e93e0285'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Manifest', part.name_en = 'Inura: VIII. Manifest',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17473 AND p.composer_id = 235 AND part.part_key = 'musicbrainz:d4ed2cad-0f4e-4900-b8cc-00ddfbd07268' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4ed2cad-0f4e-4900-b8cc-00ddfbd07268', 8, 'VIII', 'Manifest', 'Inura: VIII. Manifest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17473 AND p.composer_id = 235
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4ed2cad-0f4e-4900-b8cc-00ddfbd07268'
);


-- None Kabiosile

UPDATE pieces piece
SET piece.title = 'Kabiosile', piece.title_en = 'Kabiosile',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18855 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 부수음악 <Maggie Magalita>

UPDATE pieces piece
SET piece.title = '부수음악 <Maggie Magalita>', piece.title_en = 'Maggie Magalita',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17174 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La conga de Maggie Magalita', part.name_en = 'Maggie Magalita: La conga de Maggie Magalita',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17174 AND p.composer_id = 235 AND part.part_key = 'musicbrainz:7866d038-da6f-4c05-8966-5c01861c8f98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7866d038-da6f-4c05-8966-5c01861c8f98', 1, NULL, 'La conga de Maggie Magalita', 'Maggie Magalita: La conga de Maggie Magalita', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17174 AND p.composer_id = 235
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7866d038-da6f-4c05-8966-5c01861c8f98'
);


-- None Momentum

UPDATE pieces piece
SET piece.title = 'Momentum', piece.title_en = 'Momentum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17145 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mística

UPDATE pieces piece
SET piece.title = 'Mística', piece.title_en = 'Mística',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18578 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Parajota Delaté

UPDATE pieces piece
SET piece.title = 'Parajota Delaté', piece.title_en = 'Parajota Delaté',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20019 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pasajes

UPDATE pieces piece
SET piece.title = 'Pasajes', piece.title_en = 'Pasajes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18942 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 1번 "Sorpresa"

UPDATE pieces piece
SET piece.title = '전주곡 1번 "Sorpresa"', piece.title_en = 'Prelude no. 1 "Sorpresa"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19635 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 2번 "Pecera"

UPDATE pieces piece
SET piece.title = '전주곡 2번 "Pecera"', piece.title_en = 'Prelude no. 2 "Pecera"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17321 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Raices

UPDATE pieces piece
SET piece.title = 'Raices', piece.title_en = 'Raices',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18952 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rituál

UPDATE pieces piece
SET piece.title = 'Rituál', piece.title_en = 'Rituál',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17272 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rondo a la criolla

UPDATE pieces piece
SET piece.title = 'Rondo a la criolla', piece.title_en = 'Rondo a la criolla',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17519 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Saoko

UPDATE pieces piece
SET piece.title = 'Saoko', piece.title_en = 'Saoko',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19867 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Stride

UPDATE pieces piece
SET piece.title = 'Stride', piece.title_en = 'Stride',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16337 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tumbao

UPDATE pieces piece
SET piece.title = 'Tumbao', piece.title_en = 'Tumbao',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18002 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Variación

UPDATE pieces piece
SET piece.title = 'Variación', piece.title_en = 'Variación',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17034 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None del Caribe, soy!

UPDATE pieces piece
SET piece.title = 'del Caribe, soy!', piece.title_en = 'del Caribe, soy!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17611 AND piece.composer_id = 235
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Haiku

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Haiku', 'Haiku', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 235
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Haiku'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86e4a712-5402-456b-a04c-9228646bbe4a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '86e4a712-5402-456b-a04c-9228646bbe4a'
FROM pieces p
WHERE p.composer_id = 235 AND p.title = 'Haiku' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86e4a712-5402-456b-a04c-9228646bbe4a'
);


-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 235 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    17898
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
