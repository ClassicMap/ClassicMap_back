-- 작곡가 20명의 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동, 6/9).
-- 작품 150개(새 14개), seed 154개 중 잇기 136·숨김 16·그대로 2.
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

-- ===== Vasco Mendonça (composer_id 337) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 3개(묶음 0, 다악장 3, 낱곡 0),
-- 새 작품 0개, part 8개, 그 아래 0개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Group Together, Avoid Speech

UPDATE pieces piece
SET piece.title = 'Group Together, Avoid Speech', piece.title_en = 'Group Together, Avoid Speech',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16922 AND piece.composer_id = 337
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Solemn, Assertive', part.name_en = 'Group Together, Avoid Speech: I. Solemn, Assertive',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16922 AND p.composer_id = 337 AND part.part_key = 'musicbrainz:1f7a808f-e3be-4eab-b313-7b838c768c04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f7a808f-e3be-4eab-b313-7b838c768c04', 1, 'I', 'Solemn, Assertive', 'Group Together, Avoid Speech: I. Solemn, Assertive', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16922 AND p.composer_id = 337
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f7a808f-e3be-4eab-b313-7b838c768c04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Nocturnal', part.name_en = 'Group Together, Avoid Speech: II. Nocturnal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16922 AND p.composer_id = 337 AND part.part_key = 'musicbrainz:33c7f607-2c6b-43de-8c7c-212501659f48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33c7f607-2c6b-43de-8c7c-212501659f48', 2, 'II', 'Nocturnal', 'Group Together, Avoid Speech: II. Nocturnal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16922 AND p.composer_id = 337
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33c7f607-2c6b-43de-8c7c-212501659f48'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Agitated', part.name_en = 'Group Together, Avoid Speech: III. Agitated',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16922 AND p.composer_id = 337 AND part.part_key = 'musicbrainz:bc2d8074-628d-4f88-9a62-f38b443ba367' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc2d8074-628d-4f88-9a62-f38b443ba367', 3, 'III', 'Agitated', 'Group Together, Avoid Speech: III. Agitated', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16922 AND p.composer_id = 337
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc2d8074-628d-4f88-9a62-f38b443ba367'
);


-- None Step Right Up

UPDATE pieces piece
SET piece.title = 'Step Right Up', piece.title_en = 'Step Right Up',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19459 AND piece.composer_id = 337
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Joyful, Celebratory', part.name_en = 'Step Right Up: I. Joyful, Celebratory',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19459 AND p.composer_id = 337 AND part.part_key = 'musicbrainz:52dac7c3-d9c4-429b-a305-a351c843dfe6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52dac7c3-d9c4-429b-a305-a351c843dfe6', 1, 'I', 'Joyful, Celebratory', 'Step Right Up: I. Joyful, Celebratory', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19459 AND p.composer_id = 337
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52dac7c3-d9c4-429b-a305-a351c843dfe6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Nostalgic, Somewhat Desperate', part.name_en = 'Step Right Up: II. Nostalgic, Somewhat Desperate',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19459 AND p.composer_id = 337 AND part.part_key = 'musicbrainz:ddae432b-0d85-4b45-bdb9-e47da390e08c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddae432b-0d85-4b45-bdb9-e47da390e08c', 2, 'II', 'Nostalgic, Somewhat Desperate', 'Step Right Up: II. Nostalgic, Somewhat Desperate', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19459 AND p.composer_id = 337
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddae432b-0d85-4b45-bdb9-e47da390e08c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Triumphant', part.name_en = 'Step Right Up: III. Triumphant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19459 AND p.composer_id = 337 AND part.part_key = 'musicbrainz:4ee40e2f-ec32-45aa-8686-e3a0a659ab26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ee40e2f-ec32-45aa-8686-e3a0a659ab26', 3, 'III', 'Triumphant', 'Step Right Up: III. Triumphant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19459 AND p.composer_id = 337
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ee40e2f-ec32-45aa-8686-e3a0a659ab26'
);


-- None Unanswerable Light

UPDATE pieces piece
SET piece.title = 'Unanswerable Light', piece.title_en = 'Unanswerable Light',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18550 AND piece.composer_id = 337
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Distant', part.name_en = 'Unanswerable Light: I. Distant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18550 AND p.composer_id = 337 AND part.part_key = 'musicbrainz:b429d283-f925-4e04-8701-cda68d0676a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b429d283-f925-4e04-8701-cda68d0676a9', 1, 'I', 'Distant', 'Unanswerable Light: I. Distant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18550 AND p.composer_id = 337
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b429d283-f925-4e04-8701-cda68d0676a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Grave, Restrained', part.name_en = 'Unanswerable Light: II. Grave, Restrained',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18550 AND p.composer_id = 337 AND part.part_key = 'musicbrainz:59f55165-0280-4833-b153-c225fa6279c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59f55165-0280-4833-b153-c225fa6279c0', 2, 'II', 'Grave, Restrained', 'Unanswerable Light: II. Grave, Restrained', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18550 AND p.composer_id = 337
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59f55165-0280-4833-b153-c225fa6279c0'
);

-- 숨길 seed 작품 없음

-- ===== Hermann Zilcher (composer_id 338) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 3개(묶음 1, 다악장 1, 낱곡 1),
-- 새 작품 0개, part 12개, 그 아래 0개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- Op. 9 협주곡 D단조

UPDATE pieces piece
SET piece.title = '협주곡 D단조', piece.title_en = 'Concerto for Two Violins in D minor, op. 9',
    piece.type = 'song', piece.opus_number = 'Op. 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19802 AND piece.composer_id = 338
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 109 Fünf Duette für zwei Singstimmen und zwei Mundharmonikas in C Op. 109

UPDATE pieces piece
SET piece.title = 'Fünf Duette für zwei Singstimmen und zwei Mundharmonikas in C Op. 109', piece.title_en = 'Fünf Duette für zwei Singstimmen und zwei Mundharmonikas in C, op. 109',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '109',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19913 AND piece.composer_id = 338
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Fünf Duette für zwei Singstimmen und zwei Mundharmonikas in C, op. 109: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19913 AND p.composer_id = 338 AND part.part_key = 'musicbrainz:ddde5e5c-561b-4d92-8046-f5b8db676323' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddde5e5c-561b-4d92-8046-f5b8db676323', 1, NULL, 'I', 'Fünf Duette für zwei Singstimmen und zwei Mundharmonikas in C, op. 109: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19913 AND p.composer_id = 338
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddde5e5c-561b-4d92-8046-f5b8db676323'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Fünf Duette für zwei Singstimmen und zwei Mundharmonikas in C, op. 109: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19913 AND p.composer_id = 338 AND part.part_key = 'musicbrainz:3ecccb5d-be54-4b62-9c43-f393313bea46' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ecccb5d-be54-4b62-9c43-f393313bea46', 2, NULL, 'II', 'Fünf Duette für zwei Singstimmen und zwei Mundharmonikas in C, op. 109: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19913 AND p.composer_id = 338
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ecccb5d-be54-4b62-9c43-f393313bea46'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Fünf Duette für zwei Singstimmen und zwei Mundharmonikas in C, op. 109: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19913 AND p.composer_id = 338 AND part.part_key = 'musicbrainz:fc20d230-72bb-464a-aea1-1fa525cc8ec4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc20d230-72bb-464a-aea1-1fa525cc8ec4', 3, NULL, 'III', 'Fünf Duette für zwei Singstimmen und zwei Mundharmonikas in C, op. 109: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19913 AND p.composer_id = 338
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc20d230-72bb-464a-aea1-1fa525cc8ec4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Fünf Duette für zwei Singstimmen und zwei Mundharmonikas in C, op. 109: IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19913 AND p.composer_id = 338 AND part.part_key = 'musicbrainz:86b02d5d-1ed3-430e-8958-d4528c29da9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86b02d5d-1ed3-430e-8958-d4528c29da9c', 4, NULL, 'IV', 'Fünf Duette für zwei Singstimmen und zwei Mundharmonikas in C, op. 109: IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19913 AND p.composer_id = 338
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86b02d5d-1ed3-430e-8958-d4528c29da9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'V', part.name_en = 'Fünf Duette für zwei Singstimmen und zwei Mundharmonikas in C, op. 109: V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19913 AND p.composer_id = 338 AND part.part_key = 'musicbrainz:50567123-235f-47b0-8812-3164e3ca477c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50567123-235f-47b0-8812-3164e3ca477c', 5, NULL, 'V', 'Fünf Duette für zwei Singstimmen und zwei Mundharmonikas in C, op. 109: V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19913 AND p.composer_id = 338
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50567123-235f-47b0-8812-3164e3ca477c'
);


-- None Rokoko-Suite

UPDATE pieces piece
SET piece.title = 'Rokoko-Suite', piece.title_en = 'Rokoko-Suite',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16739 AND piece.composer_id = 338
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ouvertüre an den Menschen: Freue dich!', part.name_en = 'Rokoko-Suite: I. Ouvertüre an den Menschen: Freue dich!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16739 AND p.composer_id = 338 AND part.part_key = 'musicbrainz:467febd8-47f5-3760-8e4c-e35773f30bfd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:467febd8-47f5-3760-8e4c-e35773f30bfd', 1, 'I', 'Ouvertüre an den Menschen: Freue dich!', 'Rokoko-Suite: I. Ouvertüre an den Menschen: Freue dich!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16739 AND p.composer_id = 338
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:467febd8-47f5-3760-8e4c-e35773f30bfd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Musette: Der Frühling: Erhebt die Häupter froh, ihr Brüder', part.name_en = 'Rokoko-Suite: II. Musette: Der Frühling: Erhebt die Häupter froh, ihr Brüder',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16739 AND p.composer_id = 338 AND part.part_key = 'musicbrainz:64a150c7-3c80-3067-a7f6-7ec3b0e48999' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64a150c7-3c80-3067-a7f6-7ec3b0e48999', 2, 'II', 'Musette: Der Frühling: Erhebt die Häupter froh, ihr Brüder', 'Rokoko-Suite: II. Musette: Der Frühling: Erhebt die Häupter froh, ihr Brüder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16739 AND p.composer_id = 338
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64a150c7-3c80-3067-a7f6-7ec3b0e48999'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sarabande: Abendständchen: Hör, es klagt die Flöte wieder', part.name_en = 'Rokoko-Suite: III. Sarabande: Abendständchen: Hör, es klagt die Flöte wieder',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16739 AND p.composer_id = 338 AND part.part_key = 'musicbrainz:4df300c4-9a4f-3c37-9523-383a08e896fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4df300c4-9a4f-3c37-9523-383a08e896fc', 3, 'III', 'Sarabande: Abendständchen: Hör, es klagt die Flöte wieder', 'Rokoko-Suite: III. Sarabande: Abendständchen: Hör, es klagt die Flöte wieder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16739 AND p.composer_id = 338
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4df300c4-9a4f-3c37-9523-383a08e896fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Air: Die Nacht: Willkommen, angenehme Nacht', part.name_en = 'Rokoko-Suite: IV. Air: Die Nacht: Willkommen, angenehme Nacht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16739 AND p.composer_id = 338 AND part.part_key = 'musicbrainz:71e42e90-e623-32d8-8848-48fb1b13f827' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71e42e90-e623-32d8-8848-48fb1b13f827', 4, 'IV', 'Air: Die Nacht: Willkommen, angenehme Nacht', 'Rokoko-Suite: IV. Air: Die Nacht: Willkommen, angenehme Nacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16739 AND p.composer_id = 338
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71e42e90-e623-32d8-8848-48fb1b13f827'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Fuga burlesca: Die Alte: Zu meiner Zeit bestand noch Recht', part.name_en = 'Rokoko-Suite: V. Fuga burlesca: Die Alte: Zu meiner Zeit bestand noch Recht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16739 AND p.composer_id = 338 AND part.part_key = 'musicbrainz:c0cabd61-665e-3c79-87e6-5357745a4b8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0cabd61-665e-3c79-87e6-5357745a4b8b', 5, 'V', 'Fuga burlesca: Die Alte: Zu meiner Zeit bestand noch Recht', 'Rokoko-Suite: V. Fuga burlesca: Die Alte: Zu meiner Zeit bestand noch Recht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16739 AND p.composer_id = 338
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0cabd61-665e-3c79-87e6-5357745a4b8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Gigue: Mailied: Wie herrlich leuchtet mir die Natur', part.name_en = 'Rokoko-Suite: VI. Gigue: Mailied: Wie herrlich leuchtet mir die Natur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16739 AND p.composer_id = 338 AND part.part_key = 'musicbrainz:5c513ffe-179a-3097-b80c-204cd646a8c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c513ffe-179a-3097-b80c-204cd646a8c2', 6, 'VI', 'Gigue: Mailied: Wie herrlich leuchtet mir die Natur', 'Rokoko-Suite: VI. Gigue: Mailied: Wie herrlich leuchtet mir die Natur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16739 AND p.composer_id = 338
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c513ffe-179a-3097-b80c-204cd646a8c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'An den Menschen: Freu dich! Denn dich zu freu''n', part.name_en = 'Rokoko-Suite: VII. An den Menschen: Freu dich! Denn dich zu freu''n',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16739 AND p.composer_id = 338 AND part.part_key = 'musicbrainz:970c0674-0588-390d-9809-44f6c6e87019' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:970c0674-0588-390d-9809-44f6c6e87019', 7, 'VII', 'An den Menschen: Freu dich! Denn dich zu freu''n', 'Rokoko-Suite: VII. An den Menschen: Freu dich! Denn dich zu freu''n', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16739 AND p.composer_id = 338
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:970c0674-0588-390d-9809-44f6c6e87019'
);

-- 숨길 seed 작품 없음

-- ===== 스즈키 세이이치 (composer_id 339) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 0개(묶음 0, 다악장 0, 낱곡 0),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 2개 중 0개를 작품·part 에 잇고, 2개를 숨기고, 0개는 그대로 둔다.

-- 카탈로그에 대응이 없는 seed 작품 2개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 339 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    16585, 19843
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== José Pablo Moncayo García (composer_id 344) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 8개(묶음 1, 다악장 1, 낱곡 6),
-- 새 작품 0개, part 7개, 그 아래 0개.
-- seed 9개 중 8개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.

-- None Amatzinac

UPDATE pieces piece
SET piece.title = 'Amatzinac', piece.title_en = 'Amatzinac',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25172 AND piece.composer_id = 344
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bosques

UPDATE pieces piece
SET piece.title = 'Bosques', piece.title_en = 'Bosques',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24473 AND piece.composer_id = 344
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <La mulata de Córdoba>

UPDATE pieces piece
SET piece.title = '오페라 <La mulata de Córdoba>', piece.title_en = 'La mulata de Córdoba',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25523 AND piece.composer_id = 344
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Muros verdes

UPDATE pieces piece
SET piece.title = 'Muros verdes', piece.title_en = 'Muros verdes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24584 AND piece.composer_id = 344
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sinfonía

UPDATE pieces piece
SET piece.title = 'Sinfonía', piece.title_en = 'Sinfonía',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23879 AND piece.composer_id = 344
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Sinfonía: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23879 AND p.composer_id = 344 AND part.part_key = 'musicbrainz:809996b0-5473-491e-902f-a2b841512ce0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:809996b0-5473-491e-902f-a2b841512ce0', 1, 'I', 'Allegro', 'Sinfonía: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23879 AND p.composer_id = 344
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:809996b0-5473-491e-902f-a2b841512ce0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo', part.name_en = 'Sinfonía: II. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23879 AND p.composer_id = 344 AND part.part_key = 'musicbrainz:1ed8110c-5031-4be5-9035-6bf87deb94d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ed8110c-5031-4be5-9035-6bf87deb94d7', 2, 'II', 'Scherzo', 'Sinfonía: II. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23879 AND p.composer_id = 344
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ed8110c-5031-4be5-9035-6bf87deb94d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Lento', part.name_en = 'Sinfonía: III. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23879 AND p.composer_id = 344 AND part.part_key = 'musicbrainz:cfee98f5-a037-424f-b45d-395a2e111ebb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfee98f5-a037-424f-b45d-395a2e111ebb', 3, 'III', 'Lento', 'Sinfonía: III. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23879 AND p.composer_id = 344
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfee98f5-a037-424f-b45d-395a2e111ebb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lento – Allegro', part.name_en = 'Sinfonía: IV. Lento – Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23879 AND p.composer_id = 344 AND part.part_key = 'musicbrainz:4689c834-8db4-4f3e-91b6-b742c8e0996a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4689c834-8db4-4f3e-91b6-b742c8e0996a', 4, 'IV', 'Lento – Allegro', 'Sinfonía: IV. Lento – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23879 AND p.composer_id = 344
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4689c834-8db4-4f3e-91b6-b742c8e0996a'
);


-- None 소나타

UPDATE pieces piece
SET piece.title = '소나타', piece.title_en = 'Sonata',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24212 AND piece.composer_id = 344
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Sonata: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24212 AND p.composer_id = 344 AND part.part_key = 'musicbrainz:9acd7056-b7f6-4c14-b2f9-995bceee4f7c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9acd7056-b7f6-4c14-b2f9-995bceee4f7c', 1, NULL, 'I', 'Sonata: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24212 AND p.composer_id = 344
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9acd7056-b7f6-4c14-b2f9-995bceee4f7c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Sonata: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24212 AND p.composer_id = 344 AND part.part_key = 'musicbrainz:6dfcb97f-cc83-45b6-bbd2-8bab94a94ccf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6dfcb97f-cc83-45b6-bbd2-8bab94a94ccf', 2, NULL, 'II', 'Sonata: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24212 AND p.composer_id = 344
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dfcb97f-cc83-45b6-bbd2-8bab94a94ccf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Sonata: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24212 AND p.composer_id = 344 AND part.part_key = 'musicbrainz:48723d54-18a4-41c8-8a87-f2f34239620d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48723d54-18a4-41c8-8a87-f2f34239620d', 3, NULL, 'III', 'Sonata: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24212 AND p.composer_id = 344
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48723d54-18a4-41c8-8a87-f2f34239620d'
);


-- None Tierra de temporal

UPDATE pieces piece
SET piece.title = 'Tierra de temporal', piece.title_en = 'Tierra de temporal',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25576 AND piece.composer_id = 344
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tres piezas para piano

UPDATE pieces piece
SET piece.title = 'Tres piezas para piano', piece.title_en = 'Tres piezas para piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24866 AND piece.composer_id = 344
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 344 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    25889
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== 도널드 토비 (composer_id 346) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 15개(묶음 0, 다악장 12, 낱곡 3),
-- 새 작품 0개, part 40개, 그 아래 0개.
-- seed 17개 중 15개를 작품·part 에 잇고, 1개를 숨기고, 1개는 그대로 둔다.

-- Op. 2 6개의 가곡

UPDATE pieces piece
SET piece.title = '6개의 가곡', piece.title_en = '6 Songs for a Low Voice, Set 1, op. 2',
    piece.type = 'song', piece.opus_number = 'Op. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24701 AND piece.composer_id = 346
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 11 Aria and Variations in B-flat major for String Quartet

