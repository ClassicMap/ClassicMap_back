-- 조지 헨리 크럼 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 37개(묶음 8, 다악장 19, 낱곡 10),
-- 새 작품 2개, part 189개, 그 아래 24개.
-- seed 54개 중 35개를 작품·part 에 잇고, 1개를 숨기고, 18개는 그대로 둔다.
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

-- None A Haunted Landscape

UPDATE pieces piece
SET piece.title = 'A Haunted Landscape', piece.title_en = 'A Haunted Landscape',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18651 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Little Suite for Christmas, A.D. 1979

UPDATE pieces piece
SET piece.title = 'A Little Suite for Christmas, A.D. 1979', piece.title_en = 'A Little Suite for Christmas, A.D. 1979',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18077 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The Visitation', part.name_en = 'A Little Suite for Christmas, A.D. 1979: I. The Visitation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18077 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:12ea0aae-c705-4109-ae60-20b45e8e05e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12ea0aae-c705-4109-ae60-20b45e8e05e6', 1, 'I', 'The Visitation', 'A Little Suite for Christmas, A.D. 1979: I. The Visitation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18077 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12ea0aae-c705-4109-ae60-20b45e8e05e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Berceuse for the Infant Jesu', part.name_en = 'A Little Suite for Christmas, A.D. 1979: II. Berceuse for the Infant Jesu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18077 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:c93c5850-2259-4a7d-b25f-1123c0625b10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c93c5850-2259-4a7d-b25f-1123c0625b10', 2, 'II', 'Berceuse for the Infant Jesu', 'A Little Suite for Christmas, A.D. 1979: II. Berceuse for the Infant Jesu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18077 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c93c5850-2259-4a7d-b25f-1123c0625b10'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Shepherd''s Noël', part.name_en = 'A Little Suite for Christmas, A.D. 1979: III. The Shepherd''s Noël',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18077 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:57244957-4150-4187-b909-0ebe804d47e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57244957-4150-4187-b909-0ebe804d47e8', 3, 'III', 'The Shepherd''s Noël', 'A Little Suite for Christmas, A.D. 1979: III. The Shepherd''s Noël', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18077 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57244957-4150-4187-b909-0ebe804d47e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adoration of the Magi', part.name_en = 'A Little Suite for Christmas, A.D. 1979: IV. Adoration of the Magi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18077 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:50cedce3-8636-423a-a2d0-4ddffe9eeed6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50cedce3-8636-423a-a2d0-4ddffe9eeed6', 4, 'IV', 'Adoration of the Magi', 'A Little Suite for Christmas, A.D. 1979: IV. Adoration of the Magi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18077 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50cedce3-8636-423a-a2d0-4ddffe9eeed6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Nativity Dance', part.name_en = 'A Little Suite for Christmas, A.D. 1979: V. Nativity Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18077 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:f2466295-3392-4e58-9723-94bedefee642' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2466295-3392-4e58-9723-94bedefee642', 5, 'V', 'Nativity Dance', 'A Little Suite for Christmas, A.D. 1979: V. Nativity Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18077 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2466295-3392-4e58-9723-94bedefee642'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Canticle of the Holy Nights', part.name_en = 'A Little Suite for Christmas, A.D. 1979: VI. Canticle of the Holy Nights',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18077 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:b7799d06-bfd0-4bea-a00d-fc116e114e4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7799d06-bfd0-4bea-a00d-fc116e114e4b', 6, 'VI', 'Canticle of the Holy Nights', 'A Little Suite for Christmas, A.D. 1979: VI. Canticle of the Holy Nights', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18077 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7799d06-bfd0-4bea-a00d-fc116e114e4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Carol of the Bells', part.name_en = 'A Little Suite for Christmas, A.D. 1979: VII. Carol of the Bells',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18077 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:84965a18-f478-4dbb-91af-4699600be3d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84965a18-f478-4dbb-91af-4699600be3d9', 7, 'VII', 'Carol of the Bells', 'A Little Suite for Christmas, A.D. 1979: VII. Carol of the Bells', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18077 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84965a18-f478-4dbb-91af-4699600be3d9'
);


-- None An Idyll for the Misbegotten (Images III)

UPDATE pieces piece
SET piece.title = 'An Idyll for the Misbegotten (Images III)', piece.title_en = 'An Idyll for the Misbegotten (Images III)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18671 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <Ancient Voices of Children>

UPDATE pieces piece
SET piece.title = '연가곡집 <Ancient Voices of Children>', piece.title_en = 'Ancient Voices of Children',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16697 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'El niño busca su voz', part.name_en = 'Ancient Voices of Children: I. El niño busca su voz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16697 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:cd44b3c8-da75-4751-bbac-9640426eb2b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd44b3c8-da75-4751-bbac-9640426eb2b5', 1, 'I', 'El niño busca su voz', 'Ancient Voices of Children: I. El niño busca su voz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16697 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd44b3c8-da75-4751-bbac-9640426eb2b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Dances of the ancient earth', part.name_en = 'Ancient Voices of Children: Dances of the ancient earth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16697 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:6481c8b2-cb36-4955-b4a1-631330ee467c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6481c8b2-cb36-4955-b4a1-631330ee467c', 2, NULL, 'Dances of the ancient earth', 'Ancient Voices of Children: Dances of the ancient earth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16697 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6481c8b2-cb36-4955-b4a1-631330ee467c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'II',
    part.name_ko = 'Me he perdido muchas veces por el mar', part.name_en = 'Ancient Voices of Children: II. Me he perdido muchas veces por el mar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16697 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:be446934-e691-45a5-9c75-a506d644d2b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be446934-e691-45a5-9c75-a506d644d2b4', 3, 'II', 'Me he perdido muchas veces por el mar', 'Ancient Voices of Children: II. Me he perdido muchas veces por el mar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16697 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be446934-e691-45a5-9c75-a506d644d2b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'III',
    part.name_ko = '¿De dónde vienes, amor, mi niño? (Dance of the Sacred Life-Cycle)', part.name_en = 'Ancient Voices of Children: III. ¿De dónde vienes, amor, mi niño? (Dance of the Sacred Life-Cycle)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16697 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:771d474e-308c-4df7-91eb-3c9b20992a21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:771d474e-308c-4df7-91eb-3c9b20992a21', 4, 'III', '¿De dónde vienes, amor, mi niño? (Dance of the Sacred Life-Cycle)', 'Ancient Voices of Children: III. ¿De dónde vienes, amor, mi niño? (Dance of the Sacred Life-Cycle)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16697 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:771d474e-308c-4df7-91eb-3c9b20992a21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'IV',
    part.name_ko = 'Todas las tardes en Granada, todas las tardes se muere un niño', part.name_en = 'Ancient Voices of Children: IV. Todas las tardes en Granada, todas las tardes se muere un niño',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16697 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:9c8ef078-f918-421e-85d7-455a2ab43a4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c8ef078-f918-421e-85d7-455a2ab43a4a', 5, 'IV', 'Todas las tardes en Granada, todas las tardes se muere un niño', 'Ancient Voices of Children: IV. Todas las tardes en Granada, todas las tardes se muere un niño', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16697 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c8ef078-f918-421e-85d7-455a2ab43a4a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Ghost dance', part.name_en = 'Ancient Voices of Children: Ghost dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16697 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:29ea9d24-6686-4fed-95c2-bd3ad06267e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29ea9d24-6686-4fed-95c2-bd3ad06267e6', 6, NULL, 'Ghost dance', 'Ancient Voices of Children: Ghost dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16697 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29ea9d24-6686-4fed-95c2-bd3ad06267e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'V',
    part.name_ko = 'Se ha llenado de luces mi corazón de seda', part.name_en = 'Ancient Voices of Children: V. Se ha llenado de luces mi corazón de seda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16697 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:165ddb67-66ba-448c-a322-a3b029563c91' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:165ddb67-66ba-448c-a322-a3b029563c91', 7, 'V', 'Se ha llenado de luces mi corazón de seda', 'Ancient Voices of Children: V. Se ha llenado de luces mi corazón de seda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16697 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:165ddb67-66ba-448c-a322-a3b029563c91'
);


-- None 연가곡집 <Apparition>

UPDATE pieces piece
SET piece.title = '연가곡집 <Apparition>', piece.title_en = 'Apparition',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16031 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Night in Silence Under Many a Star', part.name_en = 'Apparition: I. The Night in Silence Under Many a Star',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16031 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:3933b74f-c29e-4c37-bb1a-c2b6cc190c90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3933b74f-c29e-4c37-bb1a-c2b6cc190c90', 1, NULL, 'The Night in Silence Under Many a Star', 'Apparition: I. The Night in Silence Under Many a Star', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16031 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3933b74f-c29e-4c37-bb1a-c2b6cc190c90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Vocalise 1: Summer Sounds', part.name_en = 'Apparition: Vocalise 1: Summer Sounds',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16031 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:0f3cece3-08e7-4245-9317-c7c19bc43ffb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f3cece3-08e7-4245-9317-c7c19bc43ffb', 2, NULL, 'Vocalise 1: Summer Sounds', 'Apparition: Vocalise 1: Summer Sounds', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16031 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f3cece3-08e7-4245-9317-c7c19bc43ffb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'When Lilacs Last in the Dooryard Bloom''d', part.name_en = 'Apparition: II. When Lilacs Last in the Dooryard Bloom''d',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16031 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:173bbd9a-e8c6-4400-aede-560abb01eda8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:173bbd9a-e8c6-4400-aede-560abb01eda8', 3, NULL, 'When Lilacs Last in the Dooryard Bloom''d', 'Apparition: II. When Lilacs Last in the Dooryard Bloom''d', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16031 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:173bbd9a-e8c6-4400-aede-560abb01eda8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Dark Mother Always Gliding with Soft Feet', part.name_en = 'Apparition: III. Dark Mother Always Gliding with Soft Feet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16031 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:d696ea4d-7cb4-433f-9821-95261b46bb30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d696ea4d-7cb4-433f-9821-95261b46bb30', 4, NULL, 'Dark Mother Always Gliding with Soft Feet', 'Apparition: III. Dark Mother Always Gliding with Soft Feet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16031 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d696ea4d-7cb4-433f-9821-95261b46bb30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Vocalise 2: Invocation to the Dark Angel', part.name_en = 'Apparition: Vocalise 2: Invocation to the Dark Angel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16031 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:30c7b313-bc8f-457c-bfdf-f9b53268a900' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30c7b313-bc8f-457c-bfdf-f9b53268a900', 5, NULL, 'Vocalise 2: Invocation to the Dark Angel', 'Apparition: Vocalise 2: Invocation to the Dark Angel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16031 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30c7b313-bc8f-457c-bfdf-f9b53268a900'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Approach Strong Deliveress!', part.name_en = 'Apparition: IV. Approach Strong Deliveress!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16031 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:625eeac3-b416-4ed7-b9bf-c6182579fa3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:625eeac3-b416-4ed7-b9bf-c6182579fa3a', 6, NULL, 'Approach Strong Deliveress!', 'Apparition: IV. Approach Strong Deliveress!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16031 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:625eeac3-b416-4ed7-b9bf-c6182579fa3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Vocalise 3: Death Carol (''''Song of the Nightbird'''')', part.name_en = 'Apparition: Vocalise 3: Death Carol (''''Song of the Nightbird'''')',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16031 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:343b6dc6-8226-457b-8fe7-89657a1fd60f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:343b6dc6-8226-457b-8fe7-89657a1fd60f', 7, NULL, 'Vocalise 3: Death Carol (''''Song of the Nightbird'''')', 'Apparition: Vocalise 3: Death Carol (''''Song of the Nightbird'''')', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16031 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:343b6dc6-8226-457b-8fe7-89657a1fd60f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Come Lovely and Soothing Death', part.name_en = 'Apparition: V. Come Lovely and Soothing Death',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16031 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:1e43e774-744b-47f7-ad32-113c7356de03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e43e774-744b-47f7-ad32-113c7356de03', 8, NULL, 'Come Lovely and Soothing Death', 'Apparition: V. Come Lovely and Soothing Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16031 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e43e774-744b-47f7-ad32-113c7356de03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'The Night in Silence Under Many a Star', part.name_en = 'Apparition: VI. The Night in Silence Under Many a Star',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16031 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:5ddd6a25-b083-4db8-8713-0c00425f3084' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ddd6a25-b083-4db8-8713-0c00425f3084', 9, NULL, 'The Night in Silence Under Many a Star', 'Apparition: VI. The Night in Silence Under Many a Star', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16031 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ddd6a25-b083-4db8-8713-0c00425f3084'
);


-- None Black Angels (Thirteen Images from the Dark Land)

