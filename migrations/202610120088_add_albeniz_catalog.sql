-- 알베니스 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 66개(묶음 17, 다악장 13, 낱곡 36),
-- 새 작품 8개, part 180개, 그 아래 0개.
-- seed 77개 중 58개를 작품·part 에 잇고, 14개를 숨기고, 5개는 그대로 둔다.
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
SET piece.title = 'Mallorca (편곡 8471)'
WHERE piece.id = 8471 AND piece.composer_id = 66 AND piece.title = 'Mallorca'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);


-- Op. 92 12 piezas características Op. 92

UPDATE pieces piece
SET piece.title = '12 piezas características Op. 92', piece.title_en = '12 piezas características, op. 92',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '92',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10865 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Gavotte sur un thème de Mlle Irene Landauer', part.name_en = '12 piezas características, op. 92, no. 1: Gavotte sur un thème de Mlle Irene Landauer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10865 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:2020ca89-e7e0-4d82-8bb8-580fa1061244' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2020ca89-e7e0-4d82-8bb8-580fa1061244', 1, NULL, 'Gavotte sur un thème de Mlle Irene Landauer', '12 piezas características, op. 92, no. 1: Gavotte sur un thème de Mlle Irene Landauer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10865 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2020ca89-e7e0-4d82-8bb8-580fa1061244'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Minuetto a Sylvia', part.name_en = '12 piezas características, op. 92, no. 2: Minuetto a Sylvia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10865 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:f33a6e42-4e0a-43da-87d3-43e180ea9e54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f33a6e42-4e0a-43da-87d3-43e180ea9e54', 2, NULL, 'Minuetto a Sylvia', '12 piezas características, op. 92, no. 2: Minuetto a Sylvia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10865 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f33a6e42-4e0a-43da-87d3-43e180ea9e54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Barcarola (Ciel sans nuages)', part.name_en = '12 piezas características, op. 92, no. 3: Barcarola (Ciel sans nuages)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10865 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:afcaf8d7-9205-4628-ae9b-012b40287c43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afcaf8d7-9205-4628-ae9b-012b40287c43', 3, NULL, 'Barcarola (Ciel sans nuages)', '12 piezas características, op. 92, no. 3: Barcarola (Ciel sans nuages)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10865 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afcaf8d7-9205-4628-ae9b-012b40287c43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Plegaria', part.name_en = '12 piezas características, op. 92, no. 4: Plegaria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10865 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:ba74d613-9dc3-4d21-8e19-72ef9601224c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba74d613-9dc3-4d21-8e19-72ef9601224c', 4, NULL, 'Plegaria', '12 piezas características, op. 92, no. 4: Plegaria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10865 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba74d613-9dc3-4d21-8e19-72ef9601224c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Conchita', part.name_en = '12 piezas características, op. 92, no. 5: Conchita',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10865 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:f9331908-3009-4708-ab83-51f124a2fec8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9331908-3009-4708-ab83-51f124a2fec8', 5, NULL, 'Conchita', '12 piezas características, op. 92, no. 5: Conchita', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10865 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9331908-3009-4708-ab83-51f124a2fec8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Pilar', part.name_en = '12 piezas características, op. 92, no. 6: Pilar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10865 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:56c862a0-eabb-4c7a-8f13-b64bca562b21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56c862a0-eabb-4c7a-8f13-b64bca562b21', 6, NULL, 'Pilar', '12 piezas características, op. 92, no. 6: Pilar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10865 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56c862a0-eabb-4c7a-8f13-b64bca562b21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Zambra', part.name_en = '12 piezas características, op. 92, no. 7: Zambra',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10865 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:88f6dec6-a56a-3bb7-9243-d0652747958d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88f6dec6-a56a-3bb7-9243-d0652747958d', 7, NULL, 'Zambra', '12 piezas características, op. 92, no. 7: Zambra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10865 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88f6dec6-a56a-3bb7-9243-d0652747958d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Pavana', part.name_en = '12 piezas características, op. 92, no. 8: Pavana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10865 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:09ff91f4-7121-4eb3-a465-ba806a9ab5f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09ff91f4-7121-4eb3-a465-ba806a9ab5f2', 8, NULL, 'Pavana', '12 piezas características, op. 92, no. 8: Pavana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10865 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09ff91f4-7121-4eb3-a465-ba806a9ab5f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Polonesa', part.name_en = '12 piezas características, op. 92, no. 9: Polonesa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10865 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:0ad0e7c0-aa81-4d18-88dc-20d559cb0b79' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ad0e7c0-aa81-4d18-88dc-20d559cb0b79', 9, NULL, 'Polonesa', '12 piezas características, op. 92, no. 9: Polonesa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10865 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ad0e7c0-aa81-4d18-88dc-20d559cb0b79'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Mazurka', part.name_en = '12 piezas características, op. 92, no. 10: Mazurka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10865 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:6e9df017-686f-431e-8a40-cecbed702828' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e9df017-686f-431e-8a40-cecbed702828', 10, NULL, 'Mazurka', '12 piezas características, op. 92, no. 10: Mazurka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10865 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e9df017-686f-431e-8a40-cecbed702828'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Staccato', part.name_en = '12 piezas características, op. 92, no. 11: Staccato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10865 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:105ff79e-0942-4887-830a-b6a7dc6e2c51' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:105ff79e-0942-4887-830a-b6a7dc6e2c51', 11, NULL, 'Staccato', '12 piezas características, op. 92, no. 11: Staccato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10865 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:105ff79e-0942-4887-830a-b6a7dc6e2c51'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Torre Bermeja', part.name_en = '12 piezas características, op. 92, no. 12: Torre Bermeja',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10865 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:011c507a-a2f9-35c4-879e-b64ddc9a4fa3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:011c507a-a2f9-35c4-879e-b64ddc9a4fa3', 12, NULL, 'Torre Bermeja', '12 piezas características, op. 92, no. 12: Torre Bermeja', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10865 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:011c507a-a2f9-35c4-879e-b64ddc9a4fa3'
);


-- Op. 164 2 Spanish National Songs Op. 164

UPDATE pieces piece
SET piece.title = '2 Spanish National Songs Op. 164', piece.title_en = '2 Spanish National Songs, op. 164',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '164',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10627 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Jota aragonesa', part.name_en = '2 Spanish National Songs, op. 164, no. 1: Jota aragonesa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10627 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:30555c73-a450-4816-8e36-d1b166a0c0b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30555c73-a450-4816-8e36-d1b166a0c0b0', 1, NULL, 'Jota aragonesa', '2 Spanish National Songs, op. 164, no. 1: Jota aragonesa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10627 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30555c73-a450-4816-8e36-d1b166a0c0b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = '2 Spanish National Songs, op. 164, no. 2: Tango in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10627 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:24e51553-7f1d-467d-9f3a-842c72d2e0c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24e51553-7f1d-467d-9f3a-842c72d2e0c7', 2, NULL, 'A단조', '2 Spanish National Songs, op. 164, no. 2: Tango in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10627 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24e51553-7f1d-467d-9f3a-842c72d2e0c7'
);


-- None 3er Minuetto, T 74

UPDATE pieces piece
SET piece.title = '3er Minuetto, T 74', piece.title_en = '3er Minuetto, T 74',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7917 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 37 6 danzas españolas Op. 37

UPDATE pieces piece
SET piece.title = '6 danzas españolas Op. 37', piece.title_en = '6 danzas españolas, op. 37',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '37',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9655 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'D장조', part.name_en = '6 danzas españolas, op. 37: No. 1 in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9655 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:5d94e9ea-638c-4379-be1d-6a257a34758d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d94e9ea-638c-4379-be1d-6a257a34758d', 1, NULL, 'D장조', '6 danzas españolas, op. 37: No. 1 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9655 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d94e9ea-638c-4379-be1d-6a257a34758d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'B♭장조', part.name_en = '6 danzas españolas, op. 37: No. 2 in B-flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9655 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:88dbd3f1-0e48-48fe-8a68-054ce280d8ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88dbd3f1-0e48-48fe-8a68-054ce280d8ae', 2, NULL, 'B♭장조', '6 danzas españolas, op. 37: No. 2 in B-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9655 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88dbd3f1-0e48-48fe-8a68-054ce280d8ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'E♭장조', part.name_en = '6 danzas españolas, op. 37: No. 3 in E-flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9655 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:be734e09-554c-4fe0-85f9-f8e6f80ae7cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be734e09-554c-4fe0-85f9-f8e6f80ae7cf', 3, NULL, 'E♭장조', '6 danzas españolas, op. 37: No. 3 in E-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9655 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be734e09-554c-4fe0-85f9-f8e6f80ae7cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'G장조', part.name_en = '6 danzas españolas, op. 37: No. 4 in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9655 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:711dfb8e-4614-4b35-80a8-960b8f74d78a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:711dfb8e-4614-4b35-80a8-960b8f74d78a', 4, NULL, 'G장조', '6 danzas españolas, op. 37: No. 4 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9655 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:711dfb8e-4614-4b35-80a8-960b8f74d78a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'A♭장조', part.name_en = '6 danzas españolas, op. 37: No. 5 in A-flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9655 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:f6850c89-7d58-4545-8603-3ac696fba0ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6850c89-7d58-4545-8603-3ac696fba0ae', 5, NULL, 'A♭장조', '6 danzas españolas, op. 37: No. 5 in A-flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9655 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6850c89-7d58-4545-8603-3ac696fba0ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'D장조', part.name_en = '6 danzas españolas, op. 37: No. 6 in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9655 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:010b6e20-5804-4de0-9811-3855bdd7dae5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:010b6e20-5804-4de0-9811-3855bdd7dae5', 6, NULL, 'D장조', '6 danzas españolas, op. 37: No. 6 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9655 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:010b6e20-5804-4de0-9811-3855bdd7dae5'
);


-- Op. 66 6 mazurkas de salón Op. 66

UPDATE pieces piece
SET piece.title = '6 mazurkas de salón Op. 66', piece.title_en = '6 mazurkas de salón, op. 66',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '66',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10723 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Isabel: Tempo enérgico', part.name_en = '6 mazurkas de salón, op. 66, no. 1: Isabel: Tempo enérgico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10723 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:cf62f731-d680-4f67-98ff-5be34eb32f5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf62f731-d680-4f67-98ff-5be34eb32f5a', 1, NULL, 'Isabel: Tempo enérgico', '6 mazurkas de salón, op. 66, no. 1: Isabel: Tempo enérgico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10723 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf62f731-d680-4f67-98ff-5be34eb32f5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Casilda: Allegro', part.name_en = '6 mazurkas de salón, op. 66, no. 2: Casilda: Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10723 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:f96ec3cb-a3d9-4188-873f-be22a13d080c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f96ec3cb-a3d9-4188-873f-be22a13d080c', 2, NULL, 'Casilda: Allegro', '6 mazurkas de salón, op. 66, no. 2: Casilda: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10723 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f96ec3cb-a3d9-4188-873f-be22a13d080c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Aurora: Non troppo', part.name_en = '6 mazurkas de salón, op. 66, no. 3: Aurora: Non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10723 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:ec3d19e0-956f-464e-b8b0-e61786b38afa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec3d19e0-956f-464e-b8b0-e61786b38afa', 3, NULL, 'Aurora: Non troppo', '6 mazurkas de salón, op. 66, no. 3: Aurora: Non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10723 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec3d19e0-956f-464e-b8b0-e61786b38afa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sofía', part.name_en = '6 mazurkas de salón, op. 66, no. 4: Sofía',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10723 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:b054cb8c-039f-4985-87e7-7e191b0effed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b054cb8c-039f-4985-87e7-7e191b0effed', 4, NULL, 'Sofía', '6 mazurkas de salón, op. 66, no. 4: Sofía', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10723 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b054cb8c-039f-4985-87e7-7e191b0effed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Christa: Presto', part.name_en = '6 mazurkas de salón, op. 66, no. 5: Christa: Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10723 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:0e8fd6c5-7e2c-4c5b-8375-5daa2396b567' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e8fd6c5-7e2c-4c5b-8375-5daa2396b567', 5, NULL, 'Christa: Presto', '6 mazurkas de salón, op. 66, no. 5: Christa: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10723 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e8fd6c5-7e2c-4c5b-8375-5daa2396b567'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'María: Tempo giusto', part.name_en = '6 mazurkas de salón, op. 66, no. 6: María: Tempo giusto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10723 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:4bba0281-fec0-414b-bdf1-cb1604b30b0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4bba0281-fec0-414b-bdf1-cb1604b30b0e', 6, NULL, 'María: Tempo giusto', '6 mazurkas de salón, op. 66, no. 6: María: Tempo giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10723 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bba0281-fec0-414b-bdf1-cb1604b30b0e'
);


