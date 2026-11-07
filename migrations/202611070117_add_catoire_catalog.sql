-- Jean Catoire 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 37개(묶음 2, 다악장 10, 낱곡 25),
-- 새 작품 1개, part 136개, 그 아래 0개.
-- seed 36개 중 36개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.
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

-- Op. 84 Interludes for Organ Op. 84

UPDATE pieces piece
SET piece.title = 'Interludes for Organ Op. 84', piece.title_en = 'Interludes for Organ, op. 84',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '84',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18538 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Interlude for Organ, op. 84 no. 1', part.name_en = 'Interlude for Organ, op. 84 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18538 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:f81ef36a-9a00-4dc5-adac-bc7c78bb1a12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f81ef36a-9a00-4dc5-adac-bc7c78bb1a12', 1, NULL, 'Interlude for Organ, op. 84 no. 1', 'Interlude for Organ, op. 84 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18538 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f81ef36a-9a00-4dc5-adac-bc7c78bb1a12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Interlude for Organ, op. 84 no. 2', part.name_en = 'Interlude for Organ, op. 84 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18538 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:123e1911-6a37-4dfc-865a-9b4e71a598d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:123e1911-6a37-4dfc-865a-9b4e71a598d1', 2, NULL, 'Interlude for Organ, op. 84 no. 2', 'Interlude for Organ, op. 84 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18538 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:123e1911-6a37-4dfc-865a-9b4e71a598d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Interlude for Organ, op. 84 no. 3', part.name_en = 'Interlude for Organ, op. 84 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18538 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:ad2e180f-366c-4c2e-8799-d5ca70e80777' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad2e180f-366c-4c2e-8799-d5ca70e80777', 3, NULL, 'Interlude for Organ, op. 84 no. 3', 'Interlude for Organ, op. 84 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18538 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad2e180f-366c-4c2e-8799-d5ca70e80777'
);


-- None Opus 134A

UPDATE pieces piece
SET piece.title = 'Opus 134A', piece.title_en = 'Opus 134A',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19190 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '1', part.name_en = 'Opus 134A : 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19190 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:0f874e06-92a5-4b04-953e-aaf33cb78036' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f874e06-92a5-4b04-953e-aaf33cb78036', 1, NULL, '1', 'Opus 134A : 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19190 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f874e06-92a5-4b04-953e-aaf33cb78036'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '2', part.name_en = 'Opus 134A : 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19190 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:dd49018b-477c-4eae-8a1d-2d45fc57a2fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd49018b-477c-4eae-8a1d-2d45fc57a2fb', 2, NULL, '2', 'Opus 134A : 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19190 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd49018b-477c-4eae-8a1d-2d45fc57a2fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '3', part.name_en = 'Opus 134A : 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19190 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:5667ad44-c8ec-4ffd-a3a8-062cf0e8130a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5667ad44-c8ec-4ffd-a3a8-062cf0e8130a', 3, NULL, '3', 'Opus 134A : 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19190 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5667ad44-c8ec-4ffd-a3a8-062cf0e8130a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '4', part.name_en = 'Opus 134A : 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19190 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:62c97f3e-3066-4a6a-b321-94a2ef69945a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62c97f3e-3066-4a6a-b321-94a2ef69945a', 4, NULL, '4', 'Opus 134A : 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19190 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62c97f3e-3066-4a6a-b321-94a2ef69945a'
);


-- None Opus 137