UPDATE pieces piece
SET piece.title = 'Black Angels (Thirteen Images from the Dark Land)', piece.title_en = 'Black Angels (Thirteen Images from the Dark Land)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19707 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Departure', part.name_en = 'Black Angels (Thirteen Images from the Dark Land): I. Departure',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19707 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:72b18b44-b989-40d1-8ee6-13c02717f648' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72b18b44-b989-40d1-8ee6-13c02717f648', 1, 'I', 'Departure', 'Black Angels (Thirteen Images from the Dark Land): I. Departure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19707 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72b18b44-b989-40d1-8ee6-13c02717f648'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72b18b44-b989-40d1-8ee6-13c02717f648'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Night of the Electric Insects', part.name_en = 'Black Angels (Thirteen Images from the Dark Land): I. Night of the Electric Insects',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19707 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:30862127-a56d-469b-a2f1-a10ba194f841' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:30862127-a56d-469b-a2f1-a10ba194f841', 1, NULL, 'Night of the Electric Insects', 'Black Angels (Thirteen Images from the Dark Land): I. Night of the Electric Insects', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72b18b44-b989-40d1-8ee6-13c02717f648'
WHERE p.id = 19707 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30862127-a56d-469b-a2f1-a10ba194f841'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72b18b44-b989-40d1-8ee6-13c02717f648'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sounds of Bones and Flutes', part.name_en = 'Black Angels (Thirteen Images from the Dark Land): II. Sounds of Bones and Flutes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19707 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:099eccf0-217c-4aff-8265-a883ccc9b567' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:099eccf0-217c-4aff-8265-a883ccc9b567', 2, NULL, 'Sounds of Bones and Flutes', 'Black Angels (Thirteen Images from the Dark Land): II. Sounds of Bones and Flutes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72b18b44-b989-40d1-8ee6-13c02717f648'
WHERE p.id = 19707 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:099eccf0-217c-4aff-8265-a883ccc9b567'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72b18b44-b989-40d1-8ee6-13c02717f648'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Lost Bells', part.name_en = 'Black Angels (Thirteen Images from the Dark Land): III. Lost Bells',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19707 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:8a098a85-e3e9-4abf-9418-0a50c89b86ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8a098a85-e3e9-4abf-9418-0a50c89b86ad', 3, NULL, 'Lost Bells', 'Black Angels (Thirteen Images from the Dark Land): III. Lost Bells', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72b18b44-b989-40d1-8ee6-13c02717f648'
WHERE p.id = 19707 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a098a85-e3e9-4abf-9418-0a50c89b86ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72b18b44-b989-40d1-8ee6-13c02717f648'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Devil Music', part.name_en = 'Black Angels (Thirteen Images from the Dark Land): IV. Devil Music',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19707 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:91d72039-f4b8-4ea8-8df1-b9dc8400e1e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:91d72039-f4b8-4ea8-8df1-b9dc8400e1e7', 4, NULL, 'Devil Music', 'Black Angels (Thirteen Images from the Dark Land): IV. Devil Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72b18b44-b989-40d1-8ee6-13c02717f648'
WHERE p.id = 19707 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91d72039-f4b8-4ea8-8df1-b9dc8400e1e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72b18b44-b989-40d1-8ee6-13c02717f648'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Danse Macabre', part.name_en = 'Black Angels (Thirteen Images from the Dark Land): V. Danse Macabre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19707 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:2184f3c5-ba31-4a34-816a-24f024e65463' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2184f3c5-ba31-4a34-816a-24f024e65463', 5, NULL, 'Danse Macabre', 'Black Angels (Thirteen Images from the Dark Land): V. Danse Macabre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72b18b44-b989-40d1-8ee6-13c02717f648'
WHERE p.id = 19707 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2184f3c5-ba31-4a34-816a-24f024e65463'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Absence', part.name_en = 'Black Angels (Thirteen Images from the Dark Land): II. Absence',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19707 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:2bfac46a-171c-40aa-b5e7-9e87142058c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bfac46a-171c-40aa-b5e7-9e87142058c9', 2, 'II', 'Absence', 'Black Angels (Thirteen Images from the Dark Land): II. Absence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19707 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bfac46a-171c-40aa-b5e7-9e87142058c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2bfac46a-171c-40aa-b5e7-9e87142058c9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Pavana Lachrymae (Der Tod und das Mädchen)', part.name_en = 'Black Angels (Thirteen Images from the Dark Land): VI. Pavana Lachrymae (Der Tod und das Mädchen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19707 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:44f48a24-d62c-46aa-b48e-554a2eb6ebb3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:44f48a24-d62c-46aa-b48e-554a2eb6ebb3', 1, NULL, 'Pavana Lachrymae (Der Tod und das Mädchen)', 'Black Angels (Thirteen Images from the Dark Land): VI. Pavana Lachrymae (Der Tod und das Mädchen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2bfac46a-171c-40aa-b5e7-9e87142058c9'
WHERE p.id = 19707 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44f48a24-d62c-46aa-b48e-554a2eb6ebb3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2bfac46a-171c-40aa-b5e7-9e87142058c9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Black Angels', part.name_en = 'Black Angels (Thirteen Images from the Dark Land): VII. Black Angels',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19707 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:0309c525-8800-4543-b6a4-33bb7e110cd5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0309c525-8800-4543-b6a4-33bb7e110cd5', 2, NULL, 'Black Angels', 'Black Angels (Thirteen Images from the Dark Land): VII. Black Angels', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2bfac46a-171c-40aa-b5e7-9e87142058c9'
WHERE p.id = 19707 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0309c525-8800-4543-b6a4-33bb7e110cd5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2bfac46a-171c-40aa-b5e7-9e87142058c9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sarabanda de la Muerte Oscura', part.name_en = 'Black Angels (Thirteen Images from the Dark Land): VIII. Sarabanda de la Muerte Oscura',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19707 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:cb1afcae-30de-45c2-9fc0-ce81861991f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cb1afcae-30de-45c2-9fc0-ce81861991f3', 3, NULL, 'Sarabanda de la Muerte Oscura', 'Black Angels (Thirteen Images from the Dark Land): VIII. Sarabanda de la Muerte Oscura', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2bfac46a-171c-40aa-b5e7-9e87142058c9'
WHERE p.id = 19707 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb1afcae-30de-45c2-9fc0-ce81861991f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2bfac46a-171c-40aa-b5e7-9e87142058c9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Lost Bells (Echo)', part.name_en = 'Black Angels (Thirteen Images from the Dark Land): IX. Lost Bells (Echo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19707 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:358b3d71-4f1c-45db-bed8-496c74bae28e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:358b3d71-4f1c-45db-bed8-496c74bae28e', 4, NULL, 'Lost Bells (Echo)', 'Black Angels (Thirteen Images from the Dark Land): IX. Lost Bells (Echo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2bfac46a-171c-40aa-b5e7-9e87142058c9'
WHERE p.id = 19707 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:358b3d71-4f1c-45db-bed8-496c74bae28e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Return', part.name_en = 'Black Angels (Thirteen Images from the Dark Land): III. Return',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19707 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:e1054eee-f688-43fd-9122-addd9db5e23a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1054eee-f688-43fd-9122-addd9db5e23a', 3, 'III', 'Return', 'Black Angels (Thirteen Images from the Dark Land): III. Return', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19707 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1054eee-f688-43fd-9122-addd9db5e23a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1054eee-f688-43fd-9122-addd9db5e23a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'God-music', part.name_en = 'Black Angels (Thirteen Images from the Dark Land): X. God-music',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19707 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:890eeca1-93e2-4aff-b5d9-b718c32476c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:890eeca1-93e2-4aff-b5d9-b718c32476c6', 1, NULL, 'God-music', 'Black Angels (Thirteen Images from the Dark Land): X. God-music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1054eee-f688-43fd-9122-addd9db5e23a'
WHERE p.id = 19707 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:890eeca1-93e2-4aff-b5d9-b718c32476c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1054eee-f688-43fd-9122-addd9db5e23a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ancient Voices', part.name_en = 'Black Angels (Thirteen Images from the Dark Land): XI. Ancient Voices',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19707 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:342420e3-461b-481f-b749-ab53e19ebbd0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:342420e3-461b-481f-b749-ab53e19ebbd0', 2, NULL, 'Ancient Voices', 'Black Angels (Thirteen Images from the Dark Land): XI. Ancient Voices', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1054eee-f688-43fd-9122-addd9db5e23a'
WHERE p.id = 19707 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:342420e3-461b-481f-b749-ab53e19ebbd0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1054eee-f688-43fd-9122-addd9db5e23a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ancient Voices (Echo)', part.name_en = 'Black Angels (Thirteen Images from the Dark Land): XII. Ancient Voices (Echo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19707 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:2dc907ea-a422-4a3a-9890-ce4388a282d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2dc907ea-a422-4a3a-9890-ce4388a282d1', 3, NULL, 'Ancient Voices (Echo)', 'Black Angels (Thirteen Images from the Dark Land): XII. Ancient Voices (Echo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1054eee-f688-43fd-9122-addd9db5e23a'
WHERE p.id = 19707 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2dc907ea-a422-4a3a-9890-ce4388a282d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1054eee-f688-43fd-9122-addd9db5e23a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Night of the Electric Insects', part.name_en = 'Black Angels (Thirteen Images from the Dark Land): XIII. Night of the Electric Insects',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19707 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:70a23491-e430-4338-bd7e-8841e19066c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:70a23491-e430-4338-bd7e-8841e19066c2', 4, NULL, 'Night of the Electric Insects', 'Black Angels (Thirteen Images from the Dark Land): XIII. Night of the Electric Insects', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1054eee-f688-43fd-9122-addd9db5e23a'
WHERE p.id = 19707 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70a23491-e430-4338-bd7e-8841e19066c2'
);


-- None Celestial Mechanics (Makrokosmos IV)

UPDATE pieces piece
SET piece.title = 'Celestial Mechanics (Makrokosmos IV)', piece.title_en = 'Celestial Mechanics (Makrokosmos IV)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16718 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Gamma Draconis', part.name_en = 'Makrokosmos IV: 3. Gamma Draconis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16718 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:0668760d-3ebd-4e94-9098-7e59e95229b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0668760d-3ebd-4e94-9098-7e59e95229b0', 1, NULL, 'Gamma Draconis', 'Makrokosmos IV: 3. Gamma Draconis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16718 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0668760d-3ebd-4e94-9098-7e59e95229b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Alpha Centauri', part.name_en = 'Makrokosmos IV: 1. Alpha Centauri',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16718 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:3971a146-d865-45f2-ae9b-1077efa3e59d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3971a146-d865-45f2-ae9b-1077efa3e59d', 2, NULL, 'Alpha Centauri', 'Makrokosmos IV: 1. Alpha Centauri', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16718 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3971a146-d865-45f2-ae9b-1077efa3e59d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Beta Cygni', part.name_en = 'Makrokosmos IV: 2. Beta Cygni',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16718 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:56cb7bd6-6c1a-4853-8ecf-b9c8098a2057' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56cb7bd6-6c1a-4853-8ecf-b9c8098a2057', 3, NULL, 'Beta Cygni', 'Makrokosmos IV: 2. Beta Cygni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16718 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56cb7bd6-6c1a-4853-8ecf-b9c8098a2057'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Delta Orionis', part.name_en = 'Makrokosmos IV: 4. Delta Orionis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16718 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:7f34ba69-1017-4891-8dab-c4711fcc97b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f34ba69-1017-4891-8dab-c4711fcc97b6', 4, NULL, 'Delta Orionis', 'Makrokosmos IV: 4. Delta Orionis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16718 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f34ba69-1017-4891-8dab-c4711fcc97b6'
);


-- None Dream Sequence (Images II)

UPDATE pieces piece
SET piece.title = 'Dream Sequence (Images II)', piece.title_en = 'Dream Sequence (Images II)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18378 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Echoes of Time and the River (Echoes II)

UPDATE pieces piece
SET piece.title = 'Echoes of Time and the River (Echoes II)', piece.title_en = 'Echoes of Time and the River (Echoes II)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17491 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Frozen Time', part.name_en = 'Echoes of Time and the River (Echoes II): I. Frozen Time',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17491 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:21ab65f1-4e5d-47f6-b782-ba862625d5d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21ab65f1-4e5d-47f6-b782-ba862625d5d3', 1, 'I', 'Frozen Time', 'Echoes of Time and the River (Echoes II): I. Frozen Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17491 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21ab65f1-4e5d-47f6-b782-ba862625d5d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Remembrance of Time', part.name_en = 'Echoes of Time and the River (Echoes II): II. Remembrance of Time',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17491 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:a9792a45-39fb-4165-89ae-038c8e74cd7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9792a45-39fb-4165-89ae-038c8e74cd7a', 2, 'II', 'Remembrance of Time', 'Echoes of Time and the River (Echoes II): II. Remembrance of Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17491 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9792a45-39fb-4165-89ae-038c8e74cd7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Collapse of Time', part.name_en = 'Echoes of Time and the River (Echoes II): III. Collapse of Time',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17491 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:874d9525-8e28-4ea6-897f-8865c1378eca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:874d9525-8e28-4ea6-897f-8865c1378eca', 3, 'III', 'Collapse of Time', 'Echoes of Time and the River (Echoes II): III. Collapse of Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17491 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:874d9525-8e28-4ea6-897f-8865c1378eca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Last Echoes of Time', part.name_en = 'Echoes of Time and the River (Echoes II): IV. Last Echoes of Time',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17491 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:aff9ed80-2d38-4134-8cc5-6d25c0b68f0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aff9ed80-2d38-4134-8cc5-6d25c0b68f0d', 4, 'IV', 'Last Echoes of Time', 'Echoes of Time and the River (Echoes II): IV. Last Echoes of Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17491 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aff9ed80-2d38-4134-8cc5-6d25c0b68f0d'
);


-- None Eleven Echoes of Autumn (Echoes I)

UPDATE pieces piece
SET piece.title = 'Eleven Echoes of Autumn (Echoes I)', piece.title_en = 'Eleven Echoes of Autumn (Echoes I)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18939 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Eco 1. Fantastico', part.name_en = 'Eleven Echoes of Autumn (Echoes I): Eco 1. Fantastico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18939 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:5d8fd037-6b28-4a22-97b1-3b2d6a8853b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d8fd037-6b28-4a22-97b1-3b2d6a8853b5', 1, NULL, 'Eco 1. Fantastico', 'Eleven Echoes of Autumn (Echoes I): Eco 1. Fantastico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18939 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d8fd037-6b28-4a22-97b1-3b2d6a8853b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Eco 2. Languidamente, quasi lontano ("hauntingly")', part.name_en = 'Eleven Echoes of Autumn (Echoes I): Eco 2. Languidamente, quasi lontano ("hauntingly")',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18939 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:239b774b-dd65-4d2f-8ff8-a9a4cf662958' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:239b774b-dd65-4d2f-8ff8-a9a4cf662958', 2, NULL, 'Eco 2. Languidamente, quasi lontano ("hauntingly")', 'Eleven Echoes of Autumn (Echoes I): Eco 2. Languidamente, quasi lontano ("hauntingly")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18939 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:239b774b-dd65-4d2f-8ff8-a9a4cf662958'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Eco 3. Prestissimo', part.name_en = 'Eleven Echoes of Autumn (Echoes I): Eco 3. Prestissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18939 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:60a6ecb0-b3cb-4226-b03a-509d70250051' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60a6ecb0-b3cb-4226-b03a-509d70250051', 3, NULL, 'Eco 3. Prestissimo', 'Eleven Echoes of Autumn (Echoes I): Eco 3. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18939 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60a6ecb0-b3cb-4226-b03a-509d70250051'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Eco 4. Con bravura', part.name_en = 'Eleven Echoes of Autumn (Echoes I): Eco 4. Con bravura',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18939 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:76aafbe1-3193-4d24-afe5-540e1171b37a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76aafbe1-3193-4d24-afe5-540e1171b37a', 4, NULL, 'Eco 4. Con bravura', 'Eleven Echoes of Autumn (Echoes I): Eco 4. Con bravura', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18939 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76aafbe1-3193-4d24-afe5-540e1171b37a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Eco 5. Dark, intense', part.name_en = 'Eleven Echoes of Autumn (Echoes I): Eco 5. Dark, intense',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18939 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:e38cde9d-af93-40d0-9001-9549578d3190' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e38cde9d-af93-40d0-9001-9549578d3190', 5, NULL, 'Eco 5. Dark, intense', 'Eleven Echoes of Autumn (Echoes I): Eco 5. Dark, intense', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18939 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e38cde9d-af93-40d0-9001-9549578d3190'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Eco 6. Dark, intense', part.name_en = 'Eleven Echoes of Autumn (Echoes I): Eco 6. Dark, intense',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18939 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:520fc50a-17f7-460b-9eea-0b9a6a083bbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:520fc50a-17f7-460b-9eea-0b9a6a083bbf', 6, NULL, 'Eco 6. Dark, intense', 'Eleven Echoes of Autumn (Echoes I): Eco 6. Dark, intense', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18939 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:520fc50a-17f7-460b-9eea-0b9a6a083bbf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Eco 7. Dark, intense', part.name_en = 'Eleven Echoes of Autumn (Echoes I): Eco 7. Dark, intense',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18939 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:d02b5f34-4913-4912-aacd-e2fc33fa1b71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d02b5f34-4913-4912-aacd-e2fc33fa1b71', 7, NULL, 'Eco 7. Dark, intense', 'Eleven Echoes of Autumn (Echoes I): Eco 7. Dark, intense', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18939 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d02b5f34-4913-4912-aacd-e2fc33fa1b71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Eco 8. Feroce, violento', part.name_en = 'Eleven Echoes of Autumn (Echoes I): Eco 8. Feroce, violento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18939 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:2e1dc668-69e4-4802-a142-4dd496b84317' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e1dc668-69e4-4802-a142-4dd496b84317', 8, NULL, 'Eco 8. Feroce, violento', 'Eleven Echoes of Autumn (Echoes I): Eco 8. Feroce, violento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18939 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e1dc668-69e4-4802-a142-4dd496b84317'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Eco 9. Serenamente, quasi lontano ("hauntingly")', part.name_en = 'Eleven Echoes of Autumn (Echoes I): Eco 9. Serenamente, quasi lontano ("hauntingly")',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18939 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:942bb776-af33-4099-8a4d-ce4f6386f476' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:942bb776-af33-4099-8a4d-ce4f6386f476', 9, NULL, 'Eco 9. Serenamente, quasi lontano ("hauntingly")', 'Eleven Echoes of Autumn (Echoes I): Eco 9. Serenamente, quasi lontano ("hauntingly")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18939 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:942bb776-af33-4099-8a4d-ce4f6386f476'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Eco 10. Senza misura ("gently undulating")', part.name_en = 'Eleven Echoes of Autumn (Echoes I): Eco 10. Senza misura ("gently undulating")',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18939 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:e4913be4-ef3d-4152-af6e-fff8ab827e0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4913be4-ef3d-4152-af6e-fff8ab827e0e', 10, NULL, 'Eco 10. Senza misura ("gently undulating")', 'Eleven Echoes of Autumn (Echoes I): Eco 10. Senza misura ("gently undulating")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18939 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4913be4-ef3d-4152-af6e-fff8ab827e0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Eco 11. Adagio; ("like a prayer")', part.name_en = 'Eleven Echoes of Autumn (Echoes I): Eco 11. Adagio; ("like a prayer")',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18939 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:9fd10101-63ef-448e-a052-0c7a9ee2e6dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fd10101-63ef-448e-a052-0c7a9ee2e6dd', 11, NULL, 'Eco 11. Adagio; ("like a prayer")', 'Eleven Echoes of Autumn (Echoes I): Eco 11. Adagio; ("like a prayer")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18939 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fd10101-63ef-448e-a052-0c7a9ee2e6dd'
);


-- None 연가곡집 <Federico's Little Songs for Children>

UPDATE pieces piece
SET piece.title = '연가곡집 <Federico''s Little Songs for Children>', piece.title_en = 'Federico''s Little Songs for Children',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17056 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'La señorita del abanico', part.name_en = 'Federico''s Little Songs for Children: I. La señorita del abanico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17056 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:1e184976-1c4c-4b97-8346-6453533098c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e184976-1c4c-4b97-8346-6453533098c4', 1, 'I', 'La señorita del abanico', 'Federico''s Little Songs for Children: I. La señorita del abanico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17056 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e184976-1c4c-4b97-8346-6453533098c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'La tarde', part.name_en = 'Federico''s Little Songs for Children: II. La tarde',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17056 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:7c737126-d53a-4846-9d8e-72b5d9f5b530' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c737126-d53a-4846-9d8e-72b5d9f5b530', 2, 'II', 'La tarde', 'Federico''s Little Songs for Children: II. La tarde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17056 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c737126-d53a-4846-9d8e-72b5d9f5b530'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Canción cantada', part.name_en = 'Federico''s Little Songs for Children: III. Canción cantada',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17056 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:71ef5228-66fd-42a5-b220-cb26d22e968e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71ef5228-66fd-42a5-b220-cb26d22e968e', 3, 'III', 'Canción cantada', 'Federico''s Little Songs for Children: III. Canción cantada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17056 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71ef5228-66fd-42a5-b220-cb26d22e968e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Caracola', part.name_en = 'Federico''s Little Songs for Children: IV. Caracola',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17056 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:89af34a0-82df-46ba-ad82-152645a5a72a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89af34a0-82df-46ba-ad82-152645a5a72a', 4, 'IV', 'Caracola', 'Federico''s Little Songs for Children: IV. Caracola', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17056 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89af34a0-82df-46ba-ad82-152645a5a72a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '¡El lagarto está llorando!', part.name_en = 'Federico''s Little Songs for Children: V. ¡El lagarto está llorando!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17056 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:3f6028d1-07db-4cad-acee-77f22b0d3aa7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f6028d1-07db-4cad-acee-77f22b0d3aa7', 5, 'V', '¡El lagarto está llorando!', 'Federico''s Little Songs for Children: V. ¡El lagarto está llorando!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17056 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f6028d1-07db-4cad-acee-77f22b0d3aa7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Cancioncilla sevillana', part.name_en = 'Federico''s Little Songs for Children: VI. Cancioncilla sevillana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17056 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:1391677b-75dd-43ff-b612-56e9bea433b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1391677b-75dd-43ff-b612-56e9bea433b6', 6, 'VI', 'Cancioncilla sevillana', 'Federico''s Little Songs for Children: VI. Cancioncilla sevillana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17056 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1391677b-75dd-43ff-b612-56e9bea433b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Canción tonta', part.name_en = 'Federico''s Little Songs for Children: VII. Canción tonta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17056 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:18a76f03-65d9-4224-874f-2959a75e9aba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18a76f03-65d9-4224-874f-2959a75e9aba', 7, 'VII', 'Canción tonta', 'Federico''s Little Songs for Children: VII. Canción tonta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17056 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18a76f03-65d9-4224-874f-2959a75e9aba'
);


-- None 5개의 피아노 소품

UPDATE pieces piece
SET piece.title = '5개의 피아노 소품', piece.title_en = 'Five Pieces for Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19892 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Five Pieces for Piano: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19892 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:95fc8a20-3e43-4e01-a8ae-3f9bc32f4e55' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95fc8a20-3e43-4e01-a8ae-3f9bc32f4e55', 1, NULL, 'I', 'Five Pieces for Piano: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19892 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95fc8a20-3e43-4e01-a8ae-3f9bc32f4e55'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Five Pieces for Piano: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19892 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:572c88e0-0a18-4ad3-aa68-3df771576626' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:572c88e0-0a18-4ad3-aa68-3df771576626', 2, NULL, 'II', 'Five Pieces for Piano: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19892 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:572c88e0-0a18-4ad3-aa68-3df771576626'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Five Pieces for Piano: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19892 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:d57ef36c-ec48-4202-9d44-8abdf594a5d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d57ef36c-ec48-4202-9d44-8abdf594a5d8', 3, NULL, 'III', 'Five Pieces for Piano: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19892 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d57ef36c-ec48-4202-9d44-8abdf594a5d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Five Pieces for Piano: IV.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19892 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:295e349c-67bc-40da-8f31-00b7bd5759dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:295e349c-67bc-40da-8f31-00b7bd5759dc', 4, NULL, 'IV', 'Five Pieces for Piano: IV.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19892 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:295e349c-67bc-40da-8f31-00b7bd5759dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'V', part.name_en = 'Five Pieces for Piano: V.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19892 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:be611e25-fa74-4572-9600-5a6d8f32b52f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be611e25-fa74-4572-9600-5a6d8f32b52f', 5, NULL, 'V', 'Five Pieces for Piano: V.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19892 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be611e25-fa74-4572-9600-5a6d8f32b52f'
);