-- Op. 25 6 pequeños valses Op. 25

UPDATE pieces piece
SET piece.title = '6 pequeños valses Op. 25', piece.title_en = '6 pequeños valses, op. 25',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '25',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10590 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = '6 pequeños valses, op. 25, no. 1: Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10590 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:222a6755-064e-4d4c-8bcd-1e46b7646d27' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:222a6755-064e-4d4c-8bcd-1e46b7646d27', 1, NULL, 'Allegretto', '6 pequeños valses, op. 25, no. 1: Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10590 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:222a6755-064e-4d4c-8bcd-1e46b7646d27'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Melancólico', part.name_en = '6 pequeños valses, op. 25, no. 2: Melancólico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10590 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:0f5e023c-b477-4ecd-836d-699fbe2c1976' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f5e023c-b477-4ecd-836d-699fbe2c1976', 2, NULL, 'Melancólico', '6 pequeños valses, op. 25, no. 2: Melancólico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10590 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f5e023c-b477-4ecd-836d-699fbe2c1976'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro ben ritmato', part.name_en = '6 pequeños valses, op. 25, no. 3: Allegro ben ritmato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10590 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:7afa2fa3-2c7e-4a93-8d9b-915f5aa3020d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7afa2fa3-2c7e-4a93-8d9b-915f5aa3020d', 3, NULL, 'Allegro ben ritmato', '6 pequeños valses, op. 25, no. 3: Allegro ben ritmato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10590 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7afa2fa3-2c7e-4a93-8d9b-915f5aa3020d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = '6 pequeños valses, op. 25, no. 4: Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10590 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:2d590dcf-0ff5-4316-a41f-0f7fe0550860' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d590dcf-0ff5-4316-a41f-0f7fe0550860', 4, NULL, 'Allegretto', '6 pequeños valses, op. 25, no. 4: Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10590 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d590dcf-0ff5-4316-a41f-0f7fe0550860'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Con brio e ritmo', part.name_en = '6 pequeños valses, op. 25, no. 5: Con brio e ritmo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10590 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:b29d5f8d-010a-472b-b451-d65c51a14ca9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b29d5f8d-010a-472b-b451-d65c51a14ca9', 5, NULL, 'Con brio e ritmo', '6 pequeños valses, op. 25, no. 5: Con brio e ritmo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10590 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b29d5f8d-010a-472b-b451-d65c51a14ca9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Allegro molto', part.name_en = '6 pequeños valses, op. 25, no. 6: Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10590 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:61d67237-8f9a-412e-91f3-4a0a9ca289da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61d67237-8f9a-412e-91f3-4a0a9ca289da', 6, NULL, 'Allegro molto', '6 pequeños valses, op. 25, no. 6: Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10590 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61d67237-8f9a-412e-91f3-4a0a9ca289da'
);


-- Op. 95 Amalia

UPDATE pieces piece
SET piece.title = 'Amalia', piece.title_en = 'Amalia, op. 95',
    piece.type = 'song', piece.opus_number = 'Op. 95',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10293 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Angustia

UPDATE pieces piece
SET piece.title = 'Angustia', piece.title_en = 'Angustia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10514 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Arbola Azpian (Zortzico), T. 84

UPDATE pieces piece
SET piece.title = 'Arbola Azpian (Zortzico), T. 84', piece.title_en = 'Arbola Azpian (Zortzico), T. 84',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11269 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 23 Barcarola

UPDATE pieces piece
SET piece.title = 'Barcarola', piece.title_en = 'Barcarola, op. 23',
    piece.type = 'song', piece.opus_number = 'Op. 23',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9326 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Berceuse, T. 114 bis

UPDATE pieces piece
SET piece.title = 'Berceuse, T. 114 bis', piece.title_en = 'Berceuse, T. 114 bis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7872 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 232 Cantos de España Op. 232

UPDATE pieces piece
SET piece.title = 'Cantos de España Op. 232', piece.title_en = 'Cantos de España, op. 232',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '232',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9198 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'n.º 1: Preludio', part.name_en = 'Cantos de España, op. 232, n.º 1: Preludio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9198 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:253cfb19-5d46-4a79-80e1-45bce1ab9196' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:253cfb19-5d46-4a79-80e1-45bce1ab9196', 1, NULL, 'n.º 1: Preludio', 'Cantos de España, op. 232, n.º 1: Preludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9198 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:253cfb19-5d46-4a79-80e1-45bce1ab9196'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'n.º 2: Oriental', part.name_en = 'Cantos de España, op. 232, n.º 2: Oriental',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9198 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:9a6112ce-6835-4b7f-8f65-bc19deba01a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a6112ce-6835-4b7f-8f65-bc19deba01a5', 2, NULL, 'n.º 2: Oriental', 'Cantos de España, op. 232, n.º 2: Oriental', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9198 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a6112ce-6835-4b7f-8f65-bc19deba01a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'n.º 3: Bajo la palmera', part.name_en = 'Cantos de España, op. 232, n.º 3: Bajo la palmera',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9198 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:607c5449-7309-4f4b-9de4-e6775fde2bf9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:607c5449-7309-4f4b-9de4-e6775fde2bf9', 3, NULL, 'n.º 3: Bajo la palmera', 'Cantos de España, op. 232, n.º 3: Bajo la palmera', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9198 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:607c5449-7309-4f4b-9de4-e6775fde2bf9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'n.º 4: Córdoba', part.name_en = 'Cantos de España, op. 232, n.º 4: Córdoba',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9198 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:f94c844c-695e-327f-8efe-947bb0090b17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f94c844c-695e-327f-8efe-947bb0090b17', 4, NULL, 'n.º 4: Córdoba', 'Cantos de España, op. 232, n.º 4: Córdoba', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9198 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f94c844c-695e-327f-8efe-947bb0090b17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'n.º 5: Seguidillas', part.name_en = 'Cantos de España, op. 232, n.º 5: Seguidillas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9198 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:8e556012-f12c-46b5-9639-8b7b26cedbcc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e556012-f12c-46b5-9639-8b7b26cedbcc', 5, NULL, 'n.º 5: Seguidillas', 'Cantos de España, op. 232, n.º 5: Seguidillas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9198 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e556012-f12c-46b5-9639-8b7b26cedbcc'
);


-- None Champagne (Carte blanche), vals de salón, T. 83

UPDATE pieces piece
SET piece.title = 'Champagne (Carte blanche), vals de salón, T. 83', piece.title_en = 'Champagne (Carte blanche), vals de salón, T. 83',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9531 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Chanson de Barberine>

UPDATE pieces piece
SET piece.title = '가곡 <Chanson de Barberine>', piece.title_en = 'Chanson de Barberine',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7533 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 78 Concierto fantástico

UPDATE pieces piece
SET piece.title = 'Concierto fantástico', piece.title_en = 'Concierto fantástico, op. 78',
    piece.type = 'album', piece.opus_number = 'Op. 78',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7453 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro ma non troppo', part.name_en = 'Concierto fantástico, op. 78: I. Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7453 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:534cc85a-1f2b-4bc7-9f4f-b6aa21b66f3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:534cc85a-1f2b-4bc7-9f4f-b6aa21b66f3e', 1, 'I', 'Allegro ma non troppo', 'Concierto fantástico, op. 78: I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7453 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:534cc85a-1f2b-4bc7-9f4f-b6aa21b66f3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Concierto fantástico, op. 78: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7453 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:011b5e69-c1ab-43e3-bc32-4a9c68933e55' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:011b5e69-c1ab-43e3-bc32-4a9c68933e55', 2, 'II', 'Andante', 'Concierto fantástico, op. 78: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7453 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:011b5e69-c1ab-43e3-bc32-4a9c68933e55'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Concierto fantástico, op. 78: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7453 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:bea26879-3a79-4f1e-889a-d6613076f649' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bea26879-3a79-4f1e-889a-d6613076f649', 3, 'III', 'Allegro', 'Concierto fantástico, op. 78: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7453 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bea26879-3a79-4f1e-889a-d6613076f649'
);


-- Op. 40 Deseo

UPDATE pieces piece
SET piece.title = 'Deseo', piece.title_en = 'Deseo, op. 40',
    piece.type = 'song', piece.opus_number = 'Op. 40',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9778 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- B. 45 España (Souvenirs) B. 45

UPDATE pieces piece
SET piece.title = 'España (Souvenirs) B. 45', piece.title_en = 'España (Souvenirs), B. 45',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'B.', piece.catalogue_number = '45',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10555 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Preludio', part.name_en = 'España (Souvenirs), B. 45, No. 1: Preludio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10555 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:ac2f8dac-231f-36fc-81e4-2ccfed5956cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac2f8dac-231f-36fc-81e4-2ccfed5956cd', 1, NULL, 'Preludio', 'España (Souvenirs), B. 45, No. 1: Preludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10555 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac2f8dac-231f-36fc-81e4-2ccfed5956cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Asturias', part.name_en = 'España (Souvenirs), B. 45, No. 2: Asturias',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10555 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:432a2bb9-b09c-3b96-90da-ceef24fd6afe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:432a2bb9-b09c-3b96-90da-ceef24fd6afe', 2, NULL, 'Asturias', 'España (Souvenirs), B. 45, No. 2: Asturias', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10555 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:432a2bb9-b09c-3b96-90da-ceef24fd6afe'
);


-- Op. 165 España, seis hojas de álbum