UPDATE pieces piece
SET piece.title = 'Opus 137', piece.title_en = 'Opus 137',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19076 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '1', part.name_en = 'Opus 137 : 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:6e22bfbf-d79f-4af9-8858-8b96c901cc01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e22bfbf-d79f-4af9-8858-8b96c901cc01', 1, NULL, '1', 'Opus 137 : 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e22bfbf-d79f-4af9-8858-8b96c901cc01'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '2', part.name_en = 'Opus 137 : 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:42cdc4bd-cd4a-44b7-b5d6-658d84a26fac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42cdc4bd-cd4a-44b7-b5d6-658d84a26fac', 2, NULL, '2', 'Opus 137 : 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42cdc4bd-cd4a-44b7-b5d6-658d84a26fac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '3', part.name_en = 'Opus 137 : 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:d78091cb-0bd2-4b7c-a5f3-90a2bb1020ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d78091cb-0bd2-4b7c-a5f3-90a2bb1020ab', 3, NULL, '3', 'Opus 137 : 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d78091cb-0bd2-4b7c-a5f3-90a2bb1020ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '4', part.name_en = 'Opus 137 : 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:cf8dbceb-8e54-4c06-b220-46cea256b2df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf8dbceb-8e54-4c06-b220-46cea256b2df', 4, NULL, '4', 'Opus 137 : 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf8dbceb-8e54-4c06-b220-46cea256b2df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '5', part.name_en = 'Opus 137 : 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:4b545eaa-a27e-4640-9a5c-17c34b61cb13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b545eaa-a27e-4640-9a5c-17c34b61cb13', 5, NULL, '5', 'Opus 137 : 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b545eaa-a27e-4640-9a5c-17c34b61cb13'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '6', part.name_en = 'Opus 137 : 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:733d452c-5dad-4afa-85f6-a7b951737244' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:733d452c-5dad-4afa-85f6-a7b951737244', 6, NULL, '6', 'Opus 137 : 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:733d452c-5dad-4afa-85f6-a7b951737244'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '7', part.name_en = 'Opus 137 : 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:bd5a5905-2c44-4571-8f5d-d8e9b2c0d4c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd5a5905-2c44-4571-8f5d-d8e9b2c0d4c2', 7, NULL, '7', 'Opus 137 : 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd5a5905-2c44-4571-8f5d-d8e9b2c0d4c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '8', part.name_en = 'Opus 137 : 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:017b2657-f382-470a-875f-bf07ecb0f90f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:017b2657-f382-470a-875f-bf07ecb0f90f', 8, NULL, '8', 'Opus 137 : 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:017b2657-f382-470a-875f-bf07ecb0f90f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '9', part.name_en = 'Opus 137 : 9',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:7750032b-5411-44b7-8b66-8703f7ac3b7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7750032b-5411-44b7-8b66-8703f7ac3b7f', 9, NULL, '9', 'Opus 137 : 9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7750032b-5411-44b7-8b66-8703f7ac3b7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '10', part.name_en = 'Opus 137 : 10',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:719f7aac-3088-4068-8721-f5d3607e23dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:719f7aac-3088-4068-8721-f5d3607e23dd', 10, NULL, '10', 'Opus 137 : 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:719f7aac-3088-4068-8721-f5d3607e23dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '11', part.name_en = 'Opus 137 : 11',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:fc5a63df-9f52-450c-91bf-2d918930fe6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc5a63df-9f52-450c-91bf-2d918930fe6c', 11, NULL, '11', 'Opus 137 : 11', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc5a63df-9f52-450c-91bf-2d918930fe6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '12', part.name_en = 'Opus 137 : 12',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:3f6864e3-6089-4622-9653-738dae422b76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f6864e3-6089-4622-9653-738dae422b76', 12, NULL, '12', 'Opus 137 : 12', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f6864e3-6089-4622-9653-738dae422b76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = '13', part.name_en = 'Opus 137 : 13',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:4338b85a-5dda-4017-8de4-a6dcf87a46ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4338b85a-5dda-4017-8de4-a6dcf87a46ee', 13, NULL, '13', 'Opus 137 : 13', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4338b85a-5dda-4017-8de4-a6dcf87a46ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = '14', part.name_en = 'Opus 137 : 14',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:8cfc6c61-2c85-40c1-aa27-ab2028ff37fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8cfc6c61-2c85-40c1-aa27-ab2028ff37fa', 14, NULL, '14', 'Opus 137 : 14', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cfc6c61-2c85-40c1-aa27-ab2028ff37fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = '15', part.name_en = 'Opus 137 : 15',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:131af945-2433-476b-885c-5e0c3646a0d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:131af945-2433-476b-885c-5e0c3646a0d2', 15, NULL, '15', 'Opus 137 : 15', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:131af945-2433-476b-885c-5e0c3646a0d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = '16', part.name_en = 'Opus 137 : 16',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:05c550b9-1f21-4df4-ac2c-5ca873971271' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05c550b9-1f21-4df4-ac2c-5ca873971271', 16, NULL, '16', 'Opus 137 : 16', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05c550b9-1f21-4df4-ac2c-5ca873971271'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = '17', part.name_en = 'Opus 137 : 17',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:e2c724e9-c55e-4228-8b50-b0ef1fe629b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2c724e9-c55e-4228-8b50-b0ef1fe629b4', 17, NULL, '17', 'Opus 137 : 17', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2c724e9-c55e-4228-8b50-b0ef1fe629b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = '18', part.name_en = 'Opus 137 : 18',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:d2732d15-b99d-4efb-be79-53a73e34873f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2732d15-b99d-4efb-be79-53a73e34873f', 18, NULL, '18', 'Opus 137 : 18', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2732d15-b99d-4efb-be79-53a73e34873f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = '19', part.name_en = 'Opus 137 : 19',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:8ac200d3-f7a4-4a71-9455-4ead235e2ac6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ac200d3-f7a4-4a71-9455-4ead235e2ac6', 19, NULL, '19', 'Opus 137 : 19', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ac200d3-f7a4-4a71-9455-4ead235e2ac6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = '20', part.name_en = 'Opus 137 : 20',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:ef9e7567-0412-4b03-82c4-10e38c903668' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef9e7567-0412-4b03-82c4-10e38c903668', 20, NULL, '20', 'Opus 137 : 20', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef9e7567-0412-4b03-82c4-10e38c903668'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = '21', part.name_en = 'Opus 137 : 21',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:d63b80e0-acc6-4e9b-8565-0644804ee578' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d63b80e0-acc6-4e9b-8565-0644804ee578', 21, NULL, '21', 'Opus 137 : 21', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d63b80e0-acc6-4e9b-8565-0644804ee578'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = '22', part.name_en = 'Opus 137 : 22',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:003ad9bc-2a88-422d-91cf-b634c39c8d2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:003ad9bc-2a88-422d-91cf-b634c39c8d2d', 22, NULL, '22', 'Opus 137 : 22', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:003ad9bc-2a88-422d-91cf-b634c39c8d2d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = '23', part.name_en = 'Opus 137 : 23',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:7dcce4d4-0e48-4f31-a6e2-a22c3c03c3ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7dcce4d4-0e48-4f31-a6e2-a22c3c03c3ec', 23, NULL, '23', 'Opus 137 : 23', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dcce4d4-0e48-4f31-a6e2-a22c3c03c3ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = '24', part.name_en = 'Opus 137 : 24',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:a34f449e-609f-4f14-8038-e71817d8268c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a34f449e-609f-4f14-8038-e71817d8268c', 24, NULL, '24', 'Opus 137 : 24', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a34f449e-609f-4f14-8038-e71817d8268c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = '25', part.name_en = 'Opus 137 : 25',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:f4f66e34-5f38-4810-961d-4306683d7484' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4f66e34-5f38-4810-961d-4306683d7484', 25, NULL, '25', 'Opus 137 : 25', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4f66e34-5f38-4810-961d-4306683d7484'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = '26', part.name_en = 'Opus 137 : 26',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:6b297bb1-1285-4ece-bd15-9bc95813b11f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b297bb1-1285-4ece-bd15-9bc95813b11f', 26, NULL, '26', 'Opus 137 : 26', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b297bb1-1285-4ece-bd15-9bc95813b11f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = '27', part.name_en = 'Opus 137 : 27',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:312b2b77-af09-4461-b28b-3028b9b2328f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:312b2b77-af09-4461-b28b-3028b9b2328f', 27, NULL, '27', 'Opus 137 : 27', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:312b2b77-af09-4461-b28b-3028b9b2328f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = '28', part.name_en = 'Opus 137 : 28',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:ee0bf8f2-8f8b-49dc-b8da-9077a9489962' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee0bf8f2-8f8b-49dc-b8da-9077a9489962', 28, NULL, '28', 'Opus 137 : 28', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee0bf8f2-8f8b-49dc-b8da-9077a9489962'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = '29', part.name_en = 'Opus 137 : 29',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:77cb7151-5ca3-4149-a905-7214d1f04647' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77cb7151-5ca3-4149-a905-7214d1f04647', 29, NULL, '29', 'Opus 137 : 29', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77cb7151-5ca3-4149-a905-7214d1f04647'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = '30', part.name_en = 'Opus 137 : 30',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:3ae74be5-04d4-48b5-97dc-eb6859079816' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ae74be5-04d4-48b5-97dc-eb6859079816', 30, NULL, '30', 'Opus 137 : 30', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ae74be5-04d4-48b5-97dc-eb6859079816'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = '31', part.name_en = 'Opus 137 : 31',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:cb9e9e51-47be-4e30-8adf-3cfdeae04329' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb9e9e51-47be-4e30-8adf-3cfdeae04329', 31, NULL, '31', 'Opus 137 : 31', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb9e9e51-47be-4e30-8adf-3cfdeae04329'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = '32', part.name_en = 'Opus 137 : 32',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:3a9b0684-9c1b-4275-b95d-ea6887854447' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a9b0684-9c1b-4275-b95d-ea6887854447', 32, NULL, '32', 'Opus 137 : 32', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a9b0684-9c1b-4275-b95d-ea6887854447'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 33, part.movement_number = NULL,
    part.name_ko = '33', part.name_en = 'Opus 137 : 33',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:9a420bf0-4bb2-401a-8fee-72955723e428' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a420bf0-4bb2-401a-8fee-72955723e428', 33, NULL, '33', 'Opus 137 : 33', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a420bf0-4bb2-401a-8fee-72955723e428'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 34, part.movement_number = NULL,
    part.name_ko = '34', part.name_en = 'Opus 137 : 34',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:25b8f67d-4152-4154-8719-b57242a35ab8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25b8f67d-4152-4154-8719-b57242a35ab8', 34, NULL, '34', 'Opus 137 : 34', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25b8f67d-4152-4154-8719-b57242a35ab8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 35, part.movement_number = NULL,
    part.name_ko = '35', part.name_en = 'Opus 137 : 35',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:f5dc19d1-e393-4600-9119-6f17c4d8ad25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5dc19d1-e393-4600-9119-6f17c4d8ad25', 35, NULL, '35', 'Opus 137 : 35', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5dc19d1-e393-4600-9119-6f17c4d8ad25'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 36, part.movement_number = NULL,
    part.name_ko = '36', part.name_en = 'Opus 137 : 36',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19076 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:65453aac-6b6d-4843-b56d-16c6c92a6c91' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65453aac-6b6d-4843-b56d-16c6c92a6c91', 36, NULL, '36', 'Opus 137 : 36', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19076 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65453aac-6b6d-4843-b56d-16c6c92a6c91'
);