-- None 4개의 녹턴

UPDATE pieces piece
SET piece.title = '4개의 녹턴', piece.title_en = 'Four Nocturnes (Night Music II)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20096 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Serenamente', part.name_en = 'Four Nocturnes (Night Music II): I. Serenamente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20096 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:a263fa40-81f6-4ce5-9398-fd6a0739c0b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a263fa40-81f6-4ce5-9398-fd6a0739c0b9', 1, 'I', 'Serenamente', 'Four Nocturnes (Night Music II): I. Serenamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20096 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a263fa40-81f6-4ce5-9398-fd6a0739c0b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scorrevole, vivace possibile', part.name_en = 'Four Nocturnes (Night Music II): II. Scorrevole, vivace possibile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20096 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:a1333488-a37a-45a2-a19c-58b3ea4d15bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1333488-a37a-45a2-a19c-58b3ea4d15bf', 2, 'II', 'Scorrevole, vivace possibile', 'Four Nocturnes (Night Music II): II. Scorrevole, vivace possibile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20096 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1333488-a37a-45a2-a19c-58b3ea4d15bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Contemplativo', part.name_en = 'Four Nocturnes (Night Music II): III. Contemplativo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20096 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:c6c9b0fe-1ddf-4722-8bdb-0f515a707244' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6c9b0fe-1ddf-4722-8bdb-0f515a707244', 3, 'III', 'Contemplativo', 'Four Nocturnes (Night Music II): III. Contemplativo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20096 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6c9b0fe-1ddf-4722-8bdb-0f515a707244'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Con un sentimento di nostalgia', part.name_en = 'Four Nocturnes (Night Music II): IV. Con un sentimento di nostalgia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20096 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:041cdcb9-d189-43c7-90c1-1d54bf4f39b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:041cdcb9-d189-43c7-90c1-1d54bf4f39b6', 4, 'IV', 'Con un sentimento di nostalgia', 'Four Nocturnes (Night Music II): IV. Con un sentimento di nostalgia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20096 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:041cdcb9-d189-43c7-90c1-1d54bf4f39b6'
);


-- None Gnomic Variations

UPDATE pieces piece
SET piece.title = 'Gnomic Variations', piece.title_en = 'Gnomic Variations',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16717 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lux Aeterna

UPDATE pieces piece
SET piece.title = 'Lux Aeterna', piece.title_en = 'Lux Aeterna',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20036 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Madrigals, Books I-IV