UPDATE pieces piece
SET piece.title = 'España, seis hojas de álbum', piece.title_en = 'España, seis hojas de álbum, op. 165',
    piece.type = 'album', piece.opus_number = 'Op. 165',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10393 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Preludio', part.name_en = 'España, seis hojas de álbum, op. 165: I. Preludio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10393 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:e24be8d1-d1e1-3b72-b777-70d52497009a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e24be8d1-d1e1-3b72-b777-70d52497009a', 1, 'I', 'Preludio', 'España, seis hojas de álbum, op. 165: I. Preludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10393 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e24be8d1-d1e1-3b72-b777-70d52497009a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Tango', part.name_en = 'España, seis hojas de álbum, op. 165: II. Tango',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10393 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:8e42803a-8e45-3cba-864b-5735c7b5f787' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e42803a-8e45-3cba-864b-5735c7b5f787', 2, 'II', 'Tango', 'España, seis hojas de álbum, op. 165: II. Tango', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10393 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e42803a-8e45-3cba-864b-5735c7b5f787'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Malagueña', part.name_en = 'España, seis hojas de álbum, op. 165: III. Malagueña',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10393 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:a5c23037-c4e3-3398-b217-98ed3471a92e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5c23037-c4e3-3398-b217-98ed3471a92e', 3, 'III', 'Malagueña', 'España, seis hojas de álbum, op. 165: III. Malagueña', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10393 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5c23037-c4e3-3398-b217-98ed3471a92e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Serenata', part.name_en = 'España, seis hojas de álbum, op. 165: IV. Serenata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10393 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:05410959-96d5-3756-a34d-1a0bcb2b10d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05410959-96d5-3756-a34d-1a0bcb2b10d8', 4, 'IV', 'Serenata', 'España, seis hojas de álbum, op. 165: IV. Serenata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10393 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05410959-96d5-3756-a34d-1a0bcb2b10d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Capricho catalán', part.name_en = 'España, seis hojas de álbum, op. 165: V. Capricho catalán',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10393 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:51bf61dd-fdaf-3e36-9829-9ec3cf352f5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51bf61dd-fdaf-3e36-9829-9ec3cf352f5d', 5, 'V', 'Capricho catalán', 'España, seis hojas de álbum, op. 165: V. Capricho catalán', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10393 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51bf61dd-fdaf-3e36-9829-9ec3cf352f5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Zortzico', part.name_en = 'España, seis hojas de álbum, op. 165: VI. Zortzico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10393 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:cee45456-3408-3a5a-8659-75dd571a43a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cee45456-3408-3a5a-8659-75dd571a43a2', 6, 'VI', 'Zortzico', 'España, seis hojas de álbum, op. 165: VI. Zortzico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10393 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cee45456-3408-3a5a-8659-75dd571a43a2'
);


-- None Estudio impromptu, T. 50

UPDATE pieces piece
SET piece.title = 'Estudio impromptu, T. 50', piece.title_en = 'Estudio impromptu, T. 50',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9517 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Granada>

UPDATE pieces piece
SET piece.title = '가곡 <Granada>', piece.title_en = 'Granada',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7677 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Henry Clifford