UPDATE pieces piece
SET piece.title = 'Aria and Variations in B-flat major for String Quartet', piece.title_en = 'Aria and Variations in B-flat major for String Quartet, op. 11',
    piece.type = 'song', piece.opus_number = 'Op. 11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24811 AND piece.composer_id = 346
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 40 첼로 협주곡 C장조

UPDATE pieces piece
SET piece.title = '첼로 협주곡 C장조', piece.title_en = 'Cello Concerto in C major, op. 40',
    piece.type = 'album', piece.opus_number = 'Op. 40',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24582 AND piece.composer_id = 346
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Cello Concerto, op. 40: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24582 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:12e8f7a4-f6c0-4a59-9425-76f51e2e95a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12e8f7a4-f6c0-4a59-9425-76f51e2e95a6', 1, 'I', 'Allegro moderato', 'Cello Concerto, op. 40: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24582 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12e8f7a4-f6c0-4a59-9425-76f51e2e95a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante maestoso', part.name_en = 'Cello Concerto, op. 40: II. Andante maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24582 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:c0020605-cd65-46ef-b1a0-b5a02bff8949' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0020605-cd65-46ef-b1a0-b5a02bff8949', 2, 'II', 'Andante maestoso', 'Cello Concerto, op. 40: II. Andante maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24582 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0020605-cd65-46ef-b1a0-b5a02bff8949'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Intermezzo: Andante innocente, con moto quasi allegretto', part.name_en = 'Cello Concerto, op. 40: III. Intermezzo: Andante innocente, con moto quasi allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24582 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:adbdd61f-d18e-4211-b8d2-009821a76db3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:adbdd61f-d18e-4211-b8d2-009821a76db3', 3, 'III', 'Intermezzo: Andante innocente, con moto quasi allegretto', 'Cello Concerto, op. 40: III. Intermezzo: Andante innocente, con moto quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24582 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adbdd61f-d18e-4211-b8d2-009821a76db3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Rondo: Allegro giocoso', part.name_en = 'Cello Concerto, op. 40: IV. Rondo: Allegro giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24582 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:99db9ba4-0ed0-4363-9712-e59e42c892fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99db9ba4-0ed0-4363-9712-e59e42c892fb', 4, 'IV', 'Rondo: Allegro giocoso', 'Cello Concerto, op. 40: IV. Rondo: Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24582 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99db9ba4-0ed0-4363-9712-e59e42c892fb'
);


-- Op. 4 첼로 소나타 F장조

UPDATE pieces piece
SET piece.title = '첼로 소나타 F장조', piece.title_en = 'Cello Sonata in F major, op. 4',
    piece.type = 'album', piece.opus_number = 'Op. 4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23619 AND piece.composer_id = 346
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegrissimo', part.name_en = 'Cello Sonata in F major, op. 4: I. Allegrissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23619 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:298d88b9-728f-43fc-a292-133f2259b5fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:298d88b9-728f-43fc-a292-133f2259b5fd', 1, 'I', 'Allegrissimo', 'Cello Sonata in F major, op. 4: I. Allegrissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23619 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:298d88b9-728f-43fc-a292-133f2259b5fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante cantabile', part.name_en = 'Cello Sonata in F major, op. 4: II. Andante cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23619 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:1f9e19c9-12fe-4bbf-94bc-b9322a39aea3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f9e19c9-12fe-4bbf-94bc-b9322a39aea3', 2, 'II', 'Andante cantabile', 'Cello Sonata in F major, op. 4: II. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23619 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f9e19c9-12fe-4bbf-94bc-b9322a39aea3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Finale: Vivace giocoso ma non presto', part.name_en = 'Cello Sonata in F major, op. 4: III. Finale: Vivace giocoso ma non presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23619 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:9d7e51d1-6ef7-4dd9-b332-5f29b9edb554' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d7e51d1-6ef7-4dd9-b332-5f29b9edb554', 3, 'III', 'Finale: Vivace giocoso ma non presto', 'Cello Sonata in F major, op. 4: III. Finale: Vivace giocoso ma non presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23619 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d7e51d1-6ef7-4dd9-b332-5f29b9edb554'
);


-- Op. 25 Elegiac Variations

UPDATE pieces piece
SET piece.title = 'Elegiac Variations', piece.title_en = 'Elegiac Variations, op. 25',
    piece.type = 'song', piece.opus_number = 'Op. 25',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25319 AND piece.composer_id = 346
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 15 피아노 협주곡 A장조

UPDATE pieces piece
SET piece.title = '피아노 협주곡 A장조', piece.title_en = 'Piano Concerto in A major, op. 15',
    piece.type = 'album', piece.opus_number = 'Op. 15',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23713 AND piece.composer_id = 346
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Energico', part.name_en = 'Piano Concerto in A major, op. 15: I. Energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23713 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:13db07bb-7c80-4d2a-8d4a-6f3ba10bf5fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13db07bb-7c80-4d2a-8d4a-6f3ba10bf5fa', 1, 'I', 'Energico', 'Piano Concerto in A major, op. 15: I. Energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23713 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13db07bb-7c80-4d2a-8d4a-6f3ba10bf5fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio ma non troppo', part.name_en = 'Piano Concerto in A major, op. 15: II. Adagio ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23713 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:6d65ec63-285f-40a9-bc46-8d499ce279d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d65ec63-285f-40a9-bc46-8d499ce279d6', 2, 'II', 'Adagio ma non troppo', 'Piano Concerto in A major, op. 15: II. Adagio ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23713 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d65ec63-285f-40a9-bc46-8d499ce279d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Alla marcia, non presto - Presto', part.name_en = 'Piano Concerto in A major, op. 15: III. Alla marcia, non presto - Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23713 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:fcd13102-d7b3-4fba-bf1d-511b870bb93a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcd13102-d7b3-4fba-bf1d-511b870bb93a', 3, 'III', 'Alla marcia, non presto - Presto', 'Piano Concerto in A major, op. 15: III. Alla marcia, non presto - Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23713 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcd13102-d7b3-4fba-bf1d-511b870bb93a'
);


-- Op. 12 피아노 4중주 E단조

UPDATE pieces piece
SET piece.title = '피아노 4중주 E단조', piece.title_en = 'Piano Quartet, op. 12',
    piece.type = 'album', piece.opus_number = 'Op. 12',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24136 AND piece.composer_id = 346
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato e sostenuto - Vivace - Moderato como prima - Vivace tranquillo como prima', part.name_en = 'Piano Quartet, op. 12: I. Allegro moderato e sostenuto - Vivace - Moderato como prima - Vivace tranquillo como prima',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24136 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:398ceaab-f027-4e37-b658-2141a8d39382' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:398ceaab-f027-4e37-b658-2141a8d39382', 1, 'I', 'Allegro moderato e sostenuto - Vivace - Moderato como prima - Vivace tranquillo como prima', 'Piano Quartet, op. 12: I. Allegro moderato e sostenuto - Vivace - Moderato como prima - Vivace tranquillo como prima', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24136 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:398ceaab-f027-4e37-b658-2141a8d39382'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Finale: Largo - Andante con moto maestoso - Energico - Molto adagio - Maestoso e tranquillo', part.name_en = 'Piano Quartet, op. 12: II. Finale: Largo - Andante con moto maestoso - Energico - Molto adagio - Maestoso e tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24136 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:2288da4e-9637-49fb-951f-d3e0a3a24b0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2288da4e-9637-49fb-951f-d3e0a3a24b0f', 2, 'II', 'Finale: Largo - Andante con moto maestoso - Energico - Molto adagio - Maestoso e tranquillo', 'Piano Quartet, op. 12: II. Finale: Largo - Andante con moto maestoso - Energico - Molto adagio - Maestoso e tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24136 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2288da4e-9637-49fb-951f-d3e0a3a24b0f'
);


-- Op. 1 피아노 3중주 B단조

UPDATE pieces piece
SET piece.title = '피아노 3중주 B단조', piece.title_en = 'Piano Trio in B minor, op. 1',
    piece.type = 'album', piece.opus_number = 'Op. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25924 AND piece.composer_id = 346
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Maestoso, Andante ma con moto', part.name_en = 'Piano Trio in B minor, op. 1: I. Maestoso, Andante ma con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25924 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:1bada21d-e261-43cb-afd1-cc7f2a8f958f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bada21d-e261-43cb-afd1-cc7f2a8f958f', 1, 'I', 'Maestoso, Andante ma con moto', 'Piano Trio in B minor, op. 1: I. Maestoso, Andante ma con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25924 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bada21d-e261-43cb-afd1-cc7f2a8f958f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Menuetto: Molto moderato', part.name_en = 'Piano Trio in B minor, op. 1: II. Menuetto: Molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25924 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:3b3439c7-f2b2-4daf-a46b-e55ae45c28a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b3439c7-f2b2-4daf-a46b-e55ae45c28a8', 2, 'II', 'Menuetto: Molto moderato', 'Piano Trio in B minor, op. 1: II. Menuetto: Molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25924 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b3439c7-f2b2-4daf-a46b-e55ae45c28a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rhapsodia: Feroce', part.name_en = 'Piano Trio in B minor, op. 1: III. Rhapsodia: Feroce',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25924 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:1017090b-267a-487c-bef4-a656f11d2b7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1017090b-267a-487c-bef4-a656f11d2b7b', 3, 'III', 'Rhapsodia: Feroce', 'Piano Trio in B minor, op. 1: III. Rhapsodia: Feroce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25924 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1017090b-267a-487c-bef4-a656f11d2b7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale. Allegro ma non troppo', part.name_en = 'Piano Trio in B minor, op. 1: IV. Finale. Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25924 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:337ba864-10f8-4d86-a1ad-8b1f767f79a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:337ba864-10f8-4d86-a1ad-8b1f767f79a1', 4, 'IV', 'Finale. Allegro ma non troppo', 'Piano Trio in B minor, op. 1: IV. Finale. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25924 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:337ba864-10f8-4d86-a1ad-8b1f767f79a1'
);


-- None 피아노 3중주 C단조 "Style tragique"

UPDATE pieces piece
SET piece.title = '피아노 3중주 C단조 "Style tragique"', piece.title_en = 'Piano Trio in C minor, op. 8 "Style tragique"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23275 AND piece.composer_id = 346
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Piano Trio in C minor, op. 8 "Style tragique": I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23275 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:8eac6e52-f09b-4d4b-8242-ded9ea878d93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8eac6e52-f09b-4d4b-8242-ded9ea878d93', 1, 'I', 'Allegro moderato', 'Piano Trio in C minor, op. 8 "Style tragique": I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23275 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8eac6e52-f09b-4d4b-8242-ded9ea878d93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Largo', part.name_en = 'Piano Trio in C minor, op. 8 "Style tragique": II. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23275 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:1370b4f1-70b9-453e-87b2-79419dd932e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1370b4f1-70b9-453e-87b2-79419dd932e4', 2, 'II', 'Largo', 'Piano Trio in C minor, op. 8 "Style tragique": II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23275 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1370b4f1-70b9-453e-87b2-79419dd932e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Finale: Allegro non tanto', part.name_en = 'Piano Trio in C minor, op. 8 "Style tragique": III. Finale: Allegro non tanto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23275 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:d9d7c2a6-b00d-4f39-8e75-a2c3d4b17da2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9d7c2a6-b00d-4f39-8e75-a2c3d4b17da2', 3, 'III', 'Finale: Allegro non tanto', 'Piano Trio in C minor, op. 8 "Style tragique": III. Finale: Allegro non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23275 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9d7c2a6-b00d-4f39-8e75-a2c3d4b17da2'
);


-- Op. 27 피아노 3중주

UPDATE pieces piece
SET piece.title = '피아노 3중주', piece.title_en = 'Piano Trio, op. 27',
    piece.type = 'album', piece.opus_number = 'Op. 27',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24329 AND piece.composer_id = 346
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con brio', part.name_en = 'Piano Trio, op. 27: I. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24329 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:3b94ef60-ec4a-4d79-9a66-c201a7749052' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b94ef60-ec4a-4d79-9a66-c201a7749052', 1, 'I', 'Allegro con brio', 'Piano Trio, op. 27: I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24329 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b94ef60-ec4a-4d79-9a66-c201a7749052'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Larghetto maestoso', part.name_en = 'Piano Trio, op. 27: II. Larghetto maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24329 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:d917368b-cc47-42b1-8a23-a963b9230c86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d917368b-cc47-42b1-8a23-a963b9230c86', 2, 'II', 'Larghetto maestoso', 'Piano Trio, op. 27: II. Larghetto maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24329 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d917368b-cc47-42b1-8a23-a963b9230c86'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro energico, non presto', part.name_en = 'Piano Trio, op. 27: III. Allegro energico, non presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24329 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:32ac5d83-a4e9-4088-a07b-d22e10f1cec0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32ac5d83-a4e9-4088-a07b-d22e10f1cec0', 3, 'III', 'Allegro energico, non presto', 'Piano Trio, op. 27: III. Allegro energico, non presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24329 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32ac5d83-a4e9-4088-a07b-d22e10f1cec0'
);


-- Op. 29 Sonata eroica for Solo Violin

UPDATE pieces piece
SET piece.title = 'Sonata eroica for Solo Violin', piece.title_en = 'Sonata eroica for Solo Violin, op. 29',
    piece.type = 'album', piece.opus_number = 'Op. 29',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25062 AND piece.composer_id = 346
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Maestoso sostenuto, quasi poco adagio', part.name_en = 'Sonata eroica for Solo Violin, op. 29: I. Maestoso sostenuto, quasi poco adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25062 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:1d143116-fb5c-4f14-96d1-75ca562fe04e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d143116-fb5c-4f14-96d1-75ca562fe04e', 1, 'I', 'Maestoso sostenuto, quasi poco adagio', 'Sonata eroica for Solo Violin, op. 29: I. Maestoso sostenuto, quasi poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25062 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d143116-fb5c-4f14-96d1-75ca562fe04e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Vivace', part.name_en = 'Sonata eroica for Solo Violin, op. 29: II. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25062 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:7262b1ec-b41a-4b5a-b903-97da0a3a8dd4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7262b1ec-b41a-4b5a-b903-97da0a3a8dd4', 2, 'II', 'Vivace', 'Sonata eroica for Solo Violin, op. 29: II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25062 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7262b1ec-b41a-4b5a-b903-97da0a3a8dd4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante tranquillo', part.name_en = 'Sonata eroica for Solo Violin, op. 29: III. Andante tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25062 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:7795f016-13ca-4712-94f3-d4f71f424b39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7795f016-13ca-4712-94f3-d4f71f424b39', 3, 'III', 'Andante tranquillo', 'Sonata eroica for Solo Violin, op. 29: III. Andante tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25062 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7795f016-13ca-4712-94f3-d4f71f424b39'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro moderato e pesante con fuoco', part.name_en = 'Sonata eroica for Solo Violin, op. 29: IV. Allegro moderato e pesante con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25062 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:000276ca-f83c-4689-a3da-015e93bfc5ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:000276ca-f83c-4689-a3da-015e93bfc5ac', 4, 'IV', 'Allegro moderato e pesante con fuoco', 'Sonata eroica for Solo Violin, op. 29: IV. Allegro moderato e pesante con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25062 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:000276ca-f83c-4689-a3da-015e93bfc5ac'
);


-- Op. 30 첼로 소나타 D장조

UPDATE pieces piece
SET piece.title = '첼로 소나타 D장조', piece.title_en = 'Sonata for Solo Cello in D major, op. 30',
    piece.type = 'album', piece.opus_number = 'Op. 30',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25761 AND piece.composer_id = 346
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con brio ma largamente', part.name_en = 'Sonata for Solo Cello in D major, op. 30: I. Allegro con brio ma largamente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25761 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:2d1f4329-d26d-4973-9171-6264fd310b69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d1f4329-d26d-4973-9171-6264fd310b69', 1, 'I', 'Allegro con brio ma largamente', 'Sonata for Solo Cello in D major, op. 30: I. Allegro con brio ma largamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25761 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d1f4329-d26d-4973-9171-6264fd310b69'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto, un poco agitato, ma sempre piano', part.name_en = 'Sonata for Solo Cello in D major, op. 30: II. Allegretto, un poco agitato, ma sempre piano',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25761 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:f655c297-7816-41c3-8fec-a6c421d80380' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f655c297-7816-41c3-8fec-a6c421d80380', 2, 'II', 'Allegretto, un poco agitato, ma sempre piano', 'Sonata for Solo Cello in D major, op. 30: II. Allegretto, un poco agitato, ma sempre piano', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25761 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f655c297-7816-41c3-8fec-a6c421d80380'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Passacaglia', part.name_en = 'Sonata for Solo Cello in D major, op. 30: III. Passacaglia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25761 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:255a9235-5aad-478e-8c20-bc30a7e01853' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:255a9235-5aad-478e-8c20-bc30a7e01853', 3, 'III', 'Passacaglia', 'Sonata for Solo Cello in D major, op. 30: III. Passacaglia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25761 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:255a9235-5aad-478e-8c20-bc30a7e01853'
);


-- None 소나타 G장조

UPDATE pieces piece
SET piece.title = '소나타 G장조', piece.title_en = 'Sonata for Two Cellos in G major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25503 AND piece.composer_id = 346
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro vivace', part.name_en = 'Sonata for Two Cellos in G major: I. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25503 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:c56e49a2-6539-4ce2-8739-ad0c76522d2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c56e49a2-6539-4ce2-8739-ad0c76522d2f', 1, 'I', 'Allegro vivace', 'Sonata for Two Cellos in G major: I. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25503 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c56e49a2-6539-4ce2-8739-ad0c76522d2f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante maestoso e sostenuto', part.name_en = 'Sonata for Two Cellos in G major: II. Andante maestoso e sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25503 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:b9b34ea5-b486-4954-948f-643719190b55' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9b34ea5-b486-4954-948f-643719190b55', 2, 'II', 'Andante maestoso e sostenuto', 'Sonata for Two Cellos in G major: II. Andante maestoso e sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25503 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9b34ea5-b486-4954-948f-643719190b55'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Fuga. Allegretto giocoso', part.name_en = 'Sonata for Two Cellos in G major: III. Fuga. Allegretto giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25503 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:f8b93680-6878-4d8e-87ea-d01247ac32ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8b93680-6878-4d8e-87ea-d01247ac32ad', 3, 'III', 'Fuga. Allegretto giocoso', 'Sonata for Two Cellos in G major: III. Fuga. Allegretto giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25503 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8b93680-6878-4d8e-87ea-d01247ac32ad'
);


-- Op. 23 현악 4중주 G장조