UPDATE pieces piece
SET piece.title = 'Madrigals, Books I-IV', piece.title_en = 'Madrigals, Books I-IV',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18287 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Madrigals, Book I', part.name_en = 'Madrigals, Book I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18287 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:4d438fad-ea37-42ce-a074-df44a66cb60c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d438fad-ea37-42ce-a074-df44a66cb60c', 1, NULL, 'Madrigals, Book I', 'Madrigals, Book I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18287 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d438fad-ea37-42ce-a074-df44a66cb60c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d438fad-ea37-42ce-a074-df44a66cb60c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Verte desnuda es recordar la tierra', part.name_en = 'Madrigals, Book I: No. 1. Verte desnuda es recordar la tierra',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18287 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:b530cb3f-c153-4dd8-8d0f-c17b46e4689d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b530cb3f-c153-4dd8-8d0f-c17b46e4689d', 1, NULL, 'Verte desnuda es recordar la tierra', 'Madrigals, Book I: No. 1. Verte desnuda es recordar la tierra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d438fad-ea37-42ce-a074-df44a66cb60c'
WHERE p.id = 18287 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b530cb3f-c153-4dd8-8d0f-c17b46e4689d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d438fad-ea37-42ce-a074-df44a66cb60c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No piensan en la lluvia, y se han dormido', part.name_en = 'Madrigals, Book I: No. 2. No piensan en la lluvia, y se han dormido',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18287 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:84e7ccb8-afd9-4953-9421-ca39a9834e80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:84e7ccb8-afd9-4953-9421-ca39a9834e80', 2, NULL, 'No piensan en la lluvia, y se han dormido', 'Madrigals, Book I: No. 2. No piensan en la lluvia, y se han dormido', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d438fad-ea37-42ce-a074-df44a66cb60c'
WHERE p.id = 18287 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84e7ccb8-afd9-4953-9421-ca39a9834e80'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d438fad-ea37-42ce-a074-df44a66cb60c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Los muertos llevan alas de musgo', part.name_en = 'Madrigals, Book I: No. 3. Los muertos llevan alas de musgo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18287 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:4952529d-171d-4628-81d0-b8c31dca0b8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4952529d-171d-4628-81d0-b8c31dca0b8a', 3, NULL, 'Los muertos llevan alas de musgo', 'Madrigals, Book I: No. 3. Los muertos llevan alas de musgo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d438fad-ea37-42ce-a074-df44a66cb60c'
WHERE p.id = 18287 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4952529d-171d-4628-81d0-b8c31dca0b8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Madrigals, Book II', part.name_en = 'Madrigals, Book II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18287 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:48bf7469-d341-4d5f-87d0-e2a152fa7fd7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48bf7469-d341-4d5f-87d0-e2a152fa7fd7', 2, NULL, 'Madrigals, Book II', 'Madrigals, Book II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18287 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48bf7469-d341-4d5f-87d0-e2a152fa7fd7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48bf7469-d341-4d5f-87d0-e2a152fa7fd7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Bebe el agua tranquila de la canción añeja', part.name_en = 'Madrigals, Book II: No. 1. Bebe el agua tranquila de la canción añeja',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18287 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:761d34cd-e341-4294-bc81-350e1361dd5f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:761d34cd-e341-4294-bc81-350e1361dd5f', 1, NULL, 'Bebe el agua tranquila de la canción añeja', 'Madrigals, Book II: No. 1. Bebe el agua tranquila de la canción añeja', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48bf7469-d341-4d5f-87d0-e2a152fa7fd7'
WHERE p.id = 18287 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:761d34cd-e341-4294-bc81-350e1361dd5f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48bf7469-d341-4d5f-87d0-e2a152fa7fd7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'La muerte entra y sale de la taberna', part.name_en = 'Madrigals, Book II: No. 2. La muerte entra y sale de la taberna',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18287 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:9a9324e1-eedc-4dee-941b-987a1ada9ca8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9a9324e1-eedc-4dee-941b-987a1ada9ca8', 2, NULL, 'La muerte entra y sale de la taberna', 'Madrigals, Book II: No. 2. La muerte entra y sale de la taberna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48bf7469-d341-4d5f-87d0-e2a152fa7fd7'
WHERE p.id = 18287 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a9324e1-eedc-4dee-941b-987a1ada9ca8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48bf7469-d341-4d5f-87d0-e2a152fa7fd7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Caballito negro Donde llevas tu jinete muerto?', part.name_en = 'Madrigals, Book II: No. 3. Caballito negro Donde llevas tu jinete muerto?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18287 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:ae8b01aa-9538-4721-be89-d6655a422afe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ae8b01aa-9538-4721-be89-d6655a422afe', 3, NULL, 'Caballito negro Donde llevas tu jinete muerto?', 'Madrigals, Book II: No. 3. Caballito negro Donde llevas tu jinete muerto?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:48bf7469-d341-4d5f-87d0-e2a152fa7fd7'
WHERE p.id = 18287 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae8b01aa-9538-4721-be89-d6655a422afe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Madrigals, Book III', part.name_en = 'Madrigals, Book III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18287 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:445dbbbe-fc06-46dd-83eb-cfe081b90fbd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:445dbbbe-fc06-46dd-83eb-cfe081b90fbd', 3, NULL, 'Madrigals, Book III', 'Madrigals, Book III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18287 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:445dbbbe-fc06-46dd-83eb-cfe081b90fbd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:445dbbbe-fc06-46dd-83eb-cfe081b90fbd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La noche canta desnuda sobre los puentes de marzo', part.name_en = 'Madrigals, Book III: No. 1. La noche canta desnuda sobre los puentes de marzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18287 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:c4eab155-ff45-49c0-ab54-c473c1b091d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c4eab155-ff45-49c0-ab54-c473c1b091d7', 1, NULL, 'La noche canta desnuda sobre los puentes de marzo', 'Madrigals, Book III: No. 1. La noche canta desnuda sobre los puentes de marzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:445dbbbe-fc06-46dd-83eb-cfe081b90fbd'
WHERE p.id = 18287 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4eab155-ff45-49c0-ab54-c473c1b091d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:445dbbbe-fc06-46dd-83eb-cfe081b90fbd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Quiero dormir el sueño de las manzanas', part.name_en = 'Madrigals, Book III: No. 2. Quiero dormir el sueño de las manzanas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18287 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:bcb35289-9fb5-4c73-bdf4-5cffa7cfb440' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bcb35289-9fb5-4c73-bdf4-5cffa7cfb440', 2, NULL, 'Quiero dormir el sueño de las manzanas', 'Madrigals, Book III: No. 2. Quiero dormir el sueño de las manzanas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:445dbbbe-fc06-46dd-83eb-cfe081b90fbd'
WHERE p.id = 18287 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcb35289-9fb5-4c73-bdf4-5cffa7cfb440'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Madrigals, Book IV', part.name_en = 'Madrigals, Book IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18287 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:20d47511-09e4-43d2-a54e-ae980a4596fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20d47511-09e4-43d2-a54e-ae980a4596fd', 4, NULL, 'Madrigals, Book IV', 'Madrigals, Book IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18287 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20d47511-09e4-43d2-a54e-ae980a4596fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:20d47511-09e4-43d2-a54e-ae980a4596fd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Por qué nací entre espejos?', part.name_en = 'Madrigals, Book IV: No. 1. Por qué nací entre espejos?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18287 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:5e52faaf-f4f3-4560-ac50-ab7abe0b7cb9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5e52faaf-f4f3-4560-ac50-ab7abe0b7cb9', 1, NULL, 'Por qué nací entre espejos?', 'Madrigals, Book IV: No. 1. Por qué nací entre espejos?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:20d47511-09e4-43d2-a54e-ae980a4596fd'
WHERE p.id = 18287 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e52faaf-f4f3-4560-ac50-ab7abe0b7cb9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:20d47511-09e4-43d2-a54e-ae980a4596fd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tu cuerpo, con la sombra violeta de mis manos, era un arcángel de frío', part.name_en = 'Madrigals, Book IV: No. 2. Tu cuerpo, con la sombra violeta de mis manos, era un arcángel de frío',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18287 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:8cfba017-9da8-4ce2-8262-5f0f4cf35946' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8cfba017-9da8-4ce2-8262-5f0f4cf35946', 2, NULL, 'Tu cuerpo, con la sombra violeta de mis manos, era un arcángel de frío', 'Madrigals, Book IV: No. 2. Tu cuerpo, con la sombra violeta de mis manos, era un arcángel de frío', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:20d47511-09e4-43d2-a54e-ae980a4596fd'
WHERE p.id = 18287 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cfba017-9da8-4ce2-8262-5f0f4cf35946'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:20d47511-09e4-43d2-a54e-ae980a4596fd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La muerte me está mirando desde las torres de Córdoba!', part.name_en = 'Madrigals, Book IV: No. 3. La muerte me está mirando desde las torres de Córdoba!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18287 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:22e9244f-7dbf-419c-a413-82b157a2315b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:22e9244f-7dbf-419c-a413-82b157a2315b', 3, NULL, 'La muerte me está mirando desde las torres de Córdoba!', 'Madrigals, Book IV: No. 3. La muerte me está mirando desde las torres de Córdoba!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:20d47511-09e4-43d2-a54e-ae980a4596fd'
WHERE p.id = 18287 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22e9244f-7dbf-419c-a413-82b157a2315b'
);


-- None Makrokosmos I

UPDATE pieces piece
SET piece.title = 'Makrokosmos I', piece.title_en = 'Makrokosmos I',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17538 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Primeval Sounds (Genesis I). Cancer', part.name_en = 'Makrokosmos I: I. Primeval Sounds (Genesis I). Cancer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17538 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:d638e8eb-e934-46dd-b3b7-9b41f62b04e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d638e8eb-e934-46dd-b3b7-9b41f62b04e7', 1, 'I', 'Primeval Sounds (Genesis I). Cancer', 'Makrokosmos I: I. Primeval Sounds (Genesis I). Cancer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17538 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d638e8eb-e934-46dd-b3b7-9b41f62b04e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Proteus. Pisces', part.name_en = 'Makrokosmos I: II. Proteus. Pisces',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17538 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:104aee85-b6cf-4d21-b953-776aaf28e3ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:104aee85-b6cf-4d21-b953-776aaf28e3ff', 2, 'II', 'Proteus. Pisces', 'Makrokosmos I: II. Proteus. Pisces', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17538 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:104aee85-b6cf-4d21-b953-776aaf28e3ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Pastorale (from the Kingdom of Atlantis, ca 10,000 BC). Taurus', part.name_en = 'Makrokosmos I: III. Pastorale (from the Kingdom of Atlantis, ca 10,000 BC). Taurus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17538 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:33aaa458-28ea-484b-adac-9e5d840bcb35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33aaa458-28ea-484b-adac-9e5d840bcb35', 3, 'III', 'Pastorale (from the Kingdom of Atlantis, ca 10,000 BC). Taurus', 'Makrokosmos I: III. Pastorale (from the Kingdom of Atlantis, ca 10,000 BC). Taurus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17538 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33aaa458-28ea-484b-adac-9e5d840bcb35'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Cruciforus (Symbol). Capricorn', part.name_en = 'Makrokosmos I: IV. Cruciforus (Symbol). Capricorn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17538 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:81a2332e-6f10-4405-b683-893e498bf70d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81a2332e-6f10-4405-b683-893e498bf70d', 4, 'IV', 'Cruciforus (Symbol). Capricorn', 'Makrokosmos I: IV. Cruciforus (Symbol). Capricorn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17538 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81a2332e-6f10-4405-b683-893e498bf70d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'The Phantom Gondolier. Scorpio', part.name_en = 'Makrokosmos I: V. The Phantom Gondolier. Scorpio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17538 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:5a526122-c86a-471f-88ed-3f625bf1fb53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a526122-c86a-471f-88ed-3f625bf1fb53', 5, 'V', 'The Phantom Gondolier. Scorpio', 'Makrokosmos I: V. The Phantom Gondolier. Scorpio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17538 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a526122-c86a-471f-88ed-3f625bf1fb53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Night Spell I. Sagittarius', part.name_en = 'Makrokosmos I: VI. Night Spell I. Sagittarius',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17538 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:57d784d2-9246-468a-ae03-b9890110862d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57d784d2-9246-468a-ae03-b9890110862d', 6, 'VI', 'Night Spell I. Sagittarius', 'Makrokosmos I: VI. Night Spell I. Sagittarius', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17538 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57d784d2-9246-468a-ae03-b9890110862d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Music of Shadows (for Aeolian Harp). Libra', part.name_en = 'Makrokosmos I: VII. Music of Shadows (for Aeolian Harp). Libra',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17538 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:68dab311-3a27-4d97-83c8-ddad4f71c57a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68dab311-3a27-4d97-83c8-ddad4f71c57a', 7, 'VII', 'Music of Shadows (for Aeolian Harp). Libra', 'Makrokosmos I: VII. Music of Shadows (for Aeolian Harp). Libra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17538 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68dab311-3a27-4d97-83c8-ddad4f71c57a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'The Magic Circle of Infinity (Moto perpetuo). Leo', part.name_en = 'Makrokosmos I: VIII. The Magic Circle of Infinity (Moto perpetuo). Leo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17538 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:4c9a1190-a3ff-46dc-9392-9c3c97a23127' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c9a1190-a3ff-46dc-9392-9c3c97a23127', 8, 'VIII', 'The Magic Circle of Infinity (Moto perpetuo). Leo', 'Makrokosmos I: VIII. The Magic Circle of Infinity (Moto perpetuo). Leo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17538 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c9a1190-a3ff-46dc-9392-9c3c97a23127'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'The Abyss of Time. Virgo', part.name_en = 'Makrokosmos I: IX. The Abyss of Time. Virgo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17538 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:29678528-6681-4897-bad3-3ce87e969726' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29678528-6681-4897-bad3-3ce87e969726', 9, 'IX', 'The Abyss of Time. Virgo', 'Makrokosmos I: IX. The Abyss of Time. Virgo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17538 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29678528-6681-4897-bad3-3ce87e969726'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Spring-Fire. Aries', part.name_en = 'Makrokosmos I: X. Spring-Fire. Aries',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17538 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:766d970e-7a3a-4992-8c60-82728960d872' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:766d970e-7a3a-4992-8c60-82728960d872', 10, 'X', 'Spring-Fire. Aries', 'Makrokosmos I: X. Spring-Fire. Aries', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17538 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:766d970e-7a3a-4992-8c60-82728960d872'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Dream Images (Love-Death Music). Gemini', part.name_en = 'Makrokosmos I: XI. Dream Images (Love-Death Music). Gemini',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17538 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:754a9928-3a55-4158-8938-f6b4a8348e18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:754a9928-3a55-4158-8938-f6b4a8348e18', 11, 'XI', 'Dream Images (Love-Death Music). Gemini', 'Makrokosmos I: XI. Dream Images (Love-Death Music). Gemini', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17538 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:754a9928-3a55-4158-8938-f6b4a8348e18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Spiral Galaxy (Symbol). Aquarius', part.name_en = 'Makrokosmos I: XII. Spiral Galaxy (Symbol). Aquarius',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17538 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:78f5ad87-4d05-4bb7-9789-ecb4fd46a987' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78f5ad87-4d05-4bb7-9789-ecb4fd46a987', 12, 'XII', 'Spiral Galaxy (Symbol). Aquarius', 'Makrokosmos I: XII. Spiral Galaxy (Symbol). Aquarius', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17538 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78f5ad87-4d05-4bb7-9789-ecb4fd46a987'
);


-- None Makrokosmos II