UPDATE pieces piece
SET piece.title = 'Henry Clifford', piece.title_en = 'Henry Clifford',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8146 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Children, let the plighted troth like a ring enfold', part.name_en = 'Henry Clifford: Children, let the plighted troth like a ring enfold.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:05bbbf1f-52a5-444d-a4c5-d8d9da806ef8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05bbbf1f-52a5-444d-a4c5-d8d9da806ef8', 1, NULL, 'Children, let the plighted troth like a ring enfold', 'Henry Clifford: Children, let the plighted troth like a ring enfold.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05bbbf1f-52a5-444d-a4c5-d8d9da806ef8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Dance of the fairies', part.name_en = 'Henry Clifford: Dance of the fairies',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:0b5e135c-18eb-4049-a335-1d0f8f9c5110' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b5e135c-18eb-4049-a335-1d0f8f9c5110', 2, NULL, 'Dance of the fairies', 'Henry Clifford: Dance of the fairies', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b5e135c-18eb-4049-a335-1d0f8f9c5110'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'When the breezes are still', part.name_en = 'Henry Clifford: When the breezes are still',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:0dea60cc-7693-402d-874a-81cd004abb1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0dea60cc-7693-402d-874a-81cd004abb1e', 3, NULL, 'When the breezes are still', 'Henry Clifford: When the breezes are still', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0dea60cc-7693-402d-874a-81cd004abb1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Lovely vision, dream delightful, wilt thou vanish', part.name_en = 'Henry Clifford: Lovely vision, dream delightful, wilt thou vanish',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:0e3bc387-a188-4b9f-a040-df6b64e720bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e3bc387-a188-4b9f-a040-df6b64e720bc', 4, NULL, 'Lovely vision, dream delightful, wilt thou vanish', 'Henry Clifford: Lovely vision, dream delightful, wilt thou vanish', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e3bc387-a188-4b9f-a040-df6b64e720bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Shall loyalty to phantom right our yearning heart', part.name_en = 'Henry Clifford: Shall loyalty to phantom right our yearning heart.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:129b102a-538b-4d06-89d6-6ddf3d0face8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:129b102a-538b-4d06-89d6-6ddf3d0face8', 5, NULL, 'Shall loyalty to phantom right our yearning heart', 'Henry Clifford: Shall loyalty to phantom right our yearning heart.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:129b102a-538b-4d06-89d6-6ddf3d0face8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Sir John Saint John approaches!', part.name_en = 'Henry Clifford: Sir John Saint John approaches!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:13272f79-73b6-4e38-b5f4-9bc898e5f902' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13272f79-73b6-4e38-b5f4-9bc898e5f902', 6, NULL, 'Sir John Saint John approaches!', 'Henry Clifford: Sir John Saint John approaches!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13272f79-73b6-4e38-b5f4-9bc898e5f902'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Sloes are blossoming in the hedges', part.name_en = 'Henry Clifford: Sloes are blossoming in the hedges',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:21447953-0ffc-454c-b4a8-d0092e1141be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21447953-0ffc-454c-b4a8-d0092e1141be', 7, NULL, 'Sloes are blossoming in the hedges', 'Henry Clifford: Sloes are blossoming in the hedges', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21447953-0ffc-454c-b4a8-d0092e1141be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Prelude', part.name_en = 'Henry Clifford: Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:23d5b327-80a4-49fd-9a18-501e476cae49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23d5b327-80a4-49fd-9a18-501e476cae49', 8, NULL, 'Prelude', 'Henry Clifford: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23d5b327-80a4-49fd-9a18-501e476cae49'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'To arms! this mandate to resist writ with my father''s', part.name_en = 'Henry Clifford: To arms! this mandate to resist writ with my father''s',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:23ded11c-d60d-4b7f-9ee1-0a2c84f75965' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23ded11c-d60d-4b7f-9ee1-0a2c84f75965', 9, NULL, 'To arms! this mandate to resist writ with my father''s', 'Henry Clifford: To arms! this mandate to resist writ with my father''s', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23ded11c-d60d-4b7f-9ee1-0a2c84f75965'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'All is lost! The battle''s o''er!', part.name_en = 'Henry Clifford: All is lost! The battle''s o''er!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:374b1893-c12c-4f60-bafa-819454ba8be2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:374b1893-c12c-4f60-bafa-819454ba8be2', 10, NULL, 'All is lost! The battle''s o''er!', 'Henry Clifford: All is lost! The battle''s o''er!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:374b1893-c12c-4f60-bafa-819454ba8be2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'The Earl of Richmond landed', part.name_en = 'Henry Clifford: The Earl of Richmond landed',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:38f26a5e-4931-40c8-beb8-28162368f49e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38f26a5e-4931-40c8-beb8-28162368f49e', 11, NULL, 'The Earl of Richmond landed', 'Henry Clifford: The Earl of Richmond landed', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38f26a5e-4931-40c8-beb8-28162368f49e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Beware! She is a witch!', part.name_en = 'Henry Clifford: Beware! She is a witch!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:468e9517-3956-49cd-922c-4c116ba4a4b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:468e9517-3956-49cd-922c-4c116ba4a4b4', 12, NULL, 'Beware! She is a witch!', 'Henry Clifford: Beware! She is a witch!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:468e9517-3956-49cd-922c-4c116ba4a4b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Said Dick to the Devil, "Come, sell me your dice"', part.name_en = 'Henry Clifford: Said Dick to the Devil, "Come, sell me your dice"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:5163dfb7-49bc-4c66-b1f3-b647009edb31' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5163dfb7-49bc-4c66-b1f3-b647009edb31', 13, NULL, 'Said Dick to the Devil, "Come, sell me your dice"', 'Henry Clifford: Said Dick to the Devil, "Come, sell me your dice"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5163dfb7-49bc-4c66-b1f3-b647009edb31'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Someone approaches', part.name_en = 'Henry Clifford: Someone approaches',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:5634d2dc-e55d-4f92-88e3-700b35cdbf98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5634d2dc-e55d-4f92-88e3-700b35cdbf98', 14, NULL, 'Someone approaches', 'Henry Clifford: Someone approaches', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5634d2dc-e55d-4f92-88e3-700b35cdbf98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'All the night our force he led', part.name_en = 'Henry Clifford: All the night our force he led',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:5fc08949-96a0-40ba-ad55-207b9aeb1524' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fc08949-96a0-40ba-ad55-207b9aeb1524', 15, NULL, 'All the night our force he led', 'Henry Clifford: All the night our force he led', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fc08949-96a0-40ba-ad55-207b9aeb1524'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Our Lady of Bolton preserve thee, Henry mine!', part.name_en = 'Henry Clifford: Our Lady of Bolton preserve thee, Henry mine!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:6347e0e7-7e4f-43c8-9820-ef89c56c3935' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6347e0e7-7e4f-43c8-9820-ef89c56c3935', 16, NULL, 'Our Lady of Bolton preserve thee, Henry mine!', 'Henry Clifford: Our Lady of Bolton preserve thee, Henry mine!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6347e0e7-7e4f-43c8-9820-ef89c56c3935'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = '''Tis I, sweet friend! To thee I bend!', part.name_en = 'Henry Clifford: ''Tis I, sweet friend! To thee I bend!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:6524dfae-da1a-43b5-b68b-1968066bc284' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6524dfae-da1a-43b5-b68b-1968066bc284', 17, NULL, '''Tis I, sweet friend! To thee I bend!', 'Henry Clifford: ''Tis I, sweet friend! To thee I bend!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6524dfae-da1a-43b5-b68b-1968066bc284'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Not mine vengeance! Not mine repayment!', part.name_en = 'Henry Clifford: Not mine vengeance! Not mine repayment!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:6d736fb3-72f3-4cf2-81b4-6f00543a3b81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d736fb3-72f3-4cf2-81b4-6f00543a3b81', 18, NULL, 'Not mine vengeance! Not mine repayment!', 'Henry Clifford: Not mine vengeance! Not mine repayment!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d736fb3-72f3-4cf2-81b4-6f00543a3b81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Woe is me to love a fairy!', part.name_en = 'Henry Clifford: Woe is me to love a fairy!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:7bab9452-54bc-44cc-825b-248162e3a1f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7bab9452-54bc-44cc-825b-248162e3a1f7', 19, NULL, 'Woe is me to love a fairy!', 'Henry Clifford: Woe is me to love a fairy!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bab9452-54bc-44cc-825b-248162e3a1f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Edward the King! March with a swing!', part.name_en = 'Henry Clifford: Edward the King! March with a swing!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:807e391c-5ae0-43e1-82b7-3350f34f554d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:807e391c-5ae0-43e1-82b7-3350f34f554d', 20, NULL, 'Edward the King! March with a swing!', 'Henry Clifford: Edward the King! March with a swing!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:807e391c-5ae0-43e1-82b7-3350f34f554d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Alas! The days are gathered and laid by', part.name_en = 'Henry Clifford: Alas! The days are gathered and laid by',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:8132dc7a-69a1-40be-9b0d-598ded175b06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8132dc7a-69a1-40be-9b0d-598ded175b06', 21, NULL, 'Alas! The days are gathered and laid by', 'Henry Clifford: Alas! The days are gathered and laid by', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8132dc7a-69a1-40be-9b0d-598ded175b06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Lady, ''tis the trysting hour!', part.name_en = 'Henry Clifford: Lady, ''tis the trysting hour!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:81598b68-7009-43c6-80da-68d88e55dd6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81598b68-7009-43c6-80da-68d88e55dd6c', 22, NULL, 'Lady, ''tis the trysting hour!', 'Henry Clifford: Lady, ''tis the trysting hour!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81598b68-7009-43c6-80da-68d88e55dd6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Dance of the fairies', part.name_en = 'Henry Clifford: Dance of the fairies',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:8b3b7ab2-9178-4748-8d71-bd1b7c3c0696' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b3b7ab2-9178-4748-8d71-bd1b7c3c0696', 23, NULL, 'Dance of the fairies', 'Henry Clifford: Dance of the fairies', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b3b7ab2-9178-4748-8d71-bd1b7c3c0696'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Pray for the soul of a chieftan departed!', part.name_en = 'Henry Clifford: Pray for the soul of a chieftan departed!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:8c293492-63ba-40ca-8d0c-6972b950c0a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c293492-63ba-40ca-8d0c-6972b950c0a7', 24, NULL, 'Pray for the soul of a chieftan departed!', 'Henry Clifford: Pray for the soul of a chieftan departed!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c293492-63ba-40ca-8d0c-6972b950c0a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'What ho! The guard! The guard!', part.name_en = 'Henry Clifford: What ho! The guard! The guard!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:a5142bbc-6967-4b6b-abca-980fc0838413' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5142bbc-6967-4b6b-abca-980fc0838413', 25, NULL, 'What ho! The guard! The guard!', 'Henry Clifford: What ho! The guard! The guard!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5142bbc-6967-4b6b-abca-980fc0838413'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'My heart is faint!', part.name_en = 'Henry Clifford: My heart is faint!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:a54a433b-671f-4304-bc7f-b42dee197a8c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a54a433b-671f-4304-bc7f-b42dee197a8c', 26, NULL, 'My heart is faint!', 'Henry Clifford: My heart is faint!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a54a433b-671f-4304-bc7f-b42dee197a8c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'So am I quite unknown?', part.name_en = 'Henry Clifford: So am I quite unknown?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:a5bd751b-237c-40ab-9d28-a16b00b9d8a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5bd751b-237c-40ab-9d28-a16b00b9d8a8', 27, NULL, 'So am I quite unknown?', 'Henry Clifford: So am I quite unknown?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5bd751b-237c-40ab-9d28-a16b00b9d8a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'Ballet and Chorus', part.name_en = 'Henry Clifford: Ballet and Chorus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:a631d8f6-f7c2-40ec-aa96-75c7a429ac7d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a631d8f6-f7c2-40ec-aa96-75c7a429ac7d', 28, NULL, 'Ballet and Chorus', 'Henry Clifford: Ballet and Chorus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a631d8f6-f7c2-40ec-aa96-75c7a429ac7d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'Cease, cease thy weeping wild and listen', part.name_en = 'Henry Clifford: Cease, cease thy weeping wild and listen.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:af190148-18dc-4765-a427-1294720881b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af190148-18dc-4765-a427-1294720881b8', 29, NULL, 'Cease, cease thy weeping wild and listen', 'Henry Clifford: Cease, cease thy weeping wild and listen.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af190148-18dc-4765-a427-1294720881b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'Sweet are the visions, mysteriously stealing', part.name_en = 'Henry Clifford: Sweet are the visions, mysteriously stealing.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:bb401de2-4753-4839-9515-e4a23d306ab8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb401de2-4753-4839-9515-e4a23d306ab8', 30, NULL, 'Sweet are the visions, mysteriously stealing', 'Henry Clifford: Sweet are the visions, mysteriously stealing.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb401de2-4753-4839-9515-e4a23d306ab8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'Introduction', part.name_en = 'Henry Clifford: Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:bee6817e-ac89-4bb2-be4c-471d66efe83c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bee6817e-ac89-4bb2-be4c-471d66efe83c', 31, NULL, 'Introduction', 'Henry Clifford: Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bee6817e-ac89-4bb2-be4c-471d66efe83c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = 'Richard is dead, and Richmond reigns!', part.name_en = 'Henry Clifford: Richard is dead, and Richmond reigns!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:c2313af8-bca5-419a-a8f6-5d1ab93b0013' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2313af8-bca5-419a-a8f6-5d1ab93b0013', 32, NULL, 'Richard is dead, and Richmond reigns!', 'Henry Clifford: Richard is dead, and Richmond reigns!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2313af8-bca5-419a-a8f6-5d1ab93b0013'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 33, part.movement_number = NULL,
    part.name_ko = 'Spirits of the flowers truant from honeyed cages', part.name_en = 'Henry Clifford: Spirits of the flowers truant from honeyed cages',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:c3067577-e170-4b29-895e-7a903d0b3968' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3067577-e170-4b29-895e-7a903d0b3968', 33, NULL, 'Spirits of the flowers truant from honeyed cages', 'Henry Clifford: Spirits of the flowers truant from honeyed cages', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3067577-e170-4b29-895e-7a903d0b3968'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 34, part.movement_number = NULL,
    part.name_ko = 'For fear of pain flee not the right!', part.name_en = 'Henry Clifford: For fear of pain flee not the right!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:c6645bba-3e1f-46be-928e-e69570c1cca3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6645bba-3e1f-46be-928e-e69570c1cca3', 34, NULL, 'For fear of pain flee not the right!', 'Henry Clifford: For fear of pain flee not the right!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6645bba-3e1f-46be-928e-e69570c1cca3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 35, part.movement_number = NULL,
    part.name_ko = 'These honest men against their will are outlaws', part.name_en = 'Henry Clifford: These honest men against their will are outlaws',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:c7a00421-3482-45cd-b9e3-f29e28cac96e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7a00421-3482-45cd-b9e3-f29e28cac96e', 35, NULL, 'These honest men against their will are outlaws', 'Henry Clifford: These honest men against their will are outlaws', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7a00421-3482-45cd-b9e3-f29e28cac96e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 36, part.movement_number = NULL,
    part.name_ko = 'O Mother, why didst thou deny my longing for the fray?', part.name_en = 'Henry Clifford: O Mother, why didst thou deny my longing for the fray?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:c8c8692e-1005-4c0a-9253-27e23d39e5e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8c8692e-1005-4c0a-9253-27e23d39e5e5', 36, NULL, 'O Mother, why didst thou deny my longing for the fray?', 'Henry Clifford: O Mother, why didst thou deny my longing for the fray?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8c8692e-1005-4c0a-9253-27e23d39e5e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 37, part.movement_number = NULL,
    part.name_ko = 'Safe! Safe beyond the seas!', part.name_en = 'Henry Clifford: Safe! Safe beyond the seas!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:cfd239f4-8d80-4c77-b911-d83b30394d42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfd239f4-8d80-4c77-b911-d83b30394d42', 37, NULL, 'Safe! Safe beyond the seas!', 'Henry Clifford: Safe! Safe beyond the seas!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfd239f4-8d80-4c77-b911-d83b30394d42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 38, part.movement_number = NULL,
    part.name_ko = 'Come hither, Colin, faithful henchman, thou!', part.name_en = 'Henry Clifford: Come hither, Colin, faithful henchman, thou!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:d0e49a38-0d3f-41e4-a080-ddc01abe686b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0e49a38-0d3f-41e4-a080-ddc01abe686b', 38, NULL, 'Come hither, Colin, faithful henchman, thou!', 'Henry Clifford: Come hither, Colin, faithful henchman, thou!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0e49a38-0d3f-41e4-a080-ddc01abe686b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 39, part.movement_number = NULL,
    part.name_ko = 'My son! They come to seek thee! Look!', part.name_en = 'Henry Clifford: My son! They come to seek thee! Look!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:d146a064-a54c-4d1c-9ed5-aa24a00da8c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d146a064-a54c-4d1c-9ed5-aa24a00da8c2', 39, NULL, 'My son! They come to seek thee! Look!', 'Henry Clifford: My son! They come to seek thee! Look!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d146a064-a54c-4d1c-9ed5-aa24a00da8c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 40, part.movement_number = NULL,
    part.name_ko = 'My shepherd lord, I wish thee joy', part.name_en = 'Henry Clifford: My shepherd lord, I wish thee joy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:d4d0a99c-99ea-4ea5-a16e-586cff507a5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4d0a99c-99ea-4ea5-a16e-586cff507a5d', 40, NULL, 'My shepherd lord, I wish thee joy', 'Henry Clifford: My shepherd lord, I wish thee joy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4d0a99c-99ea-4ea5-a16e-586cff507a5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 41, part.movement_number = NULL,
    part.name_ko = 'Lady, ''tis the trysting hour!', part.name_en = 'Henry Clifford: Lady, ''tis the trysting hour!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:d8a10f08-5e0f-41ce-8ffb-b81728069e6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8a10f08-5e0f-41ce-8ffb-b81728069e6d', 41, NULL, 'Lady, ''tis the trysting hour!', 'Henry Clifford: Lady, ''tis the trysting hour!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8a10f08-5e0f-41ce-8ffb-b81728069e6d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 42, part.movement_number = NULL,
    part.name_ko = 'Hail! Hail! All Hail!', part.name_en = 'Henry Clifford: Hail! Hail! All Hail!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:d8f435df-81e8-408a-bc5b-51320229fd65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8f435df-81e8-408a-bc5b-51320229fd65', 42, NULL, 'Hail! Hail! All Hail!', 'Henry Clifford: Hail! Hail! All Hail!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8f435df-81e8-408a-bc5b-51320229fd65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 43, part.movement_number = NULL,
    part.name_ko = 'Adieu, mine own heart true!', part.name_en = 'Henry Clifford: Adieu, mine own heart true!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:edaa372d-672d-4f4b-b1e2-f073d199577c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edaa372d-672d-4f4b-b1e2-f073d199577c', 43, NULL, 'Adieu, mine own heart true!', 'Henry Clifford: Adieu, mine own heart true!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edaa372d-672d-4f4b-b1e2-f073d199577c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 44, part.movement_number = NULL,
    part.name_ko = 'Edward for King! March with a swing!', part.name_en = 'Henry Clifford: Edward for King! March with a swing!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:f31baf05-f7ef-444b-9a88-5232d1023b1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f31baf05-f7ef-444b-9a88-5232d1023b1a', 44, NULL, 'Edward for King! March with a swing!', 'Henry Clifford: Edward for King! March with a swing!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f31baf05-f7ef-444b-9a88-5232d1023b1a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 45, part.movement_number = NULL,
    part.name_ko = 'The foe draws near!', part.name_en = 'Henry Clifford: The foe draws near!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:f36ac337-daa1-4fe1-b80f-859dbb6e291d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f36ac337-daa1-4fe1-b80f-859dbb6e291d', 45, NULL, 'The foe draws near!', 'Henry Clifford: The foe draws near!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f36ac337-daa1-4fe1-b80f-859dbb6e291d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 46, part.movement_number = NULL,
    part.name_ko = 'Remember Towton!', part.name_en = 'Henry Clifford: Remember Towton!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:f3e1969d-9bc6-4624-87d8-26ecee2d3cd8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3e1969d-9bc6-4624-87d8-26ecee2d3cd8', 46, NULL, 'Remember Towton!', 'Henry Clifford: Remember Towton!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3e1969d-9bc6-4624-87d8-26ecee2d3cd8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 47, part.movement_number = NULL,
    part.name_ko = 'Sweet are the visions mysteriously stealing', part.name_en = 'Henry Clifford: Sweet are the visions mysteriously stealing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:f6820017-92f2-4ac2-811b-c25c26c401da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6820017-92f2-4ac2-811b-c25c26c401da', 47, NULL, 'Sweet are the visions mysteriously stealing', 'Henry Clifford: Sweet are the visions mysteriously stealing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6820017-92f2-4ac2-811b-c25c26c401da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 48, part.movement_number = NULL,
    part.name_ko = 'What feeble wit is here', part.name_en = 'Henry Clifford: What feeble wit is here',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8146 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:fff009c3-0a4b-423e-90df-4fb8b478d76d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fff009c3-0a4b-423e-90df-4fb8b478d76d', 48, NULL, 'What feeble wit is here', 'Henry Clifford: What feeble wit is here', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8146 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fff009c3-0a4b-423e-90df-4fb8b478d76d'
);


