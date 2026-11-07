-- Jonathan Dove 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 54개(묶음 6, 다악장 15, 낱곡 33),
-- 새 작품 5개, part 118개, 그 아래 0개.
-- seed 55개 중 49개를 작품·part 에 잇고, 3개를 숨기고, 3개는 그대로 둔다.
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

-- None A Song of Joys

UPDATE pieces piece
SET piece.title = 'A Song of Joys', piece.title_en = 'A Song of Joys',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16652 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None All You Who Sleep Tonight

UPDATE pieces piece
SET piece.title = 'All You Who Sleep Tonight', piece.title_en = 'All You Who Sleep Tonight',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18084 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Condition', part.name_en = 'All You Who Sleep Tonight: I. Condition',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18084 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:7c8882cf-937b-4e4f-b6a7-a0a0c54b6b20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c8882cf-937b-4e4f-b6a7-a0a0c54b6b20', 1, 'I', 'Condition', 'All You Who Sleep Tonight: I. Condition', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18084 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c8882cf-937b-4e4f-b6a7-a0a0c54b6b20'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Telephone', part.name_en = 'All You Who Sleep Tonight: II. Telephone',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18084 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:0778a10f-b14c-44d2-b516-8f17893bf71d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0778a10f-b14c-44d2-b516-8f17893bf71d', 2, 'II', 'Telephone', 'All You Who Sleep Tonight: II. Telephone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18084 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0778a10f-b14c-44d2-b516-8f17893bf71d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Across', part.name_en = 'All You Who Sleep Tonight: III. Across',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18084 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:f23d9b29-59c7-45fc-b944-19a5c7c9ddac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f23d9b29-59c7-45fc-b944-19a5c7c9ddac', 3, 'III', 'Across', 'All You Who Sleep Tonight: III. Across', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18084 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f23d9b29-59c7-45fc-b944-19a5c7c9ddac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Prandial Plaint', part.name_en = 'All You Who Sleep Tonight: IV. Prandial Plaint',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18084 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:72cb4eac-2921-4c51-98a8-96041afefc26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72cb4eac-2921-4c51-98a8-96041afefc26', 4, 'IV', 'Prandial Plaint', 'All You Who Sleep Tonight: IV. Prandial Plaint', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18084 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72cb4eac-2921-4c51-98a8-96041afefc26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Interpretation', part.name_en = 'All You Who Sleep Tonight: V. Interpretation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18084 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:508cf344-495d-4b44-9eef-9e771eef5c71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:508cf344-495d-4b44-9eef-9e771eef5c71', 5, 'V', 'Interpretation', 'All You Who Sleep Tonight: V. Interpretation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18084 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:508cf344-495d-4b44-9eef-9e771eef5c71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Mistaken', part.name_en = 'All You Who Sleep Tonight: VI. Mistaken',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18084 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:eab17d8a-0a1f-4f3e-9b27-da4fa0697b5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eab17d8a-0a1f-4f3e-9b27-da4fa0697b5b', 6, 'VI', 'Mistaken', 'All You Who Sleep Tonight: VI. Mistaken', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18084 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eab17d8a-0a1f-4f3e-9b27-da4fa0697b5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'God''s Love', part.name_en = 'All You Who Sleep Tonight: VII. God''s Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18084 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:07d4e18c-7848-4df0-a4d9-3d4d320e8f4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07d4e18c-7848-4df0-a4d9-3d4d320e8f4b', 7, 'VII', 'God''s Love', 'All You Who Sleep Tonight: VII. God''s Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18084 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07d4e18c-7848-4df0-a4d9-3d4d320e8f4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Dark Road', part.name_en = 'All You Who Sleep Tonight: VIII. Dark Road',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18084 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:a4c2c988-9e49-4c0a-9c65-16a092a8b321' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4c2c988-9e49-4c0a-9c65-16a092a8b321', 8, 'VIII', 'Dark Road', 'All You Who Sleep Tonight: VIII. Dark Road', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18084 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4c2c988-9e49-4c0a-9c65-16a092a8b321'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Door', part.name_en = 'All You Who Sleep Tonight: IX. Door',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18084 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:518330fc-30ef-429a-a7b5-8c5cf0d8c2b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:518330fc-30ef-429a-a7b5-8c5cf0d8c2b8', 9, 'IX', 'Door', 'All You Who Sleep Tonight: IX. Door', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18084 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:518330fc-30ef-429a-a7b5-8c5cf0d8c2b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Night Watch', part.name_en = 'All You Who Sleep Tonight: X. Night Watch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18084 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:3dfab1d4-020c-43d7-be3a-06122ecd19da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3dfab1d4-020c-43d7-be3a-06122ecd19da', 10, 'X', 'Night Watch', 'All You Who Sleep Tonight: X. Night Watch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18084 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dfab1d4-020c-43d7-be3a-06122ecd19da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Voices', part.name_en = 'All You Who Sleep Tonight: XI. Voices',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18084 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:b0640c26-ff69-4d19-b0f3-04e6012fcba0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0640c26-ff69-4d19-b0f3-04e6012fcba0', 11, 'XI', 'Voices', 'All You Who Sleep Tonight: XI. Voices', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18084 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0640c26-ff69-4d19-b0f3-04e6012fcba0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Soon', part.name_en = 'All You Who Sleep Tonight: XII. Soon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18084 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:59e495dd-08fa-459d-9137-50709645bbca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59e495dd-08fa-459d-9137-50709645bbca', 12, 'XII', 'Soon', 'All You Who Sleep Tonight: XII. Soon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18084 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59e495dd-08fa-459d-9137-50709645bbca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'XIII',
    part.name_ko = 'All You Who Sleep Tonight', part.name_en = 'All You Who Sleep Tonight: XIII. All You Who Sleep Tonight',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18084 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:11ff7dc0-5f02-49b0-9b2f-825452fd2ce9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11ff7dc0-5f02-49b0-9b2f-825452fd2ce9', 13, 'XIII', 'All You Who Sleep Tonight', 'All You Who Sleep Tonight: XIII. All You Who Sleep Tonight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18084 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11ff7dc0-5f02-49b0-9b2f-825452fd2ce9'
);


-- None All the Future Days

UPDATE pieces piece
SET piece.title = 'All the Future Days', piece.title_en = 'All the Future Days',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20025 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Time Being', part.name_en = 'All the Future Days: I. Time Being',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20025 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:d701f3a9-a213-4a7b-b875-eced5f1ceacf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d701f3a9-a213-4a7b-b875-eced5f1ceacf', 1, 'I', 'Time Being', 'All the Future Days: I. Time Being', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20025 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d701f3a9-a213-4a7b-b875-eced5f1ceacf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Autobiography', part.name_en = 'All the Future Days: II. Autobiography',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20025 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:3e935e57-807f-442a-890e-d47dcfab549f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e935e57-807f-442a-890e-d47dcfab549f', 2, 'II', 'Autobiography', 'All the Future Days: II. Autobiography', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20025 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e935e57-807f-442a-890e-d47dcfab549f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Penelope', part.name_en = 'All the Future Days: III. Penelope',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20025 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:495f47da-125f-40a6-90cb-514e4eb8a78b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:495f47da-125f-40a6-90cb-514e4eb8a78b', 3, 'III', 'Penelope', 'All the Future Days: III. Penelope', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20025 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:495f47da-125f-40a6-90cb-514e4eb8a78b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Spider', part.name_en = 'All the Future Days: IV. Spider',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20025 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:90d0b427-7250-4496-be5a-7d267b5ddf4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90d0b427-7250-4496-be5a-7d267b5ddf4c', 4, 'IV', 'Spider', 'All the Future Days: IV. Spider', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20025 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90d0b427-7250-4496-be5a-7d267b5ddf4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Martha', part.name_en = 'All the Future Days: V. Martha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20025 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:2fa26e40-2ce5-4c87-956d-00be3779b7a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fa26e40-2ce5-4c87-956d-00be3779b7a5', 5, 'V', 'Martha', 'All the Future Days: V. Martha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20025 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fa26e40-2ce5-4c87-956d-00be3779b7a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'The Siren', part.name_en = 'All the Future Days: VI. The Siren',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20025 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:73361466-465a-488e-883f-4aa371e6b665' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73361466-465a-488e-883f-4aa371e6b665', 6, 'VI', 'The Siren', 'All the Future Days: VI. The Siren', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20025 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73361466-465a-488e-883f-4aa371e6b665'
);