-- None Opus 154

UPDATE pieces piece
SET piece.title = 'Opus 154', piece.title_en = 'Opus 154',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19531 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opus 157

UPDATE pieces piece
SET piece.title = 'Opus 157', piece.title_en = 'Opus 157',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17737 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opus 162

UPDATE pieces piece
SET piece.title = 'Opus 162', piece.title_en = 'Opus 162',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16592 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opus 163

UPDATE pieces piece
SET piece.title = 'Opus 163', piece.title_en = 'Opus 163',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19797 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opus 164

UPDATE pieces piece
SET piece.title = 'Opus 164', piece.title_en = 'Opus 164',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17487 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opus 206

UPDATE pieces piece
SET piece.title = 'Opus 206', piece.title_en = 'Opus 206',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19731 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opus 207

UPDATE pieces piece
SET piece.title = 'Opus 207', piece.title_en = 'Opus 207',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16219 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opus 210

UPDATE pieces piece
SET piece.title = 'Opus 210', piece.title_en = 'Opus 210',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18945 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opus 211

UPDATE pieces piece
SET piece.title = 'Opus 211', piece.title_en = 'Opus 211',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19337 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opus 256A

UPDATE pieces piece
SET piece.title = 'Opus 256A', piece.title_en = 'Opus 256A',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16059 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opus 278

UPDATE pieces piece
SET piece.title = 'Opus 278', piece.title_en = 'Opus 278',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19787 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opus 283

UPDATE pieces piece
SET piece.title = 'Opus 283', piece.title_en = 'Opus 283',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17364 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opus 296A

UPDATE pieces piece
SET piece.title = 'Opus 296A', piece.title_en = 'Opus 296A',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17657 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opus 303 ter

