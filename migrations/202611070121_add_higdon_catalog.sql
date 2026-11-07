-- Jennifer Higdon 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 37개(묶음 4, 다악장 13, 낱곡 20),
-- 새 작품 8개, part 61개, 그 아래 0개.
-- seed 29개 중 29개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.
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

-- None All Things Majestic

UPDATE pieces piece
SET piece.title = 'All Things Majestic', piece.title_en = 'All Things Majestic',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18829 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Teton Range', part.name_en = 'All Things Majestic: I. Teton Range',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18829 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:cbf5dfcf-efa0-44cd-8a11-270cf8e845b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbf5dfcf-efa0-44cd-8a11-270cf8e845b6', 1, 'I', 'Teton Range', 'All Things Majestic: I. Teton Range', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18829 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbf5dfcf-efa0-44cd-8a11-270cf8e845b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'String Lake', part.name_en = 'All Things Majestic: II. String Lake',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18829 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:6c1edaee-fc43-4ade-a61a-aa25c4d625a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c1edaee-fc43-4ade-a61a-aa25c4d625a9', 2, 'II', 'String Lake', 'All Things Majestic: II. String Lake', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18829 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c1edaee-fc43-4ade-a61a-aa25c4d625a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Snake River', part.name_en = 'All Things Majestic: III. Snake River',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18829 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:4227422a-d492-43dc-a315-b7474a8a4dc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4227422a-d492-43dc-a315-b7474a8a4dc9', 3, 'III', 'Snake River', 'All Things Majestic: III. Snake River', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18829 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4227422a-d492-43dc-a315-b7474a8a4dc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Cathedrals', part.name_en = 'All Things Majestic: IV. Cathedrals',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18829 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:954f936b-4d3f-4769-ad59-c45a5401f712' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:954f936b-4d3f-4769-ad59-c45a5401f712', 4, 'IV', 'Cathedrals', 'All Things Majestic: IV. Cathedrals', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18829 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:954f936b-4d3f-4769-ad59-c45a5401f712'
);


-- None Amazing Grace

UPDATE pieces piece
SET piece.title = 'Amazing Grace', piece.title_en = 'Amazing Grace',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19517 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None City Scape

UPDATE pieces piece
SET piece.title = 'City Scape', piece.title_en = 'City Scape',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16129 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'SkyLine', part.name_en = 'City Scape: I. SkyLine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16129 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:46ac7754-318c-4ead-a25d-8db006885eb1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46ac7754-318c-4ead-a25d-8db006885eb1', 1, 'I', 'SkyLine', 'City Scape: I. SkyLine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16129 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46ac7754-318c-4ead-a25d-8db006885eb1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'river sings a song to trees', part.name_en = 'City Scape: II. river sings a song to trees',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16129 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:3a15d42d-1d08-4a92-acf8-3d313c6030ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a15d42d-1d08-4a92-acf8-3d313c6030ec', 2, 'II', 'river sings a song to trees', 'City Scape: II. river sings a song to trees', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16129 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a15d42d-1d08-4a92-acf8-3d313c6030ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Peachtree Street', part.name_en = 'City Scape: III. Peachtree Street',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16129 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:f7bcb0d4-6fef-47f5-b79c-e947e6640333' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7bcb0d4-6fef-47f5-b79c-e947e6640333', 3, 'III', 'Peachtree Street', 'City Scape: III. Peachtree Street', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16129 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7bcb0d4-6fef-47f5-b79c-e947e6640333'
);


-- None 오페라 <Cold Mountain>

UPDATE pieces piece
SET piece.title = '오페라 <Cold Mountain>', piece.title_en = 'Cold Mountain',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18154 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Cold Mountain: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18154 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:fe563d0a-4239-46d3-9ef9-9a99229bcc30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe563d0a-4239-46d3-9ef9-9a99229bcc30', 1, NULL, 'Act I', 'Cold Mountain: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18154 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe563d0a-4239-46d3-9ef9-9a99229bcc30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Cold Mountain: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18154 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:354f41ee-0235-42c5-9a53-b2c8bfd5e51a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:354f41ee-0235-42c5-9a53-b2c8bfd5e51a', 2, NULL, 'Act II', 'Cold Mountain: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18154 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:354f41ee-0235-42c5-9a53-b2c8bfd5e51a'
);