UPDATE pieces piece
SET piece.title = '현악 4중주 G장조', piece.title_en = 'String Quartet in G major, op. 23',
    piece.type = 'album', piece.opus_number = 'Op. 23',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25905 AND piece.composer_id = 346
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante pomposa galante', part.name_en = 'String Quartet in G major, op. 23: I. Andante pomposa galante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25905 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:ab1156c5-0c47-4821-90d3-0fe48d73962e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab1156c5-0c47-4821-90d3-0fe48d73962e', 1, 'I', 'Andante pomposa galante', 'String Quartet in G major, op. 23: I. Andante pomposa galante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25905 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab1156c5-0c47-4821-90d3-0fe48d73962e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Pastorale Allegretto Teneramente', part.name_en = 'String Quartet in G major, op. 23: II. Pastorale Allegretto Teneramente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25905 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:d20cc97e-7d74-4c3c-b1ea-783906e062a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d20cc97e-7d74-4c3c-b1ea-783906e062a3', 2, 'II', 'Pastorale Allegretto Teneramente', 'String Quartet in G major, op. 23: II. Pastorale Allegretto Teneramente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25905 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d20cc97e-7d74-4c3c-b1ea-783906e062a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Poco adagio sempre sostenuto', part.name_en = 'String Quartet in G major, op. 23: III. Poco adagio sempre sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25905 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:0bf7539b-820a-430a-b2ad-31a899bc8574' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bf7539b-820a-430a-b2ad-31a899bc8574', 3, 'III', 'Poco adagio sempre sostenuto', 'String Quartet in G major, op. 23: III. Poco adagio sempre sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25905 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bf7539b-820a-430a-b2ad-31a899bc8574'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro commodo', part.name_en = 'String Quartet in G major, op. 23: IV. Allegro commodo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25905 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:04f82045-7033-4764-bafa-c742d1afb85c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04f82045-7033-4764-bafa-c742d1afb85c', 4, 'IV', 'Allegro commodo', 'String Quartet in G major, op. 23: IV. Allegro commodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25905 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04f82045-7033-4764-bafa-c742d1afb85c'
);


-- Op. 32 교향곡 D장조

UPDATE pieces piece
SET piece.title = '교향곡 D장조', piece.title_en = 'Symphony in D major, op. 32',
    piece.type = 'album', piece.opus_number = 'Op. 32',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23382 AND piece.composer_id = 346
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro maestoso', part.name_en = 'Symphony in D major, op. 32: I. Allegro maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23382 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:85e8338e-e4cd-4056-9678-8ff8d89bfd6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85e8338e-e4cd-4056-9678-8ff8d89bfd6c', 1, 'I', 'Allegro maestoso', 'Symphony in D major, op. 32: I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23382 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85e8338e-e4cd-4056-9678-8ff8d89bfd6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Vivace ma non troppo presto', part.name_en = 'Symphony in D major, op. 32: II. Vivace ma non troppo presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23382 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:3b50cd69-3866-4957-9885-df459699b0d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b50cd69-3866-4957-9885-df459699b0d4', 2, 'II', 'Vivace ma non troppo presto', 'Symphony in D major, op. 32: II. Vivace ma non troppo presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23382 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b50cd69-3866-4957-9885-df459699b0d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Canzone Dorica - Adagio', part.name_en = 'Symphony in D major, op. 32: III. Canzone Dorica - Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23382 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:eabf00d9-e86c-43da-a943-a65c13ba86aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eabf00d9-e86c-43da-a943-a65c13ba86aa', 3, 'III', 'Canzone Dorica - Adagio', 'Symphony in D major, op. 32: III. Canzone Dorica - Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23382 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eabf00d9-e86c-43da-a943-a65c13ba86aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro con moto energico', part.name_en = 'Symphony in D major, op. 32: IV. Allegro con moto energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23382 AND p.composer_id = 346 AND part.part_key = 'musicbrainz:75a3ed1c-29ff-4d8d-9256-dc3e82f7003f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75a3ed1c-29ff-4d8d-9256-dc3e82f7003f', 4, 'IV', 'Allegro con moto energico', 'Symphony in D major, op. 32: IV. Allegro con moto energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23382 AND p.composer_id = 346
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75a3ed1c-29ff-4d8d-9256-dc3e82f7003f'
);

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 346 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    23464
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== 리환즈 (composer_id 347) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 1, 낱곡 0),
-- 새 작품 0개, part 4개, 그 아래 0개.
-- seed 2개 중 1개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.

-- None 春節組曲

UPDATE pieces piece
SET piece.title = '春節組曲', piece.title_en = '春節組曲',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23086 AND piece.composer_id = 347
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '序曲—大秧歌', part.name_en = '春節組曲: I. 序曲—大秧歌',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23086 AND p.composer_id = 347 AND part.part_key = 'musicbrainz:b56f1247-28e2-4f4c-a763-03ff5008f5a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b56f1247-28e2-4f4c-a763-03ff5008f5a2', 1, 'I', '序曲—大秧歌', '春節組曲: I. 序曲—大秧歌', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23086 AND p.composer_id = 347
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b56f1247-28e2-4f4c-a763-03ff5008f5a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante cantabile', part.name_en = '春節組曲: II. Andante cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23086 AND p.composer_id = 347 AND part.part_key = 'musicbrainz:d59c7ce4-a493-4221-91ac-591a58d9e416' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d59c7ce4-a493-4221-91ac-591a58d9e416', 2, 'II', 'Andante cantabile', '春節組曲: II. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23086 AND p.composer_id = 347
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d59c7ce4-a493-4221-91ac-591a58d9e416'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rondo', part.name_en = '春節組曲: III. Rondo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23086 AND p.composer_id = 347 AND part.part_key = 'musicbrainz:b2d55947-0707-458d-bb7d-bf63f4266796' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2d55947-0707-458d-bb7d-bf63f4266796', 3, 'III', 'Rondo', '春節組曲: III. Rondo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23086 AND p.composer_id = 347
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2d55947-0707-458d-bb7d-bf63f4266796'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Moderato', part.name_en = '春節組曲: IV. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23086 AND p.composer_id = 347 AND part.part_key = 'musicbrainz:63496c6f-1515-4379-9d3b-7f35a9de2c26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63496c6f-1515-4379-9d3b-7f35a9de2c26', 4, 'IV', 'Moderato', '春節組曲: IV. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23086 AND p.composer_id = 347
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63496c6f-1515-4379-9d3b-7f35a9de2c26'
);

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 347 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    23091
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== 프랑수아 조제프 페티스 (composer_id 348) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 0, 다악장 2, 낱곡 0),
-- 새 작품 0개, part 6개, 그 아래 0개.
-- seed 2개 중 2개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Fantaisie symphonique

UPDATE pieces piece
SET piece.title = 'Fantaisie symphonique', piece.title_en = 'Fantaisie symphonique',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24170 AND piece.composer_id = 348
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'Fantaisie symphonique: I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24170 AND p.composer_id = 348 AND part.part_key = 'musicbrainz:9f66df86-fe25-4ca9-836e-e6d0c8b302fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f66df86-fe25-4ca9-836e-e6d0c8b302fd', 1, 'I', 'Allegro non troppo', 'Fantaisie symphonique: I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24170 AND p.composer_id = 348
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f66df86-fe25-4ca9-836e-e6d0c8b302fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante con variazioni', part.name_en = 'Fantaisie symphonique: II. Andante con variazioni',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24170 AND p.composer_id = 348 AND part.part_key = 'musicbrainz:af5e193b-53a5-475a-b66d-174af48e81b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af5e193b-53a5-475a-b66d-174af48e81b1', 2, 'II', 'Andante con variazioni', 'Fantaisie symphonique: II. Andante con variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24170 AND p.composer_id = 348
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af5e193b-53a5-475a-b66d-174af48e81b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'La Chasse. Allegro', part.name_en = 'Fantaisie symphonique: III. La Chasse. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24170 AND p.composer_id = 348 AND part.part_key = 'musicbrainz:375b413f-f119-4fd8-be4d-7097b24056f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:375b413f-f119-4fd8-be4d-7097b24056f0', 3, 'III', 'La Chasse. Allegro', 'Fantaisie symphonique: III. La Chasse. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24170 AND p.composer_id = 348
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:375b413f-f119-4fd8-be4d-7097b24056f0'
);


-- None 플루트 협주곡 B단조

UPDATE pieces piece
SET piece.title = '플루트 협주곡 B단조', piece.title_en = 'Flute Concerto in B minor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23508 AND piece.composer_id = 348
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Flute Concerto in B minor: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23508 AND p.composer_id = 348 AND part.part_key = 'musicbrainz:d0f19d4d-8990-457f-b232-767bbc04a095' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0f19d4d-8990-457f-b232-767bbc04a095', 1, 'I', 'Allegro', 'Flute Concerto in B minor: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23508 AND p.composer_id = 348
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0f19d4d-8990-457f-b232-767bbc04a095'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Flute Concerto in B minor: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23508 AND p.composer_id = 348 AND part.part_key = 'musicbrainz:50e8a065-edc1-4889-9766-909c63eef4d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50e8a065-edc1-4889-9766-909c63eef4d3', 2, 'II', 'Adagio', 'Flute Concerto in B minor: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23508 AND p.composer_id = 348
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50e8a065-edc1-4889-9766-909c63eef4d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro ma non troppo', part.name_en = 'Flute Concerto in B minor: III. Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23508 AND p.composer_id = 348 AND part.part_key = 'musicbrainz:be19f82a-29f0-462d-a509-5a84129fe716' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be19f82a-29f0-462d-a509-5a84129fe716', 3, 'III', 'Allegro ma non troppo', 'Flute Concerto in B minor: III. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23508 AND p.composer_id = 348
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be19f82a-29f0-462d-a509-5a84129fe716'
);

-- 숨길 seed 작품 없음

-- ===== Thomas Dunhill (composer_id 349) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 10개(묶음 2, 다악장 1, 낱곡 7),
-- 새 작품 1개, part 6개, 그 아래 0개.
-- seed 9개 중 9개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- Op. 43 연가곡집 <Countryside Ditties>

UPDATE pieces piece
SET piece.title = '연가곡집 <Countryside Ditties>', piece.title_en = 'Countryside Ditties, op. 43',
    piece.type = 'song', piece.opus_number = 'Op. 43',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24491 AND piece.composer_id = 349
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 42 Dance Suite

UPDATE pieces piece
SET piece.title = 'Dance Suite', piece.title_en = 'Dance Suite, op. 42',
    piece.type = 'song', piece.opus_number = 'Op. 42',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25163 AND piece.composer_id = 349
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None First Year Pieces

UPDATE pieces piece
SET piece.title = 'First Year Pieces', piece.title_en = 'First Year Pieces',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25604 AND piece.composer_id = 349
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'A Song of Erin', part.name_en = 'First Year Pieces: No. 8. A Song of Erin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25604 AND p.composer_id = 349 AND part.part_key = 'musicbrainz:b8f280e2-8b35-4d91-b4a4-87b98e214c2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8f280e2-8b35-4d91-b4a4-87b98e214c2c', 1, NULL, 'A Song of Erin', 'First Year Pieces: No. 8. A Song of Erin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25604 AND p.composer_id = 349
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8f280e2-8b35-4d91-b4a4-87b98e214c2c'
);


-- Op. 100 May-Time

UPDATE pieces piece
SET piece.title = 'May-Time', piece.title_en = 'May-Time, op. 100',
    piece.type = 'song', piece.opus_number = 'Op. 100',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23213 AND piece.composer_id = 349
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 20 피아노 5중주 C단조

UPDATE pieces piece
SET piece.title = '피아노 5중주 C단조', piece.title_en = 'Piano Quintet in C minor, op. 20',
    piece.type = 'album', piece.opus_number = 'Op. 20',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24479 AND piece.composer_id = 349
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Piano Quintet in C minor, op. 20: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24479 AND p.composer_id = 349 AND part.part_key = 'musicbrainz:aed818c4-57d9-4afd-8783-2afe1436485d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aed818c4-57d9-4afd-8783-2afe1436485d', 1, 'I', 'Allegro moderato', 'Piano Quintet in C minor, op. 20: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24479 AND p.composer_id = 349
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aed818c4-57d9-4afd-8783-2afe1436485d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Vivace assai, con fuoco', part.name_en = 'Piano Quintet in C minor, op. 20: II. Vivace assai, con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24479 AND p.composer_id = 349 AND part.part_key = 'musicbrainz:e202b1b3-fc26-4517-8724-e191908b5ec9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e202b1b3-fc26-4517-8724-e191908b5ec9', 2, 'II', 'Vivace assai, con fuoco', 'Piano Quintet in C minor, op. 20: II. Vivace assai, con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24479 AND p.composer_id = 349
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e202b1b3-fc26-4517-8724-e191908b5ec9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Elegie. Andante ma non troppo', part.name_en = 'Piano Quintet in C minor, op. 20: III. Elegie. Andante ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24479 AND p.composer_id = 349 AND part.part_key = 'musicbrainz:9542fbca-2d2b-4157-bd68-6dfbb65c4e35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9542fbca-2d2b-4157-bd68-6dfbb65c4e35', 3, 'III', 'Elegie. Andante ma non troppo', 'Piano Quintet in C minor, op. 20: III. Elegie. Andante ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24479 AND p.composer_id = 349
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9542fbca-2d2b-4157-bd68-6dfbb65c4e35'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro con brio – Prestissimo', part.name_en = 'Piano Quintet in C minor, op. 20: IV. Allegro con brio – Prestissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24479 AND p.composer_id = 349 AND part.part_key = 'musicbrainz:ae3f9110-c0fa-4ede-adfe-c43798eefef7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae3f9110-c0fa-4ede-adfe-c43798eefef7', 4, 'IV', 'Allegro con brio – Prestissimo', 'Piano Quintet in C minor, op. 20: IV. Allegro con brio – Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24479 AND p.composer_id = 349
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae3f9110-c0fa-4ede-adfe-c43798eefef7'
);


-- Op. 39 부수음악 <The King's Threshold>

UPDATE pieces piece
SET piece.title = '부수음악 <The King''s Threshold>', piece.title_en = 'The King''s Threshold, op. 39',
    piece.type = 'song', piece.opus_number = 'Op. 39',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24755 AND piece.composer_id = 349
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Old Abbey

UPDATE pieces piece
SET piece.title = 'The Old Abbey', piece.title_en = 'The Old Abbey',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24836 AND piece.composer_id = 349
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 30 연가곡집 <The Wind Among the Reeds> Op. 30

UPDATE pieces piece
SET piece.title = '연가곡집 <The Wind Among the Reeds> Op. 30', piece.title_en = 'The Wind Among the Reeds, op. 30',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '30',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25645 AND piece.composer_id = 349
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Cloths of Heaven', part.name_en = 'The Wind Among the Reeds, op. 30: No. 3. The Cloths of Heaven',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25645 AND p.composer_id = 349 AND part.part_key = 'musicbrainz:fe4df80b-0778-4901-a0bc-57dc6df1f735' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe4df80b-0778-4901-a0bc-57dc6df1f735', 1, NULL, 'The Cloths of Heaven', 'The Wind Among the Reeds, op. 30: No. 3. The Cloths of Heaven', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25645 AND p.composer_id = 349
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe4df80b-0778-4901-a0bc-57dc6df1f735'
);


-- Op. 75 Waltz Suite

UPDATE pieces piece
SET piece.title = 'Waltz Suite', piece.title_en = 'Waltz Suite, op. 75',
    piece.type = 'song', piece.opus_number = 'Op. 75',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25975 AND piece.composer_id = 349
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 99 Triptych

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Triptych', 'Triptych, op. 99', 'song', 'Op. 99', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 349
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Triptych'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '68a3ba21-8fdb-4d85-a5fe-5b5c644e7192'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '68a3ba21-8fdb-4d85-a5fe-5b5c644e7192'
FROM pieces p
WHERE p.composer_id = 349 AND p.title = 'Triptych' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '68a3ba21-8fdb-4d85-a5fe-5b5c644e7192'
);

-- 숨길 seed 작품 없음

-- ===== Fikret Amirov (composer_id 350) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 12개(묶음 2, 다악장 5, 낱곡 5),
-- 새 작품 1개, part 41개, 그 아래 36개.
-- seed 12개 중 11개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.

-- None A Tale of Nasimi

UPDATE pieces piece
SET piece.title = 'A Tale of Nasimi', piece.title_en = 'A Tale of Nasimi',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25230 AND piece.composer_id = 350
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Dance of the Executioners', part.name_en = 'A Tale of Nasimi: I. Dance of the Executioners',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25230 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:beaa6418-c055-4a3f-9117-9104a2264387' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:beaa6418-c055-4a3f-9117-9104a2264387', 1, 'I', 'Dance of the Executioners', 'A Tale of Nasimi: I. Dance of the Executioners', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25230 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:beaa6418-c055-4a3f-9117-9104a2264387'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Nasimi’s Monologue', part.name_en = 'A Tale of Nasimi: II. Nasimi’s Monologue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25230 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:bd6d6ad4-9c40-4eeb-bcaa-6672ab2c9429' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd6d6ad4-9c40-4eeb-bcaa-6672ab2c9429', 2, 'II', 'Nasimi’s Monologue', 'A Tale of Nasimi: II. Nasimi’s Monologue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25230 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd6d6ad4-9c40-4eeb-bcaa-6672ab2c9429'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Nasimi and His Beloved’s First Duet', part.name_en = 'A Tale of Nasimi: III. Nasimi and His Beloved’s First Duet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25230 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:65979812-f347-4668-9259-16f73afcbbb5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65979812-f347-4668-9259-16f73afcbbb5', 3, 'III', 'Nasimi and His Beloved’s First Duet', 'A Tale of Nasimi: III. Nasimi and His Beloved’s First Duet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25230 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65979812-f347-4668-9259-16f73afcbbb5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Girl’s Dance With Nasimi and his Beloved', part.name_en = 'A Tale of Nasimi: IV. Girl’s Dance With Nasimi and his Beloved',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25230 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:a74b7a01-8481-45a0-80ae-3ac38ee2cba6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a74b7a01-8481-45a0-80ae-3ac38ee2cba6', 4, 'IV', 'Girl’s Dance With Nasimi and his Beloved', 'A Tale of Nasimi: IV. Girl’s Dance With Nasimi and his Beloved', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25230 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a74b7a01-8481-45a0-80ae-3ac38ee2cba6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'The Invasion', part.name_en = 'A Tale of Nasimi: V. The Invasion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25230 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:cc1b1bbc-2015-43a6-8547-b900d0a7c3eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc1b1bbc-2015-43a6-8547-b900d0a7c3eb', 5, 'V', 'The Invasion', 'A Tale of Nasimi: V. The Invasion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25230 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc1b1bbc-2015-43a6-8547-b900d0a7c3eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'The Girl’s Grief', part.name_en = 'A Tale of Nasimi: VI. The Girl’s Grief',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25230 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:f4296584-c050-45d4-b794-61aa9a17b04d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4296584-c050-45d4-b794-61aa9a17b04d', 6, 'VI', 'The Girl’s Grief', 'A Tale of Nasimi: VI. The Girl’s Grief', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25230 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4296584-c050-45d4-b794-61aa9a17b04d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Nasimi and His Beloved’s Second Duet', part.name_en = 'A Tale of Nasimi: VII. Nasimi and His Beloved’s Second Duet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25230 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:09d3569f-b55f-401e-a337-82a12ab2c242' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09d3569f-b55f-401e-a337-82a12ab2c242', 7, 'VII', 'Nasimi and His Beloved’s Second Duet', 'A Tale of Nasimi: VII. Nasimi and His Beloved’s Second Duet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25230 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09d3569f-b55f-401e-a337-82a12ab2c242'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Nasimi’s Protest', part.name_en = 'A Tale of Nasimi: VIII. Nasimi’s Protest',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25230 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:941aaf3d-746d-45fa-b5cc-ebd4b0bf806b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:941aaf3d-746d-45fa-b5cc-ebd4b0bf806b', 8, 'VIII', 'Nasimi’s Protest', 'A Tale of Nasimi: VIII. Nasimi’s Protest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25230 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:941aaf3d-746d-45fa-b5cc-ebd4b0bf806b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Struggle', part.name_en = 'A Tale of Nasimi: IX. Struggle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25230 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:24d81e0c-340d-4578-aaf0-ec8516272c60' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24d81e0c-340d-4578-aaf0-ec8516272c60', 9, 'IX', 'Struggle', 'A Tale of Nasimi: IX. Struggle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25230 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24d81e0c-340d-4578-aaf0-ec8516272c60'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Immortality', part.name_en = 'A Tale of Nasimi: X. Immortality',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25230 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:f4d58982-117d-4ad9-bdaa-55ec51b455da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4d58982-117d-4ad9-bdaa-55ec51b455da', 10, 'X', 'Immortality', 'A Tale of Nasimi: X. Immortality', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25230 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4d58982-117d-4ad9-bdaa-55ec51b455da'
);