UPDATE pieces piece
SET piece.title = 'Makrokosmos II', piece.title_en = 'Makrokosmos II',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16547 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Morning Music (Genesis II). Cancer', part.name_en = 'Makrokosmos II: I. Morning Music (Genesis II). Cancer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16547 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:2e144a36-0d39-4c74-b5d3-79f6a931f19c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e144a36-0d39-4c74-b5d3-79f6a931f19c', 1, 'I', 'Morning Music (Genesis II). Cancer', 'Makrokosmos II: I. Morning Music (Genesis II). Cancer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16547 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e144a36-0d39-4c74-b5d3-79f6a931f19c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Mystic Chord. Sagittarius', part.name_en = 'Makrokosmos II: II. The Mystic Chord. Sagittarius',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16547 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:8b57458f-f1c7-453e-953c-080bbd0643d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b57458f-f1c7-453e-953c-080bbd0643d8', 2, 'II', 'The Mystic Chord. Sagittarius', 'Makrokosmos II: II. The Mystic Chord. Sagittarius', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16547 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b57458f-f1c7-453e-953c-080bbd0643d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rain-Death Variations. Pisces', part.name_en = 'Makrokosmos II: III. Rain-Death Variations. Pisces',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16547 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:56402676-87cb-442a-ad92-39606a65d449' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56402676-87cb-442a-ad92-39606a65d449', 3, 'III', 'Rain-Death Variations. Pisces', 'Makrokosmos II: III. Rain-Death Variations. Pisces', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16547 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56402676-87cb-442a-ad92-39606a65d449'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Twin Suns (Symbol). Gemini', part.name_en = 'Makrokosmos II: IV. Twin Suns (Symbol). Gemini',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16547 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:c5b9bdd1-fb34-47f5-b466-67a05f795a6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5b9bdd1-fb34-47f5-b466-67a05f795a6d', 4, 'IV', 'Twin Suns (Symbol). Gemini', 'Makrokosmos II: IV. Twin Suns (Symbol). Gemini', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16547 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5b9bdd1-fb34-47f5-b466-67a05f795a6d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Ghost-Nocturne. for the Druids of Stonehenge (Night Spell II). Virgo', part.name_en = 'Makrokosmos II: V. Ghost-Nocturne. for the Druids of Stonehenge (Night Spell II). Virgo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16547 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:0dc27961-1f5a-4498-88c3-a8bfe0bedbe5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0dc27961-1f5a-4498-88c3-a8bfe0bedbe5', 5, 'V', 'Ghost-Nocturne. for the Druids of Stonehenge (Night Spell II). Virgo', 'Makrokosmos II: V. Ghost-Nocturne. for the Druids of Stonehenge (Night Spell II). Virgo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16547 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0dc27961-1f5a-4498-88c3-a8bfe0bedbe5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Gargoyles. Taurus', part.name_en = 'Makrokosmos II: VI. Gargoyles. Taurus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16547 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:44871108-f9f4-4a95-b2a0-382f15338bf3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44871108-f9f4-4a95-b2a0-382f15338bf3', 6, 'VI', 'Gargoyles. Taurus', 'Makrokosmos II: VI. Gargoyles. Taurus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16547 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44871108-f9f4-4a95-b2a0-382f15338bf3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Tora! Tora! Tora! (Cadenza Apocalittica). Scorpio', part.name_en = 'Makrokosmos II: VII. Tora! Tora! Tora! (Cadenza Apocalittica). Scorpio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16547 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:f6f3f1e3-9461-40e6-a3be-d87995b39d5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6f3f1e3-9461-40e6-a3be-d87995b39d5a', 7, 'VII', 'Tora! Tora! Tora! (Cadenza Apocalittica). Scorpio', 'Makrokosmos II: VII. Tora! Tora! Tora! (Cadenza Apocalittica). Scorpio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16547 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6f3f1e3-9461-40e6-a3be-d87995b39d5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'A Prophecy of the Nostradamus (Symbol). Aries', part.name_en = 'Makrokosmos II: VIII. A Prophecy of the Nostradamus (Symbol). Aries',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16547 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:423eac9f-6a7d-4eb5-8901-1c2c9b0cb755' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:423eac9f-6a7d-4eb5-8901-1c2c9b0cb755', 8, 'VIII', 'A Prophecy of the Nostradamus (Symbol). Aries', 'Makrokosmos II: VIII. A Prophecy of the Nostradamus (Symbol). Aries', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16547 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:423eac9f-6a7d-4eb5-8901-1c2c9b0cb755'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Cosmic Wind. Libra', part.name_en = 'Makrokosmos II: IX. Cosmic Wind. Libra',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16547 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:2c9b0543-43a9-456c-82c0-7b3e9d62255f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c9b0543-43a9-456c-82c0-7b3e9d62255f', 9, 'IX', 'Cosmic Wind. Libra', 'Makrokosmos II: IX. Cosmic Wind. Libra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16547 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c9b0543-43a9-456c-82c0-7b3e9d62255f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Voices from the "Corona Borealis". Aquarius', part.name_en = 'Makrokosmos II: X. Voices from the "Corona Borealis". Aquarius',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16547 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:6716567f-1036-47f0-9ddc-4b878aca2a69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6716567f-1036-47f0-9ddc-4b878aca2a69', 10, 'X', 'Voices from the "Corona Borealis". Aquarius', 'Makrokosmos II: X. Voices from the "Corona Borealis". Aquarius', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16547 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6716567f-1036-47f0-9ddc-4b878aca2a69'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Litany of the Galactic Bells. Leo', part.name_en = 'Makrokosmos II: XI. Litany of the Galactic Bells. Leo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16547 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:adf66fe6-8ced-4936-b51f-0eca72e90e05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:adf66fe6-8ced-4936-b51f-0eca72e90e05', 11, 'XI', 'Litany of the Galactic Bells. Leo', 'Makrokosmos II: XI. Litany of the Galactic Bells. Leo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16547 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adf66fe6-8ced-4936-b51f-0eca72e90e05'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Agnus Dei (Symbol). Capricorn', part.name_en = 'Makrokosmos II: XII. Agnus Dei (Symbol). Capricorn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16547 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:018a373d-5802-48b0-9b0a-a1a5e1bd22a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:018a373d-5802-48b0-9b0a-a1a5e1bd22a8', 12, 'XII', 'Agnus Dei (Symbol). Capricorn', 'Makrokosmos II: XII. Agnus Dei (Symbol). Capricorn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16547 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:018a373d-5802-48b0-9b0a-a1a5e1bd22a8'
);


-- None Metamorphoses, Book I

UPDATE pieces piece
SET piece.title = 'Metamorphoses, Book I', piece.title_en = 'Metamorphoses, Book I',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18509 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Black Prince (Paul Klee)', part.name_en = 'Metamorphoses, Book I: I. Black Prince (Paul Klee)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18509 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:77a2a360-460c-4aae-be12-bf987993aa94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77a2a360-460c-4aae-be12-bf987993aa94', 1, 'I', 'Black Prince (Paul Klee)', 'Metamorphoses, Book I: I. Black Prince (Paul Klee)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18509 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77a2a360-460c-4aae-be12-bf987993aa94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Goldfish (Paul Klee)', part.name_en = 'Metamorphoses, Book I: II. Goldfish (Paul Klee)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18509 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:66cc58e6-ad79-4520-84c7-02d34bd6edd2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66cc58e6-ad79-4520-84c7-02d34bd6edd2', 2, 'II', 'Goldfish (Paul Klee)', 'Metamorphoses, Book I: II. Goldfish (Paul Klee)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18509 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66cc58e6-ad79-4520-84c7-02d34bd6edd2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Crows Over the Wheatfield (Vincent van Gogh)', part.name_en = 'Metamorphoses, Book I: III. Crows Over the Wheatfield (Vincent van Gogh)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18509 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:dd76748e-7188-46ea-9d9a-a31699881674' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd76748e-7188-46ea-9d9a-a31699881674', 3, 'III', 'Crows Over the Wheatfield (Vincent van Gogh)', 'Metamorphoses, Book I: III. Crows Over the Wheatfield (Vincent van Gogh)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18509 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd76748e-7188-46ea-9d9a-a31699881674'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'The Fiddler (Marc Chagall)', part.name_en = 'Metamorphoses, Book I: IV. The Fiddler (Marc Chagall)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18509 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:c7c29db1-30ac-46a4-8a0e-75a3c257d46d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7c29db1-30ac-46a4-8a0e-75a3c257d46d', 4, 'IV', 'The Fiddler (Marc Chagall)', 'Metamorphoses, Book I: IV. The Fiddler (Marc Chagall)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18509 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7c29db1-30ac-46a4-8a0e-75a3c257d46d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Nocturne. Blue and Gold by Southampton Water (James McNeill Whistler)', part.name_en = 'Metamorphoses, Book I: V. Nocturne. Blue and Gold by Southampton Water (James McNeill Whistler)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18509 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:0d95f179-f46d-4fee-bf20-148dff971de2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d95f179-f46d-4fee-bf20-148dff971de2', 5, 'V', 'Nocturne. Blue and Gold by Southampton Water (James McNeill Whistler)', 'Metamorphoses, Book I: V. Nocturne. Blue and Gold by Southampton Water (James McNeill Whistler)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18509 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d95f179-f46d-4fee-bf20-148dff971de2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Perilous Night (Jasper Johns)', part.name_en = 'Metamorphoses, Book I: VI. Perilous Night (Jasper Johns)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18509 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:3831eecf-cde5-4dd1-ace5-7b9336ad0e0a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3831eecf-cde5-4dd1-ace5-7b9336ad0e0a', 6, 'VI', 'Perilous Night (Jasper Johns)', 'Metamorphoses, Book I: VI. Perilous Night (Jasper Johns)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18509 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3831eecf-cde5-4dd1-ace5-7b9336ad0e0a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Clowns at Night (Marc Chagall)', part.name_en = 'Metamorphoses, Book I: VII. Clowns at Night (Marc Chagall)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18509 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:67e12d72-085b-4ac4-9b64-1bc0b02da743' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67e12d72-085b-4ac4-9b64-1bc0b02da743', 7, 'VII', 'Clowns at Night (Marc Chagall)', 'Metamorphoses, Book I: VII. Clowns at Night (Marc Chagall)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18509 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67e12d72-085b-4ac4-9b64-1bc0b02da743'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Contes barbares (Paul Gauguin)', part.name_en = 'Metamorphoses, Book I: VIII. Contes barbares (Paul Gauguin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18509 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:50ccd687-a1c7-47d3-bb06-d3546a5c9680' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50ccd687-a1c7-47d3-bb06-d3546a5c9680', 8, 'VIII', 'Contes barbares (Paul Gauguin)', 'Metamorphoses, Book I: VIII. Contes barbares (Paul Gauguin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18509 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50ccd687-a1c7-47d3-bb06-d3546a5c9680'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'The Persistence of Memory (Salvador Dalí)', part.name_en = 'Metamorphoses, Book I: IX. The Persistence of Memory (Salvador Dalí)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18509 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:e139eee2-e995-4445-9b57-f1f3bfb455a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e139eee2-e995-4445-9b57-f1f3bfb455a6', 9, 'IX', 'The Persistence of Memory (Salvador Dalí)', 'Metamorphoses, Book I: IX. The Persistence of Memory (Salvador Dalí)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18509 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e139eee2-e995-4445-9b57-f1f3bfb455a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'The Blue Rider (Wassily Kandinsky)', part.name_en = 'Metamorphoses, Book I: X. The Blue Rider (Wassily Kandinsky)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18509 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:5a66d182-bbaa-4cc8-b209-6113153b119c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a66d182-bbaa-4cc8-b209-6113153b119c', 10, 'X', 'The Blue Rider (Wassily Kandinsky)', 'Metamorphoses, Book I: X. The Blue Rider (Wassily Kandinsky)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18509 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a66d182-bbaa-4cc8-b209-6113153b119c'
);


-- None Metamorphoses, Book II

UPDATE pieces piece
SET piece.title = 'Metamorphoses, Book II', piece.title_en = 'Metamorphoses, Book II',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17905 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ancient Sound, Abstract on Black (Paul Klee, 1925)', part.name_en = 'Metamorphoses, Book 2: No. 1. Ancient Sound, Abstract on Black (Paul Klee, 1925)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17905 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:d0fd5032-bba3-461f-897e-93066de46797' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0fd5032-bba3-461f-897e-93066de46797', 1, NULL, 'Ancient Sound, Abstract on Black (Paul Klee, 1925)', 'Metamorphoses, Book 2: No. 1. Ancient Sound, Abstract on Black (Paul Klee, 1925)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17905 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0fd5032-bba3-461f-897e-93066de46797'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Landscape with Yellow Birds (Paul Klee, 1923)', part.name_en = 'Metamorphoses, Book 2: No. 2. Landscape with Yellow Birds (Paul Klee, 1923)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17905 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:489c91da-f1a2-4be6-8068-e2c95c1fa336' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:489c91da-f1a2-4be6-8068-e2c95c1fa336', 2, NULL, 'Landscape with Yellow Birds (Paul Klee, 1923)', 'Metamorphoses, Book 2: No. 2. Landscape with Yellow Birds (Paul Klee, 1923)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17905 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:489c91da-f1a2-4be6-8068-e2c95c1fa336'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Christina''s World (Andrew Wyeth, 1948)', part.name_en = 'Metamorphoses, Book 2: No. 3. Christina''s World (Andrew Wyeth, 1948)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17905 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:1efce7bf-1c33-40b3-9cdd-77ce31afa200' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1efce7bf-1c33-40b3-9cdd-77ce31afa200', 3, NULL, 'Christina''s World (Andrew Wyeth, 1948)', 'Metamorphoses, Book 2: No. 3. Christina''s World (Andrew Wyeth, 1948)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17905 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1efce7bf-1c33-40b3-9cdd-77ce31afa200'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Purple Haze (Simon Dinnerstein, 1991)', part.name_en = 'Metamorphoses, Book 2: No. 4. Purple Haze (Simon Dinnerstein, 1991)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17905 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:0fc578b0-771e-4986-8fb7-76c0f0049890' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fc578b0-771e-4986-8fb7-76c0f0049890', 4, NULL, 'Purple Haze (Simon Dinnerstein, 1991)', 'Metamorphoses, Book 2: No. 4. Purple Haze (Simon Dinnerstein, 1991)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17905 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fc578b0-771e-4986-8fb7-76c0f0049890'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Portrait of Adele Bloch-Bauer (Lady in Gold) [Gustav Klimt, 1907]', part.name_en = 'Metamorphoses, Book 2: No. 5. Portrait of Adele Bloch-Bauer (Lady in Gold) [Gustav Klimt, 1907]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17905 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:f49b25ac-028b-41de-ac8b-4017230ecf54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f49b25ac-028b-41de-ac8b-4017230ecf54', 5, NULL, 'Portrait of Adele Bloch-Bauer (Lady in Gold) [Gustav Klimt, 1907]', 'Metamorphoses, Book 2: No. 5. Portrait of Adele Bloch-Bauer (Lady in Gold) [Gustav Klimt, 1907]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17905 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f49b25ac-028b-41de-ac8b-4017230ecf54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Spirit of the Dead Watching (Paul Gauguin, 1892)', part.name_en = 'Metamorphoses, Book 2: No. 6. Spirit of the Dead Watching (Paul Gauguin, 1892)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17905 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:a6629f4a-9425-4503-9afe-746c578099a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6629f4a-9425-4503-9afe-746c578099a7', 6, NULL, 'Spirit of the Dead Watching (Paul Gauguin, 1892)', 'Metamorphoses, Book 2: No. 6. Spirit of the Dead Watching (Paul Gauguin, 1892)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17905 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6629f4a-9425-4503-9afe-746c578099a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Guernica (Pablo Picasso, 1937)', part.name_en = 'Metamorphoses, Book 2: No. 7. Guernica (Pablo Picasso, 1937)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17905 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:5c097624-4ce8-4ef5-87b3-95bf0f65aaa7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c097624-4ce8-4ef5-87b3-95bf0f65aaa7', 7, NULL, 'Guernica (Pablo Picasso, 1937)', 'Metamorphoses, Book 2: No. 7. Guernica (Pablo Picasso, 1937)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17905 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c097624-4ce8-4ef5-87b3-95bf0f65aaa7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'From the Faraway, Nearby (Georgia O''Keeffe, 1937)', part.name_en = 'Metamorphoses, Book 2: No. 8. From the Faraway, Nearby (Georgia O''Keeffe, 1937)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17905 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:f257852c-024a-4099-89ec-507b514223bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f257852c-024a-4099-89ec-507b514223bf', 8, NULL, 'From the Faraway, Nearby (Georgia O''Keeffe, 1937)', 'Metamorphoses, Book 2: No. 8. From the Faraway, Nearby (Georgia O''Keeffe, 1937)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17905 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f257852c-024a-4099-89ec-507b514223bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Easter (Marc Chagall, 1968)', part.name_en = 'Metamorphoses, Book 2: No. 9. Easter (Marc Chagall, 1968)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17905 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:876baf61-4da5-4a76-9d77-81994eceefe3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:876baf61-4da5-4a76-9d77-81994eceefe3', 9, NULL, 'Easter (Marc Chagall, 1968)', 'Metamorphoses, Book 2: No. 9. Easter (Marc Chagall, 1968)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17905 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:876baf61-4da5-4a76-9d77-81994eceefe3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'The Starry Night (Vincent van Gogh, 1889)', part.name_en = 'Metamorphoses, Book 2: No. 10. The Starry Night (Vincent van Gogh, 1889)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17905 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:1040b700-4d7f-4d76-abbc-3375b1666131' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1040b700-4d7f-4d76-abbc-3375b1666131', 10, NULL, 'The Starry Night (Vincent van Gogh, 1889)', 'Metamorphoses, Book 2: No. 10. The Starry Night (Vincent van Gogh, 1889)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17905 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1040b700-4d7f-4d76-abbc-3375b1666131'
);