-- None Concerto 4-3

UPDATE pieces piece
SET piece.title = 'Concerto 4-3', piece.title_en = 'Concerto 4-3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16092 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The Shallows', part.name_en = 'Concerto 4-3: I. The Shallows',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16092 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:51bf6301-fb72-48fb-9112-8ee66e78f3d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51bf6301-fb72-48fb-9112-8ee66e78f3d8', 1, 'I', 'The Shallows', 'Concerto 4-3: I. The Shallows', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16092 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51bf6301-fb72-48fb-9112-8ee66e78f3d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Little River', part.name_en = 'Concerto 4-3: II. Little River',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16092 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:6b5f909a-0e2a-4e2c-95eb-a4407b8fa609' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b5f909a-0e2a-4e2c-95eb-a4407b8fa609', 2, 'II', 'Little River', 'Concerto 4-3: II. Little River', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16092 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b5f909a-0e2a-4e2c-95eb-a4407b8fa609'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Roaring Smokies', part.name_en = 'Concerto 4-3: III. Roaring Smokies',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16092 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:ba3c2194-48f4-499c-abb6-a0e75f07dac9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba3c2194-48f4-499c-abb6-a0e75f07dac9', 3, 'III', 'Roaring Smokies', 'Concerto 4-3: III. Roaring Smokies', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16092 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba3c2194-48f4-499c-abb6-a0e75f07dac9'
);


-- None Dance Card

UPDATE pieces piece
SET piece.title = 'Dance Card', piece.title_en = 'Dance Card',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18916 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Raucous Rumpus', part.name_en = 'Dance Card: No. 1. Raucous Rumpus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18916 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:e27f61e2-2ce0-4d38-b211-20c33cc1fd24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e27f61e2-2ce0-4d38-b211-20c33cc1fd24', 1, NULL, 'Raucous Rumpus', 'Dance Card: No. 1. Raucous Rumpus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18916 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e27f61e2-2ce0-4d38-b211-20c33cc1fd24'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Breeze Serenade', part.name_en = 'Dance Card: No. 2. Breeze Serenade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18916 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:e1ffb334-0589-4c6b-af17-077f15fbd02b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1ffb334-0589-4c6b-af17-077f15fbd02b', 2, NULL, 'Breeze Serenade', 'Dance Card: No. 2. Breeze Serenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18916 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1ffb334-0589-4c6b-af17-077f15fbd02b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Jumble Dance', part.name_en = 'Dance Card: No. 3. Jumble Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18916 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:53dbc9e7-5e38-4650-8633-eb752062fdbd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53dbc9e7-5e38-4650-8633-eb752062fdbd', 3, NULL, 'Jumble Dance', 'Dance Card: No. 3. Jumble Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18916 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53dbc9e7-5e38-4650-8633-eb752062fdbd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Celestial Blue', part.name_en = 'Dance Card: No. 4. Celestial Blue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18916 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:83e0ca96-d229-4f0c-bee8-de3488707467' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83e0ca96-d229-4f0c-bee8-de3488707467', 4, NULL, 'Celestial Blue', 'Dance Card: No. 4. Celestial Blue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18916 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83e0ca96-d229-4f0c-bee8-de3488707467'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Machina Rockus', part.name_en = 'Dance Card: No. 5. Machina Rockus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18916 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:1b82a1b7-f6ba-4cdc-a1b4-187f40b0d936' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b82a1b7-f6ba-4cdc-a1b4-187f40b0d936', 5, NULL, 'Machina Rockus', 'Dance Card: No. 5. Machina Rockus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18916 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b82a1b7-f6ba-4cdc-a1b4-187f40b0d936'
);


-- None Dark Wood

UPDATE pieces piece
SET piece.title = 'Dark Wood', piece.title_en = 'Dark Wood',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17792 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dooryard Bloom

UPDATE pieces piece
SET piece.title = 'Dooryard Bloom', piece.title_en = 'Dooryard Bloom',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19712 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Duo Duel