-- None 발레 <Arabian Nights>

UPDATE pieces piece
SET piece.title = '발레 <Arabian Nights>', piece.title_en = 'Arabian Nights',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24948 AND piece.composer_id = 350
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Arabian Nights: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3', 1, NULL, 'Act I', 'Arabian Nights: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I. Monologue: Nurida', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act I. Monologue: Nurida',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:1837a764-84fb-4495-b228-941ae5378d30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1837a764-84fb-4495-b228-941ae5378d30', 1, NULL, 'Act I. Monologue: Nurida', 'Arabian Nights, Ballet in Two Acts: Act I. Monologue: Nurida', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1837a764-84fb-4495-b228-941ae5378d30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro con brio', part.name_en = 'Symphony for String Orchestra: IV. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:183fcb4b-2b68-4923-9bd5-8f52b2f1f092' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:183fcb4b-2b68-4923-9bd5-8f52b2f1f092', 2, NULL, 'Allegro con brio', 'Symphony for String Orchestra: IV. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:183fcb4b-2b68-4923-9bd5-8f52b2f1f092'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act I. The Executioners', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act I. The Executioners',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:1a0fd47c-7664-413e-bb29-4636b5ddae3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1a0fd47c-7664-413e-bb29-4636b5ddae3a', 3, NULL, 'Act I. The Executioners', 'Arabian Nights, Ballet in Two Acts: Act I. The Executioners', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a0fd47c-7664-413e-bb29-4636b5ddae3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act I. Schahriar''s Rage', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act I. Schahriar''s Rage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:26a1e71f-018d-4425-b2de-03151ef8cc65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:26a1e71f-018d-4425-b2de-03151ef8cc65', 4, NULL, 'Act I. Schahriar''s Rage', 'Arabian Nights, Ballet in Two Acts: Act I. Schahriar''s Rage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26a1e71f-018d-4425-b2de-03151ef8cc65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act I. The Executioners', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act I. The Executioners',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:3d43b096-5490-4433-94b6-ddc5da4990a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3d43b096-5490-4433-94b6-ddc5da4990a1', 5, NULL, 'Act I. The Executioners', 'Arabian Nights, Ballet in Two Acts: Act I. The Executioners', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d43b096-5490-4433-94b6-ddc5da4990a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act I. Duet: Schahriar and Nurida', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act I. Duet: Schahriar and Nurida',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:4b9ec817-09e1-4723-9e23-14f9a7ee81f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4b9ec817-09e1-4723-9e23-14f9a7ee81f2', 6, NULL, 'Act I. Duet: Schahriar and Nurida', 'Arabian Nights, Ballet in Two Acts: Act I. Duet: Schahriar and Nurida', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b9ec817-09e1-4723-9e23-14f9a7ee81f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act I. Orgy', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act I. Orgy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:62555cbd-9b39-4b5c-8c24-207a1e1b90d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:62555cbd-9b39-4b5c-8c24-207a1e1b90d8', 7, NULL, 'Act I. Orgy', 'Arabian Nights, Ballet in Two Acts: Act I. Orgy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62555cbd-9b39-4b5c-8c24-207a1e1b90d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act I. Nurida''s Death', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act I. Nurida''s Death',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:77fb9f04-af25-4eca-8c07-5b043f817370' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:77fb9f04-af25-4eca-8c07-5b043f817370', 8, NULL, 'Act I. Nurida''s Death', 'Arabian Nights, Ballet in Two Acts: Act I. Nurida''s Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77fb9f04-af25-4eca-8c07-5b043f817370'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act I. Dance of the Archers', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act I. Dance of the Archers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:832dd284-458f-4ec9-825c-8a92f4efe199' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:832dd284-458f-4ec9-825c-8a92f4efe199', 9, NULL, 'Act I. Dance of the Archers', 'Arabian Nights, Ballet in Two Acts: Act I. Dance of the Archers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:832dd284-458f-4ec9-825c-8a92f4efe199'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act I. Introduction', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:8b0d20ba-4e4f-42fc-a4ed-a3d038d8b902' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8b0d20ba-4e4f-42fc-a4ed-a3d038d8b902', 10, NULL, 'Act I. Introduction', 'Arabian Nights, Ballet in Two Acts: Act I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b0d20ba-4e4f-42fc-a4ed-a3d038d8b902'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Andante sostenuto', part.name_en = 'Symphony for String Orchestra: III. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:941b9dac-8590-4ead-ad63-5fe897bf84ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:941b9dac-8590-4ead-ad63-5fe897bf84ab', 11, NULL, 'Andante sostenuto', 'Symphony for String Orchestra: III. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:941b9dac-8590-4ead-ad63-5fe897bf84ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Act I. Schahriar''s Variation', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act I. Schahriar''s Variation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:aa93b588-9bc2-4972-aa4c-3f157ded94b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aa93b588-9bc2-4972-aa4c-3f157ded94b0', 12, NULL, 'Act I. Schahriar''s Variation', 'Arabian Nights, Ballet in Two Acts: Act I. Schahriar''s Variation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa93b588-9bc2-4972-aa4c-3f157ded94b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Andante maestoso - Allegretto', part.name_en = 'Symphony for String Orchestra: I. Andante maestoso - Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:abb61bab-426e-43fd-a5d4-675d31f2b908' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:abb61bab-426e-43fd-a5d4-675d31f2b908', 13, NULL, 'Andante maestoso - Allegretto', 'Symphony for String Orchestra: I. Andante maestoso - Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abb61bab-426e-43fd-a5d4-675d31f2b908'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Act I. Monologue: Schahriar', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act I. Monologue: Schahriar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:c1582c05-6d80-4cd2-97c5-23e825bb4c50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c1582c05-6d80-4cd2-97c5-23e825bb4c50', 14, NULL, 'Act I. Monologue: Schahriar', 'Arabian Nights, Ballet in Two Acts: Act I. Monologue: Schahriar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1582c05-6d80-4cd2-97c5-23e825bb4c50'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Act I. Schahriar''s Anger', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act I. Schahriar''s Anger',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:d821a984-7b0f-4323-8027-f946f4ad0dd1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d821a984-7b0f-4323-8027-f946f4ad0dd1', 15, NULL, 'Act I. Schahriar''s Anger', 'Arabian Nights, Ballet in Two Acts: Act I. Schahriar''s Anger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d821a984-7b0f-4323-8027-f946f4ad0dd1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Act I. Duet: Schahriar and Scheherazade', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act I. Duet: Schahriar and Scheherazade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:de127cbe-328c-4cfc-8631-716aa586a0c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:de127cbe-328c-4cfc-8631-716aa586a0c1', 16, NULL, 'Act I. Duet: Schahriar and Scheherazade', 'Arabian Nights, Ballet in Two Acts: Act I. Duet: Schahriar and Scheherazade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de127cbe-328c-4cfc-8631-716aa586a0c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Act I. Women''s Lamentations and Pleading', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act I. Women''s Lamentations and Pleading',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:df8e2848-6e2e-4c87-a57f-3a390551f329' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:df8e2848-6e2e-4c87-a57f-3a390551f329', 17, NULL, 'Act I. Women''s Lamentations and Pleading', 'Arabian Nights, Ballet in Two Acts: Act I. Women''s Lamentations and Pleading', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df8e2848-6e2e-4c87-a57f-3a390551f329'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Allegretto giocoso', part.name_en = 'Symphony for String Orchestra: II. Allegretto giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:e595547c-1f73-495a-9a76-9f62357c4ada' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e595547c-1f73-495a-9a76-9f62357c4ada', 18, NULL, 'Allegretto giocoso', 'Symphony for String Orchestra: II. Allegretto giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e595547c-1f73-495a-9a76-9f62357c4ada'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Act I. Scheherazade', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act I. Scheherazade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:f7ecb340-8a6c-4722-a351-1c610dcc669c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f7ecb340-8a6c-4722-a351-1c610dcc669c', 19, NULL, 'Act I. Scheherazade', 'Arabian Nights, Ballet in Two Acts: Act I. Scheherazade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7bb60417-2773-442e-9d60-d9fa614ff5a3'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7ecb340-8a6c-4722-a351-1c610dcc669c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Arabian Nights: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095', 2, NULL, 'Act II', 'Arabian Nights: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act II. The Night', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act II. The Night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:2a6b8e05-a625-490d-816f-51839cf2c742' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2a6b8e05-a625-490d-816f-51839cf2c742', 1, NULL, 'Act II. The Night', 'Arabian Nights, Ballet in Two Acts: Act II. The Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a6b8e05-a625-490d-816f-51839cf2c742'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II. The Executioners', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act II. The Executioners',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:45e3d982-ad0f-4efe-9879-627e3995524d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:45e3d982-ad0f-4efe-9879-627e3995524d', 2, NULL, 'Act II. The Executioners', 'Arabian Nights, Ballet in Two Acts: Act II. The Executioners', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45e3d982-ad0f-4efe-9879-627e3995524d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act II. Scheherazade''s Feast', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act II. Scheherazade''s Feast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:4709a7f0-5169-40dc-9354-7f551f67aa53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4709a7f0-5169-40dc-9354-7f551f67aa53', 3, NULL, 'Act II. Scheherazade''s Feast', 'Arabian Nights, Ballet in Two Acts: Act II. Scheherazade''s Feast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4709a7f0-5169-40dc-9354-7f551f67aa53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act II. Monologue: Scheherazade', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act II. Monologue: Scheherazade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:6d7129c5-a21c-48c6-8544-624469e5621d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6d7129c5-a21c-48c6-8544-624469e5621d', 4, NULL, 'Act II. Monologue: Scheherazade', 'Arabian Nights, Ballet in Two Acts: Act II. Monologue: Scheherazade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d7129c5-a21c-48c6-8544-624469e5621d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act II. The Third Tale (Ali Baba and the Forty Thieves)', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act II. The Third Tale (Ali Baba and the Forty Thieves)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:79f8b334-69b4-4ba8-906d-22e269ac678c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:79f8b334-69b4-4ba8-906d-22e269ac678c', 5, NULL, 'Act II. The Third Tale (Ali Baba and the Forty Thieves)', 'Arabian Nights, Ballet in Two Acts: Act II. The Third Tale (Ali Baba and the Forty Thieves)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79f8b334-69b4-4ba8-906d-22e269ac678c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act II. Night Music', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act II. Night Music',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:9df04ecb-544d-4cb4-bb65-bfbfcb1ec78d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9df04ecb-544d-4cb4-bb65-bfbfcb1ec78d', 6, NULL, 'Act II. Night Music', 'Arabian Nights, Ballet in Two Acts: Act II. Night Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9df04ecb-544d-4cb4-bb65-bfbfcb1ec78d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act II. Schahriar in the World of Fairy Tales', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act II. Schahriar in the World of Fairy Tales',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:9ebc0770-f1f2-4d42-8dd7-0bf88e965d80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9ebc0770-f1f2-4d42-8dd7-0bf88e965d80', 7, NULL, 'Act II. Schahriar in the World of Fairy Tales', 'Arabian Nights, Ballet in Two Acts: Act II. Schahriar in the World of Fairy Tales', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ebc0770-f1f2-4d42-8dd7-0bf88e965d80'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act II. The Executioners', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act II. The Executioners',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:a114bcff-eb91-467d-a9c2-996c0ef6d019' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a114bcff-eb91-467d-a9c2-996c0ef6d019', 8, NULL, 'Act II. The Executioners', 'Arabian Nights, Ballet in Two Acts: Act II. The Executioners', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a114bcff-eb91-467d-a9c2-996c0ef6d019'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act II. The Pursuit', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act II. The Pursuit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:a4dda9b1-16f3-4860-af71-7be30a516cc7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a4dda9b1-16f3-4860-af71-7be30a516cc7', 9, NULL, 'Act II. The Pursuit', 'Arabian Nights, Ballet in Two Acts: Act II. The Pursuit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4dda9b1-16f3-4860-af71-7be30a516cc7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act II. Finale', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act II. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:a7974c66-b06c-400c-8b27-e3a71cc319cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a7974c66-b06c-400c-8b27-e3a71cc319cd', 10, NULL, 'Act II. Finale', 'Arabian Nights, Ballet in Two Acts: Act II. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7974c66-b06c-400c-8b27-e3a71cc319cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act II. Mardshana''s Dance', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act II. Mardshana''s Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:a904a747-70c7-4065-b191-b034b4f93b5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a904a747-70c7-4065-b191-b034b4f93b5d', 11, NULL, 'Act II. Mardshana''s Dance', 'Arabian Nights, Ballet in Two Acts: Act II. Mardshana''s Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a904a747-70c7-4065-b191-b034b4f93b5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Act II. Schahriar and the Executioners', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act II. Schahriar and the Executioners',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:bb5e2ff5-9cc0-4d9e-b2bf-8699e1c96dd1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bb5e2ff5-9cc0-4d9e-b2bf-8699e1c96dd1', 12, NULL, 'Act II. Schahriar and the Executioners', 'Arabian Nights, Ballet in Two Acts: Act II. Schahriar and the Executioners', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb5e2ff5-9cc0-4d9e-b2bf-8699e1c96dd1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Act II. The Second Tale (Aladdin and the Magic Lamp)', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act II. The Second Tale (Aladdin and the Magic Lamp)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:c5b59480-3d88-40b1-83c0-80be928d4193' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c5b59480-3d88-40b1-83c0-80be928d4193', 13, NULL, 'Act II. The Second Tale (Aladdin and the Magic Lamp)', 'Arabian Nights, Ballet in Two Acts: Act II. The Second Tale (Aladdin and the Magic Lamp)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5b59480-3d88-40b1-83c0-80be928d4193'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Act II. Duet: Schahriar and Scheherazade', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act II. Duet: Schahriar and Scheherazade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:d122310a-f84b-4953-bbf1-4dff9d0c090d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d122310a-f84b-4953-bbf1-4dff9d0c090d', 14, NULL, 'Act II. Duet: Schahriar and Scheherazade', 'Arabian Nights, Ballet in Two Acts: Act II. Duet: Schahriar and Scheherazade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d122310a-f84b-4953-bbf1-4dff9d0c090d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Act II. The First Tale (Sinbad the Sailor)', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act II. The First Tale (Sinbad the Sailor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:d54dae74-4ef8-40a8-ad66-23f0b90260de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d54dae74-4ef8-40a8-ad66-23f0b90260de', 15, NULL, 'Act II. The First Tale (Sinbad the Sailor)', 'Arabian Nights, Ballet in Two Acts: Act II. The First Tale (Sinbad the Sailor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d54dae74-4ef8-40a8-ad66-23f0b90260de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Act II. Dance of the Archers', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act II. Dance of the Archers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:e545ad89-4baa-4ff5-894b-99d829361d8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e545ad89-4baa-4ff5-894b-99d829361d8d', 16, NULL, 'Act II. Dance of the Archers', 'Arabian Nights, Ballet in Two Acts: Act II. Dance of the Archers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e545ad89-4baa-4ff5-894b-99d829361d8d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Act II. Night Music', part.name_en = 'Arabian Nights, Ballet in Two Acts: Act II. Night Music',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24948 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:ea1c5ca8-389c-4c61-9135-a94379de2fbc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ea1c5ca8-389c-4c61-9135-a94379de2fbc', 17, NULL, 'Act II. Night Music', 'Arabian Nights, Ballet in Two Acts: Act II. Night Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9faccaa3-7d52-4f9b-9212-10b2e4c4d095'
WHERE p.id = 24948 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea1c5ca8-389c-4c61-9135-a94379de2fbc'
);


-- None Azerbaijan Capriccio

UPDATE pieces piece
SET piece.title = 'Azerbaijan Capriccio', piece.title_en = 'Azerbaijan Capriccio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23999 AND piece.composer_id = 350
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Azerbaijan, Symphonic Suite

UPDATE pieces piece
SET piece.title = 'Azerbaijan, Symphonic Suite', piece.title_en = 'Azerbaijan, Symphonic Suite',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24266 AND piece.composer_id = 350
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'Azerbaijan, Symphonic Suite: I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24266 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:bc60f880-e4f5-4656-a44d-10cf2035738a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc60f880-e4f5-4656-a44d-10cf2035738a', 1, 'I', 'Allegretto', 'Azerbaijan, Symphonic Suite: I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24266 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc60f880-e4f5-4656-a44d-10cf2035738a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante sostenuto', part.name_en = 'Azerbaijan, Symphonic Suite: II. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24266 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:91ff24c4-9f3c-44c0-9d5d-62638cd4e993' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91ff24c4-9f3c-44c0-9d5d-62638cd4e993', 2, 'II', 'Andante sostenuto', 'Azerbaijan, Symphonic Suite: II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24266 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91ff24c4-9f3c-44c0-9d5d-62638cd4e993'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto', part.name_en = 'Azerbaijan, Symphonic Suite: III. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24266 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:215505c0-d436-44b7-a77b-42951d4537bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:215505c0-d436-44b7-a77b-42951d4537bb', 3, 'III', 'Allegretto', 'Azerbaijan, Symphonic Suite: III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24266 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:215505c0-d436-44b7-a77b-42951d4537bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Mesto', part.name_en = 'Azerbaijan, Symphonic Suite: IV. Mesto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24266 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:b90f3779-fac2-4532-92c5-24662efd54a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b90f3779-fac2-4532-92c5-24662efd54a0', 4, 'IV', 'Mesto', 'Azerbaijan, Symphonic Suite: IV. Mesto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24266 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b90f3779-fac2-4532-92c5-24662efd54a0'
);


-- None Gülistan Bayaty Shiraz

UPDATE pieces piece
SET piece.title = 'Gülistan Bayaty Shiraz', piece.title_en = 'Gülistan Bayaty Shiraz',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23701 AND piece.composer_id = 350
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Kor Arab>

UPDATE pieces piece
SET piece.title = '가곡 <Kor Arab>', piece.title_en = 'Kor Arab',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23673 AND piece.composer_id = 350
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Kürd ovşarı