UPDATE pieces piece
SET piece.title = 'Opus 303 ter', piece.title_en = 'Opus 303 ter',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16476 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '1', part.name_en = 'Opus 303 ter : 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:ec41320c-ff49-4660-8df9-aa27924fd9c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec41320c-ff49-4660-8df9-aa27924fd9c7', 1, NULL, '1', 'Opus 303 ter : 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec41320c-ff49-4660-8df9-aa27924fd9c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '2', part.name_en = 'Opus 303 ter : 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:94e6f07a-584c-44f3-80eb-48b97152f864' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94e6f07a-584c-44f3-80eb-48b97152f864', 2, NULL, '2', 'Opus 303 ter : 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94e6f07a-584c-44f3-80eb-48b97152f864'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '3', part.name_en = 'Opus 303 ter : 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:f1e4cae7-b203-4811-9cd2-8a0742757ea6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1e4cae7-b203-4811-9cd2-8a0742757ea6', 3, NULL, '3', 'Opus 303 ter : 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1e4cae7-b203-4811-9cd2-8a0742757ea6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '4', part.name_en = 'Opus 303 ter : 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:b24bf2a4-7663-42eb-89c4-62f71eb209ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b24bf2a4-7663-42eb-89c4-62f71eb209ad', 4, NULL, '4', 'Opus 303 ter : 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b24bf2a4-7663-42eb-89c4-62f71eb209ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '5', part.name_en = 'Opus 303 ter : 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:9acf306f-626d-4202-a1ca-05e53c1ed75c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9acf306f-626d-4202-a1ca-05e53c1ed75c', 5, NULL, '5', 'Opus 303 ter : 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9acf306f-626d-4202-a1ca-05e53c1ed75c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '6', part.name_en = 'Opus 303 ter : 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:e748e385-abe8-4821-bd08-b09d17001d4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e748e385-abe8-4821-bd08-b09d17001d4b', 6, NULL, '6', 'Opus 303 ter : 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e748e385-abe8-4821-bd08-b09d17001d4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '7', part.name_en = 'Opus 303 ter : 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:013812c1-43c7-40c3-b6b0-1b18a5290958' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:013812c1-43c7-40c3-b6b0-1b18a5290958', 7, NULL, '7', 'Opus 303 ter : 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:013812c1-43c7-40c3-b6b0-1b18a5290958'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '8', part.name_en = 'Opus 303 ter : 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:4ec671bd-a164-49a3-9289-ddf1d2fc57d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ec671bd-a164-49a3-9289-ddf1d2fc57d0', 8, NULL, '8', 'Opus 303 ter : 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ec671bd-a164-49a3-9289-ddf1d2fc57d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '9', part.name_en = 'Opus 303 ter : 9',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:2845473b-33be-4a8b-a88d-92ece69f766d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2845473b-33be-4a8b-a88d-92ece69f766d', 9, NULL, '9', 'Opus 303 ter : 9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2845473b-33be-4a8b-a88d-92ece69f766d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '10', part.name_en = 'Opus 303 ter : 10',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:28bed8a0-cfb0-4319-8b25-c317da3e9e1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28bed8a0-cfb0-4319-8b25-c317da3e9e1a', 10, NULL, '10', 'Opus 303 ter : 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28bed8a0-cfb0-4319-8b25-c317da3e9e1a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '11', part.name_en = 'Opus 303 ter : 11',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:e588b40f-9807-4fba-8329-550a6a60e8ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e588b40f-9807-4fba-8329-550a6a60e8ac', 11, NULL, '11', 'Opus 303 ter : 11', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e588b40f-9807-4fba-8329-550a6a60e8ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '12', part.name_en = 'Opus 303 ter : 12',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:8dda6ef3-7a28-4866-8faa-4facbbe31567' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8dda6ef3-7a28-4866-8faa-4facbbe31567', 12, NULL, '12', 'Opus 303 ter : 12', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8dda6ef3-7a28-4866-8faa-4facbbe31567'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = '13', part.name_en = 'Opus 303 ter : 13',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:528b451e-f83e-49f6-9a5a-125eaaf3e28a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:528b451e-f83e-49f6-9a5a-125eaaf3e28a', 13, NULL, '13', 'Opus 303 ter : 13', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:528b451e-f83e-49f6-9a5a-125eaaf3e28a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = '14', part.name_en = 'Opus 303 ter : 14',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:cedcfaaa-8324-459f-b9f7-437078fa883a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cedcfaaa-8324-459f-b9f7-437078fa883a', 14, NULL, '14', 'Opus 303 ter : 14', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cedcfaaa-8324-459f-b9f7-437078fa883a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = '15', part.name_en = 'Opus 303 ter : 15',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:f1ea20bc-7d88-495e-af15-a53489a7fb92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1ea20bc-7d88-495e-af15-a53489a7fb92', 15, NULL, '15', 'Opus 303 ter : 15', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1ea20bc-7d88-495e-af15-a53489a7fb92'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = '16', part.name_en = 'Opus 303 ter : 16',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:9fe9332b-16af-4c96-8b0e-7f0d48d5f3f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fe9332b-16af-4c96-8b0e-7f0d48d5f3f3', 16, NULL, '16', 'Opus 303 ter : 16', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fe9332b-16af-4c96-8b0e-7f0d48d5f3f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = '17', part.name_en = 'Opus 303 ter : 17',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:59bb6c9d-3421-404c-826a-559121b8cebe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59bb6c9d-3421-404c-826a-559121b8cebe', 17, NULL, '17', 'Opus 303 ter : 17', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59bb6c9d-3421-404c-826a-559121b8cebe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = '18', part.name_en = 'Opus 303 ter : 18',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:9c96a434-640f-44ba-9132-210596afb15c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c96a434-640f-44ba-9132-210596afb15c', 18, NULL, '18', 'Opus 303 ter : 18', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c96a434-640f-44ba-9132-210596afb15c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = '19', part.name_en = 'Opus 303 ter : 19',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:a19eac17-4243-4dc0-b281-bb672c3ec352' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a19eac17-4243-4dc0-b281-bb672c3ec352', 19, NULL, '19', 'Opus 303 ter : 19', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a19eac17-4243-4dc0-b281-bb672c3ec352'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = '20', part.name_en = 'Opus 303 ter : 20',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:e1b59536-bac0-48d7-93a1-92591b1ab46b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1b59536-bac0-48d7-93a1-92591b1ab46b', 20, NULL, '20', 'Opus 303 ter : 20', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1b59536-bac0-48d7-93a1-92591b1ab46b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = '21', part.name_en = 'Opus 303 ter : 21',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:87a575c6-1bdd-418b-b224-dd16e87828da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87a575c6-1bdd-418b-b224-dd16e87828da', 21, NULL, '21', 'Opus 303 ter : 21', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87a575c6-1bdd-418b-b224-dd16e87828da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = '22', part.name_en = 'Opus 303 ter : 22',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:927c2a50-ac51-46ee-8fe9-f19602b35641' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:927c2a50-ac51-46ee-8fe9-f19602b35641', 22, NULL, '22', 'Opus 303 ter : 22', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:927c2a50-ac51-46ee-8fe9-f19602b35641'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = '23', part.name_en = 'Opus 303 ter : 23',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:eeaa4387-bb03-4042-8030-1e097ab6a60d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eeaa4387-bb03-4042-8030-1e097ab6a60d', 23, NULL, '23', 'Opus 303 ter : 23', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eeaa4387-bb03-4042-8030-1e097ab6a60d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = '24', part.name_en = 'Opus 303 ter : 24',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16476 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:42b63f18-dc2f-4540-b9e7-2c9419e37fd7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42b63f18-dc2f-4540-b9e7-2c9419e37fd7', 24, NULL, '24', 'Opus 303 ter : 24', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16476 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42b63f18-dc2f-4540-b9e7-2c9419e37fd7'
);


-- None Opus 312