-- None Between Friends

UPDATE pieces piece
SET piece.title = 'Between Friends', piece.title_en = 'Between Friends',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20052 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Conversation 1: Gently moving - Gradually moving forward - Energetic', part.name_en = 'Between Friends: Conversation 1: Gently moving - Gradually moving forward - Energetic',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20052 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:20912676-2997-4fb7-b115-1d6a23ef596d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20912676-2997-4fb7-b115-1d6a23ef596d', 1, NULL, 'Conversation 1: Gently moving - Gradually moving forward - Energetic', 'Between Friends: Conversation 1: Gently moving - Gradually moving forward - Energetic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20052 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20912676-2997-4fb7-b115-1d6a23ef596d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Conversation 2: Dancing', part.name_en = 'Between Friends: Conversation 2: Dancing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20052 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:8ebd095c-1bbd-4ba4-b1e5-882ee392fcf6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ebd095c-1bbd-4ba4-b1e5-882ee392fcf6', 2, NULL, 'Conversation 2: Dancing', 'Between Friends: Conversation 2: Dancing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20052 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ebd095c-1bbd-4ba4-b1e5-882ee392fcf6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Conversation 3: Spacious', part.name_en = 'Between Friends: Conversation 3: Spacious',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20052 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:2cf177f4-1c26-4ad9-ad32-19ee077ddbfd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2cf177f4-1c26-4ad9-ad32-19ee077ddbfd', 3, NULL, 'Conversation 3: Spacious', 'Between Friends: Conversation 3: Spacious', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20052 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cf177f4-1c26-4ad9-ad32-19ee077ddbfd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Conversation 4: Lively and playful, with mischief', part.name_en = 'Between Friends: Conversation 4: Lively and playful, with mischief',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20052 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:308ed162-0666-47df-8a29-9bda1ae007d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:308ed162-0666-47df-8a29-9bda1ae007d1', 4, NULL, 'Conversation 4: Lively and playful, with mischief', 'Between Friends: Conversation 4: Lively and playful, with mischief', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20052 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:308ed162-0666-47df-8a29-9bda1ae007d1'
);


-- None 가곡 <Bless the Lord, O my soul>

UPDATE pieces piece
SET piece.title = '가곡 <Bless the Lord, O my soul>', piece.title_en = 'Bless the Lord, O my soul',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17460 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 부수음악 <Breadline>

UPDATE pieces piece
SET piece.title = '부수음악 <Breadline>', piece.title_en = 'Breadline',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18460 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 코랄 전주곡 "Christ unser Herr zum Jordan kam"

UPDATE pieces piece
SET piece.title = '코랄 전주곡 "Christ unser Herr zum Jordan kam"', piece.title_en = 'Chorale Prelude "Christ unser Herr zum Jordan kam"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19961 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Christ unser Herr zum Jordan kam

UPDATE pieces piece
SET piece.title = 'Christ unser Herr zum Jordan kam', piece.title_en = 'Christ unser Herr zum Jordan kam',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19808 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cut My Shadow

UPDATE pieces piece
SET piece.title = 'Cut My Shadow', piece.title_en = 'Cut My Shadow',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19308 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Surprise', part.name_en = 'Cut My Shadow: I. Surprise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19308 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:ed40b414-3ba8-4754-a167-d71fa3bb3429' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed40b414-3ba8-4754-a167-d71fa3bb3429', 1, 'I', 'Surprise', 'Cut My Shadow: I. Surprise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19308 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed40b414-3ba8-4754-a167-d71fa3bb3429'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Guitar', part.name_en = 'Cut My Shadow: II. The Guitar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19308 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:50b6df7e-3643-4439-8f6b-2ab425a066ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50b6df7e-3643-4439-8f6b-2ab425a066ba', 2, 'II', 'The Guitar', 'Cut My Shadow: II. The Guitar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19308 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50b6df7e-3643-4439-8f6b-2ab425a066ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Song of the Dry Orange Tree', part.name_en = 'Cut My Shadow: III. Song of the Dry Orange Tree',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19308 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:9637105f-863d-456a-9212-1cb578908a3b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9637105f-863d-456a-9212-1cb578908a3b', 3, 'III', 'Song of the Dry Orange Tree', 'Cut My Shadow: III. Song of the Dry Orange Tree', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19308 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9637105f-863d-456a-9212-1cb578908a3b'
);


-- None 가곡 <Ecce beatam lucem>

UPDATE pieces piece
SET piece.title = '가곡 <Ecce beatam lucem>', piece.title_en = 'Ecce beatam lucem',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19002 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Five Am'rous Sighs

UPDATE pieces piece
SET piece.title = 'Five Am''rous Sighs', piece.title_en = 'Five Am''rous Sighs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19949 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Between Your Sheets', part.name_en = 'Five Am''rous Sighs: I. Between Your Sheets',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19949 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:b2075478-4de6-4783-9a57-fd8ef1399e86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2075478-4de6-4783-9a57-fd8ef1399e86', 1, 'I', 'Between Your Sheets', 'Five Am''rous Sighs: I. Between Your Sheets', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19949 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2075478-4de6-4783-9a57-fd8ef1399e86'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Finish', part.name_en = 'Five Am''rous Sighs: II. Finish',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19949 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:399409b8-76c4-44c3-bf46-a5659017e4cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:399409b8-76c4-44c3-bf46-a5659017e4cf', 2, 'II', 'Finish', 'Five Am''rous Sighs: II. Finish', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19949 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:399409b8-76c4-44c3-bf46-a5659017e4cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'My Heart Still Hovering', part.name_en = 'Five Am''rous Sighs: III. My Heart Still Hovering',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19949 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:1c41fdf7-55c4-488b-b474-3d5770644682' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c41fdf7-55c4-488b-b474-3d5770644682', 3, 'III', 'My Heart Still Hovering', 'Five Am''rous Sighs: III. My Heart Still Hovering', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19949 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c41fdf7-55c4-488b-b474-3d5770644682'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'All These Dismal Looks', part.name_en = 'Five Am''rous Sighs: IV. All These Dismal Looks',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19949 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:a77a6435-4b94-4c86-ab8f-f9f7c6032e02' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a77a6435-4b94-4c86-ab8f-f9f7c6032e02', 4, 'IV', 'All These Dismal Looks', 'Five Am''rous Sighs: IV. All These Dismal Looks', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19949 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a77a6435-4b94-4c86-ab8f-f9f7c6032e02'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Venus', part.name_en = 'Five Am''rous Sighs: V. Venus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19949 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:b198535b-20fc-42d9-bd03-cb447ca435a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b198535b-20fc-42d9-bd03-cb447ca435a8', 5, 'V', 'Venus', 'Five Am''rous Sighs: V. Venus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19949 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b198535b-20fc-42d9-bd03-cb447ca435a8'
);