UPDATE pieces piece
SET piece.title = 'Kürd ovşarı', piece.title_en = 'Kürd ovşarı',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25614 AND piece.composer_id = 350
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Sevil>

UPDATE pieces piece
SET piece.title = '오페라 <Sevil>', piece.title_en = 'Sevil',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24571 AND piece.composer_id = 350
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Shur, Symphonic Mugam

UPDATE pieces piece
SET piece.title = 'Shur, Symphonic Mugam', piece.title_en = 'Shur, Symphonic Mugam',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25188 AND piece.composer_id = 350
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction', part.name_en = 'Shur, Symphonic Mugam: I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25188 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:7ba5d973-235b-4988-a8df-4bf329b6915c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ba5d973-235b-4988-a8df-4bf329b6915c', 1, 'I', 'Introduction', 'Shur, Symphonic Mugam: I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25188 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ba5d973-235b-4988-a8df-4bf329b6915c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Shur', part.name_en = 'Shur, Symphonic Mugam: II. Shur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25188 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:1bd66e29-677d-4174-899a-5e0f8734bb6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bd66e29-677d-4174-899a-5e0f8734bb6e', 2, 'II', 'Shur', 'Shur, Symphonic Mugam: II. Shur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25188 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bd66e29-677d-4174-899a-5e0f8734bb6e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tesnif', part.name_en = 'Shur, Symphonic Mugam: III. Tesnif',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25188 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:a774ae30-ea30-4225-bf09-a13113395bef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a774ae30-ea30-4225-bf09-a13113395bef', 3, 'III', 'Tesnif', 'Shur, Symphonic Mugam: III. Tesnif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25188 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a774ae30-ea30-4225-bf09-a13113395bef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Shur-Shakhnaz', part.name_en = 'Shur, Symphonic Mugam: IV. Shur-Shakhnaz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25188 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:7f8a9370-a72c-40e2-97db-df977dbc060b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f8a9370-a72c-40e2-97db-df977dbc060b', 4, 'IV', 'Shur-Shakhnaz', 'Shur, Symphonic Mugam: IV. Shur-Shakhnaz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25188 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f8a9370-a72c-40e2-97db-df977dbc060b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Ryang', part.name_en = 'Shur, Symphonic Mugam: V. Ryang',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25188 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:a371437d-d696-48b8-8bad-e71e46c0751e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a371437d-d696-48b8-8bad-e71e46c0751e', 5, 'V', 'Ryang', 'Shur, Symphonic Mugam: V. Ryang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25188 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a371437d-d696-48b8-8bad-e71e46c0751e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Bayaty', part.name_en = 'Shur, Symphonic Mugam: VI. Bayaty',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25188 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:dc3a3878-9aff-4b84-a72c-4fe0cbedf230' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc3a3878-9aff-4b84-a72c-4fe0cbedf230', 6, 'VI', 'Bayaty', 'Shur, Symphonic Mugam: VI. Bayaty', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25188 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc3a3878-9aff-4b84-a72c-4fe0cbedf230'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Ryang', part.name_en = 'Shur, Symphonic Mugam: VII. Ryang',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25188 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:f144996d-95a1-4890-874a-94245d24be1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f144996d-95a1-4890-874a-94245d24be1e', 7, 'VII', 'Ryang', 'Shur, Symphonic Mugam: VII. Ryang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25188 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f144996d-95a1-4890-874a-94245d24be1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Tesnif', part.name_en = 'Shur, Symphonic Mugam: VIII. Tesnif',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25188 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:b973ec7b-4534-4e05-97c6-4efd71529a87' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b973ec7b-4534-4e05-97c6-4efd71529a87', 8, 'VIII', 'Tesnif', 'Shur, Symphonic Mugam: VIII. Tesnif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25188 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b973ec7b-4534-4e05-97c6-4efd71529a87'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Iraq', part.name_en = 'Shur, Symphonic Mugam: IX. Iraq',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25188 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:560b6522-66f6-4285-bf7e-b208d4392a06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:560b6522-66f6-4285-bf7e-b208d4392a06', 9, 'IX', 'Iraq', 'Shur, Symphonic Mugam: IX. Iraq', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25188 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:560b6522-66f6-4285-bf7e-b208d4392a06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Siman-Shems', part.name_en = 'Shur, Symphonic Mugam: X. Siman-Shems',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25188 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:cc8c7e35-3ede-4244-8acf-c88328b767e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc8c7e35-3ede-4244-8acf-c88328b767e5', 10, 'X', 'Siman-Shems', 'Shur, Symphonic Mugam: X. Siman-Shems', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25188 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc8c7e35-3ede-4244-8acf-c88328b767e5'
);


-- None 6개의 플루트와 피아노를 위한 소품

UPDATE pieces piece
SET piece.title = '6개의 플루트와 피아노를 위한 소품', piece.title_en = 'Six Pieces for Flute and Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24238 AND piece.composer_id = 350
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Song of the Ashuge', part.name_en = 'Six Pieces for Flute and Piano: Song of the Ashuge',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24238 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:bbfc4806-f43c-4f34-a22b-f2a1e447adda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbfc4806-f43c-4f34-a22b-f2a1e447adda', 1, NULL, 'Song of the Ashuge', 'Six Pieces for Flute and Piano: Song of the Ashuge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24238 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbfc4806-f43c-4f34-a22b-f2a1e447adda'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Lullaby', part.name_en = 'Six Pieces for Flute and Piano: Lullaby',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24238 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:701e2b16-34bf-48ec-9302-b752ddbf44d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:701e2b16-34bf-48ec-9302-b752ddbf44d9', 2, NULL, 'Lullaby', 'Six Pieces for Flute and Piano: Lullaby', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24238 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:701e2b16-34bf-48ec-9302-b752ddbf44d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Dance', part.name_en = 'Six Pieces for Flute and Piano: Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24238 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:4ab39f63-b2d5-4d0e-8d8e-d4b72fdb3613' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ab39f63-b2d5-4d0e-8d8e-d4b72fdb3613', 3, NULL, 'Dance', 'Six Pieces for Flute and Piano: Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24238 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ab39f63-b2d5-4d0e-8d8e-d4b72fdb3613'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'In the Azerbaijan Mountains', part.name_en = 'Six Pieces for Flute and Piano: In the Azerbaijan Mountains',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24238 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:64cc5452-c0b3-4abd-a34d-8ae62eaa7df3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64cc5452-c0b3-4abd-a34d-8ae62eaa7df3', 4, NULL, 'In the Azerbaijan Mountains', 'Six Pieces for Flute and Piano: In the Azerbaijan Mountains', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24238 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64cc5452-c0b3-4abd-a34d-8ae62eaa7df3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'At the Spring', part.name_en = 'Six Pieces for Flute and Piano: At the Spring',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24238 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:daf2cd70-3488-4b33-8b48-86663eaa217a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:daf2cd70-3488-4b33-8b48-86663eaa217a', 5, NULL, 'At the Spring', 'Six Pieces for Flute and Piano: At the Spring', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24238 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:daf2cd70-3488-4b33-8b48-86663eaa217a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Nocturne', part.name_en = 'Six Pieces for Flute and Piano: Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24238 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:f0000bcf-2d6e-4ddd-b93e-eb05ef479cb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0000bcf-2d6e-4ddd-b93e-eb05ef479cb0', 6, NULL, 'Nocturne', 'Six Pieces for Flute and Piano: Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24238 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0000bcf-2d6e-4ddd-b93e-eb05ef479cb0'
);


-- None Symphony for String Orchestra

UPDATE pieces piece
SET piece.title = 'Symphony for String Orchestra', piece.title_en = 'Symphony for String Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25807 AND piece.composer_id = 350
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante maestoso - Allegretto', part.name_en = 'Symphony for String Orchestra: I. Andante maestoso - Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25807 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:abb61bab-426e-43fd-a5d4-675d31f2b908' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:abb61bab-426e-43fd-a5d4-675d31f2b908', 1, 'I', 'Andante maestoso - Allegretto', 'Symphony for String Orchestra: I. Andante maestoso - Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25807 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abb61bab-426e-43fd-a5d4-675d31f2b908'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto giocoso', part.name_en = 'Symphony for String Orchestra: II. Allegretto giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25807 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:e595547c-1f73-495a-9a76-9f62357c4ada' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e595547c-1f73-495a-9a76-9f62357c4ada', 2, 'II', 'Allegretto giocoso', 'Symphony for String Orchestra: II. Allegretto giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25807 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e595547c-1f73-495a-9a76-9f62357c4ada'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante sostenuto', part.name_en = 'Symphony for String Orchestra: III. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25807 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:941b9dac-8590-4ead-ad63-5fe897bf84ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:941b9dac-8590-4ead-ad63-5fe897bf84ab', 3, 'III', 'Andante sostenuto', 'Symphony for String Orchestra: III. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25807 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:941b9dac-8590-4ead-ad63-5fe897bf84ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro con brio', part.name_en = 'Symphony for String Orchestra: IV. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25807 AND p.composer_id = 350 AND part.part_key = 'musicbrainz:183fcb4b-2b68-4923-9bd5-8f52b2f1f092' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:183fcb4b-2b68-4923-9bd5-8f52b2f1f092', 4, 'IV', 'Allegro con brio', 'Symphony for String Orchestra: IV. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25807 AND p.composer_id = 350
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:183fcb4b-2b68-4923-9bd5-8f52b2f1f092'
);


-- None Symphonic Dances

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Symphonic Dances', 'Symphonic Dances', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 350
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Symphonic Dances'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d75d91b-054f-429d-b4ea-1572a84662b3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8d75d91b-054f-429d-b4ea-1572a84662b3'
FROM pieces p
WHERE p.composer_id = 350 AND p.title = 'Symphonic Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d75d91b-054f-429d-b4ea-1572a84662b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81f4bb5a-ad6c-46c9-afcf-314d69fc9493', 1, 'I', 'Dance of Joy. Allegro con giubilo', 'Symphonic Dances: I. Dance of Joy. Allegro con giubilo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 350 AND p.title = 'Symphonic Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81f4bb5a-ad6c-46c9-afcf-314d69fc9493'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:666231ce-8ecd-410f-96e9-42466076de69', 2, 'II', 'Girls’ Dance. Andante cantabile amoroso', 'Symphonic Dances: II. Girls’ Dance. Andante cantabile amoroso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 350 AND p.title = 'Symphonic Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:666231ce-8ecd-410f-96e9-42466076de69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:807e149c-137b-44af-80e7-cbf274c9888a', 3, 'III', 'Dance Caprice. Allegretto alla zoppa', 'Symphonic Dances: III. Dance Caprice. Allegretto alla zoppa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 350 AND p.title = 'Symphonic Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:807e149c-137b-44af-80e7-cbf274c9888a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82306004-699d-4261-ba92-0b3ce8059fe8', 4, 'IV', 'The Yalli Round Dance. Andante sostenuto', 'Symphonic Dances: IV. The Yalli Round Dance. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 350 AND p.title = 'Symphonic Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82306004-699d-4261-ba92-0b3ce8059fe8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fb0c18d-b2c7-4684-a253-914f3d48d60c', 5, 'V', 'Dance of Djigits. Allegretto con spirito', 'Symphonic Dances: V. Dance of Djigits. Allegretto con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 350 AND p.title = 'Symphonic Dances' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fb0c18d-b2c7-4684-a253-914f3d48d60c'
);

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 350 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    24162
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Ton de Leeuw (composer_id 351) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 20개(묶음 0, 다악장 2, 낱곡 18),
-- 새 작품 6개, part 9개, 그 아래 0개.
-- seed 14개 중 14개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Antiphonie

UPDATE pieces piece
SET piece.title = 'Antiphonie', piece.title_en = 'Antiphonie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25187 AND piece.composer_id = 351
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Egidius, waer bestu bleven?

UPDATE pieces piece
SET piece.title = 'Egidius, waer bestu bleven?', piece.title_en = 'Egidius, waer bestu bleven?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25218 AND piece.composer_id = 351
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None En begheeft my niet

UPDATE pieces piece
SET piece.title = 'En begheeft my niet', piece.title_en = 'En begheeft my niet',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24826 AND piece.composer_id = 351
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Het visschertje

UPDATE pieces piece
SET piece.title = 'Het visschertje', piece.title_en = 'Het visschertje',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24842 AND piece.composer_id = 351
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Interlude

UPDATE pieces piece
SET piece.title = 'Interlude', piece.title_en = 'Interlude',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25655 AND piece.composer_id = 351
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Missa brevis

UPDATE pieces piece
SET piece.title = 'Missa brevis', piece.title_en = 'Missa brevis',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25785 AND piece.composer_id = 351
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'II',
    part.name_ko = 'Gloria', part.name_en = 'Missa brevis: II. Gloria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25785 AND p.composer_id = 351 AND part.part_key = 'musicbrainz:3e7d2480-c21b-48f7-a121-a8bde76bb204' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e7d2480-c21b-48f7-a121-a8bde76bb204', 1, 'II', 'Gloria', 'Missa brevis: II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25785 AND p.composer_id = 351
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e7d2480-c21b-48f7-a121-a8bde76bb204'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'I',
    part.name_ko = 'Kyrie elesion', part.name_en = 'Missa brevis: I. Kyrie elesion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25785 AND p.composer_id = 351 AND part.part_key = 'musicbrainz:7fb84c31-50a4-400d-ab59-8d8de1f32160' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fb84c31-50a4-400d-ab59-8d8de1f32160', 2, 'I', 'Kyrie elesion', 'Missa brevis: I. Kyrie elesion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25785 AND p.composer_id = 351
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fb84c31-50a4-400d-ab59-8d8de1f32160'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sanctus', part.name_en = 'Missa brevis: III. Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25785 AND p.composer_id = 351 AND part.part_key = 'musicbrainz:a1fab273-d478-47f3-a7df-5f0fae2254ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1fab273-d478-47f3-a7df-5f0fae2254ff', 3, 'III', 'Sanctus', 'Missa brevis: III. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25785 AND p.composer_id = 351
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1fab273-d478-47f3-a7df-5f0fae2254ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Benedictus', part.name_en = 'Missa brevis: IV. Benedictus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25785 AND p.composer_id = 351 AND part.part_key = 'musicbrainz:cc861c47-0959-4553-83c2-237b130f77f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc861c47-0959-4553-83c2-237b130f77f6', 4, 'IV', 'Benedictus', 'Missa brevis: IV. Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25785 AND p.composer_id = 351
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc861c47-0959-4553-83c2-237b130f77f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Agnus Dei', part.name_en = 'Missa brevis: V. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25785 AND p.composer_id = 351 AND part.part_key = 'musicbrainz:ea6dad4c-8471-4bd8-88bc-307776a803bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea6dad4c-8471-4bd8-88bc-307776a803bb', 5, 'V', 'Agnus Dei', 'Missa brevis: V. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25785 AND p.composer_id = 351
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea6dad4c-8471-4bd8-88bc-307776a803bb'
);


-- None Mouvements rétrogrades

UPDATE pieces piece
SET piece.title = 'Mouvements rétrogrades', piece.title_en = 'Mouvements rétrogrades',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24716 AND piece.composer_id = 351
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ombres

UPDATE pieces piece
SET piece.title = 'Ombres', piece.title_en = 'Ombres',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23955 AND piece.composer_id = 351
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Ombres: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23955 AND p.composer_id = 351 AND part.part_key = 'musicbrainz:03fafc24-15c9-4c37-9b55-3bc2152f4418' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03fafc24-15c9-4c37-9b55-3bc2152f4418', 1, NULL, 'I', 'Ombres: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23955 AND p.composer_id = 351
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03fafc24-15c9-4c37-9b55-3bc2152f4418'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Ombres: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23955 AND p.composer_id = 351 AND part.part_key = 'musicbrainz:29112648-17fb-4530-80cf-5c093c6551d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29112648-17fb-4530-80cf-5c093c6551d3', 2, NULL, 'II', 'Ombres: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23955 AND p.composer_id = 351
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29112648-17fb-4530-80cf-5c093c6551d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Ombres: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23955 AND p.composer_id = 351 AND part.part_key = 'musicbrainz:6f566dfc-5a81-4ec7-bee2-0ebdd3fa7f68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f566dfc-5a81-4ec7-bee2-0ebdd3fa7f68', 3, NULL, 'III', 'Ombres: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23955 AND p.composer_id = 351
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f566dfc-5a81-4ec7-bee2-0ebdd3fa7f68'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Ombres: IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23955 AND p.composer_id = 351 AND part.part_key = 'musicbrainz:af168cd7-3dba-4491-a3b0-c0e8ff8b9e91' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af168cd7-3dba-4491-a3b0-c0e8ff8b9e91', 4, NULL, 'IV', 'Ombres: IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23955 AND p.composer_id = 351
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af168cd7-3dba-4491-a3b0-c0e8ff8b9e91'
);


-- None Prière

UPDATE pieces piece
SET piece.title = 'Prière', piece.title_en = 'Prière',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25331 AND piece.composer_id = 351
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연습곡

UPDATE pieces piece
SET piece.title = '연습곡', piece.title_en = 'Study',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25717 AND piece.composer_id = 351
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Symphonies of Winds

UPDATE pieces piece
SET piece.title = 'Symphonies of Winds', piece.title_en = 'Symphonies of Winds',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25473 AND piece.composer_id = 351
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Symphony for Strings and Percussion

UPDATE pieces piece
SET piece.title = 'Symphony for Strings and Percussion', piece.title_en = 'Symphony for Strings and Percussion',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24886 AND piece.composer_id = 351
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Birth of Music

UPDATE pieces piece
SET piece.title = 'The Birth of Music', piece.title_en = 'The Birth of Music',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24279 AND piece.composer_id = 351
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None À cette heure du jour

UPDATE pieces piece
SET piece.title = 'À cette heure du jour', piece.title_en = 'À cette heure du jour',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24783 AND piece.composer_id = 351
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chronos

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Chronos', 'Chronos', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 351
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Chronos'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32263c81-c4b9-4964-8b3c-4598a65d8d97'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '32263c81-c4b9-4964-8b3c-4598a65d8d97'
FROM pieces p
WHERE p.composer_id = 351 AND p.title = 'Chronos' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32263c81-c4b9-4964-8b3c-4598a65d8d97'
);


-- None Clair Obscur

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Clair Obscur', 'Clair Obscur', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 351
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Clair Obscur'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80e35620-a8ac-4ea4-911e-b338c9cdbb26'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '80e35620-a8ac-4ea4-911e-b338c9cdbb26'
FROM pieces p
WHERE p.composer_id = 351 AND p.title = 'Clair Obscur' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80e35620-a8ac-4ea4-911e-b338c9cdbb26'
);


-- None Job

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Job', 'Job', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 351
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Job'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f46b6b37-813a-4845-ac5d-d8ef1985f36b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f46b6b37-813a-4845-ac5d-d8ef1985f36b'
FROM pieces p
WHERE p.composer_id = 351 AND p.title = 'Job' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f46b6b37-813a-4845-ac5d-d8ef1985f36b'
);


