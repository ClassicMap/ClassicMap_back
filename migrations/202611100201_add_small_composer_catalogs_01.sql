-- 작곡가 20명의 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동, 1/9).
-- 작품 124개(새 9개), seed 122개 중 잇기 115·숨김 6·그대로 1.
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

-- ===== 부르크뮐러 (composer_id 72) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 6개(묶음 4, 다악장 0, 낱곡 2),
-- 새 작품 0개, part 58개, 그 아래 0개.
-- seed 8개 중 6개를 작품·part 에 잇고, 2개를 숨기고, 0개는 그대로 둔다.

-- Op. 105 12개의 연습곡 Op. 105

UPDATE pieces piece
SET piece.title = '12개의 연습곡 Op. 105', piece.title_en = '12 Études, op. 105',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '105',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11806 AND piece.composer_id = 72
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = '12 Études, op. 105: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11806 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:f5ab7c46-9b40-4fa4-85c8-97dd0adecb76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5ab7c46-9b40-4fa4-85c8-97dd0adecb76', 1, NULL, 'No. 1', '12 Études, op. 105: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11806 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5ab7c46-9b40-4fa4-85c8-97dd0adecb76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = '12 Études, op. 105: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11806 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:4206ce23-fcea-4dbb-9679-1348e075850e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4206ce23-fcea-4dbb-9679-1348e075850e', 2, NULL, 'No. 2', '12 Études, op. 105: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11806 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4206ce23-fcea-4dbb-9679-1348e075850e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = '12 Études, op. 105: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11806 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:48c314ff-07dd-47f8-a092-9ed811f9f389' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48c314ff-07dd-47f8-a092-9ed811f9f389', 3, NULL, 'No. 3', '12 Études, op. 105: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11806 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48c314ff-07dd-47f8-a092-9ed811f9f389'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'No. 4', part.name_en = '12 Études, op. 105: No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11806 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:9d5cebf0-115a-4b9e-aaec-97641aba89e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d5cebf0-115a-4b9e-aaec-97641aba89e6', 4, NULL, 'No. 4', '12 Études, op. 105: No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11806 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d5cebf0-115a-4b9e-aaec-97641aba89e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'No. 5', part.name_en = '12 Études, op. 105: No. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11806 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:d35452b1-0f18-4a74-9124-9ae94417c12b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d35452b1-0f18-4a74-9124-9ae94417c12b', 5, NULL, 'No. 5', '12 Études, op. 105: No. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11806 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d35452b1-0f18-4a74-9124-9ae94417c12b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'No. 6', part.name_en = '12 Études, op. 105: No. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11806 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:f2013b36-06ab-4d49-a922-a2902e011b7d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2013b36-06ab-4d49-a922-a2902e011b7d', 6, NULL, 'No. 6', '12 Études, op. 105: No. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11806 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2013b36-06ab-4d49-a922-a2902e011b7d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'No. 7', part.name_en = '12 Études, op. 105: No. 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11806 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:00fc8bd4-0e18-4f70-b169-0b99ee8cca95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00fc8bd4-0e18-4f70-b169-0b99ee8cca95', 7, NULL, 'No. 7', '12 Études, op. 105: No. 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11806 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00fc8bd4-0e18-4f70-b169-0b99ee8cca95'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'No. 8', part.name_en = '12 Études, op. 105: No. 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11806 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:425be136-7fe4-4f9d-a9a4-0a39decf2026' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:425be136-7fe4-4f9d-a9a4-0a39decf2026', 8, NULL, 'No. 8', '12 Études, op. 105: No. 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11806 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:425be136-7fe4-4f9d-a9a4-0a39decf2026'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'No. 9', part.name_en = '12 Études, op. 105: No. 9',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11806 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:97ecd14a-ab26-4004-8321-f740695c51d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97ecd14a-ab26-4004-8321-f740695c51d9', 9, NULL, 'No. 9', '12 Études, op. 105: No. 9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11806 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97ecd14a-ab26-4004-8321-f740695c51d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'No. 10', part.name_en = '12 Études, op. 105: No. 10',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11806 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:79400bc0-6a88-47ee-961f-0048bbf86cf2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79400bc0-6a88-47ee-961f-0048bbf86cf2', 10, NULL, 'No. 10', '12 Études, op. 105: No. 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11806 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79400bc0-6a88-47ee-961f-0048bbf86cf2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'No. 11', part.name_en = '12 Études, op. 105: No. 11',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11806 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:37d33d34-2505-4610-82b2-9d33086dc683' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37d33d34-2505-4610-82b2-9d33086dc683', 11, NULL, 'No. 11', '12 Études, op. 105: No. 11', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11806 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37d33d34-2505-4610-82b2-9d33086dc683'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'No. 12', part.name_en = '12 Études, op. 105: No. 12',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11806 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:5aae35dd-7617-43a7-9fb7-a6c5a7511b6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5aae35dd-7617-43a7-9fb7-a6c5a7511b6a', 12, NULL, 'No. 12', '12 Études, op. 105: No. 12', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11806 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5aae35dd-7617-43a7-9fb7-a6c5a7511b6a'
);


-- Op. 109 18개의 연습곡 Op. 109

UPDATE pieces piece
SET piece.title = '18개의 연습곡 Op. 109', piece.title_en = '18 Études, op. 109',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '109',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11781 AND piece.composer_id = 72
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Agitato', part.name_en = '18 Études, op. 109: No. 8. Agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11781 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:0ac1ff49-4dc8-4ecf-881f-254dc09159e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ac1ff49-4dc8-4ecf-881f-254dc09159e6', 1, NULL, 'Agitato', '18 Études, op. 109: No. 8. Agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11781 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ac1ff49-4dc8-4ecf-881f-254dc09159e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'La Cloche des Matines', part.name_en = '18 Études, op. 109: No. 9. La Cloche des Matines',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11781 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:0fc8fd48-8c3f-42e8-abf4-38ba8e281179' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fc8fd48-8c3f-42e8-abf4-38ba8e281179', 2, NULL, 'La Cloche des Matines', '18 Études, op. 109: No. 9. La Cloche des Matines', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11781 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fc8fd48-8c3f-42e8-abf4-38ba8e281179'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Le Retour du Pâtre', part.name_en = '18 Études, op. 109: No. 3. Le Retour du Pâtre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11781 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:1321964b-03c8-4935-8498-fbd95b6b926a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1321964b-03c8-4935-8498-fbd95b6b926a', 3, NULL, 'Le Retour du Pâtre', '18 Études, op. 109: No. 3. Le Retour du Pâtre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11781 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1321964b-03c8-4935-8498-fbd95b6b926a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Refrain du Gondolier', part.name_en = '18 Études, op. 109: No. 14. Refrain du Gondolier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11781 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:3a93ccfa-51a6-439f-8e1a-e99a95a704ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a93ccfa-51a6-439f-8e1a-e99a95a704ea', 4, NULL, 'Refrain du Gondolier', '18 Études, op. 109: No. 14. Refrain du Gondolier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11781 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a93ccfa-51a6-439f-8e1a-e99a95a704ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'La Fileuse', part.name_en = '18 Études, op. 109: No. 18. La Fileuse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11781 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:45c0c8a6-2305-46bf-8a4b-64ea5082a1d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45c0c8a6-2305-46bf-8a4b-64ea5082a1d2', 5, NULL, 'La Fileuse', '18 Études, op. 109: No. 18. La Fileuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11781 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45c0c8a6-2305-46bf-8a4b-64ea5082a1d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Les Bohémiens', part.name_en = '18 Études, op. 109: No. 4. Les Bohémiens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11781 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:47efd02b-7da5-4bc3-96f3-bc22a169a777' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47efd02b-7da5-4bc3-96f3-bc22a169a777', 6, NULL, 'Les Bohémiens', '18 Études, op. 109: No. 4. Les Bohémiens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11781 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47efd02b-7da5-4bc3-96f3-bc22a169a777'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Le Réveil dans les Bois', part.name_en = '18 Études, op. 109: No. 12. Le Réveil dans les Bois',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11781 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:4ee899b2-285c-441b-a252-a05f9410b920' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ee899b2-285c-441b-a252-a05f9410b920', 7, NULL, 'Le Réveil dans les Bois', '18 Études, op. 109: No. 12. Le Réveil dans les Bois', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11781 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ee899b2-285c-441b-a252-a05f9410b920'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'La Source', part.name_en = '18 Études, op. 109: No. 5. La Source',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11781 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:57ccae24-c919-4435-b189-0ff67f1fcba3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57ccae24-c919-4435-b189-0ff67f1fcba3', 8, NULL, 'La Source', '18 Études, op. 109: No. 5. La Source', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11781 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57ccae24-c919-4435-b189-0ff67f1fcba3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'L''Orage', part.name_en = '18 Études, op. 109: No. 13. L''Orage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11781 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:6bf9244e-2d7b-4e2a-8c8f-00e1f982666a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bf9244e-2d7b-4e2a-8c8f-00e1f982666a', 9, NULL, 'L''Orage', '18 Études, op. 109: No. 13. L''Orage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11781 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bf9244e-2d7b-4e2a-8c8f-00e1f982666a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Les Sylphes', part.name_en = '18 Études, op. 109: No. 15. Les Sylphes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11781 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:70e291a0-4380-43e7-af42-545a9eee095e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70e291a0-4380-43e7-af42-545a9eee095e', 10, NULL, 'Les Sylphes', '18 Études, op. 109: No. 15. Les Sylphes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11781 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70e291a0-4380-43e7-af42-545a9eee095e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'La Marche', part.name_en = '18 Études, op. 109: No. 17. La Marche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11781 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:7fbec565-e124-403b-b4df-8b9027717740' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fbec565-e124-403b-b4df-8b9027717740', 11, NULL, 'La Marche', '18 Études, op. 109: No. 17. La Marche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11781 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fbec565-e124-403b-b4df-8b9027717740'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'L''enjouée', part.name_en = '18 Études, op. 109: No. 6. L''enjouée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11781 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:9aeeb652-6b25-4287-a005-fe636c49c990' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9aeeb652-6b25-4287-a005-fe636c49c990', 12, NULL, 'L''enjouée', '18 Études, op. 109: No. 6. L''enjouée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11781 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9aeeb652-6b25-4287-a005-fe636c49c990'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Berceuse', part.name_en = '18 Études, op. 109: No. 7. Berceuse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11781 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:9f416bbc-46cd-4534-9ab8-76cfa728dc85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f416bbc-46cd-4534-9ab8-76cfa728dc85', 13, NULL, 'Berceuse', '18 Études, op. 109: No. 7. Berceuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11781 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f416bbc-46cd-4534-9ab8-76cfa728dc85'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'La Sérénade', part.name_en = '18 Études, op. 109: No. 11. La Sérénade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11781 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:ab3c19cc-f8dc-4c18-8b35-cea14619871c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab3c19cc-f8dc-4c18-8b35-cea14619871c', 14, NULL, 'La Sérénade', '18 Études, op. 109: No. 11. La Sérénade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11781 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab3c19cc-f8dc-4c18-8b35-cea14619871c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Confidence', part.name_en = '18 Études, op. 109: No. 1. Confidence',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11781 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:b3296075-f52f-41aa-813e-8c068128b0f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3296075-f52f-41aa-813e-8c068128b0f8', 15, NULL, 'Confidence', '18 Études, op. 109: No. 1. Confidence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11781 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3296075-f52f-41aa-813e-8c068128b0f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'La Vélocite', part.name_en = '18 Études, op. 109: No. 10. La Vélocite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11781 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:b7453724-aa8d-44a1-ae14-a00f2b14aaf4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7453724-aa8d-44a1-ae14-a00f2b14aaf4', 16, NULL, 'La Vélocite', '18 Études, op. 109: No. 10. La Vélocite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11781 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7453724-aa8d-44a1-ae14-a00f2b14aaf4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Les Perles', part.name_en = '18 Études, op. 109: No. 2. Les Perles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11781 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:d420d177-aa44-4074-8b61-a660232d57aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d420d177-aa44-4074-8b61-a660232d57aa', 17, NULL, 'Les Perles', '18 Études, op. 109: No. 2. Les Perles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11781 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d420d177-aa44-4074-8b61-a660232d57aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'La Séparation', part.name_en = '18 Études, op. 109: No. 16. La Séparation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11781 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:ebb3dd77-9c9e-47d0-8d3e-2b8872ec87ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebb3dd77-9c9e-47d0-8d3e-2b8872ec87ca', 18, NULL, 'La Séparation', '18 Études, op. 109: No. 16. La Séparation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11781 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebb3dd77-9c9e-47d0-8d3e-2b8872ec87ca'
);


-- Op. 100 25 Études faciles et progressives Op. 100

UPDATE pieces piece
SET piece.title = '25 Études faciles et progressives Op. 100', piece.title_en = '25 Études faciles et progressives, op. 100',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '100',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11658 AND piece.composer_id = 72
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ballade', part.name_en = '25 Études faciles et progressives, op. 100: No. 15. Ballade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:009f5feb-ebd0-4acd-875b-43565c4a60ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:009f5feb-ebd0-4acd-875b-43565c4a60ef', 1, NULL, 'Ballade', '25 Études faciles et progressives, op. 100: No. 15. Ballade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:009f5feb-ebd0-4acd-875b-43565c4a60ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Le Courante Limpide (The Clear Stream)', part.name_en = '25 Études faciles et progressives, op. 100: No. 7. Le Courante Limpide (The Clear Stream)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:1a1a0adb-3647-44e8-acfa-3293bb1a5c9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a1a0adb-3647-44e8-acfa-3293bb1a5c9f', 2, NULL, 'Le Courante Limpide (The Clear Stream)', '25 Études faciles et progressives, op. 100: No. 7. Le Courante Limpide (The Clear Stream)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a1a0adb-3647-44e8-acfa-3293bb1a5c9f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La Petite Réunion (The Small Gathering)', part.name_en = '25 Études faciles et progressives, op. 100: No. 4. La Petite Réunion (The Small Gathering)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:241c123f-90b8-4535-9494-53587ad6fc24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:241c123f-90b8-4535-9494-53587ad6fc24', 3, NULL, 'La Petite Réunion (The Small Gathering)', '25 Études faciles et progressives, op. 100: No. 4. La Petite Réunion (The Small Gathering)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:241c123f-90b8-4535-9494-53587ad6fc24'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Innocence', part.name_en = '25 Études faciles et progressives, op. 100: No. 5. Innocence',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:277a6776-ead3-4e83-8758-bbf668f82868' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:277a6776-ead3-4e83-8758-bbf668f82868', 4, NULL, 'Innocence', '25 Études faciles et progressives, op. 100: No. 5. Innocence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:277a6776-ead3-4e83-8758-bbf668f82868'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Douce Plainte (Sighing)', part.name_en = '25 Études faciles et progressives, op. 100: No. 16. Douce Plainte (Sighing)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:3734e42a-dadd-488f-b389-1248bead857b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3734e42a-dadd-488f-b389-1248bead857b', 5, NULL, 'Douce Plainte (Sighing)', '25 Études faciles et progressives, op. 100: No. 16. Douce Plainte (Sighing)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3734e42a-dadd-488f-b389-1248bead857b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Arabesque', part.name_en = '25 Études faciles et progressives, op. 100: No. 2. Arabesque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:41701b5e-537f-455b-a70e-8d936e8acf66' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41701b5e-537f-455b-a70e-8d936e8acf66', 6, NULL, 'Arabesque', '25 Études faciles et progressives, op. 100: No. 2. Arabesque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41701b5e-537f-455b-a70e-8d936e8acf66'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'La Styrienne (Austrian Dance)', part.name_en = '25 Études faciles et progressives, op. 100: No. 14. La Styrienne (Austrian Dance)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:42e78b3e-2c56-4d4f-85c8-ba9e7fea0284' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42e78b3e-2c56-4d4f-85c8-ba9e7fea0284', 7, NULL, 'La Styrienne (Austrian Dance)', '25 Études faciles et progressives, op. 100: No. 14. La Styrienne (Austrian Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42e78b3e-2c56-4d4f-85c8-ba9e7fea0284'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'La Gracieuse (Gracefulness)', part.name_en = '25 Études faciles et progressives, op. 100: No. 8. La Gracieuse (Gracefulness)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:4b351731-18e4-4a46-970b-f4537420072a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b351731-18e4-4a46-970b-f4537420072a', 8, NULL, 'La Gracieuse (Gracefulness)', '25 Études faciles et progressives, op. 100: No. 8. La Gracieuse (Gracefulness)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b351731-18e4-4a46-970b-f4537420072a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'L’Adieu (Farewell)', part.name_en = '25 Études faciles et progressives, op. 100: No. 12. L’Adieu (Farewell)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:51d9937b-2ea7-40a1-853e-a70d6f882823' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51d9937b-2ea7-40a1-853e-a70d6f882823', 9, NULL, 'L’Adieu (Farewell)', '25 Études faciles et progressives, op. 100: No. 12. L’Adieu (Farewell)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51d9937b-2ea7-40a1-853e-a70d6f882823'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Consolation', part.name_en = '25 Études faciles et progressives, op. 100: No. 13. Consolation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:55c7d529-43fb-4c9c-a669-49300ba81119' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55c7d529-43fb-4c9c-a669-49300ba81119', 10, NULL, 'Consolation', '25 Études faciles et progressives, op. 100: No. 13. Consolation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55c7d529-43fb-4c9c-a669-49300ba81119'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Progrès', part.name_en = '25 Études faciles et progressives, op. 100: No. 6. Progrès',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:578a4671-156f-4d4e-bf1d-f689399ff039' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:578a4671-156f-4d4e-bf1d-f689399ff039', 11, NULL, 'Progrès', '25 Études faciles et progressives, op. 100: No. 6. Progrès', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:578a4671-156f-4d4e-bf1d-f689399ff039'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Pastorale', part.name_en = '25 Études faciles et progressives, op. 100: No. 3. Pastorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:59be7a1e-e24e-469c-ad21-af4d4dafec7c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59be7a1e-e24e-469c-ad21-af4d4dafec7c', 12, NULL, 'Pastorale', '25 Études faciles et progressives, op. 100: No. 3. Pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59be7a1e-e24e-469c-ad21-af4d4dafec7c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'La Candeur (Openness)', part.name_en = '25 Études faciles et progressives, op. 100: No. 1. La Candeur (Openness)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:61be6f77-7cf2-4178-a85c-bb6ca731fbc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61be6f77-7cf2-4178-a85c-bb6ca731fbc9', 13, NULL, 'La Candeur (Openness)', '25 Études faciles et progressives, op. 100: No. 1. La Candeur (Openness)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61be6f77-7cf2-4178-a85c-bb6ca731fbc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Inquiétude (Restlessness)', part.name_en = '25 Études faciles et progressives, op. 100: No. 18. Inquiétude (Restlessness)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:6daffcc3-8beb-4f59-969f-220bbb61c963' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6daffcc3-8beb-4f59-969f-220bbb61c963', 14, NULL, 'Inquiétude (Restlessness)', '25 Études faciles et progressives, op. 100: No. 18. Inquiétude (Restlessness)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6daffcc3-8beb-4f59-969f-220bbb61c963'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'La Chevaleresque (The Knight Errant)', part.name_en = '25 Études faciles et progressives, op. 100: No. 25. La Chevaleresque (The Knight Errant)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:78c2a0c0-f5e0-47ca-8306-889da39f6de8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78c2a0c0-f5e0-47ca-8306-889da39f6de8', 15, NULL, 'La Chevaleresque (The Knight Errant)', '25 Études faciles et progressives, op. 100: No. 25. La Chevaleresque (The Knight Errant)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78c2a0c0-f5e0-47ca-8306-889da39f6de8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'L’Harmonie des Anges (Angelic Harmony)', part.name_en = '25 Études faciles et progressives, op. 100: No. 21. L’Harmonie des Anges (Angelic Harmony)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:88110aa7-313e-4da1-aef0-40ef081305fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88110aa7-313e-4da1-aef0-40ef081305fd', 16, NULL, 'L’Harmonie des Anges (Angelic Harmony)', '25 Études faciles et progressives, op. 100: No. 21. L’Harmonie des Anges (Angelic Harmony)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88110aa7-313e-4da1-aef0-40ef081305fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Tarantelle', part.name_en = '25 Études faciles et progressives, op. 100: No. 20. Tarantelle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:8f11955f-8ff5-490d-ac5d-986706268191' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f11955f-8ff5-490d-ac5d-986706268191', 17, NULL, 'Tarantelle', '25 Études faciles et progressives, op. 100: No. 20. Tarantelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f11955f-8ff5-490d-ac5d-986706268191'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Tendre Fleur (Tender Flower)', part.name_en = '25 Études faciles et progressives, op. 100: No. 10. Tendre Fleur (Tender Flower)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:92ce909b-0101-43f5-86c3-c14aa4f41317' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92ce909b-0101-43f5-86c3-c14aa4f41317', 18, NULL, 'Tendre Fleur (Tender Flower)', '25 Études faciles et progressives, op. 100: No. 10. Tendre Fleur (Tender Flower)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92ce909b-0101-43f5-86c3-c14aa4f41317'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'L’Hirondelle (The Swallow)', part.name_en = '25 Études faciles et progressives, op. 100: No. 24. L’Hirondelle (The Swallow)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:95d3e80e-a33a-4f32-b58e-3e230188deb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95d3e80e-a33a-4f32-b58e-3e230188deb4', 19, NULL, 'L’Hirondelle (The Swallow)', '25 Études faciles et progressives, op. 100: No. 24. L’Hirondelle (The Swallow)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95d3e80e-a33a-4f32-b58e-3e230188deb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Le Retour (The Return)', part.name_en = '25 Études faciles et progressives, op. 100: No. 23. Le Retour (The Return)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:a4760183-d908-49c5-a748-5a53c1970ad6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4760183-d908-49c5-a748-5a53c1970ad6', 20, NULL, 'Le Retour (The Return)', '25 Études faciles et progressives, op. 100: No. 23. Le Retour (The Return)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4760183-d908-49c5-a748-5a53c1970ad6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'La Chasse (The Hunt)', part.name_en = '25 Études faciles et progressives, op. 100: No. 9. La Chasse (The Hunt)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:a81c6e5b-6272-4d56-a002-71e5b3cf4942' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a81c6e5b-6272-4d56-a002-71e5b3cf4942', 21, NULL, 'La Chasse (The Hunt)', '25 Études faciles et progressives, op. 100: No. 9. La Chasse (The Hunt)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a81c6e5b-6272-4d56-a002-71e5b3cf4942'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Barcarolle', part.name_en = '25 Études faciles et progressives, op. 100: No. 22. Barcarolle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:b9ce6449-c03b-4368-845a-f480a9da3566' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9ce6449-c03b-4368-845a-f480a9da3566', 22, NULL, 'Barcarolle', '25 Études faciles et progressives, op. 100: No. 22. Barcarolle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9ce6449-c03b-4368-845a-f480a9da3566'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'La Babillarde (The Chatterbox)', part.name_en = '25 Études faciles et progressives, op. 100: No. 17. La Babillarde (The Chatterbox)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:baf1705a-8ea7-4a82-84e9-d0483b98635e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:baf1705a-8ea7-4a82-84e9-d0483b98635e', 23, NULL, 'La Babillarde (The Chatterbox)', '25 Études faciles et progressives, op. 100: No. 17. La Babillarde (The Chatterbox)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:baf1705a-8ea7-4a82-84e9-d0483b98635e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'La Bergeronnette (The Wagtail)', part.name_en = '25 Études faciles et progressives, op. 100: No. 11. La Bergeronnette (The Wagtail)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:c2b9b164-4dc0-4be4-ae67-16dcb9bf379c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2b9b164-4dc0-4be4-ae67-16dcb9bf379c', 24, NULL, 'La Bergeronnette (The Wagtail)', '25 Études faciles et progressives, op. 100: No. 11. La Bergeronnette (The Wagtail)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2b9b164-4dc0-4be4-ae67-16dcb9bf379c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Ave Maria', part.name_en = '25 Études faciles et progressives, op. 100: No. 19. Ave Maria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11658 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:ff3c7411-83a1-4476-b483-5f5bd5cb01b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff3c7411-83a1-4476-b483-5f5bd5cb01b6', 25, NULL, 'Ave Maria', '25 Études faciles et progressives, op. 100: No. 19. Ave Maria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11658 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff3c7411-83a1-4476-b483-5f5bd5cb01b6'
);