-- None 오페라 <Flight>

UPDATE pieces piece
SET piece.title = '오페라 <Flight>', piece.title_en = 'Flight',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16146 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gaia Theory

UPDATE pieces piece
SET piece.title = 'Gaia Theory', piece.title_en = 'Gaia Theory',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18887 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lively', part.name_en = 'Gaia Theory: I. Lively',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18887 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:15f9c248-b6f1-4524-9e35-3353ad0330c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15f9c248-b6f1-4524-9e35-3353ad0330c3', 1, 'I', 'Lively', 'Gaia Theory: I. Lively', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18887 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15f9c248-b6f1-4524-9e35-3353ad0330c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'III',
    part.name_ko = 'Dancing', part.name_en = 'Gaia Theory: III. Dancing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18887 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:2e0dd216-4e44-4e93-9363-adb4608a4dee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e0dd216-4e44-4e93-9363-adb4608a4dee', 2, 'III', 'Dancing', 'Gaia Theory: III. Dancing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18887 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e0dd216-4e44-4e93-9363-adb4608a4dee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'II',
    part.name_ko = 'Very Spacious', part.name_en = 'Gaia Theory: II. Very Spacious',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18887 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:93efe02c-6a68-4eb0-b57b-32389ba5999b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93efe02c-6a68-4eb0-b57b-32389ba5999b', 3, 'II', 'Very Spacious', 'Gaia Theory: II. Very Spacious', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18887 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93efe02c-6a68-4eb0-b57b-32389ba5999b'
);


-- None Hojoki (An Account of My Hut)

UPDATE pieces piece
SET piece.title = 'Hojoki (An Account of My Hut)', piece.title_en = 'Hojoki (An Account of My Hut)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17105 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None I Am the Day

UPDATE pieces piece
SET piece.title = 'I Am the Day', piece.title_en = 'I Am the Day',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16580 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In Beauty May I Walk

UPDATE pieces piece
SET piece.title = 'In Beauty May I Walk', piece.title_en = 'In Beauty May I Walk',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19496 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <In Damascus>

UPDATE pieces piece
SET piece.title = '연가곡집 <In Damascus>', piece.title_en = 'In Damascus',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16067 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'A little while ago', part.name_en = 'In Damascus: I. A little while ago',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16067 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:08740fbc-2430-40d5-81be-5e8afd38a2f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08740fbc-2430-40d5-81be-5e8afd38a2f0', 1, 'I', 'A little while ago', 'In Damascus: I. A little while ago', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16067 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08740fbc-2430-40d5-81be-5e8afd38a2f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'And what if you weep alone', part.name_en = 'In Damascus: II. And what if you weep alone',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16067 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:89cbf28a-393d-4dd9-9c14-e7d0e35b28e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89cbf28a-393d-4dd9-9c14-e7d0e35b28e5', 2, 'II', 'And what if you weep alone', 'In Damascus: II. And what if you weep alone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16067 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89cbf28a-393d-4dd9-9c14-e7d0e35b28e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Two days agro', part.name_en = 'In Damascus: III. Two days agro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16067 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:ae9e66ee-ea17-46f4-8714-b6d82ed28557' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae9e66ee-ea17-46f4-8714-b6d82ed28557', 3, 'III', 'Two days agro', 'In Damascus: III. Two days agro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16067 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae9e66ee-ea17-46f4-8714-b6d82ed28557'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Here and now in Damascus', part.name_en = 'In Damascus: IV. Here and now in Damascus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16067 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:0fbbbd90-46dc-470b-b944-75d7a0453abb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fbbbd90-46dc-470b-b944-75d7a0453abb', 4, 'IV', 'Here and now in Damascus', 'In Damascus: IV. Here and now in Damascus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16067 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fbbbd90-46dc-470b-b944-75d7a0453abb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'The many faces of Damascus', part.name_en = 'In Damascus: V. The many faces of Damascus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16067 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:40455d44-9775-4f4c-a1b0-f25166891474' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40455d44-9775-4f4c-a1b0-f25166891474', 5, 'V', 'The many faces of Damascus', 'In Damascus: V. The many faces of Damascus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16067 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40455d44-9775-4f4c-a1b0-f25166891474'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Instrumental', part.name_en = 'In Damascus: VI. Instrumental',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16067 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:d66caf40-273b-4df6-9f9a-0fa0f1705c6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d66caf40-273b-4df6-9f9a-0fa0f1705c6d', 6, 'VI', 'Instrumental', 'In Damascus: VI. Instrumental', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16067 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d66caf40-273b-4df6-9f9a-0fa0f1705c6d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Soon, we will be free', part.name_en = 'In Damascus: VII. Soon, we will be free',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16067 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:0741660c-4f1e-4e25-88f6-89ee3c58aa11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0741660c-4f1e-4e25-88f6-89ee3c58aa11', 7, 'VII', 'Soon, we will be free', 'In Damascus: VII. Soon, we will be free', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16067 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0741660c-4f1e-4e25-88f6-89ee3c58aa11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'I don''t think any nations', part.name_en = 'In Damascus: VIII. I don''t think any nations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16067 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:296eaf27-4080-4327-b569-46829081db12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:296eaf27-4080-4327-b569-46829081db12', 8, 'VIII', 'I don''t think any nations', 'In Damascus: VIII. I don''t think any nations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16067 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:296eaf27-4080-4327-b569-46829081db12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'On all my travels, I''d take a book', part.name_en = 'In Damascus: IX. On all my travels, I''d take a book',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16067 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:9d497cb1-4dab-45cb-b36d-2c38ba400a84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d497cb1-4dab-45cb-b36d-2c38ba400a84', 9, 'IX', 'On all my travels, I''d take a book', 'In Damascus: IX. On all my travels, I''d take a book', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16067 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d497cb1-4dab-45cb-b36d-2c38ba400a84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'My heart is a black lump of coal', part.name_en = 'In Damascus: X. My heart is a black lump of coal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16067 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:a5f23acd-a080-4490-b276-c0a467a1cf81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5f23acd-a080-4490-b276-c0a467a1cf81', 10, 'X', 'My heart is a black lump of coal', 'In Damascus: X. My heart is a black lump of coal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16067 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5f23acd-a080-4490-b276-c0a467a1cf81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'My country', part.name_en = 'In Damascus: XI. My country',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16067 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:5464eed1-2e7e-4d30-a82f-02d995b41227' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5464eed1-2e7e-4d30-a82f-02d995b41227', 11, 'XI', 'My country', 'In Damascus: XI. My country', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16067 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5464eed1-2e7e-4d30-a82f-02d995b41227'
);


-- None Into Thy Hands

UPDATE pieces piece
SET piece.title = 'Into Thy Hands', piece.title_en = 'Into Thy Hands',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19683 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Köthener Messe