UPDATE pieces piece
SET piece.title = 'Opus 312', piece.title_en = 'Opus 312',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19487 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '1', part.name_en = 'Opus 312 : 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:b4f490a9-8fd9-46ea-9ffc-4736a8377c8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4f490a9-8fd9-46ea-9ffc-4736a8377c8a', 1, NULL, '1', 'Opus 312 : 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4f490a9-8fd9-46ea-9ffc-4736a8377c8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '2', part.name_en = 'Opus 312 : 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:95bda7e2-dc8a-4e1e-81e1-0453af6c5993' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95bda7e2-dc8a-4e1e-81e1-0453af6c5993', 2, NULL, '2', 'Opus 312 : 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95bda7e2-dc8a-4e1e-81e1-0453af6c5993'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '3', part.name_en = 'Opus 312 : 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:400f77e8-d271-48e1-93dc-abb05778b1a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:400f77e8-d271-48e1-93dc-abb05778b1a3', 3, NULL, '3', 'Opus 312 : 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:400f77e8-d271-48e1-93dc-abb05778b1a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '4', part.name_en = 'Opus 312 : 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:9c8c972a-d199-4222-bdee-837cf8fa2bd6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c8c972a-d199-4222-bdee-837cf8fa2bd6', 4, NULL, '4', 'Opus 312 : 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c8c972a-d199-4222-bdee-837cf8fa2bd6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '5', part.name_en = 'Opus 312 : 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:fbe318a6-f498-4a41-aca5-78169fbb8887' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbe318a6-f498-4a41-aca5-78169fbb8887', 5, NULL, '5', 'Opus 312 : 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbe318a6-f498-4a41-aca5-78169fbb8887'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '6', part.name_en = 'Opus 312 : 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:978b5ac9-092b-42ce-815b-925f7e2fcdf3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:978b5ac9-092b-42ce-815b-925f7e2fcdf3', 6, NULL, '6', 'Opus 312 : 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:978b5ac9-092b-42ce-815b-925f7e2fcdf3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '7', part.name_en = 'Opus 312 : 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:b5c91f9d-e088-4127-9645-bf9c71714edb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5c91f9d-e088-4127-9645-bf9c71714edb', 7, NULL, '7', 'Opus 312 : 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5c91f9d-e088-4127-9645-bf9c71714edb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '8', part.name_en = 'Opus 312 : 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:9c1c1e4e-f5f0-40fd-a825-6c2e47020c9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c1c1e4e-f5f0-40fd-a825-6c2e47020c9f', 8, NULL, '8', 'Opus 312 : 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c1c1e4e-f5f0-40fd-a825-6c2e47020c9f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '9', part.name_en = 'Opus 312 : 9',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:34c965fd-6ee2-4d51-8b50-54731bddaf0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34c965fd-6ee2-4d51-8b50-54731bddaf0f', 9, NULL, '9', 'Opus 312 : 9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34c965fd-6ee2-4d51-8b50-54731bddaf0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '10', part.name_en = 'Opus 312 : 10',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:48bb8c7d-c4fe-462a-a4c7-be17fcaec2c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48bb8c7d-c4fe-462a-a4c7-be17fcaec2c0', 10, NULL, '10', 'Opus 312 : 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48bb8c7d-c4fe-462a-a4c7-be17fcaec2c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '11', part.name_en = 'Opus 312 : 11',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:259d95e9-28a0-41e1-be5d-537a80c4810b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:259d95e9-28a0-41e1-be5d-537a80c4810b', 11, NULL, '11', 'Opus 312 : 11', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:259d95e9-28a0-41e1-be5d-537a80c4810b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '12', part.name_en = 'Opus 312 : 12',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:e7f07167-b9cf-4699-b9c6-d8cd78e116a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7f07167-b9cf-4699-b9c6-d8cd78e116a4', 12, NULL, '12', 'Opus 312 : 12', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7f07167-b9cf-4699-b9c6-d8cd78e116a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = '13', part.name_en = 'Opus 312 : 13',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:4109c1b8-87e9-4ad8-b9a0-bff307285142' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4109c1b8-87e9-4ad8-b9a0-bff307285142', 13, NULL, '13', 'Opus 312 : 13', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4109c1b8-87e9-4ad8-b9a0-bff307285142'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = '14', part.name_en = 'Opus 312 : 14',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:b2031de8-3dcb-4885-8e3c-26ab2ebf390a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2031de8-3dcb-4885-8e3c-26ab2ebf390a', 14, NULL, '14', 'Opus 312 : 14', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2031de8-3dcb-4885-8e3c-26ab2ebf390a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = '15', part.name_en = 'Opus 312 : 15',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:3a2f5c31-c0c6-49d4-9b67-f7446b17804c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a2f5c31-c0c6-49d4-9b67-f7446b17804c', 15, NULL, '15', 'Opus 312 : 15', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a2f5c31-c0c6-49d4-9b67-f7446b17804c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = '16', part.name_en = 'Opus 312 : 16',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:a1b3f54e-6c7d-4000-a558-fe618b972364' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1b3f54e-6c7d-4000-a558-fe618b972364', 16, NULL, '16', 'Opus 312 : 16', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1b3f54e-6c7d-4000-a558-fe618b972364'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = '17', part.name_en = 'Opus 312 : 17',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:b8356c50-700e-4867-bf5a-453fa3edec16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8356c50-700e-4867-bf5a-453fa3edec16', 17, NULL, '17', 'Opus 312 : 17', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8356c50-700e-4867-bf5a-453fa3edec16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = '18', part.name_en = 'Opus 312 : 18',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:184f29bc-997e-46a3-9ef8-fc485fa7c97e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:184f29bc-997e-46a3-9ef8-fc485fa7c97e', 18, NULL, '18', 'Opus 312 : 18', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:184f29bc-997e-46a3-9ef8-fc485fa7c97e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = '19', part.name_en = 'Opus 312 : 19',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:7e4393ac-ddbd-42df-b6a8-787e5aa53d29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e4393ac-ddbd-42df-b6a8-787e5aa53d29', 19, NULL, '19', 'Opus 312 : 19', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e4393ac-ddbd-42df-b6a8-787e5aa53d29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = '20', part.name_en = 'Opus 312 : 20',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:4f82554a-077b-4d45-a43d-d056dfd6b1a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f82554a-077b-4d45-a43d-d056dfd6b1a0', 20, NULL, '20', 'Opus 312 : 20', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f82554a-077b-4d45-a43d-d056dfd6b1a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = '21', part.name_en = 'Opus 312 : 21',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:e51c3c14-1292-4dcc-a856-5017339ee96e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e51c3c14-1292-4dcc-a856-5017339ee96e', 21, NULL, '21', 'Opus 312 : 21', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e51c3c14-1292-4dcc-a856-5017339ee96e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = '22', part.name_en = 'Opus 312 : 22',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:07ef3b19-652d-4d8c-819a-2402cec897c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07ef3b19-652d-4d8c-819a-2402cec897c2', 22, NULL, '22', 'Opus 312 : 22', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07ef3b19-652d-4d8c-819a-2402cec897c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = '23', part.name_en = 'Opus 312 : 23',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:4291329f-ce3e-46e4-ab2d-5e874b85ef3b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4291329f-ce3e-46e4-ab2d-5e874b85ef3b', 23, NULL, '23', 'Opus 312 : 23', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4291329f-ce3e-46e4-ab2d-5e874b85ef3b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = '24', part.name_en = 'Opus 312 : 24',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:5eab5e2f-2684-4c51-ac43-602e72201773' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5eab5e2f-2684-4c51-ac43-602e72201773', 24, NULL, '24', 'Opus 312 : 24', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5eab5e2f-2684-4c51-ac43-602e72201773'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = '25', part.name_en = 'Opus 312 : 25',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:0f1dd2c9-d94b-45fd-88ea-600e1fe5ebc6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f1dd2c9-d94b-45fd-88ea-600e1fe5ebc6', 25, NULL, '25', 'Opus 312 : 25', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f1dd2c9-d94b-45fd-88ea-600e1fe5ebc6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = '26', part.name_en = 'Opus 312 : 26',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:db5440ac-99f2-4ac5-8d09-80f091f62c4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db5440ac-99f2-4ac5-8d09-80f091f62c4c', 26, NULL, '26', 'Opus 312 : 26', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db5440ac-99f2-4ac5-8d09-80f091f62c4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = '27', part.name_en = 'Opus 312 : 27',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:32ced382-4a49-43f3-b8fa-68633d85de84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32ced382-4a49-43f3-b8fa-68633d85de84', 27, NULL, '27', 'Opus 312 : 27', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32ced382-4a49-43f3-b8fa-68633d85de84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = '28', part.name_en = 'Opus 312 : 28',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:46b4d90e-6965-431a-b50d-32df17c8707c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46b4d90e-6965-431a-b50d-32df17c8707c', 28, NULL, '28', 'Opus 312 : 28', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46b4d90e-6965-431a-b50d-32df17c8707c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = '29', part.name_en = 'Opus 312 : 29',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:d29ffd40-2270-48dd-91ab-5f060e97a4f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d29ffd40-2270-48dd-91ab-5f060e97a4f2', 29, NULL, '29', 'Opus 312 : 29', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d29ffd40-2270-48dd-91ab-5f060e97a4f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = '30', part.name_en = 'Opus 312 : 30',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:e4b30a39-82c5-428e-9d71-cb06ebea4368' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4b30a39-82c5-428e-9d71-cb06ebea4368', 30, NULL, '30', 'Opus 312 : 30', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4b30a39-82c5-428e-9d71-cb06ebea4368'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = '31', part.name_en = 'Opus 312 : 31',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:0cebdeb6-242b-4734-acdb-968e86bfeb63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0cebdeb6-242b-4734-acdb-968e86bfeb63', 31, NULL, '31', 'Opus 312 : 31', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cebdeb6-242b-4734-acdb-968e86bfeb63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = '32', part.name_en = 'Opus 312 : 32',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19487 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:87d1f6c1-ec1e-4d62-8265-e461ea21e1ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87d1f6c1-ec1e-4d62-8265-e461ea21e1ed', 32, NULL, '32', 'Opus 312 : 32', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19487 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87d1f6c1-ec1e-4d62-8265-e461ea21e1ed'
);