UPDATE pieces piece
SET piece.title = 'Duo Duel', piece.title_en = 'Duo Duel',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19462 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Echo Dash

UPDATE pieces piece
SET piece.title = 'Echo Dash', piece.title_en = 'Echo Dash',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16319 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fanfare ritmico

UPDATE pieces piece
SET piece.title = 'Fanfare ritmico', piece.title_en = 'Fanfare ritmico',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18636 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 하프 협주곡

UPDATE pieces piece
SET piece.title = '하프 협주곡', piece.title_en = 'Harp Concerto',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16626 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'II',
    part.name_ko = 'Joy Ride', part.name_en = 'Harp Concerto: II. Joy Ride',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16626 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:1d311dce-7349-44a1-a021-646cfb4f773f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d311dce-7349-44a1-a021-646cfb4f773f', 1, 'II', 'Joy Ride', 'Harp Concerto: II. Joy Ride', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16626 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d311dce-7349-44a1-a021-646cfb4f773f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'III',
    part.name_ko = 'Lullaby', part.name_en = 'Harp Concerto: III. Lullaby',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16626 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:25b8dbac-0bce-4334-a511-b9c640a279b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25b8dbac-0bce-4334-a511-b9c640a279b4', 2, 'III', 'Lullaby', 'Harp Concerto: III. Lullaby', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16626 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25b8dbac-0bce-4334-a511-b9c640a279b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'I',
    part.name_ko = 'First Light', part.name_en = 'Harp Concerto: I. First Light',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16626 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:2aab21af-4459-4d7b-9f06-0ddbc6e8a30c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2aab21af-4459-4d7b-9f06-0ddbc6e8a30c', 3, 'I', 'First Light', 'Harp Concerto: I. First Light', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16626 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2aab21af-4459-4d7b-9f06-0ddbc6e8a30c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Rap Knock', part.name_en = 'Harp Concerto: IV. Rap Knock',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16626 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:f9f4b11d-648f-4443-9a7e-bf19d63dd273' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9f4b11d-648f-4443-9a7e-bf19d63dd273', 4, 'IV', 'Rap Knock', 'Harp Concerto: IV. Rap Knock', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16626 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9f4b11d-648f-4443-9a7e-bf19d63dd273'
);


-- None Impressions

UPDATE pieces piece
SET piece.title = 'Impressions', piece.title_en = 'Impressions',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19900 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Bright Palette', part.name_en = 'Impressions: I. Bright Palette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19900 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:46cf0268-a2b7-46ea-a446-45c4415d26f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46cf0268-a2b7-46ea-a446-45c4415d26f8', 1, 'I', 'Bright Palette', 'Impressions: I. Bright Palette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19900 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46cf0268-a2b7-46ea-a446-45c4415d26f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Quiet Art', part.name_en = 'Impressions: II. Quiet Art',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19900 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:025a6a40-d678-4653-aacf-a2700f7a407c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:025a6a40-d678-4653-aacf-a2700f7a407c', 2, 'II', 'Quiet Art', 'Impressions: II. Quiet Art', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19900 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:025a6a40-d678-4653-aacf-a2700f7a407c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'To the Point', part.name_en = 'Impressions: III. To the Point',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19900 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:089c06e5-f6a7-44bc-9107-4d20e35a58a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:089c06e5-f6a7-44bc-9107-4d20e35a58a9', 3, 'III', 'To the Point', 'Impressions: III. To the Point', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19900 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:089c06e5-f6a7-44bc-9107-4d20e35a58a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Noted Canvas', part.name_en = 'Impressions: IV. Noted Canvas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19900 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:18e658c5-8542-489d-ab6c-4b7d51b8c8af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18e658c5-8542-489d-ab6c-4b7d51b8c8af', 4, 'IV', 'Noted Canvas', 'Impressions: IV. Noted Canvas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19900 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18e658c5-8542-489d-ab6c-4b7d51b8c8af'
);


-- None Legacy

UPDATE pieces piece
SET piece.title = 'Legacy', piece.title_en = 'Legacy',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18088 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Loco

UPDATE pieces piece
SET piece.title = 'Loco', piece.title_en = 'Loco',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18828 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Low Brass Concerto