-- None 가곡 <Il en est de l'amour>

UPDATE pieces piece
SET piece.title = '가곡 <Il en est de l''amour>', piece.title_en = 'Il en est de l''amour',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9419 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Improvisation, T 115 A

UPDATE pieces piece
SET piece.title = 'Improvisation, T 115 A', piece.title_en = 'Improvisation, T 115 A',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8674 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Improvisation, T. 115 C, cylinder 167 (Tempo di minuetto)

UPDATE pieces piece
SET piece.title = 'Improvisation, T. 115 C, cylinder 167 (Tempo di minuetto)', piece.title_en = 'Improvisation, T. 115 C, cylinder 167 (Tempo di minuetto)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9617 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 170 L'Automne (valse)

UPDATE pieces piece
SET piece.title = 'L''Automne (valse)', piece.title_en = 'L''Automne (valse), op. 170',
    piece.type = 'song', piece.opus_number = 'Op. 170',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9857 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- B. 46 La Vega

UPDATE pieces piece
SET piece.title = 'La Vega', piece.title_en = 'La Vega, B. 46',
    piece.type = 'song', piece.opus_number = 'B. 46',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10297 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Les Saisons, T. 100

UPDATE pieces piece
SET piece.title = 'Les Saisons, T. 100', piece.title_en = 'Les Saisons, T. 100',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9065 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le Printemps. Allegretto', part.name_en = 'Les Saisons, T. 100: No. 1. Le Printemps. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9065 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:70503cdc-0d0d-4578-a896-ae5070323daa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70503cdc-0d0d-4578-a896-ae5070323daa', 1, NULL, 'Le Printemps. Allegretto', 'Les Saisons, T. 100: No. 1. Le Printemps. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9065 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70503cdc-0d0d-4578-a896-ae5070323daa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'L’Été. Allegro', part.name_en = 'Les Saisons, T. 100: No. 2. L’Été. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9065 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:7fd91069-01a9-44ec-aa16-f9ff4c07c9e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fd91069-01a9-44ec-aa16-f9ff4c07c9e2', 2, NULL, 'L’Été. Allegro', 'Les Saisons, T. 100: No. 2. L’Été. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9065 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fd91069-01a9-44ec-aa16-f9ff4c07c9e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'L’Automne. Andantino', part.name_en = 'Les Saisons, T. 100: No. 3. L’Automne. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9065 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:7700b036-44fe-4bb8-beff-92edb5b66b26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7700b036-44fe-4bb8-beff-92edb5b66b26', 3, NULL, 'L’Automne. Andantino', 'Les Saisons, T. 100: No. 3. L’Automne. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9065 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7700b036-44fe-4bb8-beff-92edb5b66b26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'L’Hiver. Allegretto', part.name_en = 'Les Saisons, T. 100: No. 4. L’Hiver. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9065 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:69176905-aba8-449c-8c0b-e8a68507854a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69176905-aba8-449c-8c0b-e8a68507854a', 4, NULL, 'L’Hiver. Allegretto', 'Les Saisons, T. 100: No. 4. L’Hiver. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9065 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69176905-aba8-449c-8c0b-e8a68507854a'
);


-- None Mazurka de salón, T. 81

UPDATE pieces piece
SET piece.title = 'Mazurka de salón, T. 81', piece.title_en = 'Mazurka de salón, T. 81',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9606 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Menuet, T 73

UPDATE pieces piece
SET piece.title = 'Menuet, T 73', piece.title_en = 'Menuet, T 73',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10831 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Merlin>

UPDATE pieces piece
SET piece.title = '오페라 <Merlin>', piece.title_en = 'Merlin',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10005 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelude', part.name_en = 'Merlin: Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10005 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:87dbfc1d-8371-463a-9a69-c0c1b8195b79' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87dbfc1d-8371-463a-9a69-c0c1b8195b79', 1, NULL, 'Prelude', 'Merlin: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10005 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87dbfc1d-8371-463a-9a69-c0c1b8195b79'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Merlin: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10005 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:1d43fe7e-6fc1-40a9-9825-a69877ea8223' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d43fe7e-6fc1-40a9-9825-a69877ea8223', 2, NULL, 'Act I', 'Merlin: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10005 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d43fe7e-6fc1-40a9-9825-a69877ea8223'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Merlin: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10005 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:eddc5449-3f0a-4a50-90e1-9c00fbca9aac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eddc5449-3f0a-4a50-90e1-9c00fbca9aac', 3, NULL, 'Act II', 'Merlin: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10005 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eddc5449-3f0a-4a50-90e1-9c00fbca9aac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act III', part.name_en = 'Merlin: Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10005 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:ef2d3159-987d-4fe0-8453-96e7c1544d0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef2d3159-987d-4fe0-8453-96e7c1544d0e', 4, NULL, 'Act III', 'Merlin: Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10005 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef2d3159-987d-4fe0-8453-96e7c1544d0e'
);


-- None Minuetto, T 89A

UPDATE pieces piece
SET piece.title = 'Minuetto, T 89A', piece.title_en = 'Minuetto, T 89A',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8557 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 83 Pavana muy fácil para manos pequeñas

UPDATE pieces piece
SET piece.title = 'Pavana muy fácil para manos pequeñas', piece.title_en = 'Pavana muy fácil para manos pequeñas, op. 83',
    piece.type = 'song', piece.opus_number = 'Op. 83',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11144 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Pepita Jiménez>

UPDATE pieces piece
SET piece.title = '오페라 <Pepita Jiménez>', piece.title_en = 'Pepita Jiménez',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8699 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Pepita Jiménez: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8699 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:9577f2d7-9ec5-451a-a25e-e3501334f894' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9577f2d7-9ec5-451a-a25e-e3501334f894', 1, NULL, 'Act I', 'Pepita Jiménez: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8699 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9577f2d7-9ec5-451a-a25e-e3501334f894'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Pepita Jiménez: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8699 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:96c57035-f242-4a5f-bd24-bdd698ec9820' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96c57035-f242-4a5f-bd24-bdd698ec9820', 2, NULL, 'Act II', 'Pepita Jiménez: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8699 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96c57035-f242-4a5f-bd24-bdd698ec9820'
);


-- Op. 28 피아노 소나타 1번 A♭장조

UPDATE pieces piece
SET piece.title = '피아노 소나타 1번 A♭장조', piece.title_en = 'Piano sonata no. 1 in A-flat major, op. 28, B. 4',
    piece.type = 'song', piece.opus_number = 'Op. 28',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8593 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quatre Mélodies

UPDATE pieces piece
SET piece.title = 'Quatre Mélodies', piece.title_en = 'Quatre Mélodies',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10278 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'In Sickness and Health (Quand je te vois souffrir)', part.name_en = 'In Sickness and Health (Quand je te vois souffrir)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10278 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:f5d1eaee-b200-43ae-a6e7-a8e7c1429a2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5d1eaee-b200-43ae-a6e7-a8e7c1429a2d', 1, NULL, 'In Sickness and Health (Quand je te vois souffrir)', 'In Sickness and Health (Quand je te vois souffrir)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10278 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5d1eaee-b200-43ae-a6e7-a8e7c1429a2d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Paradise Regained (Le paradis retrouvé)', part.name_en = 'Paradise Regained (Le paradis retrouvé)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10278 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:5c469444-dcff-415b-ad15-8c411f9c7180' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c469444-dcff-415b-ad15-8c411f9c7180', 2, NULL, 'Paradise Regained (Le paradis retrouvé)', 'Paradise Regained (Le paradis retrouvé)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10278 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c469444-dcff-415b-ad15-8c411f9c7180'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Retreat (Le refuge)', part.name_en = 'The Retreat (Le refuge)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10278 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:d9b995b7-c085-49c8-9961-e61bcf9fcea0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9b995b7-c085-49c8-9961-e61bcf9fcea0', 3, NULL, 'The Retreat (Le refuge)', 'The Retreat (Le refuge)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10278 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9b995b7-c085-49c8-9961-e61bcf9fcea0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Amor, summa injuria', part.name_en = 'Amor, summa injuria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10278 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:4dbcd518-e86d-467a-a356-29e1d01ebd0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4dbcd518-e86d-467a-a356-29e1d01ebd0c', 4, NULL, 'Amor, summa injuria', 'Amor, summa injuria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10278 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dbcd518-e86d-467a-a356-29e1d01ebd0c'
);


-- Op. 66 Rapsodia cubana

UPDATE pieces piece
SET piece.title = 'Rapsodia cubana', piece.title_en = 'Rapsodia cubana, op. 66',
    piece.type = 'song', piece.opus_number = 'Op. 66',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10048 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Recuerdos (Mazurka), T. 80

UPDATE pieces piece
SET piece.title = 'Recuerdos (Mazurka), T. 80', piece.title_en = 'Recuerdos (Mazurka), T. 80',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10166 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 71 Recuerdos de viaje