UPDATE pieces piece
SET piece.title = 'Köthener Messe', piece.title_en = 'Köthener Messe',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18215 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Kyrie', part.name_en = 'Köthener Messe: I. Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18215 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:2741d7de-58ec-415c-b4c2-8d58c4ffc0e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2741d7de-58ec-415c-b4c2-8d58c4ffc0e9', 1, 'I', 'Kyrie', 'Köthener Messe: I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18215 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2741d7de-58ec-415c-b4c2-8d58c4ffc0e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Gloria', part.name_en = 'Köthener Messe: II. Gloria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18215 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:63fbb598-87dc-4499-8f36-ea15ca3d498a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63fbb598-87dc-4499-8f36-ea15ca3d498a', 2, 'II', 'Gloria', 'Köthener Messe: II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18215 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63fbb598-87dc-4499-8f36-ea15ca3d498a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sanctus', part.name_en = 'Köthener Messe: III. Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18215 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:55e4a9be-bc2a-4482-bc8c-4d431d61b3e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55e4a9be-bc2a-4482-bc8c-4d431d61b3e8', 3, 'III', 'Sanctus', 'Köthener Messe: III. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18215 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55e4a9be-bc2a-4482-bc8c-4d431d61b3e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Agnus Dei', part.name_en = 'Köthener Messe: IV. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18215 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:6130eb18-5cd9-4646-b53f-b8bb4ab75cb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6130eb18-5cd9-4646-b53f-b8bb4ab75cb0', 4, 'IV', 'Agnus Dei', 'Köthener Messe: IV. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18215 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6130eb18-5cd9-4646-b53f-b8bb4ab75cb0'
);


-- None 연가곡집 <Letters from Claude>

UPDATE pieces piece
SET piece.title = '연가곡집 <Letters from Claude>', piece.title_en = 'Letters from Claude',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19582 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'VII', part.name_en = 'Letters from Claude: VII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19582 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:03574303-672b-4210-acef-05b9e15f4784' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03574303-672b-4210-acef-05b9e15f4784', 1, NULL, 'VII', 'Letters from Claude: VII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19582 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03574303-672b-4210-acef-05b9e15f4784'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Letters from Claude: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19582 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:244aa46f-9e84-46c7-8437-a70ca8e53c53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:244aa46f-9e84-46c7-8437-a70ca8e53c53', 2, NULL, 'II', 'Letters from Claude: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19582 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:244aa46f-9e84-46c7-8437-a70ca8e53c53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'V', part.name_en = 'Letters from Claude: V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19582 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:67d5a404-0424-462a-8ff5-2f0cf32ce7e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67d5a404-0424-462a-8ff5-2f0cf32ce7e5', 3, NULL, 'V', 'Letters from Claude: V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19582 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67d5a404-0424-462a-8ff5-2f0cf32ce7e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Letters from Claude: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19582 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:a6582dd6-23df-4fe9-bbb3-aa0d8ddfe490' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6582dd6-23df-4fe9-bbb3-aa0d8ddfe490', 4, NULL, 'I', 'Letters from Claude: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19582 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6582dd6-23df-4fe9-bbb3-aa0d8ddfe490'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'VI', part.name_en = 'Letters from Claude: VI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19582 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:bdc675e9-2b00-4d7d-8985-7f18baf38f9e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdc675e9-2b00-4d7d-8985-7f18baf38f9e', 5, NULL, 'VI', 'Letters from Claude: VI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19582 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdc675e9-2b00-4d7d-8985-7f18baf38f9e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Letters from Claude: IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19582 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:da1e343f-1243-4153-9014-3b9fdd3232dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da1e343f-1243-4153-9014-3b9fdd3232dd', 6, NULL, 'IV', 'Letters from Claude: IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19582 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da1e343f-1243-4153-9014-3b9fdd3232dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Letters from Claude: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19582 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:de4a39f2-ad4e-4cdc-9aa9-d8dfb6bb31b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de4a39f2-ad4e-4cdc-9aa9-d8dfb6bb31b0', 7, NULL, 'III', 'Letters from Claude: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19582 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de4a39f2-ad4e-4cdc-9aa9-d8dfb6bb31b0'
);


-- None Ludwig Games

UPDATE pieces piece
SET piece.title = 'Ludwig Games', piece.title_en = 'Ludwig Games',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16071 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None My Love Is Mine

UPDATE pieces piece
SET piece.title = 'My Love Is Mine', piece.title_en = 'My Love Is Mine',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19080 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Nights Not Spent Alone

UPDATE pieces piece
SET piece.title = 'Nights Not Spent Alone', piece.title_en = 'Nights Not Spent Alone',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17765 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'III',
    part.name_ko = 'I Too Beneath Your Moon', part.name_en = 'Nights Not Spent Alone: III. I Too Beneath Your Moon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17765 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:5f93d7bf-7a36-45f1-87ed-6b2203bd8b85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f93d7bf-7a36-45f1-87ed-6b2203bd8b85', 1, 'III', 'I Too Beneath Your Moon', 'Nights Not Spent Alone: III. I Too Beneath Your Moon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17765 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f93d7bf-7a36-45f1-87ed-6b2203bd8b85'
);


-- None Northern Lights

UPDATE pieces piece
SET piece.title = 'Northern Lights', piece.title_en = 'Northern Lights',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19754 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Very Spacious', part.name_en = 'Northern Lights: I. Very Spacious',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19754 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:0ec7d802-8b19-4424-b37b-8e71277c572c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ec7d802-8b19-4424-b37b-8e71277c572c', 1, 'I', 'Very Spacious', 'Northern Lights: I. Very Spacious', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19754 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ec7d802-8b19-4424-b37b-8e71277c572c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Very Spacious', part.name_en = 'Northern Lights: II. Very Spacious',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19754 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:97ac82b8-d8de-4a01-bf4d-c28e1487838e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97ac82b8-d8de-4a01-bf4d-c28e1487838e', 2, 'II', 'Very Spacious', 'Northern Lights: II. Very Spacious', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19754 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97ac82b8-d8de-4a01-bf4d-c28e1487838e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Musing', part.name_en = 'Northern Lights: III. Musing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19754 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:ec7e1e11-7985-495b-874f-c5d9b2ea10ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec7e1e11-7985-495b-874f-c5d9b2ea10ed', 3, 'III', 'Musing', 'Northern Lights: III. Musing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19754 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec7e1e11-7985-495b-874f-c5d9b2ea10ed'
);


-- None On the streets and in the sky

UPDATE pieces piece
SET piece.title = 'On the streets and in the sky', piece.title_en = 'On the streets and in the sky',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18314 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Driving', part.name_en = 'On the streets and in the sky: I. Driving',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18314 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:7f51ebc2-8c2b-4952-911a-5260aecebf30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f51ebc2-8c2b-4952-911a-5260aecebf30', 1, 'I', 'Driving', 'On the streets and in the sky: I. Driving', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18314 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f51ebc2-8c2b-4952-911a-5260aecebf30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lively', part.name_en = 'On the streets and in the sky: II. Lively',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18314 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:9fbdc51a-708f-479f-92d4-c9a746dda396' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fbdc51a-708f-479f-92d4-c9a746dda396', 2, 'II', 'Lively', 'On the streets and in the sky: II. Lively', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18314 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fbdc51a-708f-479f-92d4-c9a746dda396'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Very Gently Moving', part.name_en = 'On the streets and in the sky: III. Very Gently Moving',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18314 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:8e70acab-cd64-4976-bf11-9b35b4d0e763' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e70acab-cd64-4976-bf11-9b35b4d0e763', 3, 'III', 'Very Gently Moving', 'On the streets and in the sky: III. Very Gently Moving', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18314 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e70acab-cd64-4976-bf11-9b35b4d0e763'
);