-- None Mountains

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Mountains', 'Mountains', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 351
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Mountains'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '65567edf-5e28-48cf-a88b-9bd757272ad7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '65567edf-5e28-48cf-a88b-9bd757272ad7'
FROM pieces p
WHERE p.composer_id = 351 AND p.title = 'Mountains' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '65567edf-5e28-48cf-a88b-9bd757272ad7'
);


-- None Syntaxis I

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Syntaxis I', 'Syntaxis I', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 351
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Syntaxis I'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d7ade0f-2161-4250-8c68-1904e8cea366'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8d7ade0f-2161-4250-8c68-1904e8cea366'
FROM pieces p
WHERE p.composer_id = 351 AND p.title = 'Syntaxis I' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d7ade0f-2161-4250-8c68-1904e8cea366'
);


-- None The Birth of Music II

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Birth of Music II', 'The Birth of Music II', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 351
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Birth of Music II'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4c7705f-fe7c-4278-9f23-4b0ef13190cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b4c7705f-fe7c-4278-9f23-4b0ef13190cf'
FROM pieces p
WHERE p.composer_id = 351 AND p.title = 'The Birth of Music II' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4c7705f-fe7c-4278-9f23-4b0ef13190cf'
);

-- 숨길 seed 작품 없음

-- ===== Peter Wishart (composer_id 353) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 3개(묶음 1, 다악장 1, 낱곡 1),
-- 새 작품 0개, part 7개, 그 아래 0개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Jesu, dulcis memoria

UPDATE pieces piece
SET piece.title = 'Jesu, dulcis memoria', piece.title_en = 'Jesu, dulcis memoria',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25835 AND piece.composer_id = 353
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Serenata Concertante for Clarinet and Small Orchestra

UPDATE pieces piece
SET piece.title = 'Serenata Concertante for Clarinet and Small Orchestra', piece.title_en = 'Serenata Concertante for Clarinet and Small Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25138 AND piece.composer_id = 353
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prelude. Allegro molto', part.name_en = 'Serenata Concertante for Clarinet and Small Orchestra: I. Prelude. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25138 AND p.composer_id = 353 AND part.part_key = 'musicbrainz:696ab935-1734-4c76-8807-32b383d2ecc7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:696ab935-1734-4c76-8807-32b383d2ecc7', 1, 'I', 'Prelude. Allegro molto', 'Serenata Concertante for Clarinet and Small Orchestra: I. Prelude. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25138 AND p.composer_id = 353
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:696ab935-1734-4c76-8807-32b383d2ecc7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'March. Risoluto alla marcia', part.name_en = 'Serenata Concertante for Clarinet and Small Orchestra: II. March. Risoluto alla marcia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25138 AND p.composer_id = 353 AND part.part_key = 'musicbrainz:abba934c-8550-4496-8110-d9cb86ee89f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:abba934c-8550-4496-8110-d9cb86ee89f5', 2, 'II', 'March. Risoluto alla marcia', 'Serenata Concertante for Clarinet and Small Orchestra: II. March. Risoluto alla marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25138 AND p.composer_id = 353
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abba934c-8550-4496-8110-d9cb86ee89f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Choral. Prelude, semplice e con ammore "Josef lieber, Josef mein"', part.name_en = 'Serenata Concertante for Clarinet and Small Orchestra: III. Choral. Prelude, semplice e con ammore "Josef lieber, Josef mein"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25138 AND p.composer_id = 353 AND part.part_key = 'musicbrainz:3171693d-ee8b-4aa2-a916-76bffa699a52' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3171693d-ee8b-4aa2-a916-76bffa699a52', 3, 'III', 'Choral. Prelude, semplice e con ammore "Josef lieber, Josef mein"', 'Serenata Concertante for Clarinet and Small Orchestra: III. Choral. Prelude, semplice e con ammore "Josef lieber, Josef mein"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25138 AND p.composer_id = 353
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3171693d-ee8b-4aa2-a916-76bffa699a52'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Waltz. Tempo di valse', part.name_en = 'Serenata Concertante for Clarinet and Small Orchestra: IV. Waltz. Tempo di valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25138 AND p.composer_id = 353 AND part.part_key = 'musicbrainz:b16ade0e-e73a-4dc8-a31a-b38455c8233f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b16ade0e-e73a-4dc8-a31a-b38455c8233f', 4, 'IV', 'Waltz. Tempo di valse', 'Serenata Concertante for Clarinet and Small Orchestra: IV. Waltz. Tempo di valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25138 AND p.composer_id = 353
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b16ade0e-e73a-4dc8-a31a-b38455c8233f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Habanera. Moderato tempo di habanera ma molto flessible', part.name_en = 'Serenata Concertante for Clarinet and Small Orchestra: V. Habanera. Moderato tempo di habanera ma molto flessible',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25138 AND p.composer_id = 353 AND part.part_key = 'musicbrainz:7dcad760-f0be-4980-b9e7-d7ac565ae27d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7dcad760-f0be-4980-b9e7-d7ac565ae27d', 5, 'V', 'Habanera. Moderato tempo di habanera ma molto flessible', 'Serenata Concertante for Clarinet and Small Orchestra: V. Habanera. Moderato tempo di habanera ma molto flessible', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25138 AND p.composer_id = 353
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dcad760-f0be-4980-b9e7-d7ac565ae27d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Finale. Rondino, molto allegro', part.name_en = 'Serenata Concertante for Clarinet and Small Orchestra: VI. Finale. Rondino, molto allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25138 AND p.composer_id = 353 AND part.part_key = 'musicbrainz:51257738-0a83-4e36-9581-7f04c88be919' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51257738-0a83-4e36-9581-7f04c88be919', 6, 'VI', 'Finale. Rondino, molto allegro', 'Serenata Concertante for Clarinet and Small Orchestra: VI. Finale. Rondino, molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25138 AND p.composer_id = 353
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51257738-0a83-4e36-9581-7f04c88be919'
);


-- Op. 17 Three Carols Op. 17

UPDATE pieces piece
SET piece.title = 'Three Carols Op. 17', piece.title_en = 'Three Carols, op. 17',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '17',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25403 AND piece.composer_id = 353
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Alleluya, a new Work is come on Hand, op. 17 no. 3', part.name_en = 'Alleluya, a new Work is come on Hand, op. 17 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25403 AND p.composer_id = 353 AND part.part_key = 'musicbrainz:3865a4f6-1a6f-4cd1-a94b-d519f2753d89' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3865a4f6-1a6f-4cd1-a94b-d519f2753d89', 1, NULL, 'Alleluya, a new Work is come on Hand, op. 17 no. 3', 'Alleluya, a new Work is come on Hand, op. 17 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25403 AND p.composer_id = 353
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3865a4f6-1a6f-4cd1-a94b-d519f2753d89'
);

-- 숨길 seed 작품 없음

-- ===== Thomas Byström (composer_id 355) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Quadrille

UPDATE pieces piece
SET piece.title = 'Quadrille', piece.title_en = 'Quadrille',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25064 AND piece.composer_id = 355
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== 파울 린케 (composer_id 365) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 13개(묶음 5, 다악장 0, 낱곡 8),
-- 새 작품 1개, part 19개, 그 아래 1개.
-- seed 15개 중 12개를 작품·part 에 잇고, 2개를 숨기고, 1개는 그대로 둔다.

-- None 오페레타 <Casanova>

UPDATE pieces piece
SET piece.title = '오페레타 <Casanova>', piece.title_en = 'Casanova',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23480 AND piece.composer_id = 365
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '“Isola bella”', part.name_en = 'Casanova: “Isola bella”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23480 AND p.composer_id = 365 AND part.part_key = 'musicbrainz:1313b666-97d5-485d-b5ac-1ef068e65a2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1313b666-97d5-485d-b5ac-1ef068e65a2c', 1, NULL, '“Isola bella”', 'Casanova: “Isola bella”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23480 AND p.composer_id = 365
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1313b666-97d5-485d-b5ac-1ef068e65a2c'
);


-- None 가곡 <Es war einmal>

UPDATE pieces piece
SET piece.title = '가곡 <Es war einmal>', piece.title_en = 'Es war einmal',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24873 AND piece.composer_id = 365
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페레타 <Frau Luna>

UPDATE pieces piece
SET piece.title = '오페레타 <Frau Luna>', piece.title_en = 'Frau Luna',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24744 AND piece.composer_id = 365
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ouvertüre', part.name_en = 'Frau Luna: Ouvertüre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24744 AND p.composer_id = 365 AND part.part_key = 'musicbrainz:9cde36db-735a-4293-a91f-a10b5246be94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9cde36db-735a-4293-a91f-a10b5246be94', 1, NULL, 'Ouvertüre', 'Frau Luna: Ouvertüre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24744 AND p.composer_id = 365
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cde36db-735a-4293-a91f-a10b5246be94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Akt I', part.name_en = 'Frau Luna: Akt I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24744 AND p.composer_id = 365 AND part.part_key = 'musicbrainz:bae0a04b-65b4-4200-8a81-13df7b47658c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bae0a04b-65b4-4200-8a81-13df7b47658c', 2, NULL, 'Akt I', 'Frau Luna: Akt I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24744 AND p.composer_id = 365
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bae0a04b-65b4-4200-8a81-13df7b47658c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bae0a04b-65b4-4200-8a81-13df7b47658c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Akt I. “Schlösser, die im Monde liegen” (Marie)', part.name_en = 'Frau Luna: Akt I. “Schlösser, die im Monde liegen” (Marie)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24744 AND p.composer_id = 365 AND part.part_key = 'musicbrainz:837df716-898c-4341-b786-391212889a7e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:837df716-898c-4341-b786-391212889a7e', 1, NULL, 'Akt I. “Schlösser, die im Monde liegen” (Marie)', 'Frau Luna: Akt I. “Schlösser, die im Monde liegen” (Marie)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bae0a04b-65b4-4200-8a81-13df7b47658c'
WHERE p.id = 24744 AND p.composer_id = 365
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:837df716-898c-4341-b786-391212889a7e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Akt II', part.name_en = 'Frau Luna: Akt II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24744 AND p.composer_id = 365 AND part.part_key = 'musicbrainz:21eacd29-f080-45db-ba55-dcf3f3e8f79d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21eacd29-f080-45db-ba55-dcf3f3e8f79d', 3, NULL, 'Akt II', 'Frau Luna: Akt II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24744 AND p.composer_id = 365
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21eacd29-f080-45db-ba55-dcf3f3e8f79d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '„Glühwürmchen, Glühwürmchen flimm''re”', part.name_en = 'Lysistrata: „Glühwürmchen, Glühwürmchen flimm''re”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24744 AND p.composer_id = 365 AND part.part_key = 'musicbrainz:020a2aa8-5efd-4522-b50c-0b59ed715d17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:020a2aa8-5efd-4522-b50c-0b59ed715d17', 4, NULL, '„Glühwürmchen, Glühwürmchen flimm''re”', 'Lysistrata: „Glühwürmchen, Glühwürmchen flimm''re”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24744 AND p.composer_id = 365
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:020a2aa8-5efd-4522-b50c-0b59ed715d17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Wenn du Lust hast', part.name_en = 'Wenn du Lust hast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24744 AND p.composer_id = 365 AND part.part_key = 'musicbrainz:0767c6be-952e-4418-8282-d0588943aebe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0767c6be-952e-4418-8282-d0588943aebe', 5, NULL, 'Wenn du Lust hast', 'Wenn du Lust hast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24744 AND p.composer_id = 365
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0767c6be-952e-4418-8282-d0588943aebe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Lasst den Kopf nicht hängen', part.name_en = 'Frau Luna: Lasst den Kopf nicht hängen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24744 AND p.composer_id = 365 AND part.part_key = 'musicbrainz:0c24a1e1-7099-4943-8643-b7e5b95d1ec0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c24a1e1-7099-4943-8643-b7e5b95d1ec0', 6, NULL, 'Lasst den Kopf nicht hängen', 'Frau Luna: Lasst den Kopf nicht hängen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24744 AND p.composer_id = 365
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c24a1e1-7099-4943-8643-b7e5b95d1ec0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '„Schenk mir doch ein kleines bisschen Liebe”', part.name_en = 'Frau Luna: „Schenk mir doch ein kleines bisschen Liebe”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24744 AND p.composer_id = 365 AND part.part_key = 'musicbrainz:21399b11-88a4-4d54-a686-1f408f17d0b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21399b11-88a4-4d54-a686-1f408f17d0b9', 7, NULL, '„Schenk mir doch ein kleines bisschen Liebe”', 'Frau Luna: „Schenk mir doch ein kleines bisschen Liebe”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24744 AND p.composer_id = 365
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21399b11-88a4-4d54-a686-1f408f17d0b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Wenn die Sonne schlafen geht', part.name_en = 'Frau Luna: Wenn die Sonne schlafen geht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24744 AND p.composer_id = 365 AND part.part_key = 'musicbrainz:30d52d08-c4d4-4e89-bad8-33248a08099d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30d52d08-c4d4-4e89-bad8-33248a08099d', 8, NULL, 'Wenn die Sonne schlafen geht', 'Frau Luna: Wenn die Sonne schlafen geht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24744 AND p.composer_id = 365
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30d52d08-c4d4-4e89-bad8-33248a08099d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Fahr mit mir zum Mond', part.name_en = 'Frau Luna: Fahr mit mir zum Mond',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24744 AND p.composer_id = 365 AND part.part_key = 'musicbrainz:70a564f8-f538-42f9-9636-d30843fd68ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70a564f8-f538-42f9-9636-d30843fd68ba', 9, NULL, 'Fahr mit mir zum Mond', 'Frau Luna: Fahr mit mir zum Mond', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24744 AND p.composer_id = 365
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70a564f8-f538-42f9-9636-d30843fd68ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Bis früh um fünfe', part.name_en = 'Frau Luna: Bis früh um fünfe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24744 AND p.composer_id = 365 AND part.part_key = 'musicbrainz:c25c18d2-f9fa-4670-b0d8-62774cfd995e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c25c18d2-f9fa-4670-b0d8-62774cfd995e', 10, NULL, 'Bis früh um fünfe', 'Frau Luna: Bis früh um fünfe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24744 AND p.composer_id = 365
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c25c18d2-f9fa-4670-b0d8-62774cfd995e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Lose, muntre Lieder', part.name_en = 'Frau Luna: Lose, muntre Lieder',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24744 AND p.composer_id = 365 AND part.part_key = 'musicbrainz:d67fd96f-1097-4dc5-8770-257867dc5c18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d67fd96f-1097-4dc5-8770-257867dc5c18', 11, NULL, 'Lose, muntre Lieder', 'Frau Luna: Lose, muntre Lieder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24744 AND p.composer_id = 365
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d67fd96f-1097-4dc5-8770-257867dc5c18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Das macht die Berliner Luft', part.name_en = 'Frau Luna: Das macht die Berliner Luft',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24744 AND p.composer_id = 365 AND part.part_key = 'musicbrainz:e40bfd5d-fa57-4f54-b232-bd1add3f6480' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e40bfd5d-fa57-4f54-b232-bd1add3f6480', 12, NULL, 'Das macht die Berliner Luft', 'Frau Luna: Das macht die Berliner Luft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24744 AND p.composer_id = 365
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e40bfd5d-fa57-4f54-b232-bd1add3f6480'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Nach der Liebesinsel', part.name_en = 'Frau Luna: Nach der Liebesinsel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24744 AND p.composer_id = 365 AND part.part_key = 'musicbrainz:f3005ae0-5693-4271-ae34-55793a1b00b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3005ae0-5693-4271-ae34-55793a1b00b3', 13, NULL, 'Nach der Liebesinsel', 'Frau Luna: Nach der Liebesinsel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24744 AND p.composer_id = 365
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3005ae0-5693-4271-ae34-55793a1b00b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'O Theophil', part.name_en = 'Frau Luna: O Theophil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24744 AND p.composer_id = 365 AND part.part_key = 'musicbrainz:f7d9c5cd-e13a-44cc-afe6-9e1523c80155' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7d9c5cd-e13a-44cc-afe6-9e1523c80155', 14, NULL, 'O Theophil', 'Frau Luna: O Theophil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24744 AND p.composer_id = 365
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7d9c5cd-e13a-44cc-afe6-9e1523c80155'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Schutzmann-Marsch', part.name_en = 'Frau Luna: Schutzmann-Marsch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24744 AND p.composer_id = 365 AND part.part_key = 'musicbrainz:fd1806d4-c00a-4299-9847-fa027c66ec86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd1806d4-c00a-4299-9847-fa027c66ec86', 15, NULL, 'Schutzmann-Marsch', 'Frau Luna: Schutzmann-Marsch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24744 AND p.composer_id = 365
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd1806d4-c00a-4299-9847-fa027c66ec86'
);


-- None 오페레타 <Grigri>

UPDATE pieces piece
SET piece.title = '오페레타 <Grigri>', piece.title_en = 'Grigri',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23466 AND piece.composer_id = 365
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '„Wenn im Lenz die Knospen sprießen”', part.name_en = 'Grigri: „Wenn im Lenz die Knospen sprießen”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23466 AND p.composer_id = 365 AND part.part_key = 'musicbrainz:b2a65c79-ad8c-496a-a142-bfaacaaeffd8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2a65c79-ad8c-496a-a142-bfaacaaeffd8', 1, NULL, '„Wenn im Lenz die Knospen sprießen”', 'Grigri: „Wenn im Lenz die Knospen sprießen”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23466 AND p.composer_id = 365
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2a65c79-ad8c-496a-a142-bfaacaaeffd8'
);


-- None Halloh! Die große Revue!!

UPDATE pieces piece
SET piece.title = 'Halloh! Die große Revue!!', piece.title_en = 'Halloh! Die große Revue!!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23218 AND piece.composer_id = 365
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Im Walzerrausch

UPDATE pieces piece
SET piece.title = 'Im Walzerrausch', piece.title_en = 'Im Walzerrausch',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24205 AND piece.composer_id = 365
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페레타 <Lysistrata>

UPDATE pieces piece
SET piece.title = '오페레타 <Lysistrata>', piece.title_en = 'Lysistrata',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25238 AND piece.composer_id = 365
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '„Glühwürmchen, Glühwürmchen flimm''re”', part.name_en = 'Lysistrata: „Glühwürmchen, Glühwürmchen flimm''re”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25238 AND p.composer_id = 365 AND part.part_key = 'musicbrainz:020a2aa8-5efd-4522-b50c-0b59ed715d17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:020a2aa8-5efd-4522-b50c-0b59ed715d17', 1, NULL, '„Glühwürmchen, Glühwürmchen flimm''re”', 'Lysistrata: „Glühwürmchen, Glühwürmchen flimm''re”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25238 AND p.composer_id = 365
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:020a2aa8-5efd-4522-b50c-0b59ed715d17'
);


-- None 가곡 <Mondwalzer>

UPDATE pieces piece
SET piece.title = '가곡 <Mondwalzer>', piece.title_en = 'Mondwalzer',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25972 AND piece.composer_id = 365
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페레타 <Nakiris Hochzeit>