-- None 3개의 첼로와 기타를 위한 녹턴

UPDATE pieces piece
SET piece.title = '3개의 첼로와 기타를 위한 녹턴', piece.title_en = '3 Nocturnes for Cello and Guitar',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11725 AND piece.composer_id = 72
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andantino', part.name_en = '3 Nocturnes for Cello and Guitar: No. 1. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11725 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:39b3751e-ba15-4a36-8bb3-126e59b4657d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39b3751e-ba15-4a36-8bb3-126e59b4657d', 1, NULL, 'Andantino', '3 Nocturnes for Cello and Guitar: No. 1. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11725 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39b3751e-ba15-4a36-8bb3-126e59b4657d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Adagio cantabile', part.name_en = '3 Nocturnes for Cello and Guitar: No. 2. Adagio cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11725 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:0707d46e-df2f-4edf-9c5d-52dffc1f8853' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0707d46e-df2f-4edf-9c5d-52dffc1f8853', 2, NULL, 'Adagio cantabile', '3 Nocturnes for Cello and Guitar: No. 2. Adagio cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11725 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0707d46e-df2f-4edf-9c5d-52dffc1f8853'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato', part.name_en = '3 Nocturnes for Cello and Guitar: No. 3. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11725 AND p.composer_id = 72 AND part.part_key = 'musicbrainz:741c0427-db91-49b1-b925-81da158ddd95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:741c0427-db91-49b1-b925-81da158ddd95', 3, NULL, 'Allegro moderato', '3 Nocturnes for Cello and Guitar: No. 3. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11725 AND p.composer_id = 72
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:741c0427-db91-49b1-b925-81da158ddd95'
);


-- Op. 105 No. 9 연습곡 E장조

UPDATE pieces piece
SET piece.title = '연습곡 E장조', piece.title_en = 'Etude in E major, op. 105 no. 9',
    piece.type = 'song', piece.opus_number = 'Op. 105 No. 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11538 AND piece.composer_id = 72
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Souvenirs de Ratisbonne

UPDATE pieces piece
SET piece.title = 'Souvenirs de Ratisbonne', piece.title_en = 'Souvenirs de Ratisbonne',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11843 AND piece.composer_id = 72
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 카탈로그에 대응이 없는 seed 작품 2개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 72 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    11388, 11940
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== 안익태 (composer_id 88) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 애국가 (South Korea)

UPDATE pieces piece
SET piece.title = '애국가 (South Korea)', piece.title_en = '애국가',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11348 AND piece.composer_id = 88
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== 강석희 (composer_id 113) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 3개(묶음 0, 다악장 1, 낱곡 2),
-- 새 작품 0개, part 3개, 그 아래 0개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Inventio - Musicae clavichordii et sonorum

UPDATE pieces piece
SET piece.title = 'Inventio - Musicae clavichordii et sonorum', piece.title_en = 'Inventio - Musicae clavichordii et sonorum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2358 AND piece.composer_id = 113
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Piano Sketches

UPDATE pieces piece
SET piece.title = 'Piano Sketches', piece.title_en = 'Piano Sketches',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1407 AND piece.composer_id = 113
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Quarter note = ca. 42', part.name_en = 'Piano Sketches: I. Quarter note = ca. 42',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1407 AND p.composer_id = 113 AND part.part_key = 'musicbrainz:ac77cf7b-d87b-4d63-a1bd-b4db8b18caf8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac77cf7b-d87b-4d63-a1bd-b4db8b18caf8', 1, 'I', 'Quarter note = ca. 42', 'Piano Sketches: I. Quarter note = ca. 42', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1407 AND p.composer_id = 113
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac77cf7b-d87b-4d63-a1bd-b4db8b18caf8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Dotted quarter note = ca. 80', part.name_en = 'Piano Sketches: II. Dotted quarter note = ca. 80',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1407 AND p.composer_id = 113 AND part.part_key = 'musicbrainz:c33dd4e5-29b8-4acb-94e1-bb3216387fe9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c33dd4e5-29b8-4acb-94e1-bb3216387fe9', 2, 'II', 'Dotted quarter note = ca. 80', 'Piano Sketches: II. Dotted quarter note = ca. 80', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1407 AND p.composer_id = 113
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c33dd4e5-29b8-4acb-94e1-bb3216387fe9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Quarter note = ca. 120', part.name_en = 'Piano Sketches: III. Quarter note = ca. 120',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1407 AND p.composer_id = 113 AND part.part_key = 'musicbrainz:8c1301b0-e450-44ef-92da-23df47f27e1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c1301b0-e450-44ef-92da-23df47f27e1a', 3, 'III', 'Quarter note = ca. 120', 'Piano Sketches: III. Quarter note = ca. 120', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1407 AND p.composer_id = 113
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c1301b0-e450-44ef-92da-23df47f27e1a'
);


-- None Sonate Bach

UPDATE pieces piece
SET piece.title = 'Sonate Bach', piece.title_en = 'Sonate Bach',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 920 AND piece.composer_id = 113
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Ilse Fromm-Michaels (composer_id 133) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 8개(묶음 1, 다악장 3, 낱곡 4),
-- 새 작품 0개, part 18개, 그 아래 0개.
-- seed 8개 중 8개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- Op. 5 Acht Skizzen

UPDATE pieces piece
SET piece.title = 'Acht Skizzen', piece.title_en = 'Acht Skizzen, op. 5',
    piece.type = 'album', piece.opus_number = 'Op. 5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18200 AND piece.composer_id = 133
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Nr. I', part.name_en = 'Acht Skizzen, op. 5: Nr. I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18200 AND p.composer_id = 133 AND part.part_key = 'musicbrainz:e9396282-65df-4719-9d20-f3bd76b7ca64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9396282-65df-4719-9d20-f3bd76b7ca64', 1, NULL, 'Nr. I', 'Acht Skizzen, op. 5: Nr. I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18200 AND p.composer_id = 133
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9396282-65df-4719-9d20-f3bd76b7ca64'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Nr. II', part.name_en = 'Acht Skizzen, op. 5: Nr. II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18200 AND p.composer_id = 133 AND part.part_key = 'musicbrainz:3282d367-cb11-422b-be53-10cebecfba34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3282d367-cb11-422b-be53-10cebecfba34', 2, NULL, 'Nr. II', 'Acht Skizzen, op. 5: Nr. II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18200 AND p.composer_id = 133
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3282d367-cb11-422b-be53-10cebecfba34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Nr. III', part.name_en = 'Acht Skizzen, op. 5: Nr. III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18200 AND p.composer_id = 133 AND part.part_key = 'musicbrainz:e749ac5c-8849-44ed-aab7-cd093f95d391' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e749ac5c-8849-44ed-aab7-cd093f95d391', 3, NULL, 'Nr. III', 'Acht Skizzen, op. 5: Nr. III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18200 AND p.composer_id = 133
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e749ac5c-8849-44ed-aab7-cd093f95d391'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Nr. IV', part.name_en = 'Acht Skizzen, op. 5: Nr. IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18200 AND p.composer_id = 133 AND part.part_key = 'musicbrainz:ad12a6f3-9565-442d-bbfb-a4323bf084b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad12a6f3-9565-442d-bbfb-a4323bf084b0', 4, NULL, 'Nr. IV', 'Acht Skizzen, op. 5: Nr. IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18200 AND p.composer_id = 133
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad12a6f3-9565-442d-bbfb-a4323bf084b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Nr. V', part.name_en = 'Acht Skizzen, op. 5: Nr. V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18200 AND p.composer_id = 133 AND part.part_key = 'musicbrainz:4e440beb-704c-4638-9327-bb4d819ee129' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e440beb-704c-4638-9327-bb4d819ee129', 5, NULL, 'Nr. V', 'Acht Skizzen, op. 5: Nr. V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18200 AND p.composer_id = 133
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e440beb-704c-4638-9327-bb4d819ee129'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Nr. VI', part.name_en = 'Acht Skizzen, op. 5: Nr. VI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18200 AND p.composer_id = 133 AND part.part_key = 'musicbrainz:a6e9022f-3efa-4b42-9f29-f8bfbb2edf96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6e9022f-3efa-4b42-9f29-f8bfbb2edf96', 6, NULL, 'Nr. VI', 'Acht Skizzen, op. 5: Nr. VI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18200 AND p.composer_id = 133
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6e9022f-3efa-4b42-9f29-f8bfbb2edf96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Nr. VII', part.name_en = 'Acht Skizzen, op. 5: Nr. VII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18200 AND p.composer_id = 133 AND part.part_key = 'musicbrainz:bfaa5735-818e-4a2f-a216-3c06ecdb8378' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfaa5735-818e-4a2f-a216-3c06ecdb8378', 7, NULL, 'Nr. VII', 'Acht Skizzen, op. 5: Nr. VII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18200 AND p.composer_id = 133
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfaa5735-818e-4a2f-a216-3c06ecdb8378'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Nr. VIII', part.name_en = 'Acht Skizzen, op. 5: Nr. VIII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18200 AND p.composer_id = 133 AND part.part_key = 'musicbrainz:1fe2ace3-2cc8-4c3e-89a4-99ade345c4a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fe2ace3-2cc8-4c3e-89a4-99ade345c4a8', 8, NULL, 'Nr. VIII', 'Acht Skizzen, op. 5: Nr. VIII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18200 AND p.composer_id = 133
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fe2ace3-2cc8-4c3e-89a4-99ade345c4a8'
);


-- None Langsamer Walzer

UPDATE pieces piece
SET piece.title = 'Langsamer Walzer', piece.title_en = 'Langsamer Walzer',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17513 AND piece.composer_id = 133
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 16 파사칼리아

UPDATE pieces piece
SET piece.title = '파사칼리아', piece.title_en = 'Passacaglia, op. 16',
    piece.type = 'song', piece.opus_number = 'Op. 16',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17304 AND piece.composer_id = 133
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 6 Sonate für Klavier

UPDATE pieces piece
SET piece.title = 'Sonate für Klavier', piece.title_en = 'Sonate für Klavier, op. 6',
    piece.type = 'album', piece.opus_number = 'Op. 6',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16576 AND piece.composer_id = 133
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Markig', part.name_en = 'Sonate für Klavier, op. 6: Markig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16576 AND p.composer_id = 133 AND part.part_key = 'musicbrainz:04a6d0ed-96de-4009-a728-03c2ea35ce65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04a6d0ed-96de-4009-a728-03c2ea35ce65', 1, NULL, 'Markig', 'Sonate für Klavier, op. 6: Markig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16576 AND p.composer_id = 133
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04a6d0ed-96de-4009-a728-03c2ea35ce65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sehr langsam. Frei im Zeitmaß', part.name_en = 'Sonate für Klavier, op. 6: Sehr langsam. Frei im Zeitmaß',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16576 AND p.composer_id = 133 AND part.part_key = 'musicbrainz:91d164c8-af32-40c5-9ac2-666aa6e71b6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91d164c8-af32-40c5-9ac2-666aa6e71b6c', 2, NULL, 'Sehr langsam. Frei im Zeitmaß', 'Sonate für Klavier, op. 6: Sehr langsam. Frei im Zeitmaß', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16576 AND p.composer_id = 133
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91d164c8-af32-40c5-9ac2-666aa6e71b6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Lebhaft, aber nicht schnell', part.name_en = 'Sonate für Klavier, op. 6: Lebhaft, aber nicht schnell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16576 AND p.composer_id = 133 AND part.part_key = 'musicbrainz:fe5bd4d4-174f-4e68-92e7-7b7600342753' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe5bd4d4-174f-4e68-92e7-7b7600342753', 3, NULL, 'Lebhaft, aber nicht schnell', 'Sonate für Klavier, op. 6: Lebhaft, aber nicht schnell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16576 AND p.composer_id = 133
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe5bd4d4-174f-4e68-92e7-7b7600342753'
);


-- Op. 11 Stimmungen eines Fauns für Klarinette solo Op. 11

UPDATE pieces piece
SET piece.title = 'Stimmungen eines Fauns für Klarinette solo Op. 11', piece.title_en = 'Stimmungen eines Fauns für Klarinette solo, op. 11',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '11',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18718 AND piece.composer_id = 133
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Klage', part.name_en = 'Stimmungen eines Fauns für Klarinette solo, op. 11: Klage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18718 AND p.composer_id = 133 AND part.part_key = 'musicbrainz:9c1f5b69-6586-32e7-81ad-8c3134c0dbb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c1f5b69-6586-32e7-81ad-8c3134c0dbb0', 1, NULL, 'Klage', 'Stimmungen eines Fauns für Klarinette solo, op. 11: Klage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18718 AND p.composer_id = 133
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c1f5b69-6586-32e7-81ad-8c3134c0dbb0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Schalkslaune', part.name_en = 'Stimmungen eines Fauns für Klarinette solo, op. 11: Schalkslaune',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18718 AND p.composer_id = 133 AND part.part_key = 'musicbrainz:0974f849-510f-3e43-8e1d-4e4278c7fc75' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0974f849-510f-3e43-8e1d-4e4278c7fc75', 2, NULL, 'Schalkslaune', 'Stimmungen eines Fauns für Klarinette solo, op. 11: Schalkslaune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18718 AND p.composer_id = 133
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0974f849-510f-3e43-8e1d-4e4278c7fc75'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Schwermut', part.name_en = 'Stimmungen eines Fauns für Klarinette solo, op. 11: Schwermut',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18718 AND p.composer_id = 133 AND part.part_key = 'musicbrainz:39756c44-7138-3bb3-bb5b-99e693b1f651' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39756c44-7138-3bb3-bb5b-99e693b1f651', 3, NULL, 'Schwermut', 'Stimmungen eines Fauns für Klarinette solo, op. 11: Schwermut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18718 AND p.composer_id = 133
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39756c44-7138-3bb3-bb5b-99e693b1f651'
);


-- Op. 8 Variationen über ein eigenes Thema

UPDATE pieces piece
SET piece.title = 'Variationen über ein eigenes Thema', piece.title_en = 'Variationen über ein eigenes Thema, op. 8',
    piece.type = 'song', piece.opus_number = 'Op. 8',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16124 AND piece.composer_id = 133
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 4 Vier Puppen

UPDATE pieces piece
SET piece.title = 'Vier Puppen', piece.title_en = 'Vier Puppen, op. 4',
    piece.type = 'album', piece.opus_number = 'Op. 4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19901 AND piece.composer_id = 133
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Der Holzsoldat', part.name_en = 'Vier Puppen, op. 4: Der Holzsoldat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19901 AND p.composer_id = 133 AND part.part_key = 'musicbrainz:e0f33ed8-4f72-4dcd-87f7-d41fe140cda6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0f33ed8-4f72-4dcd-87f7-d41fe140cda6', 1, NULL, 'Der Holzsoldat', 'Vier Puppen, op. 4: Der Holzsoldat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19901 AND p.composer_id = 133
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0f33ed8-4f72-4dcd-87f7-d41fe140cda6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Der Hampelmann', part.name_en = 'Vier Puppen, op. 4: Der Hampelmann',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19901 AND p.composer_id = 133 AND part.part_key = 'musicbrainz:3c622cda-9740-42a9-8627-ebe586c1aa6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c622cda-9740-42a9-8627-ebe586c1aa6c', 2, NULL, 'Der Hampelmann', 'Vier Puppen, op. 4: Der Hampelmann', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19901 AND p.composer_id = 133
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c622cda-9740-42a9-8627-ebe586c1aa6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Der Puppenmädchen', part.name_en = 'Vier Puppen, op. 4: Der Puppenmädchen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19901 AND p.composer_id = 133 AND part.part_key = 'musicbrainz:10effad2-c679-483d-a4be-407996a60f9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10effad2-c679-483d-a4be-407996a60f9f', 3, NULL, 'Der Puppenmädchen', 'Vier Puppen, op. 4: Der Puppenmädchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19901 AND p.composer_id = 133
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10effad2-c679-483d-a4be-407996a60f9f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Der Harlekin', part.name_en = 'Vier Puppen, op. 4: Der Harlekin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19901 AND p.composer_id = 133 AND part.part_key = 'musicbrainz:d8322429-9f43-4eda-ba24-508628d5b26f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8322429-9f43-4eda-ba24-508628d5b26f', 4, NULL, 'Der Harlekin', 'Vier Puppen, op. 4: Der Harlekin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19901 AND p.composer_id = 133
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8322429-9f43-4eda-ba24-508628d5b26f'
);


-- Op. 7 Walzerreigen

UPDATE pieces piece
SET piece.title = 'Walzerreigen', piece.title_en = 'Walzerreigen, op. 7',
    piece.type = 'song', piece.opus_number = 'Op. 7',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18323 AND piece.composer_id = 133
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Eugeniusz Knapik (composer_id 134) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 3개(묶음 1, 다악장 1, 낱곡 1),
-- 새 작품 0개, part 7개, 그 아래 0개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Corale, Interludio e Aria

UPDATE pieces piece
SET piece.title = 'Corale, Interludio e Aria', piece.title_en = 'Corale, Interludio e Aria',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16248 AND piece.composer_id = 134
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Corale', part.name_en = 'Corale, Interludio e Aria: Corale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16248 AND p.composer_id = 134 AND part.part_key = 'musicbrainz:aec0347a-ca5d-4be0-b9ae-2ecf2cb2ba72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aec0347a-ca5d-4be0-b9ae-2ecf2cb2ba72', 1, NULL, 'Corale', 'Corale, Interludio e Aria: Corale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16248 AND p.composer_id = 134
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aec0347a-ca5d-4be0-b9ae-2ecf2cb2ba72'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Interludio', part.name_en = 'Corale, Interludio e Aria: Interludio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16248 AND p.composer_id = 134 AND part.part_key = 'musicbrainz:67584763-9e1d-4ceb-9f42-2a5acb6c6ad8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67584763-9e1d-4ceb-9f42-2a5acb6c6ad8', 2, NULL, 'Interludio', 'Corale, Interludio e Aria: Interludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16248 AND p.composer_id = 134
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67584763-9e1d-4ceb-9f42-2a5acb6c6ad8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Aria', part.name_en = 'Corale, Interludio e Aria: Aria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16248 AND p.composer_id = 134 AND part.part_key = 'musicbrainz:54f72c47-4912-4598-b608-1e09c6177fa8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54f72c47-4912-4598-b608-1e09c6177fa8', 3, NULL, 'Aria', 'Corale, Interludio e Aria: Aria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16248 AND p.composer_id = 134
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54f72c47-4912-4598-b608-1e09c6177fa8'
);


-- None Tha' Munnot Waste No Time

UPDATE pieces piece
SET piece.title = 'Tha'' Munnot Waste No Time', piece.title_en = 'Tha'' Munnot Waste No Time',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16490 AND piece.composer_id = 134
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Up into the Silence

UPDATE pieces piece
SET piece.title = 'Up into the Silence', piece.title_en = 'Up into the Silence',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16736 AND piece.composer_id = 134
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'love is more thicker', part.name_en = 'Up into the Silence: I. love is more thicker...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16736 AND p.composer_id = 134 AND part.part_key = 'musicbrainz:1524a391-a85b-4f1d-a434-dea971637439' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1524a391-a85b-4f1d-a434-dea971637439', 1, 'I', 'love is more thicker', 'Up into the Silence: I. love is more thicker...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16736 AND p.composer_id = 134
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1524a391-a85b-4f1d-a434-dea971637439'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Unter den berstenden Eisspiegeln', part.name_en = 'Up into the Silence: II. Unter den berstenden Eisspiegeln...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16736 AND p.composer_id = 134 AND part.part_key = 'musicbrainz:00f172a9-8729-4c9d-8a08-7499b47fa264' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00f172a9-8729-4c9d-8a08-7499b47fa264', 2, 'II', 'Unter den berstenden Eisspiegeln', 'Up into the Silence: II. Unter den berstenden Eisspiegeln...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16736 AND p.composer_id = 134
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00f172a9-8729-4c9d-8a08-7499b47fa264'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'now air is air and thing is thing', part.name_en = 'Up into the Silence: III. now air is air and thing is thing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16736 AND p.composer_id = 134 AND part.part_key = 'musicbrainz:82f7141a-edec-444f-97a6-aa88f66c0f27' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82f7141a-edec-444f-97a6-aa88f66c0f27', 3, 'III', 'now air is air and thing is thing', 'Up into the Silence: III. now air is air and thing is thing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16736 AND p.composer_id = 134
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82f7141a-edec-444f-97a6-aa88f66c0f27'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'in time''s a noble mercy of proportion', part.name_en = 'Up into the Silence: IV. in time''s a noble mercy of proportion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16736 AND p.composer_id = 134 AND part.part_key = 'musicbrainz:ee8613d4-a7f0-419e-b414-44ea65478e09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee8613d4-a7f0-419e-b414-44ea65478e09', 4, 'IV', 'in time''s a noble mercy of proportion', 'Up into the Silence: IV. in time''s a noble mercy of proportion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16736 AND p.composer_id = 134
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee8613d4-a7f0-419e-b414-44ea65478e09'
);

-- 숨길 seed 작품 없음

-- ===== Albert Huybrechts (composer_id 136) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 1, 낱곡 0),
-- 새 작품 0개, part 3개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Sonatina for Flute & Viola