-- None Opus 318

UPDATE pieces piece
SET piece.title = 'Opus 318', piece.title_en = 'Opus 318',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18568 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opus 319

UPDATE pieces piece
SET piece.title = 'Opus 319', piece.title_en = 'Opus 319',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19420 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opus 320

UPDATE pieces piece
SET piece.title = 'Opus 320', piece.title_en = 'Opus 320',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18296 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opus 321

UPDATE pieces piece
SET piece.title = 'Opus 321', piece.title_en = 'Opus 321',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17676 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opus 322

UPDATE pieces piece
SET piece.title = 'Opus 322', piece.title_en = 'Opus 322',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18196 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opus 410

UPDATE pieces piece
SET piece.title = 'Opus 410', piece.title_en = 'Opus 410',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16725 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'A', part.name_en = 'Opus 410 : A',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16725 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:5eb445a8-c08d-42f4-937e-2f4fd6d584de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5eb445a8-c08d-42f4-937e-2f4fd6d584de', 1, NULL, 'A', 'Opus 410 : A', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16725 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5eb445a8-c08d-42f4-937e-2f4fd6d584de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'B', part.name_en = 'Opus 410 : B',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16725 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:61ff0275-9b2e-47d8-b72a-3c1f2d4de4c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61ff0275-9b2e-47d8-b72a-3c1f2d4de4c3', 2, NULL, 'B', 'Opus 410 : B', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16725 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61ff0275-9b2e-47d8-b72a-3c1f2d4de4c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'C', part.name_en = 'Opus 410 : C',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16725 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:ce8e56f0-8a7a-4121-9a9c-a75c655c0a29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce8e56f0-8a7a-4121-9a9c-a75c655c0a29', 3, NULL, 'C', 'Opus 410 : C', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16725 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce8e56f0-8a7a-4121-9a9c-a75c655c0a29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'D', part.name_en = 'Opus 410 : D',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16725 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:383e2888-4bcb-48fa-99e9-386f29ee772e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:383e2888-4bcb-48fa-99e9-386f29ee772e', 4, NULL, 'D', 'Opus 410 : D', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16725 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:383e2888-4bcb-48fa-99e9-386f29ee772e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Opus 420 : I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16725 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:90564979-13a0-4bc3-b8ee-ab90f41d6a03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90564979-13a0-4bc3-b8ee-ab90f41d6a03', 5, NULL, 'I', 'Opus 420 : I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16725 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90564979-13a0-4bc3-b8ee-ab90f41d6a03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Opus 420 : II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16725 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:3c3a6e3f-e4a6-4c81-b5a2-f199e86742d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c3a6e3f-e4a6-4c81-b5a2-f199e86742d3', 6, NULL, 'II', 'Opus 420 : II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16725 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c3a6e3f-e4a6-4c81-b5a2-f199e86742d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Opus 420 : III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16725 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:50240975-5688-4e34-a021-c89b02f30a1b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50240975-5688-4e34-a021-c89b02f30a1b', 7, NULL, 'III', 'Opus 420 : III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16725 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50240975-5688-4e34-a021-c89b02f30a1b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Opus 420 : IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16725 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:2b801174-8431-4028-908d-ee3946dc3b87' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b801174-8431-4028-908d-ee3946dc3b87', 8, NULL, 'IV', 'Opus 420 : IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16725 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b801174-8431-4028-908d-ee3946dc3b87'
);


-- None Opus 427