UPDATE pieces piece
SET piece.title = 'Recuerdos de viaje', piece.title_en = 'Recuerdos de viaje, op. 71',
    piece.type = 'album', piece.opus_number = 'Op. 71',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10517 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'En el mar', part.name_en = 'Recuerdos de viaje, op. 71: I. En el mar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10517 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:b7549d7b-d27f-45c6-98ca-d1b52991533e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7549d7b-d27f-45c6-98ca-d1b52991533e', 1, 'I', 'En el mar', 'Recuerdos de viaje, op. 71: I. En el mar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10517 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7549d7b-d27f-45c6-98ca-d1b52991533e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Leyenda (barcarola)', part.name_en = 'Recuerdos de viaje, op. 71: II. Leyenda (barcarola)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10517 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:e158064f-e19e-3a59-ab66-236babaa4989' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e158064f-e19e-3a59-ab66-236babaa4989', 2, 'II', 'Leyenda (barcarola)', 'Recuerdos de viaje, op. 71: II. Leyenda (barcarola)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10517 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e158064f-e19e-3a59-ab66-236babaa4989'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Alborada', part.name_en = 'Recuerdos de viaje, op. 71: III. Alborada',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10517 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:0e8db7ab-c2ca-4a9b-8e8b-81ffef8864c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e8db7ab-c2ca-4a9b-8e8b-81ffef8864c8', 3, 'III', 'Alborada', 'Recuerdos de viaje, op. 71: III. Alborada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10517 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e8db7ab-c2ca-4a9b-8e8b-81ffef8864c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'En la Alhambra', part.name_en = 'Recuerdos de viaje, op. 71: IV. En la Alhambra',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10517 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:f83a0d36-4cec-4df4-88c5-da8128b1a697' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f83a0d36-4cec-4df4-88c5-da8128b1a697', 4, 'IV', 'En la Alhambra', 'Recuerdos de viaje, op. 71: IV. En la Alhambra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10517 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f83a0d36-4cec-4df4-88c5-da8128b1a697'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Puerta de tierra (bolero)', part.name_en = 'Recuerdos de viaje, op. 71: V. Puerta de tierra (bolero)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10517 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:83d2e6b7-9fce-3e7a-98ee-8829ac01d8a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83d2e6b7-9fce-3e7a-98ee-8829ac01d8a4', 5, 'V', 'Puerta de tierra (bolero)', 'Recuerdos de viaje, op. 71: V. Puerta de tierra (bolero)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10517 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83d2e6b7-9fce-3e7a-98ee-8829ac01d8a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Rumores de la caleta', part.name_en = 'Recuerdos de viaje, op. 71: VI. Rumores de la caleta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10517 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:6dfaa6bc-ec36-3d09-b9ab-0c8c51b8d4b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6dfaa6bc-ec36-3d09-b9ab-0c8c51b8d4b4', 6, 'VI', 'Rumores de la caleta', 'Recuerdos de viaje, op. 71: VI. Rumores de la caleta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10517 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dfaa6bc-ec36-3d09-b9ab-0c8c51b8d4b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'En la playa', part.name_en = 'Recuerdos de viaje, op. 71: VII. En la playa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10517 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:80576be1-9ec1-445b-9457-dbf58e163091' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80576be1-9ec1-445b-9457-dbf58e163091', 7, 'VII', 'En la playa', 'Recuerdos de viaje, op. 71: VII. En la playa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10517 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80576be1-9ec1-445b-9457-dbf58e163091'
);


-- Op. 96 Ricordatti

UPDATE pieces piece
SET piece.title = 'Ricordatti', piece.title_en = 'Ricordatti, op. 96',
    piece.type = 'song', piece.opus_number = 'Op. 96',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9088 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rêves, op 201, T. 99

UPDATE pieces piece
SET piece.title = 'Rêves, op 201, T. 99', piece.title_en = 'Rêves, op 201, T. 99',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10100 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Berceuse', part.name_en = 'Rêves, op 201, T. 99: I. Berceuse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10100 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:f9082edd-68bf-4849-b938-13236d63a90c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9082edd-68bf-4849-b938-13236d63a90c', 1, 'I', 'Berceuse', 'Rêves, op 201, T. 99: I. Berceuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10100 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9082edd-68bf-4849-b938-13236d63a90c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzino', part.name_en = 'Rêves, op 201, T. 99: II. Scherzino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10100 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:a3572f20-3c0b-4341-a92a-7341edcd7955' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3572f20-3c0b-4341-a92a-7341edcd7955', 2, 'II', 'Scherzino', 'Rêves, op 201, T. 99: II. Scherzino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10100 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3572f20-3c0b-4341-a92a-7341edcd7955'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Chant d’amour', part.name_en = 'Rêves, op 201, T. 99: III. Chant d’amour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10100 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:34443b4a-ca16-4bed-af84-07c1b6fc77d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34443b4a-ca16-4bed-af84-07c1b6fc77d9', 3, 'III', 'Chant d’amour', 'Rêves, op 201, T. 99: III. Chant d’amour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10100 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34443b4a-ca16-4bed-af84-07c1b6fc77d9'
);


-- None Salmo VI del Oficio de difuntos

UPDATE pieces piece
SET piece.title = 'Salmo VI del Oficio de difuntos', piece.title_en = 'Salmo VI del Oficio de difuntos',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10778 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Scherzo, T 57

UPDATE pieces piece
SET piece.title = 'Scherzo, T 57', piece.title_en = 'Scherzo, T 57',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10612 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Seis Baladas

UPDATE pieces piece
SET piece.title = 'Seis Baladas', piece.title_en = 'Seis Baladas',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9701 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La Lontananza', part.name_en = 'Seis Baladas: La Lontananza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9701 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:afe257ba-3a69-489a-b937-8c2b9b8ef462' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afe257ba-3a69-489a-b937-8c2b9b8ef462', 1, NULL, 'La Lontananza', 'Seis Baladas: La Lontananza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9701 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afe257ba-3a69-489a-b937-8c2b9b8ef462'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Barcarola', part.name_en = 'Seis Baladas: Barcarola',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9701 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:cc44826e-d79e-4cc5-bb0c-d38119c9712e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc44826e-d79e-4cc5-bb0c-d38119c9712e', 2, NULL, 'Barcarola', 'Seis Baladas: Barcarola', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9701 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc44826e-d79e-4cc5-bb0c-d38119c9712e'
);


-- None Serenata árabe

UPDATE pieces piece
SET piece.title = 'Serenata árabe', piece.title_en = 'Serenata árabe',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8368 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 65 Siete estudios en los tonos naturales mayores Op. 65