UPDATE pieces piece
SET piece.title = 'Sonatina for Flute & Viola', piece.title_en = 'Sonatina for Flute & Viola',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17115 AND piece.composer_id = 136
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Vif et joyeux', part.name_en = 'Sonatina for Flute & Viola: I. Vif et joyeux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17115 AND p.composer_id = 136 AND part.part_key = 'musicbrainz:2a13983f-0e62-459d-93d5-e7cbf528d1f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a13983f-0e62-459d-93d5-e7cbf528d1f5', 1, 'I', 'Vif et joyeux', 'Sonatina for Flute & Viola: I. Vif et joyeux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17115 AND p.composer_id = 136
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a13983f-0e62-459d-93d5-e7cbf528d1f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Très lent', part.name_en = 'Sonatina for Flute & Viola: II. Très lent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17115 AND p.composer_id = 136 AND part.part_key = 'musicbrainz:be49330e-061f-47cc-97b1-8c87384f8579' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be49330e-061f-47cc-97b1-8c87384f8579', 2, 'II', 'Très lent', 'Sonatina for Flute & Viola: II. Très lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17115 AND p.composer_id = 136
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be49330e-061f-47cc-97b1-8c87384f8579'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Animé, Vif et très rythmé', part.name_en = 'Sonatina for Flute & Viola: III. Animé, Vif et très rythmé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17115 AND p.composer_id = 136 AND part.part_key = 'musicbrainz:9308ac87-15c5-4a24-b495-beb9c774b4e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9308ac87-15c5-4a24-b495-beb9c774b4e6', 3, 'III', 'Animé, Vif et très rythmé', 'Sonatina for Flute & Viola: III. Animé, Vif et très rythmé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17115 AND p.composer_id = 136
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9308ac87-15c5-4a24-b495-beb9c774b4e6'
);

-- 숨길 seed 작품 없음

-- ===== Joji Yuasa (composer_id 138) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 17개(묶음 0, 다악장 1, 낱곡 16),
-- 새 작품 0개, part 2개, 그 아래 0개.
-- seed 18개 중 17개를 작품·part 에 잇고, 1개를 숨기고, 0개는 그대로 둔다.

-- None <ICON> on the Source of White Noise

UPDATE pieces piece
SET piece.title = '<ICON> on the Source of White Noise', piece.title_en = '<ICON> on the Source of White Noise',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15843 AND piece.composer_id = 138
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Study in White

UPDATE pieces piece
SET piece.title = 'A Study in White', piece.title_en = 'A Study in White',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17721 AND piece.composer_id = 138
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The Sea Darkens', part.name_en = 'A Study in White: I. The Sea Darkens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17721 AND p.composer_id = 138 AND part.part_key = 'musicbrainz:9d6a8c02-fc7d-4f98-99ae-0b20dcf4c09d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d6a8c02-fc7d-4f98-99ae-0b20dcf4c09d', 1, 'I', 'The Sea Darkens', 'A Study in White: I. The Sea Darkens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17721 AND p.composer_id = 138
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d6a8c02-fc7d-4f98-99ae-0b20dcf4c09d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'I''ve Lost It', part.name_en = 'A Study in White: II. I''ve Lost It',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17721 AND p.composer_id = 138 AND part.part_key = 'musicbrainz:017a101b-0bb0-4415-a5f2-906b11ee0985' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:017a101b-0bb0-4415-a5f2-906b11ee0985', 2, 'II', 'I''ve Lost It', 'A Study in White: II. I''ve Lost It', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17721 AND p.composer_id = 138
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:017a101b-0bb0-4415-a5f2-906b11ee0985'
);


-- None Clarinet Solitude

UPDATE pieces piece
SET piece.title = 'Clarinet Solitude', piece.title_en = 'Clarinet Solitude',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19882 AND piece.composer_id = 138
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music for the Main Pavilion of the Okinawa Ocean

UPDATE pieces piece
SET piece.title = 'Music for the Main Pavilion of the Okinawa Ocean', piece.title_en = 'Music for the Main Pavilion of the Okinawa Ocean',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15776 AND piece.composer_id = 138
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None My Blue Sky

UPDATE pieces piece
SET piece.title = 'My Blue Sky', piece.title_en = 'My Blue Sky',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15846 AND piece.composer_id = 138
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opening Bell at NHK Hall

UPDATE pieces piece
SET piece.title = 'Opening Bell at NHK Hall', piece.title_en = 'Opening Bell at NHK Hall',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15818 AND piece.composer_id = 138
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Projection Esemplastic

UPDATE pieces piece
SET piece.title = 'Projection Esemplastic', piece.title_en = 'Projection Esemplastic',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15744 AND piece.composer_id = 138
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Territory

UPDATE pieces piece
SET piece.title = 'Territory', piece.title_en = 'Territory',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17812 AND piece.composer_id = 138
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Midnight Sun

UPDATE pieces piece
SET piece.title = 'The Midnight Sun', piece.title_en = 'The Midnight Sun',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18008 AND piece.composer_id = 138
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Towards “The Midnight Sun“ - Homage to Ze-Ami

UPDATE pieces piece
SET piece.title = 'Towards “The Midnight Sun“ - Homage to Ze-Ami', piece.title_en = 'Towards “The Midnight Sun“ - Homage to Ze-Ami',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18777 AND piece.composer_id = 138
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Voices Coming

UPDATE pieces piece
SET piece.title = 'Voices Coming', piece.title_en = 'Voices Coming',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15786 AND piece.composer_id = 138
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None インター・ポジ・プレイ・ション

UPDATE pieces piece
SET piece.title = 'インター・ポジ・プレイ・ション', piece.title_en = 'インター・ポジ・プレイ・ション',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17436 AND piece.composer_id = 138
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None オン・ザ・キーボード

UPDATE pieces piece
SET piece.title = 'オン・ザ・キーボード', piece.title_en = 'オン・ザ・キーボード',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15767 AND piece.composer_id = 138
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None プロジェクション・エセンプラスティック フォー・ピアノス

UPDATE pieces piece
SET piece.title = 'プロジェクション・エセンプラスティック フォー・ピアノス', piece.title_en = 'プロジェクション・エセンプラスティック フォー・ピアノス',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18763 AND piece.composer_id = 138
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 内触覚的宇宙

UPDATE pieces piece
SET piece.title = '内触覚的宇宙', piece.title_en = '内触覚的宇宙',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15848 AND piece.composer_id = 138
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 演奏詩呼びかわし

UPDATE pieces piece
SET piece.title = '演奏詩呼びかわし', piece.title_en = '演奏詩呼びかわし',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17954 AND piece.composer_id = 138
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <耳をすましてごらん>

UPDATE pieces piece
SET piece.title = '가곡 <耳をすましてごらん>', piece.title_en = '耳をすましてごらん',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15731 AND piece.composer_id = 138
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 138 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    17678
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== 루이 에마뉘엘 자댕 (composer_id 140) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 0, 다악장 1, 낱곡 1),
-- 새 작품 0개, part 3개, 그 아래 0개.
-- seed 2개 중 2개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 가곡 <Colas, Colas, sois-moi fidèle!>

UPDATE pieces piece
SET piece.title = '가곡 <Colas, Colas, sois-moi fidèle!>', piece.title_en = 'Colas, Colas, sois-moi fidèle!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18935 AND piece.composer_id = 140
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 녹턴 3번 G단조

UPDATE pieces piece
SET piece.title = '녹턴 3번 G단조', piece.title_en = 'Nocturne no. 3 in G minor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16991 AND piece.composer_id = 140
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Nocturne no. 3 in G minor: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16991 AND p.composer_id = 140 AND part.part_key = 'musicbrainz:fece2fb5-e1ad-4148-af6c-a0e13e477c94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fece2fb5-e1ad-4148-af6c-a0e13e477c94', 1, 'I', 'Allegro', 'Nocturne no. 3 in G minor: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16991 AND p.composer_id = 140
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fece2fb5-e1ad-4148-af6c-a0e13e477c94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio espressivo', part.name_en = 'Nocturne no. 3 in G minor: II. Adagio espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16991 AND p.composer_id = 140 AND part.part_key = 'musicbrainz:6192fc96-4e6d-47de-8e00-bb86407404ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6192fc96-4e6d-47de-8e00-bb86407404ce', 2, 'II', 'Adagio espressivo', 'Nocturne no. 3 in G minor: II. Adagio espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16991 AND p.composer_id = 140
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6192fc96-4e6d-47de-8e00-bb86407404ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto: Allegro molto', part.name_en = 'Nocturne no. 3 in G minor: III. Allegretto: Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16991 AND p.composer_id = 140 AND part.part_key = 'musicbrainz:c4640aed-b033-4d6a-85f5-0040d9a1b258' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4640aed-b033-4d6a-85f5-0040d9a1b258', 3, 'III', 'Allegretto: Allegro molto', 'Nocturne no. 3 in G minor: III. Allegretto: Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16991 AND p.composer_id = 140
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4640aed-b033-4d6a-85f5-0040d9a1b258'
);

-- 숨길 seed 작품 없음

-- ===== 카타리누스 엘링 (composer_id 141) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 0, 다악장 1, 낱곡 1),
-- 새 작품 1개, part 3개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- Op. 45 No. 4 가곡 <Jeg vil ud!>

UPDATE pieces piece
SET piece.title = '가곡 <Jeg vil ud!>', piece.title_en = 'Jeg vil ud!, op. 45 no. 4',
    piece.type = 'song', piece.opus_number = 'Op. 45 No. 4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18489 AND piece.composer_id = 141
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 바이올린 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡', 'Violin Concerto', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 141
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9a2ee15c-a984-4d7b-a5d7-a54ab413e5de'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9a2ee15c-a984-4d7b-a5d7-a54ab413e5de'
FROM pieces p
WHERE p.composer_id = 141 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9a2ee15c-a984-4d7b-a5d7-a54ab413e5de'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19cde33a-c7fb-48f9-8642-916a3e15a14a', 1, 'I', 'Allegro', 'Violin Concerto: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 141 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19cde33a-c7fb-48f9-8642-916a3e15a14a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68491931-3285-4fcc-b306-dc660183189b', 2, 'II', 'Andante', 'Violin Concerto: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 141 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68491931-3285-4fcc-b306-dc660183189b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d93f498-12e5-4cd3-a223-e4a73dc31f5f', 3, 'III', 'Allegro vivace', 'Violin Concerto: III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 141 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d93f498-12e5-4cd3-a223-e4a73dc31f5f'
);

-- 숨길 seed 작품 없음

-- ===== Vsevolod Zaderatsky (composer_id 143) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 2개(묶음 2, 다악장 0, 낱곡 0),
-- 새 작품 0개, part 53개, 그 아래 0개.
-- seed 2개 중 2개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 24 Preludes and Fugues

UPDATE pieces piece
SET piece.title = '24 Preludes and Fugues', piece.title_en = '24 Preludes and Fugues',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17075 AND piece.composer_id = 143
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelude in B‐flat major', part.name_en = '24 Preludes and Fugues: no. 21, Prelude in B‐flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:011480ea-3949-4ffa-9e35-ea5dfb4fe644' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:011480ea-3949-4ffa-9e35-ea5dfb4fe644', 1, NULL, 'Prelude in B‐flat major', '24 Preludes and Fugues: no. 21, Prelude in B‐flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:011480ea-3949-4ffa-9e35-ea5dfb4fe644'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fugue in G‐sharp minor', part.name_en = '24 Preludes and Fugues: no. 12, Fugue in G‐sharp minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:01f9a136-857a-4589-abd5-f703cf526336' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01f9a136-857a-4589-abd5-f703cf526336', 2, NULL, 'Fugue in G‐sharp minor', '24 Preludes and Fugues: no. 12, Fugue in G‐sharp minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01f9a136-857a-4589-abd5-f703cf526336'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = '24 Preludes and Fugues: no. 2, Prelude in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:03c94a74-a5b6-4903-97c9-1ec36f951535' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03c94a74-a5b6-4903-97c9-1ec36f951535', 3, NULL, 'A단조', '24 Preludes and Fugues: no. 2, Prelude in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03c94a74-a5b6-4903-97c9-1ec36f951535'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Fugue in A‐flat major', part.name_en = '24 Preludes and Fugues: no. 17, Fugue in A‐flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:0657ab33-e869-4950-9789-59f238a18272' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0657ab33-e869-4950-9789-59f238a18272', 4, NULL, 'Fugue in A‐flat major', '24 Preludes and Fugues: no. 17, Fugue in A‐flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0657ab33-e869-4950-9789-59f238a18272'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'F장조', part.name_en = '24 Preludes and Fugues: no. 23, Prelude in F major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:087048ee-9b65-4e88-9105-2445f16df358' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:087048ee-9b65-4e88-9105-2445f16df358', 5, NULL, 'F장조', '24 Preludes and Fugues: no. 23, Prelude in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:087048ee-9b65-4e88-9105-2445f16df358'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Fugue in C‐sharp minor', part.name_en = '24 Preludes and Fugues: no. 10, Fugue in C‐sharp minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:0a9b0fa0-73da-4bba-afa1-63aceabc7c94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a9b0fa0-73da-4bba-afa1-63aceabc7c94', 6, NULL, 'Fugue in C‐sharp minor', '24 Preludes and Fugues: no. 10, Fugue in C‐sharp minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a9b0fa0-73da-4bba-afa1-63aceabc7c94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'D단조', part.name_en = '24 Preludes and Fugues: no. 24, Prelude in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:1805e14d-29ce-4354-9ae1-13658639ffed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1805e14d-29ce-4354-9ae1-13658639ffed', 7, NULL, 'D단조', '24 Preludes and Fugues: no. 24, Prelude in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1805e14d-29ce-4354-9ae1-13658639ffed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = '24 Preludes and Fugues: no. 2, Fugue in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:1b2ed3ee-218c-468b-93e4-12bcabea3fe2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b2ed3ee-218c-468b-93e4-12bcabea3fe2', 8, NULL, 'A단조', '24 Preludes and Fugues: no. 2, Fugue in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b2ed3ee-218c-468b-93e4-12bcabea3fe2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'B단조', part.name_en = '24 Preludes and Fugues: no. 6, Fugue in B minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:253e43eb-0e78-4ed2-9d6d-05185b4926a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:253e43eb-0e78-4ed2-9d6d-05185b4926a8', 9, NULL, 'B단조', '24 Preludes and Fugues: no. 6, Fugue in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:253e43eb-0e78-4ed2-9d6d-05185b4926a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Fugue in B‐flat major', part.name_en = '24 Preludes and Fugues: no. 21, Fugue in B‐flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:2a0d7574-899a-426f-968a-068ca89a3405' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a0d7574-899a-426f-968a-068ca89a3405', 10, NULL, 'Fugue in B‐flat major', '24 Preludes and Fugues: no. 21, Fugue in B‐flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a0d7574-899a-426f-968a-068ca89a3405'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'F단조', part.name_en = '24 Preludes and Fugues: no. 18, Fugue in F minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:3053a286-4949-4ea1-94d0-d2ed3ffa958c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3053a286-4949-4ea1-94d0-d2ed3ffa958c', 11, NULL, 'F단조', '24 Preludes and Fugues: no. 18, Fugue in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3053a286-4949-4ea1-94d0-d2ed3ffa958c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '24 Preludes and Fugues: no. 1, Prelude in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:38af6512-b323-40b6-aa33-758024033f54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38af6512-b323-40b6-aa33-758024033f54', 12, NULL, 'C장조', '24 Preludes and Fugues: no. 1, Prelude in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38af6512-b323-40b6-aa33-758024033f54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'A장조', part.name_en = '24 Preludes and Fugues: no. 7, Prelude in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:3df84f7a-edd3-473c-bcb7-308a5404dd9a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3df84f7a-edd3-473c-bcb7-308a5404dd9a', 13, NULL, 'A장조', '24 Preludes and Fugues: no. 7, Prelude in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3df84f7a-edd3-473c-bcb7-308a5404dd9a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'B장조', part.name_en = '24 Preludes and Fugues: no. 11, Prelude in B major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:3e1a72a0-d0d0-406b-b736-806634d2c125' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e1a72a0-d0d0-406b-b736-806634d2c125', 14, NULL, 'B장조', '24 Preludes and Fugues: no. 11, Prelude in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e1a72a0-d0d0-406b-b736-806634d2c125'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Prelude in G‐flat major', part.name_en = '24 Preludes and Fugues: no. 13, Prelude in G‐flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:47867588-e81c-4655-ba85-820218e1fd57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47867588-e81c-4655-ba85-820218e1fd57', 15, NULL, 'Prelude in G‐flat major', '24 Preludes and Fugues: no. 13, Prelude in G‐flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47867588-e81c-4655-ba85-820218e1fd57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'E단조', part.name_en = '24 Preludes and Fugues: no. 4, Prelude in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:5c7192af-24be-4ea8-9590-dafc6ee9cb03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c7192af-24be-4ea8-9590-dafc6ee9cb03', 16, NULL, 'E단조', '24 Preludes and Fugues: no. 4, Prelude in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c7192af-24be-4ea8-9590-dafc6ee9cb03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Prelude in E‐flat major', part.name_en = '24 Preludes and Fugues: no. 19, Prelude in E‐flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:62420391-5b42-4cf0-93a8-711920a1a8b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62420391-5b42-4cf0-93a8-711920a1a8b8', 17, NULL, 'Prelude in E‐flat major', '24 Preludes and Fugues: no. 19, Prelude in E‐flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62420391-5b42-4cf0-93a8-711920a1a8b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'G장조', part.name_en = '24 Preludes and Fugues: no. 3, Prelude in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:6794f4f9-94fb-4b4f-8168-6af875bc3574' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6794f4f9-94fb-4b4f-8168-6af875bc3574', 18, NULL, 'G장조', '24 Preludes and Fugues: no. 3, Prelude in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6794f4f9-94fb-4b4f-8168-6af875bc3574'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'D장조', part.name_en = '24 Preludes and Fugues: no. 5, Fugue in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:69df8294-d941-43cf-9e98-045897876245' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69df8294-d941-43cf-9e98-045897876245', 19, NULL, 'D장조', '24 Preludes and Fugues: no. 5, Fugue in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69df8294-d941-43cf-9e98-045897876245'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'G단조', part.name_en = '24 Preludes and Fugues: no. 22, Prelude in G minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:6cb0c1fc-cb7d-4cda-b9fb-4265c6911aeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cb0c1fc-cb7d-4cda-b9fb-4265c6911aeb', 20, NULL, 'G단조', '24 Preludes and Fugues: no. 22, Prelude in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cb0c1fc-cb7d-4cda-b9fb-4265c6911aeb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Prelude in D‐flat major', part.name_en = '24 Preludes and Fugues: no. 15, Prelude in D‐flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:6db41e93-6380-484c-b6d0-d2ca5a71f75b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6db41e93-6380-484c-b6d0-d2ca5a71f75b', 21, NULL, 'Prelude in D‐flat major', '24 Preludes and Fugues: no. 15, Prelude in D‐flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6db41e93-6380-484c-b6d0-d2ca5a71f75b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Fugue in E‐flat major', part.name_en = '24 Preludes and Fugues: no. 19, Fugue in E‐flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:72e971da-d7df-4d1f-91e7-b560b8b49e6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72e971da-d7df-4d1f-91e7-b560b8b49e6c', 22, NULL, 'Fugue in E‐flat major', '24 Preludes and Fugues: no. 19, Fugue in E‐flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72e971da-d7df-4d1f-91e7-b560b8b49e6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'B장조', part.name_en = '24 Preludes and Fugues: no. 11, Fugue in B major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:78a06057-9e44-4e29-bb14-772c6387e27a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78a06057-9e44-4e29-bb14-772c6387e27a', 23, NULL, 'B장조', '24 Preludes and Fugues: no. 11, Fugue in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78a06057-9e44-4e29-bb14-772c6387e27a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'B단조', part.name_en = '24 Preludes and Fugues: no. 6, Prelude in B minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:7986dbbf-d2a3-4d34-97d3-75d180fcd424' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7986dbbf-d2a3-4d34-97d3-75d180fcd424', 24, NULL, 'B단조', '24 Preludes and Fugues: no. 6, Prelude in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7986dbbf-d2a3-4d34-97d3-75d180fcd424'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'C단조', part.name_en = '24 Preludes and Fugues: no. 20, Prelude in C minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:834f1304-cd38-445c-93af-c44f648f9891' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:834f1304-cd38-445c-93af-c44f648f9891', 25, NULL, 'C단조', '24 Preludes and Fugues: no. 20, Prelude in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:834f1304-cd38-445c-93af-c44f648f9891'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'D장조', part.name_en = '24 Preludes and Fugues: no. 5, Prelude in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:88ae43ce-78e6-4d04-a7e2-0923fbbace80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88ae43ce-78e6-4d04-a7e2-0923fbbace80', 26, NULL, 'D장조', '24 Preludes and Fugues: no. 5, Prelude in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88ae43ce-78e6-4d04-a7e2-0923fbbace80'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'E단조', part.name_en = '24 Preludes and Fugues: no. 4, Fugue in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:8e5d5c64-f865-43fe-a768-206710ccf9c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e5d5c64-f865-43fe-a768-206710ccf9c2', 27, NULL, 'E단조', '24 Preludes and Fugues: no. 4, Fugue in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e5d5c64-f865-43fe-a768-206710ccf9c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'Prelude in B‐flat minor', part.name_en = '24 Preludes and Fugues: no. 16, Prelude in B‐flat minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:8e88729a-b7b0-4b0f-9933-b8e023f44856' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e88729a-b7b0-4b0f-9933-b8e023f44856', 28, NULL, 'Prelude in B‐flat minor', '24 Preludes and Fugues: no. 16, Prelude in B‐flat minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e88729a-b7b0-4b0f-9933-b8e023f44856'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'D단조', part.name_en = '24 Preludes and Fugues: no. 24, Fugue in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:91debf20-0821-463e-a762-a321daf202ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91debf20-0821-463e-a762-a321daf202ed', 29, NULL, 'D단조', '24 Preludes and Fugues: no. 24, Fugue in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91debf20-0821-463e-a762-a321daf202ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = '24 Preludes and Fugues: no. 1, Fugue in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:9504c153-3935-4f92-8ab9-48dd78eb4629' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9504c153-3935-4f92-8ab9-48dd78eb4629', 30, NULL, 'C장조', '24 Preludes and Fugues: no. 1, Fugue in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9504c153-3935-4f92-8ab9-48dd78eb4629'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'Fugue in F‐sharp minor', part.name_en = '24 Preludes and Fugues: no. 8, Fugue in F‐sharp minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:95a09018-6a86-48a7-b4f1-7d3d9d97d8e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95a09018-6a86-48a7-b4f1-7d3d9d97d8e4', 31, NULL, 'Fugue in F‐sharp minor', '24 Preludes and Fugues: no. 8, Fugue in F‐sharp minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95a09018-6a86-48a7-b4f1-7d3d9d97d8e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = 'Prelude in A‐flat major', part.name_en = '24 Preludes and Fugues: no. 17, Prelude in A‐flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:adedf4d0-9619-4861-80d0-74e0b7113965' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:adedf4d0-9619-4861-80d0-74e0b7113965', 32, NULL, 'Prelude in A‐flat major', '24 Preludes and Fugues: no. 17, Prelude in A‐flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adedf4d0-9619-4861-80d0-74e0b7113965'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 33, part.movement_number = NULL,
    part.name_ko = 'A장조', part.name_en = '24 Preludes and Fugues: no. 7, Fugue in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:bcbe09a8-9bfd-40af-8dda-a1616c44971b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcbe09a8-9bfd-40af-8dda-a1616c44971b', 33, NULL, 'A장조', '24 Preludes and Fugues: no. 7, Fugue in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcbe09a8-9bfd-40af-8dda-a1616c44971b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 34, part.movement_number = NULL,
    part.name_ko = 'F단조', part.name_en = '24 Preludes and Fugues: no. 18, Prelude in F minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:c0c2f061-a937-4f96-b0ee-3f1cb6994e60' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0c2f061-a937-4f96-b0ee-3f1cb6994e60', 34, NULL, 'F단조', '24 Preludes and Fugues: no. 18, Prelude in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0c2f061-a937-4f96-b0ee-3f1cb6994e60'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 35, part.movement_number = NULL,
    part.name_ko = 'Prelude in F‐sharp minor', part.name_en = '24 Preludes and Fugues: no. 8, Prelude in F‐sharp minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:c225441f-8157-4db7-b8a8-b31736dc95fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c225441f-8157-4db7-b8a8-b31736dc95fc', 35, NULL, 'Prelude in F‐sharp minor', '24 Preludes and Fugues: no. 8, Prelude in F‐sharp minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c225441f-8157-4db7-b8a8-b31736dc95fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 36, part.movement_number = NULL,
    part.name_ko = 'Prelude in C‐sharp minor', part.name_en = '24 Preludes and Fugues: no. 10, Prelude in C‐sharp minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:c57eb3bd-eeec-40e4-9709-2f28809ba4c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c57eb3bd-eeec-40e4-9709-2f28809ba4c2', 36, NULL, 'Prelude in C‐sharp minor', '24 Preludes and Fugues: no. 10, Prelude in C‐sharp minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c57eb3bd-eeec-40e4-9709-2f28809ba4c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 37, part.movement_number = NULL,
    part.name_ko = 'C단조', part.name_en = '24 Preludes and Fugues: no. 20, Fugue in C minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:cc211ecf-3df7-4d45-93d6-5ce405bc700d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc211ecf-3df7-4d45-93d6-5ce405bc700d', 37, NULL, 'C단조', '24 Preludes and Fugues: no. 20, Fugue in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc211ecf-3df7-4d45-93d6-5ce405bc700d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 38, part.movement_number = NULL,
    part.name_ko = 'E장조', part.name_en = '24 Preludes and Fugues: no. 9, Fugue in E major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:ccc2c1f4-ce3d-4353-a7ff-76d866677e45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccc2c1f4-ce3d-4353-a7ff-76d866677e45', 38, NULL, 'E장조', '24 Preludes and Fugues: no. 9, Fugue in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccc2c1f4-ce3d-4353-a7ff-76d866677e45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 39, part.movement_number = NULL,
    part.name_ko = 'Prelude in E‐flat minor', part.name_en = '24 Preludes and Fugues: no. 14, Prelude in E‐flat minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:ccdec1e1-9d30-45a4-9499-52b542c33dcc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccdec1e1-9d30-45a4-9499-52b542c33dcc', 39, NULL, 'Prelude in E‐flat minor', '24 Preludes and Fugues: no. 14, Prelude in E‐flat minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccdec1e1-9d30-45a4-9499-52b542c33dcc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 40, part.movement_number = NULL,
    part.name_ko = 'Fugue in G‐flat major', part.name_en = '24 Preludes and Fugues: no. 13, Fugue in G‐flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:d244c96a-85df-4dd9-9b35-32dc7d70ee26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d244c96a-85df-4dd9-9b35-32dc7d70ee26', 40, NULL, 'Fugue in G‐flat major', '24 Preludes and Fugues: no. 13, Fugue in G‐flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d244c96a-85df-4dd9-9b35-32dc7d70ee26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 41, part.movement_number = NULL,
    part.name_ko = 'Fugue in B‐flat minor', part.name_en = '24 Preludes and Fugues: no. 16, Fugue in B‐flat minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:d6c6d881-f330-4e5e-b197-550cf4925700' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6c6d881-f330-4e5e-b197-550cf4925700', 41, NULL, 'Fugue in B‐flat minor', '24 Preludes and Fugues: no. 16, Fugue in B‐flat minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6c6d881-f330-4e5e-b197-550cf4925700'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 42, part.movement_number = NULL,
    part.name_ko = 'G단조', part.name_en = '24 Preludes and Fugues: no. 22, Fugue in G minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:d9fcb242-582a-4a55-96b0-f7b68fda4b95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9fcb242-582a-4a55-96b0-f7b68fda4b95', 42, NULL, 'G단조', '24 Preludes and Fugues: no. 22, Fugue in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9fcb242-582a-4a55-96b0-f7b68fda4b95'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 43, part.movement_number = NULL,
    part.name_ko = 'F장조', part.name_en = '24 Preludes and Fugues: no. 23, Fugue in F major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:da930286-c286-494f-a2b4-5998eb4038cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da930286-c286-494f-a2b4-5998eb4038cf', 43, NULL, 'F장조', '24 Preludes and Fugues: no. 23, Fugue in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da930286-c286-494f-a2b4-5998eb4038cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 44, part.movement_number = NULL,
    part.name_ko = 'Prelude in G‐sharp minor', part.name_en = '24 Preludes and Fugues: no. 12, Prelude in G‐sharp minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:dc744bc4-c391-49b8-8f7a-53f532042742' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc744bc4-c391-49b8-8f7a-53f532042742', 44, NULL, 'Prelude in G‐sharp minor', '24 Preludes and Fugues: no. 12, Prelude in G‐sharp minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc744bc4-c391-49b8-8f7a-53f532042742'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 45, part.movement_number = NULL,
    part.name_ko = 'G장조', part.name_en = '24 Preludes and Fugues: no. 3, Fugue in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:e0bc298a-0eff-49ce-8a7e-208b1b773113' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0bc298a-0eff-49ce-8a7e-208b1b773113', 45, NULL, 'G장조', '24 Preludes and Fugues: no. 3, Fugue in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0bc298a-0eff-49ce-8a7e-208b1b773113'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 46, part.movement_number = NULL,
    part.name_ko = 'E장조', part.name_en = '24 Preludes and Fugues: no. 9, Prelude in E major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:e80b68ee-12dd-4ee2-9ad2-96ff0dc46f0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e80b68ee-12dd-4ee2-9ad2-96ff0dc46f0d', 46, NULL, 'E장조', '24 Preludes and Fugues: no. 9, Prelude in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e80b68ee-12dd-4ee2-9ad2-96ff0dc46f0d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 47, part.movement_number = NULL,
    part.name_ko = 'Fugue in D‐flat major', part.name_en = '24 Preludes and Fugues: no. 15, Fugue in D‐flat major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:efbee902-5bfc-4000-b0eb-3be451d9a6b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efbee902-5bfc-4000-b0eb-3be451d9a6b6', 47, NULL, 'Fugue in D‐flat major', '24 Preludes and Fugues: no. 15, Fugue in D‐flat major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efbee902-5bfc-4000-b0eb-3be451d9a6b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 48, part.movement_number = NULL,
    part.name_ko = 'Fugue in E‐flat minor', part.name_en = '24 Preludes and Fugues: no. 14, Fugue in E‐flat minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17075 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:f9777afb-eaa2-405f-9358-7370040ea782' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9777afb-eaa2-405f-9358-7370040ea782', 48, NULL, 'Fugue in E‐flat minor', '24 Preludes and Fugues: no. 14, Fugue in E‐flat minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17075 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9777afb-eaa2-405f-9358-7370040ea782'
);