UPDATE pieces piece
SET piece.title = 'Low Brass Concerto', piece.title_en = 'Low Brass Concerto',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17952 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None On a Wire

UPDATE pieces piece
SET piece.title = 'On a Wire', piece.title_en = 'On a Wire',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18103 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None On the Death of the Righteous

UPDATE pieces piece
SET piece.title = 'On the Death of the Righteous', piece.title_en = 'On the Death of the Righteous',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19604 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Percussion Concerto

UPDATE pieces piece
SET piece.title = 'Percussion Concerto', piece.title_en = 'Percussion Concerto',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18379 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 피아노 3중주

UPDATE pieces piece
SET piece.title = '피아노 3중주', piece.title_en = 'Piano Trio',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19373 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Pale Yellow', part.name_en = 'Piano Trio: I. Pale Yellow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19373 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:07e27d92-a7c1-42d5-b9bd-26cb472e7d36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07e27d92-a7c1-42d5-b9bd-26cb472e7d36', 1, 'I', 'Pale Yellow', 'Piano Trio: I. Pale Yellow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19373 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07e27d92-a7c1-42d5-b9bd-26cb472e7d36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Fiery Red', part.name_en = 'Piano Trio: II. Fiery Red',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19373 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:b0edd26a-2375-4e25-959e-5381d6668642' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0edd26a-2375-4e25-959e-5381d6668642', 2, 'II', 'Fiery Red', 'Piano Trio: II. Fiery Red', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19373 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0edd26a-2375-4e25-959e-5381d6668642'
);


-- None Sky Quartet

UPDATE pieces piece
SET piece.title = 'Sky Quartet', piece.title_en = 'Sky Quartet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18868 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sky Rising', part.name_en = 'Sky Quartet: I. Sky Rising',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18868 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:15689269-d7d9-4858-b281-d66a04b595e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15689269-d7d9-4858-b281-d66a04b595e0', 1, 'I', 'Sky Rising', 'Sky Quartet: I. Sky Rising', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18868 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15689269-d7d9-4858-b281-d66a04b595e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Blue Sky', part.name_en = 'Sky Quartet: II. Blue Sky',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18868 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:ed6b5bc2-fc31-4870-acf4-aef331702d14' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed6b5bc2-fc31-4870-acf4-aef331702d14', 2, 'II', 'Blue Sky', 'Sky Quartet: II. Blue Sky', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18868 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed6b5bc2-fc31-4870-acf4-aef331702d14'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Fury', part.name_en = 'Sky Quartet: III. Fury',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18868 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:ff7331d7-0dc3-4804-be6c-df76473b2833' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff7331d7-0dc3-4804-be6c-df76473b2833', 3, 'III', 'Fury', 'Sky Quartet: III. Fury', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18868 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff7331d7-0dc3-4804-be6c-df76473b2833'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Immense Sky', part.name_en = 'Sky Quartet: IV. Immense Sky',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18868 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:f06d148c-a215-44f8-9819-4c8debb020e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f06d148c-a215-44f8-9819-4c8debb020e8', 4, 'IV', 'Immense Sky', 'Sky Quartet: IV. Immense Sky', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18868 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f06d148c-a215-44f8-9819-4c8debb020e8'
);


-- None 비올라와 피아노를 위한 소나타

UPDATE pieces piece
SET piece.title = '비올라와 피아노를 위한 소나타', piece.title_en = 'Sonata for Viola and Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19250 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Calmly', part.name_en = 'Sonata for Viola and Piano: I. Calmly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19250 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:7b6a6599-9820-4a39-8396-ea5ac3c39dc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b6a6599-9820-4a39-8396-ea5ac3c39dc1', 1, 'I', 'Calmly', 'Sonata for Viola and Piano: I. Calmly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19250 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b6a6599-9820-4a39-8396-ea5ac3c39dc1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Declamatory', part.name_en = 'Sonata for Viola and Piano: II. Declamatory',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19250 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:ee589a0c-0876-4b62-8877-4ac89b46f9db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee589a0c-0876-4b62-8877-4ac89b46f9db', 2, 'II', 'Declamatory', 'Sonata for Viola and Piano: II. Declamatory', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19250 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee589a0c-0876-4b62-8877-4ac89b46f9db'
);