UPDATE pieces piece
SET piece.title = 'Siete estudios en los tonos naturales mayores Op. 65', piece.title_en = 'Siete estudios en los tonos naturales mayores, op. 65',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '65',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11195 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'N.º 1 en do mayor (Allegro)', part.name_en = 'Siete estudios en los tonos naturales mayores, op. 65: N.º 1 en do mayor (Allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11195 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:0c467c5a-3042-4604-8e6a-937d7f538704' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c467c5a-3042-4604-8e6a-937d7f538704', 1, NULL, 'N.º 1 en do mayor (Allegro)', 'Siete estudios en los tonos naturales mayores, op. 65: N.º 1 en do mayor (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11195 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c467c5a-3042-4604-8e6a-937d7f538704'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'N.º 2 en sol mayor (Allegretto)', part.name_en = 'Siete estudios en los tonos naturales mayores, op. 65: N.º 2 en sol mayor (Allegretto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11195 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:9cab6704-0523-4dc3-88f0-5a4b0bc2b65d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9cab6704-0523-4dc3-88f0-5a4b0bc2b65d', 2, NULL, 'N.º 2 en sol mayor (Allegretto)', 'Siete estudios en los tonos naturales mayores, op. 65: N.º 2 en sol mayor (Allegretto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11195 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cab6704-0523-4dc3-88f0-5a4b0bc2b65d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'N.º 3 en re mayor (Allegretto)', part.name_en = 'Siete estudios en los tonos naturales mayores, op. 65: N.º 3 en re mayor (Allegretto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11195 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:ef5f4c1f-4081-4f0d-bd9d-d3f7e739e559' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef5f4c1f-4081-4f0d-bd9d-d3f7e739e559', 3, NULL, 'N.º 3 en re mayor (Allegretto)', 'Siete estudios en los tonos naturales mayores, op. 65: N.º 3 en re mayor (Allegretto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11195 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef5f4c1f-4081-4f0d-bd9d-d3f7e739e559'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'N.º 4 en la mayor', part.name_en = 'Siete estudios en los tonos naturales mayores, op. 65: N.º 4 en la mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11195 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:c6851820-1637-486e-a723-153d87932e3b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6851820-1637-486e-a723-153d87932e3b', 4, NULL, 'N.º 4 en la mayor', 'Siete estudios en los tonos naturales mayores, op. 65: N.º 4 en la mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11195 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6851820-1637-486e-a723-153d87932e3b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'N.º 5 en mi mayor', part.name_en = 'Siete estudios en los tonos naturales mayores, op. 65: N.º 5 en mi mayor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11195 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:fe8dc1a8-518e-4c78-a1a7-b8bc6ddcecaa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe8dc1a8-518e-4c78-a1a7-b8bc6ddcecaa', 5, NULL, 'N.º 5 en mi mayor', 'Siete estudios en los tonos naturales mayores, op. 65: N.º 5 en mi mayor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11195 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe8dc1a8-518e-4c78-a1a7-b8bc6ddcecaa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'N.º 6 en si mayor (Con brio)', part.name_en = 'Siete estudios en los tonos naturales mayores, op. 65: N.º 6 en si mayor (Con brio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11195 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:c2953934-6225-4a78-b290-1d2df091d1c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2953934-6225-4a78-b290-1d2df091d1c2', 6, NULL, 'N.º 6 en si mayor (Con brio)', 'Siete estudios en los tonos naturales mayores, op. 65: N.º 6 en si mayor (Con brio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11195 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2953934-6225-4a78-b290-1d2df091d1c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'N.º 7 en fa mayor (Allegro)', part.name_en = 'Siete estudios en los tonos naturales mayores, op. 65: N.º 7 en fa mayor (Allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11195 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:f74424c7-20eb-4152-b876-3fd325e36906' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f74424c7-20eb-4152-b876-3fd325e36906', 7, NULL, 'N.º 7 en fa mayor (Allegro)', 'Siete estudios en los tonos naturales mayores, op. 65: N.º 7 en fa mayor (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11195 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f74424c7-20eb-4152-b876-3fd325e36906'
);


-- Op. 72 Sonata para piano n.º 4

UPDATE pieces piece
SET piece.title = 'Sonata para piano n.º 4', piece.title_en = 'Sonata para piano n.º 4, op. 72',
    piece.type = 'album', piece.opus_number = 'Op. 72',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7589 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Sonata para piano n.º 4: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7589 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:758694a4-12c1-48d5-ab70-1fbf5456233d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:758694a4-12c1-48d5-ab70-1fbf5456233d', 1, 'I', 'Allegro', 'Sonata para piano n.º 4: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7589 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:758694a4-12c1-48d5-ab70-1fbf5456233d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzino. Allegro', part.name_en = 'Sonata para piano n.º 4: II. Scherzino. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7589 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:0c2dfd62-fe9d-429b-85e6-f61c3d5877c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c2dfd62-fe9d-429b-85e6-f61c3d5877c1', 2, 'II', 'Scherzino. Allegro', 'Sonata para piano n.º 4: II. Scherzino. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7589 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c2dfd62-fe9d-429b-85e6-f61c3d5877c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Menuetto. Andantino', part.name_en = 'Sonata para piano n.º 4: III. Menuetto. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7589 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:94e8a825-98ab-4b57-8f99-7d962f6eb076' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94e8a825-98ab-4b57-8f99-7d962f6eb076', 3, 'III', 'Menuetto. Andantino', 'Sonata para piano n.º 4: III. Menuetto. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7589 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94e8a825-98ab-4b57-8f99-7d962f6eb076'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Rondo. Allegro', part.name_en = 'Sonata para piano n.º 4: IV. Rondo. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7589 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:3a265eb4-1f91-47a0-966e-e7ffda1fa4f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a265eb4-1f91-47a0-966e-e7ffda1fa4f2', 4, 'IV', 'Rondo. Allegro', 'Sonata para piano n.º 4: IV. Rondo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7589 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a265eb4-1f91-47a0-966e-e7ffda1fa4f2'
);


-- Op. 68 소나타 3번

UPDATE pieces piece
SET piece.title = '소나타 3번', piece.title_en = 'Sonata para piano nº 3, op. 68',
    piece.type = 'album', piece.opus_number = 'Op. 68',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8299 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'Sonata para piano nº 3, op. 68: I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8299 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:9011b191-c3d0-403e-adf2-aa0f40c6f577' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9011b191-c3d0-403e-adf2-aa0f40c6f577', 1, 'I', 'Allegretto', 'Sonata para piano nº 3, op. 68: I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8299 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9011b191-c3d0-403e-adf2-aa0f40c6f577'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Sonata para piano nº 3, op. 68: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8299 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:cb003a5f-feb6-4391-9f2f-acaff1ba62ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb003a5f-feb6-4391-9f2f-acaff1ba62ee', 2, 'II', 'Andante', 'Sonata para piano nº 3, op. 68: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8299 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb003a5f-feb6-4391-9f2f-acaff1ba62ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro assai', part.name_en = 'Sonata para piano nº 3, op. 68: III. Allegro assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8299 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:98c0b8ef-1421-4336-9d4a-13a045a3022d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98c0b8ef-1421-4336-9d4a-13a045a3022d', 3, 'III', 'Allegro assai', 'Sonata para piano nº 3, op. 68: III. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8299 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98c0b8ef-1421-4336-9d4a-13a045a3022d'
);


-- Op. 82 소나타 5번

UPDATE pieces piece
SET piece.title = '소나타 5번', piece.title_en = 'Sonata para piano nº 5, op. 82',
    piece.type = 'album', piece.opus_number = 'Op. 82',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8801 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non tropo', part.name_en = 'Sonata para piano nº 5, op. 82: I. Allegro non tropo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8801 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:0cacc725-0a71-487e-9410-a8cd16b58ae7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0cacc725-0a71-487e-9410-a8cd16b58ae7', 1, 'I', 'Allegro non tropo', 'Sonata para piano nº 5, op. 82: I. Allegro non tropo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8801 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cacc725-0a71-487e-9410-a8cd16b58ae7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Minueto del gallo', part.name_en = 'Sonata para piano nº 5, op. 82: II. Minueto del gallo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8801 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:2167feb6-6866-49c1-88f4-f1c082d6db13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2167feb6-6866-49c1-88f4-f1c082d6db13', 2, 'II', 'Minueto del gallo', 'Sonata para piano nº 5, op. 82: II. Minueto del gallo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8801 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2167feb6-6866-49c1-88f4-f1c082d6db13'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rêverie et allegro', part.name_en = 'Sonata para piano nº 5, op. 82: III. Rêverie et allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8801 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:2d089bd1-1412-4573-aecc-4990e541b704' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d089bd1-1412-4573-aecc-4990e541b704', 3, 'III', 'Rêverie et allegro', 'Sonata para piano nº 5, op. 82: III. Rêverie et allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8801 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d089bd1-1412-4573-aecc-4990e541b704'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'Sonata para piano nº 5, op. 82: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8801 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:0f507560-4709-43c5-a751-e4422cc0411a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f507560-4709-43c5-a751-e4422cc0411a', 4, 'IV', 'Allegro', 'Sonata para piano nº 5, op. 82: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8801 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f507560-4709-43c5-a751-e4422cc0411a'
);


-- Op. 64 Suite ancienne no. 2

UPDATE pieces piece
SET piece.title = 'Suite ancienne no. 2', piece.title_en = 'Suite ancienne no. 2, op. 64',
    piece.type = 'album', piece.opus_number = 'Op. 64',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7892 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sarabande', part.name_en = 'Suite ancienne no. 2, op. 64: I. Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7892 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:24252540-f12b-405e-9be0-417937f6c20a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24252540-f12b-405e-9be0-417937f6c20a', 1, 'I', 'Sarabande', 'Suite ancienne no. 2, op. 64: I. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7892 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24252540-f12b-405e-9be0-417937f6c20a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Chaconne', part.name_en = 'Suite ancienne no. 2, op. 64: II. Chaconne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7892 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:b83bb732-0ed2-4921-b959-33ee6f1f1452' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b83bb732-0ed2-4921-b959-33ee6f1f1452', 2, 'II', 'Chaconne', 'Suite ancienne no. 2, op. 64: II. Chaconne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7892 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b83bb732-0ed2-4921-b959-33ee6f1f1452'
);


-- Op. 54 Suite ancienne

UPDATE pieces piece
SET piece.title = 'Suite ancienne', piece.title_en = 'Suite ancienne, op. 54',
    piece.type = 'album', piece.opus_number = 'Op. 54',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8633 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Gavota', part.name_en = 'Suite ancienne, op. 54: I. Gavota',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8633 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:04e6b30f-fc01-4501-b7dc-2f595bc3f75e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04e6b30f-fc01-4501-b7dc-2f595bc3f75e', 1, 'I', 'Gavota', 'Suite ancienne, op. 54: I. Gavota', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8633 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04e6b30f-fc01-4501-b7dc-2f595bc3f75e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Minuetto', part.name_en = 'Suite ancienne, op. 54: II. Minuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8633 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:604ea30c-949f-4d65-a15f-b0390dbdd447' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:604ea30c-949f-4d65-a15f-b0390dbdd447', 2, 'II', 'Minuetto', 'Suite ancienne, op. 54: II. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8633 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:604ea30c-949f-4d65-a15f-b0390dbdd447'
);


-- Op. 97 Suite española nº 2

UPDATE pieces piece
SET piece.title = 'Suite española nº 2', piece.title_en = 'Suite española nº 2, op. 97',
    piece.type = 'album', piece.opus_number = 'Op. 97',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10088 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Zaragoza', part.name_en = 'Suite española nº 2, op. 97: I. Zaragoza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10088 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:da193296-3464-4408-859b-6fc3fc207f84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da193296-3464-4408-859b-6fc3fc207f84', 1, 'I', 'Zaragoza', 'Suite española nº 2, op. 97: I. Zaragoza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10088 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da193296-3464-4408-859b-6fc3fc207f84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sevilla', part.name_en = 'Suite española nº 2, op. 97: II. Sevilla',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10088 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:0912e1d5-845f-4107-ac81-1d02db5ee36f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0912e1d5-845f-4107-ac81-1d02db5ee36f', 2, 'II', 'Sevilla', 'Suite española nº 2, op. 97: II. Sevilla', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10088 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0912e1d5-845f-4107-ac81-1d02db5ee36f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Cádiz - gaditana', part.name_en = 'Suite española nº 2, op. 97: III. Cádiz - gaditana',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10088 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:61bc3d57-dac8-44fa-90ad-5517bd790bb2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61bc3d57-dac8-44fa-90ad-5517bd790bb2', 3, 'III', 'Cádiz - gaditana', 'Suite española nº 2, op. 97: III. Cádiz - gaditana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10088 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61bc3d57-dac8-44fa-90ad-5517bd790bb2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Zambra granadina', part.name_en = 'Suite española nº 2, op. 97: IV. Zambra granadina',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10088 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:0b23f593-8af7-40dc-9c79-ad1b7a3337c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b23f593-8af7-40dc-9c79-ad1b7a3337c3', 4, 'IV', 'Zambra granadina', 'Suite española nº 2, op. 97: IV. Zambra granadina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10088 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b23f593-8af7-40dc-9c79-ad1b7a3337c3'
);


-- None Tango, T 94 B

UPDATE pieces piece
SET piece.title = 'Tango, T 94 B', piece.title_en = 'Tango, T 94 B',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11231 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <The Magic Opal>

UPDATE pieces piece
SET piece.title = '오페라 <The Magic Opal>', piece.title_en = 'The Magic Opal',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9902 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act II: Ballet', part.name_en = 'The Magic Opal: Act II: Ballet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9902 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:16a98903-e8f8-457f-9f06-7fbce0189c8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16a98903-e8f8-457f-9f06-7fbce0189c8d', 1, NULL, 'Act II: Ballet', 'The Magic Opal: Act II: Ballet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9902 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16a98903-e8f8-457f-9f06-7fbce0189c8d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II: Prelude', part.name_en = 'The Magic Opal: Act II: Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9902 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:46ca01d8-789b-44b9-9fcc-7f96f67388f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46ca01d8-789b-44b9-9fcc-7f96f67388f5', 2, NULL, 'Act II: Prelude', 'The Magic Opal: Act II: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9902 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46ca01d8-789b-44b9-9fcc-7f96f67388f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'The Magic Opal: Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9902 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:e166dddb-ab4f-442d-8e40-31de80a266d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e166dddb-ab4f-442d-8e40-31de80a266d2', 3, NULL, 'Overture', 'The Magic Opal: Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9902 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e166dddb-ab4f-442d-8e40-31de80a266d2'
);


-- None To Nellie

UPDATE pieces piece
SET piece.title = 'To Nellie', piece.title_en = 'To Nellie',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9074 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Home', part.name_en = 'Home',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9074 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:c91017d7-fa3f-4749-93c0-6fd2e32b76a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c91017d7-fa3f-4749-93c0-6fd2e32b76a9', 1, NULL, 'Home', 'Home', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9074 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c91017d7-fa3f-4749-93c0-6fd2e32b76a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Counsel', part.name_en = 'Counsel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9074 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:cd15df1f-c512-411c-92a6-0660b548ab98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd15df1f-c512-411c-92a6-0660b548ab98', 2, NULL, 'Counsel', 'Counsel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9074 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd15df1f-c512-411c-92a6-0660b548ab98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'May-Day Song', part.name_en = 'May-Day Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9074 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:8e10dee4-62a1-44f1-8dd4-51e92f86dcc8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e10dee4-62a1-44f1-8dd4-51e92f86dcc8', 3, NULL, 'May-Day Song', 'May-Day Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9074 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e10dee4-62a1-44f1-8dd4-51e92f86dcc8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'To Nelly', part.name_en = 'To Nelly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9074 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:9169c8d7-630f-46ff-b52b-71a0dfe862cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9169c8d7-630f-46ff-b52b-71a0dfe862cd', 4, NULL, 'To Nelly', 'To Nelly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9074 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9169c8d7-630f-46ff-b52b-71a0dfe862cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'A Song of Consolation', part.name_en = 'A Song of Consolation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9074 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:1a54afc5-10d9-4fb0-8835-7ee5f371fe96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a54afc5-10d9-4fb0-8835-7ee5f371fe96', 5, NULL, 'A Song of Consolation', 'A Song of Consolation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9074 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a54afc5-10d9-4fb0-8835-7ee5f371fe96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'A Song (Love Comes to All)', part.name_en = 'A Song (Love Comes to All)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9074 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:9a6776b8-c62e-415d-a69d-f0013d32ecf4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a6776b8-c62e-415d-a69d-f0013d32ecf4', 6, NULL, 'A Song (Love Comes to All)', 'A Song (Love Comes to All)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9074 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a6776b8-c62e-415d-a69d-f0013d32ecf4'
);


-- None Troisième Suite ancienne, T. 76