-- None Legends

UPDATE pieces piece
SET piece.title = 'Legends', piece.title_en = 'Legends',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15815 AND piece.composer_id = 143
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Canyon of Death', part.name_en = 'Legends: 1. Canyon of Death',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15815 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:9d7d8e8f-bb01-469a-8edb-16f73f2391a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d7d8e8f-bb01-469a-8edb-16f73f2391a8', 1, NULL, 'Canyon of Death', 'Legends: 1. Canyon of Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15815 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d7d8e8f-bb01-469a-8edb-16f73f2391a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Garden of Pearl Grapes', part.name_en = 'Legends: 2. Garden of Pearl Grapes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15815 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:ae6dd69b-7f6a-45d5-b20f-e83c571f7898' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae6dd69b-7f6a-45d5-b20f-e83c571f7898', 2, NULL, 'Garden of Pearl Grapes', 'Legends: 2. Garden of Pearl Grapes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15815 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae6dd69b-7f6a-45d5-b20f-e83c571f7898'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Bloody Cactus', part.name_en = 'Legends: 3. Bloody Cactus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15815 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:a9a923ce-275a-4d28-a14c-cce528b5ad52' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9a923ce-275a-4d28-a14c-cce528b5ad52', 3, NULL, 'Bloody Cactus', 'Legends: 3. Bloody Cactus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15815 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9a923ce-275a-4d28-a14c-cce528b5ad52'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Blue-Eyed Flower', part.name_en = 'Legends: 4. Blue-Eyed Flower',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15815 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:75f70db4-048d-475f-a0bb-541db93c7c6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75f70db4-048d-475f-a0bb-541db93c7c6b', 4, NULL, 'Blue-Eyed Flower', 'Legends: 4. Blue-Eyed Flower', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15815 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75f70db4-048d-475f-a0bb-541db93c7c6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Black Horseman', part.name_en = 'Legends: 5. Black Horseman',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15815 AND p.composer_id = 143 AND part.part_key = 'musicbrainz:3bdc1e8a-4d88-4b7a-a707-bb34ee4bebe9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bdc1e8a-4d88-4b7a-a707-bb34ee4bebe9', 5, NULL, 'Black Horseman', 'Legends: 5. Black Horseman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15815 AND p.composer_id = 143
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bdc1e8a-4d88-4b7a-a707-bb34ee4bebe9'
);

-- 숨길 seed 작품 없음

-- ===== José de Nebra (composer_id 145) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 15개(묶음 6, 다악장 1, 낱곡 8),
-- 새 작품 0개, part 19개, 그 아래 0개.
-- seed 15개 중 15개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Amar y ser amado y la divina Philotea

UPDATE pieces piece
SET piece.title = 'Amar y ser amado y la divina Philotea', piece.title_en = 'Amar y ser amado y la divina Philotea',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16399 AND piece.composer_id = 145
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Seguidilla, from “Amar y ser amado y la divina Philotea” (incidental music)', part.name_en = 'Seguidilla, from “Amar y ser amado y la divina Philotea” (incidental music)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16399 AND p.composer_id = 145 AND part.part_key = 'musicbrainz:1abc89b0-5246-4392-be15-47a097ef1794' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1abc89b0-5246-4392-be15-47a097ef1794', 1, NULL, 'Seguidilla, from “Amar y ser amado y la divina Philotea” (incidental music)', 'Seguidilla, from “Amar y ser amado y la divina Philotea” (incidental music)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16399 AND p.composer_id = 145
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1abc89b0-5246-4392-be15-47a097ef1794'
);


-- None 오페라 <Amor aumenta el valor>

UPDATE pieces piece
SET piece.title = '오페라 <Amor aumenta el valor>', piece.title_en = 'Amor aumenta el valor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16424 AND piece.composer_id = 145
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Acto I', part.name_en = 'Amor aumenta el valor, Acto I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16424 AND p.composer_id = 145 AND part.part_key = 'musicbrainz:2693060d-ad5d-43b2-a9bd-275e81eff7b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2693060d-ad5d-43b2-a9bd-275e81eff7b1', 1, NULL, 'Acto I', 'Amor aumenta el valor, Acto I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16424 AND p.composer_id = 145
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2693060d-ad5d-43b2-a9bd-275e81eff7b1'
);


-- None 오페라 <Antes que zelos y amor, la piedad llama al valor>

UPDATE pieces piece
SET piece.title = '오페라 <Antes que zelos y amor, la piedad llama al valor>', piece.title_en = 'Antes que zelos y amor, la piedad llama al valor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18520 AND piece.composer_id = 145
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Donde hay violencia no hay culpa

UPDATE pieces piece
SET piece.title = 'Donde hay violencia no hay culpa', piece.title_en = 'Donde hay violencia no hay culpa',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16243 AND piece.composer_id = 145
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Seguidilla (2), from “Donde hay violencia no hay culpa”', part.name_en = 'Seguidilla (2), from “Donde hay violencia no hay culpa”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16243 AND p.composer_id = 145 AND part.part_key = 'musicbrainz:0ae944cf-bcd3-4e44-9766-9399ec6f1094' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ae944cf-bcd3-4e44-9766-9399ec6f1094', 1, NULL, 'Seguidilla (2), from “Donde hay violencia no hay culpa”', 'Seguidilla (2), from “Donde hay violencia no hay culpa”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16243 AND p.composer_id = 145
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ae944cf-bcd3-4e44-9766-9399ec6f1094'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Seguidilla (1), from “Donde hay violencia no hay culpa” (attributed)', part.name_en = 'Seguidilla (1), from “Donde hay violencia no hay culpa” (attributed)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16243 AND p.composer_id = 145 AND part.part_key = 'musicbrainz:5c27d407-c967-4c3a-bde7-a4ef486502f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c27d407-c967-4c3a-bde7-a4ef486502f4', 2, NULL, 'Seguidilla (1), from “Donde hay violencia no hay culpa” (attributed)', 'Seguidilla (1), from “Donde hay violencia no hay culpa” (attributed)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16243 AND p.composer_id = 145
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c27d407-c967-4c3a-bde7-a4ef486502f4'
);


-- None El bajel que no recela

UPDATE pieces piece
SET piece.title = 'El bajel que no recela', piece.title_en = 'El bajel que no recela',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17889 AND piece.composer_id = 145
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None En amor, pastorcillos

UPDATE pieces piece
SET piece.title = 'En amor, pastorcillos', piece.title_en = 'En amor, pastorcillos',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17275 AND piece.composer_id = 145
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Más gloria es triunfar de sí>

UPDATE pieces piece
SET piece.title = '오페라 <Más gloria es triunfar de sí>', piece.title_en = 'Más gloria es triunfar de sí',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20008 AND piece.composer_id = 145
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <No todo indicio es verdad>

UPDATE pieces piece
SET piece.title = '오페라 <No todo indicio es verdad>', piece.title_en = 'No todo indicio es verdad',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18865 AND piece.composer_id = 145
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Para obsequio a la deydad, nunca es culto la crueldad, y Iphigenia en Tracia

UPDATE pieces piece
SET piece.title = 'Para obsequio a la deydad, nunca es culto la crueldad, y Iphigenia en Tracia', piece.title_en = 'Para obsequio a la deydad, nunca es culto la crueldad, y Iphigenia en Tracia',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19010 AND piece.composer_id = 145
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Seguidilla, from “Para obsequio a la deydad, nunca es culto la crueldad, y Iphigenia en Tracia”', part.name_en = 'Seguidilla, from “Para obsequio a la deydad, nunca es culto la crueldad, y Iphigenia en Tracia”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19010 AND p.composer_id = 145 AND part.part_key = 'musicbrainz:301db881-de54-41cf-9c2f-c0b1547f511e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:301db881-de54-41cf-9c2f-c0b1547f511e', 1, NULL, 'Seguidilla, from “Para obsequio a la deydad, nunca es culto la crueldad, y Iphigenia en Tracia”', 'Seguidilla, from “Para obsequio a la deydad, nunca es culto la crueldad, y Iphigenia en Tracia”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19010 AND p.composer_id = 145
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:301db881-de54-41cf-9c2f-c0b1547f511e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Obertura', part.name_en = 'Para obsequio a la deydad, nunca es culto la crueldad, y Iphigenia en Tracia: Obertura',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19010 AND p.composer_id = 145 AND part.part_key = 'musicbrainz:ac73c81b-4118-44f8-921e-1c5b5a1fce7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac73c81b-4118-44f8-921e-1c5b5a1fce7f', 2, NULL, 'Obertura', 'Para obsequio a la deydad, nunca es culto la crueldad, y Iphigenia en Tracia: Obertura', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19010 AND p.composer_id = 145
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac73c81b-4118-44f8-921e-1c5b5a1fce7f'
);


-- None Polychoral Mass in G

UPDATE pieces piece
SET piece.title = 'Polychoral Mass in G', piece.title_en = 'Polychoral Mass in G',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18321 AND piece.composer_id = 145
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Kyrie eleison', part.name_en = 'Polychoral Mass in G: Kyrie eleison',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18321 AND p.composer_id = 145 AND part.part_key = 'musicbrainz:f27c4e53-04a3-4ca5-a6a4-12209f5d58da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f27c4e53-04a3-4ca5-a6a4-12209f5d58da', 1, NULL, 'Kyrie eleison', 'Polychoral Mass in G: Kyrie eleison', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18321 AND p.composer_id = 145
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f27c4e53-04a3-4ca5-a6a4-12209f5d58da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Christe eleison', part.name_en = 'Polychoral Mass in G: Christe eleison',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18321 AND p.composer_id = 145 AND part.part_key = 'musicbrainz:55a066e1-8b48-473e-aca0-444056113e28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55a066e1-8b48-473e-aca0-444056113e28', 2, NULL, 'Christe eleison', 'Polychoral Mass in G: Christe eleison', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18321 AND p.composer_id = 145
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55a066e1-8b48-473e-aca0-444056113e28'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Kyrie', part.name_en = 'Polychoral Mass in G: Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18321 AND p.composer_id = 145 AND part.part_key = 'musicbrainz:26162a38-2156-4bd4-a76f-986f657c2373' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26162a38-2156-4bd4-a76f-986f657c2373', 3, NULL, 'Kyrie', 'Polychoral Mass in G: Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18321 AND p.composer_id = 145
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26162a38-2156-4bd4-a76f-986f657c2373'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Gloria', part.name_en = 'Polychoral Mass in G: Gloria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18321 AND p.composer_id = 145 AND part.part_key = 'musicbrainz:d2bfff7c-46d5-4d1e-8dfd-ac8aaf9687b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2bfff7c-46d5-4d1e-8dfd-ac8aaf9687b8', 4, NULL, 'Gloria', 'Polychoral Mass in G: Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18321 AND p.composer_id = 145
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2bfff7c-46d5-4d1e-8dfd-ac8aaf9687b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Et in terra pax', part.name_en = 'Polychoral Mass in G: Et in terra pax',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18321 AND p.composer_id = 145 AND part.part_key = 'musicbrainz:d84a726e-122a-495d-9e22-49849e234129' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d84a726e-122a-495d-9e22-49849e234129', 5, NULL, 'Et in terra pax', 'Polychoral Mass in G: Et in terra pax', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18321 AND p.composer_id = 145
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d84a726e-122a-495d-9e22-49849e234129'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Laudamus te', part.name_en = 'Polychoral Mass in G: Laudamus te',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18321 AND p.composer_id = 145 AND part.part_key = 'musicbrainz:747e3bc2-67f0-4eea-8616-480d726fad9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:747e3bc2-67f0-4eea-8616-480d726fad9b', 6, NULL, 'Laudamus te', 'Polychoral Mass in G: Laudamus te', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18321 AND p.composer_id = 145
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:747e3bc2-67f0-4eea-8616-480d726fad9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Domine Deus', part.name_en = 'Polychoral Mass in G: Domine Deus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18321 AND p.composer_id = 145 AND part.part_key = 'musicbrainz:cb37976c-b842-4ba4-9630-c4c192be3f7c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb37976c-b842-4ba4-9630-c4c192be3f7c', 7, NULL, 'Domine Deus', 'Polychoral Mass in G: Domine Deus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18321 AND p.composer_id = 145
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb37976c-b842-4ba4-9630-c4c192be3f7c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Qui tollis peccata mundi', part.name_en = 'Polychoral Mass in G: Qui tollis peccata mundi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18321 AND p.composer_id = 145 AND part.part_key = 'musicbrainz:08c07a00-3b16-4412-b195-cf29d12dca99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08c07a00-3b16-4412-b195-cf29d12dca99', 8, NULL, 'Qui tollis peccata mundi', 'Polychoral Mass in G: Qui tollis peccata mundi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18321 AND p.composer_id = 145
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08c07a00-3b16-4412-b195-cf29d12dca99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Quoniam tu solus', part.name_en = 'Polychoral Mass in G: Quoniam tu solus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18321 AND p.composer_id = 145 AND part.part_key = 'musicbrainz:4ce582c9-b461-4168-9d5a-70f3b9d60d6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ce582c9-b461-4168-9d5a-70f3b9d60d6b', 9, NULL, 'Quoniam tu solus', 'Polychoral Mass in G: Quoniam tu solus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18321 AND p.composer_id = 145
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ce582c9-b461-4168-9d5a-70f3b9d60d6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Cum Sancto Spiritu, Amen', part.name_en = 'Polychoral Mass in G: Cum Sancto Spiritu, Amen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18321 AND p.composer_id = 145 AND part.part_key = 'musicbrainz:1e253356-42af-403a-b4db-e9cbfb700b94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e253356-42af-403a-b4db-e9cbfb700b94', 10, NULL, 'Cum Sancto Spiritu, Amen', 'Polychoral Mass in G: Cum Sancto Spiritu, Amen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18321 AND p.composer_id = 145
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e253356-42af-403a-b4db-e9cbfb700b94'
);


-- None Sonata en fa mayor

UPDATE pieces piece
SET piece.title = 'Sonata en fa mayor', piece.title_en = 'Sonata en fa mayor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17375 AND piece.composer_id = 145
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tocata en do menor

UPDATE pieces piece
SET piece.title = 'Tocata en do menor', piece.title_en = 'Tocata en do menor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17507 AND piece.composer_id = 145
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vendado es amor, no es ciego