-- None Splendid Wood

UPDATE pieces piece
SET piece.title = 'Splendid Wood', piece.title_en = 'Splendid Wood',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18393 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None String Poetic

UPDATE pieces piece
SET piece.title = 'String Poetic', piece.title_en = 'String Poetic',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18014 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Jagged Climb', part.name_en = 'String Poetic: I. Jagged Climb',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18014 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:65486874-743d-4c12-874c-2ae08dda206d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65486874-743d-4c12-874c-2ae08dda206d', 1, 'I', 'Jagged Climb', 'String Poetic: I. Jagged Climb', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18014 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65486874-743d-4c12-874c-2ae08dda206d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Nocturne', part.name_en = 'String Poetic: II. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18014 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:82eeb4d2-361a-4f40-8eb1-3e05e6aa7034' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82eeb4d2-361a-4f40-8eb1-3e05e6aa7034', 2, 'II', 'Nocturne', 'String Poetic: II. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18014 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82eeb4d2-361a-4f40-8eb1-3e05e6aa7034'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Bluie Hills of Mist', part.name_en = 'String Poetic: III. Bluie Hills of Mist',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18014 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:4fc85995-96f3-4b96-8e97-2b4dbe21f01f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fc85995-96f3-4b96-8e97-2b4dbe21f01f', 3, 'III', 'Bluie Hills of Mist', 'String Poetic: III. Bluie Hills of Mist', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18014 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fc85995-96f3-4b96-8e97-2b4dbe21f01f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Maze Mechanical', part.name_en = 'String Poetic: IV. Maze Mechanical',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18014 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:1d5c1d21-8ffc-47d6-a5ea-1e524e97b0b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d5c1d21-8ffc-47d6-a5ea-1e524e97b0b8', 4, 'IV', 'Maze Mechanical', 'String Poetic: IV. Maze Mechanical', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18014 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d5c1d21-8ffc-47d6-a5ea-1e524e97b0b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Climb Jagged', part.name_en = 'String Poetic: V. Climb Jagged',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18014 AND p.composer_id = 297 AND part.part_key = 'musicbrainz:3061a437-ef4a-4982-96bd-6df661392605' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3061a437-ef4a-4982-96bd-6df661392605', 5, 'V', 'Climb Jagged', 'String Poetic: V. Climb Jagged', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18014 AND p.composer_id = 297
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3061a437-ef4a-4982-96bd-6df661392605'
);


-- None 현악 3중주

UPDATE pieces piece
SET piece.title = '현악 3중주', piece.title_en = 'String Trio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17340 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Zaka

UPDATE pieces piece
SET piece.title = 'Zaka', piece.title_en = 'Zaka',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19612 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None blue cathedral

UPDATE pieces piece
SET piece.title = 'blue cathedral', piece.title_en = 'blue cathedral',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19148 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None rapid*fire

UPDATE pieces piece
SET piece.title = 'rapid*fire', piece.title_en = 'rapid*fire',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18803 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None running the edgE

UPDATE pieces piece
SET piece.title = 'running the edgE', piece.title_en = 'running the edgE',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17579 AND piece.composer_id = 297
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 클라리넷 소나타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라리넷 소나타', 'Clarinet Sonata', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 297
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라리넷 소나타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7e10f365-52cd-46c8-95c4-eb430c3f2325'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7e10f365-52cd-46c8-95c4-eb430c3f2325'
FROM pieces p
WHERE p.composer_id = 297 AND p.title = '클라리넷 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7e10f365-52cd-46c8-95c4-eb430c3f2325'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35027245-a7bb-409d-93fd-eb1977e232a0', 1, 'I', 'Calmly', 'Clarinet Sonata: I. Calmly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 297 AND p.title = '클라리넷 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35027245-a7bb-409d-93fd-eb1977e232a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d19b788-635a-41da-a120-adbbfc1703f3', 2, 'II', 'Declamatory', 'Clarinet Sonata: II. Declamatory', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 297 AND p.title = '클라리넷 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d19b788-635a-41da-a120-adbbfc1703f3'
);