UPDATE pieces piece
SET piece.title = '오페레타 <Nakiris Hochzeit>', piece.title_en = 'Nakiris Hochzeit',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24797 AND piece.composer_id = 365
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '“Ob du mich liebst, hab'' ich den Wind gefragt”', part.name_en = 'Nakiris Hochzeit: “Ob du mich liebst, hab'' ich den Wind gefragt”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24797 AND p.composer_id = 365 AND part.part_key = 'musicbrainz:696ce3cf-6f78-42b6-8d90-741ae6aa3aaa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:696ce3cf-6f78-42b6-8d90-741ae6aa3aaa', 1, NULL, '“Ob du mich liebst, hab'' ich den Wind gefragt”', 'Nakiris Hochzeit: “Ob du mich liebst, hab'' ich den Wind gefragt”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24797 AND p.composer_id = 365
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:696ce3cf-6f78-42b6-8d90-741ae6aa3aaa'
);


-- None O Frühling, wie bist du schön !

UPDATE pieces piece
SET piece.title = 'O Frühling, wie bist du schön !', piece.title_en = 'O Frühling, wie bist du schön !',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24317 AND piece.composer_id = 365
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Sympathique>

UPDATE pieces piece
SET piece.title = '가곡 <Sympathique>', piece.title_en = 'Sympathique',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23514 AND piece.composer_id = 365
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Wedding Dance

UPDATE pieces piece
SET piece.title = 'Wedding Dance', piece.title_en = 'Wedding Dance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23923 AND piece.composer_id = 365
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페레타 <Berliner Luft>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페레타 <Berliner Luft>', 'Berliner Luft', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 365
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페레타 <Berliner Luft>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61f898c2-710b-4cdc-8e79-aa53142f610c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '61f898c2-710b-4cdc-8e79-aa53142f610c'
FROM pieces p
WHERE p.composer_id = 365 AND p.title = '오페레타 <Berliner Luft>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61f898c2-710b-4cdc-8e79-aa53142f610c'
);

-- 카탈로그에 대응이 없는 seed 작품 2개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 365 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    24362, 24819
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Marco Frisina (composer_id 366) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 20개(묶음 0, 다악장 0, 낱곡 20),
-- 새 작품 2개, part 0개, 그 아래 0개.
-- seed 19개 중 18개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.

-- None Accogli nel tuo grembo

UPDATE pieces piece
SET piece.title = 'Accogli nel tuo grembo', piece.title_en = 'Accogli nel tuo grembo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23114 AND piece.composer_id = 366
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Adoro Te devote

UPDATE pieces piece
SET piece.title = 'Adoro Te devote', piece.title_en = 'Adoro Te devote',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23185 AND piece.composer_id = 366
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Agnus Dei

UPDATE pieces piece
SET piece.title = 'Agnus Dei', piece.title_en = 'Agnus Dei',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23186 AND piece.composer_id = 366
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <Al cospetto del sultano>

UPDATE pieces piece
SET piece.title = '영화음악 <Al cospetto del sultano>', piece.title_en = 'Al cospetto del sultano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23178 AND piece.composer_id = 366
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Alla cena dell'Agnello

UPDATE pieces piece
SET piece.title = 'Alla cena dell''Agnello', piece.title_en = 'Alla cena dell''Agnello',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23116 AND piece.composer_id = 366
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Alleluia, io sono il Buon Pastore

UPDATE pieces piece
SET piece.title = 'Alleluia, io sono il Buon Pastore', piece.title_en = 'Alleluia, io sono il Buon Pastore',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23182 AND piece.composer_id = 366
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Alleluia, le tue parole

UPDATE pieces piece
SET piece.title = 'Alleluia, le tue parole', piece.title_en = 'Alleluia, le tue parole',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23189 AND piece.composer_id = 366
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Alto e glorioso Dio

UPDATE pieces piece
SET piece.title = 'Alto e glorioso Dio', piece.title_en = 'Alto e glorioso Dio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23103 AND piece.composer_id = 366
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Andate in tutto il mondo

UPDATE pieces piece
SET piece.title = 'Andate in tutto il mondo', piece.title_en = 'Andate in tutto il mondo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23117 AND piece.composer_id = 366
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Aprite le porte a Cristo

UPDATE pieces piece
SET piece.title = 'Aprite le porte a Cristo', piece.title_en = 'Aprite le porte a Cristo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23181 AND piece.composer_id = 366
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ascende

UPDATE pieces piece
SET piece.title = 'Ascende', piece.title_en = 'Ascende',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23115 AND piece.composer_id = 366
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ascolta Creatore pietoso

UPDATE pieces piece
SET piece.title = 'Ascolta Creatore pietoso', piece.title_en = 'Ascolta Creatore pietoso',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23180 AND piece.composer_id = 366
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <Assedio>

UPDATE pieces piece
SET piece.title = '영화음악 <Assedio>', piece.title_en = 'Assedio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23179 AND piece.composer_id = 366
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Atto d'amore

UPDATE pieces piece
SET piece.title = 'Atto d''amore', piece.title_en = 'Atto d''amore',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23183 AND piece.composer_id = 366
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ave Madre di Dio

UPDATE pieces piece
SET piece.title = 'Ave Madre di Dio', piece.title_en = 'Ave Madre di Dio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23184 AND piece.composer_id = 366
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ave, o Vergine Sposa

UPDATE pieces piece
SET piece.title = 'Ave, o Vergine Sposa', piece.title_en = 'Ave, o Vergine Sposa',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23112 AND piece.composer_id = 366
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Creo en ti, Señor>

UPDATE pieces piece
SET piece.title = '가곡 <Creo en ti, Señor>', piece.title_en = 'Creo en ti, Señor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24352 AND piece.composer_id = 366
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dove la carità è vera

UPDATE pieces piece
SET piece.title = 'Dove la carità è vera', piece.title_en = 'Dove la carità è vera',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23113 AND piece.composer_id = 366
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A solis ortus cardine

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'A solis ortus cardine', 'A solis ortus cardine', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 366
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'A solis ortus cardine'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ffb61968-65fc-4d24-b0d3-57f71aab0325'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ffb61968-65fc-4d24-b0d3-57f71aab0325'
FROM pieces p
WHERE p.composer_id = 366 AND p.title = 'A solis ortus cardine' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ffb61968-65fc-4d24-b0d3-57f71aab0325'
);


-- None 스타바트 마테르

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스타바트 마테르', 'Stabat Mater', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 366
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스타바트 마테르'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d48b783-0691-457b-8ab6-423cfe01bd04'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5d48b783-0691-457b-8ab6-423cfe01bd04'
FROM pieces p
WHERE p.composer_id = 366 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d48b783-0691-457b-8ab6-423cfe01bd04'
);

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 366 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    24053
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Emil Sjögren (composer_id 367) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 14개(묶음 4, 다악장 0, 낱곡 10),
-- 새 작품 2개, part 10개, 그 아래 0개.
-- seed 14개 중 12개를 작품·part 에 잇고, 2개를 숨기고, 0개는 그대로 둔다.

-- Op. 1 4 Poems of Ibsen and Björnson

UPDATE pieces piece
SET piece.title = '4 Poems of Ibsen and Björnson', piece.title_en = '4 Poems of Ibsen and Björnson, op. 1',
    piece.type = 'song', piece.opus_number = 'Op. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24924 AND piece.composer_id = 367
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 3 7 Sånger ur Tannhäuser

UPDATE pieces piece
SET piece.title = '7 Sånger ur Tannhäuser', piece.title_en = '7 Sånger ur Tannhäuser, op. 3',
    piece.type = 'song', piece.opus_number = 'Op. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25389 AND piece.composer_id = 367
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 6 7 spanische Lieder Op. 6

UPDATE pieces piece
SET piece.title = '7 spanische Lieder Op. 6', piece.title_en = '7 spanische Lieder, op. 6',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '6',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25305 AND piece.composer_id = 367
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'In dem Schatten meiner Locken, op. 6 no. 3', part.name_en = 'In dem Schatten meiner Locken, op. 6 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25305 AND p.composer_id = 367 AND part.part_key = 'musicbrainz:0ef6a2c8-8e15-4238-a467-a2fe2ee548ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ef6a2c8-8e15-4238-a467-a2fe2ee548ec', 1, NULL, 'In dem Schatten meiner Locken, op. 6 no. 3', 'In dem Schatten meiner Locken, op. 6 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25305 AND p.composer_id = 367
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ef6a2c8-8e15-4238-a467-a2fe2ee548ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Klinge, klinge, mein Pandero, op. 6 no. 1', part.name_en = 'Klinge, klinge, mein Pandero, op. 6 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25305 AND p.composer_id = 367 AND part.part_key = 'musicbrainz:eeea0a2e-7d5c-483f-9155-447b5f52b870' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eeea0a2e-7d5c-483f-9155-447b5f52b870', 2, NULL, 'Klinge, klinge, mein Pandero, op. 6 no. 1', 'Klinge, klinge, mein Pandero, op. 6 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25305 AND p.composer_id = 367
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eeea0a2e-7d5c-483f-9155-447b5f52b870'
);


-- Op. 22 No. 1 가곡 <I Seraljens lustgård>

UPDATE pieces piece
SET piece.title = '가곡 <I Seraljens lustgård>', piece.title_en = 'I Seraljens lustgård, op. 22 no. 1',
    piece.type = 'song', piece.opus_number = 'Op. 22 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25833 AND piece.composer_id = 367
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <I drömmen du är mig nära>

UPDATE pieces piece
SET piece.title = '가곡 <I drömmen du är mig nära>', piece.title_en = 'I drömmen du är mig nära',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23987 AND piece.composer_id = 367
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 9 가곡 <Kontrabandieren>

UPDATE pieces piece
SET piece.title = '가곡 <Kontrabandieren>', piece.title_en = 'Kontrabandieren, op. 9',
    piece.type = 'song', piece.opus_number = 'Op. 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24966 AND piece.composer_id = 367
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 46 Legends for Organ Op. 46

UPDATE pieces piece
SET piece.title = 'Legends for Organ Op. 46', piece.title_en = 'Legends for Organ, op. 46',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '46',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25555 AND piece.composer_id = 367
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Legend in D major, op. 46 no. 5', part.name_en = 'Legend in D major, op. 46 no. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25555 AND p.composer_id = 367 AND part.part_key = 'musicbrainz:2ecef43f-4761-451c-ae2d-1e46bb0cd9f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ecef43f-4761-451c-ae2d-1e46bb0cd9f4', 1, NULL, 'Legend in D major, op. 46 no. 5', 'Legend in D major, op. 46 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25555 AND p.composer_id = 367
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ecef43f-4761-451c-ae2d-1e46bb0cd9f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Legend no. 19 in A-flat major, Andante pastorale', part.name_en = 'Legend no. 19 in A-flat major, Andante pastorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25555 AND p.composer_id = 367 AND part.part_key = 'musicbrainz:6fc55795-d41b-4ac4-9d96-28e4cda510d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fc55795-d41b-4ac4-9d96-28e4cda510d4', 2, NULL, 'Legend no. 19 in A-flat major, Andante pastorale', 'Legend no. 19 in A-flat major, Andante pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25555 AND p.composer_id = 367
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fc55795-d41b-4ac4-9d96-28e4cda510d4'
);


-- None 전주곡과 푸가 C장조

UPDATE pieces piece
SET piece.title = '전주곡과 푸가 C장조', piece.title_en = 'Prelude and fugue in C major, op. posth.',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23427 AND piece.composer_id = 367
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 12 Sechs Lieder aus Julius Wolff’s Tannhäuser Op. 12

UPDATE pieces piece
SET piece.title = 'Sechs Lieder aus Julius Wolff’s Tannhäuser Op. 12', piece.title_en = 'Sechs Lieder aus Julius Wolff’s Tannhäuser, op. 12',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '12',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24593 AND piece.composer_id = 367
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Hab’ ein Röslein dir gebrochen, op. 12 no. 4', part.name_en = 'Hab’ ein Röslein dir gebrochen, op. 12 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24593 AND p.composer_id = 367 AND part.part_key = 'musicbrainz:e90ab8ea-c1f1-3be1-a96e-c3626efdae4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e90ab8ea-c1f1-3be1-a96e-c3626efdae4d', 1, NULL, 'Hab’ ein Röslein dir gebrochen, op. 12 no. 4', 'Hab’ ein Röslein dir gebrochen, op. 12 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24593 AND p.composer_id = 367
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e90ab8ea-c1f1-3be1-a96e-c3626efdae4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Du schaust mich an mit stummen Fragen, op. 12 no. 1', part.name_en = 'Du schaust mich an mit stummen Fragen, op. 12 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24593 AND p.composer_id = 367 AND part.part_key = 'musicbrainz:07d7f66d-b337-38cd-b4ba-7c94e226db4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07d7f66d-b337-38cd-b4ba-7c94e226db4a', 2, NULL, 'Du schaust mich an mit stummen Fragen, op. 12 no. 1', 'Du schaust mich an mit stummen Fragen, op. 12 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24593 AND p.composer_id = 367
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07d7f66d-b337-38cd-b4ba-7c94e226db4a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ich möchte schweben über Tal und Hügel, op. 12 no. 6', part.name_en = 'Ich möchte schweben über Tal und Hügel, op. 12 no. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24593 AND p.composer_id = 367 AND part.part_key = 'musicbrainz:609045ae-1579-3c2e-8b26-cac91725e187' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:609045ae-1579-3c2e-8b26-cac91725e187', 3, NULL, 'Ich möchte schweben über Tal und Hügel, op. 12 no. 6', 'Ich möchte schweben über Tal und Hügel, op. 12 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24593 AND p.composer_id = 367
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:609045ae-1579-3c2e-8b26-cac91725e187'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Jahrlang möcht’ ich so Dich halten, op. 12 no. 2', part.name_en = 'Jahrlang möcht’ ich so Dich halten, op. 12 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24593 AND p.composer_id = 367 AND part.part_key = 'musicbrainz:e215a5d5-9c67-430c-9cf4-4265334b4d2b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e215a5d5-9c67-430c-9cf4-4265334b4d2b', 4, NULL, 'Jahrlang möcht’ ich so Dich halten, op. 12 no. 2', 'Jahrlang möcht’ ich so Dich halten, op. 12 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24593 AND p.composer_id = 367
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e215a5d5-9c67-430c-9cf4-4265334b4d2b'
);


-- None Tag emot Kranser

UPDATE pieces piece
SET piece.title = 'Tag emot Kranser', piece.title_en = 'Tag emot Kranser',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24994 AND piece.composer_id = 367
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Vårluft>

UPDATE pieces piece
SET piece.title = '가곡 <Vårluft>', piece.title_en = 'Vårluft',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23966 AND piece.composer_id = 367
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 29 Zwei lyrische Stücke für Violine und Pianoforte Op. 29

UPDATE pieces piece
SET piece.title = 'Zwei lyrische Stücke für Violine und Pianoforte Op. 29', piece.title_en = 'Zwei lyrische Stücke für Violine und Pianoforte, op. 29',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '29',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24868 AND piece.composer_id = 367
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andantino quasi Allegretto', part.name_en = 'Zwei lyrische Stücke für Violine und Pianoforte: No. 1. Andantino quasi Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24868 AND p.composer_id = 367 AND part.part_key = 'musicbrainz:7df9c437-ce67-4726-b74d-f44ee29b1069' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7df9c437-ce67-4726-b74d-f44ee29b1069', 1, NULL, 'Andantino quasi Allegretto', 'Zwei lyrische Stücke für Violine und Pianoforte: No. 1. Andantino quasi Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24868 AND p.composer_id = 367
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7df9c437-ce67-4726-b74d-f44ee29b1069'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Andante sostenuto', part.name_en = 'Zwei lyrische Stücke für Violine und Pianoforte: No. 2. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24868 AND p.composer_id = 367 AND part.part_key = 'musicbrainz:adc4f11c-de97-4819-b996-9524d58c77f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:adc4f11c-de97-4819-b996-9524d58c77f9', 2, NULL, 'Andante sostenuto', 'Zwei lyrische Stücke für Violine und Pianoforte: No. 2. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24868 AND p.composer_id = 367
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adc4f11c-de97-4819-b996-9524d58c77f9'
);


-- None 가곡 <Det komma skall en sorgestund>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Det komma skall en sorgestund>', 'Det komma skall en sorgestund', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 367
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Det komma skall en sorgestund>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ac340f6-6843-4814-89b6-785ea87cf149'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4ac340f6-6843-4814-89b6-785ea87cf149'
FROM pieces p
WHERE p.composer_id = 367 AND p.title = '가곡 <Det komma skall en sorgestund>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ac340f6-6843-4814-89b6-785ea87cf149'
);


-- None 가곡 <O säg, du enda kära>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <O säg, du enda kära>', 'O säg, du enda kära', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 367
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <O säg, du enda kära>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8ca8d5b7-e7dc-477b-9c61-c4ab276fdc3c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8ca8d5b7-e7dc-477b-9c61-c4ab276fdc3c'
FROM pieces p
WHERE p.composer_id = 367 AND p.title = '가곡 <O säg, du enda kära>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8ca8d5b7-e7dc-477b-9c61-c4ab276fdc3c'
);

-- 카탈로그에 대응이 없는 seed 작품 2개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 367 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    23657, 25853
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== 얼 와일드 (composer_id 368) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 0, 다악장 2, 낱곡 0),
-- 새 작품 0개, part 7개, 그 아래 0개.
-- seed 5개 중 2개를 작품·part 에 잇고, 3개를 숨기고, 0개는 그대로 둔다.

-- None Improvisation in the Form of a Theme and Three Variations on "Someone to watch over me"

UPDATE pieces piece
SET piece.title = 'Improvisation in the Form of a Theme and Three Variations on "Someone to watch over me"', piece.title_en = 'Improvisation in the Form of a Theme and Three Variations on "Someone to watch over me"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25467 AND piece.composer_id = 368
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Theme', part.name_en = 'Improvisation in the Form of a Theme and Three Variations on "Someone to watch over me": I. Theme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25467 AND p.composer_id = 368 AND part.part_key = 'musicbrainz:a0b15a2e-f23b-4f28-9fee-e2d66bdf3928' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0b15a2e-f23b-4f28-9fee-e2d66bdf3928', 1, 'I', 'Theme', 'Improvisation in the Form of a Theme and Three Variations on "Someone to watch over me": I. Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25467 AND p.composer_id = 368
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0b15a2e-f23b-4f28-9fee-e2d66bdf3928'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Barcarolle', part.name_en = 'Improvisation in the Form of a Theme and Three Variations on "Someone to watch over me": II. Barcarolle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25467 AND p.composer_id = 368 AND part.part_key = 'musicbrainz:b3a0d65b-70d6-40ce-967c-51090627f950' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3a0d65b-70d6-40ce-967c-51090627f950', 2, 'II', 'Barcarolle', 'Improvisation in the Form of a Theme and Three Variations on "Someone to watch over me": II. Barcarolle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25467 AND p.composer_id = 368
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3a0d65b-70d6-40ce-967c-51090627f950'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Brazilian Dance', part.name_en = 'Improvisation in the Form of a Theme and Three Variations on "Someone to watch over me": III. Brazilian Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25467 AND p.composer_id = 368 AND part.part_key = 'musicbrainz:9fdf9118-5991-4d0c-8d2c-57dbbb016448' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fdf9118-5991-4d0c-8d2c-57dbbb016448', 3, 'III', 'Brazilian Dance', 'Improvisation in the Form of a Theme and Three Variations on "Someone to watch over me": III. Brazilian Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25467 AND p.composer_id = 368
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fdf9118-5991-4d0c-8d2c-57dbbb016448'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Tango', part.name_en = 'Improvisation in the Form of a Theme and Three Variations on "Someone to watch over me": IV. Tango',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25467 AND p.composer_id = 368 AND part.part_key = 'musicbrainz:e383986f-ecea-4df9-8be4-852e3a1d5fe4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e383986f-ecea-4df9-8be4-852e3a1d5fe4', 4, 'IV', 'Tango', 'Improvisation in the Form of a Theme and Three Variations on "Someone to watch over me": IV. Tango', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25467 AND p.composer_id = 368
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e383986f-ecea-4df9-8be4-852e3a1d5fe4'
);