UPDATE pieces piece
SET piece.title = 'Vendado es amor, no es ciego', piece.title_en = 'Vendado es amor, no es ciego',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17262 AND piece.composer_id = 145
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Seguidilla, from “Vendado es amor, no es ciego”', part.name_en = 'Seguidilla, from “Vendado es amor, no es ciego”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17262 AND p.composer_id = 145 AND part.part_key = 'musicbrainz:3862101d-bb43-465a-953e-89b7da223761' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3862101d-bb43-465a-953e-89b7da223761', 1, NULL, 'Seguidilla, from “Vendado es amor, no es ciego”', 'Seguidilla, from “Vendado es amor, no es ciego”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17262 AND p.composer_id = 145
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3862101d-bb43-465a-953e-89b7da223761'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tempestad grande amigo, fandango for 3 voices & string orchestra', part.name_en = 'Tempestad grande amigo, fandango for 3 voices & string orchestra',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17262 AND p.composer_id = 145 AND part.part_key = 'musicbrainz:7a4cf261-84cd-45df-bfc1-ca5b6d6d6b4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a4cf261-84cd-45df-bfc1-ca5b6d6d6b4e', 2, NULL, 'Tempestad grande amigo, fandango for 3 voices & string orchestra', 'Tempestad grande amigo, fandango for 3 voices & string orchestra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17262 AND p.composer_id = 145
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a4cf261-84cd-45df-bfc1-ca5b6d6d6b4e'
);


-- None 오페라 <Venus y Adonis>

UPDATE pieces piece
SET piece.title = '오페라 <Venus y Adonis>', piece.title_en = 'Venus y Adonis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17111 AND piece.composer_id = 145
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Viento es la dicha de amor

UPDATE pieces piece
SET piece.title = 'Viento es la dicha de amor', piece.title_en = 'Viento es la dicha de amor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16258 AND piece.composer_id = 145
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Canción, from “Viento es la dicha de amor”', part.name_en = 'Canción, from “Viento es la dicha de amor”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16258 AND p.composer_id = 145 AND part.part_key = 'musicbrainz:ccef25dc-f5c1-48a5-a76a-d04311693536' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccef25dc-f5c1-48a5-a76a-d04311693536', 1, NULL, 'Canción, from “Viento es la dicha de amor”', 'Canción, from “Viento es la dicha de amor”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16258 AND p.composer_id = 145
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccef25dc-f5c1-48a5-a76a-d04311693536'
);

-- 숨길 seed 작품 없음

-- ===== Eugeniusz Morawski-Da̜browa (composer_id 147) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 4개(묶음 1, 다악장 0, 낱곡 3),
-- 새 작품 0개, part 2개, 그 아래 0개.
-- seed 4개 중 4개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Don Quixote

UPDATE pieces piece
SET piece.title = 'Don Quixote', piece.title_en = 'Don Quixote',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17503 AND piece.composer_id = 147
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Nevermore

UPDATE pieces piece
SET piece.title = 'Nevermore', piece.title_en = 'Nevermore',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16020 AND piece.composer_id = 147
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ulalume

UPDATE pieces piece
SET piece.title = 'Ulalume', piece.title_en = 'Ulalume',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18871 AND piece.composer_id = 147
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 발레 <Świtezianka>

UPDATE pieces piece
SET piece.title = '발레 <Świtezianka>', piece.title_en = 'Świtezianka',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17295 AND piece.composer_id = 147
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act 1', part.name_en = 'Świtezianka: Act 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17295 AND p.composer_id = 147 AND part.part_key = 'musicbrainz:9f7f86fe-639a-4cbe-b543-81a093b91f0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f7f86fe-639a-4cbe-b543-81a093b91f0f', 1, NULL, 'Act 1', 'Świtezianka: Act 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17295 AND p.composer_id = 147
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f7f86fe-639a-4cbe-b543-81a093b91f0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act 2', part.name_en = 'Świtezianka: Act 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17295 AND p.composer_id = 147 AND part.part_key = 'musicbrainz:e71ef98c-86ae-463c-a66d-ab30468373a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e71ef98c-86ae-463c-a66d-ab30468373a9', 2, NULL, 'Act 2', 'Świtezianka: Act 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17295 AND p.composer_id = 147
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e71ef98c-86ae-463c-a66d-ab30468373a9'
);

-- 숨길 seed 작품 없음

-- ===== 체사레 소데로 (composer_id 150) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 1개(묶음 0, 다악장 0, 낱곡 1),
-- 새 작품 0개, part 0개, 그 아래 0개.
-- seed 1개 중 1개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 오페라 <Ombre russe>

UPDATE pieces piece
SET piece.title = '오페라 <Ombre russe>', piece.title_en = 'Ombre russe',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18180 AND piece.composer_id = 150
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 숨길 seed 작품 없음

-- ===== Teizo Matsumura (composer_id 153) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 6개(묶음 1, 다악장 2, 낱곡 3),
-- 새 작품 3개, part 8개, 그 아래 16개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None To the Night of Gethsemane

UPDATE pieces piece
SET piece.title = 'To the Night of Gethsemane', piece.title_en = 'To the Night of Gethsemane',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19336 AND piece.composer_id = 153
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 祈祷歌

UPDATE pieces piece
SET piece.title = '祈祷歌', piece.title_en = '祈祷歌',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19671 AND piece.composer_id = 153
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 詩曲一番

UPDATE pieces piece
SET piece.title = '詩曲一番', piece.title_en = '詩曲一番',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15737 AND piece.composer_id = 153
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Silence>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Silence>', 'Silence', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 153
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Silence>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c43e243-fab5-4c6a-8513-8a6484f6f5a0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3c43e243-fab5-4c6a-8513-8a6484f6f5a0'
FROM pieces p
WHERE p.composer_id = 153 AND p.title = '오페라 <Silence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c43e243-fab5-4c6a-8513-8a6484f6f5a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:855ebebc-808f-4762-b4d4-a565c10e79a1', 1, NULL, 'Act I', 'Silence: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 153 AND p.title = '오페라 <Silence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:855ebebc-808f-4762-b4d4-a565c10e79a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1b49ae8b-0b9c-48a7-81b8-130ec1d5d059', 1, NULL, 'Act I. Scene VI. On the Hilltop', 'Silence: Act I. Scene VI. On the Hilltop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:855ebebc-808f-4762-b4d4-a565c10e79a1'
WHERE p.composer_id = 153 AND p.title = '오페라 <Silence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b49ae8b-0b9c-48a7-81b8-130ec1d5d059'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1b794e63-b3a4-4086-8291-658bef830352', 2, NULL, 'Act I. Scene VII. Intermezzo (Fumi-E)', 'Silence: Act I. Scene VII. Intermezzo (Fumi-E)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:855ebebc-808f-4762-b4d4-a565c10e79a1'
WHERE p.composer_id = 153 AND p.title = '오페라 <Silence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b794e63-b3a4-4086-8291-658bef830352'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2ef9ce10-6211-45ce-bf59-0b1bddeb5d6b', 3, NULL, 'Act I. Scene IX. On a Cliff near the Sea', 'Silence: Act I. Scene IX. On a Cliff near the Sea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:855ebebc-808f-4762-b4d4-a565c10e79a1'
WHERE p.composer_id = 153 AND p.title = '오페라 <Silence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ef9ce10-6211-45ce-bf59-0b1bddeb5d6b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4d2f9b23-2023-4e48-9a90-0120818c22d1', 4, NULL, 'Act I. Scene VIII. Water Crucifixion', 'Silence: Act I. Scene VIII. Water Crucifixion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:855ebebc-808f-4762-b4d4-a565c10e79a1'
WHERE p.composer_id = 153 AND p.title = '오페라 <Silence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d2f9b23-2023-4e48-9a90-0120818c22d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5b81ae8e-41f6-4bd8-8f87-c3ec825b2c9b', 5, NULL, 'Act I. Scene I. Burning at the Stake', 'Silence: Act I. Scene I. Burning at the Stake', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:855ebebc-808f-4762-b4d4-a565c10e79a1'
WHERE p.composer_id = 153 AND p.title = '오페라 <Silence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b81ae8e-41f6-4bd8-8f87-c3ec825b2c9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:85e525b0-7604-447c-9900-3ff2b0c86787', 6, NULL, 'Act I. Scene V. An Aria on a Hilltop', 'Silence: Act I. Scene V. An Aria on a Hilltop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:855ebebc-808f-4762-b4d4-a565c10e79a1'
WHERE p.composer_id = 153 AND p.title = '오페라 <Silence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85e525b0-7604-447c-9900-3ff2b0c86787'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bf31883a-87b5-483d-adbf-9c248eee8d3f', 7, NULL, 'Act I. Scene IV. A Barn in Tomogi Village', 'Silence: Act I. Scene IV. A Barn in Tomogi Village', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:855ebebc-808f-4762-b4d4-a565c10e79a1'
WHERE p.composer_id = 153 AND p.title = '오페라 <Silence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf31883a-87b5-483d-adbf-9c248eee8d3f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bfa26db6-9cd5-42d7-9617-8eeb77d8a2bd', 8, NULL, 'Act I. Scene III. Intermezzo', 'Silence: Act I. Scene III. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:855ebebc-808f-4762-b4d4-a565c10e79a1'
WHERE p.composer_id = 153 AND p.title = '오페라 <Silence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfa26db6-9cd5-42d7-9617-8eeb77d8a2bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ce630a90-6059-4f8f-aa64-8d6f1d43f2e7', 9, NULL, 'Act I. Scene II. A Church in Macao', 'Silence: Act I. Scene II. A Church in Macao', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:855ebebc-808f-4762-b4d4-a565c10e79a1'
WHERE p.composer_id = 153 AND p.title = '오페라 <Silence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce630a90-6059-4f8f-aa64-8d6f1d43f2e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd8b43dd-7246-4361-a674-48755dad03fc', 2, NULL, 'Act II', 'Silence: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 153 AND p.title = '오페라 <Silence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd8b43dd-7246-4361-a674-48755dad03fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6d62345a-3b8b-4011-af5b-9ece10f48038', 1, NULL, 'Act II. Scene XI. The Seashore', 'Silence: Act II. Scene XI. The Seashore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd8b43dd-7246-4361-a674-48755dad03fc'
WHERE p.composer_id = 153 AND p.title = '오페라 <Silence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d62345a-3b8b-4011-af5b-9ece10f48038'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b02f2e7d-2a2d-48f7-93a1-d9d2c160575c', 2, NULL, 'Act II. Scene XIV. A Cell in the Prison', 'Silence: Act II. Scene XIV. A Cell in the Prison', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd8b43dd-7246-4361-a674-48755dad03fc'
WHERE p.composer_id = 153 AND p.title = '오페라 <Silence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b02f2e7d-2a2d-48f7-93a1-d9d2c160575c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b480f6d5-52c2-4e81-a1aa-afb74e013e8c', 3, NULL, 'Act II. Scene XV. A Bright Morning', 'Silence: Act II. Scene XV. A Bright Morning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd8b43dd-7246-4361-a674-48755dad03fc'
WHERE p.composer_id = 153 AND p.title = '오페라 <Silence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b480f6d5-52c2-4e81-a1aa-afb74e013e8c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c6d0b4ab-7a79-4b58-91df-4eb0ad56b922', 4, NULL, 'Act II. Scene XIII. The Streets of Nagasaki', 'Silence: Act II. Scene XIII. The Streets of Nagasaki', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd8b43dd-7246-4361-a674-48755dad03fc'
WHERE p.composer_id = 153 AND p.title = '오페라 <Silence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6d0b4ab-7a79-4b58-91df-4eb0ad56b922'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e13a4516-be88-42c3-9ef4-068426285db9', 5, NULL, 'Act II. Scene XII. The Prison', 'Silence: Act II. Scene XII. The Prison', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd8b43dd-7246-4361-a674-48755dad03fc'
WHERE p.composer_id = 153 AND p.title = '오페라 <Silence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e13a4516-be88-42c3-9ef4-068426285db9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f765627f-8687-4b92-b068-009b96ce9027', 6, NULL, 'Act II. Scene XVI. The Same Bright Morning', 'Silence: Act II. Scene XVI. The Same Bright Morning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd8b43dd-7246-4361-a674-48755dad03fc'
WHERE p.composer_id = 153 AND p.title = '오페라 <Silence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f765627f-8687-4b92-b068-009b96ce9027'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fcf5ad4d-2f93-4ec1-93e2-3e015df75d65', 7, NULL, 'Act II. Scene X. A Prison in Nagasaki', 'Silence: Act II. Scene X. A Prison in Nagasaki', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fd8b43dd-7246-4361-a674-48755dad03fc'
WHERE p.composer_id = 153 AND p.title = '오페라 <Silence>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcf5ad4d-2f93-4ec1-93e2-3e015df75d65'
);


-- None 교향곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 1번', 'Symphony no. 1', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 153
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7fe753cb-4b0a-409f-9e43-8c22194d916c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7fe753cb-4b0a-409f-9e43-8c22194d916c'
FROM pieces p
WHERE p.composer_id = 153 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7fe753cb-4b0a-409f-9e43-8c22194d916c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d771b02e-a81f-48a4-8c21-979888c913d0', 1, 'I', 'Andante', 'Symphony no. 1: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 153 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d771b02e-a81f-48a4-8c21-979888c913d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31963278-76db-4ebc-b5fc-afddb8cc6831', 2, 'II', 'Adagio', 'Symphony no. 1: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 153 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31963278-76db-4ebc-b5fc-afddb8cc6831'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7bb08a1b-505a-45a5-b305-acc6c9d86483', 3, 'III', 'Allegro', 'Symphony no. 1: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 153 AND p.title = '교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bb08a1b-505a-45a5-b305-acc6c9d86483'
);


-- None 교향곡 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 2번', 'Symphony no. 2', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 153
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7de6aafe-d369-4de7-9489-ea68ac3b8730'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7de6aafe-d369-4de7-9489-ea68ac3b8730'
FROM pieces p
WHERE p.composer_id = 153 AND p.title = '교향곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7de6aafe-d369-4de7-9489-ea68ac3b8730'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88710286-75f9-4804-b0fa-c0366636d50b', 1, 'I', '𝅗𝅥 = 50', 'Symphony no. 2: I. 𝅗𝅥 = 50', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 153 AND p.title = '교향곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88710286-75f9-4804-b0fa-c0366636d50b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12b43389-89e4-4e1c-b8a1-23b2b5ca1fd6', 2, 'II', '♩ = 46', 'Symphony no. 2: II. ♩ = 46', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 153 AND p.title = '교향곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12b43389-89e4-4e1c-b8a1-23b2b5ca1fd6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3aaab25-c93d-4143-9c9d-1484138ec865', 3, 'III', '𝅗𝅥 = 50', 'Symphony no. 2: III. 𝅗𝅥 = 50', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 153 AND p.title = '교향곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3aaab25-c93d-4143-9c9d-1484138ec865'
);

-- 숨길 seed 작품 없음

-- ===== Guillaume Connesson (composer_id 155) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 13개(묶음 1, 다악장 5, 낱곡 7),
-- 새 작품 1개, part 26개, 그 아래 5개.
-- seed 13개 중 12개를 작품·part 에 잇고, 0개를 숨기고, 1개는 그대로 둔다.

-- None Concerto pour violoncelle et orchestre

UPDATE pieces piece
SET piece.title = 'Concerto pour violoncelle et orchestre', piece.title_en = 'Concerto pour violoncelle et orchestre',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16848 AND piece.composer_id = 155
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Granitique', part.name_en = 'Concerto pour violoncelle et orchestre: I. Granitique',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16848 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:a54c8f86-9027-4de4-862d-4cb97d6e792a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a54c8f86-9027-4de4-862d-4cb97d6e792a', 1, 'I', 'Granitique', 'Concerto pour violoncelle et orchestre: I. Granitique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16848 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a54c8f86-9027-4de4-862d-4cb97d6e792a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Vif', part.name_en = 'Concerto pour violoncelle et orchestre: II. Vif',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16848 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:ae1720f4-27f1-43bf-82c7-fa79994431f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae1720f4-27f1-43bf-82c7-fa79994431f0', 2, 'II', 'Vif', 'Concerto pour violoncelle et orchestre: II. Vif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16848 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae1720f4-27f1-43bf-82c7-fa79994431f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Paradisiaque', part.name_en = 'Concerto pour violoncelle et orchestre: III. Paradisiaque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16848 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:17254711-a35f-4da7-a9f0-8e72587be905' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17254711-a35f-4da7-a9f0-8e72587be905', 3, 'III', 'Paradisiaque', 'Concerto pour violoncelle et orchestre: III. Paradisiaque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16848 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17254711-a35f-4da7-a9f0-8e72587be905'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Cadence', part.name_en = 'Concerto pour violoncelle et orchestre: IV. Cadence',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16848 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:860c9418-2ac1-4aa0-b84e-66270c44d4c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:860c9418-2ac1-4aa0-b84e-66270c44d4c8', 4, 'IV', 'Cadence', 'Concerto pour violoncelle et orchestre: IV. Cadence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16848 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:860c9418-2ac1-4aa0-b84e-66270c44d4c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Orgiaque', part.name_en = 'Concerto pour violoncelle et orchestre: V. Orgiaque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16848 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:5b9fd582-d9c5-40e3-9bab-b2c77b339598' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b9fd582-d9c5-40e3-9bab-b2c77b339598', 5, 'V', 'Orgiaque', 'Concerto pour violoncelle et orchestre: V. Orgiaque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16848 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b9fd582-d9c5-40e3-9bab-b2c77b339598'
);


-- None Cosmic Trilogy

UPDATE pieces piece
SET piece.title = 'Cosmic Trilogy', piece.title_en = 'Cosmic Trilogy',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19526 AND piece.composer_id = 155
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Aleph', part.name_en = 'Cosmic Trilogy: I. Aleph',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19526 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:4da898c8-bd6b-4f81-bb72-4bfe9b311f52' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4da898c8-bd6b-4f81-bb72-4bfe9b311f52', 1, 'I', 'Aleph', 'Cosmic Trilogy: I. Aleph', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19526 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4da898c8-bd6b-4f81-bb72-4bfe9b311f52'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Une lueur dans l’âge sombre', part.name_en = 'Cosmic Trilogy: II. Une lueur dans l’âge sombre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19526 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:707c604b-da9a-44ca-abfa-c59c78e5b0f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:707c604b-da9a-44ca-abfa-c59c78e5b0f8', 2, 'II', 'Une lueur dans l’âge sombre', 'Cosmic Trilogy: II. Une lueur dans l’âge sombre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19526 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:707c604b-da9a-44ca-abfa-c59c78e5b0f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:707c604b-da9a-44ca-abfa-c59c78e5b0f8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Une lueur dans l’âge sombre (Continued). Très lent - tempo 1 - à peine plus animé - a tempo (1) - plus lent', part.name_en = 'Cosmic Trilogy: II. Une lueur dans l’âge sombre (Continued). Très lent - tempo 1 - à peine plus animé - a tempo (1) - plus lent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19526 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:1f77d1d3-b891-4a78-8575-29342cd6c7c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1f77d1d3-b891-4a78-8575-29342cd6c7c5', 1, NULL, 'Une lueur dans l’âge sombre (Continued). Très lent - tempo 1 - à peine plus animé - a tempo (1) - plus lent', 'Cosmic Trilogy: II. Une lueur dans l’âge sombre (Continued). Très lent - tempo 1 - à peine plus animé - a tempo (1) - plus lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:707c604b-da9a-44ca-abfa-c59c78e5b0f8'
WHERE p.id = 19526 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f77d1d3-b891-4a78-8575-29342cd6c7c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:707c604b-da9a-44ca-abfa-c59c78e5b0f8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Une lueur dans l’âge sombre. Cosmique - détendre - calme', part.name_en = 'Cosmic Trilogy: II. Une lueur dans l’âge sombre. Cosmique - détendre - calme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19526 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:3f32db18-6cd1-4fc6-a0f5-94fdb0874a3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3f32db18-6cd1-4fc6-a0f5-94fdb0874a3f', 2, NULL, 'Une lueur dans l’âge sombre. Cosmique - détendre - calme', 'Cosmic Trilogy: II. Une lueur dans l’âge sombre. Cosmique - détendre - calme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:707c604b-da9a-44ca-abfa-c59c78e5b0f8'
WHERE p.id = 19526 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f32db18-6cd1-4fc6-a0f5-94fdb0874a3f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:707c604b-da9a-44ca-abfa-c59c78e5b0f8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Une lueur dans l’âge sombre (Continued). A tempo (1) - animer un peu - agité - plus large - animer imperceptiblement - tempo 1 - un peu plus lent - calme - plus lent, extatique, en calmant jusqu''à la fin', part.name_en = 'Cosmic Trilogy: II. Une lueur dans l’âge sombre (Continued). A tempo (1) - animer un peu - agité - plus large - animer imperceptiblement - tempo 1 - un peu plus lent - calme - plus lent, extatique, en calmant jusqu''à la fin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19526 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:54bc3607-1dd9-4ce4-879f-3f388fd5b801' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:54bc3607-1dd9-4ce4-879f-3f388fd5b801', 3, NULL, 'Une lueur dans l’âge sombre (Continued). A tempo (1) - animer un peu - agité - plus large - animer imperceptiblement - tempo 1 - un peu plus lent - calme - plus lent, extatique, en calmant jusqu''à la fin', 'Cosmic Trilogy: II. Une lueur dans l’âge sombre (Continued). A tempo (1) - animer un peu - agité - plus large - animer imperceptiblement - tempo 1 - un peu plus lent - calme - plus lent, extatique, en calmant jusqu''à la fin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:707c604b-da9a-44ca-abfa-c59c78e5b0f8'
WHERE p.id = 19526 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54bc3607-1dd9-4ce4-879f-3f388fd5b801'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Supernova', part.name_en = 'Cosmic Trilogy: III. Supernova',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19526 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:b0117704-b16a-45fd-a8f5-8e5aed538e9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0117704-b16a-45fd-a8f5-8e5aed538e9b', 3, 'III', 'Supernova', 'Cosmic Trilogy: III. Supernova', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19526 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0117704-b16a-45fd-a8f5-8e5aed538e9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b0117704-b16a-45fd-a8f5-8e5aed538e9b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Supernova. I) quelques cercles. Sensuel - à peine plus vite - [...] - subitement calme et glacé', part.name_en = 'Cosmic Trilogy: III. Supernova. I) quelques cercles. Sensuel - à peine plus vite - [...] - subitement calme et glacé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19526 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:140c9820-f198-42af-b500-970fa804c8ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:140c9820-f198-42af-b500-970fa804c8ac', 1, NULL, 'Supernova. I) quelques cercles. Sensuel - à peine plus vite - [...] - subitement calme et glacé', 'Cosmic Trilogy: III. Supernova. I) quelques cercles. Sensuel - à peine plus vite - [...] - subitement calme et glacé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b0117704-b16a-45fd-a8f5-8e5aed538e9b'
WHERE p.id = 19526 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:140c9820-f198-42af-b500-970fa804c8ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b0117704-b16a-45fd-a8f5-8e5aed538e9b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Supernova. II) pulsating star. Très vif - un peu moins vite - exultant - ralentir et calmer très progressivement - subitement un peu plus vite, comme un souvenir lointain et mystérieux - dans un sentiment d''attente - plus animé - exalté - plus vite et de plus', part.name_en = 'Cosmic Trilogy: III. Supernova. II) pulsating star. Très vif - un peu moins vite - exultant - ralentir et calmer très progressivement - subitement un peu plus vite, comme un souvenir lointain et mystérieux - dans un sentiment d''attente - plus animé - exalté - plus vite et de plus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19526 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:c54c32e8-76bd-4165-99ca-90819197a5f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c54c32e8-76bd-4165-99ca-90819197a5f4', 2, NULL, 'Supernova. II) pulsating star. Très vif - un peu moins vite - exultant - ralentir et calmer très progressivement - subitement un peu plus vite, comme un souvenir lointain et mystérieux - dans un sentiment d''attente - plus animé - exalté - plus vite et de plus', 'Cosmic Trilogy: III. Supernova. II) pulsating star. Très vif - un peu moins vite - exultant - ralentir et calmer très progressivement - subitement un peu plus vite, comme un souvenir lointain et mystérieux - dans un sentiment d''attente - plus animé - exalté - plus vite et de plus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b0117704-b16a-45fd-a8f5-8e5aed538e9b'
WHERE p.id = 19526 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c54c32e8-76bd-4165-99ca-90819197a5f4'
);