-- None 관현악 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 협주곡', 'Concerto for Orchestra', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 297
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd4f53de0-2ede-4ba0-8e4e-4f12bdd9b2d4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd4f53de0-2ede-4ba0-8e4e-4f12bdd9b2d4'
FROM pieces p
WHERE p.composer_id = 297 AND p.title = '관현악 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd4f53de0-2ede-4ba0-8e4e-4f12bdd9b2d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:304834bc-9675-40b2-8732-2d52f946f67a', 1, NULL, 'I', 'Concerto for Orchestra: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 297 AND p.title = '관현악 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:304834bc-9675-40b2-8732-2d52f946f67a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:410d2e2a-8dd7-4d89-b4ab-5384425b8e81', 2, NULL, 'II', 'Concerto for Orchestra: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 297 AND p.title = '관현악 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:410d2e2a-8dd7-4d89-b4ab-5384425b8e81'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f93a0e7b-3c5f-4503-8b65-8e182e1f0d48', 3, NULL, 'III', 'Concerto for Orchestra: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 297 AND p.title = '관현악 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f93a0e7b-3c5f-4503-8b65-8e182e1f0d48'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:baab0366-47f0-49c3-9fdd-3bbe63c2562c', 4, NULL, 'IV', 'Concerto for Orchestra: IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 297 AND p.title = '관현악 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:baab0366-47f0-49c3-9fdd-3bbe63c2562c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7165653b-9071-4d11-9adc-77bc909ec6bd', 5, NULL, 'V', 'Concerto for Orchestra: V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 297 AND p.title = '관현악 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7165653b-9071-4d11-9adc-77bc909ec6bd'
);


-- None 가곡 <O magnum mysterium>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <O magnum mysterium>', 'O magnum mysterium', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 297
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <O magnum mysterium>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b6bec792-0737-4018-aea0-9ac84b40e8a8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b6bec792-0737-4018-aea0-9ac84b40e8a8'
FROM pieces p
WHERE p.composer_id = 297 AND p.title = '가곡 <O magnum mysterium>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b6bec792-0737-4018-aea0-9ac84b40e8a8'
);


-- None 오보에 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에 협주곡', 'Oboe Concerto', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 297
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '01f0fbbc-fb70-4189-98a6-0cef6eeb31eb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '01f0fbbc-fb70-4189-98a6-0cef6eeb31eb'
FROM pieces p
WHERE p.composer_id = 297 AND p.title = '오보에 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '01f0fbbc-fb70-4189-98a6-0cef6eeb31eb'
);


-- None The Singing Rooms

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Singing Rooms', 'The Singing Rooms', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 297
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Singing Rooms'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '509c41e5-3e32-4006-ae2e-e1496522080f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '509c41e5-3e32-4006-ae2e-e1496522080f'
FROM pieces p
WHERE p.composer_id = 297 AND p.title = 'The Singing Rooms' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '509c41e5-3e32-4006-ae2e-e1496522080f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1074c1e2-a334-40e0-a434-7b3b9d511cce', 1, NULL, 'Two Versions of the Day', 'Three Windows: Two Versions of the Day', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 297 AND p.title = 'The Singing Rooms' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1074c1e2-a334-40e0-a434-7b3b9d511cce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:092e974b-a733-4e80-adbe-0b93ae3b0da4', 2, NULL, 'Things Aren''t Always', 'Things Aren''t Always', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 297 AND p.title = 'The Singing Rooms' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:092e974b-a733-4e80-adbe-0b93ae3b0da4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d82a0783-ebcb-479b-9f76-88a3d41940ba', 3, NULL, 'The Interpretation of Dreams', 'The Interpretation of Dreams', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 297 AND p.title = 'The Singing Rooms' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d82a0783-ebcb-479b-9f76-88a3d41940ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9494650f-a95d-4c1e-a0f4-4f7be211fa44', 4, NULL, 'Confession', 'Confession', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 297 AND p.title = 'The Singing Rooms' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9494650f-a95d-4c1e-a0f4-4f7be211fa44'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0dc5e907-9fff-4db3-8a82-9cc33dfb020a', 5, NULL, 'History Lesson', 'History Lesson', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 297 AND p.title = 'The Singing Rooms' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0dc5e907-9fff-4db3-8a82-9cc33dfb020a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6e441d4-7cb7-4c0b-a7eb-fee075e76c17', 6, NULL, 'A Word with God', 'A Word with God', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 297 AND p.title = 'The Singing Rooms' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6e441d4-7cb7-4c0b-a7eb-fee075e76c17'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44f09375-f53b-4df2-915a-7b34a620f75e', 7, NULL, 'Two Versions of the Day (reprise)', 'Three Windows: Two Versions of the Day (reprise)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 297 AND p.title = 'The Singing Rooms' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44f09375-f53b-4df2-915a-7b34a620f75e'
);