-- None Music for a Summer Evening (Makrokosmos III)

UPDATE pieces piece
SET piece.title = 'Music for a Summer Evening (Makrokosmos III)', piece.title_en = 'Music for a Summer Evening (Makrokosmos III)',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16157 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Nocturnal Sounds (The Awakening)', part.name_en = 'Music for a Summer Evening (Makrokosmos III): I. Nocturnal Sounds (The Awakening)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16157 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:a0b9ce1e-1220-4641-9ddb-f1c70a6f20d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0b9ce1e-1220-4641-9ddb-f1c70a6f20d5', 1, 'I', 'Nocturnal Sounds (The Awakening)', 'Music for a Summer Evening (Makrokosmos III): I. Nocturnal Sounds (The Awakening)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16157 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0b9ce1e-1220-4641-9ddb-f1c70a6f20d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Wanderer-Fantasie', part.name_en = 'Music for a Summer Evening (Makrokosmos III): II. Wanderer-Fantasie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16157 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:e22f2d1d-0918-42f7-894f-253863894380' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e22f2d1d-0918-42f7-894f-253863894380', 2, 'II', 'Wanderer-Fantasie', 'Music for a Summer Evening (Makrokosmos III): II. Wanderer-Fantasie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16157 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e22f2d1d-0918-42f7-894f-253863894380'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Advent', part.name_en = 'Music for a Summer Evening (Makrokosmos III): III. The Advent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16157 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:6f85bac8-d653-4378-acdb-ad4ca814f713' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f85bac8-d653-4378-acdb-ad4ca814f713', 3, 'III', 'The Advent', 'Music for a Summer Evening (Makrokosmos III): III. The Advent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16157 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f85bac8-d653-4378-acdb-ad4ca814f713'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Myth', part.name_en = 'Music for a Summer Evening (Makrokosmos III): IV. Myth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16157 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:bc2cb13c-a955-4bb8-8abc-94a90d978f95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc2cb13c-a955-4bb8-8abc-94a90d978f95', 4, 'IV', 'Myth', 'Music for a Summer Evening (Makrokosmos III): IV. Myth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16157 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc2cb13c-a955-4bb8-8abc-94a90d978f95'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Music of the Starry Night', part.name_en = 'Music for a Summer Evening (Makrokosmos III): V. Music of the Starry Night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16157 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:1fb29bd0-59b3-488c-a156-d294e6848bb7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fb29bd0-59b3-488c-a156-d294e6848bb7', 5, 'V', 'Music of the Starry Night', 'Music for a Summer Evening (Makrokosmos III): V. Music of the Starry Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16157 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fb29bd0-59b3-488c-a156-d294e6848bb7'
);


-- None Night Music I

UPDATE pieces piece
SET piece.title = 'Night Music I', piece.title_en = 'Night Music I',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17925 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Notturno I. Giocoso, estatico', part.name_en = 'Night Music I: Notturno I. Giocoso, estatico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17925 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:6f05328d-2e9a-4efb-81ee-41d73e470638' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f05328d-2e9a-4efb-81ee-41d73e470638', 1, NULL, 'Notturno I. Giocoso, estatico', 'Night Music I: Notturno I. Giocoso, estatico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17925 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f05328d-2e9a-4efb-81ee-41d73e470638'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Notturno II. Piccola serenata', part.name_en = 'Night Music I: Notturno II. Piccola serenata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17925 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:b9903f5f-b184-4106-beb7-b6780dcf6210' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9903f5f-b184-4106-beb7-b6780dcf6210', 2, NULL, 'Notturno II. Piccola serenata', 'Night Music I: Notturno II. Piccola serenata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17925 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9903f5f-b184-4106-beb7-b6780dcf6210'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Notturno III. La luna asoma', part.name_en = 'Night Music I: Notturno III. La luna asoma',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17925 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:be46740f-ef17-49db-865d-c5b56c691a8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be46740f-ef17-49db-865d-c5b56c691a8d', 3, NULL, 'Notturno III. La luna asoma', 'Night Music I: Notturno III. La luna asoma', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17925 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be46740f-ef17-49db-865d-c5b56c691a8d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Notturno IV. Vivace, molto ritmico', part.name_en = 'Night Music I: Notturno IV. Vivace, molto ritmico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17925 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:0999df7b-bebb-4680-8d1e-b0b88a59b75c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0999df7b-bebb-4680-8d1e-b0b88a59b75c', 4, NULL, 'Notturno IV. Vivace, molto ritmico', 'Night Music I: Notturno IV. Vivace, molto ritmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17925 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0999df7b-bebb-4680-8d1e-b0b88a59b75c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Notturno V. Gacela de la terrible presencia', part.name_en = 'Night Music I: Notturno V. Gacela de la terrible presencia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17925 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:501ab25b-de1e-4e12-b9be-7384feb2d583' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:501ab25b-de1e-4e12-b9be-7384feb2d583', 5, NULL, 'Notturno V. Gacela de la terrible presencia', 'Night Music I: Notturno V. Gacela de la terrible presencia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17925 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:501ab25b-de1e-4e12-b9be-7384feb2d583'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Notturno VI. Barcarola', part.name_en = 'Night Music I: Notturno VI. Barcarola',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17925 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:e7e0573b-e83c-429a-9765-ea58d93144c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7e0573b-e83c-429a-9765-ea58d93144c8', 6, NULL, 'Notturno VI. Barcarola', 'Night Music I: Notturno VI. Barcarola', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17925 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7e0573b-e83c-429a-9765-ea58d93144c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Notturno VII. Giocoso, estatico', part.name_en = 'Night Music I: Notturno VII. Giocoso, estatico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17925 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:8428585d-cf0e-4a06-9430-6e222adb60fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8428585d-cf0e-4a06-9430-6e222adb60fd', 7, NULL, 'Notturno VII. Giocoso, estatico', 'Night Music I: Notturno VII. Giocoso, estatico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17925 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8428585d-cf0e-4a06-9430-6e222adb60fd'
);


-- None Night of the Four Moons

UPDATE pieces piece
SET piece.title = 'Night of the Four Moons', piece.title_en = 'Night of the Four Moons',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18475 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'La luna está muerta, muerta', part.name_en = 'Night of the Four Moons: I. La luna está muerta, muerta...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18475 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:5a142d64-2896-43aa-a771-f3921b8dc764' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a142d64-2896-43aa-a771-f3921b8dc764', 1, 'I', 'La luna está muerta, muerta', 'Night of the Four Moons: I. La luna está muerta, muerta...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18475 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a142d64-2896-43aa-a771-f3921b8dc764'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Cuando sale la luna', part.name_en = 'Night of the Four Moons: II. Cuando sale la luna...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18475 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:11a4ee79-24a9-400a-a5d0-d904f492c507' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11a4ee79-24a9-400a-a5d0-d904f492c507', 2, 'II', 'Cuando sale la luna', 'Night of the Four Moons: II. Cuando sale la luna...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18475 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11a4ee79-24a9-400a-a5d0-d904f492c507'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Otro Adán oscuro está soñando', part.name_en = 'Night of the Four Moons: III. Otro Adán oscuro está soñando...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18475 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:78aecdb0-ba90-4204-b0fa-9373afc4d119' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78aecdb0-ba90-4204-b0fa-9373afc4d119', 3, 'III', 'Otro Adán oscuro está soñando', 'Night of the Four Moons: III. Otro Adán oscuro está soñando...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18475 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78aecdb0-ba90-4204-b0fa-9373afc4d119'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '¡Huye luna, luna, luna!', part.name_en = 'Night of the Four Moons: IV. ¡Huye luna, luna, luna!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18475 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:08b0ca9e-0e13-4161-aff2-8ee8422f0367' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08b0ca9e-0e13-4161-aff2-8ee8422f0367', 4, 'IV', '¡Huye luna, luna, luna!', 'Night of the Four Moons: IV. ¡Huye luna, luna, luna!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18475 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08b0ca9e-0e13-4161-aff2-8ee8422f0367'
);


-- None Otherworldly Resonances

UPDATE pieces piece
SET piece.title = 'Otherworldly Resonances', piece.title_en = 'Otherworldly Resonances',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16871 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pastoral Drone

UPDATE pieces piece
SET piece.title = 'Pastoral Drone', piece.title_en = 'Pastoral Drone',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16450 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Processional

UPDATE pieces piece
SET piece.title = 'Processional', piece.title_en = 'Processional',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17337 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 첼로 소나타

UPDATE pieces piece
SET piece.title = '첼로 소나타', piece.title_en = 'Sonata for Solo Cello',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16758 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Fantasia. Andante espressivo e con molto rubato', part.name_en = 'Sonata for Solo Cello: I. Fantasia. Andante espressivo e con molto rubato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16758 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:a68d9c32-e75a-4766-b093-7a60feb93467' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a68d9c32-e75a-4766-b093-7a60feb93467', 1, 'I', 'Fantasia. Andante espressivo e con molto rubato', 'Sonata for Solo Cello: I. Fantasia. Andante espressivo e con molto rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16758 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a68d9c32-e75a-4766-b093-7a60feb93467'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Tema pastorale con variazioni', part.name_en = 'Sonata for Solo Cello: II. Tema pastorale con variazioni',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16758 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:9af5e6e7-a680-4056-b162-2675289d2dac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9af5e6e7-a680-4056-b162-2675289d2dac', 2, 'II', 'Tema pastorale con variazioni', 'Sonata for Solo Cello: II. Tema pastorale con variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16758 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9af5e6e7-a680-4056-b162-2675289d2dac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Toccata. Largo e drammatico - Allegro vivace', part.name_en = 'Sonata for Solo Cello: III. Toccata. Largo e drammatico - Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16758 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:a63b5bbe-3fd7-4bd1-919f-9fd2369e1947' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a63b5bbe-3fd7-4bd1-919f-9fd2369e1947', 3, 'III', 'Toccata. Largo e drammatico - Allegro vivace', 'Sonata for Solo Cello: III. Toccata. Largo e drammatico - Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16758 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a63b5bbe-3fd7-4bd1-919f-9fd2369e1947'
);


-- None Songs, Drones and Refrains of Death