-- None E chiaro nella valle il fiume appare

UPDATE pieces piece
SET piece.title = 'E chiaro nella valle il fiume appare', piece.title_en = 'E chiaro nella valle il fiume appare',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18306 AND piece.composer_id = 155
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Flammenschrift

UPDATE pieces piece
SET piece.title = 'Flammenschrift', piece.title_en = 'Flammenschrift',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16212 AND piece.composer_id = 155
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Les Chants de l'Agartha

UPDATE pieces piece
SET piece.title = 'Les Chants de l''Agartha', piece.title_en = 'Les Chants de l''Agartha',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17048 AND piece.composer_id = 155
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sous le désert de Mongolie', part.name_en = 'Les Chants de l''Agartha: I. Sous le désert de Mongolie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17048 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:9c1f81ce-6574-485e-891c-d83ed726069f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c1f81ce-6574-485e-891c-d83ed726069f', 1, 'I', 'Sous le désert de Mongolie', 'Les Chants de l''Agartha: I. Sous le désert de Mongolie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17048 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c1f81ce-6574-485e-891c-d83ed726069f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'La Bibliothèque des savoirs perdus', part.name_en = 'Les Chants de l''Agartha: II. La Bibliothèque des savoirs perdus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17048 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:c69524b3-f0b8-47a4-87a0-73c9a929fd91' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c69524b3-f0b8-47a4-87a0-73c9a929fd91', 2, 'II', 'La Bibliothèque des savoirs perdus', 'Les Chants de l''Agartha: II. La Bibliothèque des savoirs perdus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17048 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c69524b3-f0b8-47a4-87a0-73c9a929fd91'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Danse devant le roi du monde', part.name_en = 'Les Chants de l''Agartha: III. Danse devant le roi du monde',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17048 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:02b94c13-6091-4e3e-9182-fb558e1b1e8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02b94c13-6091-4e3e-9182-fb558e1b1e8e', 3, 'III', 'Danse devant le roi du monde', 'Les Chants de l''Agartha: III. Danse devant le roi du monde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17048 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02b94c13-6091-4e3e-9182-fb558e1b1e8e'
);


-- None Lucifer

UPDATE pieces piece
SET piece.title = 'Lucifer', piece.title_en = 'Lucifer',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19575 AND piece.composer_id = 155
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le couronnement du Porteur de lumière', part.name_en = 'Lucifer: N°1. Le couronnement du Porteur de lumière',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19575 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:e511fb04-0fe7-4aa7-82fd-a0ebdb621eef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e511fb04-0fe7-4aa7-82fd-a0ebdb621eef', 1, NULL, 'Le couronnement du Porteur de lumière', 'Lucifer: N°1. Le couronnement du Porteur de lumière', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19575 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e511fb04-0fe7-4aa7-82fd-a0ebdb621eef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Le voyage de Lucifer', part.name_en = 'Lucifer: N°2. Le voyage de Lucifer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19575 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:51b2e392-a483-42c6-89b6-267beeb21b02' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51b2e392-a483-42c6-89b6-267beeb21b02', 2, NULL, 'Le voyage de Lucifer', 'Lucifer: N°2. Le voyage de Lucifer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19575 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51b2e392-a483-42c6-89b6-267beeb21b02'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La Rencontre', part.name_en = 'Lucifer: N°3. La Rencontre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19575 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:068573b6-cef7-40fd-8280-8cbd1dd30f86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:068573b6-cef7-40fd-8280-8cbd1dd30f86', 3, NULL, 'La Rencontre', 'Lucifer: N°3. La Rencontre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19575 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:068573b6-cef7-40fd-8280-8cbd1dd30f86'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Le Procès', part.name_en = 'Lucifer: N°4. Le Procès',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19575 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:171395d7-61f9-42c2-9789-d3d7c6d7eef3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:171395d7-61f9-42c2-9789-d3d7c6d7eef3', 4, NULL, 'Le Procès', 'Lucifer: N°4. Le Procès', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19575 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:171395d7-61f9-42c2-9789-d3d7c6d7eef3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'La Chute', part.name_en = 'Lucifer: N°5. La Chute',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19575 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:96dfc664-60c3-4a27-8c98-166b91b6b78b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96dfc664-60c3-4a27-8c98-166b91b6b78b', 5, NULL, 'La Chute', 'Lucifer: N°5. La Chute', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19575 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96dfc664-60c3-4a27-8c98-166b91b6b78b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'L''Ailleurs', part.name_en = 'Lucifer: N°6. L''Ailleurs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19575 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:d0ddfcf7-4c0e-4d1e-9df5-81bb07804d35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0ddfcf7-4c0e-4d1e-9df5-81bb07804d35', 6, NULL, 'L''Ailleurs', 'Lucifer: N°6. L''Ailleurs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19575 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0ddfcf7-4c0e-4d1e-9df5-81bb07804d35'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Epilogue', part.name_en = 'Lucifer: N°7. Epilogue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19575 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:21d51186-8fc9-438a-b9e1-80dae48f97c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21d51186-8fc9-438a-b9e1-80dae48f97c0', 7, NULL, 'Epilogue', 'Lucifer: N°7. Epilogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19575 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21d51186-8fc9-438a-b9e1-80dae48f97c0'
);


-- None Maslenitsa

UPDATE pieces piece
SET piece.title = 'Maslenitsa', piece.title_en = 'Maslenitsa',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17015 AND piece.composer_id = 155
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pour sortir au jour

UPDATE pieces piece
SET piece.title = 'Pour sortir au jour', piece.title_en = 'Pour sortir au jour',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17078 AND piece.composer_id = 155
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Danse processionnelle', part.name_en = 'Pour sortir au jour: I. Danse processionnelle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17078 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:ccc7ec97-4249-48e9-880a-26113093afd3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccc7ec97-4249-48e9-880a-26113093afd3', 1, 'I', 'Danse processionnelle', 'Pour sortir au jour: I. Danse processionnelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17078 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccc7ec97-4249-48e9-880a-26113093afd3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Entrée dans la Douat', part.name_en = 'Pour sortir au jour: II. Entrée dans la Douat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17078 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:f5c52be9-f00a-440e-acf7-73f8c343f099' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5c52be9-f00a-440e-acf7-73f8c343f099', 2, 'II', 'Entrée dans la Douat', 'Pour sortir au jour: II. Entrée dans la Douat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17078 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5c52be9-f00a-440e-acf7-73f8c343f099'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Danse de la Justification', part.name_en = 'Pour sortir au jour: III. Danse de la Justification',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17078 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:4742442f-3e56-42b8-b21a-a5cc3bd2eef2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4742442f-3e56-42b8-b21a-a5cc3bd2eef2', 3, 'III', 'Danse de la Justification', 'Pour sortir au jour: III. Danse de la Justification', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17078 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4742442f-3e56-42b8-b21a-a5cc3bd2eef2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'La balance des Dieux', part.name_en = 'Pour sortir au jour: IV. La balance des Dieux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17078 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:aa03c3bc-bf1b-4bbd-8a64-e075c7eb93fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa03c3bc-bf1b-4bbd-8a64-e075c7eb93fa', 4, 'IV', 'La balance des Dieux', 'Pour sortir au jour: IV. La balance des Dieux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17078 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa03c3bc-bf1b-4bbd-8a64-e075c7eb93fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Danse dans les champs de lalou', part.name_en = 'Pour sortir au jour: V. Danse dans les champs de lalou',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17078 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:5fc099b9-f35b-4fbc-acd8-2d9393c0f25d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fc099b9-f35b-4fbc-acd8-2d9393c0f25d', 5, 'V', 'Danse dans les champs de lalou', 'Pour sortir au jour: V. Danse dans les champs de lalou', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17078 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fc099b9-f35b-4fbc-acd8-2d9393c0f25d'
);


-- None Sextuor

UPDATE pieces piece
SET piece.title = 'Sextuor', piece.title_en = 'Sextuor',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16544 AND piece.composer_id = 155
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Dynamique', part.name_en = 'Sextuor: I. Dynamique',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16544 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:d3351fb4-a61f-4abc-82cf-1427610c5e6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3351fb4-a61f-4abc-82cf-1427610c5e6b', 1, 'I', 'Dynamique', 'Sextuor: I. Dynamique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16544 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3351fb4-a61f-4abc-82cf-1427610c5e6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Nocturne', part.name_en = 'Sextuor: II. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16544 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:e8153486-dc33-432d-bd84-368691f781bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8153486-dc33-432d-bd84-368691f781bf', 2, 'II', 'Nocturne', 'Sextuor: II. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16544 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8153486-dc33-432d-bd84-368691f781bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Festif', part.name_en = 'Sextuor: III. Festif',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16544 AND p.composer_id = 155 AND part.part_key = 'musicbrainz:f936c846-455e-4412-bd20-a77fcc2db9e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f936c846-455e-4412-bd20-a77fcc2db9e9', 3, 'III', 'Festif', 'Sextuor: III. Festif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16544 AND p.composer_id = 155
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f936c846-455e-4412-bd20-a77fcc2db9e9'
);


-- None Techno-Parade

UPDATE pieces piece
SET piece.title = 'Techno-Parade', piece.title_en = 'Techno-Parade',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17621 AND piece.composer_id = 155
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Shining One

UPDATE pieces piece
SET piece.title = 'The Shining One', piece.title_en = 'The Shining One',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18574 AND piece.composer_id = 155
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Toccata-Nocturne

UPDATE pieces piece
SET piece.title = 'Toccata-Nocturne', piece.title_en = 'Toccata-Nocturne',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18308 AND piece.composer_id = 155
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quatuor à cordes

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Quatuor à cordes', 'Quatuor à cordes', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 155
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Quatuor à cordes'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ba18c13-46ab-469f-809b-68e74f057109'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4ba18c13-46ab-469f-809b-68e74f057109'
FROM pieces p
WHERE p.composer_id = 155 AND p.title = 'Quatuor à cordes' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ba18c13-46ab-469f-809b-68e74f057109'
);

-- 숨길 seed 작품 없음

-- ===== Nancy Van de Vate (composer_id 158) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 9개(묶음 4, 다악장 2, 낱곡 3),
-- 새 작품 2개, part 30개, 그 아래 0개.
-- seed 10개 중 7개를 작품·part 에 잇고, 3개를 숨기고, 0개는 그대로 둔다.

-- None Chernobyl

UPDATE pieces piece
SET piece.title = 'Chernobyl', piece.title_en = 'Chernobyl',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19745 AND piece.composer_id = 158
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music in Five, Three and Seven

UPDATE pieces piece
SET piece.title = 'Music in Five, Three and Seven', piece.title_en = 'Music in Five, Three and Seven',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18536 AND piece.composer_id = 158
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Music in Five, Three and Seven: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18536 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:dd02cb1b-0dd4-45ec-bd64-7f7d2a76c160' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd02cb1b-0dd4-45ec-bd64-7f7d2a76c160', 1, NULL, 'I', 'Music in Five, Three and Seven: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18536 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd02cb1b-0dd4-45ec-bd64-7f7d2a76c160'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Music in Five, Three and Seven: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18536 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:17bb7b86-d57b-4146-8c6a-7474aad7af46' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17bb7b86-d57b-4146-8c6a-7474aad7af46', 2, NULL, 'II', 'Music in Five, Three and Seven: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18536 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17bb7b86-d57b-4146-8c6a-7474aad7af46'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Music in Five, Three and Seven: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18536 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:be972d14-1469-4fdf-8b11-a5af140778e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be972d14-1469-4fdf-8b11-a5af140778e3', 3, NULL, 'III', 'Music in Five, Three and Seven: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18536 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be972d14-1469-4fdf-8b11-a5af140778e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Music in Five, Three and Seven: IV.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18536 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:21bba327-8436-429a-af46-880525b65bdc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21bba327-8436-429a-af46-880525b65bdc', 4, NULL, 'IV', 'Music in Five, Three and Seven: IV.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18536 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21bba327-8436-429a-af46-880525b65bdc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'V', part.name_en = 'Music in Five, Three and Seven: V.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18536 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:4159d5c7-c914-4b00-8fc3-3f56d10b582c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4159d5c7-c914-4b00-8fc3-3f56d10b582c', 5, NULL, 'V', 'Music in Five, Three and Seven: V.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18536 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4159d5c7-c914-4b00-8fc3-3f56d10b582c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'VI', part.name_en = 'Music in Five, Three and Seven: VI.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18536 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:d312679c-041e-45e1-badc-e477fc5524ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d312679c-041e-45e1-badc-e477fc5524ea', 6, NULL, 'VI', 'Music in Five, Three and Seven: VI.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18536 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d312679c-041e-45e1-badc-e477fc5524ea'
);


-- None Seven Fantasy Pieces for Violin and Piano

UPDATE pieces piece
SET piece.title = 'Seven Fantasy Pieces for Violin and Piano', piece.title_en = 'Seven Fantasy Pieces for Violin and Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16801 AND piece.composer_id = 158
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Slow and expressive', part.name_en = 'Seven Fantasy Pieces for Violin and Piano: I. Slow and expressive',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16801 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:7d115662-4b4b-46ef-a450-6d87241ca10b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d115662-4b4b-46ef-a450-6d87241ca10b', 1, 'I', 'Slow and expressive', 'Seven Fantasy Pieces for Violin and Piano: I. Slow and expressive', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16801 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d115662-4b4b-46ef-a450-6d87241ca10b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Slowly, with a timeless quality', part.name_en = 'Seven Fantasy Pieces for Violin and Piano: II. Slowly, with a timeless quality',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16801 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:f5ce5951-eac8-48bd-9f93-33fd48fa0c54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5ce5951-eac8-48bd-9f93-33fd48fa0c54', 2, 'II', 'Slowly, with a timeless quality', 'Seven Fantasy Pieces for Violin and Piano: II. Slowly, with a timeless quality', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16801 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5ce5951-eac8-48bd-9f93-33fd48fa0c54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Fast', part.name_en = 'Seven Fantasy Pieces for Violin and Piano: III. Fast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16801 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:421187bc-7fca-46b1-bdb9-f06ac23a526d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:421187bc-7fca-46b1-bdb9-f06ac23a526d', 3, 'III', 'Fast', 'Seven Fantasy Pieces for Violin and Piano: III. Fast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16801 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:421187bc-7fca-46b1-bdb9-f06ac23a526d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Very slowly', part.name_en = 'Seven Fantasy Pieces for Violin and Piano: IV. Very slowly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16801 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:da6f62f8-8520-412a-8891-70fada1a7c0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da6f62f8-8520-412a-8891-70fada1a7c0d', 4, 'IV', 'Very slowly', 'Seven Fantasy Pieces for Violin and Piano: IV. Very slowly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16801 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da6f62f8-8520-412a-8891-70fada1a7c0d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Quickly', part.name_en = 'Seven Fantasy Pieces for Violin and Piano: V. Quickly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16801 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:13cac628-4bf5-49ad-b36c-0fb9222dbf10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13cac628-4bf5-49ad-b36c-0fb9222dbf10', 5, 'V', 'Quickly', 'Seven Fantasy Pieces for Violin and Piano: V. Quickly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16801 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13cac628-4bf5-49ad-b36c-0fb9222dbf10'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Eerily', part.name_en = 'Seven Fantasy Pieces for Violin and Piano: VI. Eerily',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16801 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:facc6595-a97c-412f-9269-2ec53711aecb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:facc6595-a97c-412f-9269-2ec53711aecb', 6, 'VI', 'Eerily', 'Seven Fantasy Pieces for Violin and Piano: VI. Eerily', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16801 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:facc6595-a97c-412f-9269-2ec53711aecb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Fast', part.name_en = 'Seven Fantasy Pieces for Violin and Piano: VII. Fast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16801 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:56356ccb-74b4-42fc-8e51-9c1bc650a886' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56356ccb-74b4-42fc-8e51-9c1bc650a886', 7, 'VII', 'Fast', 'Seven Fantasy Pieces for Violin and Piano: VII. Fast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16801 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56356ccb-74b4-42fc-8e51-9c1bc650a886'
);


-- None 6개의 연습곡

UPDATE pieces piece
SET piece.title = '6개의 연습곡', piece.title_en = 'Six Etudes for Solo Viola',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16478 AND piece.composer_id = 158
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Songs for the Four Parts of Night

UPDATE pieces piece
SET piece.title = 'Songs for the Four Parts of Night', piece.title_en = 'Songs for the Four Parts of Night',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16378 AND piece.composer_id = 158
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'In the Blue Night', part.name_en = 'In the Blue Night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16378 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:ba08e7d3-eb92-4578-9ecc-b5e2540c5854' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba08e7d3-eb92-4578-9ecc-b5e2540c5854', 1, NULL, 'In the Blue Night', 'In the Blue Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16378 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba08e7d3-eb92-4578-9ecc-b5e2540c5854'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'In the Dark I Enter', part.name_en = 'In the Dark I Enter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16378 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:77f16410-7801-4761-a0dd-6db9427ae3c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77f16410-7801-4761-a0dd-6db9427ae3c2', 2, NULL, 'In the Dark I Enter', 'In the Dark I Enter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16378 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77f16410-7801-4761-a0dd-6db9427ae3c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'I Can See Spirit Tufts of White Feathers', part.name_en = 'I Can See Spirit Tufts of White Feathers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16378 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:60f05318-af2b-4723-b998-abf059e0a5f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60f05318-af2b-4723-b998-abf059e0a5f1', 3, NULL, 'I Can See Spirit Tufts of White Feathers', 'I Can See Spirit Tufts of White Feathers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16378 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60f05318-af2b-4723-b998-abf059e0a5f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'In the Great Night', part.name_en = 'In the Great Night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16378 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:a45748d5-81f2-4cd5-8ddb-677c05e02371' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a45748d5-81f2-4cd5-8ddb-677c05e02371', 4, NULL, 'In the Great Night', 'In the Great Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16378 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a45748d5-81f2-4cd5-8ddb-677c05e02371'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'I Am Going to See the Land', part.name_en = 'I Am Going to See the Land',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16378 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:1563b424-8404-4424-a46a-3ad6a922f104' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1563b424-8404-4424-a46a-3ad6a922f104', 5, NULL, 'I Am Going to See the Land', 'I Am Going to See the Land', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16378 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1563b424-8404-4424-a46a-3ad6a922f104'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'The Dawn Approaches', part.name_en = 'The Dawn Approaches',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16378 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:a2a5f541-1ef8-456b-92af-56bdf35b9abd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2a5f541-1ef8-456b-92af-56bdf35b9abd', 6, NULL, 'The Dawn Approaches', 'The Dawn Approaches', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16378 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2a5f541-1ef8-456b-92af-56bdf35b9abd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'The Morning Star', part.name_en = 'The Morning Star',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16378 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:72b78161-58f2-4a52-8c81-a4721bb0adf4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72b78161-58f2-4a52-8c81-a4721bb0adf4', 7, NULL, 'The Morning Star', 'The Morning Star', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16378 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72b78161-58f2-4a52-8c81-a4721bb0adf4'
);


-- None Suite for Marimba

UPDATE pieces piece
SET piece.title = 'Suite for Marimba', piece.title_en = 'Suite for Marimba',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19388 AND piece.composer_id = 158
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Suite for Marimba: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19388 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:0199c9b5-250a-44d0-924f-75d10af89637' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0199c9b5-250a-44d0-924f-75d10af89637', 1, NULL, 'I', 'Suite for Marimba: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19388 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0199c9b5-250a-44d0-924f-75d10af89637'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Suite for Marimba: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19388 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:65155b68-8cc2-4eb2-9ccc-d4f3f8b9be44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65155b68-8cc2-4eb2-9ccc-d4f3f8b9be44', 2, NULL, 'II', 'Suite for Marimba: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19388 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65155b68-8cc2-4eb2-9ccc-d4f3f8b9be44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Suite for Marimba: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19388 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:2679cbd3-0dd5-41a2-8b85-d7205bb95fb6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2679cbd3-0dd5-41a2-8b85-d7205bb95fb6', 3, NULL, 'III', 'Suite for Marimba: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19388 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2679cbd3-0dd5-41a2-8b85-d7205bb95fb6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Suite for Marimba: IV.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19388 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:501818f9-cc8b-46c9-9573-bf349dbd8391' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:501818f9-cc8b-46c9-9573-bf349dbd8391', 4, NULL, 'IV', 'Suite for Marimba: IV.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19388 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:501818f9-cc8b-46c9-9573-bf349dbd8391'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'V', part.name_en = 'Suite for Marimba: V.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19388 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:5337c1f8-031f-4135-b196-8a2811282832' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5337c1f8-031f-4135-b196-8a2811282832', 5, NULL, 'V', 'Suite for Marimba: V.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19388 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5337c1f8-031f-4135-b196-8a2811282832'
);


-- None Two for Two

UPDATE pieces piece
SET piece.title = 'Two for Two', piece.title_en = 'Two for Two',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18302 AND piece.composer_id = 158
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Two for Two: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18302 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:9eaec9b8-5878-4a2f-a678-11b89218dc07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9eaec9b8-5878-4a2f-a678-11b89218dc07', 1, NULL, 'No. 1', 'Two for Two: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18302 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9eaec9b8-5878-4a2f-a678-11b89218dc07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Two for Two: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18302 AND p.composer_id = 158 AND part.part_key = 'musicbrainz:948c6b71-3d04-42d1-86c7-af2d4bbd8425' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:948c6b71-3d04-42d1-86c7-af2d4bbd8425', 2, NULL, 'No. 2', 'Two for Two: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18302 AND p.composer_id = 158
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:948c6b71-3d04-42d1-86c7-af2d4bbd8425'
);