-- None Our revels now are ended

UPDATE pieces piece
SET piece.title = 'Our revels now are ended', piece.title_en = 'Our revels now are ended',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17089 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Out of Time

UPDATE pieces piece
SET piece.title = 'Out of Time', piece.title_en = 'Out of Time',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18940 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Quite fast', part.name_en = 'Out of Time: I. Quite fast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18940 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:d71fd43d-06a0-422d-9f85-ee7e5a11d06a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d71fd43d-06a0-422d-9f85-ee7e5a11d06a', 1, 'I', 'Quite fast', 'Out of Time: I. Quite fast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18940 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d71fd43d-06a0-422d-9f85-ee7e5a11d06a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Slow', part.name_en = 'Out of Time: II. Slow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18940 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:091b1eda-c29e-4809-901f-ecf41eb6a098' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:091b1eda-c29e-4809-901f-ecf41eb6a098', 2, 'II', 'Slow', 'Out of Time: II. Slow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18940 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:091b1eda-c29e-4809-901f-ecf41eb6a098'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Stomping', part.name_en = 'Out of Time: III. Stomping',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18940 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:16dc2c10-f7c3-4965-8991-649572f76eeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16dc2c10-f7c3-4965-8991-649572f76eeb', 3, 'III', 'Stomping', 'Out of Time: III. Stomping', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18940 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16dc2c10-f7c3-4965-8991-649572f76eeb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lively', part.name_en = 'Out of Time: IV. Lively',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18940 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:e8feb85d-d1f7-401a-8c9b-0998714a7a2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8feb85d-d1f7-401a-8c9b-0998714a7a2d', 4, 'IV', 'Lively', 'Out of Time: IV. Lively', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18940 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8feb85d-d1f7-401a-8c9b-0998714a7a2d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Fast', part.name_en = 'Out of Time: V. Fast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18940 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:f7ba5573-fef9-44c9-87f3-d33357d87b93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7ba5573-fef9-44c9-87f3-d33357d87b93', 5, 'V', 'Fast', 'Out of Time: V. Fast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18940 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7ba5573-fef9-44c9-87f3-d33357d87b93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Gently moving', part.name_en = 'Out of Time: VI. Gently moving',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18940 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:02ffde70-0136-42d7-9552-01531f9d11fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02ffde70-0136-42d7-9552-01531f9d11fa', 6, 'VI', 'Gently moving', 'Out of Time: VI. Gently moving', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18940 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02ffde70-0136-42d7-9552-01531f9d11fa'
);


-- None Run to the Edge

UPDATE pieces piece
SET piece.title = 'Run to the Edge', piece.title_en = 'Run to the Edge',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18929 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Run, shepherds, run!>

UPDATE pieces piece
SET piece.title = '가곡 <Run, shepherds, run!>', piece.title_en = 'Run, shepherds, run!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16567 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Seek Him That Maketh the Seven Stars

UPDATE pieces piece
SET piece.title = 'Seek Him That Maketh the Seven Stars', piece.title_en = 'Seek Him That Maketh the Seven Stars',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19163 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None St. John's Service

UPDATE pieces piece
SET piece.title = 'St. John''s Service', piece.title_en = 'St. John''s Service',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18697 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Magnificat', part.name_en = 'St. John''s Service: Magnificat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18697 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:510037c0-49ad-4ee6-9f56-679082357817' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:510037c0-49ad-4ee6-9f56-679082357817', 1, NULL, 'Magnificat', 'St. John''s Service: Magnificat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18697 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:510037c0-49ad-4ee6-9f56-679082357817'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Nunc Dimittis', part.name_en = 'St. John''s Service: Nunc Dimittis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18697 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:4bebf21e-79e2-4c83-ac0e-02a1175d685e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4bebf21e-79e2-4c83-ac0e-02a1175d685e', 2, NULL, 'Nunc Dimittis', 'St. John''s Service: Nunc Dimittis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18697 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bebf21e-79e2-4c83-ac0e-02a1175d685e'
);


-- None Stargazer

UPDATE pieces piece
SET piece.title = 'Stargazer', piece.title_en = 'Stargazer',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20011 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Searching the Night Sky', part.name_en = 'Stargazer: I. Searching the Night Sky',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20011 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:0984ca65-3a33-4313-a4d1-e1337eed69cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0984ca65-3a33-4313-a4d1-e1337eed69cf', 1, 'I', 'Searching the Night Sky', 'Stargazer: I. Searching the Night Sky', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20011 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0984ca65-3a33-4313-a4d1-e1337eed69cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Constellations', part.name_en = 'Stargazer: II. Constellations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20011 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:1abc77a2-f6aa-494f-b477-ddaa38aaea8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1abc77a2-f6aa-494f-b477-ddaa38aaea8d', 2, 'II', 'Constellations', 'Stargazer: II. Constellations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20011 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1abc77a2-f6aa-494f-b477-ddaa38aaea8d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Arcturus and Canis Chasing Ursa Major and Minor with Lyra', part.name_en = 'Stargazer: III. Arcturus and Canis Chasing Ursa Major and Minor with Lyra',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20011 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:f551b050-c7b8-40ef-ab41-4ee1a6f480cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f551b050-c7b8-40ef-ab41-4ee1a6f480cf', 3, 'III', 'Arcturus and Canis Chasing Ursa Major and Minor with Lyra', 'Stargazer: III. Arcturus and Canis Chasing Ursa Major and Minor with Lyra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20011 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f551b050-c7b8-40ef-ab41-4ee1a6f480cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Gemini', part.name_en = 'Stargazer: IV. Gemini',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20011 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:4836c228-579b-407a-9ff6-ad03075423b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4836c228-579b-407a-9ff6-ad03075423b7', 4, 'IV', 'Gemini', 'Stargazer: IV. Gemini', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20011 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4836c228-579b-407a-9ff6-ad03075423b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Orion, Pegasus', part.name_en = 'Stargazer: V. Orion, Pegasus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20011 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:60efc84f-d706-4fc3-ac2c-0778f1dafc44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60efc84f-d706-4fc3-ac2c-0778f1dafc44', 5, 'V', 'Orion, Pegasus', 'Stargazer: V. Orion, Pegasus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20011 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60efc84f-d706-4fc3-ac2c-0778f1dafc44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'The Milky Way', part.name_en = 'Stargazer: VI. The Milky Way',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20011 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:b68290a7-eecf-46f4-be1f-8c5f7915eadc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b68290a7-eecf-46f4-be1f-8c5f7915eadc', 6, 'VI', 'The Milky Way', 'Stargazer: VI. The Milky Way', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20011 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b68290a7-eecf-46f4-be1f-8c5f7915eadc'
);


-- None The Dancing Pipes

UPDATE pieces piece
SET piece.title = 'The Dancing Pipes', piece.title_en = 'The Dancing Pipes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19345 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Magic Flute Dances