UPDATE pieces piece
SET piece.title = 'Opus 427', piece.title_en = 'Opus 427',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19085 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '1', part.name_en = 'Opus 427 : 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19085 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:83465dbe-2952-4127-a767-3a62bd55f976' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83465dbe-2952-4127-a767-3a62bd55f976', 1, NULL, '1', 'Opus 427 : 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19085 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83465dbe-2952-4127-a767-3a62bd55f976'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '2', part.name_en = 'Opus 427 : 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19085 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:f8074e5b-9f36-49d5-9dc4-1bc40a438b59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8074e5b-9f36-49d5-9dc4-1bc40a438b59', 2, NULL, '2', 'Opus 427 : 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19085 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8074e5b-9f36-49d5-9dc4-1bc40a438b59'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '3', part.name_en = 'Opus 427 : 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19085 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:0bfb1221-5381-4cd7-81f7-1584b3ea59e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bfb1221-5381-4cd7-81f7-1584b3ea59e0', 3, NULL, '3', 'Opus 427 : 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19085 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bfb1221-5381-4cd7-81f7-1584b3ea59e0'
);


-- None Opus 504 ter

UPDATE pieces piece
SET piece.title = 'Opus 504 ter', piece.title_en = 'Opus 504 ter',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18753 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Opus 504 ter : I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18753 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:a7601441-eb04-4a72-9b4e-b04d01113b25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7601441-eb04-4a72-9b4e-b04d01113b25', 1, NULL, 'I', 'Opus 504 ter : I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18753 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7601441-eb04-4a72-9b4e-b04d01113b25'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Opus 504 ter : II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18753 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:2485c283-059b-49bd-a448-2c629028b6e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2485c283-059b-49bd-a448-2c629028b6e1', 2, NULL, 'II', 'Opus 504 ter : II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18753 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2485c283-059b-49bd-a448-2c629028b6e1'
);


-- None Opus 520

UPDATE pieces piece
SET piece.title = 'Opus 520', piece.title_en = 'Opus 520',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19429 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Opus 520 : I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19429 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:fb189cdb-add6-42a3-beea-477badddbb30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb189cdb-add6-42a3-beea-477badddbb30', 1, NULL, 'I', 'Opus 520 : I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19429 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb189cdb-add6-42a3-beea-477badddbb30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Opus 520 : II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19429 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:1368b28d-853c-4091-a289-b44909667821' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1368b28d-853c-4091-a289-b44909667821', 2, NULL, 'II', 'Opus 520 : II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19429 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1368b28d-853c-4091-a289-b44909667821'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Opus 520 : III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19429 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:2b41030b-2db2-4da8-80ec-a46665101076' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b41030b-2db2-4da8-80ec-a46665101076', 3, NULL, 'III', 'Opus 520 : III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19429 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b41030b-2db2-4da8-80ec-a46665101076'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Opus 520 : IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19429 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:c2e80631-9364-4f11-bccb-aa8ad70dd8b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2e80631-9364-4f11-bccb-aa8ad70dd8b3', 4, NULL, 'IV', 'Opus 520 : IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19429 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2e80631-9364-4f11-bccb-aa8ad70dd8b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'V', part.name_en = 'Opus 520 : V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19429 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:82a9ca17-1a60-4373-9803-8fb59b29c7d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82a9ca17-1a60-4373-9803-8fb59b29c7d6', 5, NULL, 'V', 'Opus 520 : V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19429 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82a9ca17-1a60-4373-9803-8fb59b29c7d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'VI', part.name_en = 'Opus 520 : VI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19429 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:b2de8297-997c-45bd-9e78-cbb25bf77998' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2de8297-997c-45bd-9e78-cbb25bf77998', 6, NULL, 'VI', 'Opus 520 : VI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19429 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2de8297-997c-45bd-9e78-cbb25bf77998'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'VII', part.name_en = 'Opus 520 : VII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19429 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:079634fb-8759-4b5f-8f5e-df2060b0530a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:079634fb-8759-4b5f-8f5e-df2060b0530a', 7, NULL, 'VII', 'Opus 520 : VII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19429 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:079634fb-8759-4b5f-8f5e-df2060b0530a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'VIII', part.name_en = 'Opus 520 : VIII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19429 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:3bf9a5bb-9c99-4280-a8cd-09d3a7fee7d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bf9a5bb-9c99-4280-a8cd-09d3a7fee7d5', 8, NULL, 'VIII', 'Opus 520 : VIII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19429 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bf9a5bb-9c99-4280-a8cd-09d3a7fee7d5'
);


-- None Opus 546

UPDATE pieces piece
SET piece.title = 'Opus 546', piece.title_en = 'Opus 546',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18999 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Première section', part.name_en = 'Opus 546 : Première section',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18999 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:392b49ee-92bb-4a98-bc61-b511454a2aa7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:392b49ee-92bb-4a98-bc61-b511454a2aa7', 1, NULL, 'Première section', 'Opus 546 : Première section', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18999 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:392b49ee-92bb-4a98-bc61-b511454a2aa7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Deuxième section', part.name_en = 'Opus 546 : Deuxième section',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18999 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:fe04f8dc-0fe5-403a-91a5-f5afcaf77c96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe04f8dc-0fe5-403a-91a5-f5afcaf77c96', 2, NULL, 'Deuxième section', 'Opus 546 : Deuxième section', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18999 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe04f8dc-0fe5-403a-91a5-f5afcaf77c96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Troisième section', part.name_en = 'Opus 546 : Troisième section',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18999 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:8f58f993-1e26-4384-a6d4-3351841be7e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f58f993-1e26-4384-a6d4-3351841be7e7', 3, NULL, 'Troisième section', 'Opus 546 : Troisième section', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18999 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f58f993-1e26-4384-a6d4-3351841be7e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Quatrième section', part.name_en = 'Opus 546 : Quatrième section',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18999 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:193acdef-b7f0-46de-a2b4-59b26ad9440a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:193acdef-b7f0-46de-a2b4-59b26ad9440a', 4, NULL, 'Quatrième section', 'Opus 546 : Quatrième section', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18999 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:193acdef-b7f0-46de-a2b4-59b26ad9440a'
);


-- Op. 277 Organ Sonata 10

UPDATE pieces piece
SET piece.title = 'Organ Sonata 10', piece.title_en = 'Organ Sonata 10, op. 277',
    piece.type = 'song', piece.opus_number = 'Op. 277',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17973 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 205 Piano Sonata 10

UPDATE pieces piece
SET piece.title = 'Piano Sonata 10', piece.title_en = 'Piano Sonata 10, op. 205',
    piece.type = 'song', piece.opus_number = 'Op. 205',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19852 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 224 Piano Sonata 15