UPDATE pieces piece
SET piece.title = 'Songs, Drones and Refrains of Death', piece.title_en = 'Songs, Drones and Refrains of Death',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16839 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Refrain 1', part.name_en = 'Songs, Drones and Refrains of Death: Refrain 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16839 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:77521a1a-de9e-4932-9dcb-4784c05e15c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77521a1a-de9e-4932-9dcb-4784c05e15c4', 1, NULL, 'Refrain 1', 'Songs, Drones and Refrains of Death: Refrain 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16839 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77521a1a-de9e-4932-9dcb-4784c05e15c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'La guitarra', part.name_en = 'Songs, Drones and Refrains of Death: I. La guitarra',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16839 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:5ac3297b-4520-4a76-87b4-f61c333788e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ac3297b-4520-4a76-87b4-f61c333788e0', 2, NULL, 'La guitarra', 'Songs, Drones and Refrains of Death: I. La guitarra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16839 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ac3297b-4520-4a76-87b4-f61c333788e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Death-Drone I', part.name_en = 'Songs, Drones and Refrains of Death: Death-Drone I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16839 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:e715c6f9-a58c-44be-a8b0-87aa4053e39b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e715c6f9-a58c-44be-a8b0-87aa4053e39b', 3, NULL, 'Death-Drone I', 'Songs, Drones and Refrains of Death: Death-Drone I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16839 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e715c6f9-a58c-44be-a8b0-87aa4053e39b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Refrain 2', part.name_en = 'Songs, Drones and Refrains of Death: Refrain 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16839 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:fafbb7ab-2580-47fb-96ff-be8652780b03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fafbb7ab-2580-47fb-96ff-be8652780b03', 4, NULL, 'Refrain 2', 'Songs, Drones and Refrains of Death: Refrain 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16839 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fafbb7ab-2580-47fb-96ff-be8652780b03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Casida de las palomas oscuras', part.name_en = 'Songs, Drones and Refrains of Death: II. Casida de las palomas oscuras',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16839 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:c97370fb-9bfc-4495-86f0-9b6dbc9af3a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c97370fb-9bfc-4495-86f0-9b6dbc9af3a4', 5, NULL, 'Casida de las palomas oscuras', 'Songs, Drones and Refrains of Death: II. Casida de las palomas oscuras', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16839 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c97370fb-9bfc-4495-86f0-9b6dbc9af3a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Refrain 3', part.name_en = 'Songs, Drones and Refrains of Death: Refrain 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16839 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:54d1086c-98d2-4194-acf6-752ad46eb62a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54d1086c-98d2-4194-acf6-752ad46eb62a', 6, NULL, 'Refrain 3', 'Songs, Drones and Refrains of Death: Refrain 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16839 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54d1086c-98d2-4194-acf6-752ad46eb62a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Death-Drone II', part.name_en = 'Songs, Drones and Refrains of Death: Death-Drone II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16839 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:a6ab6711-ea2b-41d8-95eb-2a934387d0fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6ab6711-ea2b-41d8-95eb-2a934387d0fe', 7, NULL, 'Death-Drone II', 'Songs, Drones and Refrains of Death: Death-Drone II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16839 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6ab6711-ea2b-41d8-95eb-2a934387d0fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Canción de jinete, 1860', part.name_en = 'Songs, Drones and Refrains of Death: III. Canción de jinete, 1860',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16839 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:368f6b89-218c-487a-966c-5e560e8c1e16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:368f6b89-218c-487a-966c-5e560e8c1e16', 8, NULL, 'Canción de jinete, 1860', 'Songs, Drones and Refrains of Death: III. Canción de jinete, 1860', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16839 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:368f6b89-218c-487a-966c-5e560e8c1e16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Cadenza appassionata for 2 drummers', part.name_en = 'Songs, Drones and Refrains of Death: Cadenza appassionata for 2 drummers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16839 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:6d13cf28-8921-4979-941a-6cef03084e9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d13cf28-8921-4979-941a-6cef03084e9d', 9, NULL, 'Cadenza appassionata for 2 drummers', 'Songs, Drones and Refrains of Death: Cadenza appassionata for 2 drummers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16839 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d13cf28-8921-4979-941a-6cef03084e9d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Refrain 4', part.name_en = 'Songs, Drones and Refrains of Death: Refrain 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16839 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:5b0d4669-c8fe-4385-b165-c7f96a5a040f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b0d4669-c8fe-4385-b165-c7f96a5a040f', 10, NULL, 'Refrain 4', 'Songs, Drones and Refrains of Death: Refrain 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16839 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b0d4669-c8fe-4385-b165-c7f96a5a040f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Casida del herido por el agua', part.name_en = 'Songs, Drones and Refrains of Death: IV. Casida del herido por el agua',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16839 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:10c710f5-c673-41fb-b417-b49959dd368c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10c710f5-c673-41fb-b417-b49959dd368c', 11, NULL, 'Casida del herido por el agua', 'Songs, Drones and Refrains of Death: IV. Casida del herido por el agua', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16839 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10c710f5-c673-41fb-b417-b49959dd368c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Death-Drone III', part.name_en = 'Songs, Drones and Refrains of Death: Death-Drone III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16839 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:06bd3473-bf57-4ce6-9f72-3d4de98ffdf0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06bd3473-bf57-4ce6-9f72-3d4de98ffdf0', 12, NULL, 'Death-Drone III', 'Songs, Drones and Refrains of Death: Death-Drone III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16839 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06bd3473-bf57-4ce6-9f72-3d4de98ffdf0'
);


-- None Star-Child

UPDATE pieces piece
SET piece.title = 'Star-Child', piece.title_en = 'Star-Child',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18326 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Music of the Spheres', part.name_en = 'Star-Child: I. Music of the Spheres',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18326 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:a24fcb8d-449c-40c9-81fd-312558b5d5c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a24fcb8d-449c-40c9-81fd-312558b5d5c8', 1, 'I', 'Music of the Spheres', 'Star-Child: I. Music of the Spheres', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18326 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a24fcb8d-449c-40c9-81fd-312558b5d5c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Voice Crying in the Wilderness', part.name_en = 'Star-Child: II. Voice Crying in the Wilderness',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18326 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:6d7f54f7-4f6a-4558-88b8-6f8a6b50e001' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d7f54f7-4f6a-4558-88b8-6f8a6b50e001', 2, 'II', 'Voice Crying in the Wilderness', 'Star-Child: II. Voice Crying in the Wilderness', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18326 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d7f54f7-4f6a-4558-88b8-6f8a6b50e001'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Powers of Darkness Ascent', part.name_en = 'Star-Child: III. The Powers of Darkness Ascent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18326 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:57222621-42d5-4f9a-82bb-1674befe0846' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57222621-42d5-4f9a-82bb-1674befe0846', 3, 'III', 'The Powers of Darkness Ascent', 'Star-Child: III. The Powers of Darkness Ascent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18326 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57222621-42d5-4f9a-82bb-1674befe0846'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Music of the Apocalypse', part.name_en = 'Star-Child: IV. Music of the Apocalypse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18326 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:177c2e62-d18d-4dbc-a5ea-2d2bb651ddb6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:177c2e62-d18d-4dbc-a5ea-2d2bb651ddb6', 4, 'IV', 'Music of the Apocalypse', 'Star-Child: IV. Music of the Apocalypse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18326 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:177c2e62-d18d-4dbc-a5ea-2d2bb651ddb6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Advent of the Children''s Light', part.name_en = 'Star-Child: V. Advent of the Children''s Light',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18326 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:d8e9f187-df72-4a85-9234-77eec0d745f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8e9f187-df72-4a85-9234-77eec0d745f5', 5, 'V', 'Advent of the Children''s Light', 'Star-Child: V. Advent of the Children''s Light', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18326 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8e9f187-df72-4a85-9234-77eec0d745f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Hymn the New Age', part.name_en = 'Star-Child: VI. Hymn the New Age',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18326 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:3097c3d4-34f7-4b76-9313-bed4a8ff8233' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3097c3d4-34f7-4b76-9313-bed4a8ff8233', 6, 'VI', 'Hymn the New Age', 'Star-Child: VI. Hymn the New Age', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18326 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3097c3d4-34f7-4b76-9313-bed4a8ff8233'
);


-- None The River of Life

UPDATE pieces piece
SET piece.title = 'The River of Life', piece.title_en = 'The River of Life',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18120 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'IX',
    part.name_ko = 'Deep River', part.name_en = 'The River of Life: IX. Deep River',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18120 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:18548e9a-aaa6-4b5f-84ef-10f18fbd0513' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18548e9a-aaa6-4b5f-84ef-10f18fbd0513', 1, 'IX', 'Deep River', 'The River of Life: IX. Deep River', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18120 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18548e9a-aaa6-4b5f-84ef-10f18fbd0513'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'V',
    part.name_ko = 'Time Is a Drifting River: A Psalm for Daybreak and Morning', part.name_en = 'The River of Life: V. Time Is a Drifting River: A Psalm for Daybreak and Morning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18120 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:3a8df730-22a5-4e41-899a-d6996d0ab81e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a8df730-22a5-4e41-899a-d6996d0ab81e', 2, 'V', 'Time Is a Drifting River: A Psalm for Daybreak and Morning', 'The River of Life: V. Time Is a Drifting River: A Psalm for Daybreak and Morning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18120 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a8df730-22a5-4e41-899a-d6996d0ab81e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'I',
    part.name_ko = 'Shall We Gather At the River?', part.name_en = 'The River of Life: I. Shall We Gather At the River?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18120 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:4a0c2fd3-cbe5-41c5-a527-6d15930b0451' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a0c2fd3-cbe5-41c5-a527-6d15930b0451', 3, 'I', 'Shall We Gather At the River?', 'The River of Life: I. Shall We Gather At the River?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18120 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a0c2fd3-cbe5-41c5-a527-6d15930b0451'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'III',
    part.name_ko = 'Amazing Grace!', part.name_en = 'The River of Life: III. Amazing Grace!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18120 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:5f523216-a139-4dd0-bc4e-06bc42e84355' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f523216-a139-4dd0-bc4e-06bc42e84355', 4, 'III', 'Amazing Grace!', 'The River of Life: III. Amazing Grace!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18120 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f523216-a139-4dd0-bc4e-06bc42e84355'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'VI',
    part.name_ko = 'Were You There When They Crucified My Lord?', part.name_en = 'The River of Life: VI. Were You There When They Crucified My Lord?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18120 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:837324bc-a959-417d-a1fc-bcae55f66257' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:837324bc-a959-417d-a1fc-bcae55f66257', 5, 'VI', 'Were You There When They Crucified My Lord?', 'The River of Life: VI. Were You There When They Crucified My Lord?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18120 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:837324bc-a959-417d-a1fc-bcae55f66257'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VIII',
    part.name_ko = 'Nearer, My God to Thee', part.name_en = 'The River of Life: VIII. Nearer, My God to Thee',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18120 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:a2a29054-5b49-4d5b-89b7-0e4ef9fd667e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2a29054-5b49-4d5b-89b7-0e4ef9fd667e', 6, 'VIII', 'Nearer, My God to Thee', 'The River of Life: VIII. Nearer, My God to Thee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18120 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2a29054-5b49-4d5b-89b7-0e4ef9fd667e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'II',
    part.name_ko = 'Will There Be Any Stars In My Crown?', part.name_en = 'The River of Life: II. Will There Be Any Stars In My Crown?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18120 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:ba26c754-545e-4ca2-8410-88dd10f1b38f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba26c754-545e-4ca2-8410-88dd10f1b38f', 7, 'II', 'Will There Be Any Stars In My Crown?', 'The River of Life: II. Will There Be Any Stars In My Crown?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18120 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba26c754-545e-4ca2-8410-88dd10f1b38f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VII',
    part.name_ko = 'One More River to Cross ("Noah''s Ark" - a Humoresque)', part.name_en = 'The River of Life: VII. One More River to Cross ("Noah''s Ark" - a Humoresque)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18120 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:e81ca8eb-cc30-4778-981d-853747ba83c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e81ca8eb-cc30-4778-981d-853747ba83c4', 8, 'VII', 'One More River to Cross ("Noah''s Ark" - a Humoresque)', 'The River of Life: VII. One More River to Cross ("Noah''s Ark" - a Humoresque)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18120 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e81ca8eb-cc30-4778-981d-853747ba83c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IV',
    part.name_ko = 'Give Me That Old Time Religion', part.name_en = 'The River of Life: IV. Give Me That Old Time Religion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18120 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:eda4cc74-1413-4851-989d-2c0b8660b2dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eda4cc74-1413-4851-989d-2c0b8660b2dd', 9, 'IV', 'Give Me That Old Time Religion', 'The River of Life: IV. Give Me That Old Time Religion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18120 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eda4cc74-1413-4851-989d-2c0b8660b2dd'
);


-- None 가곡 <The Sleeper>

UPDATE pieces piece
SET piece.title = '가곡 <The Sleeper>', piece.title_en = 'The Sleeper',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16207 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Three Early Songs

UPDATE pieces piece
SET piece.title = 'Three Early Songs', piece.title_en = 'Three Early Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16203 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Night', part.name_en = 'Three Early Songs: No. 1. Night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16203 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:0459efdf-6b20-4a14-bcf0-f9f9ab674d97' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0459efdf-6b20-4a14-bcf0-f9f9ab674d97', 1, NULL, 'Night', 'Three Early Songs: No. 1. Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16203 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0459efdf-6b20-4a14-bcf0-f9f9ab674d97'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Let It Be Forgotten', part.name_en = 'Three Early Songs: No. 2. Let It Be Forgotten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16203 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:ff3a247f-1f73-499c-9c7b-28f59be84710' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff3a247f-1f73-499c-9c7b-28f59be84710', 2, NULL, 'Let It Be Forgotten', 'Three Early Songs: No. 2. Let It Be Forgotten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16203 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff3a247f-1f73-499c-9c7b-28f59be84710'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Wind Elegy', part.name_en = 'Three Early Songs: No. 3. Wind Elegy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16203 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:f1c6ebd3-e77b-4f76-abc8-07367afe7878' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1c6ebd3-e77b-4f76-abc8-07367afe7878', 3, NULL, 'Wind Elegy', 'Three Early Songs: No. 3. Wind Elegy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16203 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1c6ebd3-e77b-4f76-abc8-07367afe7878'
);


-- None Unto the Hills