UPDATE pieces piece
SET piece.title = 'The Magic Flute Dances', piece.title_en = 'The Magic Flute Dances',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15806 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <The Passing of the Year>

UPDATE pieces piece
SET piece.title = '연가곡집 <The Passing of the Year>', piece.title_en = 'The Passing of the Year',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17252 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Invocation', part.name_en = 'The Passing of the Year: No. 1. Invocation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17252 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:351e2aa0-ddda-4d1c-be9e-4d8761ae97f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:351e2aa0-ddda-4d1c-be9e-4d8761ae97f3', 1, NULL, 'Invocation', 'The Passing of the Year: No. 1. Invocation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17252 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:351e2aa0-ddda-4d1c-be9e-4d8761ae97f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Narrow Bud Opens Her Beauties to the Sun', part.name_en = 'The Passing of the Year: No. 2. The Narrow Bud Opens Her Beauties to the Sun',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17252 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:c8ad51f4-d314-48cf-8a8c-41a60dc74169' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8ad51f4-d314-48cf-8a8c-41a60dc74169', 2, NULL, 'The Narrow Bud Opens Her Beauties to the Sun', 'The Passing of the Year: No. 2. The Narrow Bud Opens Her Beauties to the Sun', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17252 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8ad51f4-d314-48cf-8a8c-41a60dc74169'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Answer July', part.name_en = 'The Passing of the Year: No. 3. Answer July',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17252 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:6f219e62-35f2-41bf-9b58-3ca8267fc6b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f219e62-35f2-41bf-9b58-3ca8267fc6b0', 3, NULL, 'Answer July', 'The Passing of the Year: No. 3. Answer July', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17252 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f219e62-35f2-41bf-9b58-3ca8267fc6b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Hot Sun, Cool Fire', part.name_en = 'The Passing of the Year: No. 4. Hot Sun, Cool Fire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17252 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:98543ff4-2fa3-4fbc-ad86-5c0800d4bd2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98543ff4-2fa3-4fbc-ad86-5c0800d4bd2a', 4, NULL, 'Hot Sun, Cool Fire', 'The Passing of the Year: No. 4. Hot Sun, Cool Fire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17252 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98543ff4-2fa3-4fbc-ad86-5c0800d4bd2a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Ah, Sun - Flower!', part.name_en = 'The Passing of the Year: No. 5. Ah, Sun - Flower!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17252 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:b45fdfcb-3eec-4dc0-93f8-83ab20f416c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b45fdfcb-3eec-4dc0-93f8-83ab20f416c9', 5, NULL, 'Ah, Sun - Flower!', 'The Passing of the Year: No. 5. Ah, Sun - Flower!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17252 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b45fdfcb-3eec-4dc0-93f8-83ab20f416c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Adieu! Farewell Earth’s Bliss!', part.name_en = 'The Passing of the Year: No. 6. Adieu! Farewell Earth’s Bliss!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17252 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:f228fc34-5cb2-4eaa-901d-cd9995fd988d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f228fc34-5cb2-4eaa-901d-cd9995fd988d', 6, NULL, 'Adieu! Farewell Earth’s Bliss!', 'The Passing of the Year: No. 6. Adieu! Farewell Earth’s Bliss!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17252 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f228fc34-5cb2-4eaa-901d-cd9995fd988d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Ring Out, Wild Bells', part.name_en = 'The Passing of the Year: No. 7. Ring Out, Wild Bells',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17252 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:cd7e575a-e5ed-422e-a1af-92eb4beee04c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd7e575a-e5ed-422e-a1af-92eb4beee04c', 7, NULL, 'Ring Out, Wild Bells', 'The Passing of the Year: No. 7. Ring Out, Wild Bells', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17252 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd7e575a-e5ed-422e-a1af-92eb4beee04c'
);


-- None The Ringing Isle

UPDATE pieces piece
SET piece.title = 'The Ringing Isle', piece.title_en = 'The Ringing Isle',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17044 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Star-Song>

UPDATE pieces piece
SET piece.title = '가곡 <The Star-Song>', piece.title_en = 'The Star-Song',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18897 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Three Kings

UPDATE pieces piece
SET piece.title = 'The Three Kings', piece.title_en = 'The Three Kings',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18143 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None They Will Rise

UPDATE pieces piece
SET piece.title = 'They Will Rise', piece.title_en = 'They Will Rise',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18572 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Thre Tennyson Songs

UPDATE pieces piece
SET piece.title = 'Thre Tennyson Songs', piece.title_en = 'Thre Tennyson Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18754 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Swallow, swallow', part.name_en = 'Three Tennyson Songs: Swallow, swallow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18754 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:225d4eb1-32ef-49a6-bef7-bc2c6953c553' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:225d4eb1-32ef-49a6-bef7-bc2c6953c553', 1, NULL, 'Swallow, swallow', 'Three Tennyson Songs: Swallow, swallow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18754 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:225d4eb1-32ef-49a6-bef7-bc2c6953c553'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Sailor-boy', part.name_en = 'Three Tennyson Songs: The Sailor-boy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18754 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:a434db80-9561-4756-b0f8-ead30011ec03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a434db80-9561-4756-b0f8-ead30011ec03', 2, NULL, 'The Sailor-boy', 'Three Tennyson Songs: The Sailor-boy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18754 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a434db80-9561-4756-b0f8-ead30011ec03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Dark House', part.name_en = 'Three Tennyson Songs: Dark House',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18754 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:f7f1543e-fadd-40a3-af6f-0e3021f0cea9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7f1543e-fadd-40a3-af6f-0e3021f0cea9', 3, NULL, 'Dark House', 'Three Tennyson Songs: Dark House', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18754 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7f1543e-fadd-40a3-af6f-0e3021f0cea9'
);


-- None 오페라 <Tobias and the Angel>

UPDATE pieces piece
SET piece.title = '오페라 <Tobias and the Angel>', piece.title_en = 'Tobias and the Angel',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19161 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <Under Alter’d Skies>