UPDATE pieces piece
SET piece.title = 'Piano Sonata 15', piece.title_en = 'Piano Sonata 15, op. 224',
    piece.type = 'song', piece.opus_number = 'Op. 224',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19726 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 204 Piano Sonata 9

UPDATE pieces piece
SET piece.title = 'Piano Sonata 9', piece.title_en = 'Piano Sonata 9, op. 204',
    piece.type = 'song', piece.opus_number = 'Op. 204',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17408 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 195 Requiem Antiphons

UPDATE pieces piece
SET piece.title = 'Requiem Antiphons', piece.title_en = 'Requiem Antiphons, op. 195',
    piece.type = 'album', piece.opus_number = 'Op. 195',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16541 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Requiem Antiphons, op. 195: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16541 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:6a6378d5-f8a0-4241-958e-91a58b5c6999' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a6378d5-f8a0-4241-958e-91a58b5c6999', 1, NULL, 'I', 'Requiem Antiphons, op. 195: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16541 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a6378d5-f8a0-4241-958e-91a58b5c6999'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Requiem Antiphons, op. 195: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16541 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:85d16dbc-d407-4803-a154-6d876fa80afa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85d16dbc-d407-4803-a154-6d876fa80afa', 2, NULL, 'II', 'Requiem Antiphons, op. 195: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16541 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85d16dbc-d407-4803-a154-6d876fa80afa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Requiem Antiphons, op. 195: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16541 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:8049fc53-0c73-46aa-956b-c6adcd1775d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8049fc53-0c73-46aa-956b-c6adcd1775d2', 3, NULL, 'III', 'Requiem Antiphons, op. 195: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16541 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8049fc53-0c73-46aa-956b-c6adcd1775d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Requiem Antiphons, op. 195: IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16541 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:ef0288e2-8223-4f72-8ba9-4e41ee4aa72a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef0288e2-8223-4f72-8ba9-4e41ee4aa72a', 4, NULL, 'IV', 'Requiem Antiphons, op. 195: IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16541 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef0288e2-8223-4f72-8ba9-4e41ee4aa72a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'V', part.name_en = 'Requiem Antiphons, op. 195: V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16541 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:f9152bd1-12e5-44e6-983b-487f22cd3e1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9152bd1-12e5-44e6-983b-487f22cd3e1e', 5, NULL, 'V', 'Requiem Antiphons, op. 195: V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16541 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9152bd1-12e5-44e6-983b-487f22cd3e1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'VI', part.name_en = 'Requiem Antiphons, op. 195: VI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16541 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:2e488b42-3996-4ef7-862f-9efcb86627db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e488b42-3996-4ef7-862f-9efcb86627db', 6, NULL, 'VI', 'Requiem Antiphons, op. 195: VI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16541 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e488b42-3996-4ef7-862f-9efcb86627db'
);


-- Op. 573 레퀴엠 Op. 573

UPDATE pieces piece
SET piece.title = '레퀴엠 Op. 573', piece.title_en = 'Requiem, op. 573',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '573',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16287 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Requiem aeternam', part.name_en = 'Requiem, op. 573: Requiem aeternam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16287 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:368037ba-7d48-4fd7-ba22-b0a0da249b12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:368037ba-7d48-4fd7-ba22-b0a0da249b12', 1, NULL, 'Requiem aeternam', 'Requiem, op. 573: Requiem aeternam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16287 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:368037ba-7d48-4fd7-ba22-b0a0da249b12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Offertorium', part.name_en = 'Requiem, op. 573: Offertorium',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16287 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:97ed423c-3642-46be-9c61-5e9594ad09b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97ed423c-3642-46be-9c61-5e9594ad09b0', 2, NULL, 'Offertorium', 'Requiem, op. 573: Offertorium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16287 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97ed423c-3642-46be-9c61-5e9594ad09b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sanctus', part.name_en = 'Requiem, op. 573: Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16287 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:4fcec691-60c4-4791-a359-47dbaba3d237' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fcec691-60c4-4791-a359-47dbaba3d237', 3, NULL, 'Sanctus', 'Requiem, op. 573: Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16287 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fcec691-60c4-4791-a359-47dbaba3d237'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Agnus Dei', part.name_en = 'Requiem, op. 573: Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16287 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:139a4f25-62aa-4582-922d-7edae843589f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:139a4f25-62aa-4582-922d-7edae843589f', 4, NULL, 'Agnus Dei', 'Requiem, op. 573: Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16287 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:139a4f25-62aa-4582-922d-7edae843589f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Lux aeterna', part.name_en = 'Requiem, op. 573: Lux aeterna',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16287 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:bbc22b6f-cdea-46bf-bee5-ad4cd2732b7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbc22b6f-cdea-46bf-bee5-ad4cd2732b7a', 5, NULL, 'Lux aeterna', 'Requiem, op. 573: Lux aeterna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16287 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbc22b6f-cdea-46bf-bee5-ad4cd2732b7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Libera me', part.name_en = 'Requiem, op. 573: Libera me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16287 AND p.composer_id = 190 AND part.part_key = 'musicbrainz:6b303005-25b9-4659-ab0e-7d4b54be6c8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b303005-25b9-4659-ab0e-7d4b54be6c8b', 6, NULL, 'Libera me', 'Requiem, op. 573: Libera me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16287 AND p.composer_id = 190
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b303005-25b9-4659-ab0e-7d4b54be6c8b'
);


-- Op. 445 클라리넷과 피아노를 위한 소나타 3번

UPDATE pieces piece
SET piece.title = '클라리넷과 피아노를 위한 소나타 3번', piece.title_en = 'Sonata for Clarinet and Piano no. 3, op. 445',
    piece.type = 'song', piece.opus_number = 'Op. 445',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17269 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 301 플루트와 피아노를 위한 소나타 7번

UPDATE pieces piece
SET piece.title = '플루트와 피아노를 위한 소나타 7번', piece.title_en = 'Sonata for Flute and Piano no. 7, op. 301',
    piece.type = 'song', piece.opus_number = 'Op. 301',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17704 AND piece.composer_id = 190
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opus 145

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Opus 145', 'Opus 145', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 190
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Opus 145'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ccfdbfef-30b7-4ee8-84a0-89b85c2e2cd8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ccfdbfef-30b7-4ee8-84a0-89b85c2e2cd8'
FROM pieces p
WHERE p.composer_id = 190 AND p.title = 'Opus 145' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ccfdbfef-30b7-4ee8-84a0-89b85c2e2cd8'
);


-- 숨길 seed 작품 없음