-- None 피아노 소나타

UPDATE pieces piece
SET piece.title = '피아노 소나타', piece.title_en = 'Piano Sonata',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 26014 AND piece.composer_id = 368
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro (March)', part.name_en = 'Piano Sonata: I. Allegro (March)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26014 AND p.composer_id = 368 AND part.part_key = 'musicbrainz:9892a288-8b4a-4c93-9fbc-d2676b425aa1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9892a288-8b4a-4c93-9fbc-d2676b425aa1', 1, 'I', 'Allegro (March)', 'Piano Sonata: I. Allegro (March)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26014 AND p.composer_id = 368
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9892a288-8b4a-4c93-9fbc-d2676b425aa1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Piano Sonata: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26014 AND p.composer_id = 368 AND part.part_key = 'musicbrainz:879e6f1a-e68a-4a5e-84af-9ff37a4c950d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:879e6f1a-e68a-4a5e-84af-9ff37a4c950d', 2, 'II', 'Adagio', 'Piano Sonata: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26014 AND p.composer_id = 368
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:879e6f1a-e68a-4a5e-84af-9ff37a4c950d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Toccata (a la Ricky Martin)', part.name_en = 'Piano Sonata: III. Toccata (a la Ricky Martin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26014 AND p.composer_id = 368 AND part.part_key = 'musicbrainz:11ac5894-93f6-4767-ac86-d0759cddbbff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11ac5894-93f6-4767-ac86-d0759cddbbff', 3, 'III', 'Toccata (a la Ricky Martin)', 'Piano Sonata: III. Toccata (a la Ricky Martin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26014 AND p.composer_id = 368
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11ac5894-93f6-4767-ac86-d0759cddbbff'
);

-- 카탈로그에 대응이 없는 seed 작품 3개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 368 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    23066, 23576, 23930
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Hans Georg Nägeli (composer_id 371) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 0, 다악장 0, 낱곡 2),
-- 새 작품 1개, part 0개, 그 아래 0개.
-- seed 2개 중 1개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.

-- None Tipaatsungaalerit

UPDATE pieces piece
SET piece.title = 'Tipaatsungaalerit', piece.title_en = 'Tipaatsungaalerit',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25104 AND piece.composer_id = 371
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Freut euch des Lebens>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Freut euch des Lebens>', 'Freut euch des Lebens', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 371
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Freut euch des Lebens>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '763737b9-447e-4af3-a7f7-f26c3f3c2855'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '763737b9-447e-4af3-a7f7-f26c3f3c2855'
FROM pieces p
WHERE p.composer_id = 371 AND p.title = '가곡 <Freut euch des Lebens>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '763737b9-447e-4af3-a7f7-f26c3f3c2855'
);

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 371 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    23124
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== 한스 첸더 (composer_id 375) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 9개(묶음 0, 다악장 0, 낱곡 9),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 10개 중 9개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.

-- None Canto II

UPDATE pieces piece
SET piece.title = 'Canto II', piece.title_en = 'Canto II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25180 AND piece.composer_id = 375
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canto VI

UPDATE pieces piece
SET piece.title = 'Canto VI', piece.title_en = 'Canto VI',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25116 AND piece.composer_id = 375
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fragmente (Canto V)

UPDATE pieces piece
SET piece.title = 'Fragmente (Canto V)', piece.title_en = 'Fragmente (Canto V)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23490 AND piece.composer_id = 375
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fūrin no kyō

UPDATE pieces piece
SET piece.title = 'Fūrin no kyō', piece.title_en = 'Fūrin no kyō',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25282 AND piece.composer_id = 375
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Introitus mit Fanfaren

UPDATE pieces piece
SET piece.title = 'Introitus mit Fanfaren', piece.title_en = 'Introitus mit Fanfaren',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24074 AND piece.composer_id = 375
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Kalligraphie I

UPDATE pieces piece
SET piece.title = 'Kalligraphie I', piece.title_en = 'Kalligraphie I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23728 AND piece.composer_id = 375
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Litanei

UPDATE pieces piece
SET piece.title = 'Litanei', piece.title_en = 'Litanei',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24024 AND piece.composer_id = 375
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Muji no kyō

UPDATE pieces piece
SET piece.title = 'Muji no kyō', piece.title_en = 'Muji no kyō',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24445 AND piece.composer_id = 375
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music to Hear

UPDATE pieces piece
SET piece.title = 'Music to Hear', piece.title_en = 'Music to Hear',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24644 AND piece.composer_id = 375
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 375 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    24905
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Julius Eichberg (composer_id 381) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 1, 다악장 0, 낱곡 0),
-- 새 작품 0개, part 1개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 오페라 <The Doctor of Alcantara>

UPDATE pieces piece
SET piece.title = '오페라 <The Doctor of Alcantara>', piece.title_en = 'The Doctor of Alcantara',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25775 AND piece.composer_id = 381
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'The Doctor of Alcantara: Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25775 AND p.composer_id = 381 AND part.part_key = 'musicbrainz:2b24ec5e-fba1-4edc-8053-5742c099f597' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b24ec5e-fba1-4edc-8053-5742c099f597', 1, NULL, 'Overture', 'The Doctor of Alcantara: Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25775 AND p.composer_id = 381
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b24ec5e-fba1-4edc-8053-5742c099f597'
);

-- 숨길 seed 작품 없음

-- ===== 허레이쇼 파커 (composer_id 383) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 11개(묶음 3, 다악장 2, 낱곡 6),
-- 새 작품 0개, part 19개, 그 아래 0개.
-- seed 11개 중 11개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- Op. 49 3 Characteristic Pieces Op. 49

UPDATE pieces piece
SET piece.title = '3 Characteristic Pieces Op. 49', piece.title_en = '3 Characteristic Pieces, op. 49',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '49',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25762 AND piece.composer_id = 383
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Conte sérieux, op. 49 no. 1', part.name_en = 'Conte sérieux, op. 49 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25762 AND p.composer_id = 383 AND part.part_key = 'musicbrainz:3e7638af-100b-46ca-8049-5b881e71f811' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e7638af-100b-46ca-8049-5b881e71f811', 1, NULL, 'Conte sérieux, op. 49 no. 1', 'Conte sérieux, op. 49 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25762 AND p.composer_id = 383
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e7638af-100b-46ca-8049-5b881e71f811'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'La sauterelle, op. 49 no. 2', part.name_en = 'La sauterelle, op. 49 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25762 AND p.composer_id = 383 AND part.part_key = 'musicbrainz:d7ed6d0e-be63-492a-a685-eda9e6702a92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7ed6d0e-be63-492a-a685-eda9e6702a92', 2, NULL, 'La sauterelle, op. 49 no. 2', 'La sauterelle, op. 49 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25762 AND p.composer_id = 383
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7ed6d0e-be63-492a-a685-eda9e6702a92'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Valse gracile, op. 49 no. 3', part.name_en = 'Valse gracile, op. 49 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25762 AND p.composer_id = 383 AND part.part_key = 'musicbrainz:910b07d8-cae3-497e-9498-25372626940d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:910b07d8-cae3-497e-9498-25372626940d', 3, NULL, 'Valse gracile, op. 49 no. 3', 'Valse gracile, op. 49 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25762 AND p.composer_id = 383
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:910b07d8-cae3-497e-9498-25372626940d'
);


-- Op. 50 칸타타 <A Wanderer’s Psalm>

UPDATE pieces piece
SET piece.title = '칸타타 <A Wanderer’s Psalm>', piece.title_en = 'A Wanderer’s Psalm, op. 50',
    piece.type = 'song', piece.opus_number = 'Op. 50',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23750 AND piece.composer_id = 383
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 55 협주곡 E♭단조

UPDATE pieces piece
SET piece.title = '협주곡 E♭단조', piece.title_en = 'Concerto in E-flat minor for Organ and Orchestra, op. 55',
    piece.type = 'album', piece.opus_number = 'Op. 55',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25771 AND piece.composer_id = 383
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Concerto in E-flat minor for Organ and Orchestra, op. 55: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25771 AND p.composer_id = 383 AND part.part_key = 'musicbrainz:c76720e2-6836-4200-bf6b-a8e56a56582b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c76720e2-6836-4200-bf6b-a8e56a56582b', 1, 'I', 'Allegro moderato', 'Concerto in E-flat minor for Organ and Orchestra, op. 55: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25771 AND p.composer_id = 383
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c76720e2-6836-4200-bf6b-a8e56a56582b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Concerto in E-flat minor for Organ and Orchestra, op. 55: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25771 AND p.composer_id = 383 AND part.part_key = 'musicbrainz:cbde54ac-e859-4af9-ad73-15ec52e725eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbde54ac-e859-4af9-ad73-15ec52e725eb', 2, 'II', 'Andante', 'Concerto in E-flat minor for Organ and Orchestra, op. 55: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25771 AND p.composer_id = 383
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbde54ac-e859-4af9-ad73-15ec52e725eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto, ma ben marcato', part.name_en = 'Concerto in E-flat minor for Organ and Orchestra, op. 55: III. Allegretto, ma ben marcato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25771 AND p.composer_id = 383 AND part.part_key = 'musicbrainz:1e956c88-7d04-41ba-99b6-cf404da41069' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e956c88-7d04-41ba-99b6-cf404da41069', 3, 'III', 'Allegretto, ma ben marcato', 'Concerto in E-flat minor for Organ and Orchestra, op. 55: III. Allegretto, ma ben marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25771 AND p.composer_id = 383
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e956c88-7d04-41ba-99b6-cf404da41069'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro moderato, molto risoluto', part.name_en = 'Concerto in E-flat minor for Organ and Orchestra, op. 55: IV. Allegro moderato, molto risoluto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25771 AND p.composer_id = 383 AND part.part_key = 'musicbrainz:1e1710d9-b3f7-4c15-b9b5-0b00f2219482' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e1710d9-b3f7-4c15-b9b5-0b00f2219482', 4, 'IV', 'Allegro moderato, molto risoluto', 'Concerto in E-flat minor for Organ and Orchestra, op. 55: IV. Allegro moderato, molto risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25771 AND p.composer_id = 383
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e1710d9-b3f7-4c15-b9b5-0b00f2219482'
);


-- Op. 28 Four Compositions for Organ Op. 28

UPDATE pieces piece
SET piece.title = 'Four Compositions for Organ Op. 28', piece.title_en = 'Four Compositions for Organ, op. 28',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '28',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23312 AND piece.composer_id = 383
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Triumphal March, op. 28 no. 1', part.name_en = 'Triumphal March, op. 28 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23312 AND p.composer_id = 383 AND part.part_key = 'musicbrainz:9f6f1408-c83e-4113-8495-2f864737608b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f6f1408-c83e-4113-8495-2f864737608b', 1, NULL, 'Triumphal March, op. 28 no. 1', 'Triumphal March, op. 28 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23312 AND p.composer_id = 383
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f6f1408-c83e-4113-8495-2f864737608b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Larghetto, op. 28 no. 2', part.name_en = 'Larghetto, op. 28 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23312 AND p.composer_id = 383 AND part.part_key = 'musicbrainz:746c6934-567b-4a75-b782-6aa0ed2795b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:746c6934-567b-4a75-b782-6aa0ed2795b6', 2, NULL, 'Larghetto, op. 28 no. 2', 'Larghetto, op. 28 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23312 AND p.composer_id = 383
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:746c6934-567b-4a75-b782-6aa0ed2795b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Pastorale, op. 28 no. 3', part.name_en = 'Pastorale, op. 28 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23312 AND p.composer_id = 383 AND part.part_key = 'musicbrainz:03db9bc6-9364-4550-bc45-3aefba229abe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03db9bc6-9364-4550-bc45-3aefba229abe', 3, NULL, 'Pastorale, op. 28 no. 3', 'Pastorale, op. 28 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23312 AND p.composer_id = 383
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03db9bc6-9364-4550-bc45-3aefba229abe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Concert Piece no. 2, op. 28 no. 4', part.name_en = 'Concert Piece no. 2, op. 28 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23312 AND p.composer_id = 383 AND part.part_key = 'musicbrainz:571d07a6-b1a6-461b-9dd8-fd2a7871471b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:571d07a6-b1a6-461b-9dd8-fd2a7871471b', 4, NULL, 'Concert Piece no. 2, op. 28 no. 4', 'Concert Piece no. 2, op. 28 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23312 AND p.composer_id = 383
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:571d07a6-b1a6-461b-9dd8-fd2a7871471b'
);


-- Op. 20 Four Compositions for the Organ Op. 20

UPDATE pieces piece
SET piece.title = 'Four Compositions for the Organ Op. 20', piece.title_en = 'Four Compositions for the Organ, op. 20',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '20',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23975 AND piece.composer_id = 383
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Wedding Song, op. 20 no. 1', part.name_en = 'Wedding Song, op. 20 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23975 AND p.composer_id = 383 AND part.part_key = 'musicbrainz:8071a98a-884d-4043-9daf-6acd71e51bfb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8071a98a-884d-4043-9daf-6acd71e51bfb', 1, NULL, 'Wedding Song, op. 20 no. 1', 'Wedding Song, op. 20 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23975 AND p.composer_id = 383
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8071a98a-884d-4043-9daf-6acd71e51bfb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fughetta, op. 20 no. 2', part.name_en = 'Fughetta, op. 20 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23975 AND p.composer_id = 383 AND part.part_key = 'musicbrainz:79c4be0c-0902-488e-95f4-054a0c7d3f26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79c4be0c-0902-488e-95f4-054a0c7d3f26', 2, NULL, 'Fughetta, op. 20 no. 2', 'Fughetta, op. 20 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23975 AND p.composer_id = 383
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79c4be0c-0902-488e-95f4-054a0c7d3f26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Melody and Intermezzo, op. 20 no. 3', part.name_en = 'Melody and Intermezzo, op. 20 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23975 AND p.composer_id = 383 AND part.part_key = 'musicbrainz:72b8689c-7dbb-4419-87c9-e8bf6872bc85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72b8689c-7dbb-4419-87c9-e8bf6872bc85', 3, NULL, 'Melody and Intermezzo, op. 20 no. 3', 'Melody and Intermezzo, op. 20 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23975 AND p.composer_id = 383
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72b8689c-7dbb-4419-87c9-e8bf6872bc85'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Fantasie, op. 20 no. 4', part.name_en = 'Fantasie, op. 20 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23975 AND p.composer_id = 383 AND part.part_key = 'musicbrainz:3e02ce32-0071-4b8b-ba3a-5a73795cc6d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e02ce32-0071-4b8b-ba3a-5a73795cc6d0', 4, NULL, 'Fantasie, op. 20 no. 4', 'Fantasie, op. 20 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23975 AND p.composer_id = 383
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e02ce32-0071-4b8b-ba3a-5a73795cc6d0'
);


-- None 가곡 <Jam sol recedit>

UPDATE pieces piece
SET piece.title = '가곡 <Jam sol recedit>', piece.title_en = 'Jam sol recedit',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23061 AND piece.composer_id = 383
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 51 No. 2 가곡 <June Night>

UPDATE pieces piece
SET piece.title = '가곡 <June Night>', piece.title_en = 'June Night, op. 51 no. 2',
    piece.type = 'song', piece.opus_number = 'Op. 51 No. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24232 AND piece.composer_id = 383
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Light's Glittering Morn

UPDATE pieces piece
SET piece.title = 'Light''s Glittering Morn', piece.title_en = 'Light''s Glittering Morn',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23320 AND piece.composer_id = 383
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 65 오르간 소나타 E♭단조

UPDATE pieces piece
SET piece.title = '오르간 소나타 E♭단조', piece.title_en = 'Organ Sonata in E-flat minor, op. 65',
    piece.type = 'album', piece.opus_number = 'Op. 65',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25608 AND piece.composer_id = 383
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Organ Sonata in E-flat minor, op. 65: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25608 AND p.composer_id = 383 AND part.part_key = 'musicbrainz:d80babc3-512f-4a77-84d2-dd19415180e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d80babc3-512f-4a77-84d2-dd19415180e5', 1, 'I', 'Allegro moderato', 'Organ Sonata in E-flat minor, op. 65: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25608 AND p.composer_id = 383
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d80babc3-512f-4a77-84d2-dd19415180e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Organ Sonata in E-flat minor, op. 65: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25608 AND p.composer_id = 383 AND part.part_key = 'musicbrainz:31104341-95e2-4b0c-91df-9f1f6e7cb48c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31104341-95e2-4b0c-91df-9f1f6e7cb48c', 2, 'II', 'Andante', 'Organ Sonata in E-flat minor, op. 65: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25608 AND p.composer_id = 383
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31104341-95e2-4b0c-91df-9f1f6e7cb48c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto', part.name_en = 'Organ Sonata in E-flat minor, op. 65: III. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25608 AND p.composer_id = 383 AND part.part_key = 'musicbrainz:577b773e-0604-48f7-9627-61f33896aaed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:577b773e-0604-48f7-9627-61f33896aaed', 3, 'III', 'Allegretto', 'Organ Sonata in E-flat minor, op. 65: III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25608 AND p.composer_id = 383
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:577b773e-0604-48f7-9627-61f33896aaed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Fugue', part.name_en = 'Organ Sonata in E-flat minor, op. 65: IV. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25608 AND p.composer_id = 383 AND part.part_key = 'musicbrainz:2ba29c0c-2ad6-4d3a-bfb2-72c9c9304700' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ba29c0c-2ad6-4d3a-bfb2-72c9c9304700', 4, 'IV', 'Fugue', 'Organ Sonata in E-flat minor, op. 65: IV. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25608 AND p.composer_id = 383
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ba29c0c-2ad6-4d3a-bfb2-72c9c9304700'
);


-- None Rejoice, the Lord Is King!

UPDATE pieces piece
SET piece.title = 'Rejoice, the Lord Is King!', piece.title_en = 'Rejoice, the Lord Is King!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24817 AND piece.composer_id = 383
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 47 No. 6 가곡 <The Lark Now Leaves His Wat'ry Nest>

UPDATE pieces piece
SET piece.title = '가곡 <The Lark Now Leaves His Wat''ry Nest>', piece.title_en = 'The Lark Now Leaves His Wat''ry Nest, op. 47 no. 6',
    piece.type = 'song', piece.opus_number = 'Op. 47 No. 6',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23252 AND piece.composer_id = 383
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음