UPDATE pieces piece
SET piece.title = '연가곡집 <Under Alter’d Skies>', piece.title_en = 'Under Alter’d Skies',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18858 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Fair Ship', part.name_en = 'Under Alter’d Skies: No. 1. Fair Ship',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18858 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:8c2b491a-31af-47b3-b8a5-819c0390cdd1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c2b491a-31af-47b3-b8a5-819c0390cdd1', 1, NULL, 'Fair Ship', 'Under Alter’d Skies: No. 1. Fair Ship', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18858 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c2b491a-31af-47b3-b8a5-819c0390cdd1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Calm Is the Morn', part.name_en = 'Under Alter’d Skies: No. 2. Calm Is the Morn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18858 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:392e7aed-b881-4a78-9d4f-bab0fd0e22ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:392e7aed-b881-4a78-9d4f-bab0fd0e22ae', 2, NULL, 'Calm Is the Morn', 'Under Alter’d Skies: No. 2. Calm Is the Morn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18858 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:392e7aed-b881-4a78-9d4f-bab0fd0e22ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'To-night the Winds Begin to Rise', part.name_en = 'Under Alter’d Skies: No. 3. To-night the Winds Begin to Rise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18858 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:42c4b064-2e5c-4232-b80e-39d11e3c103b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42c4b064-2e5c-4232-b80e-39d11e3c103b', 3, NULL, 'To-night the Winds Begin to Rise', 'Under Alter’d Skies: No. 3. To-night the Winds Begin to Rise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18858 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42c4b064-2e5c-4232-b80e-39d11e3c103b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'With Weary Steps', part.name_en = 'Under Alter’d Skies: No. 4. With Weary Steps',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18858 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:60e69935-6256-43f2-9b11-4be176633d1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60e69935-6256-43f2-9b11-4be176633d1d', 4, NULL, 'With Weary Steps', 'Under Alter’d Skies: No. 4. With Weary Steps', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18858 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60e69935-6256-43f2-9b11-4be176633d1d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Be Near Me', part.name_en = 'Under Alter’d Skies: No. 5. Be Near Me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18858 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:45ffc248-7505-41af-b809-dbdf671590cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45ffc248-7505-41af-b809-dbdf671590cf', 5, NULL, 'Be Near Me', 'Under Alter’d Skies: No. 5. Be Near Me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18858 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45ffc248-7505-41af-b809-dbdf671590cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Peace, Come Away', part.name_en = 'Under Alter’d Skies: No. 6. Peace, Come Away',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18858 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:99781710-7e4c-4eb8-8b48-96e5cb4b58de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99781710-7e4c-4eb8-8b48-96e5cb4b58de', 6, NULL, 'Peace, Come Away', 'Under Alter’d Skies: No. 6. Peace, Come Away', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18858 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99781710-7e4c-4eb8-8b48-96e5cb4b58de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Thy Voice Is on the Rolling Air', part.name_en = 'Under Alter’d Skies: No. 7. Thy Voice Is on the Rolling Air',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18858 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:455ece28-e53c-4a64-b216-752ceafd3da9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:455ece28-e53c-4a64-b216-752ceafd3da9', 7, NULL, 'Thy Voice Is on the Rolling Air', 'Under Alter’d Skies: No. 7. Thy Voice Is on the Rolling Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18858 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:455ece28-e53c-4a64-b216-752ceafd3da9'
);


-- None 가곡 <Vadam et circuibo civitatem>

UPDATE pieces piece
SET piece.title = '가곡 <Vadam et circuibo civitatem>', piece.title_en = 'Vadam et circuibo civitatem',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18974 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vanishing Gold

UPDATE pieces piece
SET piece.title = 'Vanishing Gold', piece.title_en = 'Vanishing Gold',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17277 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vast Ocean of Light

UPDATE pieces piece
SET piece.title = 'Vast Ocean of Light', piece.title_en = 'Vast Ocean of Light',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18333 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vertue

UPDATE pieces piece
SET piece.title = 'Vertue', piece.title_en = 'Vertue',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17227 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None We Are One Fire

UPDATE pieces piece
SET piece.title = 'We Are One Fire', piece.title_en = 'We Are One Fire',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19227 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Wellcome All Wonders in One Sight!

UPDATE pieces piece
SET piece.title = 'Wellcome All Wonders in One Sight!', piece.title_en = 'Wellcome All Wonders in One Sight!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18633 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Who Wrote the Book of Love?

UPDATE pieces piece
SET piece.title = 'Who Wrote the Book of Love?', piece.title_en = 'Who Wrote the Book of Love?',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19075 AND piece.composer_id = 139
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Poet Love (1)', part.name_en = 'Who Wrote the Book of Love?: I. Poet Love (1)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19075 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:cfaf1081-c770-44a3-b799-800b6653a6c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfaf1081-c770-44a3-b799-800b6653a6c2', 1, 'I', 'Poet Love (1)', 'Who Wrote the Book of Love?: I. Poet Love (1)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19075 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfaf1081-c770-44a3-b799-800b6653a6c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sappho Love', part.name_en = 'Who Wrote the Book of Love?: II. Sappho Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19075 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:d85cef68-02cb-4edb-a5be-65b2ebb94c4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d85cef68-02cb-4edb-a5be-65b2ebb94c4d', 2, 'II', 'Sappho Love', 'Who Wrote the Book of Love?: II. Sappho Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19075 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d85cef68-02cb-4edb-a5be-65b2ebb94c4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Greek Love', part.name_en = 'Who Wrote the Book of Love?: III. Greek Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19075 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:5d5f413d-f2db-4d35-83b1-7bb9c7e3e008' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d5f413d-f2db-4d35-83b1-7bb9c7e3e008', 3, 'III', 'Greek Love', 'Who Wrote the Book of Love?: III. Greek Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19075 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d5f413d-f2db-4d35-83b1-7bb9c7e3e008'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Persian Love', part.name_en = 'Who Wrote the Book of Love?: IV. Persian Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19075 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:7e46df0f-7fc4-4d83-8371-ce78f1f4f718' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e46df0f-7fc4-4d83-8371-ce78f1f4f718', 4, 'IV', 'Persian Love', 'Who Wrote the Book of Love?: IV. Persian Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19075 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e46df0f-7fc4-4d83-8371-ce78f1f4f718'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Deaf Love', part.name_en = 'Who Wrote the Book of Love?: V. Deaf Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19075 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:a06c8254-2264-45c2-ae30-9638a1a3a001' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a06c8254-2264-45c2-ae30-9638a1a3a001', 5, 'V', 'Deaf Love', 'Who Wrote the Book of Love?: V. Deaf Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19075 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a06c8254-2264-45c2-ae30-9638a1a3a001'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Gallant Love', part.name_en = 'Who Wrote the Book of Love?: VI. Gallant Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19075 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:d9515189-46db-4f1d-9d50-5e6efebb57f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9515189-46db-4f1d-9d50-5e6efebb57f2', 6, 'VI', 'Gallant Love', 'Who Wrote the Book of Love?: VI. Gallant Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19075 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9515189-46db-4f1d-9d50-5e6efebb57f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Cold Love', part.name_en = 'Who Wrote the Book of Love?: VII. Cold Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19075 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:a199571c-787b-41c8-b293-5d66dd288c30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a199571c-787b-41c8-b293-5d66dd288c30', 7, 'VII', 'Cold Love', 'Who Wrote the Book of Love?: VII. Cold Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19075 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a199571c-787b-41c8-b293-5d66dd288c30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Prescient Love', part.name_en = 'Who Wrote the Book of Love?: VIII. Prescient Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19075 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:c257c7a6-3802-451d-9778-49d0fee658a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c257c7a6-3802-451d-9778-49d0fee658a9', 8, 'VIII', 'Prescient Love', 'Who Wrote the Book of Love?: VIII. Prescient Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19075 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c257c7a6-3802-451d-9778-49d0fee658a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Misbegotten Love', part.name_en = 'Who Wrote the Book of Love?: IX. Misbegotten Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19075 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:f7d0eb1d-35a2-409f-86ae-6c957fc9a5f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7d0eb1d-35a2-409f-86ae-6c957fc9a5f0', 9, 'IX', 'Misbegotten Love', 'Who Wrote the Book of Love?: IX. Misbegotten Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19075 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7d0eb1d-35a2-409f-86ae-6c957fc9a5f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Puzzled Love', part.name_en = 'Who Wrote the Book of Love?: X. Puzzled Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19075 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:39bb3a2a-ab2e-4889-9d96-83f2f7f8efcd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39bb3a2a-ab2e-4889-9d96-83f2f7f8efcd', 10, 'X', 'Puzzled Love', 'Who Wrote the Book of Love?: X. Puzzled Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19075 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39bb3a2a-ab2e-4889-9d96-83f2f7f8efcd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Poet Love (2)', part.name_en = 'Who Wrote the Book of Love?: XI. Poet Love (2)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19075 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:2a0d4ac5-40b8-42b7-acf4-b7113e2d6672' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a0d4ac5-40b8-42b7-acf4-b7113e2d6672', 11, 'XI', 'Poet Love (2)', 'Who Wrote the Book of Love?: XI. Poet Love (2)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19075 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a0d4ac5-40b8-42b7-acf4-b7113e2d6672'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Gypsy Love', part.name_en = 'Who Wrote the Book of Love?: XII. Gypsy Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19075 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:1ffcb8a1-3dae-4076-a652-1540d87b78df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ffcb8a1-3dae-4076-a652-1540d87b78df', 12, 'XII', 'Gypsy Love', 'Who Wrote the Book of Love?: XII. Gypsy Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19075 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ffcb8a1-3dae-4076-a652-1540d87b78df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'XIII',
    part.name_ko = 'Burning Love', part.name_en = 'Who Wrote the Book of Love?: XIII. Burning Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19075 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:c2475d44-3dbb-486e-b694-6862b38c4d8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2475d44-3dbb-486e-b694-6862b38c4d8d', 13, 'XIII', 'Burning Love', 'Who Wrote the Book of Love?: XIII. Burning Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19075 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2475d44-3dbb-486e-b694-6862b38c4d8d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = 'XIV',
    part.name_ko = 'Folk Love', part.name_en = 'Who Wrote the Book of Love?: XIV. Folk Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19075 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:4807887b-bcd4-42a3-86fa-60eba044ebf8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4807887b-bcd4-42a3-86fa-60eba044ebf8', 14, 'XIV', 'Folk Love', 'Who Wrote the Book of Love?: XIV. Folk Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19075 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4807887b-bcd4-42a3-86fa-60eba044ebf8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = 'XV',
    part.name_ko = 'Shrug Love', part.name_en = 'Who Wrote the Book of Love?: XV. Shrug Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19075 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:16f290d4-c162-4812-b966-9efea80367fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16f290d4-c162-4812-b966-9efea80367fa', 15, 'XV', 'Shrug Love', 'Who Wrote the Book of Love?: XV. Shrug Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19075 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16f290d4-c162-4812-b966-9efea80367fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = 'XVI',
    part.name_ko = 'Scientific Love', part.name_en = 'Who Wrote the Book of Love?: XVI. Scientific Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19075 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:2f29ed14-cd50-45d0-8db2-7a053e11c6a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f29ed14-cd50-45d0-8db2-7a053e11c6a8', 16, 'XVI', 'Scientific Love', 'Who Wrote the Book of Love?: XVI. Scientific Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19075 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f29ed14-cd50-45d0-8db2-7a053e11c6a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = 'XVII',
    part.name_ko = 'Cythera Love', part.name_en = 'Who Wrote the Book of Love?: XVII. Cythera Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19075 AND p.composer_id = 139 AND part.part_key = 'musicbrainz:abf45ea3-5b45-42a4-9ca0-5220416f84dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:abf45ea3-5b45-42a4-9ca0-5220416f84dd', 17, 'XVII', 'Cythera Love', 'Who Wrote the Book of Love?: XVII. Cythera Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19075 AND p.composer_id = 139
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abf45ea3-5b45-42a4-9ca0-5220416f84dd'
);