-- None 비올라 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '비올라 협주곡', 'Viola Concerto', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 297
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '비올라 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0d4b24b-eac5-464c-af19-e3b84a3bf84c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b0d4b24b-eac5-464c-af19-e3b84a3bf84c'
FROM pieces p
WHERE p.composer_id = 297 AND p.title = '비올라 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0d4b24b-eac5-464c-af19-e3b84a3bf84c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7ae3b14-12fb-49be-b251-7ef24c939ecf', 1, NULL, 'I', 'Viola Concerto: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 297 AND p.title = '비올라 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7ae3b14-12fb-49be-b251-7ef24c939ecf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f133e4e-1007-4a2d-ac31-3cae7df5c4a8', 2, NULL, 'II', 'Viola Concerto: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 297 AND p.title = '비올라 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f133e4e-1007-4a2d-ac31-3cae7df5c4a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b57b2a8-5307-4c5f-969d-e7a172cbdb5a', 3, NULL, 'III', 'Viola Concerto: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 297 AND p.title = '비올라 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b57b2a8-5307-4c5f-969d-e7a172cbdb5a'
);


-- None 바이올린 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡', 'Violin Concerto', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 297
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '970606d8-0b41-480d-bd03-f7651336b091'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '970606d8-0b41-480d-bd03-f7651336b091'
FROM pieces p
WHERE p.composer_id = 297 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '970606d8-0b41-480d-bd03-f7651336b091'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7ebb5ba-c291-443b-a522-f4b0bb40f625', 1, 'I', '1726', 'Violin Concerto: I. 1726', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 297 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7ebb5ba-c291-443b-a522-f4b0bb40f625'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b12e6b56-667f-48db-96a6-77c2f2d9c391', 2, 'II', 'Chaconni', 'Violin Concerto: II. Chaconni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 297 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b12e6b56-667f-48db-96a6-77c2f2d9c391'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5259a974-69cf-439d-9fa3-1e5680c67495', 3, 'III', 'Fly Forward', 'Violin Concerto: III. Fly Forward', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 297 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5259a974-69cf-439d-9fa3-1e5680c67495'
);


-- None Voices

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Voices', 'Voices', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 297
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Voices'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d09b8ff-755a-4f91-9a55-1df444dbc0ed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7d09b8ff-755a-4f91-9a55-1df444dbc0ed'
FROM pieces p
WHERE p.composer_id = 297 AND p.title = 'Voices' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d09b8ff-755a-4f91-9a55-1df444dbc0ed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:925972ac-e1bb-46f7-92fe-5a99b14a5d25', 1, 'I', 'Blitz -', 'Voices: I. Blitz -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 297 AND p.title = 'Voices' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:925972ac-e1bb-46f7-92fe-5a99b14a5d25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9286c026-38ce-4c40-bdfa-b9e30beb03bc', 2, 'II', 'Soft Enlacing -', 'Voices: II. Soft Enlacing -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 297 AND p.title = 'Voices' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9286c026-38ce-4c40-bdfa-b9e30beb03bc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c242245d-2c91-40e5-b214-7035cbfe2bb1', 3, 'III', 'Grace', 'Voices: III. Grace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 297 AND p.title = 'Voices' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c242245d-2c91-40e5-b214-7035cbfe2bb1'
);


-- 숨길 seed 작품 없음