UPDATE pieces piece
SET piece.title = 'Unto the Hills', piece.title_en = 'Unto the Hills',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16940 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'VI',
    part.name_ko = 'A) Down In the Valley B) Hush, Little Baby (An Appalachian Lullaby)', part.name_en = 'Unto the Hills: VI. A) Down In the Valley B) Hush, Little Baby (An Appalachian Lullaby)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16940 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:058da53a-c03c-4f75-b03e-809b9d3588bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:058da53a-c03c-4f75-b03e-809b9d3588bc', 1, 'VI', 'A) Down In the Valley B) Hush, Little Baby (An Appalachian Lullaby)', 'Unto the Hills: VI. A) Down In the Valley B) Hush, Little Baby (An Appalachian Lullaby)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16940 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:058da53a-c03c-4f75-b03e-809b9d3588bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'V',
    part.name_ko = 'Appalachian Epiphany: A Psalm for Sunset and Dusk', part.name_en = 'Unto the Hills: V. Appalachian Epiphany: A Psalm for Sunset and Dusk',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16940 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:13fb0368-9816-43db-9124-63a1e854897c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13fb0368-9816-43db-9124-63a1e854897c', 2, 'V', 'Appalachian Epiphany: A Psalm for Sunset and Dusk', 'Unto the Hills: V. Appalachian Epiphany: A Psalm for Sunset and Dusk', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16940 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13fb0368-9816-43db-9124-63a1e854897c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'VIII',
    part.name_ko = 'the Riddle', part.name_en = 'Unto the Hills: VIII. the Riddle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16940 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:4ec819ae-264b-47dc-846f-97923789ef33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ec819ae-264b-47dc-846f-97923789ef33', 3, 'VIII', 'the Riddle', 'Unto the Hills: VIII. the Riddle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16940 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ec819ae-264b-47dc-846f-97923789ef33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IX',
    part.name_ko = 'Poor Wayfaring Stranger (Echo)', part.name_en = 'Unto the Hills: IX. Poor Wayfaring Stranger (Echo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16940 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:54d400d3-f453-43d3-8851-6e5db385e4fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54d400d3-f453-43d3-8851-6e5db385e4fc', 4, 'IX', 'Poor Wayfaring Stranger (Echo)', 'Unto the Hills: IX. Poor Wayfaring Stranger (Echo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16940 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54d400d3-f453-43d3-8851-6e5db385e4fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'I',
    part.name_ko = 'Poor Wayfaring Stranger', part.name_en = 'Unto the Hills: I. Poor Wayfaring Stranger',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16940 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:85f8f241-2176-4408-9e94-1bb7442cb8d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85f8f241-2176-4408-9e94-1bb7442cb8d7', 5, 'I', 'Poor Wayfaring Stranger', 'Unto the Hills: I. Poor Wayfaring Stranger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16940 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85f8f241-2176-4408-9e94-1bb7442cb8d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'III',
    part.name_ko = 'Ten Thousand Miles', part.name_en = 'Unto the Hills: III. Ten Thousand Miles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16940 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:9bca0d8f-9ea6-4a79-8539-3aeb9b783756' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bca0d8f-9ea6-4a79-8539-3aeb9b783756', 6, 'III', 'Ten Thousand Miles', 'Unto the Hills: III. Ten Thousand Miles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16940 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bca0d8f-9ea6-4a79-8539-3aeb9b783756'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'II',
    part.name_ko = 'All the Pretty Little Horses (An Appalachian Lullaby)', part.name_en = 'Unto the Hills: II. All the Pretty Little Horses (An Appalachian Lullaby)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16940 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:c78ac846-5edd-4d06-a0ba-bc941b8b5f4f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c78ac846-5edd-4d06-a0ba-bc941b8b5f4f', 7, 'II', 'All the Pretty Little Horses (An Appalachian Lullaby)', 'Unto the Hills: II. All the Pretty Little Horses (An Appalachian Lullaby)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16940 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c78ac846-5edd-4d06-a0ba-bc941b8b5f4f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'IV',
    part.name_ko = 'Ev''ry Night When the Sun Goes In', part.name_en = 'Unto the Hills: IV. Ev''ry Night When the Sun Goes In',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16940 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:e2bc525d-dc32-41a9-8ce4-357a9d738f46' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2bc525d-dc32-41a9-8ce4-357a9d738f46', 8, 'IV', 'Ev''ry Night When the Sun Goes In', 'Unto the Hills: IV. Ev''ry Night When the Sun Goes In', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16940 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2bc525d-dc32-41a9-8ce4-357a9d738f46'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'VII',
    part.name_ko = 'Black, Black, Black Is the Color', part.name_en = 'Unto the Hills: VII. Black, Black, Black Is the Color',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16940 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:f0fd1f8f-30e3-4902-b7fe-daad2aac1b23' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0fd1f8f-30e3-4902-b7fe-daad2aac1b23', 9, 'VII', 'Black, Black, Black Is the Color', 'Unto the Hills: VII. Black, Black, Black Is the Color', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16940 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0fd1f8f-30e3-4902-b7fe-daad2aac1b23'
);


-- None Vox Balaenae

UPDATE pieces piece
SET piece.title = 'Vox Balaenae', piece.title_en = 'Vox Balaenae',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15775 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Vocalise (...for the beginning of time)', part.name_en = 'Vox Balaenae: I. Vocalise (...for the beginning of time)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15775 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:72997668-1cb7-4556-af48-61abca391c53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72997668-1cb7-4556-af48-61abca391c53', 1, 'I', 'Vocalise (...for the beginning of time)', 'Vox Balaenae: I. Vocalise (...for the beginning of time)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15775 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72997668-1cb7-4556-af48-61abca391c53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sea Theme', part.name_en = 'Vox Balaenae: II. Sea Theme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15775 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:d61f6b4a-a1c2-41d5-823d-12c336fbbd6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d61f6b4a-a1c2-41d5-823d-12c336fbbd6b', 2, 'II', 'Sea Theme', 'Vox Balaenae: II. Sea Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15775 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d61f6b4a-a1c2-41d5-823d-12c336fbbd6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Variation I: Archeozoic', part.name_en = 'Vox Balaenae: III. Variation I: Archeozoic',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15775 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:47547b89-468a-4768-8c70-94e0f884f7ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47547b89-468a-4768-8c70-94e0f884f7ff', 3, 'III', 'Variation I: Archeozoic', 'Vox Balaenae: III. Variation I: Archeozoic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15775 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47547b89-468a-4768-8c70-94e0f884f7ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Variation II: Proterozoic', part.name_en = 'Vox Balaenae: IV. Variation II: Proterozoic',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15775 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:ff088b2b-77f5-4a96-bc47-a3c0562c0a63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff088b2b-77f5-4a96-bc47-a3c0562c0a63', 4, 'IV', 'Variation II: Proterozoic', 'Vox Balaenae: IV. Variation II: Proterozoic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15775 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff088b2b-77f5-4a96-bc47-a3c0562c0a63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Variation III: Paleozoic', part.name_en = 'Vox Balaenae: V. Variation III: Paleozoic',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15775 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:355912e5-3e4b-4720-91f7-3b42e643f537' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:355912e5-3e4b-4720-91f7-3b42e643f537', 5, 'V', 'Variation III: Paleozoic', 'Vox Balaenae: V. Variation III: Paleozoic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15775 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:355912e5-3e4b-4720-91f7-3b42e643f537'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Variation IV: Mesozoic', part.name_en = 'Vox Balaenae: VI. Variation IV: Mesozoic',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15775 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:8f40648d-e7f5-4b09-897e-504e682c5d8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f40648d-e7f5-4b09-897e-504e682c5d8a', 6, 'VI', 'Variation IV: Mesozoic', 'Vox Balaenae: VI. Variation IV: Mesozoic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15775 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f40648d-e7f5-4b09-897e-504e682c5d8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Variation V: Cenozoic', part.name_en = 'Vox Balaenae: VII. Variation V: Cenozoic',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15775 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:125b5624-4abb-4ab4-b398-f43be330d362' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:125b5624-4abb-4ab4-b398-f43be330d362', 7, 'VII', 'Variation V: Cenozoic', 'Vox Balaenae: VII. Variation V: Cenozoic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15775 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:125b5624-4abb-4ab4-b398-f43be330d362'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Sea-Nocturne (...for the end of time)', part.name_en = 'Vox Balaenae: VIII. Sea-Nocturne (...for the end of time)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15775 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:cb68daf5-4e8b-46da-b1db-49def60baba1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb68daf5-4e8b-46da-b1db-49def60baba1', 8, 'VIII', 'Sea-Nocturne (...for the end of time)', 'Vox Balaenae: VIII. Sea-Nocturne (...for the end of time)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15775 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb68daf5-4e8b-46da-b1db-49def60baba1'
);


-- None Zeitgeist, tableaux vivants for two amplified pianos

UPDATE pieces piece
SET piece.title = 'Zeitgeist, tableaux vivants for two amplified pianos', piece.title_en = 'Zeitgeist, tableaux vivants for two amplified pianos',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17147 AND piece.composer_id = 191
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'IV: Day Of The Comet. Prestissimo', part.name_en = 'Zeitgeist, Six Tableau For Two Amplified Pianos, Book I: IV: Day Of The Comet. Prestissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17147 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:170700b6-c5fb-447e-a639-766ad1016588' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:170700b6-c5fb-447e-a639-766ad1016588', 1, NULL, 'IV: Day Of The Comet. Prestissimo', 'Zeitgeist, Six Tableau For Two Amplified Pianos, Book I: IV: Day Of The Comet. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17147 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:170700b6-c5fb-447e-a639-766ad1016588'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II: Two Harlequins. Vivace, Molto Capriccioso', part.name_en = 'Zeitgeist, Six Tableau For Two Amplified Pianos, Book I: II: Two Harlequins. Vivace, Molto Capriccioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17147 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:2e61488a-d9c9-4c9d-818d-58dda4edc6c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e61488a-d9c9-4c9d-818d-58dda4edc6c9', 2, NULL, 'II: Two Harlequins. Vivace, Molto Capriccioso', 'Zeitgeist, Six Tableau For Two Amplified Pianos, Book I: II: Two Harlequins. Vivace, Molto Capriccioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17147 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e61488a-d9c9-4c9d-818d-58dda4edc6c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III: Monochord. Lentamente, Misterioso', part.name_en = 'Zeitgeist, Six Tableau For Two Amplified Pianos, Book I: III: Monochord. Lentamente, Misterioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17147 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:3aabf457-99ab-4ec0-949f-d8f368e4fe2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3aabf457-99ab-4ec0-949f-d8f368e4fe2c', 3, NULL, 'III: Monochord. Lentamente, Misterioso', 'Zeitgeist, Six Tableau For Two Amplified Pianos, Book I: III: Monochord. Lentamente, Misterioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17147 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3aabf457-99ab-4ec0-949f-d8f368e4fe2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'I: Portent. Molto Moderato, Il Ritmo Ben Marcato', part.name_en = 'Zeitgeist, Six Tableau For Two Amplified Pianos, Book I: I: Portent. Molto Moderato, Il Ritmo Ben Marcato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17147 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:4120dbdb-d4ed-4eae-918d-737065d0b044' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4120dbdb-d4ed-4eae-918d-737065d0b044', 4, NULL, 'I: Portent. Molto Moderato, Il Ritmo Ben Marcato', 'Zeitgeist, Six Tableau For Two Amplified Pianos, Book I: I: Portent. Molto Moderato, Il Ritmo Ben Marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17147 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4120dbdb-d4ed-4eae-918d-737065d0b044'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'V: The Realm Of Morpheus ("…The Inner Eye Of Dreams"). Piano I-Lentamente, Quasi Lontano, Sognante. Piano II-Adagio, Sospeso, Misterioso', part.name_en = 'Zeitgeist, Six Tableau For Two Amplified Pianos, Book I: V: The Realm Of Morpheus ("…The Inner Eye Of Dreams"). Piano I-Lentamente, Quasi Lontano, Sognante. Piano II-Adagio, Sospeso, Misterioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17147 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:48436e44-7ddf-45b2-8b00-cd43c7a8659c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48436e44-7ddf-45b2-8b00-cd43c7a8659c', 5, NULL, 'V: The Realm Of Morpheus ("…The Inner Eye Of Dreams"). Piano I-Lentamente, Quasi Lontano, Sognante. Piano II-Adagio, Sospeso, Misterioso', 'Zeitgeist, Six Tableau For Two Amplified Pianos, Book I: V: The Realm Of Morpheus ("…The Inner Eye Of Dreams"). Piano I-Lentamente, Quasi Lontano, Sognante. Piano II-Adagio, Sospeso, Misterioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17147 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48436e44-7ddf-45b2-8b00-cd43c7a8659c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'VI: Reverberations. Molto Moderato, Il Ritmo Ben Marcato', part.name_en = 'Zeitgeist, Six Tableau For Two Amplified Pianos, Book I: VI: Reverberations. Molto Moderato, Il Ritmo Ben Marcato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17147 AND p.composer_id = 191 AND part.part_key = 'musicbrainz:dcf4c81e-0b17-4424-b0d2-3edbdd3558b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcf4c81e-0b17-4424-b0d2-3edbdd3558b4', 6, NULL, 'VI: Reverberations. Molto Moderato, Il Ritmo Ben Marcato', 'Zeitgeist, Six Tableau For Two Amplified Pianos, Book I: VI: Reverberations. Molto Moderato, Il Ritmo Ben Marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17147 AND p.composer_id = 191
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcf4c81e-0b17-4424-b0d2-3edbdd3558b4'
);


-- None Quest

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Quest', 'Quest', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 191
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Quest'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '74fdcc91-a171-4b59-be83-876158d2eed6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '74fdcc91-a171-4b59-be83-876158d2eed6'
FROM pieces p
WHERE p.composer_id = 191 AND p.title = 'Quest' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '74fdcc91-a171-4b59-be83-876158d2eed6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8bb0aa5-cc6f-4654-a72a-b64c100f1a20', 1, NULL, 'Refrain 1', 'Quest: Refrain 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = 'Quest' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8bb0aa5-cc6f-4654-a72a-b64c100f1a20'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6caefe6-f0cc-4d57-9cbe-28b1f0b3b828', 2, NULL, 'Dark Paths', 'Quest: I. Dark Paths', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = 'Quest' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6caefe6-f0cc-4d57-9cbe-28b1f0b3b828'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f93b2caa-ed1f-4492-b28e-cae12caa6016', 3, NULL, 'Fugitive Sounds', 'Quest: II. Fugitive Sounds', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = 'Quest' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f93b2caa-ed1f-4492-b28e-cae12caa6016'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73c11609-9f5f-4a7e-9de4-0054612b56e1', 4, NULL, 'Refrain 2', 'Quest: Refrain 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = 'Quest' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73c11609-9f5f-4a7e-9de4-0054612b56e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1d86489-e81d-4631-900f-e7ee55381890', 5, NULL, 'Forgotten Sounds', 'Quest: III. Forgotten Sounds', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = 'Quest' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1d86489-e81d-4631-900f-e7ee55381890'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88910928-82e0-47c9-b4fc-4a1a54adfb35', 6, NULL, 'Fugitive Sounds', 'Quest: IV. Fugitive Sounds', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = 'Quest' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88910928-82e0-47c9-b4fc-4a1a54adfb35'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:054354a4-3f9d-412d-a325-ab4acc256774', 7, NULL, 'Refrain 3', 'Quest: Refrain 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = 'Quest' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:054354a4-3f9d-412d-a325-ab4acc256774'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9e9f8e0-1a1e-4706-bc97-525f50668fd7', 8, NULL, 'Nocturnal', 'Quest: V. Nocturnal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 191 AND p.title = 'Quest' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9e9f8e0-1a1e-4706-bc97-525f50668fd7'
);


-- None Variazioni

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Variazioni', 'Variazioni', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 191
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Variazioni'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '04b14cfd-9b16-4602-8444-1f47a54022ef'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '04b14cfd-9b16-4602-8444-1f47a54022ef'
FROM pieces p
WHERE p.composer_id = 191 AND p.title = 'Variazioni' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '04b14cfd-9b16-4602-8444-1f47a54022ef'
);


-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 191 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    18436
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