-- None Missa Brevis

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Missa Brevis', 'Missa Brevis', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 139
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Missa Brevis'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9124b890-375c-44ef-b768-63ab55a10f52'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9124b890-375c-44ef-b768-63ab55a10f52'
FROM pieces p
WHERE p.composer_id = 139 AND p.title = 'Missa Brevis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9124b890-375c-44ef-b768-63ab55a10f52'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20333f10-f361-4d63-b72c-2a8c2b774968', 1, 'I', 'Kyrie', 'Missa Brevis: I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 139 AND p.title = 'Missa Brevis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20333f10-f361-4d63-b72c-2a8c2b774968'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59f1e922-238f-4a13-80ca-cc1e1c951d0b', 2, 'II', 'Gloria', 'Missa Brevis: II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 139 AND p.title = 'Missa Brevis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59f1e922-238f-4a13-80ca-cc1e1c951d0b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62e6a2fa-5caa-4cea-b4ec-127f835e2fd9', 3, 'III', 'Sanctus and Benedictus', 'Missa Brevis: III. Sanctus and Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 139 AND p.title = 'Missa Brevis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62e6a2fa-5caa-4cea-b4ec-127f835e2fd9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b844fb7c-84a3-4481-b0ac-914496e4e5ca', 4, 'IV', 'Agnus Dei', 'Missa Brevis: IV. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 139 AND p.title = 'Missa Brevis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b844fb7c-84a3-4481-b0ac-914496e4e5ca'
);


-- None Niagara

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Niagara', 'Niagara', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 139
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Niagara'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86235308-3895-41de-8c0f-d3ccf6d3211f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '86235308-3895-41de-8c0f-d3ccf6d3211f'
FROM pieces p
WHERE p.composer_id = 139 AND p.title = 'Niagara' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86235308-3895-41de-8c0f-d3ccf6d3211f'
);


-- None 피아노 5중주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 5중주', 'Piano Quintet', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 139
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 5중주'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09983552-8ec9-436b-b474-a8cacb0c8f3f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '09983552-8ec9-436b-b474-a8cacb0c8f3f'
FROM pieces p
WHERE p.composer_id = 139 AND p.title = '피아노 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09983552-8ec9-436b-b474-a8cacb0c8f3f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0a281c9-0cf0-4b3a-8798-b72eb5c90645', 1, 'I', 'Energetic', 'Piano Quintet: I. Energetic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 139 AND p.title = '피아노 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0a281c9-0cf0-4b3a-8798-b72eb5c90645'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b82beb3b-1abb-48f1-ad1b-f402dde8c4b4', 2, 'II', 'Very spacious', 'Piano Quintet: II. Very spacious', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 139 AND p.title = '피아노 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b82beb3b-1abb-48f1-ad1b-f402dde8c4b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3277f3b5-4770-4f2e-b6cb-4956fa0d9946', 3, 'III', 'Lively', 'Piano Quintet: III. Lively', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 139 AND p.title = '피아노 5중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3277f3b5-4770-4f2e-b6cb-4956fa0d9946'
);


-- None 테 데움

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '테 데움', 'Te Deum', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 139
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '테 데움'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd4e9bc9e-ad04-4db5-9510-8cd61aab8753'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd4e9bc9e-ad04-4db5-9510-8cd61aab8753'
FROM pieces p
WHERE p.composer_id = 139 AND p.title = '테 데움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd4e9bc9e-ad04-4db5-9510-8cd61aab8753'
);


-- None The End

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The End', 'The End', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 139
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The End'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3fdf6a01-c871-4629-9afd-07a0232fbc3d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3fdf6a01-c871-4629-9afd-07a0232fbc3d'
FROM pieces p
WHERE p.composer_id = 139 AND p.title = 'The End' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3fdf6a01-c871-4629-9afd-07a0232fbc3d'
);


-- 카탈로그에 대응이 없는 seed 작품 3개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 139 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    18659, 19386, 19962
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