UPDATE pieces piece
SET piece.title = 'Troisième Suite ancienne, T. 76', piece.title_en = 'Troisième Suite ancienne, T. 76',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8676 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Minuetto', part.name_en = 'Troisième Suite ancienne, T. 76: I. Minuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8676 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:a15927f7-7ffa-4def-9eb8-274716d0330b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a15927f7-7ffa-4def-9eb8-274716d0330b', 1, 'I', 'Minuetto', 'Troisième Suite ancienne, T. 76: I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8676 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a15927f7-7ffa-4def-9eb8-274716d0330b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Gavotta', part.name_en = 'Troisième Suite ancienne, T. 76: II. Gavotta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8676 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:f247e1ba-480d-44f2-9b13-6d74cee2f69e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f247e1ba-480d-44f2-9b13-6d74cee2f69e', 2, 'II', 'Gavotta', 'Troisième Suite ancienne, T. 76: II. Gavotta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8676 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f247e1ba-480d-44f2-9b13-6d74cee2f69e'
);


-- None 가곡 <Veux‐tu partir un jour ?>

UPDATE pieces piece
SET piece.title = '가곡 <Veux‐tu partir un jour ?>', piece.title_en = 'Veux‐tu partir un jour ?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7939 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Yvonne en visite!

UPDATE pieces piece
SET piece.title = 'Yvonne en visite!', piece.title_en = 'Yvonne en visite!',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7959 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'La révérence!', part.name_en = 'Yvonne en visite!: I. La révérence!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7959 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:793ceed9-42b8-3bce-9037-3ea9f7b8492d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:793ceed9-42b8-3bce-9037-3ea9f7b8492d', 1, 'I', 'La révérence!', 'Yvonne en visite!: I. La révérence!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7959 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:793ceed9-42b8-3bce-9037-3ea9f7b8492d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Joyeuse rencontre et quelques pénibles événements!', part.name_en = 'Yvonne en visite!: II. Joyeuse rencontre et quelques pénibles événements!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7959 AND p.composer_id = 66 AND part.part_key = 'musicbrainz:6f4f3f52-9a87-3fef-8eac-22025b06c7cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f4f3f52-9a87-3fef-8eac-22025b06c7cc', 2, 'II', 'Joyeuse rencontre et quelques pénibles événements!', 'Yvonne en visite!: II. Joyeuse rencontre et quelques pénibles événements!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7959 AND p.composer_id = 66
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f4f3f52-9a87-3fef-8eac-22025b06c7cc'
);


-- B. 42 Zambra granadina (Danse orientale) in D minor

UPDATE pieces piece
SET piece.title = 'Zambra granadina (Danse orientale) in D minor', piece.title_en = 'Zambra granadina (Danse orientale) in D minor, B. 42',
    piece.type = 'song', piece.opus_number = 'B. 42',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9887 AND piece.composer_id = 66
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Amor, summa injuria

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Amor, summa injuria', 'Amor, summa injuria', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 66
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Amor, summa injuria'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3beb0b74-056b-4d04-940d-0bd84569810f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3beb0b74-056b-4d04-940d-0bd84569810f'
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Amor, summa injuria' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3beb0b74-056b-4d04-940d-0bd84569810f'
);


-- None Catalonia

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Catalonia', 'Catalonia', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 66
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Catalonia'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3e33ebe-a7fe-4a27-a434-b00253e4c544'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd3e33ebe-a7fe-4a27-a434-b00253e4c544'
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Catalonia' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3e33ebe-a7fe-4a27-a434-b00253e4c544'
);


-- B. 47 Iberia B. 47

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Iberia B. 47', 'Iberia, B. 47', 'album', NULL, 'B.', '47', NULL, 'manual', 1
FROM composers c
WHERE c.id = 66
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Iberia B. 47'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd79d77d6-957d-4a7e-bde4-7634707b9a3e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd79d77d6-957d-4a7e-bde4-7634707b9a3e'
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Iberia B. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd79d77d6-957d-4a7e-bde4-7634707b9a3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e562edf-ff1e-3a9a-910a-7c16e7a37c1a', 1, NULL, 'Book I: I. Evocación', 'Iberia, B. 47: Book I: I. Evocación', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Iberia B. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e562edf-ff1e-3a9a-910a-7c16e7a37c1a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3ac9852-bf8b-362b-952c-08bbc5dc3e73', 2, NULL, 'Book I: II. El puerto', 'Iberia, B. 47: Book I: II. El puerto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Iberia B. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3ac9852-bf8b-362b-952c-08bbc5dc3e73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eecc1f59-7c31-343d-a546-2bde9389d847', 3, NULL, 'Book I: III. El Corpus en Sevilla', 'Iberia, B. 47: Book I: III. El Corpus en Sevilla', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Iberia B. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eecc1f59-7c31-343d-a546-2bde9389d847'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2669c3a8-1ebb-340d-9bc2-505c73165673', 4, NULL, 'Book II: I. Rondeña', 'Iberia, B. 47: Book II: I. Rondeña', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Iberia B. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2669c3a8-1ebb-340d-9bc2-505c73165673'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c63e0ac-ec99-30e7-99d0-d34ed09fc06b', 5, NULL, 'Book II: II. Almería', 'Iberia, B. 47: Book II: II. Almería', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Iberia B. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c63e0ac-ec99-30e7-99d0-d34ed09fc06b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bbf05b5-f77b-3608-9665-8da77ef8984d', 6, NULL, 'Book II: III. Triana', 'Iberia, B. 47: Book II: III. Triana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Iberia B. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bbf05b5-f77b-3608-9665-8da77ef8984d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3575cd7-b7e4-368c-a3d5-062b5b90f147', 7, NULL, 'Book III: I. El Albaicín', 'Iberia, B. 47: Book III: I. El Albaicín', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Iberia B. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3575cd7-b7e4-368c-a3d5-062b5b90f147'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2621bc5c-7a82-34d9-abfe-7707abdb2219', 8, NULL, 'Book III: II. El Polo', 'Iberia, B. 47: Book III: II. El Polo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Iberia B. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2621bc5c-7a82-34d9-abfe-7707abdb2219'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8333a717-f8d3-3049-ba4a-c9511effaee6', 9, NULL, 'Book III: III. Lavapiés', 'Iberia, B. 47: Book III: III. Lavapiés', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Iberia B. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8333a717-f8d3-3049-ba4a-c9511effaee6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a641e2d-8b49-350a-8578-0d9098bed37c', 10, NULL, 'Book IV: I. Málaga', 'Iberia, B. 47: Book IV: I. Málaga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Iberia B. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a641e2d-8b49-350a-8578-0d9098bed37c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54a46d49-4c52-3153-9fe8-598a54b7ee51', 11, NULL, 'Book IV: II. Jerez', 'Iberia, B. 47: Book IV: II. Jerez', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Iberia B. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54a46d49-4c52-3153-9fe8-598a54b7ee51'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45c160af-50fb-3bab-a6fa-ef2502211103', 12, NULL, 'Book IV: III. Eritaña', 'Iberia, B. 47: Book IV: III. Eritaña', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Iberia B. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45c160af-50fb-3bab-a6fa-ef2502211103'
);


-- Op. 202 Mallorca

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Mallorca', 'Mallorca, op. 202', 'song', 'Op. 202', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 66
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Mallorca'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de3b34e5-d2a9-310d-9818-c23bb36c2600'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'de3b34e5-d2a9-310d-9818-c23bb36c2600'
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Mallorca' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de3b34e5-d2a9-310d-9818-c23bb36c2600'
);


-- Op. 12 Pavana-capricho

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Pavana-capricho', 'Pavana-capricho, op. 12', 'song', 'Op. 12', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 66
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Pavana-capricho'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7043da32-5ff9-35eb-8a7b-dd3c7d123d7d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7043da32-5ff9-35eb-8a7b-dd3c7d123d7d'
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Pavana-capricho' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7043da32-5ff9-35eb-8a7b-dd3c7d123d7d'
);


-- Op. 70 Rapsodia española

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Rapsodia española', 'Rapsodia española, op. 70', 'song', 'Op. 70', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 66
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Rapsodia española'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '69d365ca-3df6-49fc-8f6a-6cacd2b39df3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '69d365ca-3df6-49fc-8f6a-6cacd2b39df3'
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Rapsodia española' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '69d365ca-3df6-49fc-8f6a-6cacd2b39df3'
);


-- Op. 181 Serenata española

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Serenata española', 'Serenata española, op. 181', 'song', 'Op. 181', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 66
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Serenata española'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1576271-dd04-48c9-a5bf-8aa362c8bf9b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b1576271-dd04-48c9-a5bf-8aa362c8bf9b'
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Serenata española' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1576271-dd04-48c9-a5bf-8aa362c8bf9b'
);


-- Op. 47 Suite española no. 1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Suite española no. 1', 'Suite española no. 1, op. 47', 'album', 'Op. 47', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 66
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Suite española no. 1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca59a57d-28e0-4eee-8ee7-4f4635b922da'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ca59a57d-28e0-4eee-8ee7-4f4635b922da'
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Suite española no. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca59a57d-28e0-4eee-8ee7-4f4635b922da'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:165b28c7-3590-44ab-a66d-47ee9e713945', 1, 'I', 'Granada (Serenata)', 'Suite española no. 1, op. 47: I. Granada (Serenata)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Suite española no. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:165b28c7-3590-44ab-a66d-47ee9e713945'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0ac4d74-a840-4a63-b115-9416513be25a', 2, 'II', 'Cataluña (Curranda)', 'Suite española no. 1, op. 47: II. Cataluña (Curranda)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Suite española no. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0ac4d74-a840-4a63-b115-9416513be25a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb6cfcdb-ce0d-4b73-b060-a36f0e3b5201', 3, 'III', 'Sevilla (Sevillanas)', 'Suite española no. 1, op. 47: III. Sevilla (Sevillanas)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Suite española no. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb6cfcdb-ce0d-4b73-b060-a36f0e3b5201'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1725f239-f1ea-469d-a0e5-181c150b6a25', 4, 'IV', 'Cádiz (Saeta)', 'Suite española no. 1, op. 47: IV. Cádiz (Saeta)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Suite española no. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1725f239-f1ea-469d-a0e5-181c150b6a25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30a6a036-7f95-44d4-82d8-d9ed3f51fb1d', 5, 'VI', 'Aragón (Fantasía)', 'Suite española no. 1, op. 47: VI. Aragón (Fantasía)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Suite española no. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30a6a036-7f95-44d4-82d8-d9ed3f51fb1d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:feacbd26-6a01-445e-b09b-ecc0b0dce8f0', 6, 'VII', 'Castilla (Seguidillas)', 'Suite española no. 1, op. 47: VII. Castilla (Seguidillas)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Suite española no. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:feacbd26-6a01-445e-b09b-ecc0b0dce8f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb54cd2c-44cb-469a-a6ee-15d6e0d754b5', 7, 'VIII', 'Cuba (Nocturno)', 'Suite española no. 1, op. 47: VIII. Cuba (Nocturno)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 66 AND p.title = 'Suite española no. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb54cd2c-44cb-469a-a6ee-15d6e0d754b5'
);


-- 카탈로그에 대응이 없는 seed 작품 14개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 66 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    7515, 8071, 8471, 8509, 8590, 9318, 9376, 9642, 10292, 10689, 10714, 11141, 11177, 11249
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