-- None 바이올린 협주곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡 1번', 'Concerto no. 1 for Violin and Orchestra', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 158
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '467f8408-d9a7-45cb-95ef-bbb6a32d1ffd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '467f8408-d9a7-45cb-95ef-bbb6a32d1ffd'
FROM pieces p
WHERE p.composer_id = 158 AND p.title = '바이올린 협주곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '467f8408-d9a7-45cb-95ef-bbb6a32d1ffd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf99aac5-2cb0-4f26-b027-ca4b3fd59b14', 1, NULL, 'I', 'Concerto no. 1 for Violin and Orchestra: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 158 AND p.title = '바이올린 협주곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf99aac5-2cb0-4f26-b027-ca4b3fd59b14'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ac45111-1033-4137-8030-baf4fbbef966', 2, NULL, 'II', 'Concerto no. 1 for Violin and Orchestra: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 158 AND p.title = '바이올린 협주곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ac45111-1033-4137-8030-baf4fbbef966'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41717dc2-6a2d-4d71-b87c-b0f67c5be798', 3, NULL, 'III', 'Concerto no. 1 for Violin and Orchestra: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 158 AND p.title = '바이올린 협주곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41717dc2-6a2d-4d71-b87c-b0f67c5be798'
);


-- None 현악 4중주 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 2번', 'String Quartet No. 2', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 158
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90a62b14-0d06-4d60-a047-8d8dba36f63e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '90a62b14-0d06-4d60-a047-8d8dba36f63e'
FROM pieces p
WHERE p.composer_id = 158 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90a62b14-0d06-4d60-a047-8d8dba36f63e'
);

-- 카탈로그에 대응이 없는 seed 작품 3개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 158 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    16955, 17919, 19205
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- ===== Kazimierz Serocki (composer_id 159) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 15개(묶음 2, 다악장 4, 낱곡 9),
-- 새 작품 1개, part 47개, 그 아래 0개.
-- seed 14개 중 14개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 트롬본 협주곡

UPDATE pieces piece
SET piece.title = '트롬본 협주곡', piece.title_en = 'Concerto for Trombone and Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17490 AND piece.composer_id = 159
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lento espressive, molto rubato - Allegro', part.name_en = 'Concerto for Trombone and Orchestra: I. Lento espressive, molto rubato - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17490 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:b320e033-0ce9-4a55-a0b2-070f7dd57e73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b320e033-0ce9-4a55-a0b2-070f7dd57e73', 1, 'I', 'Lento espressive, molto rubato - Allegro', 'Concerto for Trombone and Orchestra: I. Lento espressive, molto rubato - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17490 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b320e033-0ce9-4a55-a0b2-070f7dd57e73'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Largo, molto cantabile', part.name_en = 'Concerto for Trombone and Orchestra: II. Largo, molto cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17490 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:5ff3be5b-1c7e-49d7-8737-bc277acc9ca7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ff3be5b-1c7e-49d7-8737-bc277acc9ca7', 2, 'II', 'Largo, molto cantabile', 'Concerto for Trombone and Orchestra: II. Largo, molto cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17490 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ff3be5b-1c7e-49d7-8737-bc277acc9ca7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro grazioso', part.name_en = 'Concerto for Trombone and Orchestra: III. Allegro grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17490 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:17eccb03-e982-4f40-a163-e8706d69ae5f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17eccb03-e982-4f40-a163-e8706d69ae5f', 3, 'III', 'Allegro grazioso', 'Concerto for Trombone and Orchestra: III. Allegro grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17490 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17eccb03-e982-4f40-a163-e8706d69ae5f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'Concerto for Trombone and Orchestra: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17490 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:b7f29367-b15a-419e-bec5-9512efdbabbb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7f29367-b15a-419e-bec5-9512efdbabbb', 4, 'IV', 'Allegro', 'Concerto for Trombone and Orchestra: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17490 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7f29367-b15a-419e-bec5-9512efdbabbb'
);


-- None Continuum

UPDATE pieces piece
SET piece.title = 'Continuum', piece.title_en = 'Continuum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17785 AND piece.composer_id = 159
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Epizody

UPDATE pieces piece
SET piece.title = 'Epizody', piece.title_en = 'Epizody',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18726 AND piece.composer_id = 159
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Forte e piano

UPDATE pieces piece
SET piece.title = 'Forte e piano', piece.title_en = 'Forte e piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19613 AND piece.composer_id = 159
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Freski symfoniczne

UPDATE pieces piece
SET piece.title = 'Freski symfoniczne', piece.title_en = 'Freski symfoniczne',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17529 AND piece.composer_id = 159
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Impromptu fantasque

UPDATE pieces piece
SET piece.title = 'Impromptu fantasque', piece.title_en = 'Impromptu fantasque',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19908 AND piece.composer_id = 159
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Musica concertante

UPDATE pieces piece
SET piece.title = 'Musica concertante', piece.title_en = 'Musica concertante',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18914 AND piece.composer_id = 159
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pianophonie

UPDATE pieces piece
SET piece.title = 'Pianophonie', piece.title_en = 'Pianophonie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17140 AND piece.composer_id = 159
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Segmenti

UPDATE pieces piece
SET piece.title = 'Segmenti', piece.title_en = 'Segmenti',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18759 AND piece.composer_id = 159
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sinfonietta for Two String Orchestras

UPDATE pieces piece
SET piece.title = 'Sinfonietta for Two String Orchestras', piece.title_en = 'Sinfonietta for Two String Orchestras',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17151 AND piece.composer_id = 159
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sonatina for Trombone and Piano

UPDATE pieces piece
SET piece.title = 'Sonatina for Trombone and Piano', piece.title_en = 'Sonatina for Trombone and Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18112 AND piece.composer_id = 159
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Sonatina for Trombone and Piano: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18112 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:2ee6f5ea-9151-48a9-9714-21691be22b34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ee6f5ea-9151-48a9-9714-21691be22b34', 1, 'I', 'Allegro', 'Sonatina for Trombone and Piano: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18112 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ee6f5ea-9151-48a9-9714-21691be22b34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Sonatina for Trombone and Piano: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18112 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:aaff18e9-375e-46cd-8312-1c9458034882' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aaff18e9-375e-46cd-8312-1c9458034882', 2, 'II', 'Andante', 'Sonatina for Trombone and Piano: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18112 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaff18e9-375e-46cd-8312-1c9458034882'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Sonatina for Trombone and Piano: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18112 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:6327e1fd-5d1e-42e5-a27b-926d3ba7ecc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6327e1fd-5d1e-42e5-a27b-926d3ba7ecc1', 3, 'III', 'Allegro', 'Sonatina for Trombone and Piano: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18112 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6327e1fd-5d1e-42e5-a27b-926d3ba7ecc1'
);


-- None Sonatina na puzon i fortepian

UPDATE pieces piece
SET piece.title = 'Sonatina na puzon i fortepian', piece.title_en = 'Sonatina na puzon i fortepian',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17840 AND piece.composer_id = 159
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Sonatina na puzon i fortepian: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17840 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:e9489ae1-99c8-4b0f-acb2-330dc6992b7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9489ae1-99c8-4b0f-acb2-330dc6992b7f', 1, 'I', 'Allegro', 'Sonatina na puzon i fortepian: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17840 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9489ae1-99c8-4b0f-acb2-330dc6992b7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante molto sostenuto', part.name_en = 'Sonatina na puzon i fortepian: II. Andante molto sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17840 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:8912ef61-0a27-4768-b513-9ca8fba5e7b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8912ef61-0a27-4768-b513-9ca8fba5e7b2', 2, 'II', 'Andante molto sostenuto', 'Sonatina na puzon i fortepian: II. Andante molto sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17840 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8912ef61-0a27-4768-b513-9ca8fba5e7b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro vivace', part.name_en = 'Sonatina na puzon i fortepian: III. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17840 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:c0b550a5-82d3-41b8-9972-147da45925b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0b550a5-82d3-41b8-9972-147da45925b3', 3, 'III', 'Allegro vivace', 'Sonatina na puzon i fortepian: III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17840 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0b550a5-82d3-41b8-9972-147da45925b3'
);


-- None Suite for Four Trombones

UPDATE pieces piece
SET piece.title = 'Suite for Four Trombones', piece.title_en = 'Suite for Four Trombones',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18039 AND piece.composer_id = 159
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Intrada', part.name_en = 'Suite for Four Trombones: I. Intrada',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18039 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:00cbf91c-4c12-46b8-8ebc-d7eef99f512a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00cbf91c-4c12-46b8-8ebc-d7eef99f512a', 1, 'I', 'Intrada', 'Suite for Four Trombones: I. Intrada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18039 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00cbf91c-4c12-46b8-8ebc-d7eef99f512a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'IV',
    part.name_ko = 'Chorale', part.name_en = 'Suite for Four Trombones: IV. Chorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18039 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:1d629fc9-ec0a-4db9-ada6-e743225e083d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d629fc9-ec0a-4db9-ada6-e743225e083d', 2, 'IV', 'Chorale', 'Suite for Four Trombones: IV. Chorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18039 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d629fc9-ec0a-4db9-ada6-e743225e083d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'V',
    part.name_ko = 'Intermezzo', part.name_en = 'Suite for Four Trombones: V. Intermezzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18039 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:389e7768-709f-4705-a317-289b9ea91d96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:389e7768-709f-4705-a317-289b9ea91d96', 3, 'V', 'Intermezzo', 'Suite for Four Trombones: V. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18039 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:389e7768-709f-4705-a317-289b9ea91d96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'VI',
    part.name_ko = 'Arietta', part.name_en = 'Suite for Four Trombones: VI. Arietta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18039 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:88aefb0d-d093-42c0-ace4-01e2a72a2c8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88aefb0d-d093-42c0-ace4-01e2a72a2c8e', 4, 'VI', 'Arietta', 'Suite for Four Trombones: VI. Arietta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18039 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88aefb0d-d093-42c0-ace4-01e2a72a2c8e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'VII',
    part.name_ko = 'Toccatina', part.name_en = 'Suite for Four Trombones: VII. Toccatina',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18039 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:b0433201-79f0-4b07-b840-cff8480234ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0433201-79f0-4b07-b840-cff8480234ec', 5, 'VII', 'Toccatina', 'Suite for Four Trombones: VII. Toccatina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18039 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0433201-79f0-4b07-b840-cff8480234ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'III',
    part.name_ko = 'Interlude', part.name_en = 'Suite for Four Trombones: III. Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18039 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:cf6ab65e-dd53-4e3a-bda6-092b367fc94d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf6ab65e-dd53-4e3a-bda6-092b367fc94d', 6, 'III', 'Interlude', 'Suite for Four Trombones: III. Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18039 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf6ab65e-dd53-4e3a-bda6-092b367fc94d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'II',
    part.name_ko = 'Canon', part.name_en = 'Suite for Four Trombones: II. Canon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18039 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:eb866989-4637-4105-805c-dbe5c5f2c6a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb866989-4637-4105-805c-dbe5c5f2c6a2', 7, 'II', 'Canon', 'Suite for Four Trombones: II. Canon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18039 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb866989-4637-4105-805c-dbe5c5f2c6a2'
);


-- None Suite of Preludes

UPDATE pieces piece
SET piece.title = 'Suite of Preludes', piece.title_en = 'Suite of Preludes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16795 AND piece.composer_id = 159
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Animato', part.name_en = 'Suite of Preludes: No. 1. Animato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16795 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:511aa3c2-4d1a-494f-a976-72d3ed03c6f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:511aa3c2-4d1a-494f-a976-72d3ed03c6f6', 1, NULL, 'Animato', 'Suite of Preludes: No. 1. Animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16795 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:511aa3c2-4d1a-494f-a976-72d3ed03c6f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Affettuoso', part.name_en = 'Suite of Preludes: No. 2. Affettuoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16795 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:a7bb5a59-800e-4965-bbf4-aca260d615ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7bb5a59-800e-4965-bbf4-aca260d615ed', 2, NULL, 'Affettuoso', 'Suite of Preludes: No. 2. Affettuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16795 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7bb5a59-800e-4965-bbf4-aca260d615ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Agitato', part.name_en = 'Suite of Preludes: No. 3. Agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16795 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:e0713574-6fa7-4b68-bd0f-3588278d3924' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0713574-6fa7-4b68-bd0f-3588278d3924', 3, NULL, 'Agitato', 'Suite of Preludes: No. 3. Agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16795 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0713574-6fa7-4b68-bd0f-3588278d3924'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Teneramente', part.name_en = 'Suite of Preludes: No. 4. Teneramente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16795 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:aa050b2b-7927-4197-99af-3e6d7d288c39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa050b2b-7927-4197-99af-3e6d7d288c39', 4, NULL, 'Teneramente', 'Suite of Preludes: No. 4. Teneramente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16795 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa050b2b-7927-4197-99af-3e6d7d288c39'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Veloce', part.name_en = 'Suite of Preludes: No. 5. Veloce',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16795 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:24dda77b-60a4-4776-9306-6a83d7b78925' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24dda77b-60a4-4776-9306-6a83d7b78925', 5, NULL, 'Veloce', 'Suite of Preludes: No. 5. Veloce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16795 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24dda77b-60a4-4776-9306-6a83d7b78925'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Capriccioso', part.name_en = 'Suite of Preludes: No. 6. Capriccioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16795 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:f6dde768-b7ea-4614-96b5-640f22dcdd81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6dde768-b7ea-4614-96b5-640f22dcdd81', 6, NULL, 'Capriccioso', 'Suite of Preludes: No. 6. Capriccioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16795 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6dde768-b7ea-4614-96b5-640f22dcdd81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Furioso', part.name_en = 'Suite of Preludes: No. 7. Furioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16795 AND p.composer_id = 159 AND part.part_key = 'musicbrainz:ec7f7c8b-1e83-4a50-a217-e40fb7e86cd6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec7f7c8b-1e83-4a50-a217-e40fb7e86cd6', 7, NULL, 'Furioso', 'Suite of Preludes: No. 7. Furioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16795 AND p.composer_id = 159
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec7f7c8b-1e83-4a50-a217-e40fb7e86cd6'
);


-- None 영화음악 <Potop>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <Potop>', 'Potop', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 159
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <Potop>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '813d0895-f56a-4a7d-a9b7-4f9f1af1f0c4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '813d0895-f56a-4a7d-a9b7-4f9f1af1f0c4'
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '813d0895-f56a-4a7d-a9b7-4f9f1af1f0c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01e304ac-3e94-451c-a2ff-74d862276eff', 1, NULL, 'Pożegnanie', 'Pożegnanie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01e304ac-3e94-451c-a2ff-74d862276eff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0884dd80-dd8a-45d4-a104-dccdefda0997', 2, NULL, '"Jestem sobie panem..."', '"Jestem sobie panem..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0884dd80-dd8a-45d4-a104-dccdefda0997'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12e8b2c8-60a6-4009-9c97-2100f1738cd8', 3, NULL, 'Na cekaliku', 'Na cekaliku', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12e8b2c8-60a6-4009-9c97-2100f1738cd8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13dcfb72-9ed7-41e9-8f3f-7caed9d16843', 4, NULL, 'Kmicic Babinicz', 'Kmicic Babinicz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13dcfb72-9ed7-41e9-8f3f-7caed9d16843'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:161763f6-ae52-4a5d-ae69-a746f8d65693', 5, NULL, 'Chorągwie Rzeczpospolitej', 'Chorągwie Rzeczpospolitej', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:161763f6-ae52-4a5d-ae69-a746f8d65693'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f493174-bed9-4bdb-9e42-c1c81c399f16', 6, NULL, 'Oleńka i Kmicic', 'Oleńka i Kmicic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f493174-bed9-4bdb-9e42-c1c81c399f16'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21d55ddd-26d1-4468-bbc7-87f10344a373', 7, NULL, 'Kulig', 'Kulig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21d55ddd-26d1-4468-bbc7-87f10344a373'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3458831f-fad5-4b9e-8e36-e2213f1ccc37', 8, NULL, 'Oleńka', 'Oleńka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3458831f-fad5-4b9e-8e36-e2213f1ccc37'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3932d82f-2d89-49e3-bdae-63e3b4c3f126', 9, NULL, 'Podstęp Kmicica', 'Podstęp Kmicica', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3932d82f-2d89-49e3-bdae-63e3b4c3f126'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:541b27f6-8085-4e6d-8cf2-84d79c20b100', 10, NULL, '"Oj wyjdę ja..."', '"Oj wyjdę ja..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:541b27f6-8085-4e6d-8cf2-84d79c20b100'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:694e714a-3b0a-4bc8-84ca-564915841876', 11, NULL, 'Częstochowa', 'Częstochowa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:694e714a-3b0a-4bc8-84ca-564915841876'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fecfe97-d1ee-46d9-9bf8-08a4219430c2', 12, NULL, 'Wojska szwedzkie', 'Wojska szwedzkie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fecfe97-d1ee-46d9-9bf8-08a4219430c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f6992eb-56da-4fc2-9afe-a16dcae5dfb6', 13, NULL, 'Spotkanie', 'Spotkanie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f6992eb-56da-4fc2-9afe-a16dcae5dfb6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91f7cdab-30b6-480c-ae4d-8b8c968f62ba', 14, NULL, 'Dla Rzeczpospolitej', 'Dla Rzeczpospolitej', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91f7cdab-30b6-480c-ae4d-8b8c968f62ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab474a9a-9dff-4287-801e-f7dea3ee8b66', 15, NULL, 'Potop', 'Potop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab474a9a-9dff-4287-801e-f7dea3ee8b66'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b01291fe-7196-4a3b-b1f5-e21101a4367f', 16, NULL, 'Kompanija', 'Kompanija', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b01291fe-7196-4a3b-b1f5-e21101a4367f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd7a080b-b492-41ee-b779-2ed7388280ce', 17, NULL, 'Dwór księcia Bogusława Radziwiłła', 'Dwór księcia Bogusława Radziwiłła', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd7a080b-b492-41ee-b779-2ed7388280ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3b736cc-6b1c-404a-a155-791a870df271', 18, NULL, 'Kmicic i Wołodyjowski', 'Kmicic i Wołodyjowski', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3b736cc-6b1c-404a-a155-791a870df271'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cda762d1-2217-4ca2-835c-03e7c87b81ff', 19, NULL, 'Był na Żmudzi ród Billewiczów', 'Był na Żmudzi ród Billewiczów', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cda762d1-2217-4ca2-835c-03e7c87b81ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d11deee9-07a0-43a9-ac8f-ff620c1cf9dc', 20, NULL, '"Oj miła ma..."', '"Oj miła ma..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d11deee9-07a0-43a9-ac8f-ff620c1cf9dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3608c97-8544-4a3d-b871-bef8b271c1c0', 21, NULL, 'Psalm Szwedów', 'Psalm Szwedów', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3608c97-8544-4a3d-b871-bef8b271c1c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef29552d-0bbb-4898-a4a4-435ce8ff6211', 22, NULL, 'Wieczerza u Radziwiłłów', 'Wieczerza u Radziwiłłów', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef29552d-0bbb-4898-a4a4-435ce8ff6211'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb7f5b2e-60dc-4bbf-b021-c658e37841b2', 23, NULL, 'Przed bitwą', 'Przed bitwą', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 159 AND p.title = '영화음악 <Potop>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb7f5b2e-60dc-4bbf-b021-c658e37841b2'
);

-- 숨길 seed 작품 없음

-- ===== André Souris (composer_id 160) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 3개(묶음 2, 다악장 1, 낱곡 0),
-- 새 작품 0개, part 17개, 그 아래 0개.
-- seed 3개 중 3개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Danceries de la Renaissance française

UPDATE pieces piece
SET piece.title = 'Danceries de la Renaissance française', piece.title_en = 'Danceries de la Renaissance française',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18932 AND piece.composer_id = 160
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Basse dance', part.name_en = 'Danceries de la Renaissance française : I. Basse dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18932 AND p.composer_id = 160 AND part.part_key = 'musicbrainz:8f735885-fac4-4623-92fa-1fe1464cc0ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f735885-fac4-4623-92fa-1fe1464cc0ad', 1, 'I', 'Basse dance', 'Danceries de la Renaissance française : I. Basse dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18932 AND p.composer_id = 160
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f735885-fac4-4623-92fa-1fe1464cc0ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Suite de Bransle de Bourgogne', part.name_en = 'Danceries de la Renaissance française : II. Suite de Bransle de Bourgogne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18932 AND p.composer_id = 160 AND part.part_key = 'musicbrainz:c0915de2-1248-43b4-a153-77686bdf0502' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0915de2-1248-43b4-a153-77686bdf0502', 2, 'II', 'Suite de Bransle de Bourgogne', 'Danceries de la Renaissance française : II. Suite de Bransle de Bourgogne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18932 AND p.composer_id = 160
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0915de2-1248-43b4-a153-77686bdf0502'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Pavane d''Angleterre avec sa Gaillarde', part.name_en = 'Danceries de la Renaissance française : III. Pavane d''Angleterre avec sa Gaillarde',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18932 AND p.composer_id = 160 AND part.part_key = 'musicbrainz:42b3ed47-c7f1-4dc5-b0e0-ea005465db9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42b3ed47-c7f1-4dc5-b0e0-ea005465db9c', 3, 'III', 'Pavane d''Angleterre avec sa Gaillarde', 'Danceries de la Renaissance française : III. Pavane d''Angleterre avec sa Gaillarde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18932 AND p.composer_id = 160
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42b3ed47-c7f1-4dc5-b0e0-ea005465db9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Suite d''Allemandes', part.name_en = 'Danceries de la Renaissance française : IV. Suite d''Allemandes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18932 AND p.composer_id = 160 AND part.part_key = 'musicbrainz:096b04d1-d25c-46ef-8e25-3884bf62b9ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:096b04d1-d25c-46ef-8e25-3884bf62b9ed', 4, 'IV', 'Suite d''Allemandes', 'Danceries de la Renaissance française : IV. Suite d''Allemandes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18932 AND p.composer_id = 160
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:096b04d1-d25c-46ef-8e25-3884bf62b9ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Tourdion', part.name_en = 'Danceries de la Renaissance française : V. Tourdion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18932 AND p.composer_id = 160 AND part.part_key = 'musicbrainz:f9103443-c3a2-4508-942c-8a37e9d80198' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9103443-c3a2-4508-942c-8a37e9d80198', 5, 'V', 'Tourdion', 'Danceries de la Renaissance française : V. Tourdion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18932 AND p.composer_id = 160
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9103443-c3a2-4508-942c-8a37e9d80198'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Suite de Bransles Gays', part.name_en = 'Danceries de la Renaissance française : VI. Suite de Bransles Gays',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18932 AND p.composer_id = 160 AND part.part_key = 'musicbrainz:f2e5bb39-c599-4bf6-9f3c-75555b22b04f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2e5bb39-c599-4bf6-9f3c-75555b22b04f', 6, 'VI', 'Suite de Bransles Gays', 'Danceries de la Renaissance française : VI. Suite de Bransles Gays', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18932 AND p.composer_id = 160
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2e5bb39-c599-4bf6-9f3c-75555b22b04f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Bransle d''Écosse', part.name_en = 'Danceries de la Renaissance française : VII. Bransle d''Écosse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18932 AND p.composer_id = 160 AND part.part_key = 'musicbrainz:de7e419a-407c-449e-ac28-280000661fff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de7e419a-407c-449e-ac28-280000661fff', 7, 'VII', 'Bransle d''Écosse', 'Danceries de la Renaissance française : VII. Bransle d''Écosse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18932 AND p.composer_id = 160
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de7e419a-407c-449e-ac28-280000661fff'
);


-- None 칸타타 <Le Marchand d'images, cantate rurale>

UPDATE pieces piece
SET piece.title = '칸타타 <Le Marchand d''images, cantate rurale>', piece.title_en = 'Le Marchand d''images, cantate rurale',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18442 AND piece.composer_id = 160
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Première partie', part.name_en = 'Le Marchand d''images, cantate rurale : Première partie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18442 AND p.composer_id = 160 AND part.part_key = 'musicbrainz:4d5700a4-a95f-449b-8cb7-5bf90e2eaed3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d5700a4-a95f-449b-8cb7-5bf90e2eaed3', 1, NULL, 'Première partie', 'Le Marchand d''images, cantate rurale : Première partie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18442 AND p.composer_id = 160
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d5700a4-a95f-449b-8cb7-5bf90e2eaed3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Deuxième partie (Pastorales)', part.name_en = 'Le Marchand d''images, cantate rurale : Deuxième partie (Pastorales)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18442 AND p.composer_id = 160 AND part.part_key = 'musicbrainz:4c81fc5a-22f6-4bb8-8a0e-1e76eb2cd39c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c81fc5a-22f6-4bb8-8a0e-1e76eb2cd39c', 2, NULL, 'Deuxième partie (Pastorales)', 'Le Marchand d''images, cantate rurale : Deuxième partie (Pastorales)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18442 AND p.composer_id = 160
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c81fc5a-22f6-4bb8-8a0e-1e76eb2cd39c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Troisième partie', part.name_en = 'Le Marchand d''images, cantate rurale : Troisième partie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18442 AND p.composer_id = 160 AND part.part_key = 'musicbrainz:f3b5e775-5ea6-4462-9f89-0664ef74f3a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3b5e775-5ea6-4462-9f89-0664ef74f3a1', 3, NULL, 'Troisième partie', 'Le Marchand d''images, cantate rurale : Troisième partie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18442 AND p.composer_id = 160
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3b5e775-5ea6-4462-9f89-0664ef74f3a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Quatrième partie (Comptines et Cantiques)', part.name_en = 'Le Marchand d''images, cantate rurale : Quatrième partie (Comptines et Cantiques)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18442 AND p.composer_id = 160 AND part.part_key = 'musicbrainz:9786edbf-23de-4330-b437-76535cf55fbb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9786edbf-23de-4330-b437-76535cf55fbb', 4, NULL, 'Quatrième partie (Comptines et Cantiques)', 'Le Marchand d''images, cantate rurale : Quatrième partie (Comptines et Cantiques)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18442 AND p.composer_id = 160
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9786edbf-23de-4330-b437-76535cf55fbb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Cinquième partie', part.name_en = 'Le Marchand d''images, cantate rurale : Cinquième partie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18442 AND p.composer_id = 160 AND part.part_key = 'musicbrainz:f5d53bb3-072c-4987-b61e-27d9608140dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5d53bb3-072c-4987-b61e-27d9608140dd', 5, NULL, 'Cinquième partie', 'Le Marchand d''images, cantate rurale : Cinquième partie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18442 AND p.composer_id = 160
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5d53bb3-072c-4987-b61e-27d9608140dd'
);


-- None 교향곡

UPDATE pieces piece
SET piece.title = '교향곡', piece.title_en = 'Symphonies',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16797 AND piece.composer_id = 160
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '1', part.name_en = 'Symphonies: 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16797 AND p.composer_id = 160 AND part.part_key = 'musicbrainz:04227153-bfea-4e6f-96e2-44f7c7db7c83' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04227153-bfea-4e6f-96e2-44f7c7db7c83', 1, NULL, '1', 'Symphonies: 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16797 AND p.composer_id = 160
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04227153-bfea-4e6f-96e2-44f7c7db7c83'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '2', part.name_en = 'Symphonies: 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16797 AND p.composer_id = 160 AND part.part_key = 'musicbrainz:1cf721e8-c7d8-401c-b5d5-181e549a1102' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cf721e8-c7d8-401c-b5d5-181e549a1102', 2, NULL, '2', 'Symphonies: 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16797 AND p.composer_id = 160
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cf721e8-c7d8-401c-b5d5-181e549a1102'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '3', part.name_en = 'Symphonies: 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16797 AND p.composer_id = 160 AND part.part_key = 'musicbrainz:332590a5-4df9-4fa0-927e-54d0d4b9b865' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:332590a5-4df9-4fa0-927e-54d0d4b9b865', 3, NULL, '3', 'Symphonies: 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16797 AND p.composer_id = 160
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:332590a5-4df9-4fa0-927e-54d0d4b9b865'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '4', part.name_en = 'Symphonies: 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16797 AND p.composer_id = 160 AND part.part_key = 'musicbrainz:f16f0d7d-0606-4499-959c-708e25bb4d93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f16f0d7d-0606-4499-959c-708e25bb4d93', 4, NULL, '4', 'Symphonies: 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16797 AND p.composer_id = 160
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f16f0d7d-0606-4499-959c-708e25bb4d93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '5', part.name_en = 'Symphonies: 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16797 AND p.composer_id = 160 AND part.part_key = 'musicbrainz:36d40f2c-9c90-4220-a2dd-6b5117dc6605' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36d40f2c-9c90-4220-a2dd-6b5117dc6605', 5, NULL, '5', 'Symphonies: 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16797 AND p.composer_id = 160
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36d40f2c-9c90-4220-a2dd-6b5117dc6605'
);

-- 숨길 seed 작품 없음

-- ===== William Henry Fry (composer_id 163) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 5개(묶음 0, 다악장 0, 낱곡 5),
-- 새 작품 1개, part 0개, 그 아래 0개.
-- seed 4개 중 4개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None Niagara Symphony

UPDATE pieces piece
SET piece.title = 'Niagara Symphony', piece.title_en = 'Niagara Symphony',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19663 AND piece.composer_id = 163
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Overture to Macbeth

UPDATE pieces piece
SET piece.title = 'Overture to Macbeth', piece.title_en = 'Overture to Macbeth',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16540 AND piece.composer_id = 163
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Santa Claus, Christmas Symphony

UPDATE pieces piece
SET piece.title = 'Santa Claus, Christmas Symphony', piece.title_en = 'Santa Claus, Christmas Symphony',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17021 AND piece.composer_id = 163
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Breaking Heart

UPDATE pieces piece
SET piece.title = 'The Breaking Heart', piece.title_en = 'The Breaking Heart',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19467 AND piece.composer_id = 163
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Adieu

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Adieu', 'Adieu', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 163
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Adieu'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47fd0661-9a5c-4088-a8c6-a9596148b539'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '47fd0661-9a5c-4088-a8c6-a9596148b539'
FROM pieces p
WHERE p.composer_id = 163 AND p.title = 'Adieu' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47fd0661-9a5c-4088-a8c6-a9596148b539'
);

-- 숨길 seed 작품 없음

-- ===== Pierre Wissmer (composer_id 166) =====
-- 작품을 MusicBrainz 작품 구조로 다시 짠다(6차 자동). 작품 8개(묶음 0, 다악장 8, 낱곡 0),
-- 새 작품 0개, part 31개, 그 아래 0개.
-- seed 8개 중 8개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.

-- None 2ème quatuor à cordes

UPDATE pieces piece
SET piece.title = '2ème quatuor à cordes', piece.title_en = '2ème quatuor à cordes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17437 AND piece.composer_id = 166
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = '2ème quatuor à cordes : I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17437 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:202d6041-f476-4083-b457-885056a0abc6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:202d6041-f476-4083-b457-885056a0abc6', 1, 'I', 'Allegro moderato', '2ème quatuor à cordes : I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17437 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:202d6041-f476-4083-b457-885056a0abc6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = '2ème quatuor à cordes : II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17437 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:ba21bbbd-50ab-4cf0-9940-c305d69e8934' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba21bbbd-50ab-4cf0-9940-c305d69e8934', 2, 'II', 'Andante', '2ème quatuor à cordes : II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17437 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba21bbbd-50ab-4cf0-9940-c305d69e8934'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = '2ème quatuor à cordes : III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17437 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:1d2c8dad-28d2-4a99-9591-be25e7e1b41e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d2c8dad-28d2-4a99-9591-be25e7e1b41e', 3, 'III', 'Allegro', '2ème quatuor à cordes : III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17437 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d2c8dad-28d2-4a99-9591-be25e7e1b41e'
);


-- None 연가곡집 <Chants de mars>

UPDATE pieces piece
SET piece.title = '연가곡집 <Chants de mars>', piece.title_en = 'Chants de mars',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16738 AND piece.composer_id = 166
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'C''est pas moi qui suis le Bon Dieu', part.name_en = 'Chants de mars: I. C''est pas moi qui suis le Bon Dieu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16738 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:42b06df9-f019-4ebe-ad67-e46015880755' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42b06df9-f019-4ebe-ad67-e46015880755', 1, 'I', 'C''est pas moi qui suis le Bon Dieu', 'Chants de mars: I. C''est pas moi qui suis le Bon Dieu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16738 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42b06df9-f019-4ebe-ad67-e46015880755'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Bête à Bon Dieu fais moi-t-un beau dimanche', part.name_en = 'Chants de mars: II. Bête à Bon Dieu fais moi-t-un beau dimanche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16738 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:89e0edb8-ce54-4386-a398-d76e86755cbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89e0edb8-ce54-4386-a398-d76e86755cbf', 2, 'II', 'Bête à Bon Dieu fais moi-t-un beau dimanche', 'Chants de mars: II. Bête à Bon Dieu fais moi-t-un beau dimanche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16738 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89e0edb8-ce54-4386-a398-d76e86755cbf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'A force ce n''est plus Maman', part.name_en = 'Chants de mars: III. A force ce n''est plus Maman',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16738 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:07899885-bf59-4177-871e-332cb866fb3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07899885-bf59-4177-871e-332cb866fb3a', 3, 'III', 'A force ce n''est plus Maman', 'Chants de mars: III. A force ce n''est plus Maman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16738 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07899885-bf59-4177-871e-332cb866fb3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Ça évite les accidents', part.name_en = 'Chants de mars: IV. Ça évite les accidents',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16738 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:d08327e5-d2e9-4bbb-a515-de42a2275925' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d08327e5-d2e9-4bbb-a515-de42a2275925', 4, 'IV', 'Ça évite les accidents', 'Chants de mars: IV. Ça évite les accidents', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16738 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d08327e5-d2e9-4bbb-a515-de42a2275925'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Comme les anges au paradis', part.name_en = 'Chants de mars: V. Comme les anges au paradis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16738 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:1d007629-8965-4d9a-acbb-18e0681acbbc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d007629-8965-4d9a-acbb-18e0681acbbc', 5, 'V', 'Comme les anges au paradis', 'Chants de mars: V. Comme les anges au paradis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16738 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d007629-8965-4d9a-acbb-18e0681acbbc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Mes avions de papier blanc', part.name_en = 'Chants de mars: VI. Mes avions de papier blanc',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16738 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:9d539db1-291b-4581-a414-55b73c5f4878' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d539db1-291b-4581-a414-55b73c5f4878', 6, 'VI', 'Mes avions de papier blanc', 'Chants de mars: VI. Mes avions de papier blanc', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16738 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d539db1-291b-4581-a414-55b73c5f4878'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Sur le pont d''Avignon', part.name_en = 'Chants de mars: VII. Sur le pont d''Avignon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16738 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:cf07512f-3b7d-4b59-913b-3365a102c5a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf07512f-3b7d-4b59-913b-3365a102c5a0', 7, 'VII', 'Sur le pont d''Avignon', 'Chants de mars: VII. Sur le pont d''Avignon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16738 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf07512f-3b7d-4b59-913b-3365a102c5a0'
);


-- None 협주곡 1번

UPDATE pieces piece
SET piece.title = '협주곡 1번', piece.title_en = 'Concerto no. 1 pour violon et orchestre',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17577 AND piece.composer_id = 166
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Concerto no. 1 pour violon et orchestre: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17577 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:4af5fa71-2f4f-49b8-8898-eaa00ba044d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4af5fa71-2f4f-49b8-8898-eaa00ba044d5', 1, 'I', 'Allegro', 'Concerto no. 1 pour violon et orchestre: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17577 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4af5fa71-2f4f-49b8-8898-eaa00ba044d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Fugue', part.name_en = 'Concerto no. 1 pour violon et orchestre: II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17577 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:bf89b26e-10ef-4b8a-8098-f52bc12b6473' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf89b26e-10ef-4b8a-8098-f52bc12b6473', 2, 'II', 'Fugue', 'Concerto no. 1 pour violon et orchestre: II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17577 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf89b26e-10ef-4b8a-8098-f52bc12b6473'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Finale. Vivace', part.name_en = 'Concerto no. 1 pour violon et orchestre: III. Finale. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17577 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:02bc57e1-56d7-42d3-a3d6-2d0b9a8ebec8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02bc57e1-56d7-42d3-a3d6-2d0b9a8ebec8', 3, 'III', 'Finale. Vivace', 'Concerto no. 1 pour violon et orchestre: III. Finale. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17577 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02bc57e1-56d7-42d3-a3d6-2d0b9a8ebec8'
);


-- None 협주곡 2번

UPDATE pieces piece
SET piece.title = '협주곡 2번', piece.title_en = 'Concerto no. 2 pour violon et orchestre',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16197 AND piece.composer_id = 166
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro risoluto', part.name_en = 'Concerto no. 2 pour violon et orchestre: I. Allegro risoluto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16197 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:bcb5c7f8-0d99-4826-bc17-2e039bb8ef10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcb5c7f8-0d99-4826-bc17-2e039bb8ef10', 1, 'I', 'Allegro risoluto', 'Concerto no. 2 pour violon et orchestre: I. Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16197 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcb5c7f8-0d99-4826-bc17-2e039bb8ef10'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Molto moderato', part.name_en = 'Concerto no. 2 pour violon et orchestre: II. Molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16197 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:4463f1f1-205d-4817-a6e8-ad29b3949a72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4463f1f1-205d-4817-a6e8-ad29b3949a72', 2, 'II', 'Molto moderato', 'Concerto no. 2 pour violon et orchestre: II. Molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16197 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4463f1f1-205d-4817-a6e8-ad29b3949a72'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro con spirito', part.name_en = 'Concerto no. 2 pour violon et orchestre: III. Allegro con spirito',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16197 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:62c5822e-83ce-4b14-9a85-5977c8f7cafa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62c5822e-83ce-4b14-9a85-5977c8f7cafa', 3, 'III', 'Allegro con spirito', 'Concerto no. 2 pour violon et orchestre: III. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16197 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62c5822e-83ce-4b14-9a85-5977c8f7cafa'
);


-- None 협주곡 3번

UPDATE pieces piece
SET piece.title = '협주곡 3번', piece.title_en = 'Concerto no. 3 pour violon et orchestre',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19744 AND piece.composer_id = 166
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '♩ = 108', part.name_en = 'Concerto no. 3 pour violon et orchestre: I. ♩ = 108',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19744 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:b67fc7f0-059a-477d-975a-4b77dd64cfad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b67fc7f0-059a-477d-975a-4b77dd64cfad', 1, 'I', '♩ = 108', 'Concerto no. 3 pour violon et orchestre: I. ♩ = 108', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19744 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b67fc7f0-059a-477d-975a-4b77dd64cfad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '♩ = 62', part.name_en = 'Concerto no. 3 pour violon et orchestre: II. ♩ = 62',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19744 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:723d8bde-8780-42ba-894b-a9a2ee26300d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:723d8bde-8780-42ba-894b-a9a2ee26300d', 2, 'II', '♩ = 62', 'Concerto no. 3 pour violon et orchestre: II. ♩ = 62', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19744 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:723d8bde-8780-42ba-894b-a9a2ee26300d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '♩ = 108', part.name_en = 'Concerto no. 3 pour violon et orchestre: III. ♩ = 108',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19744 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:721c6249-04d6-470e-9e76-00f8fa12985e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:721c6249-04d6-470e-9e76-00f8fa12985e', 3, 'III', '♩ = 108', 'Concerto no. 3 pour violon et orchestre: III. ♩ = 108', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19744 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:721c6249-04d6-470e-9e76-00f8fa12985e'
);


-- None Sinfonietta concertante pour flûte, harpe et orchestre

UPDATE pieces piece
SET piece.title = 'Sinfonietta concertante pour flûte, harpe et orchestre', piece.title_en = 'Sinfonietta concertante pour flûte, harpe et orchestre',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17689 AND piece.composer_id = 166
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'III',
    part.name_ko = 'Ballo', part.name_en = 'Sinfonietta concertante pour flûte, harpe et orchestre : III. Ballo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17689 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:305f6071-d8e5-44a4-8353-3bae71382e54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:305f6071-d8e5-44a4-8353-3bae71382e54', 1, 'III', 'Ballo', 'Sinfonietta concertante pour flûte, harpe et orchestre : III. Ballo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17689 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:305f6071-d8e5-44a4-8353-3bae71382e54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Romanza', part.name_en = 'Sinfonietta concertante pour flûte, harpe et orchestre : II. Romanza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17689 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:767a5bf8-bfc8-459f-9a3d-0f772b014835' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:767a5bf8-bfc8-459f-9a3d-0f772b014835', 2, 'II', 'Romanza', 'Sinfonietta concertante pour flûte, harpe et orchestre : II. Romanza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17689 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:767a5bf8-bfc8-459f-9a3d-0f772b014835'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'I',
    part.name_ko = 'Cadenza e Toccata', part.name_en = 'Sinfonietta concertante pour flûte, harpe et orchestre : I. Cadenza e Toccata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17689 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:84fd46aa-a48d-49b5-8843-a35fe6945b33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84fd46aa-a48d-49b5-8843-a35fe6945b33', 3, 'I', 'Cadenza e Toccata', 'Sinfonietta concertante pour flûte, harpe et orchestre : I. Cadenza e Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17689 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84fd46aa-a48d-49b5-8843-a35fe6945b33'
);


-- None 교향곡 5번

UPDATE pieces piece
SET piece.title = '교향곡 5번', piece.title_en = 'Symphonie no. 5',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19379 AND piece.composer_id = 166
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'III',
    part.name_ko = 'Andante malincolico', part.name_en = 'Symphonie no. 5 : III. Andante malincolico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19379 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:4b68723c-a19d-46c5-a736-3e08c1abe06b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b68723c-a19d-46c5-a736-3e08c1abe06b', 1, 'III', 'Andante malincolico', 'Symphonie no. 5 : III. Andante malincolico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19379 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b68723c-a19d-46c5-a736-3e08c1abe06b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'IV',
    part.name_ko = 'Finale', part.name_en = 'Symphonie no. 5 : IV. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19379 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:74234366-f352-43c7-921b-8ab8932cdd9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74234366-f352-43c7-921b-8ab8932cdd9f', 2, 'IV', 'Finale', 'Symphonie no. 5 : IV. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19379 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74234366-f352-43c7-921b-8ab8932cdd9f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'II',
    part.name_ko = 'Andante ‐ Allegro burlesco', part.name_en = 'Symphonie no. 5 : II. Andante ‐ Allegro burlesco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19379 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:ae6317b9-6d66-440c-bbe9-121c88ec8704' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae6317b9-6d66-440c-bbe9-121c88ec8704', 3, 'II', 'Andante ‐ Allegro burlesco', 'Symphonie no. 5 : II. Andante ‐ Allegro burlesco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19379 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae6317b9-6d66-440c-bbe9-121c88ec8704'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Symphonie no. 5 : I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19379 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:e1e76951-d610-400f-883a-080700d81d28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1e76951-d610-400f-883a-080700d81d28', 4, 'I', 'Allegro', 'Symphonie no. 5 : I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19379 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1e76951-d610-400f-883a-080700d81d28'
);


-- None 교향곡 6번

UPDATE pieces piece
SET piece.title = '교향곡 6번', piece.title_en = 'Symphonie no. 6',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17379 AND piece.composer_id = 166
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Préface et Sonate', part.name_en = 'Symphonie no. 6 : I. Préface et Sonate',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17379 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:068bcf2a-11b2-4c75-a738-c80fecc73deb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:068bcf2a-11b2-4c75-a738-c80fecc73deb', 1, 'I', 'Préface et Sonate', 'Symphonie no. 6 : I. Préface et Sonate', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17379 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:068bcf2a-11b2-4c75-a738-c80fecc73deb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'III',
    part.name_ko = 'Méditation', part.name_en = 'Symphonie no. 6 : III. Méditation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17379 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:13cc489d-9258-45a3-8243-dcb729506440' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13cc489d-9258-45a3-8243-dcb729506440', 2, 'III', 'Méditation', 'Symphonie no. 6 : III. Méditation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17379 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13cc489d-9258-45a3-8243-dcb729506440'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'IV',
    part.name_ko = 'Dédicace', part.name_en = 'Symphonie no. 6 : IV. Dédicace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17379 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:5c6449ad-583b-4124-be63-bba5a61e857c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c6449ad-583b-4124-be63-bba5a61e857c', 3, 'IV', 'Dédicace', 'Symphonie no. 6 : IV. Dédicace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17379 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c6449ad-583b-4124-be63-bba5a61e857c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'II',
    part.name_ko = 'Nocturne', part.name_en = 'Symphonie no. 6 : II. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17379 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:9959fac4-2839-4cd2-bcac-f895a143af33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9959fac4-2839-4cd2-bcac-f895a143af33', 4, 'II', 'Nocturne', 'Symphonie no. 6 : II. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17379 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9959fac4-2839-4cd2-bcac-f895a143af33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Épilogue', part.name_en = 'Symphonie no. 6 : V. Épilogue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17379 AND p.composer_id = 166 AND part.part_key = 'musicbrainz:9a50780b-19e5-4d69-93bf-e23724c015e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a50780b-19e5-4d69-93bf-e23724c015e1', 5, 'V', 'Épilogue', 'Symphonie no. 6 : V. Épilogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17379 AND p.composer_id = 166
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a50780b-19e5-4d69-93bf-e23724c015e1'
);

-- 숨길 seed 작품 없음
